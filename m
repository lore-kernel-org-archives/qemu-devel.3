Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6C5FCA198
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 22:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vziep-00036d-Ie; Mon, 09 Mar 2026 18:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vzief-00031H-JP
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:00:51 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vzied-0004WH-EV
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:00:49 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64ca1ba0089so11206730d50.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 15:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773093646; x=1773698446; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jgcwa0yWIQXzfZ6W1KbFQLwbNji5JkMYnF9BGfpw40I=;
 b=FhoZSzONOMPSIboRC9rGSPoLWKi3n5U8tioZkk8qj5dImlBWwVX7CjdlBL24B5JTc3
 UNpSmsJhXcx3k7XDVJ1riOyAheoJqVBbiwqLkzngx0XvZ7jZIXUKSbYpNjwAEGgZ8/St
 WnAFrhQnqzBwRPI9MUf21vChC7czqNFKC1dSTVruePi61zTulAJwCV8LWM0KJyRD23iz
 KfZOvj3Jt873/B/H8W8dkjTyxAaS75zMtRUGeTHWyU8QhDGT1n0BJmPvs8bZpPi7Lruk
 QUQwfU+IjE0TYChr1vWDHQT/69QcKLlvuQwF7/0GUjGXwxaUWqWQbwioqoB8NrrQOU4B
 Hrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773093646; x=1773698446;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jgcwa0yWIQXzfZ6W1KbFQLwbNji5JkMYnF9BGfpw40I=;
 b=hJFwiypLmDYkDgGtSx4wp0+mA4CW8hXLBirF3xbD6/V29PNC1KVEnK5xwLSUvCOvFo
 THH/niEAyfvQ8pFpAjWxSdoy4DwHd9+W6goXuJ4mURQO9pRTIDAElHKNogdawj6Qq7Uh
 4ydE/cToy4X5vzAxIBw/n8OVrZ4w+YWS9QF3C6D9br8gLggdw0lWHqrDvi9WZKXoAieq
 xX8MFEaWbCfkGZVLtWlExybOnYIGfHU33HhetxmlW/a9/rX/67POdvTjrtlt4A+5LG7p
 doUjpvU/NHN8PKv0nxlaRr8eysPuzyFk9DX3Yhqzg7jtnqtbU6RiPTuFoQFDy27sDDhv
 md+g==
X-Gm-Message-State: AOJu0YyCq3DHgAUnRN1S0WlZ3R58MXgeKopgpt4+SrY1nG6bKCDSqScz
 6sa4F/0z4RpObtrPLHVK484w1PkJ5Mv+aQJUjwet/M6K9z4Qp1KZB3ha
X-Gm-Gg: ATEYQzyRyPYH+80v660KF1h/QQUjLeFo0RBDycWyAV71mhEv9ipfbNhVeImBkrRYj1Y
 wsjAjI97OCQWMgZ4gXZpeUMMp6eafrWlDJ9st+KJ0KOhiT0qHnc/iCeh8OwWSli78W4VINN2gT+
 MPQM5E1qjSUq60FrdIgjVrQXvM03/2TWGMjZGLaDciq6zBhyokZ/wlp0QDT4/u2mZ8oZwCmhhk7
 gUYnRL1s1o7Z2aP8FABTbpXOwljcWxoZOpXNJAQxytJqhOFjylWc6260zte1GISocXobRem6NLe
 5QsBSDPz3+b4/wQ8K4xhP19NTnjsueXfo9UjvzEcHIz9AV/jEwl/kwNTTZkbSl5cb4KfnqBOxZr
 CTMr1EOAfDVhWfHN5khB92HIUFI5r7rH/7QBN1yP+IbT11d3akbkmHDw/9Z9WNvfwmL/24yji6U
 JFThJHPukbOuRqcbYD7+wC8BjFPOAGpqVDhTw=
X-Received: by 2002:a05:690c:498f:b0:798:5fab:8f09 with SMTP id
 00721157ae682-798dd7d0303mr120627417b3.59.1773093646284; 
 Mon, 09 Mar 2026 15:00:46 -0700 (PDT)
