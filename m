Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC19CD129A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt8K-00026o-Iv; Mon, 08 Apr 2024 13:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt8H-00025x-SH
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:14 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt8C-0003jI-JS
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:13 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ed32341906so962669b3a.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598607; x=1713203407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cP8jA9GFq1yR+e10bjvG/FkvD/Ggh4PQtWX+MXPzUjs=;
 b=lTJvob900ZquP5RvzbX+VFDZKvWJ8q6CoX1gKWJZsx91XuuHiH+0gM7241ThTwmT6J
 1nnDW1IWf/RCCvUAGLPgs74yKNbb2JPjgVt0YlQh5sCTWhplqlkCfz87gyALWP6HjJRS
 hIoRjNhLv9JAciCEw0EieVf1GbPrPgW0/ARKaefL0RF/vQedJMjrOIyflfkMpDKGITSn
 a5pWcM4h7PHUENOEt3omvw0VzzyzBCzXndZ6Vpl8YnrkYFynLpg/uLrjhtV66MHPX9Yv
 BRUKbQ99t/l+hhCRVip98RMDY8YiFe8IiTJvSK8KFm4Xh29+/VFWGjg4e6efkCTBFX2G
 HHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598607; x=1713203407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cP8jA9GFq1yR+e10bjvG/FkvD/Ggh4PQtWX+MXPzUjs=;
 b=a3FjeXFxb4EtKpdnGMKUTPRoxzJkio4Bi2lOCvSE6KkrC9+vIA/6vfBDJmioeWYLqS
 76IVQMjvkdR8TPRj+4VEkTh8yXcKRsKT238VyMO/tJIVK1nq9fy4LJeSVe8yuRliXOEq
 VeIKq4qvN3rGGsRucARJkYjhjj9szumJpOnB3tI8+G5cTx9kCiqQrW+aN4y2C1MSuaH/
 1MCgUpfiwj3WhyyZzOJI2eD1j0jj6aYsAHJB6CCuK5C5stm3kVFf0HfNsyP3o/583hb8
 Qtwi8p2tjEmYy6elE/kf2uv/woLFLvXvKDmk0M3vwCk48QXWZpDhM76nJ5ldZF1QRlf/
 EpDg==
X-Gm-Message-State: AOJu0YxjRuhbQ3BVavYZxT6/TFF7q1YOLkpqm+77xhfUFehrhJhVxtvY
 jsjyedWfCEiZZSo+FF7zanvQ7huDtiMJ1p2XrLeK/6AAcAeHZHPCRr+FzQPvBl4Ee48L9I08N9A
 4
X-Google-Smtp-Source: AGHT+IElnT4gcdfTpp83OSg8Mhf7bmwOWkA/wEJsOw0Azbljcv8Nom3I+VGyTPCYkHR4dtXe1sUSHQ==
X-Received: by 2002:a05:6a20:158c:b0:1a7:545d:d334 with SMTP id
 h12-20020a056a20158c00b001a7545dd334mr4763093pzj.47.1712598607383; 
 Mon, 08 Apr 2024 10:50:07 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:50:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/35] target/microblaze: Use insn_start from DisasContextBase
Date: Mon,  8 Apr 2024 07:49:18 -1000
Message-Id: <20240408174929.862917-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 4e52ef32db..fc451befae 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -62,9 +62,6 @@ typedef struct DisasContext {
     DisasContextBase base;
     const MicroBlazeCPUConfig *cfg;
 
-    /* TCG op of the current insn_start.  */
-    TCGOp *insn_start;
-
     TCGv_i32 r0;
     bool r0_set;
 
@@ -699,14 +696,14 @@ static TCGv compute_ldst_addr_ea(DisasContext *dc, int ra, int rb)
 static void record_unaligned_ess(DisasContext *dc, int rd,
                                  MemOp size, bool store)
 {
-    uint32_t iflags = tcg_get_insn_start_param(dc->insn_start, 1);
+    uint32_t iflags = tcg_get_insn_start_param(dc->base.insn_start, 1);
 
     iflags |= ESR_ESS_FLAG;
     iflags |= rd << 5;
     iflags |= store * ESR_S;
     iflags |= (size == MO_32) * ESR_W;
 
-    tcg_set_insn_start_param(dc->insn_start, 1, iflags);
+    tcg_set_insn_start_param(dc->base.insn_start, 1, iflags);
 }
 #endif
 
@@ -1624,7 +1621,6 @@ static void mb_tr_insn_start(DisasContextBase *dcb, CPUState *cs)
     DisasContext *dc = container_of(dcb, DisasContext, base);
 
     tcg_gen_insn_start(dc->base.pc_next, dc->tb_flags & ~MSR_TB_MASK);
-    dc->insn_start = tcg_last_op();
 }
 
 static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
-- 
2.34.1


