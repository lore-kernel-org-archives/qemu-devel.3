Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90464C55184
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 08:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqnmM-0001bV-FQ; Mon, 03 Aug 2026 04:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wqnmK-0001bJ-6w
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 04:12:08 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wqnmI-0003es-Od
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 04:12:07 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4954dff6536so12210615e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 01:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1785744724; x=1786349524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mgozXciHTThk22TT8NHrXksaBCyxZBiWb8wXbhOl/N4=;
 b=jPAogKmZRz27e+cPSimiSzPNhmvZsjOXZzSis0DkZ3c3nI+HmUH50jOq8ww97Pzs78
 1wK7AVYKzfP4Ls0KEsdkR3vc2t+NntY0mNo0DRJ9XdXhyDI2boxUxFTxdbU/u82MAD7n
 f5A1eky26T3iL5Ngw6wu5I70StULUKG+zVCt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785744724; x=1786349524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mgozXciHTThk22TT8NHrXksaBCyxZBiWb8wXbhOl/N4=;
 b=hfk6KR/x3GhEHE8+K64MPJoqQA1EanZFmcg3jVt3ug0MtRkp3GeHXQ11nh2V5ZDcfT
 tQ/4g/2bpazBWekG+U3v3WUsfgFGAGj8CZxj0nZYS3ITRL+qxpNKA9cDxFELbETSuBRa
 kYVKXTkwTcaSjJUZJQNCVHo1RVPw5M5koxmnsrGwqUjcicGDTFpiVnhsb5rgx2oI2KNs
 aj/OPJoOYo5eRSxNiNw8EjXKv1tFyr4dmh2Wcm6IKEh4/nKNMPnfBHzZ6y56OHaxuJLO
 DhG4ZtnmPqFHn8NGBo/TFmZTgP3aAbTfVcNTueBvGtJ2xic35fIRG7srGSBuIkwwVIdf
 lwWw==
X-Gm-Message-State: AOJu0Yx3vXZyGLCmBiuO8i40NVii5Em5fqnaX1toG59vT5r+ZKP9fkdS
 pKYNh59u2Xo2vrecoQw1BZG95888ThGniLPpgpOObd3WGJu6BiqXWnl5uzB9vz6Yy9c4lGO6Y9r
 O9JPx
X-Gm-Gg: AR+sD11hZcGzGe8WTm4qO1ZHQIvjxxe3WLZcwOi4DTr53Ce8YC56iRKAye42cRXgQMK
 Rl1lASSAfbdxpaBZvq9dNsTbzcHWYwKNhW84UmygOenhMLk+gBcyToIhFFpvXOwPfYRwOEUP21h
 8LLyaSpkV93SiisRZ3YCEnZmBX3poI0pSNhoRwP7TwGQkMYOh/HPlXYI1rC9IK3pFyOLhKVQStq
 LJ2DH5tsufWm3t6njG3C/EOq6Dm+sgjkIOXDCbAotIT7KNyq17Vpcu3pCVjN9tWqTF38U2wv0zw
 r+tCnj8oBW7KFQ05DVcu6BCFPRH/gpXrzxwhJB7w4PdJJQ3VfV3aUg6mxxSW2OU6/kbG9JQjr0b
 JpDIWi7cOLi04RFJV9FpCenn7XlGK2ypCbnUzYKzGNqziezKh5ZFhUW9fxADJau2E8XqfdI8uR0
 U6LHFCFs9qhxbOTue2MU5th6zhlogSfMiuDxjU9uoz2hfaDlR5yEwzEHHVJB9KfERXzWctcsrzx
 IxYLtvkmHabssVFeNUX9min1U4GssgNhWp1WA9odoKgpKZNTpqbER+FNJcQ
X-Received: by 2002:a05:600c:524a:b0:498:28b:1025 with SMTP id
 5b1f17b1804b1-4980c66c838mr182685135e9.5.1785744723693; 
 Mon, 03 Aug 2026 01:12:03 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a7200803110ea947f174a.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:8031:10ea:947f:174a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b98284sm209358435e9.12.2026.08.03.01.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 01:12:03 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v5 02/10] hw/audio/virtio-sound: drop unused struct
 VirtIOSoundPCMStream.flushing field
Date: Mon,  3 Aug 2026 10:11:51 +0200
Message-ID: <20260803081159.91981-3-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260803081159.91981-1-alexander@mihalicyn.com>
References: <20260803081159.91981-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
v5:
	- added RWB tag from Manos
v4:
	- this commit was split from
	  "hw/audio/virtio-sound: add stream state variable"
	  (suggested by Manos Pitsidianakis)
---
 include/hw/audio/virtio-snd.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index f8bb5c95b97..b60b098ccd8 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -138,7 +138,6 @@ struct VirtIOSoundPCMStream {
     virtio_snd_pcm_set_params params;
     uint32_t id;
     VirtIOSound *s;
-    bool flushing;
     audsettings as;
     union {
         SWVoiceIn *in;
-- 
2.47.3


