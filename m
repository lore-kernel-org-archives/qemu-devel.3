Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE1DC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMUj-0003WJ-GF; Tue, 20 May 2025 08:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMUc-0002wv-8M; Tue, 20 May 2025 08:54:50 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMUX-00012I-ID; Tue, 20 May 2025 08:54:49 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-30572effb26so5234209a91.0; 
 Tue, 20 May 2025 05:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745677; x=1748350477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7eabZrzKs+cL55IaJg89VzpBHaEX4pjQLmBcxb/tbcE=;
 b=PFJBH4kPO8TLd/9LqAMq9z01rA9Jn/YwOjBIujf+ZuYsqiPzIPZrpdyLa0b6VzQ7U1
 9qQ6pxl79yCqyGNjYFMaiJV4wJB2pD8hBWqDTzp642MzsQq90PNybIKflAUnUM2IMzCw
 O3NMkRJyNHlHLSgv6Mc4geOMMoDU/4q4gzmqfsHoD5tc94lIAg+E5XSICH8MdanbORb+
 W6LAjpgcVJaY06KyOQDidw50H79jpcgS8M23MGK1xdH2M3giVYpVN02Bs4GH5x88yADb
 XYWNvb8VyNz8GsQxQgcf/6hylwETysa4F79ng/OHRZ46ZehDhiKHlfrc3Zkx6FamDS0H
 xEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745677; x=1748350477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7eabZrzKs+cL55IaJg89VzpBHaEX4pjQLmBcxb/tbcE=;
 b=atFm3phTa2ptgtZAVJhinIkZnV5OT8fDZvGbyMZQ+JBBdlZt9hP645gCQKuU8LmIp9
 rbBAFE+BSw0KSsBhvEkYt1h8Np5n4G+hHf9RDY7Rm5zUhexqMWXG/rLSCnYXeRipcAmz
 ly0QyMfBOhBsyPUSAVN77czkEkVCcIriJQA3DJ7kK1P9HVaerKXlZQMDJ5M2gLPKUDL0
 y42cAWPwClovbDFdC0DVEFEFXKjWKUGQmckJ1UGe0Lh5L/bk/TGLT8xLukW7KQ4k7icY
 6lNj/5EHPZ81219vEV82GNkXFaDtUg+aaepZH8mZnTiba8o7dB95P9JPEVsK0lvvhGeG
 dWqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDcctndDE1NUCRpfIehupCh0zTj21on2UJqUzKLt6ZMDN2jLpDSTmfnww9/s9Y1rykZT6jzWmneDWPDA==@nongnu.org,
 AJvYcCW+Rg64lDcS+zynl8mU99kqcknp0820fBPeVyykXi/s6RKDuDm8dBOi9Yao32gkAvz6aQHRnTb/uA==@nongnu.org
X-Gm-Message-State: AOJu0YxsrSwtsBD1iUti0G35nzgrRSfKtwLMT394N9TLDdg/bMRPtZAS
 LfU0ZZrBXtBRc3T8jZFmSbYj/Yu1hyrlgHEO4DsCVlQ7RwP7yp3e2McGvXKNbyCD
X-Gm-Gg: ASbGncvmnak87sXOT7NW0sVwFacF+T5qeGmEMGToO69UrGz2jXHhzoggmPTWiTG6xZZ
 G3WyW5YrCAJn101Os/xhcjN9MF8y8ftzY11fwZMw/RDyShmut5itVsK0iPhBjIs7UZCnXq25GYF
 gmvg5KWv4Ws1wAzIIDst8fafJ74YSMRQJgmzZFZyqKSO/jwKSMBWMnJp53SgFN66ntz/4zxPNAq
 wPgIYCDSCmuxa+iXzDgf4rXfnCb/bAVq6EJ5v4Xn++X3y8NHJGpPwIjg/Ufg2bdpvUsZy89e3s+
 KpzB8/v3Gn4uI6FZo5+1QDpSp3/Yy6xwVNDVvgjBy3TWWjA4uvQ=
