Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB14E9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsdVD-00067H-3b; Wed, 18 Feb 2026 04:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdVB-0005yX-7f
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:05:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdV9-0000lq-Cg
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771405542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ss9oHxzNE9nQ9jCG/M5jycsST569jt37+/YoOvR3kZY=;
 b=UjnWPlSV/boXWqDiyvODzmaG+1FXD97sUlI9rf4MM6AvqsaQM+9ZxZkB+08+gQSJPqvjpI
 9yDDbZ+QlAcuv7kC24WBk5jROGQumZFRBxIOyj0XmUQ+Ai6I8mpj+b/sc/MWQzDEujae78
 LV8dXwT4Q/uyZFOD5sZtERlLif/H254=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-NwcKr5enMnK04RTVj339SA-1; Wed,
 18 Feb 2026 04:05:39 -0500
X-MC-Unique: NwcKr5enMnK04RTVj339SA-1
X-Mimecast-MFC-AGG-ID: NwcKr5enMnK04RTVj339SA_1771405538
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A8B41954B05; Wed, 18 Feb 2026 09:05:38 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 811FC30001B9; Wed, 18 Feb 2026 09:05:37 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 41/85] audio: make audio_driver init() & fini() optional
Date: Wed, 18 Feb 2026 10:02:41 +0100
Message-ID: <20260218090330.1476169-42-marcandre.lureau@redhat.com>
In-Reply-To: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
References: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The next patches are going to remove usage of the driver callbacks in
favor of QOM realize/finalize.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio-mixeng-be.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
index f906c84bf7c..45873646b3c 100644
--- a/audio/audio-mixeng-be.c
+++ b/audio/audio-mixeng-be.c
@@ -1521,9 +1521,11 @@ static bool audio_mixeng_backend_realize(AudioBackend *abe,
     audio_driver *drv = AUDIO_MIXENG_BACKEND_GET_CLASS(be)->driver;
 
     be->dev = dev;
-    be->drv_opaque = drv->init(be->dev, errp);
-    if (!be->drv_opaque) {
-        return false;
+    if (drv->init != NULL) {
+        be->drv_opaque = drv->init(be->dev, errp);
+        if (!be->drv_opaque) {
+            return false;
+        }
     }
 
     if (!drv->pcm_ops->get_buffer_in) {
@@ -1664,7 +1666,9 @@ static void audio_mixeng_backend_finalize(Object *obj)
     }
 
     if (s->drv) {
-        s->drv->fini (s->drv_opaque);
+        if (s->drv->fini) {
+            s->drv->fini (s->drv_opaque);
+        }
         s->drv = NULL;
     }
 
-- 
2.53.0


