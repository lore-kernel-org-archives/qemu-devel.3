Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01476E77166
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 23:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIc6Z-0001IL-4U; Tue, 03 Dec 2024 18:14:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tIc6W-0001GD-AF
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 18:14:52 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tIc6T-0001IK-8T
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 18:14:51 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-724d23df764so5362717b3a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 15:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733267688; x=1733872488;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wnE0CmP8NTo4c9Y80T+D12LCLdMtfc2JUgxsXFE/v+o=;
 b=uEHWXBxaa+f7zXpJz/8OK4luOnoP6K9NZq7q6gnChqmAHMmWn+kUjULr2/s48IiMdI
 pTLJrSWq9kDYKyldK68/7JSoauD5ZYIS8XNMViAJK0QRFqzQHMwudVXGbbQ1UMAZbAsz
 hsIvYZ07SRiapUxg58iKBke1k4pcMRs7PZFAPhVfUwg21/GDKC8r+/Uhlze9jUlZGS+O
 ZliPNr2tI+Li5c8cnxXWuBI7LGOIi0vGIhHwXcvjFOplsNa+vK6qJH6Pa6lgy5wygZ6Q
 4Mivkoze1KKB0fok/lH8CabjEw/5NqyMO5V3Y/nCvxAZ96KWAUd1X7wzmCEfC+2THRVQ
 dFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733267688; x=1733872488;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wnE0CmP8NTo4c9Y80T+D12LCLdMtfc2JUgxsXFE/v+o=;
 b=FawvAQEEVIUWN58xqgvysJ9gFS0L1MLR796l6A/IdlIL4b2rbIkhvG7CYrBOgnRCF+
 n/WWbwBfchWUjG8voRCQXr+kPw4+a9RfmG3+o047KVKueYfCv74dgJVQjd5jHJzUq5zA
 U5PweCKYUeJBY8jPhusGfUdNLalPACitjoda/eVAR/CbW8ldw2iGZUlMHrz45iDWWtlu
 +otGSjFBDOXCTjodlgKx+MB27naaNbCQSltXp+EwvUgYh1CQvWQkOQUY3O9KNWSqTYTz
 4dew+4Y397BzI1A6SqDpDnV95XMFONLDPiblpyUGoj0XnoCE55UBy2pWbsJzy7Lqr69+
 aYnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdqVGPdrXwq03yS5dCFBjNI/C8u3NzAuU6SHCx6ykahKu5XJvtPtq/kb2X8Y5DSX+IgY6IQKD1wO1M@nongnu.org
X-Gm-Message-State: AOJu0YzjWzJZicEcjUStfawzUKAPkXrhAIFY15SWe82I0BunhQzw3XMc
 l11UCTXBU12qjE/5yfSGZVlBcOMnBLvSWm7q+no1DtMBYm8xieFwvnBcPzLeLOQ=
X-Gm-Gg: ASbGncs/DBbid+v/jz49GDw7yWSyc/kzj1FnzGCrF/+G9GcJSHmBdlMz5F3wcIV1e1O
 XBmCLpGVhwi4i22D0QRUjD7tA79IYCdgmdiGGN9HjttraWtspwqp6+K0d6AQDX8J49huM6XEb5a
 2i1GV1dw3dPgkWvpSTqike6ipe29+LNrq788MeKirF/qARm0q07VHkmWNzyPKZmTkTUZx3iskuC
 P1YYuPlJhhMBMJ9QWFUHUdl2QXUMBbSzkkOI4hLjlr2EmvI7iRyP7UwmAVxiv0=
X-Google-Smtp-Source: AGHT+IFfFe9wwTLurayiKPPFuIml+pnARUR4kEcvabXwOOing9vio2xzrU7HqkYbxERf8HqAtGAK5g==
X-Received: by 2002:a17:902:e743:b0:215:4a4e:9286 with SMTP id
 d9443c01a7336-215bd0e66b0mr64747065ad.26.1733267687830; 
 Tue, 03 Dec 2024 15:14:47 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7254180f78asm11032133b3a.133.2024.12.03.15.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:14:47 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 03 Dec 2024 15:14:40 -0800
Subject: [PATCH v4 02/11] target/riscv: Decouple AIA processing from
 xiselect and xireg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-counter_delegation-v4-2-c12a89baed86@rivosinc.com>
References: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
In-Reply-To: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

Since xiselect and xireg also will be of use in sxcsrind, AIA should
have its own separated interface when those CSRs are accessed.

Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/csr.c | 165 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 139 insertions(+), 26 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 9846770820f4..52e0139fc99c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -29,6 +29,7 @@
 #include "sysemu/cpu-timers.h"
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
+#include <stdbool.h>
 
 /* CSR function table public API */
 void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops)
@@ -305,6 +306,15 @@ static RISCVException aia_any32(CPURISCVState *env, int csrno)
     return any32(env, csrno);
 }
 
