Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409C1EA4FC2
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 13:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuWJM-00029C-Sk; Mon, 23 Feb 2026 08:49:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWIh-0000f7-5l
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:48:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWIb-00073U-Lb
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771854512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bmLE4PI4NiS4bmYyzdcYckwaqWftpyyj3Q24H/oUE1E=;
 b=WYlZZtGxmbRPxrbtdTWMzFEE/yOmqGVtmV25eCFkCBpSlJ7J/j+xnXzXgDuT+pm1DDjxj+
 mqhzyYWLOAJsD6Fjlp6Ev/AftENEUFLwqqoBB5obAtZdkvMMNSqvSC0mLa5AwKq4tIFZsW
 oOOXKQAvhJA78dcqssyZbbpKmBv/8Wo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-M7PI0Nz7PpytdP8CNbjpkQ-1; Mon,
 23 Feb 2026 08:48:31 -0500
X-MC-Unique: M7PI0Nz7PpytdP8CNbjpkQ-1
X-Mimecast-MFC-AGG-ID: M7PI0Nz7PpytdP8CNbjpkQ_1771854510
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EAAD18005B7; Mon, 23 Feb 2026 13:48:30 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8ED7519560B4; Mon, 23 Feb 2026 13:48:29 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v3 21/85] audio: use DEFINE_TYPES
Date: Mon, 23 Feb 2026 14:46:22 +0100
Message-ID: <20260223134731.2377432-22-marcandre.lureau@redhat.com>
In-Reply-To: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
References: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
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

It's the "modern" way of registring the object TypeInfo.

Suggested-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 75a7f694319..c4e4adec106 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -2366,30 +2366,25 @@ AudiodevList *qmp_query_audiodevs(Error **errp)
     return ret;
 }
 
-static const TypeInfo audio_be_info = {
-    .name = TYPE_AUDIO_BACKEND,
-    .parent = TYPE_OBJECT,
-    .instance_size = sizeof(AudioBackend),
-    .instance_init = audio_be_init,
-    .instance_finalize = audio_be_finalize,
-    .abstract = true,
-    .class_size = sizeof(AudioBackendClass),
-};
-
-static const TypeInfo audio_mixeng_backend_info = {
-    .name = TYPE_AUDIO_MIXENG_BACKEND,
-    .parent = TYPE_AUDIO_BACKEND,
-    .instance_size = sizeof(AudioMixengBackend),
-    .instance_init = audio_mixeng_backend_init,
-    .instance_finalize = audio_mixeng_backend_finalize,
-    .class_size = sizeof(AudioMixengBackendClass),
-    .class_init = audio_mixeng_backend_class_init,
+static const TypeInfo audio_types[] = {
+    {
+        .name = TYPE_AUDIO_BACKEND,
+        .parent = TYPE_OBJECT,
+        .instance_size = sizeof(AudioBackend),
+        .instance_init = audio_be_init,
+        .instance_finalize = audio_be_finalize,
+        .abstract = true,
+        .class_size = sizeof(AudioBackendClass),
+    },
+    {
+        .name = TYPE_AUDIO_MIXENG_BACKEND,
+        .parent = TYPE_AUDIO_BACKEND,
+        .instance_size = sizeof(AudioMixengBackend),
+        .instance_init = audio_mixeng_backend_init,
+        .instance_finalize = audio_mixeng_backend_finalize,
+        .class_size = sizeof(AudioMixengBackendClass),
+        .class_init = audio_mixeng_backend_class_init,
+    }
 };
 
-static void register_types(void)
-{
-    type_register_static(&audio_be_info);
-    type_register_static(&audio_mixeng_backend_info);
-}
-
-type_init(register_types);
+DEFINE_TYPES(audio_types)
-- 
2.53.0


