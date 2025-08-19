Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C139CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoR0n-000860-Re; Tue, 19 Aug 2025 14:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR0g-0007HH-1t; Tue, 19 Aug 2025 14:24:38 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR0d-0003yG-8Y; Tue, 19 Aug 2025 14:24:37 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b471756592cso3862706a12.3; 
 Tue, 19 Aug 2025 11:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627873; x=1756232673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i6f7sVT4bGYsPhkhxxnC/Q6xqoXFxbpoICuYkhSX10A=;
 b=gZ5yFs+tcZky0TEOki1x7JUBNTlj/MzKlh07yY7agJjvCRMcilp/ibeiZzy1KnIRpa
 /8wswvDqIOpX3vBEF1rDlkxVy1VhpElGIzGug3EMF8lZL1wRJ09+R6SfVHjsAM0fg4iI
 yEv2camTtcvACMNcuL9VnkPp8wYYN8H6KbUNnfzSjk0VesTHs2MFXL24kg/92lxwmhr6
 O5ttXwKWS5C75ESobj50kt9SmV7OZGbRxJvtvtQ1R+2X3iGZh5iZxw8+Yh7yJKiM2ro+
 p70LAUkwY4FW2qadWjYDZiXGi4DcR7Y0ii4VjidmWSCSTz80BKy/K/i6jDg5vGL/bZjR
 oG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627873; x=1756232673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i6f7sVT4bGYsPhkhxxnC/Q6xqoXFxbpoICuYkhSX10A=;
 b=teS4X7HWUfeRH4MwkTGmQkqOByvZOgd3CuqFqGTBWbbUhBCXdkrvih0fWgKtEOLBWf
 dUhcaz7fGCctx5dgMwCBxrrQxDdp4H/vS54qBozWSvJU69bYRjYVnS16b99+qoHgnmje
 b0oyubTOhDsl+pZPFMD3y+QgyA1M/wLNv4y74uOzalp1OBBZQNWdrSV274sXhriLUxjF
 ZiW4gWlM43qtqDr6h2nti/N5FMROwn+Sx8oFIDjtbgFzIn9gWBvBY/jcj/gi0nQw5XJl
 ynk+3WlLlhVW2DhK68lj04XRj0CkFHdm5S/MZsQVMoGLEmp2bI1W+v/qUJuufb6bwccb
 VUkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHTtytr6mYfnsJRCuSAABRNN2EpRKq4a85YrI627KxhuoI1xKlwjC0X112ihDqBPSzWAokNCDA+fTz3w==@nongnu.org,
 AJvYcCX4WCWtZdAPjB5U1+WJ9lpRx2a96hgkIFfvZAKVhACTkw0PTHXmcZH2xG2HYPBbyTPTHn/S6FbxkQ==@nongnu.org
X-Gm-Message-State: AOJu0Yyy0nQNTyTBqxUHn4Drc3t6yeBPidiXi4yPDBTebtJ8hyb8RiV7
 Erv3IWYGQSDZhZRDMqUfwBRf89niUJAoqI/bdbZLAzFk7omSQXLTMR+xQsfWvHML
X-Gm-Gg: ASbGncsmogQLXU90zelXckRmVEYdwCsKj85z7m8DNH3SS1iELaWRXsS03w4i4WWSptt
 tztG98RDDahgsqtxkpsclLR/G63p/3io6FkmLzC7jYoQBtSBPS/kyz1z0ilGoPNoScajiFc0ovp
 fHd+XWv/DusuCZy8chmLpx9U3e3yj3ePslE5PN5ahTJ1sPrxs6pnTQqbcUeJ7388CNeSOFi9g9Q
 jjMI+ZdczZND6r8XjIiske5EdpUWbSkBD04BnP+SFno3ifz5fib3tB8Zz/ZCBtUKmwqAbZzxliH
 Ty37lYOs+2Q74k11ArK+FKyfspyXlzgcdMqH/UVZB3HA9nMI3ByHwBLXye6WfV6mieb7jnul5UK
 FPQyxgwHmYdFRwauL5pPvxplklE/Nqnob
