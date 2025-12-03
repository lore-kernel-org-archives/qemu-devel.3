Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2660D12D77
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 15:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQoNA-0007kg-FN; Wed, 03 Dec 2025 10:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQoN7-0007kS-UX
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 10:02:26 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQoN5-0008Ui-Nf
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 10:02:25 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so52967225e9.2
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 07:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764774142; x=1765378942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ifKfVnKlJ4a+G+6RwB5PXhDNWtWYycaJHQnGsuoBwkQ=;
 b=oL0HoVe2La4jq9MiPD/CTU3z3UKDV1LiVH8axIVcClTnT7bmO5yM6kLL8INr54RYBd
 OInF9X7uXa2p3xMia9Yl/TstQ1fV76Ifs9oKqMN6CeWkRZLsegYjruSF5H2pVEDDhZCU
 me7u2tT0FmGD5RrkLlqCVsmwiM1F5zNIAodMjEJT9tKmztexZuMVew5JpeI/vjn5A+gG
 3hYz5hDil8OO8zXaLk/Xc3Fza8SJ8Ae+QR3LIf3Tjo4K03iH97dezZwQfgfIas7ozWoO
 Alu/44eccCVujSsqhn0UuhCsnroou68xf80nCpd7AfZJQoRmnLoxcras2SsYIC0Gry36
 GxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764774142; x=1765378942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ifKfVnKlJ4a+G+6RwB5PXhDNWtWYycaJHQnGsuoBwkQ=;
 b=fOklXcYuuTwj8GMJ+gsizap98kCDItm4ffiv8LnYjmYevypNLnXStLn++2vh/j0Rja
 wwtaMWU9iV4dwfB3g687VroUIOHG0r7NMk76jAVkH7azT6KlzeDyVQYBPSdUF1G0sZw9
 HRFLtX/qbLxbOQFjv981xgmQXNTCuN/rUMUHnC5r6rAerkSbaLmv+HNWGbIjpICM/Q3i
 7mXP1NVjldaeuoD4x86RzZ/tcyq8bsef4QO2bjBdASLWJnB42dhSIxpq7+6k2W6nKrht
 N9tXkZXv26brcE0Ka+Pn8nQQ1MUgqXvLTY55oJKHZPR9Z7CMor6ALICIwAX4vtqWww+U
 VLUA==
X-Gm-Message-State: AOJu0YwfBErYOVZzCHWMAQlAxqebTN884ZXdq79AzRPQyv1YS4/AyhV8
 vQWRJqm9kg+61YIIKDTnljYx+v2biE4GXnts36rpCCdmLOYmRyvzVNlXQ4G0uit5RnR6l/DMrBy
 TbQxwrVA=
X-Gm-Gg: ASbGnctz2iXr8kBxCJJLyyTksjuFhINU+qCVPOxIw76VXsq0LYGKc+ymKFL8yeqMVc6
 JNm7Eg9FdKOYc+ITPU+5XBkrj16gJUstF/VHVNG3CL5l9lr4yK3YD3Dz6kKbapgBFjODYimwZpo
 FqUE7jhOWOsicUVTFi7gy0DCfkGThTYif2TI9l8Gm82NS2AoQLwXn+o2hwP6Ik67MScNe3PXdX2
 dy/GClUU8dNi2kpQ0qcn0ykVVNvM9iUyZAo/9x8hjqyl89GBiPzFaakyE5dL7/9XHz7G9usn8RD
 sKEY+ivMuqCDl/wZGklVwPyKCZLWJEdVQPAqkJucWl+AHT47iS2DRh5iSDnzXN8SG2X7VSH5Do5
 TzqUueUnB2dLFfp0l6U2+MIvOV7dhydRztrR4wgv+OYYewYV9WqiVfQIB5pfw+jR5sRhnhgF0nb
 gXs/gtwiurfVAawhq61fkP7fc/XyyNZe+PZbyaghKBayVsaqtowautjjNwNu2S
X-Google-Smtp-Source: AGHT+IHsVyA3BpAz2WKazQLAph6AyPebxHuUkFjxOtPh8Il4NemOWL3FC7vqVin9hVgRzP6KI9iJDg==
X-Received: by 2002:a05:600c:3789:b0:477:7d94:5d0e with SMTP id
 5b1f17b1804b1-4792af3f93emr18259235e9.27.1764774141586; 
 Wed, 03 Dec 2025 07:02:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792b02ba67sm22270425e9.2.2025.12.03.07.02.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Dec 2025 07:02:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/3] tcg/tci: Introduce INDEX_op_tci_qemu_{ld,st}_rrr
