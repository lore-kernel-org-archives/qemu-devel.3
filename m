Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCD1CD98E8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQhv-0002KV-Bv; Tue, 16 Jun 2026 06:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQho-0001t1-SE
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:42 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQhm-0003Tp-3Q
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:40 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c86484d35d1so1503028a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604457; x=1782209257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z5MJMD7DLmPAgIxPr6bWjQ19lgkOsPJq3HKXc0cJskA=;
 b=iPaf6yXrsLJlea9QMbQSDCb4+fwV3xQuzF7UuPqbCgyhUXY8D3x6orrc5pwfOBEaWt
 nesfOYSTH02ylr2HjEBwrtLPhrDdftJOfiY90yKEAtY0SIyYqgdwn2gT6zbWGf10c/JK
 3246Ne0HuwHf4JhE2cXS5HBr8sHUi/J3StCpjJuOe75U53CILD3ub++ofgslXaxmbAz5
 vESn9/aVzcfm6+Pv0jIKwnN2abLdxo/WKHkTJsRMBmqxiAkloGpd8SGDlZ92QGNIvvz4
 T/9T8lJJOrc2UtNMWX/noX7lmY2cubgPBPFBpSvftVpVDB9IsAIaSb7ZHM1UzHhDSuyN
 cR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604457; x=1782209257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z5MJMD7DLmPAgIxPr6bWjQ19lgkOsPJq3HKXc0cJskA=;
 b=k6PAUGfmDGapOoDJzdsQ2MWFRUTr8WNqG/v8hG1FtHLXhJgFgc9XE7kc6Eh3UXTdfe
 OakGSmdA2pnyBKUOUGgQgJO4qNMMJPZ3Q3TW/I7BN1I4wgFUstotP+0+BcVzqu9GWUiy
 6h9fenjcJ8/F0Y6edgY6o58woNk76JKf7PSOaQR2eVWsNW5dnT/wahjPPnNn4HnsxCHO
 8VCMy5joh4SMMmLbyNCJ1AmamXIDM4jca7fFgSwuYYlgTFaVoICARU8sp3FmDHj3P4s7
 hqmIx2lWbbXlkM4VbpoixIunIb3vV0mWXL5DEkYBEgQ8CY2tQ4HLSixAzipKRW7Eqzlr
 zs0g==
X-Gm-Message-State: AOJu0YyazfJ5LoSoAmFr+f+FMdi1AAQaQ2mnDPLlHotlBBMLxRevHtWo
 HMEQnlTWkgbyTIuF4w4rfTo0oYa/tg9KdzMMtU0yQzoDXmqnVXOH+ZPvLlRP0H11
X-Gm-Gg: Acq92OE2z3nhDc1iMBJcIUw80lo6gcM1JQrF92ztVnjuyagC2lN6HN1AJYOgRH995yf
 NqN4OanwBkBIC0LvCD4QBPkSlPMBwbiVTCVc3auCPXygq6x0cP8uLZQ3oclNnTPhjmKuPlwHdyN
 YRULD+iZiQa8bLl7WP1cYRhgawQ8tPCB8/TgaonUX4aiQHyVJawYzILEYQjF/ctFdfwpdV548Lx
 xyg97XMc7IxeiLe6EVJAOecplqV70GtCqPwNN+YOoZGxO/fI9l3dpGxpOr8znvcIJzjXWOJ+qbT
 FjXqeUK5TxkBroIby0nUGf6E+RM7+pbxxkqrC+2vBZlNVGSX1QBA1OYt5nq5he162Chy78V+KXY
 y1+g9vwUrgjoX+8SXMHfWWEEum1jxdtBuTA4f13oDr9W00uKSlnnI0Ed/LbnxXuOnrwldQXsgqv
 k74jF8elDTGwh9heE2rCRpSD9RpwJosHIJzADPHc4n
X-Received: by 2002:a05:6a21:7010:b0:3a0:c2b4:d976 with SMTP id
 adf61e73a8af0-3b796423b63mr16966350637.44.1781604456826; 
 Tue, 16 Jun 2026 03:07:36 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:07:36 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 35/83] target/riscv: Introduce externally facing CSR access
 functions
Date: Tue, 16 Jun 2026 20:04:38 +1000
Message-ID: <20260616100527.1939565-36-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52c.google.com
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

From: Anton Johansson <anjo@rev.ng>

Convert riscv_csr_[read|write]() into target_ulong angnostic CSR access
functions that can be safely used from outside of target/ without
knowledge of the target register size.  Replace the 4 existing CSR
accesses in hw/ and linux-user/.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260520125406.28693-25-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  7 ++++++-
 target/riscv/csr.h        | 13 -------------
 hw/riscv/riscv_hart.c     |  7 +++----
 linux-user/riscv/signal.c |  5 +++--
 target/riscv/csr.c        | 15 +++++++++++++++
 5 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b751c9d348..e7ecc02b64 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -905,7 +905,12 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
 RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env);
 uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
 
