Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960ADCCA470
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 03:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4WTe-0007Ko-1w; Thu, 02 Oct 2025 23:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTb-0007Ic-OK
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:59 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTU-0001Js-5b
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:59 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-78118e163e5so2456224b3a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 20:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759462127; x=1760066927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bhxBjl9dnV1s4sWgaM9fEYlOc+gZAvu50RmyzHsZFQ4=;
 b=OFC6a2QEcT3t41rGcrw8XLt44cfuQ0A8zuQl1jVmO4xMhwCvEvBb/tDUvIiPuboL42
 sHKw8Ux7kAIQnzix8Dve4xDJqNsIzYyddkMkL3YDr6PmK0uWscRnfGgV8Ru8fDMuVbPh
 1ZrHlfr65sHviy8BVX8k07/YE741F8ERLw6K7NbQR3hdkGk/4M5dqeST9kVDI9qfD+x5
 tDmGGvZBY1inl57fF6FlceETllNr3bUgiN1ZXb5Sb8rKajePQ8RuAdyjumVUZFPtKSvO
 NiGVFLuE0TYycWbrKmZapUQc9uA1l9Y9/AE8pAXrESC3KsUYyR2YwTOAdd72MEyY0EbN
 DxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759462127; x=1760066927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bhxBjl9dnV1s4sWgaM9fEYlOc+gZAvu50RmyzHsZFQ4=;
 b=GMPYNAxtZ+7a3zFoP0F3RRHosGWSeftybPvQtjyy57qQy3cZywxo3gKGSM+doxjjbC
 l3+tn2fky31E2tJUkWWfww4xuuIWpPSQ3wT6DB598SnN2XIKXPLZgGW3KbfAe98WLcFW
 KDgF25zW9I04/4+40grdalYnkFFQE7pDGrLhkjy2KtxWY/9MwBH6Nbsl+ecFuq4e+f80
 k53Tgusr2GdzmcgSu+yTQ26wBJBOO2hRXMs7dnYRaFpzwnNvGQgJ2JRxXEz3A2QcREiy
 KBZbC6tA7anOwJ3nXj5U8VaU3RjKkqh8zXVAqGpH3NyBrtgiUXvf0yK89UfnmZe+THDb
 Lmkw==
X-Gm-Message-State: AOJu0YwGORggL/OvKAmTUzFAgQ4cDJeJ4rl25ziv/A04MrigXAu7/s4N
 LDTuDqlWGc1TU4kZvvGSNbQTt5yWvSOvqRskPXvcci74RYpdBrW9w6G/qUEkrA==
X-Gm-Gg: ASbGncvepiZEQeqIrvELtT5o+2ciJFIBkhf5TuJkBbK6PWiCIPvSc5h6Cyd7t4Wpgas
 etqzHVN6jpBRFu13f7jQ6Kl1iy2EL/Z7xjsPwq4lfRGMJLqxUbJ/JsuHC4ZwZnfxaIt6TZZn5y5
 +a+bEH7UroRENnF7M8KmRsuHxdobguOCOWJxRCvbcROAsjunfOlRMSD0FCB3/eHmb99QvUuFNjI
 GCuFZ6jOtoFbMuF+DzFE7ROVQ4U7miM5zJr3XSAaEplyK/RQw/23YoOlEUd1ofxLdOFfM5405DO
 2Iiej3OtNmNmyloc7d/Z7NNTrcOdh85aphUDYBPlBukg/qUW6/i7C6HWY7MHo6bavEvim7DM6pB
 yfnGF0FQajukLCVUXF1ErmgBBmnXZKQFilOvgN+6PzbzVMe+aaaTFrNHhMkX0vQOyiSnZr5v3VQ
 UFSt02OddMp2oRvbQxDcVyUw5/NX3dfefxZiL91MYmSQb3669w2Hdl
X-Google-Smtp-Source: AGHT+IGQ+dWxdlyOjGc/Mqvw3Y/FIbqUO4ta+pa2enjq2GROPh8iADP40Lf4gMe6cZVvWh/6ff3SVw==
X-Received: by 2002:a05:6a21:e083:b0:2ac:7445:4947 with SMTP id
 adf61e73a8af0-32b61d6ffc7mr2021095637.19.1759462126528; 
 Thu, 02 Oct 2025 20:28:46 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b62ce55205csm844202a12.18.2025.10.02.20.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 20:28:45 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 21/26] target/riscv: rvv: Replace checking V by checking Zve32x
Date: Fri,  3 Oct 2025 13:27:13 +1000
Message-ID: <20251003032718.1324734-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003032718.1324734-1-alistair.francis@wdc.com>
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
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

From: Max Chou <max.chou@sifive.com>

The Zve32x extension will be applied by the V and Zve* extensions.
Therefore we can replace the original V checking with Zve32x checking for both
the V and Zve* extensions.

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250923090729.1887406-2-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c            | 2 +-
 target/riscv/csr.c            | 3 ++-
 target/riscv/machine.c        | 3 ++-
 target/riscv/riscv-qmp-cmds.c | 2 +-
 target/riscv/tcg/tcg-cpu.c    | 2 +-
 5 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d055ddf462..a877018ab0 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -604,7 +604,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
             }
         }
     }
-    if (riscv_has_ext(env, RVV) && (flags & CPU_DUMP_VPU)) {
+    if (riscv_cpu_cfg(env)->ext_zve32x && (flags & CPU_DUMP_VPU)) {
         static const int dump_rvv_csrs[] = {
                     CSR_VSTART,
                     CSR_VXSAT,
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ea36eccb3d..5c91658c3d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2005,7 +2005,8 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
     if (riscv_has_ext(env, RVF)) {
         mask |= MSTATUS_FS;
     }
-    if (riscv_has_ext(env, RVV)) {
+
+    if (riscv_cpu_cfg(env)->ext_zve32x) {
         mask |= MSTATUS_VS;
     }
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 51e0567ed3..18d790af0d 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -131,7 +131,8 @@ static bool vector_needed(void *opaque)
     RISCVCPU *cpu = opaque;
     CPURISCVState *env = &cpu->env;
 
-    return riscv_has_ext(env, RVV);
+    return kvm_enabled() ? riscv_has_ext(env, RVV) :
+                           riscv_cpu_cfg(env)->ext_zve32x;
 }
 
 static const VMStateDescription vmstate_vector = {
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index b63de8dd45..c499f9b9a7 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -342,7 +342,7 @@ int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval)
     }
 
     if (reg_is_vreg(name)) {
-        if (!riscv_has_ext(env, RVV)) {
+        if (!riscv_cpu_cfg(env)->ext_zve32x) {
             return -EINVAL;
         }
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 143ab079d4..b3b7f14503 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -661,7 +661,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (riscv_has_ext(env, RVV)) {
+    if (cpu->cfg.ext_zve32x) {
         riscv_cpu_validate_v(env, &cpu->cfg, &local_err);
         if (local_err != NULL) {
             error_propagate(errp, local_err);
-- 
2.51.0


