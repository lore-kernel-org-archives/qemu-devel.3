Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F313C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjLK-0003aj-Kb; Tue, 30 Jul 2024 05:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLI-0003UC-Qh
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:28 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLG-0000X7-96
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:28 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-36865a516f1so2835618f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722332425; x=1722937225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NzA4PjXCRONbQTo8BkDcv1kJWdZctM8YQjAGl+nA/2Y=;
 b=IWxayZdS+y1XSMSMDx/cotFWvinCo1CDJCqP00GukJsrCA5Y70FO8NDArwbha4hV+0
 T1C1lDz8t5WTtkG1soHWYOCnmRgs6V3D4zvXZqdfAo1Pq7h2Mlr8mswAm0Fo5kExx0We
 oUlbUyaMxVgTd7lg+mUbJl4DFbN20xsFeAP7qNS8pOy1NVMXXRJbbgNLOdEfz6nFmXTc
 JmfGODsVcNctjtikDVjRM45uhovzHKJAd+Pjsnpc0P7OfRxNxn/stdmZZgLnz8EAn+3J
 wydHug7sKOkzSrgi3Nt6HyGrfNZycFhQ1TLqc6TC2cSv0EkrMnpdrmP0yJYzUC7jjAQx
 /Ydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722332425; x=1722937225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NzA4PjXCRONbQTo8BkDcv1kJWdZctM8YQjAGl+nA/2Y=;
 b=dxajZdRcstUVr/hmTLfYQOXa8ZSIRefcLCXAxP5Z33AILLS/juJ91vQwU376uB7ASV
 hgdIONX6TJUeQrbzoTij2xdgU8RmruzOCbV7Spx01WLSUOqdSuLlQHCKijShxxIUY6eA
 ufOui6iPGImbN3AOU7dTOA1/Awz7ROVZ4GE/Nymi77I10O+inhjmmlUh1aL5KfFN5XzH
 tQv1kZ4fZREgEW7RgkUzxUDe45QjAoELgV8fBdPi4eRvHusPHl1skbn4uY06ALbtaHEF
 DGm2e1uOdDblUExL3LgBtuIOgUlbwfzPMNbqGmHPtts9Ra/bABc8xT+UBRbph11GSpL+
 Kl9g==
X-Gm-Message-State: AOJu0YyhO4E/VhmxcZoF+BXSEGb3bFz4K+olwM4/GK6IkH65AenzhUSD
 HmfNabb2TY+JALecXoYgEDoKURzvm/ktWR8rMzUzjkjO93w0GQc9mhVDKDgga+o4ZbKZ/+yWGrF
 I
X-Google-Smtp-Source: AGHT+IGMnsxlzihbxHfqSbR/RWqX9GZgXtfCmClfS1Nlc5yt8jEP7DIg2PPeJeU15ZO+q+QM2IGCqg==
X-Received: by 2002:adf:f582:0:b0:368:3f5b:2ae7 with SMTP id
 ffacd0b85a97d-36b5d079e31mr7514750f8f.24.1722332424739; 
 Tue, 30 Jul 2024 02:40:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862549sm14194974f8f.106.2024.07.30.02.40.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 02:40:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/21] target/arm/kvm: Do not silently remove PMU
Date: Tue, 30 Jul 2024 10:40:03 +0100
Message-Id: <20240730094020.2758637-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730094020.2758637-1-peter.maydell@linaro.org>
References: <20240730094020.2758637-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

kvm_arch_init_vcpu() used to remove PMU when it is not available even
if the CPU model needs one. It is semantically incorrect, and may
continue execution on a misbehaving host that advertises a CPU model
while lacking its PMU. Keep the PMU when the CPU model needs one, and
let kvm_arm_vcpu_init() fail if the KVM implementation mismatches with
our expectation.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b20a35052f4..849e2e21b30 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1888,13 +1888,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
     if (!arm_feature(env, ARM_FEATURE_AARCH64)) {
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_EL1_32BIT;
     }
-    if (!kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PMU_V3)) {
-        cpu->has_pmu = false;
-    }
     if (cpu->has_pmu) {
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
-    } else {
-        env->features &= ~(1ULL << ARM_FEATURE_PMU);
     }
     if (cpu_isar_feature(aa64_sve, cpu)) {
         assert(kvm_arm_sve_supported());
-- 
2.34.1


