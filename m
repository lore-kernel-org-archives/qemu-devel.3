Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C0FC3ABAB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 13:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9kvd-0005NJ-Kh; Tue, 29 Apr 2025 09:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9kuj-00056m-GU
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:22:24 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9kub-0005cM-PP
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:22:18 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39c266c2dd5so6767627f8f.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 06:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745932923; x=1746537723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jry+P8FNPxXBYqdgMf1f9uotm9bgcJ4IEZiGTKV/sRU=;
 b=RLcnheujz04RgOhqFjcdyGlDuzeEwbpWPG4Xp34V3L7LsIbhdcaOD/l4jZrkFdcdV+
 4NCkQ/MkTSYMVQc24C8yu9vAf6baHvYAO+L/gIXQjZkbz/Xg2G2As2UqIl4/mb71GeX1
 ya+boXEkfJBGxk7Fr/6hEEFTdirEbHwpyCu4jmDA5Du7cS7pOSpYVczglqg0pr4a2MM/
 +kMr7B9AYVN6OO7TCp5lGDKaH+K6GB47/3nWsvh+JHEVFcbYk1zU2i+UEJoe89WAO1ew
 Dv9KnjewRvvsHH9kIo/owAexCVrbetHHDT4C+UVdbfYffCYdiy9ZMQIlwbBf2eStMULQ
 +SyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745932923; x=1746537723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jry+P8FNPxXBYqdgMf1f9uotm9bgcJ4IEZiGTKV/sRU=;
 b=NFi/McwcruFL9EiJLyF516s6MAgOnTVG5/8YY0lUbNSvvp4i2rVgFHnaHuRYTSYUv+
 1RiOZvQep8OagGtP93hDm3ZDk/7sc8dl3+C7XU4KfA3YaEHdSAd+Hdl/dcHL47e9vhdf
 7JjK/a5jrK1s3kuLOoJqnIQFOP/DgyPNfdlYLzLspD8NN9Bbrm5HCCjUjAopcAVAnkgy
 vyCpnsXDd0ySIpnZkY8a7/1Hxh9s4NC6PcoYeEdn9TjME2+z4sXV8o5eyokIk8qu8Ize
 w6VsOA7QNARDSMSrLH29mK29re8KnR/HhAwZdXUAuHzsaQeCbojWqwnpR90PcaO+OVYV
 sTUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpmALNo8/ZoM6s8H9DOdAHL0l9PpHVAYxxhfx5+d7uFlUgSuZANL1CKcF8d7HtgvYvo/R1L63lDSuB@nongnu.org
X-Gm-Message-State: AOJu0YyC30puU42/uDwKzECk6X7yWvvdoZjSIV3H2QFVWpnlLdnz/f6m
 aNhcIRtdUuPcoXqL2lXLC74Esltphm1kuQipOPFiPeL4nA0NEvir3piuEogTvNA=
X-Gm-Gg: ASbGncvqQamw4OB6pe+AeKG06Yq2jb66CmGr724hiYQkHFSYfu0HQwKYUVNgTNnw6zz
 z3FLZwWJ2yRN0yy3duwGclzAifT9CoMe6qzs1Z6EHmwV8zcJ+T1spQrJVvgazlivwY6pBR57ZuB
 s/nPAHgbosn2AR5jlyovDRC3hFb50BHTY7CpNBaRYZCYiIsUOK8WPlQ8UrK8cjrHph71kg4IARY
 XwGRqtKIu/i1pJNdJuR2kZUuSfM7LSJaKHTflLJlN7jTiGlrmianC9uj0B8SdsZTei7bXp7dDhO
 vyjnf6n0maPL3s30YvAXoHOyrbwSvrvRYqqWToz4ePJ8wvU=
X-Google-Smtp-Source: AGHT+IG7HSBydWfx8YTIsDDva31B7d2yqbSS9wTPdwilM2zlq2kbKzyFbqhxasZWW7S0wvH85hUgWQ==
X-Received: by 2002:a5d:4ec2:0:b0:3a0:83b5:f4c1 with SMTP id
 ffacd0b85a97d-3a0891b2dc7mr2372329f8f.24.1745932923467; 
 Tue, 29 Apr 2025 06:22:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca5219sm13729371f8f.27.2025.04.29.06.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:22:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v2 1/7] target/microblaze: Use 'obj' in DEVICE() casts in
 mb_cpu_initfn()
Date: Tue, 29 Apr 2025 14:21:54 +0100
Message-ID: <20250429132200.605611-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429132200.605611-1-peter.maydell@linaro.org>
References: <20250429132200.605611-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

We're about to make a change that removes the only other use
of the 'cpu' local variable in mb_cpu_initfn(); since the
DEVICE() casts work fine with the Object*, use that instead,
so that we can remove the local variable when we make the
following change.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/microblaze/cpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 00a2730de4d..d92a43191bd 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -333,11 +333,11 @@ static void mb_cpu_initfn(Object *obj)
 
 #ifndef CONFIG_USER_ONLY
     /* Inbound IRQ and FIR lines */
-    qdev_init_gpio_in(DEVICE(cpu), microblaze_cpu_set_irq, 2);
-    qdev_init_gpio_in_named(DEVICE(cpu), mb_cpu_ns_axi_dp, "ns_axi_dp", 1);
-    qdev_init_gpio_in_named(DEVICE(cpu), mb_cpu_ns_axi_ip, "ns_axi_ip", 1);
-    qdev_init_gpio_in_named(DEVICE(cpu), mb_cpu_ns_axi_dc, "ns_axi_dc", 1);
-    qdev_init_gpio_in_named(DEVICE(cpu), mb_cpu_ns_axi_ic, "ns_axi_ic", 1);
+    qdev_init_gpio_in(DEVICE(obj), microblaze_cpu_set_irq, 2);
+    qdev_init_gpio_in_named(DEVICE(obj), mb_cpu_ns_axi_dp, "ns_axi_dp", 1);
+    qdev_init_gpio_in_named(DEVICE(obj), mb_cpu_ns_axi_ip, "ns_axi_ip", 1);
+    qdev_init_gpio_in_named(DEVICE(obj), mb_cpu_ns_axi_dc, "ns_axi_dc", 1);
+    qdev_init_gpio_in_named(DEVICE(obj), mb_cpu_ns_axi_ic, "ns_axi_ic", 1);
 #endif
 
     /* Restricted 'endianness' property is equivalent of 'little-endian' */
-- 
2.43.0


