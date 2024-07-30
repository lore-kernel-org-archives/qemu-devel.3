Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BEBC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjLK-0003cR-UD; Tue, 30 Jul 2024 05:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLI-0003U6-Nb
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:28 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLG-0000X5-8w
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:28 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-427b1d4da32so15413315e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722332424; x=1722937224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bZsLhHkGD+2RM38lDnVh/UCvs0hJqBanVDQ8iZwwBuE=;
 b=lUqaleGYBlOLbVUXNtr0PANnSb0ma7SSFyVldsT4IsRp+qloAYQ8uhDC7DdhcbWABA
 CXxnjLvBDMRtOTU9XhbnazikaOS3PCrRVdZ4ujyy5vjioaC/XP+wVcFb71zlR3RyH9ok
 KUVBqmYQgsPEToH086QPgLm0+XjzfKBCYJh7BjL5M9ywDB1GDLWccbv0O41wyK3iQ5P0
 7c8RTJXr3GpDm/oS62RCu89FLnYX4Yqu6wwb+FtDnuyHlZwQqfRYRuxLB9cnmmpieVqX
 0FK5OPdoQCFW6w0rCQf6c7z+J5wylo5ng08e2871S4Fff4IijjGiKfZyFWUhEEKSZk1p
 FJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722332424; x=1722937224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bZsLhHkGD+2RM38lDnVh/UCvs0hJqBanVDQ8iZwwBuE=;
 b=gxkj3ke44yg+dyEMI6X+D4phzZq3lckat8/1kseue+4/KgE14ZjpJ2qKoQSjqUxJor
 GFDfXEnyHMC+v9png4VgW4NEZSuz4d4Fg7vlV89lLpGhnivtIh5ujadtWZgaUpzfVGNg
 1QO1fFExdD94XB8Lu7oethCu+NhO3zchSouw7qRPA9yay42diDwJU/M3pFycYUfbIODF
 P3o5NRgLGj1qteZUTf29yufR7Rgu4qrOnhapGwLfJzYaynAM+ea4cYhIxPJmvUvGE8zQ
 EbBXdV7eH1L+/aPT/hi4MHbgwv2QRYFKHQTctbbXlRE00iHvNMBLXxGmti3tbWQ4TlNp
 21/Q==
X-Gm-Message-State: AOJu0YxrwyqebdnChMxuUktCdWF7TmNxrQnebDTtUnPQgxytRho/odtA
 26U91mg5lzTm0thXW7glEEobV3Vo+UmqNJAoAzcPcN/SYTDg8WWep4E6xr/X8qSIOMyoYA281yQ
 b
X-Google-Smtp-Source: AGHT+IEXImobQRJfoA+d3bbD7Ajoq2QvOWuY4gsQmi9ruKV7s0Zk4qs/0fPNNNDp385SskhrEEewWQ==
X-Received: by 2002:a5d:6e04:0:b0:366:e308:f9a1 with SMTP id
 ffacd0b85a97d-36b8c8e9b57mr1001217f8f.23.1722332424295; 
 Tue, 30 Jul 2024 02:40:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862549sm14194974f8f.106.2024.07.30.02.40.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 02:40:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/21] target/arm/kvm: Set PMU for host only when available
Date: Tue, 30 Jul 2024 10:40:02 +0100
Message-Id: <20240730094020.2758637-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730094020.2758637-1-peter.maydell@linaro.org>
References: <20240730094020.2758637-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

target/arm/kvm.c checked PMU availability but unconditionally set the
PMU feature flag for the host CPU model, which is confusing. Set the
feature flag only when available.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 70f79eda33c..b20a35052f4 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -280,6 +280,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     if (kvm_arm_pmu_supported()) {
         init.features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
         pmu_supported = true;
+        features |= 1ULL << ARM_FEATURE_PMU;
     }
 
     if (!kvm_arm_create_scratch_host_vcpu(cpus_to_try, fdarray, &init)) {
@@ -448,7 +449,6 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     features |= 1ULL << ARM_FEATURE_V8;
     features |= 1ULL << ARM_FEATURE_NEON;
     features |= 1ULL << ARM_FEATURE_AARCH64;
-    features |= 1ULL << ARM_FEATURE_PMU;
     features |= 1ULL << ARM_FEATURE_GENERIC_TIMER;
 
     ahcf->features = features;
-- 
2.34.1


