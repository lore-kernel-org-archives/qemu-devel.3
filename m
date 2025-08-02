Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60DFC87FD3
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 00:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLxN-0005RY-I2; Sat, 02 Aug 2025 19:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLrw-0004Tp-Sf
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:42:35 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLrv-0006sC-Al
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:42:28 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e8e0aa2e3f9so2765253276.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754178146; x=1754782946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mn1fK5l3yCLKQ4lorT8vlvbr/nAjsRIkl737awJXwL4=;
 b=FMoQagPF/kptnQjqXSc/DbxrJ/yzLftiH7fMIhFOT53Ll6sKsFEWZAk4YeXsxpqXTA
 Xgnowh4nOy3yqdBlrs8Q5/qbhuJDPByvk2vVrSD1dBckq6T9F/nS8ar0sugPKPpCCi95
 4plyr6cxclpw7sgU71HkQ73geV9FfZQb3ex+X4kHku6sm8Wt41/79yQFrS8BVoxV7TAo
 pqPU1pKSPE4PcTODr6KhrlfupwRyRHo8EfMCYl6bUuqM5DvoDWttiW+1uSlcmt8FSMbT
 OkpAmSg1QRqmwpCNajwDRMdbJAOXGK+qvERxagrlPbJg6SXmSl1Q/4CyhXq+REhnC0eF
 qi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754178146; x=1754782946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mn1fK5l3yCLKQ4lorT8vlvbr/nAjsRIkl737awJXwL4=;
 b=JQV0D/N7EtymaWd0sz7DJIJ5wPKjMFFt5cm8Y80U0G4aeHEEEo+r5zAoiIhVLmWyRp
 Zzr95ztRl6Sp9G+Ji7ai0cAHdB+MId/+p4dMe9L3kWy/V+MCcL1mQLql8Uuy9rpnmaYX
 LI2ryrpWQa0k4WTytEpM3+anxhbfZzSQ/z/+y8HbYTw/NAha25wTjwlzzV/qRBcW1j+z
 xq9Dr1eRFIKdQSHZhsxB/DHUi93kLLLVIm52LzOUMBW5GMbjE10ODKs1vY7t8+IamfJ1
 xN2c6vxluAF0TN9aXZZavLVqd271TV1o0oy/TZe4c6ox6ZlR3TniRz5MTLCENbcLYgnA
 +ajg==
X-Gm-Message-State: AOJu0YxMwBqS6lMVAgSuGb7kxkR9q9LWiBzshwWZrURm3SN/M0AoSyub
 wnWfCYxvqEKYYttNOFdIBaYWO4jL4GpRLGQ4g8QvgP0GlboB4V+yjexIRZ6SbSCHvRkYi/F1Cq8
 m8+/VvEA=
X-Gm-Gg: ASbGncu/UrYdXoA/Tt5TDF5co4JW9rGj87ZhwVbYuAjQS0UeM3lBkUvxFDIDlTKEWWl
 LFvHgj7Q/sv6hGmbof8gqwkVublS14DoTzzifrt4BSa4SImo//FzUfX/O6v/Ni+d6RTtgA0pFRn
 x9r4cMtrkgANcgpSBaOOp/TL7JyjuVzcpoOBPrjKDd0j2Rxd5b/0b/IRAw43igHTbKPdKADGAbF
 pAhe3zksrSkSIx+1cRiZ2ymWeo413oSBowD+97avFCJdohWo1QufGILw7TIMMmQ1aIq2DrFOBSd
 a/c7a3WbGdu1qo0D7/rtBoTUimhxI2voVyutPVjs0RrvcUfzowx+GP4E4AGEww2j3khX77EiaA9
 OkvsxQM8GdvD83zn79RDKs5HDsWhtRE7HLsDhizCywoVpDuFIp53OlP/l2GojOjg=
X-Google-Smtp-Source: AGHT+IFOq8CxVLu0H363YNAcS5STFfcNfrykWc7MhpYsZbR2WCOwTRF5jFjICzn/kIuETJ5Bg7eyig==
X-Received: by 2002:a05:6902:4388:b0:e8d:72d0:9733 with SMTP id
 3f1490d57ef6-e8fee1ecb03mr4836191276.32.1754178146249; 
 Sat, 02 Aug 2025 16:42:26 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-71b5a423f38sm18461527b3.40.2025.08.02.16.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:42:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 81/85] linux-user: Change exported get_elf_hwcap to
 abi_ulong
Date: Sun,  3 Aug 2025 09:29:49 +1000
Message-ID: <20250802232953.413294-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb2a.google.com
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

AArch64 is about to add the first 64-bit hwcap bit, so we
have to expand the return type.  Since the only user
assigns this to a abi_ulong, match that type.

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


