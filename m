Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A547DC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 16:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmxNR-0007Lp-NG; Tue, 25 Feb 2025 11:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <loic@rivosinc.com>) id 1tmxMx-0007FY-OJ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 11:01:17 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <loic@rivosinc.com>) id 1tmxMt-0001ww-KU
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 11:01:15 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4398c8c8b2cso58658175e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 08:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740499258; x=1741104058;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HSlxDFH/ObyXVckt8oRUa9wf2y151knGbEMsdZQomEY=;
 b=u8+9lnvO2z0r4JqzdAUkZ1gcPoSt13z110I30MusEQcnzqeqPmbDtjH3/kHCRJtuWF
 zORpa6YRyCokilyUxAk62mvnGw5R3NHu+kJHFfU1CPK1O77RGgGmI+T595BhFPT1UvR0
 y7WyzaDWkN1yG0VuxGL2AO+/SNYLFKd9W8WsV84XuvvIq5zqE5U3AvVno75asG1gCE6c
 nu/u2cwUpD90gxt57DQZCzFVZVtTJo3W6LUuM9qOZdLKwnS0cGhlmZq3Vo20ZX02iTiV
 NJziz8wQTS+hVjV97V0ewyi3h9O2Zv9JXGJ3nXjoRA46sJsJ/sr3YhIPkW0hMv/T0tAo
 0aWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740499258; x=1741104058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HSlxDFH/ObyXVckt8oRUa9wf2y151knGbEMsdZQomEY=;
 b=uwZJQgE6mXvxr9TOzuEEcUhk7to06vN+uAL98bFaEWYkdz6bzO5FxVKoXhJJYHipHO
 PTGKluhpD1AMvsEdU03VXbiivcVq1ToBF6L6ft49un8v1+lzgCQ3ISXlPZodby9wVp6a
 f/nj091NZeyeffvC5h+ydyfybIk4VVTt3G8sNcCr9UN01egQ/M+5iLzp6uyQf/LJt4lR
 VseCTZU/Rg1r3/Ze32i9BqqIt1ygTlJgLmG/fyiaQz+beWNeOD1wcpf0n2GFGHoSTwYv
 z0l3iFHzqpHnxKDn5qUeckWd2m5aqJdIu4+xbKMuUK5ap0PF+wLWXATjojGDlRuDDAtT
 +3Dg==
X-Gm-Message-State: AOJu0YwuPe7ylsYkaTcIVPqLb5+qWQ+U5N6pIQS1gBAbmSySPPhWxW/I
 YB1gL6/m6O3HTmaVgJKhX/o0xTaKx5X/YWQAyetbjcLtrdmZmbrwT2/b72gAV6B2Au4NCCfXH/A
 sYZoB1Hb1
X-Gm-Gg: ASbGncuWGK+S3UF7N+QHmwCFJsKoE62XoGOWMyPBWKtbfvdQyWbuL/rSS/nawS7ReMc
 AJLNp7Fciwe6B2HVAQIaB4AuoRp4YZfiqRwPFPtjfC43D8Jhd7xuNpFOfdm1kgKnvR8iC0SKfd5
 qF4BKpTdjok6qXzrwHnJjZImK+ICSOiGCq2DHIqfyfV2PNpwTvuFFFUbDL9d3DVl2fjjF25Eiha
 b8ncuLs0NcGCKjyOxwnbTdA35teeokjYROArnY6mz4B6xojaJNrO0ghU2MsQyngkD2BxtzQyb5x
 uZKqrKuEgWhB4AKOsXAaNife8RkYlsrNgq1nC1/voU6szGRGtyRh2bGbwv9lWdyJ7vMipgsqOw=
 =
X-Google-Smtp-Source: AGHT+IFFomsqx67Lys9xn577NNBX51qZjNRGPtr/fLIRAQw1Uhgu6AAHxTm800E9cMVvZ2y/UsTljg==
X-Received: by 2002:a05:600c:a01:b0:439:9106:c09 with SMTP id
 5b1f17b1804b1-43ab0f6fba7mr38933725e9.26.1740499257743; 
 Tue, 25 Feb 2025 08:00:57 -0800 (PST)
