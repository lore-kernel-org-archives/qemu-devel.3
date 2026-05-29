Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66954CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 19:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3Gk-0005Oc-6z; Fri, 29 May 2026 15:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wT3GU-0004zV-Ax
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:53:07 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wT3GQ-0005XW-Fl
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:53:05 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-69dead44101so1962357eaf.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 12:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780084380; x=1780689180; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jovH9veV+Mzo6mUlNsazHlccWGMJEwNuWJfNmm+BCNg=;
 b=Tj+sW7g0/30IkdYTXHlfF00Fle5c7X3l7ztKKi7rnFY0cFj1M+hHwZzq0D+0/SsLeW
 bm38c6/3sNjd3IhL08AXAUqO0K9LDIvNqMXycwG0oENUCxnSkOxVOYrfHgeY5DjGGNEv
 l7HD4/8KFFAGRtMl0be36WtJw8myLElSvdqeF3PjAolRPqtZI3RI2OpMytRVXoUQZ84K
 ZdjtFqhYuQrq+ydo9d1X7YUhhr3uT1XKGWfgOKxgTuXeQeMpMc26BcwXmkHPmSHtCG0s
 UwXPzWeITkHW3PGDfSxUkC0gOi7OL0loJ6/MtjQ8dvzIe38TBtIzSfrd0GAvpadvpZRY
 IIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780084380; x=1780689180;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jovH9veV+Mzo6mUlNsazHlccWGMJEwNuWJfNmm+BCNg=;
 b=JEExrsnPEd3GRC7EH2n+yoEFvN/D3ta/In/Ao+9uv5BNZnU3I/Wf+TG/kJRov9fZfo
 nELkhJpsiv4GKijdI9IeA+TbwHY+K6lZbd5L5HxPJrzX90H06toBkY0VVM6/cPCRbBzM
 q/42JQ4Z8nqxxKUUs4RZWdXA3E22BMMllv/x7q7NITHHuc5oUXf3QzfT2ZZm7FefBpsb
 Cfg1FaIr/NgF+rlkFDZnFoPG9iURhEuNZ22/ETdZDacKELSQ1WW9eKnBlaBDTB9gFxDf
 Sh3MoFyfIXLwrUrWYrZd/IXhMMC9oUvLIgWS1h+k6eGIZqmJy1MpfEqVxkbqKt1+xkp2
 f8og==
X-Gm-Message-State: AOJu0YxUi9L8M25XFdl3ONrEN0vcNe+qvcoy9gzX7jkXWsJfRzIOGTg/
 2LlJpzl/qWAraTFpDlrav3dUCy4DnmLZdhREGQ/uNTej9B8Z8qtWh0m5
X-Gm-Gg: Acq92OGQyuriNZtBPEHiQF16BRIGFC2Jf+dv/fKlkR+SaQQFhfI2A4d6edYA0kLWSTQ
 iyiLufv3647VO9+LgrL+i6GhRRmioP6wsTHEtjCtG5s/V9qfgRwA0tyjq1l4pQLhPTGQ9Fxhp9Y
 iKINN7xVv+0v8mSzrMaGCBHozy+4Qfif+a7h3xJEKKU/x7htdhU2jpVKNKfj2kQCxcmUIBCGcWv
 pOukgtCiBNDAe3F2FYSuBJr9VJyovk1IDqTONfjIxAEXPpTWPR7sqyBLFSJWWzudEu0Lp1sfvQb
 nuPkDCEGwOCwLBMfWhQl3uCqBno2ozCnTtjEK0AZX8tUGzgo/wTpnFqLR6eZRuJXHHH3mHp1MHA
 XKrHEhHzL1aWBKPptUwEGo7mWhqmr0bKxK04B7DFhKQX49JjVVPklzgQT/FJAjLZRm3SzVUDsrf
 ZcXoYMhw4bV4klDiUGlBLCrODFu2Dgk8h+CuN/143pyGtNdU7aOAbeOg==
X-Received: by 2002:a05:6820:2d4a:b0:69d:6bfd:5a29 with SMTP id
 006d021491bc7-69e105a5e1bmr454225eaf.56.1780084380275; 
 Fri, 29 May 2026 12:53:00 -0700 (PDT)
