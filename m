Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F33C54744
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 23:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj5TB-0002yu-VI; Tue, 27 Aug 2024 19:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj5T9-0002sS-B5
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 19:19:23 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj5T7-0000qw-Je
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 19:19:23 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fec34f94abso62746785ad.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 16:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724800758; x=1725405558;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zfvLnj6XNfSIT8sSl0+fnX4A6Nm3Jxdidu50F7PUqy8=;
 b=XmVaZ2qW4F4jwE2NtpsqyPU1jEN2pzHRR199GA/duOlkiq7FK+ZVAKr8sKOv8/au84
 7sz7RkbwAQJABXwxikApYynNhWpWzL+tC7pUj7Gyk7H7FuEyZtULVW1lDCIx+e0oDeWB
 sMuGUQ+xB2ivYsqwiqeTEEoStSMO8sO837tcRcyg/ut+6BzUO7SP/7t57hQSvaWFlZIv
 2qgV6sxl/Mbb542/FSlcG5fxqKII3dtJVON/UkeoHU5VOLT4SgIQ4ltE3jDg6X6LiYnp
 V5eQ1lRxt3cEElheozZOWypuKi278S9qV5rdNo1lTWHj9jR+k0i9hH1j5uBdvKA2QrfH
 Cdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724800758; x=1725405558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zfvLnj6XNfSIT8sSl0+fnX4A6Nm3Jxdidu50F7PUqy8=;
 b=I/OjbkqSHK+ZHCHvsPD+HGJFcTW8MUmNnsSBCExxUzNCCgKU0oFtliZpaNvhawCqIE
 NvdTjo+7FQIkVzu2ybYgoschME9Oqay2RyLqNEXFj4UNdBi1HF1KmgqsGfgjXy+1unZz
 tKgLWE0z2bABwckqMTXSl1IMLnn2luX9SR5lgifUx9+qMSd75BvERvKCyuSqkWULBxTU
 CzvrqPEEzstc3zSHKpF6qmh60CIMUgCHjCYw3MctUBh0T1/xLsElX5Ju7RUSWRJ+1Ggw
 w1TOWCXCYhWzj5f4ym91SZltkJw+eU+ReIql8h56FQQfOBdlnry7xBxU6X36rBj1qm9u
 bP2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV42+BsNMu7xddQ+WVHsRoWFsYpr6I0p7i7RM51tyISUNCcyPxC0UShRvRPNprCeJwGgMCcFeJjFQh@nongnu.org
X-Gm-Message-State: AOJu0YyjswqSj6nw++ZCQ+Cx6te4AFZcAmBurZ33pT/UiRNopNOkzAdB
 Zk+TkpOZrAy0wXqncPdJRzAyXt74GCb4pX+ElnvSXUMrOKYMNCgRjMBWndQK3HM=
X-Google-Smtp-Source: AGHT+IEPE65G+n61Ae9A0ikXCgWRNT68qIhkhH4nzikUEGjAPGpWmeUVc7lFmr+YjU9FY4ZQMN3O3g==
X-Received: by 2002:a17:902:e842:b0:1fb:90e1:c8c5 with SMTP id
 d9443c01a7336-2039e4b5193mr116545135ad.33.1724800758168; 
 Tue, 27 Aug 2024 16:19:18 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203b0ee6179sm57785155ad.92.2024.08.27.16.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 16:19:17 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v10 06/21] target/riscv: additional code information for sw
 check
Date: Tue, 27 Aug 2024 16:18:50 -0700
Message-ID: <20240827231906.553327-7-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240827231906.553327-1-debug@rivosinc.com>
References: <20240827231906.553327-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

sw check exception support was recently added. This patch further augments
sw check exception by providing support for additional code which is
provided in *tval. Adds `sw_check_code` field in cpuarchstate. Whenever
sw check exception is raised *tval gets the value deposited in
`sw_check_code`.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        | 2 ++
 target/riscv/cpu_helper.c | 3 +++
 target/riscv/csr.c        | 1 +
 3 files changed, 6 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a7c970e70c..a0f14c759e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -224,6 +224,8 @@ struct CPUArchState {
 
     /* elp state for zicfilp extension */
     bool      elp;
+    /* sw check code for sw check exception */
+    target_ulong sw_check_code;
 #ifdef CONFIG_USER_ONLY
     uint32_t elf_flags;
 #endif
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 5f38969aa6..fffd865cb4 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1760,6 +1760,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                 cs->watchpoint_hit = NULL;
             }
             break;
+        case RISCV_EXCP_SW_CHECK:
+            tval = env->sw_check_code;
+            break;
         default:
             break;
         }
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5771a14848..a5a969a377 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1179,6 +1179,7 @@ static const uint64_t all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS |
                          (1ULL << (RISCV_EXCP_INST_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_LOAD_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_STORE_PAGE_FAULT)) | \
+                         (1ULL << (RISCV_EXCP_SW_CHECK)) | \
                          (1ULL << (RISCV_EXCP_INST_GUEST_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT)) | \
                          (1ULL << (RISCV_EXCP_VIRT_INSTRUCTION_FAULT)) | \
-- 
2.44.0