X-Google-Smtp-Source: AGHT+IEy/0Agp5IS6C8/NwyH610FoMQVkjWxGkrobBfEBNSM11Dp8E1r/XXFQWWpYkW0NCusONsDQQ==
X-Received: by 2002:a17:902:f64d:b0:240:8ce5:f514 with SMTP id
 d9443c01a7336-245e0470413mr49560815ad.34.1755627872830; 
 Tue, 19 Aug 2025 11:24:32 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:24:32 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH 21/35] tcg/wasm: Add neg/not/ctpop instructions
Date: Wed, 20 Aug 2025 03:21:50 +0900
Message-ID: <0eb3445353ddde2f34bac187bf8d3ecf02f106b4.1755623522.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52c.google.com
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

The Wasm backend implements only TCG_TARGET_REG_BITS=64 so the ctpop
instruction is generated only for 64bit operations, as declared in
cset_ctpop. Therefore, this commit adds only the 64bit version of ctpop
implementation.

The tgen_neg function was used by several functions and intended to emit TCI
code. So it have been renamed to tgen_neg_tci.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm/tcg-target.c.inc | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index 3c0374cd01..0ba16e8dce 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -180,6 +180,7 @@ typedef enum {
     OPC_I32_SHR_U = 0x76,
     OPC_I32_ROTR = 0x78,
 
+    OPC_I64_POPCNT = 0x7b,
     OPC_I64_ADD = 0x7c,
     OPC_I64_SUB = 0x7d,
     OPC_I64_MUL = 0x7e,
@@ -499,6 +500,29 @@ static void tcg_wasm_out_nor(
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
 }
 
+static void tcg_wasm_out_neg(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg));
+    tcg_wasm_out_op_not(s);
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, 1);
+    tcg_wasm_out_op(s, OPC_I64_ADD);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+}
+
+static void tcg_wasm_out_not(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg));
+    tcg_wasm_out_op_not(s);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+}
+
+static void tcg_wasm_out_ctpop64(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg));
+    tcg_wasm_out_op(s, OPC_I64_POPCNT);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+}
+
 static void tcg_wasm_out_setcond(TCGContext *s, TCGType type, TCGReg ret,
                                  TCGReg arg1, TCGReg arg2, TCGCond cond)
 {
@@ -1609,6 +1633,7 @@ static const TCGOutOpBinary outop_xor = {
 static void tgen_ctpop(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tcg_out_op_rr(s, INDEX_op_ctpop, a0, a1);
+    tcg_wasm_out_ctpop64(s, a0, a1);
 }
 
 static TCGConstraintSetIndex cset_ctpop(TCGType type, unsigned flags)
@@ -1665,9 +1690,15 @@ static const TCGOutOpUnary outop_bswap64 = {
 };
 #endif
 
-static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+static void tgen_neg_tci(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tcg_out_op_rr(s, INDEX_op_neg, a0, a1);
+ }
+
+static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tgen_neg_tci(s, type, a0, a1);
+    tcg_wasm_out_neg(s, a0, a1);
 }
 
 static const TCGOutOpUnary outop_neg = {
@@ -1678,6 +1709,7 @@ static const TCGOutOpUnary outop_neg = {
 static void tgen_not(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tcg_out_op_rr(s, INDEX_op_not, a0, a1);
+    tcg_wasm_out_not(s, a0, a1);
 }
 
 static const TCGOutOpUnary outop_not = {
@@ -1710,7 +1742,7 @@ static void tgen_negsetcond(TCGContext *s, TCGType type, TCGCond cond,
                             TCGReg dest, TCGReg arg1, TCGReg arg2)
 {
     tgen_setcond_tci(s, type, cond, dest, arg1, arg2);
-    tgen_neg(s, type, dest, dest);
+    tgen_neg_tci(s, type, dest, dest);
     tcg_wasm_out_negsetcond(s, type, dest, arg1, arg2, cond);
 }
 
-- 
2.43.0


