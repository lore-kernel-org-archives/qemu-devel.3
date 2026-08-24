Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83FDC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNa0-0003S9-18; Mon, 24 Aug 2026 01:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNZQ-0002G6-8F
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:10 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNZO-0002BS-49
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:07 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ceaf8a1265so34603035ad.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550604; x=1788155404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8ZvrE0OJGfngMr7vtDZpzHvPZXdScoco3DbqKgkdkXM=;
 b=CbpKI9cqL+GcnTM8Swln6n4n4Kjl2Ik8QPZzhvtx7aii7O9d6wSHFY/MsDVIC0Kyci
 gx7yzsNaIbTROl/UI6DQLF1q76kuI8scpKy6a+fN1zemx4XyK199JzkABdI5RKCRrUMM
 UEomlK23wNpMnbg6S0JwmBgznfxzvtSshVOVvX0NG2JTtykz+m8WlR2aSbvI74tsUL3R
 KY0XPiTGYCrtL6ROTWz0QTlSZerQQvnKZWtZzSjl5GQqfGOxlnPLn+HETvhxhu4cgOAA
 LAywJIv3GiZjqrQ0ALeoUDCoZ5kXjvM5/9ksBEbqfWlsSttY0y4r0UZm0o4nZaZ/jYQW
 0FKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550604; x=1788155404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8ZvrE0OJGfngMr7vtDZpzHvPZXdScoco3DbqKgkdkXM=;
 b=pVqsqK00WXxiyDM3FQSowziCFJ/1N8cOm5RFC+kPRg/Lp8vzkQ58w0Lt8TqcDqXRI1
 fAn19O4dVZ/HTWwn0rrD5aQsWchQH/vwJIuSeJ/546rEqCv1JiemiQNNQIAaxMFe+UBT
 N1IeCjx9d04hA33k0vTR7qX3pgQULU8QHWQCrX4rXGBIauCEv/2OSSQroD8xcUT9e44N
 36DQPKcQTcRHprm+MWL9m4DhKvMhyPNxNg6nDaMFOv7YO/PDImpfO9mbTjmnwyoHekq7
 Yqth9B1b5leHiajhCmWsXSEQ5/cPjGtxuFrKpXI2cZ7v2RijGPt3SKC956QRFf4wuGJ9
 IkjQ==
X-Gm-Message-State: AFuF++keaWKv+IRn48mN3xfIhY4vIzjeSexVhtGnqVrd9k+rPn31v4BP
 2kxSuvQkslBF1E2iIfrPy6dGL+JFDVkONEWT2vbtlT7Bd2ZykCkUbclsLHW+Iw==
X-Gm-Gg: AR+sD10bZ7BYbFG7NRNSnrhifiIzrQ/cIeYnVC6fqJf0CkEkLKDJDYMPmn1rZZNXNPs
 b78SIyBl5K5nNqppzQttPQhk9N8+CgkWbRmaTK/XirD7Av710FLo1Fkx2dEsM0AXJqaQov81kaA
 6SxJaU+SbeMybHJzAHIQpHpy6GS+iH2uQj45z75TiUIehYoABrG9qVFASbol+6EkBG+bdHGE/xW
 8T9N07tjbbQWUe8IfHUaoasvlkFO9dql2Osn7Gmx4VdEDSnWxfgVu7ivqfnNqYIqDvCv0F6aLES
 KlBXuH7AMp7jTpmG7S2CBuRrekoWWi6WJqCp03nGw9JVqAe9c/v/0AH8ulgG+XP2SpmmZfdChet
 72ksqAq/L6JPZA1+N1N1N4IIxq8+JiegkOW3Obiy12InNVH2dop8kKROYY0hhaMNz/Ep4cqHBDS
 4CKN3rbKWeg7p6bg17zszYIlZcomS0EH9NwL8fatsZBXq/fyTM2gDLDtghgilgI2h8Hc8mX9HVk
 jdj/Q==
X-Received: by 2002:a17:90b:4a81:b0:381:a766:efcb with SMTP id
 98e67ed59e1d1-395c34fed98mr37548683a91.4.1787550603960; 
 Sun, 23 Aug 2026 22:50:03 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:50:03 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: A-Shehab <ahshehab24@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 33/96] target/riscv: allow menvcfg/henvcfg LPE and SSE bits
 on RV32
Date: Mon, 24 Aug 2026 15:47:03 +1000
Message-ID: <20260824054806.2790041-34-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
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