Received: from [172.26.74.149] ([185.213.193.97])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7990a54ba7csm5218437b3.19.2026.03.09.15.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 15:00:45 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 09 Mar 2026 17:59:35 -0400
Subject: [PATCH v4 03/13] target/arm: mte_check unemitted on STORE_ONLY
 load
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-feat-mte4-v4-3-daaf0375620d@gmail.com>
References: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
In-Reply-To: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773093641; l=4489;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=Pc5+zDEDvypPiBruXS4oDhDpK0/vb94rXRcJo+SklaM=;
 b=C0tF2Q2XkRpKWcPpGhPfmysyIy7na5/XgjITCJ8m1lZoQgGGKx0Ckoo1JipRV7V3CWqELSVqm
 baJXYNaepU/DFGH7iUkQ2bbSPMAs/Y7YwFtqn+u0oj6RZV2Ii0jGpc9
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=brookmangabriel@gmail.com; helo=mail-yx1-xb130.google.com
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
---
 target/arm/cpu.h               |  2 ++
 target/arm/tcg/hflags.c        | 12 ++++++++++++
 target/arm/tcg/translate-a64.c |  8 ++++++--
 target/arm/tcg/translate.h     |  2 ++
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 677ac18f6f..7911912c3e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2525,6 +2525,8 @@ FIELD(TBFLAG_A64, ZT0EXC_EL, 39, 2)
 FIELD(TBFLAG_A64, GCS_EN, 41, 1)
 FIELD(TBFLAG_A64, GCS_RVCEN, 42, 1)
 FIELD(TBFLAG_A64, GCSSTR_EL, 43, 2)
+FIELD(TBFLAG_A64, MTE_STORE_ONLY, 45, 1)
+FIELD(TBFLAG_A64, MTE0_STORE_ONLY, 46, 1)
 
 /*
  * Helpers for using the above. Note that only the A64 accessors use
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 7e6f8d3647..75c55b1a6d 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -423,6 +423,15 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
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
@@ -432,6 +441,9 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
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
index 5d261a5e32..874174a15b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -301,7 +301,8 @@ static TCGv_i64 gen_mte_check1_mmuidx(DisasContext *s, TCGv_i64 addr,
                                       MemOp memop, bool is_unpriv,
                                       int core_idx)
 {
-    if (tag_checked && s->mte_active[is_unpriv]) {
+    if (tag_checked && s->mte_active[is_unpriv] &&
+        (is_write || !s->mte_store_only[is_unpriv])) {
         TCGv_i64 ret;
         int desc = 0;
 
@@ -333,7 +334,8 @@ TCGv_i64 gen_mte_check1(DisasContext *s, TCGv_i64 addr, bool is_write,
 TCGv_i64 gen_mte_checkN(DisasContext *s, TCGv_i64 addr, bool is_write,
                         bool tag_checked, int total_size, MemOp single_mop)
 {
-    if (tag_checked && s->mte_active[0]) {
+    if (tag_checked && s->mte_active[0] &&
+        (is_write || !s->mte_store_only[0])) {
         TCGv_i64 ret;
         int desc = 0;
 
@@ -10696,6 +10698,8 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->ata[1] = EX_TBFLAG_A64(tb_flags, ATA0);
     dc->mte_active[0] = EX_TBFLAG_A64(tb_flags, MTE_ACTIVE);
     dc->mte_active[1] = EX_TBFLAG_A64(tb_flags, MTE0_ACTIVE);
+    dc->mte_store_only[0] = EX_TBFLAG_A64(tb_flags, MTE_STORE_ONLY);
+    dc->mte_store_only[1] = EX_TBFLAG_A64(tb_flags, MTE0_STORE_ONLY);
     dc->pstate_sm = EX_TBFLAG_A64(tb_flags, PSTATE_SM);
     dc->pstate_za = EX_TBFLAG_A64(tb_flags, PSTATE_ZA);
     dc->sme_trap_nonstreaming = EX_TBFLAG_A64(tb_flags, SME_TRAP_NONSTREAMING);
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 3e3094a463..74143161f4 100644
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
2.52.0


