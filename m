Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D9FC02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 11:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg096-0007QC-BX; Thu, 06 Feb 2025 06:34:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg094-0007J3-8E
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:34:10 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg092-0000s4-Dd
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:34:09 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso7571105e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 03:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738841646; x=1739446446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RCLsw1b6jyw8lyUUykKTmpsXr484uY+OOog3P2Qta5M=;
 b=FeSiwfT7dtCPPsRvumF4nJCMV964oV4o7b6JK7H+9nKakfn6hVp92vR5YtjO/rPwo7
 I1rZdHBaPafeewcUOM6mqCgm5yTNcuFPW1flIMSYwE3kokBUjqE5YE5LeZm61bmfxmTt
 EPJSsM1b+H9tXBl2bR2SdonWYQiZTnjbens6tTJoF/uNgk72gUsc4pB0UyTsEu8+2Qw4
 wbU/mvSrVdazYcqif0UMdDt4TPcCuM2haXzI44JYZHFMHnviFtUWJMVTkqXwwRTOf1xG
 8Nd470IVkrDY6wyqUA+J7M6B0/WRqWS3Of25OMwDXniMDqtZvJV3mN8MtuxFhiV4hy3a
 DWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738841646; x=1739446446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RCLsw1b6jyw8lyUUykKTmpsXr484uY+OOog3P2Qta5M=;
 b=lJ1+L+PIctfu1Yrhi3+/bWXV9OPHf7A7ocJMKCqUtFvL3WqNtg6sAElVV8Y8CpgYUL
 bLtjaNzLhW4FNmKfUxCkY5QR2TaAvJnrVY0eu68bTKEN0+VoqwtMRmH5qEva9qJzjQFX
 udvHz7/Tzv2QcvesY0yHPotGQ3ULrn96OJHjFPhRpGCpjEjbAmfGeTsK27OHlqVqcr3n
 fqTQ0Qs0XV/RyU0WeVkFfOaX7jIqaJ9XIynbArmR6XPaNeZR2LdQwnLo8wOGKzkPhJmi
 UtHXeaSEAd3G/aZdD9d9Y/HaDnbRxppWhU1Gxr7BVg+6w0Lpb/8DDpPeO4AlluWRqpdX
 0HmA==
X-Gm-Message-State: AOJu0YzJ2WJSqv0ILcGSE33QtJFGFA7o+FOKZbIIbIr/SQPtjo4Vu+1u
 zYnlnY4inj6erCrA0ry88VNC5+4BUC6j9i6MKJL5ey6BVm3KoKw/jPaOwxmiokdhT+vn744iBHc
 G7GY=
X-Gm-Gg: ASbGnctkko34hk+SLxyNKmRMNMzChe2xabp5/4j8Jdc8EuYGk/L6CkTkO8RkJC2XhdM
 iMm9749UNk3jQpp+XtK53T5kQLUiGFCX32xo94VgkB3x0hwjOD5gAx4onN0rm6n4/QkFRU+K2/f
 cd1N7QAcla63ZK919TexLt/OFTywx/KGV3BLxV//ahAi/aqh2RsDXvUHRt3YOIxFAKaoHEOBGZX
 0FtDW7fQ5j3oyIh18LEvuUgKxIO52mfJvSsT5XbO11VHlb5dvYze9qKrhyoSYD3cY8lJddnZT9h
 EeDCQ3VZMtuQf/cSmEGJVcyVcifrIQapFKMf39qvGfdntSlEpzWuhaTwzZkANzdlFQ==
X-Google-Smtp-Source: AGHT+IHbiUV1AIizIz2l2WR3PMewvnrCQJ0Q0iw21yckdJwBo/WQskrqRe3F/iPngpN7L30DSxhf3w==
X-Received: by 2002:a05:600c:3b24:b0:435:1b:65ee with SMTP id
 5b1f17b1804b1-4390d55fcd0mr49019445e9.24.1738841646302; 
 Thu, 06 Feb 2025 03:34:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dc9ffd8sm16200085e9.10.2025.02.06.03.34.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 03:34:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 09/16] target/microblaze: Introduce mo_endian() helper
Date: Thu,  6 Feb 2025 12:33:14 +0100
Message-ID: <20250206113321.94906-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206113321.94906-1-philmd@linaro.org>
References: <20250206113321.94906-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

mo_endian() returns the target endianness, currently static.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 0d51b2c468c..b5389d65b2e 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -708,12 +708,17 @@ static void record_unaligned_ess(DisasContext *dc, int rd,
 }
 #endif
 
+static inline MemOp mo_endian(DisasContext *dc)
+{
+    return MO_TE;
+}
+
 static bool do_load(DisasContext *dc, int rd, TCGv addr, MemOp mop,
                     int mem_index, bool rev)
 {
     MemOp size = mop & MO_SIZE;
 
-    mop |= MO_TE;
+    mop |= mo_endian(dc);
 
     /*
      * When doing reverse accesses we need to do two things.
@@ -848,7 +853,8 @@ static bool trans_lwx(DisasContext *dc, arg_typea *arg)
     /* lwx does not throw unaligned access errors, so force alignment */
     tcg_gen_andi_tl(addr, addr, ~3);
 
-    tcg_gen_qemu_ld_i32(cpu_res_val, addr, dc->mem_index, MO_TE | MO_UL);
+    tcg_gen_qemu_ld_i32(cpu_res_val, addr, dc->mem_index,
+                        mo_endian(dc) | MO_UL);
     tcg_gen_mov_tl(cpu_res_addr, addr);
 
     if (arg->rd) {
@@ -865,7 +871,7 @@ static bool do_store(DisasContext *dc, int rd, TCGv addr, MemOp mop,
 {
     MemOp size = mop & MO_SIZE;
 
-    mop |= MO_TE;
+    mop |= mo_endian(dc);
 
     /*
      * When doing reverse accesses we need to do two things.
@@ -1019,7 +1025,7 @@ static bool trans_swx(DisasContext *dc, arg_typea *arg)
 
     tcg_gen_atomic_cmpxchg_i32(tval, cpu_res_addr, cpu_res_val,
                                reg_for_write(dc, arg->rd),
-                               dc->mem_index, MO_TE | MO_UL);
+                               dc->mem_index, mo_endian(dc) | MO_UL);
 
     tcg_gen_brcond_i32(TCG_COND_NE, cpu_res_val, tval, swx_fail);
 
-- 
2.47.1


