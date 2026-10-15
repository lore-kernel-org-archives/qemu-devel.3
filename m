Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262C7CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ4r-0002co-GA; Thu, 15 Oct 2026 06:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4p-0002Wf-Hs
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:47 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4o-0007rz-1R
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:47 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so271325f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792061564; x=1792666364; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WhF1nzBVuqOQY35KjB2wbzU1vZyv4lwyST+Egorhjoo=;
 b=FaMfDLMefnB7Kp3JCe+XhPRlUB0Oq5vCGK0Lt/6fEWwMvl/a15jvlfFMcRA05y8nf6
 WGmSXj+r9KdwnxxoksBbwYyg1yjYzBkjQa+hlMUf7SAW6IT3kP4/UWXrIl2IKrI7slxO
 TMY/qrFrX+RkeYKUKZ9M2frgUnslGanuGkVBoky5774DG6H4w6CjWxIOOT2OUOq5PLKH
 t2VSMtuc1lxNey1j1vTRisG2EYfZIzYPtZlbkbVWA99DhNONpP4LpPB9kmZBPbfH5N/b
 lT4CQ4332SWEFFW/gokkCC904Y4XexOMDErBQsY1/roBnjFfntcJFgkXak5nMecWjcwa
 OpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061564; x=1792666364;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WhF1nzBVuqOQY35KjB2wbzU1vZyv4lwyST+Egorhjoo=;
 b=qSPpR62xGgdm0OxjKnPM+iQIcI8odOJJSmWP4bfaoQ6UiXLDbgvBh7JuPavQ8Xz3CU
 3jKIMYDZWCliiMFFVHiBBiWJnPjB6+J+8Qpi/scLQixfHSRpzBITmYarBkZRhKgyScEn
 /2zGD8T+Hc1zW/YvqB75JHcg02A0TAaYomh+VdIwMbknRm8BTfSdL/eQTlgUAIObnnWo
 vrflsJaRj/525qYX54mCpGFfrBhpMn37erBGwWgnhyZf8rLgevDgDxC23XiXNpzYg4q0
 l9CySsCARQI/49Z4CfbyeIUEoZ30pf7j4rN2S8NGDRBoxVRtE3fAAVlvbVm+7K/z8Hyt
 b/Kg==
X-Gm-Message-State: AFq9FYJXXSXUJdBtqY4p+zZ15C1iphuCA5PU7xQWtDwjBL2066s80n4V
 4dR1xcB6Kt3Mud2HHxVXwijMXWryrKSifBUpofHbfWebtroyKSjHcIfkr8hVAjxHuOXCEeeQap/
 KSXbD0m0=
X-Gm-Gg: AYBFou0vbAEyorWvTknEq4ViWwuc2oU0CYwzcEqJ/Cbl9Kf/V6CQAKKu6dBGImznJny
 4ACY0Yi38Tyof4TEevs2Tf0bF6BKhpDuifr/hEANQXLW+fvtoSpYH3nLEzMiUGvjA/nDto3QdGh
 mPnu0qG/v0V8bPP5/xk9tPUrcF5cU/AISY2ramGXa5a0Loc8cpKK5rTDxlIGPzDFwN6zh8ja7Zb
 aXH/8mwxYRznH2cSEAPdUepziIFWjdTyogMK/KJqsrSylk5rfRLhUJHXxq/HvV+fQyN9DnoR4bn
 pGiGqGewgoAlwfDH9Uvke5UIZFlgrkgSQpy5XXXRaiQjulZiLY4xm81oKborexPeT34vuLhVjUp
 wS45tQRJpZChbtoBp9XNdivdOxKSdDT++MhnyNCUlTI13crpaMRrBp/KOLcvH1oGp9tdyg4mXvJ
 Wgma/tXZWyn2pQRz/q7OaBqnKY83w/wftpamb72k/b5V13BXMvZo3GNcgxspbt0k8R4zCqrzsMg
 vF6X3x0A9FlLnV57bfMxrgMt6JtEamT6DrIvY4tbWrzjG2ueIhxkLlxJ8sU7rqKjeGpJCgTWrze
 euyNVtyPtsYDntc=
X-Received: by 2002:a05:600c:8105:b0:49f:fdca:c361 with SMTP id
 5b1f17b1804b1-4a18e483818mr403748875e9.12.1792061564394; 
 Thu, 15 Oct 2026 03:52:44 -0700 (PDT)
Received: from stoup.fritz.box
 (p200300ca3f0f8b006e0ed1a687ab6860.dip0.t-ipconnect.de.
 [2003:ca:3f0f:8b00:6e0e:d1a6:87ab:6860])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df5b88207sm3075949f8f.59.2026.10.15.03.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:52:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Chou <max.chou@sifive.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 15/16] tcg/riscv64: Validate AUIPC relocation range
Date: Thu, 15 Oct 2026 12:52:07 +0200
Message-ID: <20261015105212.356392-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015105212.356392-1-richard.henderson@linaro.org>
References: <20261015105212.356392-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Max Chou <max.chou@sifive.com>

reloc_call splits a PC-relative offset into a signed 12-bit low
immediate and an AUIPC contribution. When the low immediate carries
into bit 31, the existing 32-bit arithmetic can accept an unencodable
positive 0x80000000 AUIPC contribution.

Keep the split in pointer-width arithmetic and reject it unless the
rounded upper contribution is representable as signed 32-bit. Factor
this validation into split_auipc_offset so reloc_call retains its
existing failure contract.

Fixes: dfa8e74f9463 ("tcg/riscv: Add the relocation functions")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
[rth: Pass target as intptr_t to split_auipc_offset.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv64/tcg-target.c.inc | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index d6c52323c3b..99c81dc6521 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -640,14 +640,28 @@ static bool reloc_jimm20(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
     return encode_jimm20(src_rw, offset);
 }
 
-static bool reloc_call(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
+static bool split_auipc_offset(tcg_insn_unit *src_rw, intptr_t target,
+                               int32_t *ret_hi, int32_t *ret_lo)
 {
     const tcg_insn_unit *src_rx = tcg_splitwx_to_rx(src_rw);
-    intptr_t offset = (intptr_t)target - (intptr_t)src_rx;
-    int32_t lo = sextreg(offset, 0, 12);
-    int32_t hi = offset - lo;
+    intptr_t offset = target - (intptr_t)src_rx;
+    int32_t lo = sextract32(offset, 0, 12);
+    intptr_t hi = offset - lo;
 
-    if (offset == hi + lo) {
+    /* AUIPC sign-extends its 20-bit immediate after shifting by 12. */
+    if (hi == (int32_t)hi) {
+        *ret_lo = lo;
+        *ret_hi = hi;
+        return true;
+    }
+    return false;
+}
+
+static bool reloc_call(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
+{
+    int32_t lo, hi;
+
+    if (split_auipc_offset(src_rw, (intptr_t)target, &hi, &lo)) {
         src_rw[0] |= encode_uimm20(hi);
         src_rw[1] |= encode_imm12(lo);
         return true;
-- 
2.53.0


