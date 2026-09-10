Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FC9C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4ZzR-0003Qi-E1; Thu, 10 Sep 2026 04:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4ZzP-0003OK-5f
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:18:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4ZzN-0004uW-QO
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789028313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ab79tc0wP1jslXYpwrccZQdhGgSRbeaIJ1DfJSrtXZY=;
 b=AKqbOKzpdN27o/z73kd3QEhznkX9DpIEPjKvCgXVEVjgtvA+u5Vz9jStmXK3u02++ViWmz
 7zy7l4SpHh/s0VmUJ+hev8wjWkKb9l4WqYZXUeX761SqPng42kvY6M4FlJ42u2FxPmwUky
 igUIIvb51fHcQXoprynas2bFxF5nxgY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-YENPm2ENMFSmMW2xcTUQCA-1; Thu,
 10 Sep 2026 04:18:29 -0400
X-MC-Unique: YENPm2ENMFSmMW2xcTUQCA-1
X-Mimecast-MFC-AGG-ID: YENPm2ENMFSmMW2xcTUQCA_1789028308
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 879DA1954213; Thu, 10 Sep 2026 08:18:28 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 07C50180049F; Thu, 10 Sep 2026 08:18:26 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 12:17:38 +0400
Subject: [PATCH v4 10/24] ui/console: disable GL scanout when dmabuf is the
 active one
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v4-10-7d623714bd71@redhat.com>
References: <20260910-virtio-gpu-cleanup-v4-0-7d623714bd71@redhat.com>
In-Reply-To: <20260910-virtio-gpu-cleanup-v4-0-7d623714bd71@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqomeotwTamMPYRRXwZO/jb/uRK05lHMjdvrdUr
 grSqB/lCwWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqJnqAAKCRDa6OEJdZac
 5R9aD/9Fmmin1SEIWj8CxuIyunyVEI3Z1Kfhd2cYBhIeNPzhVbDiQ3JfeIu7U3oYWc4XO/93fTG
 SqZ5vBSRuBvhTwsduqsfRziku8mu0jrNO+o3t/HKoE9OJkDmYApfR9v6ReU1Mv/ZedTFoDv74FS
 ORVDD0Tvh4LpiZd6ThFuzTVkVx5dYr/qMp5E5AUaUs3zNyQ2j4UnRZMIX+ALJZYxQmyhV3rr0Hz
 dve+JJHXV2QUUHQrDh1ubZP7JRqhwB99vhBodjyjA9kPQBcBbodKHerlA64G1gypDMj5D1RmlGf
 s2sZ61tNmPva7XZJKh2DcGlRb6mWrhr5WDr1qOGg5d8zGuyiH5dKRMLER6O0WBXTewcO2xB1vMN
 WFW5y7ultOarr6VNoz0Pull5od/eTrEKu7lNP1TsEYvdlr1Hi7kKVs6H2TkfC8eyMPlpDG6KGIf
 6vZ2dWIOtWdocOQNTAVwuFcZYVRFXGnZaoOu6DrLkmwdT5+cMFeJAmNZ52rSf/ZsGy+HAVl8gDD
 c6xbbtaPBTcVrDA5QVMReV32qCX6GGamthLwJsK6If074uXSDVy6d1ftTP8tHq8Q1r2BsO8iicJ
 mDAWj2INBRlsIPe/yNjC0sMp8Dcni9TrwZHWxnjUri02+VVNAhTGvv79qIt5IOCJ56V+CHp373V
 VJ4E6x52210QavA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


