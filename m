Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E7FC61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2ThB-0004RC-SP; Fri, 04 Sep 2026 09:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2ThA-0004Qz-NX
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:11:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Th8-00055j-PP
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788527461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AVAHgQbM/aPiivdzsKn8yGeaKqOnfruJK8/C1MWLsWc=;
 b=VygB1cWUhUx0s74FB4AqpjGhrmxQRsdlUjtqEa7rXBruZKeLIiybTqQm+pgcN6Mih9dGyr
 dMKg6OKJjPCdcHjyeuvw8pV/sxYocdPBxoag2Z2Si1f+3eVFOH7O61bXFBcBN3RRuNJ8kH
 mgo/U0+6Mk2uAOGb5bJpchtzDPLFbjQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-ywnLlXUtMbWQzjCiHyquaQ-1; Fri,
 04 Sep 2026 09:10:57 -0400
X-MC-Unique: ywnLlXUtMbWQzjCiHyquaQ-1
X-Mimecast-MFC-AGG-ID: ywnLlXUtMbWQzjCiHyquaQ_1788527456
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F09D718417EC; Fri,  4 Sep 2026 13:10:55 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 161505BC; Fri,  4 Sep 2026 13:10:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 17:10:14 +0400
Subject: [PATCH v2 10/25] ui/console: disable GL scanout when dmabuf is the
 active one
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-virtio-gpu-cleanup-v2-10-15b5ae6b0023@redhat.com>
References: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
In-Reply-To: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=993;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=U5tu1RWLhciHqx779/J6PMsZlOhqAA0BFItvJyOfq/k=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmsMvMfzYCHhRtZcb5RvG0me54nAWeTcl6nKqf
 923oOBuL4mJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaprDLwAKCRDa6OEJdZac
 5axND/oDULv1AGPnlQc7hH/qVJDyqAMf6WIncd0kvP2kuQxphzeupB+r2MYqdxtv/wZ6NRqp48e
 e4vTn3p7fYhLCm+EEDAEf77KchwSES6itDOL+Ofy4+hau01p6Vu+U7HQ7tZ0Q5X8e2nMNNLi4tT
 GiETc0KQB/394Ec0IGzZCGJgLYxz/iiTUbLtuhAklLPgFWEq5euTxMe0aC0aX35RFqJAtqNlFFL
 1sL0ezia9KNeJnU8I6ID023TmtA474mMMT5ZchHxZ+PU5pH2GgFlo80G0N0lvouKTVkBe+hVzG2
 HyKE3xVDkZRj0DmH3+bikE/yyoXE/Gh/rMTdU/VVrMpj2X+n+FfZ65sRAgYKuW3njQK4dVnUcYP
 YjlekIxGurIrokGuuqbPzYhhAE6FL4+S9ae2AG9cT094Q1hQPjJhUckaZ2tRFfS/cHloxmD9acS
 vjsNnoQ1KJg2Z6kYkum/1L1nTbkKP8dGWqK/UjdzPC4pEuUygXor9VAaL2w2p5fMiOl27I+Lm77
 /sSBJMzcWfbq3SAHVDZSw0KoOSG5wgNe7JyDYfvS29/2dTDL5okqWXp+/I5VvhPydB9UBf1nUyQ
 +kJcq9esD+oo8C418sFEtbLas1+Vv9TKuCUbMnLTqNaY0E7xsdEg5/tZQUSh4l/uA/1bC4SE9Yp
 FDv59fJ/mhdDkYQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


