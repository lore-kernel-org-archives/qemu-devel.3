Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C919C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTg9H-0001UE-Bh; Mon, 23 Jun 2025 08:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg9E-0001Ti-QO
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:19:40 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg9B-0000Yn-6H
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:19:40 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a522224582so1926345f8f.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750681174; x=1751285974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MgoMlu6luU8uPkDpvUPvEjZTODhHkmT/W4wpYdZo59E=;
 b=CVzpMz23T4COrgXR/FdUdeKQ7hB4B/qjzXRMc+ISoeE3M7QadJWaF1CiWM3U2xXtIm
 FygfI1UKpaITWHHPN+ubloPdrTzFEEvSwSU7QmX85Nh7MDWeEqsP4wURUAMYRcwevGwu
 BN4xeoOXMLhfyPoBzdkkipmqpQDG/VEB7F09g+QyjKmITcGeFlcgmYUUtJEKDsrfVStM
 BiiAiR9A7kqEbXDY3zws6VBmaZQNmyagHSUBUu8NHlh+UpFx0ebWUWIZ26IRmrMJ7Uv0
 QqrzNTuo/AWMxm1D93sCEGJ64aoSwMhLQAH2GU3LV1k4tPViCzHpiFfciz5+Q9itTmz+
 taZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681174; x=1751285974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MgoMlu6luU8uPkDpvUPvEjZTODhHkmT/W4wpYdZo59E=;
 b=QOsqDOoI5TwvR7J+9T7TSr8cYpLmIPNQA6ngueWcijvJvRDj9a6UKvByJddoM0+Nq2
 qr6lgp7jqRqC+zKyqDflqaernRzrao5BL2rchLBVT1pksYRabkcylbIW+Dq4qX7BBdzc
 0bcsW7bLiq6AXQHuONvkGx8dGP/uCICUqoj8tKgctfXXHniLFaBYKdPMN57UX/5wNHDW
 BjNBhF5ABs+w8NzN86pq8f+gsDL2jJbecuxpyHscHonrN/0D/TpQo0G04atEQ66GM1fW
 QM7NpGcVeMLiWpUjbBj65EEYYqTs4Gcn6oI1iweoQvLG+FdcrYQFZNUV+lxWcRUJUKmx
 mdOQ==
X-Gm-Message-State: AOJu0Yw1yhlmoVWgmB6LK2VfLlI98/1aryBx67VEbxh+Fjg6yfC+Orh3
 YRPKNw56SpicoFMZ4UhYxKnhvYBzeQ0MlH4GAprg/rEipRQ1qwPK9FXcAuYaasAfrga8zez9tJU
 6LH37
X-Gm-Gg: ASbGncs2CT9rZTora7rdQCJIe5IgdRQf0nQSdBuDSn7Y/aRACVYbKhr3Tcd/v/D208O
 THIM5Zti6RqZvvr6DRsN0Tpa5du5JFOqnbkMehcGsCtspwDnqZgHbHjczqsd3HUH8cwcJ2H8vqH
 wWSPku13kO45tIUcGrVzmF5eRcSXUW/qOX6SDrkpHiA4Q2HjBnOg86Bf/KqXkQLLDu8UzQjfJ5F
 QCbBt+6efOoDizArjD9vlzSy2klWE0/pvZJzSYAluB2HFmWE9+HcN+M/gz+p0s/WMtjKOPfoKSY
 QNPugvzQgWp8vbfq8WPdqziD9S2PolYbfpwQq1hNpSv4fJxB6KCABMvpas9gRAnBOxfjXBujyRI
 HZJcKQXGA6xnMDWooprrfV0h/A2PuNPLk8ZOi
X-Google-Smtp-Source: AGHT+IH5nN0Buqju33OA312k0qD0vKiMOH8kEulBGzTvtfmPtg2jIEiKfCSnA60Z3UW/VHNqpVWLLw==
X-Received: by 2002:a5d:584c:0:b0:3a4:e6bb:2d32 with SMTP id
 ffacd0b85a97d-3a6d12a2416mr9606493f8f.22.1750681173855; 
 Mon, 23 Jun 2025 05:19:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f1054bsm9217868f8f.9.2025.06.23.05.19.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Jun 2025 05:19:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v3 09/26] target/arm: Correct KVM & HVF dtb_compatible value
Date: Mon, 23 Jun 2025 14:18:28 +0200
Message-ID: <20250623121845.7214-10-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623121845.7214-1-philmd@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Linux kernel knows how to parse "arm,armv8", not "arm,arm-v8".

See arch/arm64/boot/dts/foundation-v8.dts:

  https://github.com/torvalds/linux/commit/90556ca1ebdd

Cc: qemu-stable@nongnu.org
Fixes: 26861c7ce06 ("target-arm: Add minimal KVM AArch64 support")
Fixes: 585df85efea ("hvf: arm: Implement -cpu host")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c | 2 +-
 target/arm/kvm.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index d4c58516e8b..bf59b17dcb9 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -879,7 +879,7 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     hv_vcpu_exit_t *exit;
     int i;
 
-    ahcf->dtb_compatible = "arm,arm-v8";
+    ahcf->dtb_compatible = "arm,armv8";
     ahcf->features = (1ULL << ARM_FEATURE_V8) |
                      (1ULL << ARM_FEATURE_NEON) |
                      (1ULL << ARM_FEATURE_AARCH64) |
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 74fda8b8090..9a1b031556a 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -266,7 +266,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     }
 
     ahcf->target = init.target;
-    ahcf->dtb_compatible = "arm,arm-v8";
+    ahcf->dtb_compatible = "arm,armv8";
 
     err = read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64pfr0,
                          ARM64_SYS_REG(3, 0, 0, 4, 0));
-- 
2.49.0


