Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEBEC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 18:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKLlO-0006Uy-Gs; Wed, 28 May 2025 14:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uKLlD-0006N8-BN
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:44:20 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uKLlB-0000NH-Nd
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:44:19 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-5259331b31eso32113e0c.0
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 11:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1748457856; x=1749062656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N1EvtJG5mNTqGGcNevZ83Z0Oy3cFvMJyHR4hO17x8rQ=;
 b=muuGdoASU6EQL6LZpMZy7CNxcnQXGB7lxVcHPsXIsJ/MZhTqyWSierFP2HEcfelYcs
 neEFuMMgzkVSda3yjmWWndlYvBMhAxT3Ujy2EE7okivh4D1N+p+5TzXqjPS6CAqSqam7
 uZMB6ioWQuWwz1UDfTMqIy9tkukDaCXu0pXqc3L7JIEAeNG05Ur+6l/Kcxb7Io2DqVMR
 3Wmm9BZJQvnEdUpwdm0QM7g9rMgTaG2HnjT4+tkFpLFWGUop3XYn1vd+rv+BfxdxInSf
 GnQbCUbAdIjL4f3KVcOWqcMidNyqzgr+7C9oyZEBrjws1U8kSxPl8bi1pDD0P/zlEkAu
 MIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748457856; x=1749062656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N1EvtJG5mNTqGGcNevZ83Z0Oy3cFvMJyHR4hO17x8rQ=;
 b=EwMGyXxE3VjhuIx+cxI//2RJNeZs1bvbE7d4DS3tSjyJ2+i+EWan7WRkUYk6zcMmxy
 cJJrkQm3dTeRnaguhWgBJLufnWZIPZX4e5QCPfog2h1slMxAlbQaXWGsURbbZJRva+t0
 yn9b9HDwI0SWrLb15+FGHG3QU7pdxepb+xCIa+Bxqu9+gCJTSBEyDY38buHBYzH9+Qfn
 99ii9sFfJfkRTrjrL8E0cv/NobPv/++Qq/VYi4OrKg3fMHGPoj/H24WPqmFBd0ceLPh6
 XRRopP2nKrhovYbLhFZHYtq2aV00H1hNAvAM+bDE2xNbBi7wqblWjT8vChKMwkc0PBPu
 4xDA==
X-Gm-Message-State: AOJu0YwzMrYzCCgEAHNjWEUM/ImDjc97ob6hczmPW4IFw3LTk+YSOZbg
 a/dEnw01F7c80LR69X7BAsozEUuYNjeTqe8wBA1qZ1d5ugNhGK8hHMwAtSqgbWalkBlVNGHVYvU
 re5qc
X-Gm-Gg: ASbGncsxFKQRqkxEVwPMjLjEGh55CeBc3jfAaI23QK83cAYQOhHL9aJHnLmpJDRDQSu
 B8PzU0azuTfmC7vIqOTBu3+AwVjUuUEa9CIe7bB2UeGnTE8Yf2sNJNj0RgyctJPbRvn4XU3JJGf
 BcLGGtYzGMgLiDhhbDySFBFjg9Ob7HYwWvrEFGuBUlbdw/SRkPFwduiLjJ/nIabTTtd5/5HV3IR
 lI3GWtcdKo6TJvilFPsgVaD50JV0PZY/07LsSaes+A7fph1HPB3yAJhU8XJSx2S69z5uVn3Kll4
 XgItOH3NOt7MuYzdwcfZ1lZTNEh7MgCa7267dtQROl04CGDE7hWnng==
X-Google-Smtp-Source: AGHT+IEZsqzOu2500pJHUdm7HK5pcS8IkH0h3efbu7mqBCrgxiKayChMsFZfot6DUH6UBJR9vFmMtA==
X-Received: by 2002:a05:6122:6799:b0:52f:bef8:deee with SMTP id
 71dfb90a1353d-52fbef8df52mr6343782e0c.8.1748457856087; 
 Wed, 28 May 2025 11:44:16 -0700 (PDT)
Received: from grind.. ([191.255.35.190]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-53066945971sm1568512e0c.30.2025.05.28.11.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 11:44:15 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, ajones@ventanamicro.com,
 bjorn@rivosinc.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 1/3] target/riscv/tcg: restrict satp_mode changes in
 cpu_set_profile
Date: Wed, 28 May 2025 15:44:05 -0300
Message-ID: <20250528184407.1451983-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528184407.1451983-1-dbarboza@ventanamicro.com>
References: <20250528184407.1451983-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-vk1-xa35.google.com
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

We're changing 'mmu' to true regardless of whether the profile is
being enabled or not, and at the same time we're changing satp_mode to
profile->enabled.

This will promote a situation where we'll set mmu=on without a virtual
memory mode, which is a mistake.

Only touch 'mmu' and satp_mode if the profile is being enabled.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Fixes: 55398025e7 ("target/riscv: add satp_mode profile support")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 target/riscv/tcg/tcg-cpu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index a84cca48fc..857c625580 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1339,16 +1339,16 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
 
     if (profile->enabled) {
         cpu->env.priv_ver = profile->priv_spec;
-    }
 
 #ifndef CONFIG_USER_ONLY
-    if (profile->satp_mode != RISCV_PROFILE_ATTR_UNUSED) {
-        object_property_set_bool(obj, "mmu", true, NULL);
-        const char *satp_prop = satp_mode_str(profile->satp_mode,
-                                              riscv_cpu_is_32bit(cpu));
-        object_property_set_bool(obj, satp_prop, profile->enabled, NULL);
-    }
+        if (profile->satp_mode != RISCV_PROFILE_ATTR_UNUSED) {
+            object_property_set_bool(obj, "mmu", true, NULL);
+            const char *satp_prop = satp_mode_str(profile->satp_mode,
+                                                  riscv_cpu_is_32bit(cpu));
+            object_property_set_bool(obj, satp_prop, true, NULL);
+        }
 #endif
+    }
 
     for (i = 0; misa_bits[i] != 0; i++) {
         uint32_t bit = misa_bits[i];
-- 
2.49.0


