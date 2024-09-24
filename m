Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC57CCF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDsa-00019h-9t; Tue, 24 Sep 2024 18:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDsY-0000rm-I8
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:19:30 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDsW-0001iy-UR
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:19:30 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71b070ff24dso638592b3a.2
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216367; x=1727821167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mjNXzgiEWyVyuZjYAU57+xA7vgC68VppCOY2z+wCZZg=;
 b=QOoR1l86deqhLHRhaEAZn+g+59L1ZLO/f9yjsYkitpLC2cEIB7N2qhD6Y2xmVbZFzf
 xqib7iYH+Qsv79A1g/XR5JHVEbDBDhatRmYirQnzGRpupQn+kHwec9U57n5Q5WOecsTf
 PJQuYXZyZ2pLt2Y6ExHypUZMeSs/+Ayh+WaxOoFFuzQdkr2jU5Ua9YYh6kJIqgTLKutA
 yWJeY3o7xSufQKHAG1Ee1as2xL7I6KJ1VeN2WOdNdWYx2/rEP2EfbOpzRe89mBaY/FS9
 LbxoM2CA21mAiRUgp3JSSprKzuJg8HiTNbW10RqmBaQxI+j60wFwL1r5l9J3fRfpr9dE
 qXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216367; x=1727821167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mjNXzgiEWyVyuZjYAU57+xA7vgC68VppCOY2z+wCZZg=;
 b=k95dnJgQ57lVxdYLRKMAuVVqZt+MSbDTZi7UED+a1nbwTQxfngCd4pJDAtDQ6HV9RL
 Mei5FZkoeGZzSAsfGBS1me8fZKSbzAcEoW2TICMNqWTwLVOfoUbULgKojGTmWMAaMsC6
 6FokMXOrBnJPFIIheP7wqJ4II0wU2fAMscAqSz3+rrMxDhOcj0ori2sZaljVjRKTfvsc
 5RX10JFbWoJFFeE9Nuk6jl64u2Zm0XMHXkvlm45ZJhlQEg7SKnWwgq2x3CPbEgzKGOPX
 X/KZyFK7HMWe7B6aCS7YoxQzLcimrCYZ+d010teupqmFiPRzPLNocxzUfQIXd5vk/J4m
 x8Sg==
X-Gm-Message-State: AOJu0YwlCgUfSSqTdSM3e+6UQ/YiILrBfj2yRcbYpvn4WEWpZC0sA8UG
 UWze+Fmm1BsK8JG19A6MR4FBdcS/eUrcnKqWrUbH02fhsAICO0nB097GNw==
X-Google-Smtp-Source: AGHT+IFdRpmdugdwvp57HsPTPeVPN1/oNiyZfgPBsGeFbmr6zL1qxKQ4n/ui4O6subbvgVcReOM2Kw==
X-Received: by 2002:a05:6a00:8315:b0:718:d740:b870 with SMTP id
 d2e1a72fcca58-71b0aa95107mr865510b3a.2.1727216367381; 
 Tue, 24 Sep 2024 15:19:27 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:19:26 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 28/47] target/riscv32: Fix masking of physical address
Date: Wed, 25 Sep 2024 08:17:29 +1000
Message-ID: <20240924221751.2688389-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Andrew Jones <ajones@ventanamicro.com>

C doesn't extend the sign bit for unsigned types since there isn't a
sign bit to extend. This means a promotion of a u32 to a u64 results
in the upper 32 bits of the u64 being zero. If that result is then
used as a mask on another u64 the upper 32 bits will be cleared. rv32
physical addresses may be up to 34 bits wide, so we don't want to
clear the high bits while page aligning the address. The fix is to
use hwaddr for the mask, which, even on rv32, is 64-bits wide.

Fixes: af3fc195e3c8 ("target/riscv: Change the TLB page size depends on PMP entries.")
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240909083241.43836-2-ajones@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 395a1d9140..4b2c72780c 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1323,7 +1323,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     int ret = TRANSLATE_FAIL;
     int mode = mmuidx_priv(mmu_idx);
     /* default TLB page size */
-    target_ulong tlb_size = TARGET_PAGE_SIZE;
+    hwaddr tlb_size = TARGET_PAGE_SIZE;
 
     env->guest_phys_fault_addr = 0;
 
@@ -1375,7 +1375,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
                 qemu_log_mask(CPU_LOG_MMU,
                               "%s PMP address=" HWADDR_FMT_plx " ret %d prot"
-                              " %d tlb_size " TARGET_FMT_lu "\n",
+                              " %d tlb_size %" HWADDR_PRIu "\n",
                               __func__, pa, ret, prot_pmp, tlb_size);
 
                 prot &= prot_pmp;
@@ -1409,7 +1409,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
             qemu_log_mask(CPU_LOG_MMU,
                           "%s PMP address=" HWADDR_FMT_plx " ret %d prot"
-                          " %d tlb_size " TARGET_FMT_lu "\n",
+                          " %d tlb_size %" HWADDR_PRIu "\n",
                           __func__, pa, ret, prot_pmp, tlb_size);
 
             prot &= prot_pmp;
-- 
2.46.1


