Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9CFC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJXB-0001w3-4L; Tue, 06 May 2025 10:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVO-00023w-Te
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:48 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVM-00029x-HE
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:46 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-441c99459e9so19289395e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542562; x=1747147362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NIaSPaix7r679jzJntYchPOTlZ36RPzqbOenhGw4cwE=;
 b=S7C1oDxxtr14R+vykgGAmg2HclnVtH2vLyeCE/JR2plr2a6CXlNwr5O9WF/Bv8xnT/
 xe6nUUqwCbCeFtLvFBu9tF5yK2CnpvXA+Oj+EFRRHTNSP5pjObL8YtXnTgv12eyh0z0D
 8E+SvfsewhQBHQNmRvPnS8vIC23Bh/7IsxZCYy+4RLa5HfBhGD73/+3gvI8MLFk11FtR
 eJ3PHYAEA/Q4sJEOqsyiZYOKVPvKRyy1MwcqyMJ8oVS3hF80GhehHfLpG1UQk9c0xATF
 IPwvvI2Our/Qty+hkRpMKV7cYPMoiw0H5owOmRXxXXg/EmQDt3bPVbXOMm075rsR4jyD
 NOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542562; x=1747147362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NIaSPaix7r679jzJntYchPOTlZ36RPzqbOenhGw4cwE=;
 b=VAUu7DCiDCgNKhEu8ALUAyDLL+wuQngRiZx8Z7m35imRW0h0rS+LZW8h+uSjDw+YGl
 UueaKZbE04rYkILuhmXUMEB3+BEM2Y3WvHuHexsK2zuCFxlfV/LP5VBcOfugmWcvL4FC
 HZQFE5MYBtStP6Wbw08mhtVvd181+/cvJMcU6loL3T5gt3uJY8pXyjTsiVbyX1Sfbr9T
 T/kXKdoPVMr64Hhe/capvgwun+s8MGhhJH3vN6qr6qGD92gUL3nVTvuijDsANly4E+yn
 1dN9zlotE3bpYVM/bmh6pQ0qD//qgf8jw5xdRD1jH8J2p4JiHxV5dKyT2AleclCj8pww
 URDQ==
X-Gm-Message-State: AOJu0YyJHZjZcDpnnk9nXv0ACtFkzBjpLPJhdJw5P98LRNN/VpukiFYJ
 4wvjBKlZvEf0K5tfTdrJHZNqHtPZwdJYK7+dZ1V8vheHH1d3Ls+YKPVeprHaluf4d1yVB7UIMj6
 7
X-Gm-Gg: ASbGnctm2FcHjZGL29tYYASA9VpfRJqu0I9rMwfKoFfTuKHZfv411IMzCDdgjUQK25b
 kVRpGlwzys7vMhipR9Cxv2G/IS449RpfRCOVQJBEYANkW9QKj64pFV75A+4FQib1nAJCQd3swnB
 0Rj12/1+X5S7Py5TmrLVhIiK+9/T1Yr4Mh4a06xsUUvSXwUFPaSQ6ib9DBfCwAanUyDw9tg78hM
 TPibtiAaDPj9KWeHTBKl6CzKHMgUKXpZq7Y9MjrqYhEp7NROaVc2b7JyNwin8iLFMfgMmYgc9pA
 yrPCBWJLBiMZR7cN2Q76meX9eIX0WlR8iAC07s+hrVv5aqM=
X-Google-Smtp-Source: AGHT+IHZHLqbgPhzsWqMt7Ulkvn2BKGmK6YK8s1saDOm8cYYSdtX128W9pHaFVSErTDoxHqa4PKYUw==
X-Received: by 2002:a05:600c:3155:b0:43b:cb12:ba6d with SMTP id
 5b1f17b1804b1-441bbea0d49mr159933705e9.3.1746542562484; 
 Tue, 06 May 2025 07:42:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/32] target/arm: Don't assert() for ISB/SB inside IT block
Date: Tue,  6 May 2025 15:42:05 +0100
Message-ID: <20250506144214.1221450-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

If the guest code has an ISB or SB insn inside an IT block, we
generate incorrect code which trips a TCG assertion:

qemu-system-arm: ../tcg/tcg-op.c:3343: void tcg_gen_goto_tb(unsigned int): Assertion `(tcg_ctx->goto_tb_issue_mask & (1 << idx)) == 0' failed.

This is because we call gen_goto_tb(dc, 1, ...) twice:

 brcond_i32 ZF,$0x0,ne,$L1
 add_i32 pc,pc,$0x4
 goto_tb $0x1
 exit_tb $0x73d948001b81
 set_label $L1
 add_i32 pc,pc,$0x4
 goto_tb $0x1
 exit_tb $0x73d948001b81

Both calls are in arm_tr_tb_stop(), one for the
DISAS_NEXT/DISAS_TOO_MANY handling, and one for the dc->condjump
condition-failed codepath.  The DISAS_NEXT handling doesn't have this
problem because arm_post_translate_insn() does the handling of "emit
the label for the condition-failed conditional execution" and so
arm_tr_tb_stop() doesn't have dc->condjump set.  But for
DISAS_TOO_MANY we don't do that.

Fix the bug by making arm_post_translate_insn() handle the
DISAS_TOO_MANY case.  This only affects the SB and ISB insns when
used in Thumb mode inside an IT block: only these insns specifically
set is_jmp to TOO_MANY, and their A32 encodings are unconditional.

For the major TOO_MANY case (breaking the TB because it would cross a
page boundary) we do that check and set is_jmp to TOO_MANY only after
the call to arm_post_translate_insn(); so arm_post_translate_insn()
sees is_jmp == DISAS_NEXT, and  we emit the correct code for that
situation.

With this fix we generate the somewhat more sensible set of TCG ops:
 brcond_i32 ZF,$0x0,ne,$L1
 set_label $L1
 add_i32 pc,pc,$0x4
 goto_tb $0x1
 exit_tb $0x7c5434001b81

(NB: the TCG optimizer doesn't optimize out the jump-to-next, but
we can't really avoid emitting it because we don't know at the
point we're emitting the handling for the condexec check whether
this insn is going to happen to be a nop for us or not.)

Cc: qemu-stable@nongnu.org
Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2942
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250501125544.727038-1-peter.maydell@linaro.org
---
 target/arm/tcg/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 88df9c482ab..e773ab72685 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -7760,7 +7760,8 @@ static bool arm_check_ss_active(DisasContext *dc)
 
 static void arm_post_translate_insn(DisasContext *dc)
 {
-    if (dc->condjmp && dc->base.is_jmp == DISAS_NEXT) {
+    if (dc->condjmp &&
+        (dc->base.is_jmp == DISAS_NEXT || dc->base.is_jmp == DISAS_TOO_MANY)) {
         if (dc->pc_save != dc->condlabel.pc_save) {
             gen_update_pc(dc, dc->condlabel.pc_save - dc->pc_save);
         }
-- 
2.43.0


