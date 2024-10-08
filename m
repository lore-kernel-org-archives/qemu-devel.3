Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED17FCF042A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 22:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syJ28-0000Bm-DK; Tue, 08 Oct 2024 18:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1syJ24-00009E-Qf
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 18:50:20 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1syJ21-0003tE-4Y
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 18:50:20 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20c693b68f5so77035ad.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 15:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728427815; x=1729032615;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=61DmhqGlxZdTdu0z6XnaxhiYNNsj39PmvrjUzzuF3V4=;
 b=ClIxMuHiQ8ZZQplo231m2J5MSM6n5rHrh5T6CqPXFeekFbXo50/rgz6UdTS3M+gGIj
 af8C7+nGex19DcVZgeYXUJnJOVtSv/Q0W1bX5CEB91jD3oglJw60QDM1mItzV1hjSu/j
 caTL7dn6ET8BydJ1e0vbgdvl9FlL8imMvTElrUe6TflXsuWx1umMQ/rIwW1sn99uLK36
 uUYBa099K+1REWQmbOUcaFqlBWS3ONL12BsulxwmA5bxe87i9JsLrPa5u87WRxWALZpf
 imG2ah9an5o/mVcNCMkJ+lOE8hvMBlDyPImDy4iB4E8kylOef+E0v/KTLmThScJEFqz6
 ZaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728427815; x=1729032615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=61DmhqGlxZdTdu0z6XnaxhiYNNsj39PmvrjUzzuF3V4=;
 b=MRbWlj6VxeySXjvtpxgdMhGhTaNugYFrEH+35GF8ouhR2qW7eLFpa7cmnt+xqvQ4LS
 CviNr23ehs9RU1N3j2Re/vGk8kNn508jAWRqabE5GiBPoixCqrVsCznaSbxlUXcyb8BR
 PYIgyAUnK61HBMHmDbCHHVlMTeEZc0JofY9QDjGUBOYh8JJpAeLC3iudg+0FhP18/Hql
 0QxrmFjBF2Bf4WGwBdRA/LKIENNn+Zlfu2gobYkJ+0C/PnFHb4pqU9i6MGFTdZGcLMTO
 U6mIZEZ70xakKPXL6wiOpjpz5o8w+3UoC/L/aV+IAUeuquTV3Xm/vP7YZCN+SUk+FU8+
 aDmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx0BnWy4bFKbcEfUR1Sf/imLOXYv4O3Dwt7AVPenrWNaRslMSTU0BE/xujb5YOxB2snrRJPbWg6G9O@nongnu.org
X-Gm-Message-State: AOJu0YzaXu6teMqPedMM3D2k/cSZDxixdvpUzxolG9KUYDwgxHhHcwrz
 XRRmBwhiI6+r5qKJXBfAOJDtlrXBJb8kIX2Kp1Txzod4uf/TmzcdmbIU5jnRzkA=
X-Google-Smtp-Source: AGHT+IE60vOaedx53a6PzITj5GQ1D48k64F3az1EVTJW0qwB1jtPs1nfFd336iVlYVyxus1dOGXZag==
X-Received: by 2002:a17:902:e547:b0:20c:68e4:443d with SMTP id
 d9443c01a7336-20c68e44610mr706785ad.34.1728427815502; 
 Tue, 08 Oct 2024 15:50:15 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138af962sm60006105ad.26.2024.10.08.15.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 15:50:15 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v16 01/20] target/riscv: expose *envcfg csr and priv to
 qemu-user as well
Date: Tue,  8 Oct 2024 15:49:51 -0700
Message-ID: <20241008225010.1861630-2-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241008225010.1861630-1-debug@rivosinc.com>
References: <20241008225010.1861630-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x629.google.com
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


