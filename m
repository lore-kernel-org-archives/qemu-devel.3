Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAF0CF34BE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 18:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swQeM-0007C7-47; Thu, 03 Oct 2024 14:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1swQe8-00079g-3e
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:33:52 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1swQe5-0004r6-Nz
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:33:51 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20b7a4336easo9116875ad.3
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 11:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727980428; x=1728585228;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=61DmhqGlxZdTdu0z6XnaxhiYNNsj39PmvrjUzzuF3V4=;
 b=sLt6YP/RwUo1to8+zstg7Uob7uVYaXz5GVX1XYxJh5pdPVa8uuatNiiKBASLwjiGvb
 N8MRzzvPHftmB7J4L1QwWQ4+gi3qJVTZtgzpImuvRsfsrMKETyxuW3Nz1AqIoygA78NS
 rF4pPopo9NTABY519SbWW3XoX7b+GlyYeoDMrQyx6aYfHMnEmQaexKOnWl4rqLdaF9RD
 hebQwdaa5come12xhpKoXM5Rq3u9f14KMfMql9GFV8a8etO47zn38YD8bTFkIyhMkW4o
 8120POL1wKmBGFDn38OFyWWc2ccfbkmE2C405HMnMAJ0UoeJf4qutruhaochf8iFSgD9
 vXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727980428; x=1728585228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=61DmhqGlxZdTdu0z6XnaxhiYNNsj39PmvrjUzzuF3V4=;
 b=S+hIJ72zqx4EfFREAE4SR4JeS2MNFrmKfzCzJsl1RT1iB0sGPe+hPAhtJdZgSyEalI
 PH6qKODKVYareLfdlk+cT5avFAP4YU/3+Zm641qvr74xNLML1JIs73XDNkZV1KqNQKmD
 QFv/KoxMUepvU5cq/j0zeF0uuHFXzpnrTxJ8Fbbzx5VjLQYMqBWNgkNhnVkaTF7NhfVu
 DSgQ3jaijrIocdpSDNkg+ZSokEIxDb8duAukUkfWMBbGIRGNXgtZMX5z5dB7j6BWi5to
 OCYGlFwA5CSznhrVnJz/f5/UdkzfG55sleL3AzMG60Wt8K8thQJTZEEUfI5y0TgrjLJg
 i+9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3YM0MIHwdi7idr0LsgNxZgXO0uqc/vpbrbA/73umMdC5/zW9B/RftmaHSlugG69hmVQmFJ0gZ4A3j@nongnu.org
X-Gm-Message-State: AOJu0YzCxt3NSfT+RUNcqvxa8QXBhkLchoWhn5DlyXeWQ4tsU0+7cRQD
 n29GXMcjZdnpR/+mgi4/DMIrQa/GPHqJvQl8R8Kd0C/aCRfkl9HLiEIv2+InJzauJwduPXSjgs5
 e
X-Google-Smtp-Source: AGHT+IFHdojLysk0kiPQ8c2xfJDeSL4ZBTFyJN5pnu6nNEn45E1lZ9MYevDkhkTEm62GQXgJcJx3Eg==
X-Received: by 2002:a17:902:d48a:b0:20b:57f0:b37e with SMTP id
 d9443c01a7336-20bfde583d2mr1965695ad.1.1727980428551; 
 Thu, 03 Oct 2024 11:33:48 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20beefad16asm11796245ad.193.2024.10.03.11.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 11:33:48 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v15 01/21] target/riscv: expose *envcfg csr and priv to
 qemu-user as well
Date: Thu,  3 Oct 2024 11:33:22 -0700
Message-ID: <20241003183342.679249-2-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241003183342.679249-1-debug@rivosinc.com>
References: <20241003183342.679249-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62d.google.com
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

Execution environment config CSR controlling user env and current
privilege state shouldn't be limited to qemu-system only. *envcfg
CSRs control enabling of features in next lesser mode. In some cases
bits *envcfg CSR can be lit up by kernel as part of kernel policy or
software (user app) can choose to opt-in by issuing a system call
(e.g. prctl). In case of qemu-user, it should be no different because
qemu is providing underlying execution environment facility and thus
either should provide some default value in *envcfg CSRs or react to
system calls (prctls) initiated from application. priv is set to PRV_U
and menvcfg/senvcfg set to 0 for qemu-user on reest.

`henvcfg` has been left for qemu-system only because it is not expected
that someone will use qemu-user where application is expected to have
hypervisor underneath which is controlling its execution environment. If
such a need arises then `henvcfg` could be exposed as well.

Relevant discussion:
https://lore.kernel.org/all/CAKmqyKOTVWPFep2msTQVdUmJErkH+bqCcKEQ4hAnyDFPdWKe0Q@mail.gmail.com/

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 5 +++++
 target/riscv/cpu.h | 9 +++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 658bdb4ae1..24ca0bfcaa 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1003,7 +1003,12 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     }
 
     pmp_unlock_entries(env);
+#else
+    env->priv = PRV_U;
+    env->senvcfg = 0;
+    env->menvcfg = 0;
 #endif
+
     env->xl = riscv_cpu_mxl(env);
     riscv_cpu_update_mask(env);
     cs->exception_index = RISCV_EXCP_NONE;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 1619c3acb6..2623f6cf75 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -234,8 +234,12 @@ struct CPUArchState {
     uint32_t elf_flags;
 #endif
 
-#ifndef CONFIG_USER_ONLY
     target_ulong priv;
+    /* CSRs for execution environment configuration */
+    uint64_t menvcfg;
+    target_ulong senvcfg;
+
+#ifndef CONFIG_USER_ONLY
     /* This contains QEMU specific information about the virt state. */
     bool virt_enabled;
     target_ulong geilen;
@@ -445,12 +449,9 @@ struct CPUArchState {
     target_ulong upmmask;
     target_ulong upmbase;
 
-    /* CSRs for execution environment configuration */
-    uint64_t menvcfg;
     uint64_t mstateen[SMSTATEEN_MAX_COUNT];
     uint64_t hstateen[SMSTATEEN_MAX_COUNT];
     uint64_t sstateen[SMSTATEEN_MAX_COUNT];
-    target_ulong senvcfg;
     uint64_t henvcfg;
 #endif
     target_ulong cur_pmmask;
-- 
2.45.0


