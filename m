Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D0ACF042C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 22:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syJ29-0000CG-78; Tue, 08 Oct 2024 18:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1syJ27-0000BW-KU
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 18:50:23 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1syJ25-0003v4-QE
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 18:50:23 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20bb39d97d1so53773345ad.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 15:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728427820; x=1729032620;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dKczBHanLSZvcjjGDp0D2cgwbOL2pYUmrFfrlbX195U=;
 b=Dqh9sagE4RfeBPY1KnAugLT+qqbj29fFHCCoW/ectcMckjJ4on/YyU1NCI3noPZUgy
 1GNokFOWm+CR34U+1Lexhu0KvisP0D61iyV+Si7JxmYZXz5V0aVVZSoB9pogtButbeXe
 JsQ/MulqHjKr4tYbBwkU6ipeor4qjLP3MU0BlfcTDlOdDl93MibV3kfxC8e3AjCfTTO4
 iK0+fm2bWzcsZyN5Kon9/Ov8pOhTZv2z6zJ1gvDNyYm8v8FPwfDW9YWNjc5yiI3K1pvC
 LhOOOYPXmSqzpux25yTC3rYbm9o/yzSh0utkPvh5jt3K2TEnETjbL6N05JFjxKLnNhMA
 uAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728427820; x=1729032620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dKczBHanLSZvcjjGDp0D2cgwbOL2pYUmrFfrlbX195U=;
 b=hgB8zW3yokVQjqqL4/0bpDd33tddQpLKcTWafUeAaGJa+YNv/Foi0o0nNdJlzLFGNc
 YmP1QnoSbhjhLyT74uwjKM65P5HGZrLW4zSSMT7MQqxYe9UzaAsIpKRUw9+bnb9m2BcA
 augT3tDN4Umg2Qz0wUHnKA2DWjVgQZD01M9xRcxunXKiw/Oyq5NgApNW6EnTPnaHFJb+
 6s2X2rVc3qdGGpUT9Sta4MHvQy+RZ9TmacGJCYd5opwB96VU+LyD8gnGey3Emx19m1xO
 JmrAgvFcC0Yb6cLPtAGQDnMGW8cbCka26mE2xsansuZqw1pOhhg5bDeUHzLmusT6szTp
 OWsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxylnHVegLe0c6g75QmPRAhALQRLolwAq/Rr84x1qQYxitMT1eSYJfTczDwSNA+S0NNoGqSmtr/kD3@nongnu.org
X-Gm-Message-State: AOJu0Yy2mu7OXgKvHg7J24XmBQFH7Fi92fM2iZ27n9/t8QOTWoSjecB2
 ncy9q0iDcxsty/TBPh2ZoT6QMYddqoRsaW/197DZFAePxhO3XLOXhF4sOSzDLqE=
X-Google-Smtp-Source: AGHT+IE46BR6tfdcgfXmMnnlKeMaBG7fhcEqSeHADSTTNSpcuWnuYX1HlBDzwNBTsdvVRySgI+DYaA==
X-Received: by 2002:a17:902:f685:b0:20b:5b1a:209 with SMTP id
 d9443c01a7336-20c63746f4amr8102905ad.9.1728427820600; 
 Tue, 08 Oct 2024 15:50:20 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138af962sm60006105ad.26.2024.10.08.15.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 15:50:20 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v16 05/20] target/riscv: additional code information for sw
 check
Date: Tue,  8 Oct 2024 15:49:55 -0700
Message-ID: <20241008225010.1861630-6-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241008225010.1861630-1-debug@rivosinc.com>
References: <20241008225010.1861630-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
index 6c5e199e72..dc33604b13 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -232,6 +232,8 @@ struct CPUArchState {
 
     /* elp state for zicfilp extension */
     bool      elp;
+    /* sw check code for sw check exception */
+    target_ulong sw_check_code;
 #ifdef CONFIG_USER_ONLY
     uint32_t elf_flags;
 #endif
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index d7b776c556..8ad24ed2a6 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1766,6 +1766,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
index 57cef9e682..919de7970c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1377,6 +1377,7 @@ static const uint64_t all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS |
                          (1ULL << (RISCV_EXCP_INST_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_LOAD_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_STORE_PAGE_FAULT)) | \
+                         (1ULL << (RISCV_EXCP_SW_CHECK)) | \
                          (1ULL << (RISCV_EXCP_INST_GUEST_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT)) | \
                          (1ULL << (RISCV_EXCP_VIRT_INSTRUCTION_FAULT)) | \
-- 
2.45.0


