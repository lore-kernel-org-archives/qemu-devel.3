Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9715CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtmc-0005fW-8A; Thu, 23 Oct 2025 07:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBtmW-0005CJ-0F
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:47:00 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBtmT-000213-Ca
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:46:59 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47106fc51faso10527865e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 04:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761220015; x=1761824815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ywx1NTEVaZQkKaXvAYoeY9Xrt/iLLGXyjyipFG87mzI=;
 b=p+rGj4ev3/BLxl6GblkpoIDN5Dcm+0AtOKdp9C+MjOEYnABzElWgspt2brlxkzHDFJ
 CNR/SJQnfIJcTexjLPCzN2qYt+ycSL3vin3qju+FT0zdcaiBGRcdA0Jcl7YLcP97TeHn
 mrVCJZ3FMva8rJia4F91+tlsTHkJO4i1LGWAXB5w2JY3rxeTwUxY0NcE4W9f0lBEE2PY
 53fNOpPymsBFEOKtdcxiZjA+Wejb1erhdByPFDH7Tf8tuQGtQrhIF9X5yr7KIMU7lAF9
 O6pVQdg7MjpgaGY5XFfyMN4Aup+Luq/5D47Bsd5UAutb1wFu5Lykj7QQ7Ch9oEcU9/gV
 qUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761220015; x=1761824815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ywx1NTEVaZQkKaXvAYoeY9Xrt/iLLGXyjyipFG87mzI=;
 b=KZQ08d4PEN14AsfXtOur3g/Zu4YxhUmGxsHSlb7o9SfLRiZU3pu2HMF4RadNVsgXiH
 oo5M5C7apa/o6t/CVKAYT+J1KQgyVO/GyFmM65B7ZCfvVTKwngNVrHESQwVHhFyl+ntP
 GJuFpOmyK/FIXFPllg3pxWxqTM+9+hIpLiChG8aNcR+IwKo8e3vrbFQHLlp7zUKyyaH/
 laU2R5OP8gSwE4inmbSsdo9qqzrl3W1pUfek52wmLIP6exalBX9O7a/7mC0AEoRC2RsW
 cCOkgT6g15VBI3NpoQk+S5eeT/BgSEo4/MUMrn/c1j5S1k8gTl5zr/JQATpsHFj2Ol69
 TIpA==
X-Gm-Message-State: AOJu0Yx5FI7ix3oxFqya+Hj96bOd3+uzLNeU3iyMAgFx6Qb5o6iBb0u5
 Emjlc+D1ThB3XlT2MUblYzWDkGmmpTx6o32kbSwWM3i/v1fRHXRFrieGY3ifGvopyQKDOXJJWS8
 BU7RdJAU=
X-Gm-Gg: ASbGncuRYAq7JoqrNEodZA+W8NprtWFFAWzk0+MgZNdDAMMf+FTWAN0ijajzJz2CFSW
 UNyRevlXnM7xTYI1lMobMmfN5M7GMw2CjvrRpFxM+etK34KQXfOhbyOfqewFEFyeinbEei6NraV
 4P9Si2OntJzZl7CuW58CNEg9E6G0ZWBMsysgmHGGW6x6Qvtt6RiTwdMMgQUrqyqKC4cLvbB/aOV
 ficH6l2fd/RTSLjPT8pcBzlWmbLNqnDrpMHHwyNT5utxQPrgXkVN8DnBIun3nIShx/A5V280zTa
 L6yhEmaGpz2VUSaruw5ao+TgzWJs5JgC6PxQlC6Qv3IV/m3HJT11vCHEl4kiDNCv1RQtOD7zwcu
 FCvRP0qSFqnDiPMEPl2G3ZuAegh6SqYFajfcmbMPtu/NmOQgHeTONiKiPugz5cdMpzav4Z9P8wn
 6eN8HcWYHgr98tqgGuvlqbVrYqezQNnNhP0UiRs7mU56shJ/JZCe+rve0ERm/r
X-Google-Smtp-Source: AGHT+IGw4gglu7O8489NpdACo5UWYvNq0w3S3tF8X+OJgaau/h3nWhaz0mON5L13y0rSiQoVefgHqg==
X-Received: by 2002:a05:600c:548a:b0:46e:6d5f:f68 with SMTP id
 5b1f17b1804b1-4711787a2cdmr168135995e9.12.1761220015353; 
 Thu, 23 Oct 2025 04:46:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475caea0468sm35327155e9.8.2025.10.23.04.46.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 04:46:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Peter Collingbourne <pcc@google.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 03/58] target/arm/hvf: Check hv_vcpus_exit() returned value
Date: Thu, 23 Oct 2025 13:45:40 +0200
Message-ID: <20251023114638.5667-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

hv_vcpus_exit() returns a hv_return_t enum type (defined
in <Hypervisor/hv_error.h>). Assert we succeeded, as we
are not ready to handle any error path.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
---
 target/arm/hvf/hvf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 91bbd3a6aae..4c98faebbed 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -963,9 +963,11 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 
 void hvf_kick_vcpu_thread(CPUState *cpu)
 {
+    hv_return_t ret;
     trace_hvf_kick_vcpu_thread(cpu->cpu_index, cpu->stop);
     cpus_kick_thread(cpu);
-    hv_vcpus_exit(&cpu->accel->fd, 1);
+    ret = hv_vcpus_exit(&cpu->accel->fd, 1);
+    assert_hvf_ok(ret);
 }
 
 static void hvf_raise_exception(CPUState *cpu, uint32_t excp,
-- 
2.51.0


