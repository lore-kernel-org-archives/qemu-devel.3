Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D75C369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7krG-0002xl-EP; Wed, 23 Apr 2025 20:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqW-00013G-4G
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:45 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kq6-0004hr-KV
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:20 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736dd9c4b40so1421447b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455997; x=1746060797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mEj8DRwl0sBMiNx3GlTORUB7tXRrga1o2uCtdvfn7gU=;
 b=lGK5yn4BNnDPULebW/lHfzqbpycMjKm0wvJjkjEsaxsJOE/uKyM6fut/5ckXTJPpTe
 QMnHu7khFeSjwwR8ahSkpN762OuUboPM8FPBK4AORyODM8Tw4Ln7qUyUKYuIQwXGDmB+
 7enE5SRbGP1qxEY8FNFfnaDLlVw3zbgcA5zTktPafhNdG0YrWiE0ayXHuyAwbCcBrAPp
 tyWVexiznkYCbPwhrxOEBp6o9spfl1LzIT0hvUrM55pXQ1nhPSeQoUa/YOXpqd9rVp9U
 JLjZYeM+nNslXbJj5QzISy52bQKfyferm8fSJyUPKKzVrSoCG8i4QhMcD54wQlPDHpUj
 ANgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455997; x=1746060797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mEj8DRwl0sBMiNx3GlTORUB7tXRrga1o2uCtdvfn7gU=;
 b=d33k5974ScUJAS6sa8oLykdTdj4tmAQKTm6gtm+sYcrueXVE/Hkr83PBCtplTOv1B/
 BsUT5eNBi3gtsWoj8xWX09B7f76yYdrvBafkegWIXNcMXeHVuaqoVPmg6kgs0lvvL8A7
 S2gABMbL/OnOUlan4ekfrghuIMl2O89DU483HpseGfGvfqbOGiP8zTdipxT5/Vw7ACcY
 VZfSpn+WgdNIqz+G5Wd1MZzHR0/6uN4agkyAQFkjSGk2o+RrWlpzIEiS0VhspuI0lWj5
 nxBr9PcQmjrGSUe3Pa/0+Oaa5YGsg13rJdilA02dyCMqOF0F2kkeez3JnOB0DjZjxyGG
 wyfA==
X-Gm-Message-State: AOJu0YzSP39G/VmYyDN1THa8Cuyn6H1opYwwHEjjW2jY9mNYpVcn50ia
 xsP9sUNv0uWWZjEE5vNs5zdvCFeB9/oR/wI02aT4Y6W440n/OTTRtAv1AJQQU9Nce9vXK4dRJDC
 C
X-Gm-Gg: ASbGnctLOD1PyWNx/8b2iznAcCbFT98+pU3XSVrcI+qMtcmkTbE+Y/n4Gtr3wCIj3ft
 r5jFXdRnz9lUbRBcPE/Mz+ly9aO0MSvoJqbXEp+02XdJiQUnrzRXfJ3Vno5CqxEGCXTN6r5umn+
 CtE6yt02l8glo6jOJrqw8TlAi6J2pI+DM3TVLRjmW+wd+FV66UBKOId9Pwrewx+QN2kekB7tZNa
 X5jz5eM4XajNmsr7flFm2DyPU8S6DBW+wV7sRPurHm7+2av/Jts9JxFE+Eec9iRCXW1OFE3KnhI
 qQhMLwuRj3fus7yO44OD7OoAEnMcPId6OZmorpuaX/qI/CVGCEJaKCKf2fVM6el195C8UjFSyyE
 =
X-Google-Smtp-Source: AGHT+IFFvgCDWXxIT7KQmJM5OE4pMgMYaQN+VBUclz1GlDS8wEFab191zZS1ugch7pYzpt6g1mal/A==
X-Received: by 2002:a05:6a00:8104:b0:732:5875:eb95 with SMTP id
 d2e1a72fcca58-73e267e0e51mr570715b3a.4.1745455996901; 
 Wed, 23 Apr 2025 17:53:16 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 053/148] include/hw/core: Drop ifndef CONFIG_USER_ONLY from
 cpu.h
Date: Wed, 23 Apr 2025 17:47:58 -0700
Message-ID: <20250424004934.598783-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

We were hiding a number of declarations from user-only,
although it hurts nothing to allow them.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 37cb7d1531..6dcee5d0ba 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -614,8 +614,6 @@ extern bool mttcg_enabled;
  */
 bool cpu_paging_enabled(const CPUState *cpu);
 
-#if !defined(CONFIG_USER_ONLY)
-
 /**
  * cpu_get_memory_mapping:
  * @cpu: The CPU whose memory mappings are to be obtained.
@@ -676,8 +674,6 @@ int cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
  */
 GuestPanicInformation *cpu_get_crash_info(CPUState *cpu);
 
-#endif /* !CONFIG_USER_ONLY */
-
 /**
  * CPUDumpFlags:
  * @CPU_DUMP_CODE:
@@ -701,7 +697,6 @@ enum CPUDumpFlags {
  */
 void cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 
-#ifndef CONFIG_USER_ONLY
 /**
  * cpu_get_phys_page_attrs_debug:
  * @cpu: The CPU to obtain the physical page address for.
@@ -758,8 +753,6 @@ bool cpu_virtio_is_big_endian(CPUState *cpu);
  */
 bool cpu_has_work(CPUState *cpu);
 
-#endif /* CONFIG_USER_ONLY */
-
 /**
  * cpu_list_add:
  * @cpu: The CPU to be added to the list of CPUs.
@@ -1136,8 +1129,6 @@ const char *target_name(void);
 
 #ifdef COMPILING_PER_TARGET
 
-#ifndef CONFIG_USER_ONLY
-
 extern const VMStateDescription vmstate_cpu_common;
 
 #define VMSTATE_CPU() {                                                     \
@@ -1147,7 +1138,6 @@ extern const VMStateDescription vmstate_cpu_common;
     .flags = VMS_STRUCT,                                                    \
     .offset = 0,                                                            \
 }
-#endif /* !CONFIG_USER_ONLY */
 
 #endif /* COMPILING_PER_TARGET */
 
-- 
2.43.0


