Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E767E7BD9F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfW-0007pL-TK; Mon, 16 Feb 2026 06:21:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwd9-0007Ur-5X
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:19:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwd7-0008R6-C7
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kcz5monBArNaXcY5PhEuW+EZzvnBJyzEr+NifJaMiTA=;
 b=I18eE5P0dTOHtgCARk8IHgIsw47vmnhku5Kc7JnFqud7AGjkew1MtEecUmKuIJ6FLVKDdm
 SmX7lp6T/9HApPpPt2M9dlyDoBLL5vt5aiTsKBUW40kjnUIw9fk74kCDXkeZb0U3s2jTDZ
 EhQR0StrH3QFK1ugCzd/Qa4xSt7vsqc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-wLzjMd9WOeuCX78ZAzILDg-1; Mon,
 16 Feb 2026 06:19:00 -0500
X-MC-Unique: wLzjMd9WOeuCX78ZAzILDg-1
X-Mimecast-MFC-AGG-ID: wLzjMd9WOeuCX78ZAzILDg_1771240738
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24BAA1956089; Mon, 16 Feb 2026 11:18:58 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 29E7F30001A5; Mon, 16 Feb 2026 11:18:56 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:16:00 +0100
Subject: [PATCH 71/85] audio/wav: replace custom logging with error_report
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-71-e676662e4514@redhat.com>
References: <20260216-audio-v1-0-e676662e4514@redhat.com>
In-Reply-To: <20260216-audio-v1-0-e676662e4514@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3883;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=uy45aaxsrjikhNcoNvvFIYlxO1WkTxvpW/LgSnOpQeQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxRdF6doIYfytosh7z/TOgj7Eu7I/l0FEgOC
 OWyEbY3E0iJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UQAKCRDa6OEJdZac
 5W1pD/4soLavWDJkIjW9wjtTAn9bFFjzpkpQvg+h/UkCj+CwRYP9f0ABzpzzvK4HJTji5IErsBq
 Cv+dYZem2stuwHwUe1EFktQY8EbQ/QK/kqB0rk7Owvn8RceUCp86sgYCIYS2Htyf/7Zdw+tfgiL
 jpPmGk2jU8RcFOUPqBEGBR+T0Xp1y82JAwP8pHSpNfeJyWs5QjYnNHR0uzXyJ4wfLQPHHFRl1hl
 TmP5fPtgFXJrl+nsbESW4cIKKnOGC7Omib/SitjBwGrfEIKJNzgzRxABSKZmq20CkMEvqjpjT8I
 V58YqecwLayd6LAup7KagI7NI2T45yKEk/J/64awhwg5xYIlVLnzmrmeCQ65apIWgcgne+5d8Du
 S9TWQ2fpZ54PegbRkddf07FcgEPSFvYp+GVyAgbbZHz41wzTZeuWGFgcg0XY6V2Cl4u/hzNK/67
 eNRlZvguytwYAt+R4ciluJ4qJT94ROktWWoZi1m83NX5LmC7N2ruQo2/aUb1ehNSjDUEZ04/99J
 xhzrd24T8aqQ2ZF+Pr7FCZ74U/mjh6/aQ7Y5VWRDYUfhlDilx66zZ4AdjkA8OtUzYMFFdUzGfqA
 4Z87I8w5yrRi2uaw5ppeHGnKf3Lct4ysBmHMNDy+jT0TJ3+jzWtkn66yK666d8YvftCQBZDpmmv
 cKGDqaKhgfK1rGg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Replace the custom audio logging infrastructure (dolog macro) with
standard QEMU error reporting (error_report).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/wavaudio.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index ade8fd1d8c3..eed1e501af0 100644
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
2.53.0


