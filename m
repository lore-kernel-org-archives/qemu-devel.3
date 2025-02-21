Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B40C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS8b-00072F-Lk; Fri, 21 Feb 2025 07:28:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tlS74-0006Dr-Ap
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:26:41 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tlS71-0007Yk-Ug
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:26:37 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-220c8eb195aso43137535ad.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740140794; x=1740745594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CWBUtSS67oYR3l74Eped0x0Nc8HfHcVrd0NioQ2Xqss=;
 b=RPIb+UZsckyWQQoKfXk4tg6xbgAjDg0mkZWRmsK9ARd1X9BO65pFn41hSlGC4m6WQM
 qqoVdfRZulhefPGvMSM+B4s+8ld+SxNFMUJ4fbFSsFEG3DBg1aKaKx6zex195D8/PcNK
 dH+p8f4d7KBSQY3J/lLj/gARuR91Z6V4tfT5SqEyzAELEwMfi9MixhoKq6x8kS0VyWJC
 OrqTjvVat7I8Qn3oL4pIpg5F/N9cSy57Tjl6nnwBBkhHxyN37exLtfaneQMHR+8OEL8Y
 AzepSx2KoQvPbFSPU0kljidjJKec+AC6HmsnUYKniQMP1InXZLu9U6QHjspCrcMWdVja
 KPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140794; x=1740745594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CWBUtSS67oYR3l74Eped0x0Nc8HfHcVrd0NioQ2Xqss=;
 b=eOrw6c6z8ibv7ArCmfW6lku31O3Za/wbr0OJoe9wPdMS8T28c+TKdOCv0IAfehrgKR
 nS+Xq0WtC7UqZaYPbidBAD0G7dBKyvH7BSO9DAlK6BQT340c9kUbko8fls8z1tTKjTHK
 ipdyuRpTszecjegwb71bWwHQ/REWD1cn27KQ6e5Lbdq7ufovF7mvrSjHJ3Oglq12JJSB
 Q8cK93doIdY5w68IO/O+4DDX9rmSTPvQSznkHHgseOXPCdqycMosNeooX0cRW+wJi0mQ
 RRauaCKt3rsuZ/02Amp1DpQ60vCgQZO/qaIvpobri7jrqpqZzUx2tGA8P0nFR+GWWAPm
 aXpA==
X-Gm-Message-State: AOJu0YzxM7q01sMUz819i1do0NoxF00AVdDP/+CmjCz1GA0PPqgjCw2a
 GDYjai41f7zoT80CLhvH6uvF0B+XmIRP6AnA7GSCkMXVzqAy0tLOoAF1PUX2IBxazfYZjUi9NhQ
 c
X-Gm-Gg: ASbGncvvySVJZQ8FXDR84RTRpj6zGdLLWEcZvExA07Qv0KsobTTDBmzWTmIE5yyiYy5
 x98oN/5tuzot9vrUCPxejQGRWkSnaXiyNzkERmZ2ex6oJBrYYBnVn0AwwZFPH8bPVT+nzCyVO7U
 0Pi5sv17p6l/m7Ivx5houRmPpkSCS3GgdVBm5upheVBxmLJx305V8njfRBpfsacyAmLs0Eb692t
 WPzAk7rbuwQSQeewpI0dyo8h1Yq/2FYuJC0OlNphzoHwP2pdSYDdVHQ85kTJdExfL3jjEr1MwQJ
 REfFTjhPDuSvDpwSz2ECAiYtBmSlW2FhCs/CQILYuUQajWTs2i5A9g==
X-Google-Smtp-Source: AGHT+IHiYj/wM+pKpfvYQyLlZlxFQa12aHhGIepWYrUEIkw6t3B0qkFHpiO/R+EzBgMwK8flkLXolQ==
X-Received: by 2002:a17:903:2381:b0:220:d272:534d with SMTP id
 d9443c01a7336-2219ff57817mr53796555ad.22.1740140794054; 
 Fri, 21 Feb 2025 04:26:34 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.11.154.120])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545e39bsm137349855ad.124.2025.02.21.04.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:26:33 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 1/3] target/riscv/cpu: ignore TCG init for KVM CPUs in
 reset_hold
Date: Fri, 21 Feb 2025 09:26:21 -0300
Message-ID: <20250221122623.495188-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221122623.495188-1-dbarboza@ventanamicro.com>
References: <20250221122623.495188-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
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

riscv_cpu_reset_hold() does a lot of TCG-related initializations that
aren't relevant for KVM, but nevertheless are impacting the reset state
of KVM vcpus.

When running a KVM guest, kvm_riscv_reset_vcpu() is called at the end of
reset_hold(). At that point env->mstatus is initialized to a non-zero
value, and it will be use to write 'sstatus' in the vcpu
(kvm_arch_put_registers() then kvm_riscv_put_regs_csr()).

Do an early exit in riscv_cpu_reset_hold() if we're running KVM. All the
KVM reset procedure will be centered in kvm_riscv_reset_vcpu().

While we're at it, remove the kvm_enabled() check in
kvm_riscv_reset_vcpu() since it's already being gated in
riscv_cpu_reset_hold().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c         | 9 +++++----
 target/riscv/kvm/kvm-cpu.c | 3 ---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 522d6584e4..8e6e629ec4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1050,6 +1050,11 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
         mcc->parent_phases.hold(obj, type);
     }
 #ifndef CONFIG_USER_ONLY
+    if (kvm_enabled()) {
+        kvm_riscv_reset_vcpu(cpu);
+        return;
+    }
+
     env->misa_mxl = mcc->misa_mxl_max;
     env->priv = PRV_M;
     env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
@@ -1146,10 +1151,6 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
         env->rnmip = 0;
         env->mnstatus = set_field(env->mnstatus, MNSTATUS_NMIE, false);
     }
-
-    if (kvm_enabled()) {
-        kvm_riscv_reset_vcpu(cpu);
-    }
 #endif
 }
 
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 23ce779359..484b6afe7c 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1603,9 +1603,6 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
     CPURISCVState *env = &cpu->env;
     int i;
 
-    if (!kvm_enabled()) {
-        return;
-    }
     for (i = 0; i < 32; i++) {
         env->gpr[i] = 0;
     }
-- 
2.48.1


