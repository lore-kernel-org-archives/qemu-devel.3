Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99652ECE57B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniBy-0004pC-5B; Mon, 09 Sep 2024 13:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBu-0004dp-Mz
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:42 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBt-00062t-4d
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:42 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-206e614953aso36150965ad.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725902920; x=1726507720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gH4TiQd0zre/48UyAuTgFyxk/rLl6wXtwZdFEj9L1dg=;
 b=Vmh9HKy28zjmkGkxn/IbVLUoCMqwjRz7FY4MEPYjTFXSgbHNUeeCCFLzViNDB0Lll2
 phqkEvm+BtX3bgRK6raw5y+DPVaz1exEHgzoKJDq50kSYnSAtmGNVQ2hHlqWPQnAfMmr
 wzPxEMtW/mosUd/USk7ygQw8L7XMy+bghhFxTUM975Ddipcwp1gCes7VZ855IaZ/2hGK
 pBXv9K/GnSTipDvjdgJFhxkA+J5GMiUHlm8W8chak+wCHLQrsblFmizkyWLfEUo2xKWA
 oUirWtR9IA3MdpG7I3mP4MvXEhz25LfN5Tt9GMizxWZa+1TIbZc7c0c3Zl25BwwHHUAf
 9dAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725902920; x=1726507720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gH4TiQd0zre/48UyAuTgFyxk/rLl6wXtwZdFEj9L1dg=;
 b=oIiP8gqLxitcw/BJ977sOKFs8upoQIHrdD40I3cAgLL1rg46JVT1ntLxyzTxETeJVg
 /cIoj9yVQanXw2JaD875qHBFZ635aeIRxnMyWuNRGVpdR6BK8QVLdOjKcuK4BkXGlJ36
 AZZsv2wh9JBPu3/lAcI6sYbBKuDPbso67qBVc082i0hsyDV/lncMZCL9RdwVsArQaMZY
 0lvPQx5Dbh81Rh9n/nnqH5SpOA74x8qNWpPEdxLkkc/tYEogX/VO0sord0o9cv9Ki4Qe
 ItC/Kq3+1097cUp2xWEHdxZgeDkPfoA6aX3zHOOMX4bkjKpk4CgIQXFyA/gQawJ90Thp
 AFUg==
X-Gm-Message-State: AOJu0YzTCY6Om/HuFOs+gED55tlUn+Kpe6FXuPUigMoW6p59TALu+c9z
 Gh60quG/nhrPRHNSwY/kRrQIMo5TNQMwRqOlhH2OCpfCbQQWrqLiuT+kPX2+zFJBmKhHEuj/sdp
 /
X-Google-Smtp-Source: AGHT+IFiizCmIYRhKFglJ5EQkCRO/P6yjf+NZtscD7lImP+vLQgsUB5zB2gAM6l6lr/DaZgYn3VMLA==
X-Received: by 2002:a17:903:234c:b0:205:8407:631d with SMTP id
 d9443c01a7336-2070c077244mr119400695ad.13.1725902919804; 
 Mon, 09 Sep 2024 10:28:39 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e11e02sm36539875ad.14.2024.09.09.10.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 10:28:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	daniel@0x0f.com
