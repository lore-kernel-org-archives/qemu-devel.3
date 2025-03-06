Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2905C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDTw-00028t-V6; Thu, 06 Mar 2025 10:49:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDTn-0001H1-Pm
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:49:48 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDTm-0006PQ-1H
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:49:47 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43bdc607c16so6571565e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276184; x=1741880984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JHufb90aAQPXYkdAYjcoLZv75tv+O6S6Pg9iD8hfp6A=;
 b=urwIXbP0lYZfd466Jdif/67wLh83swg0ISfDfoNQPYYMulmpwTWLTess7mgDw78Pio
 ruO50isBxfrr1HOohvgRzneWWHoTw5zZlFHg9ma0bhaGsdiXjFjF/2cSkf0z3rht+kAc
 NDWKwLgkSaJlGDINyuOouSdvzxH8VlsEEfmSp2tPCx1YQ1hxMz9boeYhuMJKj66b0BtU
 zuFENGC+ifBWzhaSxl70hoG7VmIrc1uwE4E8Sk5GJCDtH9UR/yw8I73EEaMwg14mRHU+
 RPjau5g/xDQLK2EHkqyUSNtp0q+z9ofYPms5xszCCBQnUpR43qt8POCrHRqMtpUUZR4t
 y1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276184; x=1741880984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JHufb90aAQPXYkdAYjcoLZv75tv+O6S6Pg9iD8hfp6A=;
 b=GgjH5b/p44Xzegz/A0GDuG4UdctHIBCxoKtLXQRq7HI/lL0qe9fBTypkbshEknpdug
 YbMMvqdl5MBPZZxI/GUj0oUC7ccY1tdFF0moDJbZcEpVN881B9Ip4QsaSYr6STbbmx9n
 5AnTIELGuW9SSsWqKOeFYVbObDmEyECHsPbYoWiVnWwI0jYWO8RQGZqb3tVl7W0w1SL4
 oiYlnDJO0sK0qhFgk/CGdNQ2TsET/hL8XyV5Mdx5OSLb0LkMbVuTj0rzhzbD8p49QJYR
 xSJQIwt/IXWrDoePKj0MxL+Y27V7z5iJehLuTPMP7Y7eN8g10vBr/pNr2fhvxN16/Bh5
 tFTg==
X-Gm-Message-State: AOJu0YyTUia1nvGhMhmb2KYTqzx+lx9Dqu+C2aTfp/dk5ccYh8pTEW+3
 WsSVPg4keHqokKf43zm1oAprbve80ie5Yrnh0jm4ksDg//jABGvoyvooB2VTg+R6cUJxq2KCqMu
 h0io=
X-Gm-Gg: ASbGncsIvTGrbFnOzp7XCR+dbdHqy9VzdtvkcTTyMPxaIBQEIuY1A6yEOuKa8XIDspJ
 nMJHEUYr+ER79mIxm9AKXzQAXl4rSB9cCcyX7FNShFRWB2jXBksk/O8OrM93o1SlXL1GZKu/Y1E
 cL/uIROJjCDnieKCKNBg++MMPrkpPlNOgV4PFYIsv0NbECYaj8Pl2Yi5u+ZXZB9TBkvTj40Bt6S
 zA84ZK0AdONM/j8mFp3ikdmO54fhJG32q31cyWhhgJjOeQbmuGrPlmB40TG5TCDXctMLKnSlluX
 NkLfiAv5GIuRqonS/auTiS0fc5AXo8XDGrZ41PQ1KIIcBdPtQ49EDY9wTZafFsTTAucQ3sie/OZ
 E50zK5A7+l7o/QZFA0Mk=
X-Google-Smtp-Source: AGHT+IHgYMVNwtGHitcuLKdLv2Grt4G6fLRo8HL/qGhQ7dVm9pUhvBWyJOd40ms18Fj9YS5g3svAkg==
X-Received: by 2002:a5d:59ae:0:b0:391:2995:5ef2 with SMTP id
 ffacd0b85a97d-3912995602cmr3037855f8f.37.1741276184087; 
 Thu, 06 Mar 2025 07:49:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfcdasm2369930f8f.23.2025.03.06.07.49.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:49:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/54] target/microblaze: Introduce mo_endian() helper
Date: Thu,  6 Mar 2025 16:47:10 +0100
Message-ID: <20250306154737.70886-29-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
Message-Id: <20241105130431.22564-16-philmd@linaro.org>
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


