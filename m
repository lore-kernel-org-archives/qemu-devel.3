Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D86CD5BB1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDMn-0001UJ-5G; Thu, 21 May 2026 20:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDMk-0001TU-7j
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:03:51 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDMh-0003DT-Np
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:03:49 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c801912c903so3071544a12.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408225; x=1780013025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rNkojL9uuqvWe7wcYdTzaSL3blOAtL9R1zlg72VqgO0=;
 b=L5P9p/y8FN4C5IwRVVXmf2TEmCN6JZlhyJGxPjyiIucc7vRm5T6vbQBlvT1ZD/dQ6+
 of6SoOylnsXf5JDz7J/OL6lxgoRaQDZZ8zvjVfTCq6STeksFZBoQLBRufl6O3JsVVY33
 KDuGn+pTGYYEQvUEeRy7YTB6bv7DeJXwozyPMAKEWqs91Qo9Zkv+utvP/sQN+GRs6IbA
 C06LbA6GEeGuGVZeXY5Xu/LSuKjxfHxgi159nrJ5EUBT81UNK6DsXQ93yOAuZeba04Ka
 Ax72lBrlDTKEdZNB7pW5ynSZfdltEm9xktKOKCBF5FHrVuVEblcf8l0XEQvyhfj/aHSR
 R3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408225; x=1780013025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rNkojL9uuqvWe7wcYdTzaSL3blOAtL9R1zlg72VqgO0=;
 b=nqRP49qib/5WwXZ+xlKUC16p+MBP0p9k0qVjpjUnM82J55OYBiywmaZ1rdMHu/KrcW
 fSS0yyZsCpxykaVlH9G1VsnG9goR0tV0aMpmrEHPUOag6GM12NRVVu/yCo2uZwC13On1
 xBphpSAmHe4QxY+hwPY5d2aRGQYpOgHN9vFooqKmBFW9PGB896EWChh5nGvTG52uLBaP
 6mQDuCFDUsS6PoenYNkueTcOKuvJ9Kadk1ktgfbeh+2Jw9QrCn6DmcuKIcUR3ZvJ2/u7
 KlzGEaeoY0DF5bOpNquf+d5/MANNHsQMk1aqs+O5agCvHcL6VvgO40Pfw7cOtmb1cGEM
 1sDg==
X-Gm-Message-State: AOJu0YxZ76SJe1fm8a4HplDNko4J09jFlpR13F37FXda7BPZw0GMOtqZ
 Am+3wOblKedb46W0BQg2hMJIYPWDI20M68c6BFLNhbciJh8ArOK+9d1f+8uJhaIq
X-Gm-Gg: Acq92OFzLcjccPI2sKT78v5SPyZmJ4Ul2jvsPSSyUhYj/OCMMiw1GhQe5g+NGCliZSO
 1tQC2l6B4hpl6YYZJvtRo88JR9m/RV0YCrWB3bp3fSgxSyihWtw5c3fNwevs8bpI1V7kyB4+eEb
 HpNyLZF5wTBYQb8PpFhxjtjSQ51YuOPz77IXyXS7E8HMfRtb45AlrGNCXNmSgWcTuDccsjFnAWE
 WoDBlR00MXIjLB2KpfAFXSgCLiTGaxfZJLa+wK99zHMUvSVcq+vsaPdnkZnuxrunuEXKOEOvA3z
 74FC4+QOrLt5mBZrE3RN9rGpfJo293mI8g34uXUGEjR0H3+tYfAXDBzssxcygg9nzIPM6BW9SEY
 Y4zGTVZHriuJKQj6wOrYeGBl6SVHK1U4rtWyfX28BUzVP0+MJUrJX9q/bMzsvBZZklWFw9uAHSI
 4uJs4KGcKfWhIrN0JfdabLFvns7UcvXDJJc+uin4tHfg==
X-Received: by 2002:a17:902:c950:b0:2b2:d09c:c07c with SMTP id
 d9443c01a7336-2beb0848f5bmr9521905ad.36.1779408224851; 
 Thu, 21 May 2026 17:03:44 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:03:44 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Max Chou <max.chou@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 03/48] target/riscv: Update MISA.C for Zc* extensions
Date: Fri, 22 May 2026 10:02:39 +1000
Message-ID: <20260522000324.23255-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x532.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Frank Chang <frank.chang@sifive.com>

MISA.C is set if the following extensions are selected:
  * Zca and not F.
  * Zca, Zcf and F (but not D) is specified (RV32 only).
  * Zca, Zcf and Zcd if D is specified (RV32 only).
  * Zca, Zcd if D is specified (RV64 only).

Therefore, MISA.C must be set according to the Zc* extension rules.

Warn the user if RVC is explicitly disabled but MISA.C is required by
the rules above.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260424050509.3935180-2-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 02c98cc2db..216c5f9f76 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1163,6 +1163,44 @@ static void riscv_cpu_enable_implied_rules(RISCVCPU *cpu)
     }
 }
 
+/*
+ * MISA.C is set if the following extensions are selected:
+ *   - Zca and not F.
+ *   - Zca, Zcf and F (but not D) is specified on RV32.
+ *   - Zca, Zcf and Zcd if D is specified on RV32.
+ *   - Zca, Zcd if D is specified on RV64.
+ */
+static void riscv_cpu_update_misa_c(RISCVCPU *cpu)
+{
+    CPURISCVState *env = &cpu->env;
+    bool set_misa_c = false;
+
+    if (riscv_has_ext(env, RVC)) {
+        return;
+    }
+
+    if (cpu->cfg.ext_zca && !riscv_has_ext(env, RVF)) {
+        set_misa_c = true;
+    } else if (riscv_cpu_mxl(env) == MXL_RV32 &&
+               cpu->cfg.ext_zca && cpu->cfg.ext_zcf &&
+               (riscv_has_ext(env, RVD) ? cpu->cfg.ext_zcd :
+                                          riscv_has_ext(env, RVF))) {
+        set_misa_c = true;
+    } else if (riscv_cpu_mxl(env) == MXL_RV64 &&
+               cpu->cfg.ext_zca && cpu->cfg.ext_zcd) {
+        set_misa_c = true;
+    }
+
+    if (set_misa_c) {
+        if (cpu_misa_ext_is_user_set(RVC)) {
+            warn_report("RVC mandated by Zca/Zcf/Zcd extensions");
+            return;
+        }
+
+        riscv_cpu_set_misa_ext(env, env->misa_ext | RVC);
+    }
+}
+
 void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 {
     CPURISCVState *env = &cpu->env;
@@ -1170,6 +1208,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 
     riscv_cpu_init_implied_exts_rules();
     riscv_cpu_enable_implied_rules(cpu);
+    riscv_cpu_update_misa_c(cpu);
 
     riscv_cpu_validate_misa_priv(env, &local_err);
     if (local_err != NULL) {
-- 
2.53.0


