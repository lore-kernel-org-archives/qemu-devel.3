Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488A8CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoR0i-0007XE-Nn; Tue, 19 Aug 2025 14:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR0a-0007Bf-Fb; Tue, 19 Aug 2025 14:24:33 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR0X-0003xb-Sj; Tue, 19 Aug 2025 14:24:31 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b471754c159so3818632a12.3; 
 Tue, 19 Aug 2025 11:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627867; x=1756232667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Uxl4hRz+IS3ofUlHMTimcLwfnwpWGHBSdo9rZYe2Aw=;
 b=lA/cDKtvbNT3e+Xfd2A5PlJdZTsOFBIl1KKuALUolntb9M4SnZrYrlpTJuGPWLauA5
 6sF4Lh4iBrAVbWL4B/1tacioqma1049MTuevd8ehhWVBdTyAFzgvR0FEs26WMJ7J9fBA
 twuV2Uk1njTOZhmXYEoMCvW4Eve8Z0jig99nCMimy7q0WmRfTuYVor510F/KXnEt2FfB
 j8upAYEZegh62ieXgPbjXsWrQNPRCq0poQg9NXqtdjB9GeOrGWvvRht2Cv1Tb73R9vqo
 I/xG3G6dXAqVwiJO0drEFhXabneRdbr8JE6f3ohGhyjRCoDkosPXjtnF94e72/aCnT9X
 rB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627867; x=1756232667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Uxl4hRz+IS3ofUlHMTimcLwfnwpWGHBSdo9rZYe2Aw=;
 b=ajQblg1Ku8Y1zKjJw8BZMv2nTNpwP2MTAn/CZm3swSI+n8rgeOu2MeWxvIb/8lEX0V
 HpAk5vm9ckVwKOT2azRTFdiNeDOCUE0AVNiRtvC1de5J57B3UrvV1FjRUhf7jb/Ra4Ts
 wSydMWIoKJmr8/QWfGxhhl1fve71sgSHJrJJg24CPS7o2PPHSmNaZWVEjzWifT66goSO
 1ON768aURf25IdttUBYjmxVmSHZSg2/gc6jY4LWK1b7AHzxDPlC2ROcG3FRXHpW7Zxkr
 nP//UsbJ2S5HxkpgYXNIm1Tp7QqLsBxWpdsd2KtrEbN72MIfnci6P0P0FclVwTLQmvXI
 vPZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7Svwv5wjStHe4oPw0NHBJkvu+aPpRda/VPpp805GR1oWLltx2XrYq3AgDAmQqxNNAlOwvjfewAw==@nongnu.org,
 AJvYcCWslTV2RH+PfjQoY8o69QvR/kqQAXFS4N1aa9JiAo25tG5Lg4DSUm1QQAYOxJvnORASsDQcfysLX/VL5A==@nongnu.org
X-Gm-Message-State: AOJu0YwzP54EdgeNtCjh8tapbs/NfE1/A7Uwl0v82pMQTF/+bEamJNR6
 iVBLv7rH7wYuyOucBzpbGNA/fALL5956xFSdslzXj5s69Nwuojrp3K+xYWfyPhGJ
X-Gm-Gg: ASbGnctJfMH4zgxcnHU24XvSrA1Twbmh6uJtN1zmNTS4gOuN/I00mlczgtIBZdTXp0t
 JQ5RjEs2lxzdHknD7qF9EVPjrgB9iF8vGYm+m6SVO9M2A5BXQDCgremb0Am4tfYbsk5Jjxigrgp
 nBhywxH09qqY+4smBLgfpoutWQKkd/7V9yqtXy2O6F4BJ88BuI3RJghZRZyiIX2UUwCUqYKuR2U
 CEIaOOerhzQgOm3eAObo+p9X7fMQmF+RCaufCVz5bdAXIxQxRDJLDHvF4+XIhBD0r3MpPJJo6Z/
 odJmDLHYPHd36UGBPSCc9pIXgPL2uxbyHJXpQp+ieunnu18yiXqn8SYc/Q1lye2EWiLc6Gq6dWz
 sbQlaq9oxpcZMp3sBC+VmqMrVeGOeSVJk
X-Google-Smtp-Source: AGHT+IFptKn6/1+hfiOBYp4Ar7Op0/yESM5nLqJes5p4R9zBhW3KpTmz1veH2B/fTkU4utWReLHnWw==
X-Received: by 2002:a17:902:f541:b0:23f:f074:415e with SMTP id
 d9443c01a7336-245e030fd76mr35962265ad.14.1755627867321; 
 Tue, 19 Aug 2025 11:24:27 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:24:26 -0700 (PDT)
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
Subject: [PATCH 20/35] tcg/wasm: Add andc/orc/eqv/nand/nor instructions
Date: Wed, 20 Aug 2025 03:21:49 +0900
Message-ID: <cf283ca6c957d3c454facb228000129c171c904f.1755623522.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x529.google.com
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

This commit implements andc, orc, eqv, nand and nor operations using Wasm
instructions.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm/tcg-target.c.inc | 55 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index 01ef7d32f3..3c0374cd01 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -449,6 +449,56 @@ static void tcg_wasm_out_cond(
     }
 }
 
+static void tcg_wasm_out_andc(
+    TCGContext *s, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg2));
+    tcg_wasm_out_op_not(s);
+    tcg_wasm_out_op(s, OPC_I64_AND);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+}
+
+static void tcg_wasm_out_orc(
+    TCGContext *s, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg2));
+    tcg_wasm_out_op_not(s);
+    tcg_wasm_out_op(s, OPC_I64_OR);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+}
+
+static void tcg_wasm_out_eqv(
+    TCGContext *s, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg2));
+    tcg_wasm_out_op(s, OPC_I64_XOR);
+    tcg_wasm_out_op_not(s);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+}
+
+static void tcg_wasm_out_nand(
+    TCGContext *s, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg2));
+    tcg_wasm_out_op(s, OPC_I64_AND);
+    tcg_wasm_out_op_not(s);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+}
+
+static void tcg_wasm_out_nor(
+    TCGContext *s, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg2));
+    tcg_wasm_out_op(s, OPC_I64_OR);
+    tcg_wasm_out_op_not(s);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+}
+
 static void tcg_wasm_out_setcond(TCGContext *s, TCGType type, TCGReg ret,
                                  TCGReg arg1, TCGReg arg2, TCGCond cond)
 {
@@ -1177,6 +1227,7 @@ static void tgen_andc(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_andc, a0, a1, a2);
+    tcg_wasm_out_andc(s, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_andc = {
@@ -1266,6 +1317,7 @@ static void tgen_eqv(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_eqv, a0, a1, a2);
+    tcg_wasm_out_eqv(s, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_eqv = {
@@ -1339,6 +1391,7 @@ static void tgen_nand(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_nand, a0, a1, a2);
+    tcg_wasm_out_nand(s, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_nand = {
@@ -1350,6 +1403,7 @@ static void tgen_nor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_nor, a0, a1, a2);
+    tcg_wasm_out_nor(s, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_nor = {
@@ -1373,6 +1427,7 @@ static void tgen_orc(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_orc, a0, a1, a2);
+    tcg_wasm_out_orc(s, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_orc = {
-- 
2.43.0


