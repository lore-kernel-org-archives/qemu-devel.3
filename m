Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69271C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 14:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVJx-0005fk-HV; Thu, 01 May 2025 10:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVJt-0005dY-OW
 for qemu-devel@nongnu.org; Thu, 01 May 2025 10:55:25 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVJr-0005QO-TJ
 for qemu-devel@nongnu.org; Thu, 01 May 2025 10:55:25 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-227cf12df27so10357255ad.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 07:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746111322; x=1746716122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fbSBsMP5ixQP3674lJZfsVNkGgJPNW/j+NTvOfGTPO8=;
 b=SUgcmnhlSkXBq8JqcHWLBF74yhCwrbWiuPqWxyRjpFW/LgtIppscuvzg9MIqZ1VdYh
 ftNEVuRJu+ri6YRHgdSNJyMZwZPyE8UnqDz8prkthIsSFsDM6P5C/9Ro/vdoklTJmxI2
 LzhruBClTdbs2fBtBO6TLpTXCgcIk2k8NnckVvqom6QxY82YW6GKHJ+fEaD8SdJAbTax
 nvVZEN1HxVGt4bz4fXMsRfsoTEbU0AcbK/IJVhyK88IiBY7+KzF/UUBrDB/iFF47VN8K
 G5g/G75SfiBhfc104AosglJtdZwqIqULT4k+a6BPrDXfXlpFD18AGJo/AzDWVLNHJxca
 7ENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746111322; x=1746716122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fbSBsMP5ixQP3674lJZfsVNkGgJPNW/j+NTvOfGTPO8=;
 b=QzoDf+1qkxJu9cMLkA1qgOuN/7DrLbdNOA4d/6pxAjtFfEbUwrzs5SrwjzTLIGhVfo
 IRh+pJMPBx/YFcXdSzKPvMRpEERiUz5ZsDhm+0VAAAwnVdPPrhq2g9QXla32+K0JFQDD
 XdJYvkVL6t3s98XgakLF7uWl454ZGkDs01BQOtqggGsUThvHkM65njPYChfJHZzp2RSz
 /cbub1BWhUxZEfC/367RR8/617AAMai0cREafOGfh2JXq9MWJJQG/NbzNB0+DEUCotbK
 gUhUfJPMfU79GA6/i6sAtZHdJnFJq0sIwOfo3RXmlDVXojyRFJFNQuk2xk8aeiHN+J8n
 fRCg==
X-Gm-Message-State: AOJu0YwQ8fY/spU+ZBtX+iCWc9dZxhgZZrsJkKZZeKgxbVmHaVo4pFXg
 5ZfmcC20Zaic4UILLdaKiJM/laT0nOdmd+0r7VGYVA21q6nfgk80lFjuoRokc/5n/q3LlvwS+hR
 W
X-Gm-Gg: ASbGnctkp/UuSm/JRXVADJSAaCWGmHxdeksGD0VHMFlpix5Tc7lgay7Qgyrb0cG1nQR
 5x/pmfttdRYumzB7ysvW4QdcDU9eavKkvx8sq2e3dCZuZoE1t5WeXOb9QQ8/vwFN0FKvyrG4INU
 qlXS+oV6lsBcaAfqPnWe+YyssR4oUT6yT88tCJql2Tbh+y9QawV6L7imolixTJy4VUIbp+ABx4y
 fVQr0fVdUZKv2kQ8Sw+VL6qay4F/BFTE3n8OImN9QEUYzvPSlfpnqrVEOzRaVFxOo5yZbyvSlca
 nyswyk+qmPZlX7Ucce5IASiOJoqH5Yyn2G4EzxE3Lhtv75cW5D/BaxCnEAlWyuZZqEQY4pJPv3T
 i2GfHW3dpOg==
X-Google-Smtp-Source: AGHT+IFjhSGLnaDlUMbdpt1X3OyrArpYGOQ6OVgKKEsA3oVGq80nIkCBhU6+sCWg5KJmlMSislf7Zw==
X-Received: by 2002:a17:902:ef03:b0:223:3394:3a2e with SMTP id
 d9443c01a7336-22e087f7e2cmr41450325ad.18.1746111321982; 
 Thu, 01 May 2025 07:55:21 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e0bb0e770sm7644415ad.92.2025.05.01.07.55.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 07:55:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/11] accel/tcg: Move user-only tlb_vaddr_to_host out of line
Date: Thu,  1 May 2025 07:55:09 -0700
Message-ID: <20250501145520.2695073-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501145520.2695073-1-richard.henderson@linaro.org>
References: <20250501145520.2695073-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

At the same time, fix a mis-match between user and system
by using vaddr not abi_ptr for the address parameter.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ldst.h | 8 --------
 accel/tcg/user-exec.c        | 6 ++++++
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
index 44a62b54da..00e6419e13 100644
--- a/include/accel/tcg/cpu-ldst.h
+++ b/include/accel/tcg/cpu-ldst.h
@@ -515,15 +515,7 @@ static inline uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
  * Otherwise (TLB entry is for an I/O access, guest software
  * TLB fill required, etc) return NULL.
  */
-#ifdef CONFIG_USER_ONLY
-static inline void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
-                                      MMUAccessType access_type, int mmu_idx)
-{
-    return g2h(env_cpu(env), addr);
-}
-#else
 void *tlb_vaddr_to_host(CPUArchState *env, vaddr addr,
                         MMUAccessType access_type, int mmu_idx);
-#endif
 
 #endif /* ACCEL_TCG_CPU_LDST_H */
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index e1f4c4eacf..adc5296ba5 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -850,6 +850,12 @@ void *probe_access(CPUArchState *env, vaddr addr, int size,
     return size ? g2h(env_cpu(env), addr) : NULL;
 }
 
+void *tlb_vaddr_to_host(CPUArchState *env, vaddr addr,
+                        MMUAccessType access_type, int mmu_idx)
+{
+    return g2h(env_cpu(env), addr);
+}
+
 tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
                                         void **hostp)
 {
-- 
2.43.0


