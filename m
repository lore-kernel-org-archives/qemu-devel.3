Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7683CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 10:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utkS8-0006eq-4A; Wed, 03 Sep 2025 06:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkRL-00069O-E9
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:10:12 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkRJ-000064-FE
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:10:07 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45b8b02dd14so20495435e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 03:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756894202; x=1757499002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wPrMzC7xkMP6BFGfr7/f+KLgzjkhoBLbvGsAwbo7XSI=;
 b=ShiMvimXdR2D3FTucQzD3ZDgQ74EJMemYdXNjwU0WSBTddigV22N2aHopr6+1BNQDY
 xts/k03eFoR4Hzm0+aB1wwpO4HI7hBiZniPBzmLOVaBC/BlqLYzsryfsw3+fig1TD2R0
 VHEfqdX++itZSDdtMFQsanhgrvuj2xfWDgLcaFA0iFlTQ6iDphrnxlc0UvZN8DC78oVS
 yi1wdJnxtQqpCQUrE4IXrB0VCBy8p6/Lm6wywKR6sIrVn7+Zzx+vjD3nZG7IeUjFUvki
 Met+HeM9QTK3lQb68VQA/lUuBxLItGYyp3KIQSxyrBSVGrTB3OpRKwiNdPbvcPRaFsrp
 RE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756894202; x=1757499002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wPrMzC7xkMP6BFGfr7/f+KLgzjkhoBLbvGsAwbo7XSI=;
 b=jq6eTuiBFoS+YKWRK9A+klhWwgOH1tYKjr1Z4oI4lWRLZ9i2NAXyEI2k0+Wp+h4X9L
 M3ce7Y5GYnLHUUa3D7zjedBSs2bUgdPaIIWbzlzm3xEvR3pdXD3K5muH6uCTrDSY+ugk
 KZsSP2zwLhXu9m4q4awhi4T1IpMu/UxgrYymr+4T6rEoubINfiuhqHV5jj2R6taHO+TZ
 zlcHbZEql0xPYdz6sXLoLvHirsiPVECFkDnVu84TKpzzBOJ1nmqSIHNzcXNxNqjN593v
 fKxn//dYv1R+ruuvXEzU11En/PZc/DX7Eju3yu8WddfSdbQ6tGFIhz2vKi2SGv7W4+5o
 Zpyw==
X-Gm-Message-State: AOJu0Yy1CJG1x7qD0y7uTK38+rtIwAQBlwHjpYZRyEWxWLWT8Oo6ahtK
 oF+rYfJ68Yfd1B0w/QVWH7y34CxGPTxq83/C8/CSOywaV3HjmG1i3UArDkL1ONhpmWy2IQbI5c6
 4Zvifm6Af4A==
X-Gm-Gg: ASbGnctErY3iWbsTPmLgwBz7t0Q4b3iKJVwxRNcojjZP4QxmZRGNGeXVPW0A1sL8OMc
 jNh7G/Nok5roig0QsigYgjhuCPqwc9s6K8rcK/N7woMojk2F9bOc1RPlAexEMXG8VcmI0z5+BZH
 NzcQKRdgs7o3+sMMqsnAsFTISe5N6tjdix1Mu2dD2H5B50OQpDHKD9u9Wc8u5Kf9/Z5cxf1PYq7
 5h9xehSM4BCiLvizcXQI6Y9oP45nIknebrdZBzDvSf/vgWPOlnnYKWrvJHgGF4VlaaZ9UK5/ukT
 SLlWT5yoMfu64QfSex04TFiaX/7C6ugI5T6mWuCO7n1VeMoEHsrJrHeU6SzcBw3LQiC+Rkz5S/U
 jhPlTBIzEc5AvLy9N/1rG2fKoOkbTyZnzxAgz3FEa47nzWT8waT98Gb07mD3pVd0/MFPKu+H8a6
 BEttbjY9AkmPTmpok7
X-Google-Smtp-Source: AGHT+IFqGkT1Nsdy6nEix3cmm2NK4/o8TXTxVSoc7EyZnEEYvN+6IEOCgtR2JSl/s6rnfy/fD6GTRg==
X-Received: by 2002:a05:600c:1d10:b0:45b:891f:afcf with SMTP id
 5b1f17b1804b1-45b891fb24dmr95642275e9.27.1756894202179; 
 Wed, 03 Sep 2025 03:10:02 -0700 (PDT)
Received: from localhost.localdomain (98.red-88-29-180.dynamicip.rima-tde.net.
 [88.29.180.98]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306c22sm320208935e9.13.2025.09.03.03.09.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Sep 2025 03:10:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 21/24] target/arm: Call aarch64_add_pauth_properties() once in
 host_initfn()
Date: Wed,  3 Sep 2025 12:06:57 +0200
Message-ID: <20250903100702.16726-22-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903100702.16726-1-philmd@linaro.org>
References: <20250903100702.16726-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu64.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 26cf7e6dfa2..f81cfd0113c 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -762,20 +762,20 @@ static void aarch64_a53_initfn(Object *obj)
 
 static void aarch64_host_initfn(Object *obj)
 {
-#if defined(CONFIG_KVM)
     ARMCPU *cpu = ARM_CPU(obj);
+#if defined(CONFIG_KVM)
     kvm_arm_set_cpu_features_from_host(cpu);
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         aarch64_add_sve_properties(obj);
-        aarch64_add_pauth_properties(obj);
     }
 #elif defined(CONFIG_HVF)
-    ARMCPU *cpu = ARM_CPU(obj);
     hvf_arm_set_cpu_features_from_host(cpu);
-    aarch64_add_pauth_properties(obj);
 #else
     g_assert_not_reached();
 #endif
+    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+        aarch64_add_pauth_properties(obj);
+    }
 }
 
 static void aarch64_max_initfn(Object *obj)
-- 
2.51.0


