Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44127D72347
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 07:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjC0V-0000AW-Ab; Fri, 23 Jan 2026 02:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vjBzF-0007JG-Dw
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 02:53:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vjBzD-0002V8-Vf
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 02:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769154823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZHladij5m9AKNnQu/b0L46HMbjjBJluO4f1jnLDM164=;
 b=a5glhxMcrAWjOxvgu2tLZdo5yQojNgsIiO2RHaRPehpnBVCGRDG7WnK4T/aCbCDhO1X01O
 eTswJPFLUSftlxk2MtwNQLsKyqXzh3ZHVxLtuDFl62XFOsNKc3OW5DiW8YusCRLioJVla5
 ELBmTDAt3qAJrBYq5S16hloilKvkhDY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-ggG9WeNmOoy9KmDCwENCPA-1; Fri,
 23 Jan 2026 02:53:41 -0500
X-MC-Unique: ggG9WeNmOoy9KmDCwENCPA-1
X-Mimecast-MFC-AGG-ID: ggG9WeNmOoy9KmDCwENCPA_1769154821
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9DEE1955D84; Fri, 23 Jan 2026 07:53:40 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6105330002D1; Fri, 23 Jan 2026 07:53:38 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 37/37] audio: make audio_driver init() & fini() optional
Date: Fri, 23 Jan 2026 11:49:40 +0400
Message-ID: <20260123074945.2563196-38-marcandre.lureau@redhat.com>
In-Reply-To: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The next patches are going to remove usage of the driver callbacks in
favor of QOM realize/finalize.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio-mixeng-be.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
index 8ebceb968ce..2c9c2af87a0 100644
--- a/audio/audio-mixeng-be.c
+++ b/audio/audio-mixeng-be.c
@@ -1520,9 +1520,11 @@ static bool audio_mixeng_backend_realize(AudioBackend *abe,
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
@@ -1663,7 +1665,9 @@ static void audio_mixeng_backend_finalize(Object *obj)
     }
 
     if (s->drv) {
-        s->drv->fini (s->drv_opaque);
+        if (s->drv->fini) {
+            s->drv->fini (s->drv_opaque);
+        }
         s->drv = NULL;
     }
 
-- 
2.52.0


