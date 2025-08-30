Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5137ACA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 18:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNvp-0007Dm-Qp; Sat, 30 Aug 2025 11:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usELg-0005ri-Fd
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:01 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usELe-00045q-IO
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:00 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b471737b347so1849890a12.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532517; x=1757137317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9BLUtzvTW8VOTUOKS/GDDwgNmXTZirSsYLUXuCw4aI8=;
 b=GVPQhE6D+/2NFr5hi7rRy7Koe8IOWhhEIruX+WoTcMnUCofodVrGOBRoCcd2Cqy/8l
 Xe7DzOFqz8+Y4PCJDJgVkBuRZsNEOX0NlP7AsBk55CPmmeYk7jaAWWMQRghjjA+4+mWr
 UqvdSt3ghDqCHj4C986W8iUR/TgIbvomSJNAufDNT4CJI9XA0yYaVSDmo8L2FNzZsuqB
 hK4WpdeOmwO1Xj96E47Vl02gNHN61lEoKv0HoIvNrmmyu2q1A8ORW/VlN8hUhHYDOh6E
 axdCCpkabXGQfPZgUg2gVVgtOuEUXre1Zw5ygBNhahuG/Fe8OeasH4kPCTjK5tcl9Ae2
 SDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532517; x=1757137317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9BLUtzvTW8VOTUOKS/GDDwgNmXTZirSsYLUXuCw4aI8=;
 b=M5Kiv1p+H4XmDdF7G8HdmFmxTuwL7vtXVM7YYw8/0DOXH0t83M2ZTRhGEbM4EmacyK
 zdoH2Oi7odoS0dcXSF3IvLxDk7AAi2xu4eh4NJZVtMZwoeGBE3m89lPdwmeX4DZWir4N
 GoJ0STjAbpbFfsIVX15ysWSvEjmhWXcxG0p+o7L8Y+YNMSqHt0zTz0bvPjf5opaA+j4v
 mbEiHIyQdEN7unxSVg1b3ho63+egjn6X33AHf4aTqLksnnI5LA+LUWelgISlUXD3hLuY
 ByIpFCx1DzzdShqIkLpWpdV3ogm4XMDyDL+256THyenIgleZ0h+kE/Dp7YLxbuYdI6Ha
 0kxw==
X-Gm-Message-State: AOJu0Yy1jq8gGXCBfzB+wfFuqbUuTMS7pgcd9UolANlkTL0VZFznpYKb
 TUEAsTdZU1Vu+ZBaTv7W4+rIt0MKiewsN1OvVauaPRtbXQJMXsq6x9ps7g3OdZAF3mVezDerREX
 W4llF/zo=
X-Gm-Gg: ASbGncuBG82k0uJu6w+4F7CYOPIQ6OHFELdXfeE2K1UeXiPAzNN6uZYopCTQLuD5Wnz
 FRuLXPPG9HefuvidMHZMyteQpzLfntQ3csysvmNjM9jyjCp7cdaQHPOCATjqXAVAVqWyOEdI8jw
 jyV7MCX636pCFodDbrEPAa3piCn8s7Rn380VImALBUuk6672EQyjyli7SHq56ToTBSkDSU4OcfC
 n4Yk+9qFCHdNLLT8jH1f1VEBvwkceyhXjU0wxe0MK+5Uf1OzgycAmKCZSC+RaKg9tKrdrIc/CmX
 ytBnjyKXQNSsPyuAmrmAW3N8Utnvw3t8MkNij9cjq+6+kllo14Rqn1jOz6jIUlcRuTuDU5t0sy5
 4Pd//gY0SgzCBQyKDS9NPlHlRn/H9XfxjjxaJhRx8aBaqeCyfsNoWuFlk7FB+
X-Google-Smtp-Source: AGHT+IGRx6XlzDBJicXk7N1gLw2pxXyUfoeJK/CfWNY5/uwO12HjvS9R2iUl/Vx6dX23xjvllcIwJw==
X-Received: by 2002:a05:6a20:914a:b0:243:9f98:ff33 with SMTP id
 adf61e73a8af0-243d6f0308dmr1641639637.37.1756532516699; 
 Fri, 29 Aug 2025 22:41:56 -0700 (PDT)
Received: from stoup.. (122-150-204-48.dyn.ip.vocus.au. [122.150.204.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4d96829a66sm2435905a12.6.2025.08.29.22.41.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:41:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 08/84] target/arm: Skip AF and DB updates for AccessType_AT
Date: Sat, 30 Aug 2025 15:40:12 +1000
Message-ID: <20250830054128.448363-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

We are required to skip DB update for AT instructions, and
we are allowed to skip AF updates.  Choose to skip both.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 8925c9a610..089eeff845 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -58,6 +58,12 @@ typedef struct S1Translate {
      * and will not change the state of the softmmu TLBs.
      */
     bool in_debug;
+    /*
+     * in_at: is this AccessType_AT?
+     * This is also set for debug, because at heart that is also
+     * an address translation, and simplifies a test.
+     */
+    bool in_at;
     /*
      * If this is stage 2 of a stage 1+2 page table walk, then this must
      * be true if stage 1 is an EL0 access; otherwise this is ignored.
@@ -1929,7 +1935,12 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     descaddr &= ~(hwaddr)(page_size - 1);
     descaddr |= (address & (page_size - 1));
 
-    if (likely(!ptw->in_debug)) {
+    /*
+     * For AccessType_AT, DB is not updated (AArch64.SetDirtyFlag),
+     * and it is IMPLEMENTATION DEFINED whether AF is updated
+     * (AArch64.SetAccessFlag; qemu chooses to not update).
+     */
+    if (likely(!ptw->in_at)) {
         /*
          * Access flag.
          * If HA is enabled, prepare to update the descriptor below.
@@ -3553,6 +3564,7 @@ bool get_phys_addr_for_at(CPUARMState *env, vaddr address,
     S1Translate ptw = {
         .in_mmu_idx = mmu_idx,
         .in_space = space,
+        .in_at = true,
         .in_prot_check = prot_check,
     };
     /*
@@ -3653,6 +3665,7 @@ static hwaddr arm_cpu_get_phys_page(CPUARMState *env, vaddr addr,
         .in_mmu_idx = mmu_idx,
         .in_space = arm_mmu_idx_to_security_space(env, mmu_idx),
         .in_debug = true,
+        .in_at = true,
         .in_prot_check = 0,
     };
     GetPhysAddrResult res = {};
-- 
2.43.0


