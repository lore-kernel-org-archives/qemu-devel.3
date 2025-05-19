Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBD6C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs3Y-0000vf-Do; Mon, 19 May 2025 00:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGroJ-0007Q2-7x
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:09:07 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGroG-0004JI-Q1
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:09:06 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2302d90c7f7so50605145ad.3
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627743; x=1748232543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6B8XcozBhKUSaO2IzZDRk0dCZYzeMARm9IqAu7+vN/0=;
 b=iWNjZ50OF373nsxgsmByysBHjAtDCeMHjvgOGBRMSeIRiWcMvjTLp4LG269fowXQCB
 UWx7EO+5IotsZ9gNc1Ftyfw/jcOL67CLPj8Cjh8FeYRCAZ/+4KS+uQoeKXwd5vPmMxvJ
 QY9hwgRRpFOGepCu5y8o2ziUw5xlo2KGPk4wCOaPlY+nCW2rnO5QKsx8lZkjo8RqBCl6
 nGfyyQ9aAYUV+R8WM0/6AD3K/J3ynBxRd232124AkRDY0W0KZUY3TCKyVex16lXNpUwH
 q14gfLXkpuxu1trJ6Z6GlHjUg9c6qyWn8UEf7480KKLvZr0KW89uXCPjR+8MA8n9RYQb
 bgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627743; x=1748232543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6B8XcozBhKUSaO2IzZDRk0dCZYzeMARm9IqAu7+vN/0=;
 b=aZDAZ/lBc047JQa57Pp2x+1Lh3S0qnOCsaVy/VqJQqdDM2YNdXtKwGDHmi/uDK2GfD
 oaNGnhaeTEJcgRoJOq1U29iiPav3u44JbpvmYEG6Gs8OAJvh2KaGKwBdvHJYrA7YpBXI
 EQJ640Axz7MppULqa5u8c+760f+/qNtYlQNoG3d+kCIGkOf61LID5YkanQWbP6qzzHLE
 Gqk3moiD/rYf0dZNU3zParbgPZUcJCFQ3/aYhVMlM1qCDanrWg1kd4YkbAxj6Jm45cWO
 tm8hsokIMi6zl7S/x4M0yTYDhIvSsB9Kul4pVDxpLXnzolPFK1zRlKGM+J/YPdfAMLt3
 JNgg==
X-Gm-Message-State: AOJu0YxfwZiGfYm9zJ5JfU8zAkHwQlq0Ez0G3qVEfnxqm0PtbIyAmfue
 GB9D9ufsUOxa6LJ8iCevq0nmzx9aVZ2DjpOXynk6xEyXe8Mva1890lle9/el2Q==
X-Gm-Gg: ASbGncueUlgPyxn/UoQ9FmHGKUdWz/oSuzZJnU2whWxN6SfRY40hKHD0S0gkf6ubfKx
 C1klK9YCJKhyRhno/w380ssqB49HUDIbn4VG6ogUCxc63bn8OQeftF74uI/QK8BIzol7NoUjNj7
 xV7F8bNk+LOSsyVszeEM86qQ3wchXVb5GQbwgVsHl3Pe3vau4Wepp87rDO/qZZX048xWtI2uCjt
 V9mJI7TiHW3wOiKb3OEFFTI2j+ke4LcqIrguOqwzpquLjs4kcCbOYC/SuKrfzThumXmjI9BJLZ1
 a+BH8+BPjRBvfvosuYupdETcqQhJ4kihKVrPwUk2M+2Om9hN6XRfigHr4P6otMrkMBiMbyaKAIj
 p6v08IFEa5ccSDLP+4qgfx+8mULvUwjDZR/ZhW5xsLlzYqUPnQCo+oHH8
X-Google-Smtp-Source: AGHT+IEOF9UlfMdOnWuMQ5Lk8Wti3VsuHKn9jSCVAswey0P7E3m0HFx33yi7n+Xwn7gw86S8gi6+Ww==
X-Received: by 2002:a17:903:1ce:b0:223:5a6e:b16 with SMTP id
 d9443c01a7336-231d438b45emr182939015ad.5.1747627743202; 
 Sun, 18 May 2025 21:09:03 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:09:02 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 36/56] target/riscv: Pass ra to riscv_csrrw_i128
Date: Mon, 19 May 2025 14:05:33 +1000
Message-ID: <20250519040555.3797167-37-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250425152311.804338-6-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h       | 4 ++--
 target/riscv/csr.c       | 8 ++++----
 target/riscv/op_helper.c | 9 +++++----
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f674e93a4f..ff7ba2a0a1 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -848,8 +848,8 @@ typedef RISCVException (*riscv_csr_op_fn)(CPURISCVState *env, int csrno,
 RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
                                Int128 *ret_value);
 RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
-                                Int128 *ret_value,
-                                Int128 new_value, Int128 write_mask);
+                                Int128 *ret_value, Int128 new_value,
+                                Int128 write_mask, uintptr_t ra);
 
 typedef RISCVException (*riscv_csr_read128_fn)(CPURISCVState *env, int csrno,
                                                Int128 *ret_value);
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 807a891e7d..53458491da 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5656,8 +5656,8 @@ RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
 }
 
 RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
-                                Int128 *ret_value,
-                                Int128 new_value, Int128 write_mask)
+                                Int128 *ret_value, Int128 new_value,
+                                Int128 write_mask, uintptr_t ra)
 {
     RISCVException ret;
 
@@ -5668,7 +5668,7 @@ RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
 
     if (csr_ops[csrno].read128) {
         return riscv_csrrw_do128(env, csrno, ret_value,
-                                 new_value, write_mask, 0);
+                                 new_value, write_mask, ra);
     }
 
     /*
@@ -5681,7 +5681,7 @@ RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
     target_ulong old_value;
     ret = riscv_csrrw_do64(env, csrno, &old_value,
                            int128_getlo(new_value),
-                           int128_getlo(write_mask), 0);
+                           int128_getlo(write_mask), ra);
     if (ret == RISCV_EXCP_NONE && ret_value) {
         *ret_value = int128_make64(old_value);
     }
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 0672101637..557807ba4b 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -108,7 +108,7 @@ void helper_csrw_i128(CPURISCVState *env, int csr,
 {
     RISCVException ret = riscv_csrrw_i128(env, csr, NULL,
                                           int128_make128(srcl, srch),
-                                          UINT128_MAX);
+                                          UINT128_MAX, GETPC());
 
     if (ret != RISCV_EXCP_NONE) {
         riscv_raise_exception(env, ret, GETPC());
@@ -116,13 +116,14 @@ void helper_csrw_i128(CPURISCVState *env, int csr,
 }
 
 target_ulong helper_csrrw_i128(CPURISCVState *env, int csr,
-                       target_ulong srcl, target_ulong srch,
-                       target_ulong maskl, target_ulong maskh)
+                               target_ulong srcl, target_ulong srch,
+                               target_ulong maskl, target_ulong maskh)
 {
     Int128 rv = int128_zero();
     RISCVException ret = riscv_csrrw_i128(env, csr, &rv,
                                           int128_make128(srcl, srch),
-                                          int128_make128(maskl, maskh));
+                                          int128_make128(maskl, maskh),
+                                          GETPC());
 
     if (ret != RISCV_EXCP_NONE) {
         riscv_raise_exception(env, ret, GETPC());
-- 
2.49.0


