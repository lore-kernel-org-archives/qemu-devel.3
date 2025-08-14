Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37094CA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXhS-00014u-CH; Thu, 14 Aug 2025 09:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXhD-0000jx-Gx
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:08:45 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXh6-0005x7-Mj
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:08:43 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b4717563599so693923a12.3
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176912; x=1755781712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Xz5ywrXRvUgKRNtpJyxz8fg1SwzzhmCjpXpAJaxAoA=;
 b=LJ32U4ureI3Wb33fNOmeFtzovz99Q/CUhH6St/XgkUOdhhXCBgeuZk/fxzYE6ewUtv
 c/SB/HvIWLQnPf5eLzNmTQNc+DjUnbo4A9jz3+RLkhb3RzPHFFiuTwYLAjmZId279wsy
 cOBjrdvMo1CdI2JkQGBpkiSWVMPBizftCbCfhQLa4xDznV2O67HXah9xwvJEiL+vCNR4
 qhV4m/Zc39frMcN/Fd3zyXDcv6mlssGd0mMKRV8KX7lut+FyrssyT+4W8eByU8NsmZIl
 lj9rDxpXQhDPdEeSOw9kXEVlAPkde5UnexnGhKRax+sbuLod0KvJYz5E3x/3UEytSpYU
 B53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176912; x=1755781712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Xz5ywrXRvUgKRNtpJyxz8fg1SwzzhmCjpXpAJaxAoA=;
 b=deEOKOo11vh+238uf6dD4d/APQ9RODe2ypLgNqohD7GQvoOJEXhSwCuGNp3Vww90fr
 UVnkj3V5JuoKpEexC+X7lmmaBzMWpv1pV6yw0BVePoWmpT+cR8UCE9N8R9ve3ASnM9oE
 V/VqB7W+h22LWiAXPX5/TfKqT5IFEPLSUHjfHdKEThey6Z62H+zcQQW/9uIjIlpt0jMs
 25hcoGa8A0x5paf01QnNjNAmxMUtIAuxlOX6MX3YhF0VLWkIiWCsBQLbfeZEvvo2oFlq
 w77Twzij4a1zMRmqiZMEbXZX5yByHhWtDv41VT1giyhSBu7015yLm7gol3zwud4rZNBW
 sHVA==
X-Gm-Message-State: AOJu0YxFFTEncEDgNs4Nu/b1sk4n4JHigSOmfqNqr0QzKti0WTzInoDF
 +l5YAPHmtHzl5rb81HKwZnnEcpedGSsxZ0F3v0qEZHkYNJiy8wiakJHm0uETezyZb5Q4fYg94Iu
 Zv3rkS+Q=
X-Gm-Gg: ASbGnct8Dk5rdQBXMTV1X63+RnV4l+r28d5j4vXnEX6TvgssVf3NGK06RdgfsAJ1XtV
 ba7q0JnY6hOhWyqr3d88FVkJoASZlqnojkAOAFO+VYPZx6E2bZWWPHLuzoeQROhrkIRK/hHeR5r
 AcaVsuGmIy5HnNE9SC7hyAYoeZto4educ1QdF71n7Kr4lhB6OgR40l4n2Ie3uk7AcS03NkXhmwn
 hvt7EQ5CeuqktX4Bpe7Z0K/lbYyaCXMAVjsFO1c4T3HUZhQqD8M/aaKX8eoTvoS2yuGmXXZl4lB
 6YzYFO7uBhPuvPrqys0NSyhACztLnKMFb7ZQnQccDXAM6lRkjgkrdkruKAfTTGCP3G0XlEtRWkE
 ERMcKqKiusrykDnN7xCeGVtZoPSM1Lcv0iAZUcyvA9BugxGQ=
X-Google-Smtp-Source: AGHT+IH8wCgRgx1Gxdk7EVHy9Jg2RPrVCUOg3vltmvLYl/U/TpbZyCpBsGuNGBEXDGi1bMcyO7flzA==
X-Received: by 2002:a17:903:228a:b0:242:9bbc:c775 with SMTP id
 d9443c01a7336-2445871c7d3mr43166585ad.56.1755176911664; 
 Thu, 14 Aug 2025 06:08:31 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24304c2943asm64438335ad.30.2025.08.14.06.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:08:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 81/85] linux-user: Change exported get_elf_hwcap to
 abi_ulong
Date: Thu, 14 Aug 2025 22:57:48 +1000
Message-ID: <20250814125752.164107-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

AArch64 is about to add the first 64-bit hwcap bit, so we
have to expand the return type.  Since the only user
assigns this to a abi_ulong, match that type.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h  |  2 +-
 linux-user/elfload.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index e102e6f410..e1badd4393 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -99,7 +99,7 @@ abi_long memcpy_to_target(abi_ulong dest, const void *src,
 extern unsigned long guest_stack_size;
 
 #if defined(TARGET_S390X) || defined(TARGET_AARCH64) || defined(TARGET_ARM)
-uint32_t get_elf_hwcap(void);
+abi_ulong get_elf_hwcap(void);
 const char *elf_hwcap_str(uint32_t bit);
 #endif
 #if defined(TARGET_AARCH64) || defined(TARGET_ARM)
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ea214105ff..d87d1a16e0 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -511,10 +511,10 @@ static bool init_guest_commpage(void)
 #define ELF_HWCAP get_elf_hwcap()
 #define ELF_HWCAP2 get_elf_hwcap2()
 
-uint32_t get_elf_hwcap(void)
+abi_ulong get_elf_hwcap(void)
 {
     ARMCPU *cpu = ARM_CPU(thread_cpu);
-    uint32_t hwcaps = 0;
+    abi_ulong hwcaps = 0;
 
     hwcaps |= ARM_HWCAP_ARM_SWP;
     hwcaps |= ARM_HWCAP_ARM_HALF;
@@ -841,10 +841,10 @@ enum {
 #define GET_FEATURE_ID(feat, hwcap) \
     do { if (cpu_isar_feature(feat, cpu)) { hwcaps |= hwcap; } } while (0)
 
-uint32_t get_elf_hwcap(void)
+abi_ulong get_elf_hwcap(void)
 {
     ARMCPU *cpu = ARM_CPU(thread_cpu);
-    uint32_t hwcaps = 0;
+    abi_ulong hwcaps = 0;
 
     hwcaps |= ARM_HWCAP_A64_FP;
     hwcaps |= ARM_HWCAP_A64_ASIMD;
@@ -1824,7 +1824,7 @@ static inline void init_thread(struct target_pt_regs *regs,
 #define GET_FEATURE(_feat, _hwcap) \
     do { if (s390_has_feat(_feat)) { hwcap |= _hwcap; } } while (0)
 
-uint32_t get_elf_hwcap(void)
+abi_ulong get_elf_hwcap(void)
 {
     /*
      * Let's assume we always have esan3 and zarch.
-- 
2.43.0


