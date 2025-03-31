Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9613C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 12:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzDsl-0008Ke-VC; Mon, 31 Mar 2025 08:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tzDsM-000897-K2; Mon, 31 Mar 2025 08:04:23 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tzDsG-0002k2-OL; Mon, 31 Mar 2025 08:04:19 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-227cf12df27so61822965ad.0; 
 Mon, 31 Mar 2025 05:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743422650; x=1744027450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z07Ct8cMY/7zNIWgwigXMBSDODFfC5hNPp52sgKCaAU=;
 b=MvuYEq8UlM/RqnwdgzXmnlOQtymwtDCG5EPbZbir3QKj2a0URfjyuG9E2H1P8x/l5+
 DePP1EXckShs4iov68CLp6msp4clA+7OCpTd9gtD2zourVByqWMxF3KVDI2H4AzcDRJk
 /GaAM6RxxNvhO/JHGMYcK9/o/kIg81nJTNdYl5/yHkRzMOFblqMoJfxRuk01rO0GPYKI
 DC8vFmNSSiWuTxT/luqkfnmSC6s6ey6uZ3baaLuGHtz6Uas1bH0zITob50SLUsPSTBCc
 Neav1sdMWT9DF10w4WB5azQUMmco4S9dD8QZ/7ThCAvgYWddvzzYtvB4jc32oqPWveIy
 W2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743422650; x=1744027450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z07Ct8cMY/7zNIWgwigXMBSDODFfC5hNPp52sgKCaAU=;
 b=sftOUhnMqnd3qcNL/JDBRm/Ul1IGz/O/vM39Pm4w9JB7mGibwyJxIsB4DRzEBSiBW/
 d25FPud4VaU0hL7f/AL7tCCLdVXmpQyvDTP4vb1Hlz9kzzI04dCHNhJhOzVR85Cwcv0U
 nJsduR0Y59gwusjdsSDo75caT2v+ZVSalzldgFTzktWVzn74/5LMDtKhRg6hpjX8poE/
 9Kx23uD1v4/Zbdsr3q+T1dgwtTEw1LNxXCKHEkOxGgF4BOW3PwoN/xWCFV++TKcT3fFc
 GObjikxsd0YA0N7RDP5HLCizb+R7eN60IpkSDmePGiClzEa76HzJFfy+0BJfseSK1xo4
 TrHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeWgxChPNedJK3YcbG4VcHVyz89ViQEkrTvbg6KkUThXDIfxKT1zst1U1AQGmBP9Kv9H+0CTkc+Tz3i7Y=@nongnu.org,
 AJvYcCVMXUYUZc/roAZVWtnyepzeKXn1KFZgbhnCHaM3yZRQR5AhFe3bFVkkKFRH4+pwgy1MjhRdwRZaU3JV@nongnu.org
X-Gm-Message-State: AOJu0YxERJsfzsjv8nzr4nZ+arOOUnQ1nOTby5UWe5hG33fpOz/Dr2ai
 wLyZ7urI2nXWlTPxrHq/vTjLmYi1YtkmpcsgqOFZ5LviQyp4QTzzYVNwgg==
X-Gm-Gg: ASbGnctFK5KrmG3r5dejwt9lNiwPvxuUYw6oD0upTrVlSZbXUvUuab7FSeGEipjLcv2
 KixLTufUIcf/0q8fjKdVW/chwIV96gTzVfJNWxHxOcgNqo3EEbtYg3BAdcSW748bDe3bdfM8cMQ
 vtJiM/IU/IuAptG8IwT7Gz7de9PUJRRWsPY4dKd3K1H4mRXNNAEvxrj2FBoZagNPVDEEI6ZPib1
 K3ZBhQ4psNySF1QngstLmmhv4u+AoWuAhV9UPuUmdPwN2WxNYMave0hb9+I86PogEbBLsaDJwAf
 MDWsAPx4IUTReAnDC75nDlSg9S+SsffXfNtel3XJaH5LvHyImw==
X-Google-Smtp-Source: AGHT+IHOkA80ap5RIeJgo63z5h4eCz6qcntPtSfCzMwCVx1Kk/YGHr6BIFunVI+04vSaXPAxBIebeA==
X-Received: by 2002:a17:903:46cc:b0:221:89e6:ccb6 with SMTP id
 d9443c01a7336-2292ef33b00mr162809765ad.25.1743422650333; 
 Mon, 31 Mar 2025 05:04:10 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291eedfde5sm67526105ad.78.2025.03.31.05.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:04:09 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH 1/2] target/ppc: Big-core scratch register fix
Date: Mon, 31 Mar 2025 22:03:55 +1000
Message-ID: <20250331120357.584561-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331120357.584561-1-npiggin@gmail.com>
References: <20250331120357.584561-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

The per-core SCRATCH0-7 registers are shared between big cores, which
was missed in the big-core implementation. It is difficult to model
well with the big-core == 2xPnvCore scheme we moved to, this fix
uses the even PnvCore to store the scrach data.

Also remove a stray log message that came in with the same patch that
introduced patch.

Fixes: c26504afd5f5c ("ppc/pnv: Add a big-core mode that joins two regular cores")
Cc: qemu-stable@nongnu.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/misc_helper.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 2d9512c116b..46ae454afd3 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -332,6 +332,10 @@ target_ulong helper_load_sprd(CPUPPCState *env)
     PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
     target_ulong sprc = env->spr[SPR_POWER_SPRC];
 
+    if (pc->big_core) {
+        pc = pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1);
+    }
+
     switch (sprc & 0x3e0) {
     case 0: /* SCRATCH0-3 */
     case 1: /* SCRATCH4-7 */
@@ -368,6 +372,10 @@ void helper_store_sprd(CPUPPCState *env, target_ulong val)
     PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
     int nr;
 
+    if (pc->big_core) {
+        pc = pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1);
+    }
+
     switch (sprc & 0x3e0) {
     case 0: /* SCRATCH0-3 */
     case 1: /* SCRATCH4-7 */
@@ -378,7 +386,6 @@ void helper_store_sprd(CPUPPCState *env, target_ulong val)
          * information. Could also dump these upon checkstop.
          */
         nr = (sprc >> 3) & 0x7;
-        qemu_log("SPRD write 0x" TARGET_FMT_lx " to SCRATCH%d\n", val, nr);
         pc->scratch[nr] = val;
         break;
     default:
-- 
2.47.1


