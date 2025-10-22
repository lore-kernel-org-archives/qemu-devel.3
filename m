Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A41CCD1BE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 06:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBSn6-0001Cu-K4; Wed, 22 Oct 2025 02:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSn4-00017a-Rk
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:57:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSn3-00086N-37
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761116264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nGMm2WNlAwuqkjgPVmmBw8DnVNZofzxhoHILFvByxx8=;
 b=VvK5o/wf/VXEwymg0m/NutcrR4V30ahPKjVQacrqGL6RJ8onmks8PgbX1g1Nb0QWROM+C2
 fhfrr05yHkEt7JA+hB+wWQ12r4evC2mDA8DMZ9Nacxf657NsTPmR3XAJxr3ypxBmFjzfdM
 wetVbZDfgUrkgY2XnHmoUqA5v+hbbFo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-Iv6VYl_cMiGuafVjEsYzzA-1; Wed,
 22 Oct 2025 02:57:41 -0400
X-MC-Unique: Iv6VYl_cMiGuafVjEsYzzA-1
X-Mimecast-MFC-AGG-ID: Iv6VYl_cMiGuafVjEsYzzA_1761116260
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2547195422D; Wed, 22 Oct 2025 06:57:40 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B3AA21956056; Wed, 22 Oct 2025 06:57:39 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 10/42] audio: rename audio_define->audio_add_audiodev()
Date: Wed, 22 Oct 2025 10:56:05 +0400
Message-ID: <20251022065640.1172785-11-marcandre.lureau@redhat.com>
In-Reply-To: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
References: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

For readability.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 audio/audio.h | 4 ++--
 audio/audio.c | 8 ++++----
 system/vl.c   | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index fcc22307be..eb5b5d662d 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -168,8 +168,8 @@ void audio_sample_to_uint64(const void *samples, int pos,
 void audio_sample_from_uint64(void *samples, int pos,
                             uint64_t left, uint64_t right);
 
-void audio_define(Audiodev *audio);
-void audio_define_default(Audiodev *dev, Error **errp);
+void audio_add_audiodev(Audiodev *audio);
+void audio_add_default_audiodev(Audiodev *dev, Error **errp);
 void audio_parse_option(const char *opt);
 void audio_create_default_audiodevs(void);
 void audio_init_audiodevs(void);
diff --git a/audio/audio.c b/audio/audio.c
index 89f091bc88..6197fa1788 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1712,7 +1712,7 @@ void audio_create_default_audiodevs(void)
             visit_type_Audiodev(v, NULL, &dev, &error_fatal);
             visit_free(v);
 
-            audio_define_default(dev, &error_abort);
+            audio_add_default_audiodev(dev, &error_abort);
         }
     }
 }
@@ -2142,10 +2142,10 @@ void audio_parse_option(const char *opt)
     visit_type_Audiodev(v, NULL, &dev, &error_fatal);
     visit_free(v);
 
-    audio_define(dev);
+    audio_add_audiodev(dev);
 }
 
-void audio_define(Audiodev *dev)
+void audio_add_audiodev(Audiodev *dev)
 {
     AudiodevListEntry *e;
 
@@ -2156,7 +2156,7 @@ void audio_define(Audiodev *dev)
     QSIMPLEQ_INSERT_TAIL(&audiodevs, e, next);
 }
 
-void audio_define_default(Audiodev *dev, Error **errp)
+void audio_add_default_audiodev(Audiodev *dev, Error **errp)
 {
     AudiodevListEntry *e;
 
diff --git a/system/vl.c b/system/vl.c
index d20a9cbe08..7187b24449 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2264,7 +2264,7 @@ static void qemu_record_config_group(const char *group, QDict *dict,
         Audiodev *dev = NULL;
         Visitor *v = qobject_input_visitor_new_keyval(QOBJECT(dict));
         if (visit_type_Audiodev(v, NULL, &dev, errp)) {
-            audio_define(dev);
+            audio_add_audiodev(dev);
         }
         visit_free(v);
 
@@ -3086,11 +3086,11 @@ void qemu_init(int argc, char **argv)
                 visit_type_Audiodev(v, NULL, &dev, &error_fatal);
                 visit_free(v);
                 if (model) {
-                    audio_define(dev);
+                    audio_add_audiodev(dev);
                     select_soundhw(model, dev->id);
                     g_free(model);
                 } else {
-                    audio_define_default(dev, &error_fatal);
+                    audio_add_default_audiodev(dev, &error_fatal);
                 }
                 break;
             }
-- 
2.51.0


