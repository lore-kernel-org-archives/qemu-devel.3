Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8C8C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnyM-0007de-FL; Sun, 16 Feb 2025 18:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwl-0004Uk-FZ
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:12 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwf-0006TQ-C4
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:10 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2fbf5c2f72dso5743918a91.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748062; x=1740352862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/75beKJVbQPAqYNdfZxdiKIeNjarDa2uAUSltqMchs8=;
 b=ZEhmLg0gtWLZiY+XcMbZUHZtmzD6MfHVV+in/ZPlCW8k8V0hcGk/7bA8Tju8m/jgEr
 Oq7vX2E1AdlxISsuaPLzrAAk+biIPHm3Lq/OchW1xHTMMUTuyfnIRY2vtqr22eF4As5W
 cb1i/k2YIUjWfVFSTClKNNhJ/xbA2PF3L4BbLAdSmRDIvZoYmtoawqGw95DXpifHHxOW
 puGLsI5YyGqA89LygxiCt8yyJ5Zn1ebqdo1r/M0SubUC05++uoLT8TOmE554aWUXxg+x
 j596Z7omz2xLXKJglvJNSzgMQpCsAPoy5szgJxyo63P4M9foUCA0vhiClw3Fd01cKrra
 +00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748062; x=1740352862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/75beKJVbQPAqYNdfZxdiKIeNjarDa2uAUSltqMchs8=;
 b=FFDN/b1NLkiEFdJOuABQ1/or5NsuxCldmPyHm8EPvxQphj8JBgd9//qben8uRbL/Yb
 n5przkvoW3rRRh3/pUB3BxMoClp7d6KaLa/DPUKZU1BhJczOzEISDMF6lCgwcC3dhWrQ
 gObMYSTQW+H3DJmFN6qifvtGYE3V+q+SBlBjyFrE616JC2ioEgkXxcAdLqOQ9Qr2vlNF
 Z7VotY7pV56nLnilFoTJ6310NDTYnZH4n2JtUeJyEOgrwbcuu9uG24fi1idPK4+yD/ZT
 4Ih5hn4sU5VF3krHzwJaShUNOu5u9CoqYd/+B3hzXFrvOrocqdwaBfOR9NKW6NDi1iJo
 TDHQ==
X-Gm-Message-State: AOJu0YyewoBusuW7mYR+TeC3EROEcGcZNu4OBPeuskleg6O6JKzpt5Rb
 uCSKcTrHEv4m+5UN80JrO9WTD06Y9SUH61miOgLmI+o0jsdi/xBA0c8P0aa3mx+rhwQBY0N1/+e
 c
X-Gm-Gg: ASbGncvov6PaCaM2TcQB7RXdL9ugdxWqFWrQHoohtXuE+mFpodC4kLNxn+Zyp55LthZ
 L86j1ZrHEb/f/Nc/ogi5NpX5zBL/1DTg3qmapYJHEW2K5arjfbYRW7dzSIu7qLSSjmDMsuNHwGj
 m6xPOlCnk2PgnFWC6evHjriuXEHFmuGL2Ul7Igc564WijXFWVbKmKYnvj6ByjQSNBAbSIfHtPLN
 xvhPlrrtcS5SfpCcxNriRjCtDqenhc0vSNmPKoGtmcf0Mx6yVy2t6SdKSkAmWQZsvTpAkticBL5
 tfA7CbHSIEuMcqEnCK1Rlmo2Ljl0o8tRM6uEdylDW0RlgxA=
X-Google-Smtp-Source: AGHT+IGoifXRA+rGuCarXc8hnxZfDWV+1Z6T0Mi6mFZkojxoDyEZR+VwtgZdNx6+GJz1ciMSyQfFsA==
X-Received: by 2002:a17:90b:3812:b0:2ee:ab04:1037 with SMTP id
 98e67ed59e1d1-2fc40f22bdemr13553443a91.17.1739748062070; 
 Sun, 16 Feb 2025 15:21:02 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.21.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:21:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 141/162] tcg/s390x: Use ADD LOGICAL WITH SIGNED IMMEDIATE
Date: Sun, 16 Feb 2025 15:09:50 -0800
Message-ID: <20250216231012.2808572-142-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390x/tcg-target.c.inc | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 2b31ea1c3e..36293d0f42 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -135,6 +135,9 @@ typedef enum S390Opcode {
     RIEc_CLGIJ   = 0xec7d,
     RIEc_CLIJ    = 0xec7f,
 
+    RIEd_ALHSIK  = 0xecda,
+    RIEd_ALGHSIK = 0xecdb,
+
     RIEf_RISBG   = 0xec55,
 
     RIEg_LOCGHI  = 0xec46,
@@ -682,8 +685,16 @@ static void tcg_out_insn_RI(TCGContext *s, S390Opcode op, TCGReg r1, int i2)
     tcg_out32(s, (op << 16) | (r1 << 20) | (i2 & 0xffff));
 }
 
+static void tcg_out_insn_RIEd(TCGContext *s, S390Opcode op,
+                              TCGReg r1, TCGReg r3, int i2)
+{
+    tcg_out16(s, (op & 0xff00) | (r1 << 4) | r3);
+    tcg_out16(s, i2);
+    tcg_out16(s, op & 0xff);
+}
+
 static void tcg_out_insn_RIEg(TCGContext *s, S390Opcode op, TCGReg r1,
-                             int i2, int m3)
+                              int i2, int m3)
 {
     tcg_out16(s, (op & 0xff00) | (r1 << 4) | m3);
     tcg_out32(s, (i2 << 16) | (op & 0xff));
@@ -2276,6 +2287,15 @@ static void tgen_addco_rrr(TCGContext *s, TCGType type,
 static void tgen_addco_rri(TCGContext *s, TCGType type,
                            TCGReg a0, TCGReg a1, tcg_target_long a2)
 {
+    if (a2 == (int16_t)a2) {
+        if (type == TCG_TYPE_I32) {
+            tcg_out_insn(s, RIEd, ALHSIK, a0, a1, a2);
+        } else {
+            tcg_out_insn(s, RIEd, ALGHSIK, a0, a1, a2);
+        }
+        return;
+    }
+
     tcg_out_mov(s, type, a0, a1);
     if (type == TCG_TYPE_I32) {
         tcg_out_insn(s, RIL, ALFI, a0, a2);
-- 
2.43.0


