Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C81DC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4G65-0003DI-Mv; Wed, 09 Sep 2026 07:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G64-00033t-E6
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:04:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G63-0005GS-1B
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788951846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ab79tc0wP1jslXYpwrccZQdhGgSRbeaIJ1DfJSrtXZY=;
 b=PSwXp6bEHI2enwGLrzggD7cKi8sXVTyHT+KggaDQclInYUlUPkjlGB6UQbsoJA3VpUbOk5
 OnGIdqV0FJYYaYk5UHXBdcqQ1DKNMhDKyS5Jxj87UZsviCc1g94DANkrWlc2rLRu0b6zk8
 BAsCqjFnlJpsguHQBDYKUaOFzmqttMo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-rUwtFTSLNvGGR4XQ4bubAw-1; Wed,
 09 Sep 2026 07:04:05 -0400
X-MC-Unique: rUwtFTSLNvGGR4XQ4bubAw-1
X-Mimecast-MFC-AGG-ID: rUwtFTSLNvGGR4XQ4bubAw_1788951844
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BA1C1954107; Wed,  9 Sep 2026 11:04:04 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B9321800352; Wed,  9 Sep 2026 11:04:01 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 09 Sep 2026 15:03:15 +0400
Subject: [PATCH v3 10/24] ui/console: disable GL scanout when dmabuf is the
 active one
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-virtio-gpu-cleanup-v3-10-99266590e79d@redhat.com>
References: <20260909-virtio-gpu-cleanup-v3-0-99266590e79d@redhat.com>
In-Reply-To: <20260909-virtio-gpu-cleanup-v3-0-99266590e79d@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1052;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=OQduuPEP/YmWbLpH074hRz03Ee7qLxiHWTT26EkF3go=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoTzyf55LkQFR/HUfY9f1KegvTffLqfyKSLcyK
 8onYXeISPuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqE88gAKCRDa6OEJdZac
 5eMgEACkOpwCTxrRGkDXjiguH4Mgq1IPhe3Djy3kDLzSIxLQEedoPcHfmO0Y1YShXCAavz9OF2E
 VAUe2MVcMVhKVDVsBWr6aJxzJ1jC990R1QUsAeoNcs/Im9tIeHUsZriNNsxre/Y8a2hIKarIquY
 5WfddEC7A2dHz9JoJKtJzp9ZIqxfrfafWVqgYEGLQYWHrS2KmWjRhh2EoWWRfv7HV5NY7XMA56d
 GLxRAPgXYXiOIAHT/MyqwnBmtiqHtt/AS0iEOZcUgHcwM0TLde2CZxnK0eljZAwYs+e6Qlpz024
 KJHQaq8QUt8dBySPJPv8oLggKzn5mZQG30C2uypVl85+Rr+4BFrJvtrvm4JwLRQkiZ+EhDCAI3G
 HkjCzR0lmw5g7OZMtztXoLRKED5kSIxwroSl0qC2JC5dLg9CW4QOF6yp5QgPgHrahifKcATmEPp
 SfltyL2J6urB0iTx7lvecmQ3vjwnjcOygylhpAxsmyLrUdnRvXTUHK+m2vzYIBmV/lFxKcJKKNh
 RXt39mdHJIye9BGdpiuXEjapFvWqeIudagjfME+kjGj1QmaPTCKZcvFFC8AKJKzUaA5y1K5+USS
 LDfc1TRfVCYOXg5W8q604Ko1cJXutlMp6Ha7qekSAJsD1r4sDck584mAdDdY033PtNpIWd9oaPi
 mUihzUYwdbWGvfg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Disable the GL scanout when the actively-displayed dmabuf is released,
so the console does not retain a stale reference.

The VFIO commit changes to call qemu_console_gl_release_dmabuf() before
qemu_graphic_console_close(), which dereferences the active scanout.

Fixes: 239b7c5705a4 ("vfio/pci: close display console during unrealize, not finalize")
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/console.c b/ui/console.c
index a8a2a247d8f4..14f148118e37 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1049,6 +1049,9 @@ void qemu_console_gl_release_dmabuf(QemuConsole *con,
             dcl->ops->dpy_gl_release_dmabuf(dcl, dmabuf);
         }
     }
+    if (con->scanout.kind == SCANOUT_DMABUF && dmabuf == con->scanout.dmabuf) {
+        qemu_console_gl_scanout_disable(con);
+    }
 }
 
 void qemu_console_gl_update(QemuConsole *con,

-- 
2.55.0.543.g5ebe2ebe4ea8


