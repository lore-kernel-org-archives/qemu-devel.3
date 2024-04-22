Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B79F9C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 13:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rytUq-0004uG-0i; Mon, 22 Apr 2024 09:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rytUe-0004ie-P4
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 09:14:02 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rytUc-0002Ih-SA
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 09:14:00 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41a5b68ed0aso5793795e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 06:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713791636; x=1714396436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0CfwgkjbzgYAXblJxs9gNejxswFCkLFrV38LRL8E1yU=;
 b=tyvl/BI70G1Xk+WD+Qk7e3MM8Qd5VggIYvW93mqBow72QiwfFIjekrCyBTYPJ7bwbm
 h5P1jn+hSJ17dyyrRajjoZ4/tD24/aqueYqIteJq7dHLvb1grixObvwvstmSXF2K8Mhg
 GctTmirbVX98fZyFCeUuM031jDapgIcPYpaFhOZcgGO7euowYGeWNNmIayi/mXnb1bxW
 oM6Acx4vVGWsuBpBLunwjPgn1a2MZR5x+cDwz2oVrGj8V9dK9KZTwng51SshYxawZ1nS
 L3ngpe6Fa3XBtOtuSgWJMi5WshMhLJFsPbARiMn5PZXFImIC9Y/QfRkGucVJTAOKsBLb
 6K9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713791636; x=1714396436;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0CfwgkjbzgYAXblJxs9gNejxswFCkLFrV38LRL8E1yU=;
 b=XIllD2gL72diXSdtWjby6yi3Pix8g0W6Ic8ssU647eNifDOrOc43Ug87tRsII55t1g
 ye+BRFYEminhKMM4oJWbprv+flkNimP9Ziycog0v1JW28uZJdz8Xf2Tl7cdlGzpTCMDd
 gXrGedeT0xUYf6xzHYNsX03KKoaFc8kAIU9wrEd6LOoD/HkCqTVDRzSBfdbN/t01HQ0V
 kSCLjbtV98/AWB3ZBCB2s3wIXe7NDvD7DoPLh9mWF32gwYSu3LvUesLpHjCN3ykvP4Rl
 ovqY8bFC9Its3Acb6Qh9sz/ivSBeKIk0CeO1pC5iUg71PQgI1zjtBiTByaVRulDouPrF
 Nasg==
X-Gm-Message-State: AOJu0Yz8+WxAi9XdtkzBu9DORqlfJ+hV4BZTtA5Cjnjyk0yk6oRuTzUd
 jDgZyRIkNIOwiQFYWaa2pv4KtnLXgLtWmmRUsCzgHhINfnkmptZCo9D79srp10PopkZUV7Ay52T
 0
X-Google-Smtp-Source: AGHT+IEFwwxxKpZSrbL5n00pjuOEcQz+uFu4fifPN39q8IkzUkm5AiNdU8KaFLLv2neUl7A/M3RFtg==
X-Received: by 2002:a05:600c:5489:b0:41a:43ae:baf2 with SMTP id
 iv9-20020a05600c548900b0041a43aebaf2mr2528021wmb.34.1713791636480; 
 Mon, 22 Apr 2024 06:13:56 -0700 (PDT)
Received: from m1.home (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 j10-20020adfff8a000000b0034335f13570sm11917566wrr.116.2024.04.22.06.13.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 Apr 2024 06:13:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v2] hw/audio/virtio-snd: Use device endianness instead of
 target one
Date: Mon, 22 Apr 2024 15:13:55 +0200
Message-ID: <20240422131355.2264-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since VirtIO devices can change endianness at runtime,
we need to use the device endianness, not the target
one.

Cc: qemu-stable@nongnu.org
Fixes: eb9ad377bb ("virtio-sound: handle control messages and streams")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/audio/virtio-snd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index c80b58bf5d..82c5647660 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -395,13 +395,15 @@ static uint32_t virtio_snd_get_qemu_freq(uint32_t rate)
  * Get QEMU Audiosystem compatible audsettings from virtio based pcm stream
  * params.
  */
-static void virtio_snd_get_qemu_audsettings(audsettings *as,
+static void virtio_snd_get_qemu_audsettings(VirtIOSound *s, audsettings *as,
                                             virtio_snd_pcm_set_params *params)
 {
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
+
     as->nchannels = MIN(AUDIO_MAX_CHANNELS, params->channels);
     as->fmt = virtio_snd_get_qemu_format(params->format);
     as->freq = virtio_snd_get_qemu_freq(params->rate);
-    as->endianness = target_words_bigendian() ? 1 : 0;
+    as->endianness = virtio_is_big_endian(vdev) ? 1 : 0;
 }
 
 /*
@@ -464,7 +466,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
         s->pcm->streams[stream_id] = stream;
     }
 
-    virtio_snd_get_qemu_audsettings(&as, params);
+    virtio_snd_get_qemu_audsettings(s, &as, params);
     stream->info.direction = stream_id < s->snd_conf.streams / 2 +
         (s->snd_conf.streams & 1) ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;
     stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
-- 
2.41.0