Received: from llx1.cad.pilog.net (lfbn-mar-1-50-94.w86-229.abo.wanadoo.fr.
 [86.229.28.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab1546df4sm30530755e9.17.2025.02.25.08.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:00:57 -0800 (PST)
From: =?UTF-8?q?Lo=C3=AFc=20Lefort?= <loic@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Lo=C3=AFc=20Lefort?= <loic@rivosinc.com>
Subject: [PATCH 3/5] target/riscv: pmp: fix checks on writes to pmpcfg in
 Smepmp MML mode
Date: Tue, 25 Feb 2025 17:00:50 +0100
Message-ID: <20250225160052.39564-4-loic@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250225160052.39564-1-loic@rivosinc.com>
References: <20250225160052.39564-1-loic@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=loic@rivosinc.com; helo=mail-wm1-x335.google.com
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

With Machine Mode Lockdown (mseccfg.MML) set and RLB not set, checks on pmpcfg
writes would match the wrong cases of Smepmp truth table.

The existing code allows writes for the following cases:
- L=1, X=0: cases 8, 10, 12, 14
- L=0, RWX!=WX: cases 0-2, 4-6
This leaves cases 3, 7, 9, 11, 13, 15 for which writes are ignored.

From the Smepmp specification: "Adding a rule with executable privileges that
either is M-mode-only or a locked Shared-Region is not possible (...)" This
description matches cases 9-11, 13 of the truth table.

This commit implements an explicit check for these cases by using
pmp_get_epmp_operation to convert between PMP configuration and Smepmp truth
table cases.

Signed-off-by: Loïc Lefort <loic@rivosinc.com>
---
 target/riscv/pmp.c | 81 ++++++++++++++++++++++++----------------------
 1 file changed, 43 insertions(+), 38 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index b7f1430ff8..e0ea436f8e 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -75,6 +75,44 @@ static int pmp_is_readonly(CPURISCVState *env, uint32_t pmp_index)
     return pmp_is_locked(env, pmp_index) && !MSECCFG_RLB_ISSET(env);
 }
 
+/*
+ * Check whether `val` is an invalid Smepmp config value
+ */
+static int pmp_is_invalid_smepmp_cfg(CPURISCVState *env, uint8_t val)
+{
+    /* No check if mseccfg.MML is not set or if mseccfg.RLB is set */
+    if (!MSECCFG_MML_ISSET(env) || MSECCFG_RLB_ISSET(env)) {
+        return 0;
+    }
+
+    /*
+     * Adding a rule with executable privileges that either is M-mode-only
+     * or a locked Shared-Region is not possible
+     */
+    switch (pmp_get_smepmp_operation(val)) {
+    case 0:
+    case 1:
+    case 2:
+    case 3:
+    case 4:
+    case 5:
+    case 6:
+    case 7:
+    case 8:
+    case 12:
+    case 14:
+    case 15:
+        return 0;
+    case 9:
+    case 10:
+    case 11:
+    case 13:
+        return 1;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 /*
  * Count the number of active rules.
  */
@@ -103,46 +141,13 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_index)
 static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
 {
     if (pmp_index < MAX_RISCV_PMPS) {
-        bool readonly = true;
-
-        if (riscv_cpu_cfg(env)->ext_smepmp) {
-            /* mseccfg.RLB is set */
-            if (MSECCFG_RLB_ISSET(env)) {
-                readonly = false;
-            }
-
-            /* mseccfg.MML is not set */
-            if (!MSECCFG_MML_ISSET(env) && !pmp_is_readonly(env, pmp_index)) {
-                readonly = false;
-            }
-
-            /* mseccfg.MML is set */
-            if (MSECCFG_MML_ISSET(env)) {
-                /* not adding execute bit */
-                if ((val & PMP_LOCK) != 0 && (val & PMP_EXEC) != PMP_EXEC) {
-                    readonly = false;
-                }
-                /* shared region and not adding X bit */
-                if ((val & PMP_LOCK) != PMP_LOCK &&
-                    (val & 0x7) != (PMP_WRITE | PMP_EXEC)) {
-                    readonly = false;
-                }
-            }
-        } else {
-            if (!pmp_is_readonly(env, pmp_index)) {
-                readonly = false;
-            }
-        }
-
-        if (readonly) {
+        if (pmp_is_readonly(env, pmp_index)) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "ignoring pmpcfg write - read only\n");
-        } else if (env->pmp_state.pmp[pmp_index].cfg_reg != val) {
-            /* If !mseccfg.MML then ignore writes with encoding RW=01 */
-            if ((val & PMP_WRITE) && !(val & PMP_READ) &&
-                !MSECCFG_MML_ISSET(env)) {
-                return false;
-            }
+        } else if (pmp_is_invalid_smepmp_cfg(env, val)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "ignoring pmpcfg write - invalid\n");
+        } else {
             env->pmp_state.pmp[pmp_index].cfg_reg = val;
             pmp_update_rule_addr(env, pmp_index);
             return true;
-- 
2.47.2