+static RISCVException csrind_or_aia_any(CPURISCVState *env, int csrno)
+{
+    if (!riscv_cpu_cfg(env)->ext_smaia && !riscv_cpu_cfg(env)->ext_smcsrind) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return any(env, csrno);
+}
+
 static RISCVException smode(CPURISCVState *env, int csrno)
 {
     if (riscv_has_ext(env, RVS)) {
@@ -341,6 +351,30 @@ static RISCVException aia_smode32(CPURISCVState *env, int csrno)
     return smode32(env, csrno);
 }
 
+static bool csrind_extensions_present(CPURISCVState *env)
+{
+    return riscv_cpu_cfg(env)->ext_smcsrind || riscv_cpu_cfg(env)->ext_sscsrind;
+}
+
+static bool aia_extensions_present(CPURISCVState *env)
+{
+    return riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_ssaia;
+}
+
+static bool csrind_or_aia_extensions_present(CPURISCVState *env)
+{
+    return csrind_extensions_present(env) || aia_extensions_present(env);
+}
+
+static RISCVException csrind_or_aia_smode(CPURISCVState *env, int csrno)
+{
+    if (!csrind_or_aia_extensions_present(env)) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return smode(env, csrno);
+}
+
 static RISCVException hmode(CPURISCVState *env, int csrno)
 {
     if (riscv_has_ext(env, RVH)) {
@@ -360,6 +394,15 @@ static RISCVException hmode32(CPURISCVState *env, int csrno)
 
 }
 
+static RISCVException csrind_or_aia_hmode(CPURISCVState *env, int csrno)
+{
+    if (!csrind_or_aia_extensions_present(env)) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return hmode(env, csrno);
+}
+
 static RISCVException umode(CPURISCVState *env, int csrno)
 {
     if (riscv_has_ext(env, RVU)) {
@@ -1966,6 +2009,22 @@ static int aia_xlate_vs_csrno(CPURISCVState *env, int csrno)
     };
 }
 
+static int csrind_xlate_vs_csrno(CPURISCVState *env, int csrno)
+{
+    if (!env->virt_enabled) {
+        return csrno;
+    }
+
+    switch (csrno) {
+    case CSR_SISELECT:
+        return CSR_VSISELECT;
+    case CSR_SIREG:
+        return CSR_VSIREG;
+    default:
+        return csrno;
+    };
+}
+
 static RISCVException rmw_xiselect(CPURISCVState *env, int csrno,
                                    target_ulong *val, target_ulong new_val,
                                    target_ulong wr_mask)
@@ -1973,7 +2032,7 @@ static RISCVException rmw_xiselect(CPURISCVState *env, int csrno,
     target_ulong *iselect;
 
     /* Translate CSR number for VS-mode */
-    csrno = aia_xlate_vs_csrno(env, csrno);
+    csrno = csrind_xlate_vs_csrno(env, csrno);
 
     /* Find the iselect CSR based on CSR number */
     switch (csrno) {
@@ -2002,6 +2061,12 @@ static RISCVException rmw_xiselect(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static bool xiselect_aia_range(target_ulong isel)
+{
+    return (ISELECT_IPRIO0 <= isel && isel <= ISELECT_IPRIO15) ||
+           (ISELECT_IMSIC_FIRST <= isel && isel <= ISELECT_IMSIC_LAST);
+}
+
 static int rmw_iprio(target_ulong xlen,
                      target_ulong iselect, uint8_t *iprio,
                      target_ulong *val, target_ulong new_val,
@@ -2047,45 +2112,44 @@ static int rmw_iprio(target_ulong xlen,
     return 0;
 }
 
-static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
-                                target_ulong *val, target_ulong new_val,
-                                target_ulong wr_mask)
+static RISCVException rmw_xireg_aia(CPURISCVState *env, int csrno,
+                         target_ulong isel, target_ulong *val,
+                         target_ulong new_val, target_ulong wr_mask)
 {
-    bool virt, isel_reserved;
-    uint8_t *iprio;
+    bool virt = false, isel_reserved = false;
     int ret = -EINVAL;
-    target_ulong priv, isel, vgein;
-
-    /* Translate CSR number for VS-mode */
-    csrno = aia_xlate_vs_csrno(env, csrno);
+    uint8_t *iprio;
+    target_ulong priv, vgein;
 
-    /* Decode register details from CSR number */
-    virt = false;
-    isel_reserved = false;
+    /* VS-mode CSR number passed in has already been translated */
     switch (csrno) {
     case CSR_MIREG:
+        if (!riscv_cpu_cfg(env)->ext_smaia) {
+            goto done;
+        }
         iprio = env->miprio;
-        isel = env->miselect;
         priv = PRV_M;
         break;
     case CSR_SIREG:
-        if (env->priv == PRV_S && env->mvien & MIP_SEIP &&
+        if (!riscv_cpu_cfg(env)->ext_ssaia ||
+            (env->priv == PRV_S && env->mvien & MIP_SEIP &&
             env->siselect >= ISELECT_IMSIC_EIDELIVERY &&
-            env->siselect <= ISELECT_IMSIC_EIE63) {
+            env->siselect <= ISELECT_IMSIC_EIE63)) {
             goto done;
         }
         iprio = env->siprio;
-        isel = env->siselect;
         priv = PRV_S;
         break;
     case CSR_VSIREG:
+        if (!riscv_cpu_cfg(env)->ext_ssaia) {
+            goto done;
+        }
         iprio = env->hviprio;
-        isel = env->vsiselect;
         priv = PRV_S;
         virt = true;
         break;
     default:
-         goto done;
+        goto done;
     };
 
     /* Find the selected guest interrupt file */
@@ -2116,10 +2180,54 @@ static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
     }
 
 done:
+    /*
+     * If AIA is not enabled, illegal instruction exception is always
+     * returned regardless of whether we are in VS-mode or not
+     */
     if (ret) {
         return (env->virt_enabled && virt && !isel_reserved) ?
                RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;
     }
+
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
+                                target_ulong *val, target_ulong new_val,
+                                target_ulong wr_mask)
+{
+    bool virt = false;
+    int ret = -EINVAL;
+    target_ulong isel;
+
+    /* Translate CSR number for VS-mode */
+    csrno = csrind_xlate_vs_csrno(env, csrno);
+
+    /* Decode register details from CSR number */
+    switch (csrno) {
+    case CSR_MIREG:
+        isel = env->miselect;
+        break;
+    case CSR_SIREG:
+        isel = env->siselect;
+        break;
+    case CSR_VSIREG:
+        isel = env->vsiselect;
+        virt = true;
+        break;
+    default:
+         goto done;
+    };
+
+    if (xiselect_aia_range(isel)) {
+        return rmw_xireg_aia(env, csrno, isel, val, new_val, wr_mask);
+    }
+
+done:
+    if (ret) {
+        return (env->virt_enabled && virt) ?
+               RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;
+    }
     return RISCV_EXCP_NONE;
 }
 
@@ -5065,8 +5173,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MIP]      = { "mip",      any,  NULL,    NULL, rmw_mip        },
 
     /* Machine-Level Window to Indirectly Accessed Registers (AIA) */
-    [CSR_MISELECT] = { "miselect", aia_any,   NULL, NULL,    rmw_xiselect },
-    [CSR_MIREG]    = { "mireg",    aia_any,   NULL, NULL,    rmw_xireg },
+    [CSR_MISELECT] = { "miselect", csrind_or_aia_any,   NULL, NULL,
+                       rmw_xiselect                                    },
+    [CSR_MIREG]    = { "mireg",    csrind_or_aia_any,   NULL, NULL,
+                       rmw_xireg                                       },
 
     /* Machine-Level Interrupts (AIA) */
     [CSR_MTOPEI]   = { "mtopei",   aia_any, NULL, NULL, rmw_xtopei },
@@ -5184,8 +5294,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_SATP]     = { "satp",     satp, read_satp,     write_satp     },
 
     /* Supervisor-Level Window to Indirectly Accessed Registers (AIA) */
-    [CSR_SISELECT]   = { "siselect",   aia_smode, NULL, NULL, rmw_xiselect },
-    [CSR_SIREG]      = { "sireg",      aia_smode, NULL, NULL, rmw_xireg },
+    [CSR_SISELECT]   = { "siselect",   csrind_or_aia_smode, NULL, NULL,
+                         rmw_xiselect                                       },
+    [CSR_SIREG]      = { "sireg",      csrind_or_aia_smode, NULL, NULL,
+                         rmw_xireg                                          },
 
     /* Supervisor-Level Interrupts (AIA) */
     [CSR_STOPEI]     = { "stopei",     aia_smode, NULL, NULL, rmw_xtopei },
@@ -5264,9 +5376,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     /*
      * VS-Level Window to Indirectly Accessed Registers (H-extension with AIA)
      */
-    [CSR_VSISELECT]   = { "vsiselect",   aia_hmode, NULL, NULL,
-                          rmw_xiselect                                     },
-    [CSR_VSIREG]      = { "vsireg",      aia_hmode, NULL, NULL, rmw_xireg  },
+    [CSR_VSISELECT]   = { "vsiselect",   csrind_or_aia_hmode, NULL, NULL,
+                          rmw_xiselect                                      },
+    [CSR_VSIREG]      = { "vsireg",      csrind_or_aia_hmode, NULL, NULL,
+                          rmw_xireg                                         },
 
     /* VS-Level Interrupts (H-extension with AIA) */
     [CSR_VSTOPEI]     = { "vstopei",     aia_hmode, NULL, NULL, rmw_xtopei },

-- 
2.34.1