X-Google-Smtp-Source: AGHT+IEZCo8TLYMPhGsfPoyVD7cxyqqI5vVtGGele8JzfzU/R/+q5jO0KcIFs8Gd49flFHnnc/IHyQ==
X-Received: by 2002:a17:90b:6c8:b0:30e:8f60:b4c with SMTP id
 98e67ed59e1d1-30e8f600d77mr26832066a91.16.1747745677188; 
 Tue, 20 May 2025 05:54:37 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:54:36 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 25/33] tcg/wasm32: Set mulu2/muls2 as unimplemented
Date: Tue, 20 May 2025 21:51:27 +0900
Message-ID: <0e228847d902b25d643bcbee028d67e3cb0f0464.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x102d.google.com
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

These operations have no direct equivalents in Wasm, so they are left
unimplemented and delegated to helper functions.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm32/tcg-target.c.inc | 38 ++-----------------------------------
 1 file changed, 2 insertions(+), 36 deletions(-)

diff --git a/tcg/wasm32/tcg-target.c.inc b/tcg/wasm32/tcg-target.c.inc
index 9fad96d0fd..df34097267 100644
--- a/tcg/wasm32/tcg-target.c.inc
+++ b/tcg/wasm32/tcg-target.c.inc
@@ -2076,19 +2076,6 @@ static void tcg_out_op_rrrbb(TCGContext *s, TCGOpcode op, TCGReg r0,
     tcg_out32(s, insn);
 }
 
-static void tcg_out_op_rrrr(TCGContext *s, TCGOpcode op,
-                            TCGReg r0, TCGReg r1, TCGReg r2, TCGReg r3)
-{
-    tcg_insn_unit_tci insn = 0;
-
-    insn = deposit32(insn, 0, 8, op);
-    insn = deposit32(insn, 8, 4, r0);
-    insn = deposit32(insn, 12, 4, r1);
-    insn = deposit32(insn, 16, 4, r2);
-    insn = deposit32(insn, 20, 4, r3);
-    tcg_out32(s, insn);
-}
-
 static void tcg_out_op_rrrrrc(TCGContext *s, TCGOpcode op,
                               TCGReg r0, TCGReg r1, TCGReg r2,
                               TCGReg r3, TCGReg r4, TCGCond c5)
@@ -2610,37 +2597,16 @@ static const TCGOutOpBinary outop_mul = {
     .out_rrr = tgen_mul,
 };
 
-static TCGConstraintSetIndex cset_mul2(TCGType type, unsigned flags)
-{
-    return type == TCG_TYPE_REG ? C_O2_I2(r, r, r, r) : C_NotImplemented;
-}
-
-static void tgen_muls2(TCGContext *s, TCGType type,
-                       TCGReg a0, TCGReg a1, TCGReg a2, TCGReg a3)
-{
-    tcg_out_op_rrrr(s, INDEX_op_muls2, a0, a1, a2, a3);
-}
-
 static const TCGOutOpMul2 outop_muls2 = {
-    .base.static_constraint = C_Dynamic,
-    .base.dynamic_constraint = cset_mul2,
-    .out_rrrr = tgen_muls2,
+    .base.static_constraint = C_NotImplemented,
 };
 
 static const TCGOutOpBinary outop_mulsh = {
     .base.static_constraint = C_NotImplemented,
 };
 
-static void tgen_mulu2(TCGContext *s, TCGType type,
-                       TCGReg a0, TCGReg a1, TCGReg a2, TCGReg a3)
-{
-    tcg_out_op_rrrr(s, INDEX_op_mulu2, a0, a1, a2, a3);
-}
-
 static const TCGOutOpMul2 outop_mulu2 = {
-    .base.static_constraint = C_Dynamic,
-    .base.dynamic_constraint = cset_mul2,
-    .out_rrrr = tgen_mulu2,
+    .base.static_constraint = C_NotImplemented,
 };
 
 static const TCGOutOpBinary outop_muluh = {
-- 
2.43.0


