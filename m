Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7657F99367
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFquW-0007A2-D4; Thu, 23 Apr 2026 06:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqto-0006TS-DA
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:08 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtk-0002Ad-TW
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:08 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso3509562f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938583; x=1777543383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7zZNkeHRQ8Kr3iPcUhyDO0K+W7wnqOd8n/AUj5CFYko=;
 b=L1RYBGXXykLtuGu0lQgZ+/sbQ4Emh6mfsaeKyfyrpdOhJGqDuaxyW+y/prnpTcsgiW
 jUdoEuSRKxOrf63H7kAj4G6PBgOC76/CsRksf/p7l1uHOeHfN5IKr3niwBAEVQhOmz4h
 dyiqTfx1RaY9qfiKO6P4DztWizDbtwFdVr/yu212K/JW5/vDbu8FiIU2GFAk/OO1cguL
 h8hSQcxSnb3Fzo5a8BzDJYiqffIvCWxA+Du2fyLeidGE8DOaTsA+Z8nHrV5ddoydhRgE
 QwyIz+JlnQBTAzcKZHAbGkkkUczgOr9t7mxoCAAh7gVNKAvcBBisY4am8x5yFN0ImEcM
 WB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938583; x=1777543383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7zZNkeHRQ8Kr3iPcUhyDO0K+W7wnqOd8n/AUj5CFYko=;
 b=mFgiZ27nEjaZTXBAFGLoJNp1vovYtXnhov2vlAEnHGIAQ67VVvE8KDiyFl7T+Ke4A+
 aaK+v49LWuWQ8pCZj8OHmUw4G3uflQluKiDN7iP8jpKFdAwAsXdTtZdlaB3tic51hBan
 CFZK3kNq48CVodNZpLqOtm9j0MEZsbx7Cn96vrykW233iApA4adWwl+eaXTHkTPqtBaU
 FpMmeydt+EbOuZ6M9OadgCtHMlEHSZjsmq4GPD4C3RcMTFRvTCgPFK4YJNaBeUqSIBAi
 Gzkz3+bNqC8d3LdxBY49TRSKDyLB0KPxcBReF80GChr0vPrPgyfQfNbQataDhnRwHNJN
 T9YQ==
X-Gm-Message-State: AOJu0Ywa2ULFyrKlDy4Z53dw8GGaFPVs21t7xWl8kt9QHLboV8twapNt
 Zuz5e55YMQtFs6okdwLf8oCHINzPqgNxDLoZntSln6LUnacOiLXNcwCU/JC+JpMG/mD/FuAhBr1
 Lcy7Y
X-Gm-Gg: AeBDieuWEwaVqIIFs2QCcazrtQsYYZs6yiL/VPPBen2t8RVRtFYdUvxT+BsV4sDtebC
 6mkMwuS/tLOLhQ0Px9ryomRDgnf0w9lQkD/Ez1tZbOYEuXs4xzbczgda9cnKaww8dANX0qAaS0F
 RlyXluRNpXiPS50KsaxbNULi6HYjWTYn9A8zCaqGrMP69iPcN4PfoJ9KfDJSzbI3gi9ZxIinMBz
 3o9nGtePNB0sPIdnw4L1sRG53L0EvVcchra9tlkC/DT2OtKl3gV9q4CpiO5nzMrJVYUwphSlMQO
 KF3xOO/xalGageuYuqjw3fS14s4amXNNgULka8OsoqmYzFXArW2WiTyaO/cGRHdt3KqO9I45PRz
 SGhVvEinMI4kim1wH5xJBXSlEL2YEjjsAZURkyYbPFkxIYANVm1r71B3LeHACLSTX4lsnH+buw6
 ll8TJjVgh7Jj2BvCyPw8EUeqk9bTcglXjUs4q+fIqpJU9Y/g951xc49ltCCFkGEOcZ+SL2xQWtD
 mjaMoAtGmCJGDaF/pKKllQNtKU3BWcu3OwQqqv0BEUmExZBKrYm
X-Received: by 2002:a05:6000:2013:b0:43c:d665:3830 with SMTP id
 ffacd0b85a97d-43fe3dfd327mr38281837f8f.32.1776938583102; 
 Thu, 23 Apr 2026 03:03:03 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/59] target/arm/tcg/translate.c: remove target_ulong
Date: Thu, 23 Apr 2026 11:01:59 +0100
Message-ID: <20260423100229.2941820-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We can replace it with uint32_t, because we know it's limited to 32-bit
target.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260407222208.271838-21-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index c432de2a26..ce427c5a3c 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6282,7 +6282,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 
 /* Ditto, for a halfword (Thumb) instruction */
 static uint16_t arm_lduw_code(CPUARMState *env, DisasContextBase* s,
-                              target_ulong addr, bool sctlr_b)
+                              uint32_t addr, bool sctlr_b)
 {
     MemOp end = MO_LE;
     if (sctlr_b) {
@@ -6529,7 +6529,7 @@ static void arm_post_translate_insn(DisasContext *dc)
 
 /* Load an instruction and return it in the standard little-endian order */
 static uint32_t arm_ldl_code(CPUARMState *env, DisasContextBase *s,
-                             target_ulong addr, bool sctlr_b)
+                             uint32_t addr, bool sctlr_b)
 {
     return translator_ldl_end(env, s, addr, sctlr_b ? MO_BE : MO_LE);
 }
-- 
2.43.0


