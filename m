Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDBFD2FED9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknp7-0003yW-Fj; Tue, 27 Jan 2026 13:29:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vknng-0001Q9-96
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:28:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vknnd-0003PL-IS
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:28:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769538505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RMQmS+opm7irL9efzEm3gEPqvkUMjXPW3JX3/rTd+vA=;
 b=Y1oe8qJkiHWIT98GHWfVVq7dT7EGS1nmOkBPvRw7wB9tZ2FSAP8/4S0KAe8W63mXnqVEK7
 q7HRBq8jYg2TclwGie2nnFTZJFPQcWqbaCHMMN6FCfNDNRCzD7yTGcKn8gQ2bKfo7EFFkc
 N5bxG+i59gcu1EWZMKoUVzn6k6eCfNQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-V3AHowQ7OgekKGi69_jwLQ-1; Tue,
 27 Jan 2026 13:28:21 -0500
X-MC-Unique: V3AHowQ7OgekKGi69_jwLQ-1
X-Mimecast-MFC-AGG-ID: V3AHowQ7OgekKGi69_jwLQ_1769538500
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CB7719775E2; Tue, 27 Jan 2026 18:28:20 +0000 (UTC)
Received: from localhost (unknown [10.45.242.23])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B8D041800109; Tue, 27 Jan 2026 18:28:18 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 30/43] audio/wav: replace custom logging with error_report
Date: Tue, 27 Jan 2026 22:24:57 +0400
Message-ID: <20260127182516.289834-31-marcandre.lureau@redhat.com>
In-Reply-To: <20260127182516.289834-1-marcandre.lureau@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Replace the custom audio logging infrastructure (dolog macro) with
standard QEMU error reporting (error_report).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/wavaudio.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 090f3f4dc60..5c614ed3b51 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -24,10 +24,10 @@
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
+#include "qemu/error-report.h"
 #include "qemu/audio.h"
 #include "qom/object.h"
 
-#define AUDIO_CAP "wav"
 #include "audio_int.h"
 
 #define TYPE_AUDIO_WAV "audio-wav"
@@ -51,8 +51,8 @@ static size_t wav_write_out(HWVoiceOut *hw, void *buf, size_t len)
     assert(bytes % hw->info.bytes_per_frame == 0);
 
     if (bytes && fwrite(buf, bytes, 1, wav->f) != 1) {
-        dolog("wav_write_out: fwrite of %" PRId64 " bytes failed\nReason: %s\n",
-              bytes, strerror(errno));
+        error_report("wav: fwrite of %" PRId64 " bytes failed: %s",
+                     bytes, strerror(errno));
     }
 
     wav->total_samples += bytes / hw->info.bytes_per_frame;
@@ -98,11 +98,11 @@ static int wav_init_out(HWVoiceOut *hw, struct audsettings *as)
 
     case AUDIO_FORMAT_S32:
     case AUDIO_FORMAT_U32:
-        dolog ("WAVE files can not handle 32bit formats\n");
+        error_report("wav: WAVE files cannot handle 32-bit formats");
         return -1;
 
     case AUDIO_FORMAT_F32:
-        dolog("WAVE files can not handle float formats\n");
+        error_report("wav: WAVE files cannot handle float formats");
         return -1;
 
     default:
@@ -122,14 +122,13 @@ static int wav_init_out(HWVoiceOut *hw, struct audsettings *as)
 
     wav->f = fopen(wav_path, "wb");
     if (!wav->f) {
-        dolog ("Failed to open wave file `%s'\nReason: %s\n",
-               wav_path, strerror(errno));
+        error_report("wav: failed to open wave file '%s': %s",
+                     wav_path, strerror(errno));
         return -1;
     }
 
     if (fwrite (hdr, sizeof (hdr), 1, wav->f) != 1) {
-        dolog ("wav_init_out: failed to write header\nReason: %s\n",
-               strerror(errno));
+        error_report("wav: failed to write header: %s", strerror(errno));
         return -1;
     }
 
@@ -153,30 +152,25 @@ static void wav_fini_out (HWVoiceOut *hw)
     le_store (dlen, datalen, 4);
 
     if (fseek (wav->f, 4, SEEK_SET)) {
-        dolog ("wav_fini_out: fseek to rlen failed\nReason: %s\n",
-               strerror(errno));
+        error_report("wav: fseek to rlen failed: %s", strerror(errno));
         goto doclose;
     }
     if (fwrite (rlen, 4, 1, wav->f) != 1) {
-        dolog ("wav_fini_out: failed to write rlen\nReason: %s\n",
-               strerror (errno));
+        error_report("wav: failed to write rlen: %s", strerror(errno));
         goto doclose;
     }
     if (fseek (wav->f, 32, SEEK_CUR)) {
-        dolog ("wav_fini_out: fseek to dlen failed\nReason: %s\n",
-               strerror (errno));
+        error_report("wav: fseek to dlen failed: %s", strerror(errno));
         goto doclose;
     }
     if (fwrite (dlen, 4, 1, wav->f) != 1) {
-        dolog ("wav_fini_out: failed to write dlen\nReaons: %s\n",
-               strerror (errno));
+        error_report("wav: failed to write dlen: %s", strerror(errno));
         goto doclose;
     }
 
  doclose:
     if (fclose (wav->f))  {
-        dolog ("wav_fini_out: fclose %p failed\nReason: %s\n",
-               wav->f, strerror (errno));
+        error_report("wav: fclose failed: %s", strerror(errno));
     }
     wav->f = NULL;
 }
-- 
2.52.0