Subject: [PATCH v3 16/26] target/m68k: Remove env argument to gen_load_mode
Date: Mon,  9 Sep 2024 10:28:13 -0700
Message-ID: <20240909172823.649837-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909172823.649837-1-richard.henderson@linaro.org>
References: <20240909172823.649837-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Use the env pointer in DisasContext.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 938c650c78..a3452ace96 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -775,9 +775,8 @@ static TCGv gen_lea(CPUM68KState *env, DisasContext *s, uint16_t insn,
  * a write otherwise it is a read (0 == sign extend, -1 == zero extend).
  * ADDRP is non-null for readwrite operands.
  */
-static TCGv gen_load_mode(CPUM68KState *env, DisasContext *s,
-                          int mode, int reg0, int opsize, TCGv *addrp,
-                          int sign, int index)
+static TCGv gen_load_mode(DisasContext *s, int mode, int reg0, int opsize,
+                          TCGv *addrp, int sign, int index)
 {
     TCGv reg, ret, addr = NULL;
     int32_t offset;
@@ -798,19 +797,19 @@ static TCGv gen_load_mode(CPUM68KState *env, DisasContext *s,
             /* Immediate: sign extend values for consistency.  */
             switch (opsize) {
             case OS_BYTE:
-                offset = read_im8(env, s);
+                offset = read_im8(s->env, s);
                 if (sign) {
                     offset = (int8_t)offset;
                 }
                 break;
             case OS_WORD:
-                offset = read_im16(env, s);
+                offset = read_im16(s->env, s);
                 if (sign) {
                     offset = (int16_t)offset;
                 }
                 break;
             case OS_LONG:
-                offset = read_im32(env, s);
+                offset = read_im32(s->env, s);
                 break;
             default:
                 g_assert_not_reached();
@@ -1323,7 +1322,7 @@ static void gen_exit_tb(DisasContext *s)
 
 #define SRC_EA(env, result, opsize, op_sign, addrp)                     \
     do {                                                                \
-        result = gen_load_mode(env, s, extract32(insn, 3, 3),           \
+        result = gen_load_mode(s, extract32(insn, 3, 3),                \
                                REG(insn, 0), opsize, addrp,             \
                                op_sign, IS_USER(s));                    \
         if (IS_NULL_QREG(result)) {                                     \
@@ -1699,10 +1698,8 @@ DISAS_INSN(abcd_mem)
 
     /* Indirect pre-decrement load (mode 4) */
 
-    src = gen_load_mode(env, s, 4, REG(insn, 0), OS_BYTE,
-                        NULL, false, IS_USER(s));
-    dest = gen_load_mode(env, s, 4, REG(insn, 9), OS_BYTE,
-                         &addr, false, IS_USER(s));
+    src = gen_load_mode(s, 4, REG(insn, 0), OS_BYTE, NULL, false, IS_USER(s));
+    dest = gen_load_mode(s, 4, REG(insn, 9), OS_BYTE, &addr, false, IS_USER(s));
 
     bcd_add(dest, src);
 
@@ -1735,10 +1732,8 @@ DISAS_INSN(sbcd_mem)
 
     /* Indirect pre-decrement load (mode 4) */
 
-    src = gen_load_mode(env, s, 4, REG(insn, 0), OS_BYTE,
-                        NULL, false, IS_USER(s));
-    dest = gen_load_mode(env, s, 4, REG(insn, 9), OS_BYTE,
-                         &addr, false, IS_USER(s));
+    src = gen_load_mode(s, 4, REG(insn, 0), OS_BYTE, NULL, false, IS_USER(s));
+    dest = gen_load_mode(s, 4, REG(insn, 9), OS_BYTE, &addr, false, IS_USER(s));
 
     bcd_sub(dest, src);
 
@@ -3119,11 +3114,9 @@ DISAS_INSN(cmpm)
     TCGv src, dst;
 
     /* Post-increment load (mode 3) from Ay.  */
-    src = gen_load_mode(env, s, 3, REG(insn, 0), opsize,
-                        NULL, true, IS_USER(s));
+    src = gen_load_mode(s, 3, REG(insn, 0), opsize, NULL, true, IS_USER(s));
     /* Post-increment load (mode 3) from Ax.  */
-    dst = gen_load_mode(env, s, 3, REG(insn, 9), opsize,
-                        NULL, true, IS_USER(s));
+    dst = gen_load_mode(s, 3, REG(insn, 9), opsize, NULL, true, IS_USER(s));
 
     gen_update_cc_cmp(s, dst, src, opsize);
 }
-- 
2.43.0