Date: Wed,  3 Dec 2025 16:02:10 +0100
Message-ID: <20251203150212.66098-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251203150212.66098-1-philmd@linaro.org>
References: <20251203150212.66098-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Richard Henderson <richard.henderson@linaro.org>

Since d182123974c4, the number of bits in a MemOpIdx
tops out at 17.  This fixes an assert in tcg_out_op_rrm.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251202011228.503007-2-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/tci/tcg-target-opc.h.inc |  2 ++
 tcg/tci.c                    | 19 +++++++++++++++++++
 tcg/tci/tcg-target.c.inc     | 14 ++++++++++++--
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/tcg/tci/tcg-target-opc.h.inc b/tcg/tci/tcg-target-opc.h.inc
index 4eb32ed7361..f8bfffc1251 100644
--- a/tcg/tci/tcg-target-opc.h.inc
+++ b/tcg/tci/tcg-target-opc.h.inc
@@ -13,3 +13,5 @@ DEF(tci_rotl32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_rotr32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_setcond32, 1, 2, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_movcond32, 1, 2, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_qemu_ld_rrr, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_qemu_st_rrr, 0, 3, 0, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/tci.c b/tcg/tci.c
index 700e6726169..e15d4e8e08b 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -794,12 +794,24 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             taddr = regs[r1];
             regs[r0] = tci_qemu_ld(env, taddr, oi, tb_ptr);
             break;
+        case INDEX_op_tci_qemu_ld_rrr:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            taddr = regs[r1];
+            oi = regs[r2];
+            regs[r0] = tci_qemu_ld(env, taddr, oi, tb_ptr);
+            break;
 
         case INDEX_op_qemu_st:
             tci_args_rrm(insn, &r0, &r1, &oi);
             taddr = regs[r1];
             tci_qemu_st(env, taddr, regs[r0], oi, tb_ptr);
             break;
+        case INDEX_op_tci_qemu_st_rrr:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            taddr = regs[r1];
+            oi = regs[r2];
+            tci_qemu_st(env, taddr, regs[r0], oi, tb_ptr);
+            break;
 
         case INDEX_op_qemu_ld2:
             tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
@@ -1050,6 +1062,13 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            op_name, str_r(r0), str_r(r1), oi);
         break;
 
+    case INDEX_op_tci_qemu_ld_rrr:
+    case INDEX_op_tci_qemu_st_rrr:
+        tci_args_rrr(insn, &r0, &r1, &r2);
+        info->fprintf_func(info->stream, "%-12s  %s, %s, %s",
+                           op_name, str_r(r0), str_r(r1), str_r(r2));
+        break;
+
     case INDEX_op_qemu_ld2:
     case INDEX_op_qemu_st2:
         tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 35c66a48369..532f87262c4 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -1188,7 +1188,12 @@ static const TCGOutOpStore outop_st = {
 static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data,
                          TCGReg addr, MemOpIdx oi)
 {
-    tcg_out_op_rrm(s, INDEX_op_qemu_ld, data, addr, oi);
+    if (oi & ~0xffff) {
+        tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, oi);
+        tcg_out_op_rrr(s, INDEX_op_tci_qemu_ld_rrr, data, addr, TCG_REG_TMP);
+    } else {
+        tcg_out_op_rrm(s, INDEX_op_qemu_ld, data, addr, oi);
+    }
 }
 
 static const TCGOutOpQemuLdSt outop_qemu_ld = {
@@ -1213,7 +1218,12 @@ static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
 static void tgen_qemu_st(TCGContext *s, TCGType type, TCGReg data,
                          TCGReg addr, MemOpIdx oi)
 {
-    tcg_out_op_rrm(s, INDEX_op_qemu_st, data, addr, oi);
+    if (oi & ~0xffff) {
+        tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, oi);
+        tcg_out_op_rrr(s, INDEX_op_tci_qemu_st_rrr, data, addr, TCG_REG_TMP);
+    } else {
+        tcg_out_op_rrm(s, INDEX_op_qemu_st, data, addr, oi);
+    }
 }
 
 static const TCGOutOpQemuLdSt outop_qemu_st = {
-- 
2.51.0