Received: from [10.21.163.79] ([146.74.94.63])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e06587eecsm1626692eaf.0.2026.05.29.12.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 12:52:59 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Fri, 29 May 2026 12:52:43 -0700
Subject: [PATCH v7 03/15] target/arm: mte_check unemitted on STORE_ONLY
 load
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-feat-mte4-v7-3-ccbd3c14eb3c@gmail.com>
References: <20260529-feat-mte4-v7-0-ccbd3c14eb3c@gmail.com>
In-Reply-To: <20260529-feat-mte4-v7-0-ccbd3c14eb3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780084373; l=4550;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=7dxUnCrrHW7OTVsrkn7i1P2N75efUwHqPbYA2F7zfpE=;
 b=05/nOvHlwlAHioNyWTa5zvopOaBoKgIQfEnGpVlmsGOrRGD/rF7rE6rsA0GnJmzQwqMimaOfv
 2NSvC41ABnsCdNZEe6Q8rSVScV6uFLNIc+xZIHvC3gTFeJuQgHG7/qo
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=brookmangabriel@gmail.com; helo=mail-oo1-xc35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This feature disables generation of the mte check helper on loads when
STORE_ONLY tag checking mode is enabled.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h               |  2 ++
 target/arm/tcg/hflags.c        | 12 ++++++++++++
 target/arm/tcg/translate-a64.c |  8 ++++++--
 target/arm/tcg/translate.h     |  2 ++
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d9c03c9c2e..08f04a57af 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2534,6 +2534,8 @@ FIELD(TBFLAG_A64, GCS_EN, 41, 1)
 FIELD(TBFLAG_A64, GCS_RVCEN, 42, 1)
 FIELD(TBFLAG_A64, GCSSTR_EL, 43, 2)
 FIELD(TBFLAG_A64, FPMR_EL, 45, 2)
+FIELD(TBFLAG_A64, MTE_STORE_ONLY, 47, 1)
+FIELD(TBFLAG_A64, MTE0_STORE_ONLY, 48, 1)
 
 /*
  * Helpers for using the above. Note that only the A64 accessors use
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 794cdf00b2..6be84b68ab 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -461,6 +461,15 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                      */
                     DP_TBFLAG_A64(flags, MTE0_ACTIVE, 1);
                 }
+                /*
+                 * Repeat for MTE_STORE_ONLY
+                 */
+                if ((el == 0 ? SCTLR_TCSO0 : SCTLR_TCSO) & sctlr) {
+                    DP_TBFLAG_A64(flags, MTE_STORE_ONLY, 1);
+                    if (!EX_TBFLAG_A64(flags, UNPRIV)) {
+                        DP_TBFLAG_A64(flags, MTE0_STORE_ONLY, 1);
+                    }
+                }
             }
         }
         /* And again for unprivileged accesses, if required.  */
@@ -470,6 +479,9 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
             && (sctlr & SCTLR_TCF0)
             && allocation_tag_access_enabled(env, 0, sctlr)) {
             DP_TBFLAG_A64(flags, MTE0_ACTIVE, 1);
+            if (SCTLR_TCSO0 & sctlr) {
+                DP_TBFLAG_A64(flags, MTE0_STORE_ONLY, 1);
+            }
         }
         /*
          * For unpriv tag-setting accesses we also need ATA0. Again, in
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 15b40090c0..a5850fb58d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -302,7 +302,8 @@ static TCGv_i64 gen_mte_check1_mmuidx(DisasContext *s, TCGv_i64 addr,
                                       MemOp memop, bool is_unpriv,
                                       int core_idx)
 {
-    if (tag_checked && s->mte_active[is_unpriv]) {
+    if (tag_checked && s->mte_active[is_unpriv] &&
+        (is_write || !s->mte_store_only[is_unpriv])) {
         TCGv_i64 ret;
         int desc = 0;
 
@@ -334,7 +335,8 @@ TCGv_i64 gen_mte_check1(DisasContext *s, TCGv_i64 addr, bool is_write,
 TCGv_i64 gen_mte_checkN(DisasContext *s, TCGv_i64 addr, bool is_write,
                         bool tag_checked, int total_size, MemOp single_mop)
 {
-    if (tag_checked && s->mte_active[0]) {
+    if (tag_checked && s->mte_active[0] &&
+        (is_write || !s->mte_store_only[0])) {
         TCGv_i64 ret;
         int desc = 0;
 
@@ -10719,6 +10721,8 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->ata[1] = EX_TBFLAG_A64(tb_flags, ATA0);
     dc->mte_active[0] = EX_TBFLAG_A64(tb_flags, MTE_ACTIVE);
     dc->mte_active[1] = EX_TBFLAG_A64(tb_flags, MTE0_ACTIVE);
+    dc->mte_store_only[0] = EX_TBFLAG_A64(tb_flags, MTE_STORE_ONLY);
+    dc->mte_store_only[1] = EX_TBFLAG_A64(tb_flags, MTE0_STORE_ONLY);
     dc->pstate_sm = EX_TBFLAG_A64(tb_flags, PSTATE_SM);
     dc->pstate_za = EX_TBFLAG_A64(tb_flags, PSTATE_ZA);
     dc->sme_trap_nonstreaming = EX_TBFLAG_A64(tb_flags, SME_TRAP_NONSTREAMING);
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index d4bcc5bad4..551c6ff347 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -140,6 +140,8 @@ typedef struct DisasContext {
     bool ata[2];
     /* True if v8.5-MTE tag checks affect the PE; index with is_unpriv.  */
     bool mte_active[2];
+    /* True if v8.5-MTE tag checks disabled for reads; index with is_unpriv. */
+    bool mte_store_only[2];
     /* True with v8.5-BTI and SCTLR_ELx.BT* set.  */
     bool bt;
     /* True if any CP15 access is trapped by HSTR_EL2 */

-- 
2.54.0


