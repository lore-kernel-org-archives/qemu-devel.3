Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406ECC5321D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 19:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shZXs-0003Oo-7b; Fri, 23 Aug 2024 15:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1shZXl-00032a-Lf
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 15:01:54 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1shZXi-0004IB-OF
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 15:01:53 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2023dd9b86aso18788745ad.1
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 12:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724439709; x=1725044509;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NjZJpddrUYMLka+s3BuiKelWfoIA0sOQqw+ndLoWex0=;
 b=0bXbe/2LBdJFWFPrqfLZS5aaIG/U6qsqqQoSZ1jfOJlKZWzn7Ccy51axNaJU5COpay
 QPFZ5QATn0Ujx672A28e6sqigQFxGdMmH0fzJ3ossa/8nvVcfpB/ShE7507Y25yMmMse
 onBQbdYJgf+R8uqUsT3Vom7fKQSqXd2cPX9gD0nAwZ1gN2EmoEuKPdww26LxQJAqTpFO
 2543RitDnfL0rJnwx2g4PywhHNGv5FxUB6/z8YhJXR5/2/MmIV0nLqD3OmBeceJvoHuW
 ybjtB+Nj7w5Bn/7f5VNWIuKFikqzCnU2HpI7tlpa48W+Z+TSTGzjQpq6C+482UzqTi8l
 1Tsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724439709; x=1725044509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NjZJpddrUYMLka+s3BuiKelWfoIA0sOQqw+ndLoWex0=;
 b=cDJj8Kzf/NEj6kF6reA9zES4hJ290MHTIEDmQfUgDVCDswvtQzkugxrAx/kh4WyUpI
 oObuv3DJC+eTZ6Ry6rKde0fw1A9Tnl88cGbXhr9vz58Ec3Dz/AppoWIxdEKRDtCmbXI3
 MkpmUfnykGoBP6UtnYSzUtUZqJBVKf07yoK5DU32DHVgsk0eTXU2IQSslJupD6kFmm5h
 qvj06WxW+lSZ1h/0Gfb74P8BUCAyBDIKBRuj9F1WpDf4pQv5H+/vD9kWR+wKUBkhhj+z
 JJ5MDJHF8Oe29J6nKW5CwXWNNbBCsw4U2eK9RMhia1S2LLspBKzPie4njhjNaeq6IIxR
 2pEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNLUcCLsQ4D2IPSavVo3UGw5RbpnSfN10boGb6V53WSYC1YRnyEZP2x20wOc0F3syy6lBvuS+Wi7+7@nongnu.org
X-Gm-Message-State: AOJu0Yy9FtkShoZDh2ZlYPGPrM9th4yG/u2NrvC5PLHQD3EDZ+W1yWHp
 oWiEV3G1hOk0n2l7/zUdQiL9ie91RQ1JX/IIuuHr+p5zExhvU6whrd9YZ6CiBLE=
X-Google-Smtp-Source: AGHT+IEmnqrRRuWv/NERGqYzBO69Ibbq5tDkFQ0ipIEJkm4K2PhUoLDhR5ZIy2iBBeL7wrdCDOxElw==
X-Received: by 2002:a17:903:11c5:b0:201:f18e:5077 with SMTP id
 d9443c01a7336-2039e50d411mr29667755ad.49.1724439709145; 
 Fri, 23 Aug 2024 12:01:49 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203b0c37768sm1749885ad.230.2024.08.23.12.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 12:01:48 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 richard.henderson@linaro.org, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v8 04/17] target/riscv: additional code information for sw
 check
Date: Fri, 23 Aug 2024 12:01:26 -0700
Message-ID: <20240823190140.4156920-5-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240823190140.4156920-1-debug@rivosinc.com>
References: <20240823190140.4156920-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62f.google.com
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
---
 target/riscv/cpu.h        | 2 ++
 target/riscv/cpu_helper.c | 2 ++
 target/riscv/csr.c        | 1 +
 3 files changed, 5 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7be0fa30f7..11c6513a90 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -224,6 +224,8 @@ struct CPUArchState {
 
     /* elp state for zicfilp extension */
     bool      elp;
+    /* sw check code for sw check exception */
+    target_ulong sw_check_code;
 #ifdef CONFIG_USER_ONLY
     uint32_t elf_flags;
     bool ufcfien;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 12484ca7d2..9f08a67a9e 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1761,6 +1761,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                 cs->watchpoint_hit = NULL;
             }
             break;
+        case RISCV_EXCP_SW_CHECK:
+            tval = env->sw_check_code;
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


