Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787B4CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mwn-0002wG-Hu; Thu, 16 Oct 2025 08:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MwF-00023a-V5
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:18:36 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mw9-0008RC-TD
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:18:34 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47112a73785so4431215e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617102; x=1761221902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PPP4W+2GMCtu5NaTXRhA0Y3fwTHqC/v44euxXjto1BU=;
 b=Qe/1peNis2yDYh/t7nWWLm0BJSJ+rpAvfhwctNpHQvSKKN+yiaEyjUKvXFdjeGjfxQ
 2t7rEP8k/tIb4Igk9KYta8GRyyTVCtYS72dNMgq43WJGKMRAWwu1xngkX1rfalPBPhq5
 5oZwhb0RNWwDEHTxDkU20B6wFVaOZ3EH0atTtfr9CmQZO08JQFRBqTWdHJkMtPvjfKS8
 MMNN8cYUhVyBV7wG5uo37qwQQW2TlD/yDKKy+W/sD+DpqvqypPulKKQKhLuenwSQ6o+L
 Q+srbZh2i51ceJI+tAatibw5MKwOTR/5E39E2HOShqa+cIz+VHSGkI6t7c6bpZ6950Q2
 /5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617102; x=1761221902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PPP4W+2GMCtu5NaTXRhA0Y3fwTHqC/v44euxXjto1BU=;
 b=fTJ8Mv+c3HKfK/W1RIcUf0LtXVfinBJxKkCWGZqv06w1uUWnVgHdQuWc9Dc8l3mYen
 GEEpL5fGlguSzWnTxxQ3MelVteBmfWlBstD0QEMBE0a1rZKjC/f5+ZJQK9LA1gZr9gOW
 deNYQKzTjRtBNOFUbA2a5sLQAiPDYl4w2Mn77gkU1jSVNJvKI9hoTDjdYkjfUftOIb5N
 I8Q1ITd3v9I+MHitUV7ck8mjS4OsUI3pOnOPl6ORlua67PEUBrc+veXlrTPEXNoNrrPT
 kemjMq0WYfQp9uA6gr6qHvEMAj7FUDHppePeQn0yPI4NCZDU73gKFhHkYlFLJXO6NxnW
 pR8w==
X-Gm-Message-State: AOJu0Yztq61eimBxyudNSxZ0kB7OxkuPKeUgiXQSbGScdjGcPo+LOLzB
 oO5TfBtrYccFsMgtdjONHpnh2E9Xvp4Hu3yCWhqtxqGvbn7Gfh39FfnX1q390pgmMzDzIXJ0SXi
 IDsktqSA=
X-Gm-Gg: ASbGnctQ91h7VBehphkep+sohrRVWn/2pqSNC7gEbpKkffAyfAYlN5En7JtccIlx1bm
 mgTOLjTrXHiAGjBAmz35hpwReD7wRvZgQBbdiqZTHjebhGHPK34HkOQlZpUY41Y+iZci1tg4aaS
 3krk2M/ag0Guu/hXlmiPZySXMuvaOp81g/tOSlVh2ibtdRde+SFkxP6ZK7TvlMNDbbSoNNlqHSz
 LV3IiDsEgFErTpLHL/wPpMaaNgo2Gud7SJl7DhhnKt9CcAciccG8GQNKEGBx9jdgVvYQTmcEMMA
 JQWW5h9KzOIEombWKV4a8jUrOG96zv6cx4JNkxatbG5Eg6gODmxdwvfmh3T92f3CRKS3peweeM/
 w2aBK1rFG5i+coM+X2in4mKyVdByu59Qjt5tMpGPsky7tRhnbuNsaF4hnQUZDfQO7iFhXm5Gpxz
 lqJQJUkh1jxtNXsHoAQJq4DLH6/5X1F3mpRi9WNnwMhOz7DW2cm6vOYxaUMaDyFsqz
X-Google-Smtp-Source: AGHT+IGyQC134su+mwuuvMoP69QAHm5LSv7rkJWU7qltG8h+n1xk8619gdovHFYO/FMH3cTUPNoYIw==
X-Received: by 2002:a05:600c:c162:b0:46e:4a60:ea2c with SMTP id
 5b1f17b1804b1-46fa9b17e57mr244312255e9.37.1760617101764; 
 Thu, 16 Oct 2025 05:18:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5825aasm33953046f8f.14.2025.10.16.05.18.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:18:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/75] target/openrisc: Introduce mo_endian() helper
Date: Thu, 16 Oct 2025 14:14:52 +0200
Message-ID: <20251016121532.14042-37-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

mo_endian() returns the target endianness.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251010070702.51484-11-philmd@linaro.org>
---
 target/openrisc/translate.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 623513bb15c..1a43e5ab6f7 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -59,6 +59,11 @@ typedef struct DisasContext {
     TCGv zero;
 } DisasContext;
 
+static inline MemOp mo_endian(DisasContext *dc)
+{
+    return MO_TE;
+}
+
 static inline bool is_user(DisasContext *dc)
 {
 #ifdef CONFIG_USER_ONLY
@@ -622,7 +627,8 @@ static bool trans_l_lwa(DisasContext *dc, arg_load *a)
     check_r0_write(dc, a->d);
     ea = tcg_temp_new();
     tcg_gen_addi_tl(ea, cpu_R(dc, a->a), a->i);
-    tcg_gen_qemu_ld_tl(cpu_R(dc, a->d), ea, dc->mem_idx, MO_TE | MO_UL);
+    tcg_gen_qemu_ld_tl(cpu_R(dc, a->d), ea, dc->mem_idx,
+                       mo_endian(dc) | MO_UL);
     tcg_gen_mov_tl(cpu_lock_addr, ea);
     tcg_gen_mov_tl(cpu_lock_value, cpu_R(dc, a->d));
     return true;
@@ -632,7 +638,7 @@ static void do_load(DisasContext *dc, arg_load *a, MemOp mop)
 {
     TCGv ea;
 
-    mop |= MO_TE;
+    mop |= mo_endian(dc);
 
     check_r0_write(dc, a->d);
     ea = tcg_temp_new();
@@ -690,7 +696,8 @@ static bool trans_l_swa(DisasContext *dc, arg_store *a)
 
     val = tcg_temp_new();
     tcg_gen_atomic_cmpxchg_tl(val, cpu_lock_addr, cpu_lock_value,
-                              cpu_R(dc, a->b), dc->mem_idx, MO_TE | MO_UL);
+                              cpu_R(dc, a->b), dc->mem_idx,
+                              mo_endian(dc) | MO_UL);
     tcg_gen_setcond_tl(TCG_COND_EQ, cpu_sr_f, val, cpu_lock_value);
 
     tcg_gen_br(lab_done);
@@ -707,7 +714,7 @@ static void do_store(DisasContext *dc, arg_store *a, MemOp mop)
 {
     TCGv t0 = tcg_temp_new();
 
-    mop |= MO_TE;
+    mop |= mo_endian(dc);
 
     tcg_gen_addi_tl(t0, cpu_R(dc, a->a), a->i);
     tcg_gen_qemu_st_tl(cpu_R(dc, a->b), t0, dc->mem_idx, mop);
-- 
2.51.0


