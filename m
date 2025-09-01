Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F566CA1005
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut31k-0003ln-2t; Mon, 01 Sep 2025 07:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut318-0002OJ-MJ; Mon, 01 Sep 2025 07:48:10 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut30u-0001kH-KU; Mon, 01 Sep 2025 07:48:09 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b4c3d8bd21eso2681943a12.2; 
 Mon, 01 Sep 2025 04:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727265; x=1757332065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIiv1lrfYrU9eW05Aj0a0MU6VidnMXh6ukt52O2SkXk=;
 b=Mlac3vZAREPO4r4kK1wgy9RzZFyz+T0hbPnlGYlLDPwiNSkIXSyOcDAcqxr3LyfrFU
 wbpPGK0wPGNSuF90rj3Gn0NmIWmw/Fz7mKgWLNJmZCBL3DvFNp8HAK3ntrlAKGu11kjC
 sT87OP13Xg8P2gPlmjt3/qE5AM3eUIWnKQF5MWHJod9zP4qnu3vuNKrW8PXxIkj9fD2O
 oT1CuZzlRPA+fyTOQirv162qyIGtbnzCAxPxoD51rugSC3vAAx+FqXNn1BnFwMwCk7sa
 l1GsTlWoeLXcKWm4X0xM+IFG/d3Di0l/9QuB4hjfh1c8RekFYKPzvrZkHIK0qX/Jyu18
 Wjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727265; x=1757332065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nIiv1lrfYrU9eW05Aj0a0MU6VidnMXh6ukt52O2SkXk=;
 b=tEY4KXy8Tzh8nw5vrezZjPcEE8nk8CWDRHBxIU6gMwl7XrM7LHSv+hQfvFfYymH+BQ
 kGVEGjWGrfk1Ek3rz+fXkE5ffP4y08T4nKBzhMCxEruVV4xDUESjkDoJ3t9FRBUGExuL
 pNm23OZMEEvgXotTwuzPzwN4I8KkUpoUMX5KeMgPJPMs0YC7K8gTEhb6UkXB7q7QdWVq
 Nypf6LLzBr3N4s38DvNYxHTznL5m3VtAREljDMCYDv/A69Zr+0NroRL73W3n0SwC1qBK
 ul1Rw8VC475IRi47p1KEcolevnC/6siRph9SqXY5OuwXUlfBlz54O7L95WIXNPv97W5x
 rgWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg5jbNFaCW+xGoiTkG+1hNPMNSfho+6Lxbj4PTTmEU/DUU2k00ljnEDgsisQaAJJnXygDOkv10foe4Eg==@nongnu.org,
 AJvYcCWXkWN07pPg/VjQzdSUrof30vmV//amRs4d+oNvRXavYB7VEOJZJL3Z8tAs6LsGqJpFQGjDtteQcA==@nongnu.org
X-Gm-Message-State: AOJu0YwntnHLxg3/pyL6L3wIEL8t3PrerBXIGvjgVBnca98u55gU96UR
 oXtUvuOcgmwX0WVfkRnfJTOOmvqgHMwNz7v9HiiEuvmL+ikTggTwNEwr4SWw2w==
X-Gm-Gg: ASbGncso0+bFTP1dzV6tr8m0TnvT796dBj4l9GgKcw/gVTB2hVEH88+dHZhxTAJhEsm
 Z5I4I/V3HyXsaLCyErSTymDiUC9lyRPmFx48ElMufljiLBOBbnv6ZEhpHa41b/VGgPLxVW1dATO
 xgS3dZp7oRsNPmsCjWrbsIpchlDXE2weh9IgDSgXakWRjoMHy33ilE4xXpszgQgjWGyGuuSKFrY
 X38yDJ4A3n3L9tMhpuKwn58m2kUyAFuyuuo1jSi6o2Ie2uNReds2NsHu+3VanZku085BCd2P8eM
 RjhNKk1Hh6CHZpT8vf5om9uEjX3hvm11VpUyUYMWnpAYYlwfjpi3ZGpJ0+lLYdJiIsnxTmvJjCN
 o5siM7M4m3uej3knSlwwhd3IWEsfw9Q87
X-Google-Smtp-Source: AGHT+IE+pw6GZWT18YVnSv97ZiC9pFBPWrzddhYO7EH11sfg4q6JnKNe7CRX0SskKmk7jQ2/ICnxcw==
X-Received: by 2002:a17:902:eccf:b0:24a:8df4:a55c with SMTP id
 d9443c01a7336-24a8df4aae4mr100462065ad.48.1756727265555; 
 Mon, 01 Sep 2025 04:47:45 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:47:44 -0700 (PDT)
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
Subject: [PATCH v3 25/35] tcg/wasm: Mark unimplemented instructions
Date: Mon,  1 Sep 2025 20:44:27 +0900
Message-ID: <a3656a34217da7ac63ecdab31370b35b70b3ac94.1756724464.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This commit adds the C_NotImplemented constraint and provides stubs for the
functions that aren't implemented in the Wasm backend.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm/tcg-target.c.inc | 119 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index 1d639561db..598db7b4bd 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -1950,6 +1950,125 @@ static void tcg_out_mb(TCGContext *s, unsigned a0)
     tcg_wasm_out8(s, 0x00);
 }
 
+static const TCGOutOpDeposit outop_deposit = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpExtract outop_extract = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpExtract2 outop_extract2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_addco = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_addci = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbo = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbi = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpUnary outop_not = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_andc = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_eqv = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_nand = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_nor = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_orc = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpDivRem outop_divs2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpDivRem outop_divu2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpMul2 outop_muls2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_mulsh = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpMul2 outop_mulu2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_muluh = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBswap outop_bswap16 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBswap outop_bswap32 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpUnary outop_bswap64 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpQemuLdSt2 outop_qemu_st2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static bool tcg_out_xchg(TCGContext *s, TCGType type, TCGReg r1, TCGReg r2)
+{
+    return false;
+}
+
+static void tcg_out_set_borrow(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
+static void tcg_out_set_carry(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tcg_out_tb_start(TCGContext *s)
 {
     init_sub_buf();
-- 
2.43.0


