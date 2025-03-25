Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A4DC36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 22:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txD0K-0001lx-Vn; Tue, 25 Mar 2025 18:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txD0D-0001LT-SF
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:10 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txD0B-00071y-6s
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:09 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2240b4de12bso59342585ad.2
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 15:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742942645; x=1743547445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QHX5k2lUgvMa0RL4ytQ9eAaxeLEElDmk4Ql4Y4+DSI8=;
 b=JuHSFqQgR/e307E96SkDtTDBCXlVEu4aAX7qBh3YOqwo563O3dnJJSTr+ZEuX71HuX
 n1eqdV/lGxAArpguyNhvcocCykVGo9g2YZQZLrA8MW//EkhM8+rkTWqIk40nJcKeY+0H
 IdC5bK/PXhnB48WOq9fjxv0YGO/pkLkv0oVAFhZ5B3EKQaEHA+ENW56kKG6DsPXn6XYK
 zxOglN9k4821iUrqtZ/KLCdYV2cJ93N4keis9ceincNRnWW3ofAQJF2Cwl2AeVFftxu+
 50I6Y4r6QXOOnJRBmyozCZquWK2rzbUj7edkHdBu4JvUu5nuFXBrsZmKgqGn7Cxx3WlJ
 4muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742942645; x=1743547445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QHX5k2lUgvMa0RL4ytQ9eAaxeLEElDmk4Ql4Y4+DSI8=;
 b=Zy6G3Ug8+8fEdYlZDcQgu5qz9prGyP5By5ouIYDHrh0K9Z/enp4eTCH4drgiySyNFt
 tJGNJdgoKEzP14VuA+LHuBYioNnFM7NA8GyRgEyvBA+rX5aXsCfMmVA/ong4PCzqLLMl
 tPn/0uidWy/E3l+OaAokcw1ey6qBUntZePBDgxD/GzqcTCqPN7SBWmMFxTzwAR2y3z55
 WydYvOZQk1jq0f/2P96ZIy6nQmCQaWu1dnT6XxTYmD4RN6O05z1xCqPYfRCxbqzO4f66
 XU8DsvKnac7Ngh53v/ixfkp8EOOie0KpupdukLE1DNknnBqzPP9liOWoTSQDupbp9jnQ
 7Gww==
X-Gm-Message-State: AOJu0YxoWKfwnG9IEgMKOD8iQErJ2DB2nVre9r3NXzeBOC+s5PumREHE
 F0w1eDTeeADupIlT1/3LpR8ZDKK5jobW+bfS7FBCrMeMGdoZdpHJA1Gj/teFvEW5X88DduZQzvJ
 X
X-Gm-Gg: ASbGnctHMMhLz4/OAuEydHjak+AgVBVmoKqj8yEZJ6HTWrwtoSJxJd6t2mibCmNhmid
 sx1S6tJ6vQDRpJUpx0W4qYGGLaOzv9XxfPx0oFcYhOs7IW6fTcRfnWfbUtHCPOAuT3IJM4ye0BV
 4TMrPocJYJJJu5qVIfxEJc2MZNyxy0UhQ0hfn2ON2A87E7giFLFmfrzrxc+B7ix+Xs6ZGVaWyJK
 S8a48tOo2jxH7YBKXeJzAiWNTl1gzQsf3ahLMZdxuBe0mCs3EVyiZdikczTXSLNSiOe+Z0l1Qh+
 kxqWYf3P5Pn0wY+rSQeD5glYUwGOf7uiLMDqyR+HsC0lPT9SFZM0lMJbTLoiToCrGpkheQYakyA
 d
X-Google-Smtp-Source: AGHT+IF1BdqqhDB1O6iCoCoQnLWgNuFN+hT2nfQObV+5Idf262uhi43wCOk4OldnVlQVKvLkB7lxog==
X-Received: by 2002:a05:6a00:1995:b0:736:34a2:8a18 with SMTP id
 d2e1a72fcca58-73905a27860mr31732395b3a.24.1742942645338; 
 Tue, 25 Mar 2025 15:44:05 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390611d3d6sm11111321b3a.94.2025.03.25.15.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 15:44:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, philmd@linaro.org, pierrick.bouvier@linaro.org,
 qemu-stable@nongnu.org
Subject: [PATCH v2 01/11] target/avr: Fix buffer read in avr_print_insn
Date: Tue, 25 Mar 2025 15:43:53 -0700
Message-ID: <20250325224403.4011975-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325224403.4011975-1-richard.henderson@linaro.org>
References: <20250325224403.4011975-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Do not unconditionally attempt to read 4 bytes, as there
may only be 2 bytes remaining in the translator cache.

Cc: qemu-stable@nongnu.org
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/disas.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/target/avr/disas.c b/target/avr/disas.c
index b7689e8d7c..d341030174 100644
--- a/target/avr/disas.c
+++ b/target/avr/disas.c
@@ -68,28 +68,35 @@ static bool decode_insn(DisasContext *ctx, uint16_t insn);
 
 int avr_print_insn(bfd_vma addr, disassemble_info *info)
 {
-    DisasContext ctx;
+    DisasContext ctx = { info };
     DisasContext *pctx = &ctx;
     bfd_byte buffer[4];
     uint16_t insn;
     int status;
 
-    ctx.info = info;
-
-    status = info->read_memory_func(addr, buffer, 4, info);
+    status = info->read_memory_func(addr, buffer, 2, info);
     if (status != 0) {
         info->memory_error_func(status, addr, info);
         return -1;
     }
     insn = bfd_getl16(buffer);
-    ctx.next_word = bfd_getl16(buffer + 2);
-    ctx.next_word_used = false;
+
+    status = info->read_memory_func(addr + 2, buffer + 2, 2, info);
+    if (status == 0) {
+        ctx.next_word = bfd_getl16(buffer + 2);
+    }
 
     if (!decode_insn(&ctx, insn)) {
         output(".db", "0x%02x, 0x%02x", buffer[0], buffer[1]);
     }
 
-    return ctx.next_word_used ? 4 : 2;
+    if (!ctx.next_word_used) {
+        return 2;
+    } else if (status == 0) {
+        return 4;
+    }
+    info->memory_error_func(status, addr + 2, info);
+    return -1;
 }
 
 
-- 
2.43.0