From: A-Shehab <ahshehab24@gmail.com>

The Zicfilp landing-pad enable (LPE, bit 2) and Zicfiss shadow-stack
enable (SSE, bit 3) controls live in the low 32 bits of menvcfg and
henvcfg, and the CFI specification defines them for both RV32 and RV64.

QEMU only adds MENVCFG_LPE/MENVCFG_SSE (and the henvcfg equivalents) to
the writable mask inside the "riscv_cpu_mxl(env) == MXL_RV64" block, so
on RV32 these bits are silently dropped and the features cannot be
enabled. This is inconsistent with write_senvcfg(), which already
handles SENVCFG_LPE/SENVCFG_SSE regardless of MXLEN.

Hoist the LPE/SSE mask handling out of the RV64-only block in
write_menvcfg() and write_henvcfg() so the bits become writable on RV32
as well. The upper-half writers (write_menvcfgh/write_henvcfgh) are
unaffected because these bits reside in the low 32 bits.

Reproducible on qemu-system-riscv32 -cpu rv32,zicfilp=true,zicfiss=true:
an M-mode write of menvcfg.{LPE,SSE} reads back as zero, while the same
program on rv64 keeps the bits set.

Fixes: 4923f672e3d7 ("target/riscv: Introduce elp state and enabling controls for zicfilp")
Fixes: 8205bc127a83 ("target/riscv: introduce ssp and enabling controls for zicfiss")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4045
Signed-off-by: A-Shehab <ahshehab24@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260726080537.13913-1-ahshehab24@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/csr.c | 45 +++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index a90449b87f..ffd751caa5 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -3221,6 +3221,19 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
                     MENVCFG_CBZE;
     bool stce_changed = false;
 
+    /*
+     * menvcfg.LPE (Zicfilp) and menvcfg.SSE (Zicfiss) reside in the low
+     * 32 bits and are defined for both RV32 and RV64, so they must be
+     * writable regardless of MXLEN.
+     */
+    if (cfg->ext_zicfilp) {
+        mask |= MENVCFG_LPE;
+    }
+
+    if (cfg->ext_zicfiss) {
+        mask |= MENVCFG_SSE;
+    }
+
     if (riscv_cpu_mxl(env) == MXL_RV64) {
         mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
                 (cfg->ext_sstc ? MENVCFG_STCE : 0) |
@@ -3228,14 +3241,6 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
                 (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
                 (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
 
-        if (env_archcpu(env)->cfg.ext_zicfilp) {
-            mask |= MENVCFG_LPE;
-        }
-
-        if (env_archcpu(env)->cfg.ext_zicfiss) {
-            mask |= MENVCFG_SSE;
-        }
-
         /* Update PMM field only if the value is valid according to Zjpm v1.0 */
         if (env_archcpu(env)->cfg.ext_smnpm &&
             get_field(val, MENVCFG_PMM) != PMM_FIELD_RESERVED) {
@@ -3383,20 +3388,24 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
         return ret;
     }
 
+    /*
+     * henvcfg.LPE (Zicfilp) and henvcfg.SSE (Zicfiss) reside in the low
+     * 32 bits and are defined for both RV32 and RV64, so they must be
+     * writable regardless of MXLEN.
+     */
+    if (cfg->ext_zicfilp) {
+        mask |= HENVCFG_LPE;
+    }
+
+    /* H can light up SSE for VS only if HS had it from menvcfg */
+    if (cfg->ext_zicfiss && get_field(env->menvcfg, MENVCFG_SSE)) {
+        mask |= HENVCFG_SSE;
+    }
+
     if (riscv_cpu_mxl(env) == MXL_RV64) {
         mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE |
                                 HENVCFG_DTE);
 
-        if (env_archcpu(env)->cfg.ext_zicfilp) {
-            mask |= HENVCFG_LPE;
-        }
-
-        /* H can light up SSE for VS only if HS had it from menvcfg */
-        if (env_archcpu(env)->cfg.ext_zicfiss &&
-            get_field(env->menvcfg, MENVCFG_SSE)) {
-            mask |= HENVCFG_SSE;
-        }
-
         /* Update PMM field only if the value is valid according to Zjpm v1.0 */
         if (env_archcpu(env)->cfg.ext_ssnpm &&
             get_field(val, HENVCFG_PMM) != PMM_FIELD_RESERVED) {
-- 
2.54.0