-#include "target/riscv/csr.h"
+/*
+ * Externally facing CSR access functions, wrappers around riscv_csr*().
+ */
+
+RISCVException riscv_csr_write_i64(CPURISCVState *env, int csrno, uint64_t val);
+RISCVException riscv_csr_read_i64(CPURISCVState *env, int csrn, uint64_t *res);
 
 /*
  * The event id are encoded based on the encoding specified in the
diff --git a/target/riscv/csr.h b/target/riscv/csr.h
index f45f9912c5..4cca3a000a 100644
--- a/target/riscv/csr.h
+++ b/target/riscv/csr.h
@@ -26,19 +26,6 @@ RISCVException riscv_csrrw_debug(CPURISCVState *env, int csrno,
                                  target_ulong new_value,
                                  target_ulong write_mask);
 
-static inline void riscv_csr_write(CPURISCVState *env, int csrno,
-                                   target_ulong val)
-{
-    riscv_csrrw(env, csrno, NULL, val, MAKE_64BIT_MASK(0, TARGET_LONG_BITS), 0);
-}
-
-static inline target_ulong riscv_csr_read(CPURISCVState *env, int csrno)
-{
-    target_ulong val = 0;
-    riscv_csrr(env, csrno, &val);
-    return val;
-}
-
 typedef RISCVException (*riscv_csr_predicate_fn)(CPURISCVState *env,
                                                  int csrno);
 typedef RISCVException (*riscv_csr_read_fn)(CPURISCVState *env, int csrno,
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index e675358e1a..d1c7188369 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -67,12 +67,11 @@ static void csr_call(char *cmd, uint64_t cpu_num, int csrno, uint64_t *val)
     RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(cpu_num));
     CPURISCVState *env = &cpu->env;
 
-    int ret = RISCV_EXCP_NONE;
+    RISCVException ret = RISCV_EXCP_NONE;
     if (strcmp(cmd, "get_csr") == 0) {
-        ret = riscv_csrr(env, csrno, (target_ulong *)val);
+        ret = riscv_csr_read_i64(env, csrno, val);
     } else if (strcmp(cmd, "set_csr") == 0) {
-        ret = riscv_csrrw(env, csrno, NULL, *(target_ulong *)val,
-                          MAKE_64BIT_MASK(0, TARGET_LONG_BITS), 0);
+        ret = riscv_csr_write_i64(env, csrno, *val);
     }
 
     g_assert(ret == RISCV_EXCP_NONE);
diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
index 358fa1d82d..9d5ba300e4 100644
--- a/linux-user/riscv/signal.c
+++ b/linux-user/riscv/signal.c
@@ -90,7 +90,8 @@ static void setup_sigcontext(struct target_sigcontext *sc, CPURISCVState *env)
         __put_user(env->fpr[i], &sc->fpr[i]);
     }
 
-    uint32_t fcsr = riscv_csr_read(env, CSR_FCSR);
+    uint64_t fcsr;
+    riscv_csr_read_i64(env, CSR_FCSR, &fcsr);
     __put_user(fcsr, &sc->fcsr);
 }
 
@@ -159,7 +160,7 @@ static void restore_sigcontext(CPURISCVState *env, struct target_sigcontext *sc)
 
     uint32_t fcsr;
     __get_user(fcsr, &sc->fcsr);
-    riscv_csr_write(env, CSR_FCSR, fcsr);
+    riscv_csr_write_i64(env, CSR_FCSR, fcsr);
 }
 
 static void restore_ucontext(CPURISCVState *env, struct target_ucontext *uc)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index e508985311..19d5a55b54 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5751,6 +5751,21 @@ RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
     return riscv_csrrw_do64(env, csrno, ret_value, new_value, write_mask, ra);
 }
 
+RISCVException riscv_csr_write_i64(CPURISCVState *env, int csrno, uint64_t val)
+{
+    return riscv_csrrw(env, csrno, NULL, val,
+                       MAKE_64BIT_MASK(0, TARGET_LONG_BITS), 0);
+}
+
+RISCVException riscv_csr_read_i64(CPURISCVState *env, int csrno, uint64_t *res)
+{
+    RISCVException ret;
+    target_ulong val = 0;
+    ret = riscv_csrr(env, csrno, &val);
+    *res = val;
+    return ret;
+}
+
 static RISCVException riscv_csrrw_do128(CPURISCVState *env, int csrno,
                                         Int128 *ret_value,
                                         Int128 new_value,
-- 
2.54.0


