Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DF1C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbTU-0002nK-Ge; Fri, 20 Jun 2025 09:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbTS-0002id-C9
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:08:06 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbTQ-0004bK-6G
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:08:06 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-442e9c00bf4so15034255e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750424882; x=1751029682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DHkUxhiwznLnPGQ7CmoJiivDkUiQkmNfBetsY13UZBg=;
 b=mzU5OT7wO27hiwOCswg96hP1vq46euSOASpTsIMB5hASXGmQJExy9ebNWCYAHU3rUg
 IwagJOjAE2HukMuWgBfh0TIf/KT0QjQBVNJY5ZDicQFC/kBL60TJQR13Kj1roE5AjKcY
 heuWOBFLz6L8L0dkJHF+8GAMqAgvJcpRSCpSFpYaeHPZJmwa947fq+I+oH0NdTQCWNC+
 ZDrYAQvmnD2bE2AqXnqGqbu3viwzpQw+KfHY3dz1wiaIte5KWKoYwVu9rY6NWVe7uBud
 p41Rb/cuKvo7A/cYbPdRLsGUWZdUkMnppclajLHwEFqM0y7uSH2iJSzCw/5shN/85Ml7
 dFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424882; x=1751029682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DHkUxhiwznLnPGQ7CmoJiivDkUiQkmNfBetsY13UZBg=;
 b=l1Mchcu1U+IoQeDRLR9EYlwfrNU9GE+OKgu/3TrIgpr3CyX+clVZ+bSHySceql2YUA
 C95BiNmfiMAqHdazcdh5kazChiL0l35PTWqahM00NozBGWfLsV/5XZzB+5YTuCSIcmg8
 CXNi6MGTO9Cdjh6RuOcwk/bnIPClaMV470033ev6LefocIcJ1DH6BwIYwXT5M9Nlcl3d
 B9LOPBqHh4ZKaqGCdb6HLOlNUwfcBAZAeNtwr2rs3jAqfg0FuPY5isz0tUU+xMANGMJk
 PNy0Ru+XHUo91Q8Ma/BXV+04xMAkAzSbL0Lfy44DMQLig61keHSKxkqT6eDNLYQz5pcU
 HzfQ==
X-Gm-Message-State: AOJu0YzwvsNIj5OzKKcRUigv/uARlETdJ36d0MCvrfdyMBCkvSQWgsAp
 dBslSGQvg2RYEN8QCzL8eeRaJmv2JaZZhWY86CdrVBqNXDGyTSBXf3StDNFa3CZdCZEwb9yY8mK
 kcjlMad4=
X-Gm-Gg: ASbGncuP6d8nCkLJetZt7sc10gXOOLb1cbLtRRe1ZNfpvDLvoCcClMCkv3QTFaH5nl6
 FzDutaCpLcMrQ5xVCDrjpZnBKRvw/Kh0gsqDbZ10/5mac9DPUDLF8zjHNXiZOovKY/eUuotRz7T
 e6bbhJz4KaBbhSHLqOE+7KF6nZ4MHeV6GsyzacP2RqJ7PwjYjpHHPSayrIR/nu7FBn0bvru+vAx
 YhJLelwZQsjGJCGEchq0CuVrtm7/2SnVfx0MDH4E/R85lFNzxWgVWBb3To/8VIAR5hk5jAjJ1uN
 cvclif4qPVR1/A1H60O6piSGRl3sy2b5XMN5o0GEOhVVgkF5FIt3q+C2q4FF8706J5zcWjNirJ5
 tOGkRxhpRRAyXIK52FPK19XayZImuTDGWNkFw
X-Google-Smtp-Source: AGHT+IFIRA+QgEzXaz5Kv5aRlxYuLkZKTx/pYgPZDxWBgIRvFsRGsi3xvxXp90rTSlKsbLeeXas7Hg==
X-Received: by 2002:a05:600c:3acf:b0:440:6a37:be0d with SMTP id
 5b1f17b1804b1-453655c3d4fmr28644125e9.15.1750424882015; 
 Fri, 20 Jun 2025 06:08:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535e98b66asm57984935e9.17.2025.06.20.06.08.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 06:08:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 09/26] target/arm: Correct KVM & HVF dtb_compatible value
Date: Fri, 20 Jun 2025 15:06:52 +0200
Message-ID: <20250620130709.31073-10-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620130709.31073-1-philmd@linaro.org>
References: <20250620130709.31073-1-philmd@linaro.org>
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

Linux kernel knows how to parse "arm,armv8", not "arm,arm-v8".

See arch/arm64/boot/dts/foundation-v8.dts:

  https://github.com/torvalds/linux/commit/90556ca1ebdd

Fixes: 26861c7ce06 ("target-arm: Add minimal KVM AArch64 support")
Fixes: 585df85efea ("hvf: arm: Implement -cpu host")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


