Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC8FD1815E
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 00:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0VdH-00046V-SO; Mon, 14 Oct 2024 20:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t0VdF-000460-EW
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 20:41:49 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t0VdD-0006bW-R4
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 20:41:49 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2e30fb8cb07so1930735a91.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 17:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728952906; x=1729557706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tY5hWmYQZvs/fXtZp/tPu7fkje8YdUCcSflZjBQIfo0=;
 b=aNF21eB8gvQpTf/sd+A6xh1DumUhCau6T+7joibKlC3a95ZfFrFMB3p6b+jLge3WgN
 7uUzntbmR2Bf7PHAo99rThRzKg1HkWinBFq13TQZGH1bwr83qKrLa3GOax6vnTPMgqvr
 n99ARLoOPTS7nHYm/6Oyq/ePwaAhPCJ3iT0ylXBoBZ50XANQnpWS6EH99uGXuw2zB9pG
 DfC192Iq+4Dr0eEAm/nHBcjHtSVP9TIu2zPqYVUcd6A45DoWLffyim8BWJIkZjR24Fp6
 3/lzlvCUKZSYb54jqu0Sm+tHn2WLuvihDG1727mVo2/z+g09SrICrCk/hLo2kWvZZCQi
 aKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728952906; x=1729557706;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tY5hWmYQZvs/fXtZp/tPu7fkje8YdUCcSflZjBQIfo0=;
 b=IDLzBJdv530+MVIwyrtBTVQw7VT4+rrc5wBA3UbwV8DhtEWFEbG6azEfAmja7RM1uz
 Kp765Hdm0sbyoARU/x9d/ts7rAMx3oZMeiZwVbiglgqLFOJTlZ3jLF2P3iVPL239+J3H
 utUcOsSa/Vdf1QhfC5WBnZ11d5pQJDgK8RTPUQBnyhJ8M5QXpnklfApAHm5aahvqorXD
 gPbvccp4ENzfjza4aUQP9ZppoJ+LOoTnRRINvFsjB+vGL/11dCOZN4YM/7L7V+xBBU9V
 oxToZQzWSTT2ukr1uZ2l4+e8n1BlDoKyh3luLq+C8LKIYCbydzL1W57HHTz9gXkG478C
 twJA==
X-Gm-Message-State: AOJu0YwN70HTzLBNetqC2cyV2zj5rnNdIjhSqJcxuGeWyV+fbqArYqE5
 eViHuOa+cDP318uA0fIm/tYnkUOl+Bhu4WGm1QrAluxIOJ5OxYIlpyQLFsyNN2vYkKwzcrT1Wqj
 E
X-Google-Smtp-Source: AGHT+IGhAeANZ+iAwHeXhZmOfsWlXgqdPMdMX9A6j3R6IwpIpAOE/XreVtK+gXalODBZzcropEbelQ==
X-Received: by 2002:a17:90b:88e:b0:2e2:92dc:6fd4 with SMTP id
 98e67ed59e1d1-2e2f0aebf4bmr15793769a91.23.1728952905846; 
 Mon, 14 Oct 2024 17:41:45 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e392f62c21sm166614a91.46.2024.10.14.17.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 17:41:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH] target/i386: Use only 16 and 32-bit operands for IN/OUT
Date: Mon, 14 Oct 2024 17:41:44 -0700
Message-ID: <20241015004144.2111817-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

The REX.W prefix is ignored for these instructions.
Mirror the solution already used for INS/OUTS: X86_SIZE_z.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2581
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/decode-new.c.inc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 30be9237c3..429ed87bb6 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1627,9 +1627,9 @@ static const X86OpEntry opcodes_root[256] = {
     [0xE2] = X86_OP_ENTRYr(LOOP,   J,b), /* implicit: CX with aflag size */
     [0xE3] = X86_OP_ENTRYr(JCXZ,   J,b), /* implicit: CX with aflag size */
     [0xE4] = X86_OP_ENTRYwr(IN,    0,b, I_unsigned,b), /* AL */
-    [0xE5] = X86_OP_ENTRYwr(IN,    0,v, I_unsigned,b), /* AX/EAX */
+    [0xE5] = X86_OP_ENTRYwr(IN,    0,z, I_unsigned,b), /* AX/EAX */
     [0xE6] = X86_OP_ENTRYrr(OUT,   0,b, I_unsigned,b), /* AL */
-    [0xE7] = X86_OP_ENTRYrr(OUT,   0,v, I_unsigned,b), /* AX/EAX */
+    [0xE7] = X86_OP_ENTRYrr(OUT,   0,z, I_unsigned,b), /* AX/EAX */
 
     [0xF1] = X86_OP_ENTRY0(INT1,   svm(ICEBP)),
     [0xF4] = X86_OP_ENTRY0(HLT,    chk(cpl0) svm(HLT)),
@@ -1761,9 +1761,9 @@ static const X86OpEntry opcodes_root[256] = {
     [0xEA] = X86_OP_ENTRYrr(JMPF,  I_unsigned,p, I_unsigned,w, chk(i64)),
     [0xEB] = X86_OP_ENTRYr(JMP,    J,b),
     [0xEC] = X86_OP_ENTRYwr(IN,    0,b, 2,w), /* AL, DX */
-    [0xED] = X86_OP_ENTRYwr(IN,    0,v, 2,w), /* AX/EAX, DX */
+    [0xED] = X86_OP_ENTRYwr(IN,    0,z, 2,w), /* AX/EAX, DX */
     [0xEE] = X86_OP_ENTRYrr(OUT,   0,b, 2,w), /* DX, AL */
-    [0xEF] = X86_OP_ENTRYrr(OUT,   0,v, 2,w), /* DX, AX/EAX */
+    [0xEF] = X86_OP_ENTRYrr(OUT,   0,z, 2,w), /* DX, AX/EAX */
 
     [0xF8] = X86_OP_ENTRY0(CLC),
     [0xF9] = X86_OP_ENTRY0(STC),
-- 
2.43.0


