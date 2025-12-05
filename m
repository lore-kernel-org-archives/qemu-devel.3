Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069C9D3398E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 16:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRYXd-00048c-SY; Fri, 05 Dec 2025 11:20:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRYXb-00047G-LN
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:20:19 -0500
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRYXZ-0001YZ-QK
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:20:19 -0500
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-8b2d32b9777so299226985a.2
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 08:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764951616; x=1765556416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6fPJsTPDa10TALVbynk3C88yXdX6ZHPLfRrmJzOfuL4=;
 b=OqpMyRuNRsXJ4HUztR8nP5RkZ/Nz5pG+ORFbc3bcn0jXBxlfccHzNJR0FiY5UVvrUU
 5bdjLNN5YSET2xY+Y+GK+oG6Y/Ln+qNd10PvLYuqbmeyBe8oPM9QlbKMbzPMnIdPDmdx
 dG1/ENgt0nt9yZN+F/27BIV/CxcvUi1SC2J4gJMeBi0gL4jetpFz8nUicFyb93GAPPuo
 h1ebhITs0zZCM36+BgGqikuFcYV7+//HbQOjFjmi0DQt1ATNl+8+oyEmJjMC0e3oeWqv
 UK+my6zpPGQhNcynif5GUjURnxd6w0INYPlETvXE4IMQeELW/mtO4SxB7pxLKyYiZFAO
 9nwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764951616; x=1765556416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6fPJsTPDa10TALVbynk3C88yXdX6ZHPLfRrmJzOfuL4=;
 b=jf4Vp5uK9GbOteRyt9+EFWkP4CHhuQDL4IEIoMdklvYnM1q77UG2IPAtez3HFjDbGt
 KWF0kRyFRbEdxLATS0zj+Ots66HlZYdxGbh4HBvpv1aglz3TVlZPIePY9F76k20enlN9
 L1CzzaGTwSBUO+/TAC23/6+XC4JQqjVWahyPlTdd1+DsyR8r+IQvIPz2EjFWiVdSf9sC
 dvCbZ3UaWSpF8RD/9e6vevd0BQu83LDB0pw8EWpoEkYbYH7wNqofHtfIop4sQpiNQXik
 +HwJ0tSK5e0Bi5ECOuKzixyPALdYY+NGiuGznkoQTObOdmOpR5vZKFuXa6USPZlXJldt
 jDTg==
X-Gm-Message-State: AOJu0Ywmgv2/S+zyk9D6TD5AQe5sKQsuinJx7b1DX+4wjcPwQexNUJwI
 z47MhmP7UjvINTcnD07fOgulnRC7qYmdDDoAAR83XGFNKEd2HD287Xc7OjHVwlelH9DfnFpQi3U
 Xw7uWbi0=
X-Gm-Gg: ASbGncuYyWjGpOzyqRzEYz5I29GAtBrRrAfkSI45ZyQxM8cjiwO7p7CsKbwrMEslbRc
 qEOtHKphBRi88iWjbgAWIoleH+72EDy7uxUGBns7AsSiyTCbdse/yZgVkpgdtSl81FJkVQPMLbz
 YTOMd+aE873QLF2Ynk92yhepg172l17+d5NtB5KFcFEJuMABN05C0VUIWQx26kwus1SkU+5hxHg
 1HY0iKQgN+1lC2UHqBQSuCaRRVuZKbPbcQY41tWtvF478rwl3Vml1q8q6TPaXz8kIxRf8pdlJpO
 cLGLTQnMWcoN4S75IBcJRb8NLIl7do56TEHZHjIWx/BT2E1vIuEG3Ps0/e60+paEulb5gww69rs
 flAS85P075cpjCVDT/bTTKXnROTR6YNTZKh+1oPy2Zi3xgYph2aTwet4FMH2/oN+9ARTFs/Alzj
 6qx6Wg4OU7e/3odzdDOLzfUJxFm6UahpjQ94RieLj1le9uKWGKDxrw+QJvyj0cSRWywTY=
X-Google-Smtp-Source: AGHT+IFKIVk7fUDFXP8+57tmdLOf4bXxkzzOIlu8P+T33nzzIDk7LyYAwIjBFqyJvYCo6KrbLzlsEA==
X-Received: by 2002:a05:620a:4142:b0:8b2:ea33:389d with SMTP id
 af79cd13be357-8b5e47ceff6mr1445515185a.4.1764951616273; 
 Fri, 05 Dec 2025 08:20:16 -0800 (PST)
Received: from stoup.. ([172.56.17.137]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88830bfc22dsm21591636d6.43.2025.12.05.08.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 08:20:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/6] tcg/tci: Introduce INDEX_op_tci_qemu_{ld,st}_rrr
Date: Fri,  5 Dec 2025 10:20:03 -0600
Message-ID: <20251205162007.26405-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205162007.26405-1-richard.henderson@linaro.org>
References: <20251205162007.26405-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x736.google.com
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

Since d182123974c4, the number of bits in a MemOpIdx tops out at 17.
which won't fit in the TCI rrm format, thus an assertion failure.
Introduce new opcodes that take the MemOpIdx from a register, as
we already do for qemu_ld2 and qemu_st2.

Fixes: d182123974c4 ("include/exec/memopidx: Adjust for 32 mmu indexes")
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci.c                    | 19 +++++++++++++++++++
 tcg/tci/tcg-target-opc.h.inc |  2 ++
 tcg/tci/tcg-target.c.inc     | 14 ++++++++++++--
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/tcg/tci.c b/tcg/tci.c
index 700e672616..e15d4e8e08 100644
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
diff --git a/tcg/tci/tcg-target-opc.h.inc b/tcg/tci/tcg-target-opc.h.inc
index 4eb32ed736..f8bfffc125 100644
--- a/tcg/tci/tcg-target-opc.h.inc
+++ b/tcg/tci/tcg-target-opc.h.inc
@@ -13,3 +13,5 @@ DEF(tci_rotl32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_rotr32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_setcond32, 1, 2, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_movcond32, 1, 2, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_qemu_ld_rrr, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_qemu_st_rrr, 0, 3, 0, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 35c66a4836..532f87262c 100644
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
2.43.0


