Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3144FE7BD8F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwa5-0004m8-CD; Mon, 16 Feb 2026 06:15:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwa3-0004kn-2B
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:15:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwa1-0007JL-62
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=03yR22OPWyv4xOgsTRflUVZkTa9pLbZJpc7QOwE/YKQ=;
 b=TGoOJBTQFu7C3Tf5HBYi/M8siHV5k4SBHvv+N6mzwbfue1JVNCOy0DSuThYqEn+vZtf25V
 pEwvem1zNM/pOYu2WWNQ32IVxz0kxPsH6LEyF364V92kI/g/U68QlA0blUWPlY1xa+IH7f
 gAPyf+p8/pkwYYwqaIHE8tOJb85AtMg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-S_3Rn-x3NoK6-w9xBzQ9TQ-1; Mon,
 16 Feb 2026 06:15:47 -0500
X-MC-Unique: S_3Rn-x3NoK6-w9xBzQ9TQ-1
X-Mimecast-MFC-AGG-ID: S_3Rn-x3NoK6-w9xBzQ9TQ_1771240545
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE3911955D4D; Mon, 16 Feb 2026 11:15:45 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8A63119560B2; Mon, 16 Feb 2026 11:15:44 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:14:52 +0100
Subject: [PATCH 03/85] audio/adlib: drop ts_helper HWVoice field
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-3-e676662e4514@redhat.com>
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
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1480;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=/79pMsmTucvlzgY5FBqKNb003r8HB/EPhG2j1zf1dS8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxOtpJ93glYebWbW0M9TwpEeqzqZE8wKES33
 RpgLlFp1SaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8TgAKCRDa6OEJdZac
 5R1BEAC1bQIZC001c8va6eb/i5dK/TdhxHw+4klXKNMMuGSZ+JwVRaxYcY7R2CI478M/ELBtQkY
 4/V5alEvtX2F2ho08cK0axbyCE9VkCq08MmXq2+UuHz8eHd2r27EX+JZ3m5ErrQtunIk1afEn82
 sKHC1peBr6Zq/FTNB+ud/MzVK7zm35OlZWeVzcnT5C3fOF1WPO1w/IrQgUppQUhgBqkeZi/aVtX
 NPx/fEL/1WMRR91QxWWTXhZXoWYbJ5f7zkNI5mouFp8VR6lxzOXd5v1XYqcNb7/osyRUMjfVkqN
 74FaxTgii9tdNhEKUozF5fa8jXTmqhA4Gzw6K5rQ1+njUcGNkBC6kO2wqBHPUf6/EoGRozaLvCg
 f/3qksrInIQLbaMRlHJnz1Zt/1Si+6IkEmpzxG7mF92uQyaeGp5hrQ+W/w9s9ws3/bdyURTfP1X
 ba2QcsfkupaOjIF41sA0EXVftgZKcakw3OsJUedprcVxnx+2QvkoyfeHTR+g7lWDE3Hzgd8aI/Q
 Tx2HAZmVKIfOSmhcZ2C9hhzhKRI6y6EiXKDSn/gTQG+9wtIzwNiVCPkUJEXJmZSRc+8F4x+HbRS
 3tDMRV15aAagKqjcM/gYsyJzxB6OiK841t7AZOOvvcww5ujOeoltNFXQrFxdMdIlAakRx7KZSSX
 g9lwi9ZRnAbskLg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Previous commits made this dead code.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/audio_int.h | 2 --
 audio/audio.c     | 2 --
 2 files changed, 4 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index b2b8002477c..20b4c87b0b6 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -77,7 +77,6 @@ typedef struct HWVoiceOut {
     struct audio_pcm_info info;
 
     f_sample *clip;
-    uint64_t ts_helper;
 
     STSampleBuffer mix_buf;
     void *buf_emul;
@@ -99,7 +98,6 @@ typedef struct HWVoiceIn {
     t_sample *conv;
 
     size_t total_samples_captured;
-    uint64_t ts_helper;
 
     STSampleBuffer conv_buf;
     void *buf_emul;
diff --git a/audio/audio.c b/audio/audio.c
index b7a28f79d4f..a218570a4f4 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1240,7 +1240,6 @@ static void audio_run_out(AudioBackend *s)
 #endif
 
         if (played) {
-            hw->ts_helper += played;
             audio_capture_mix_and_clear (hw, prev_rpos, played);
         }
 
@@ -1320,7 +1319,6 @@ static void audio_run_in(AudioBackend *s)
 
         min = audio_pcm_hw_find_min_in (hw);
         hw->total_samples_captured += captured - min;
-        hw->ts_helper += captured;
 
         for (sw = hw->sw_head.lh_first; sw; sw = sw->entries.le_next) {
             sw->total_hw_samples_acquired -= min;

-- 
2.53.0


