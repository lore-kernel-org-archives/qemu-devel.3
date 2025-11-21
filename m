Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEF6CF64B1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd27-0001Ha-7T; Fri, 21 Nov 2025 21:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMcbX-00048y-9B
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:40:00 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMcZV-0002lN-MN
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:39:57 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b73a9592fb8so556322866b.1
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 17:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763775452; x=1764380252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gX9jGmeu+KwJPxY0MI+9o8DmOfeDSzlJfBVH4f7ccoo=;
 b=mtycuAHV+Zz8F+oM2KomidNA5iFwvYiUIRV/tW3h3CpTu3xcuVun1j7Z8DOtenoQLX
 XvZ/YNEedT+vGuuzAcjyAZWRqeLEdeFvSikKkD3fc2Ky6yGNUYs5zPJRYL8vodBXTfpA
 cQjwfTeRW5fm+LXIPSYU7Idc6rJokxwZUab13fFlZinItuJMoYK5PvOBMyS+xExg3g0W
 fnwFOwJxOwK6OL9rotEJmd1/8soFPvgfQnhqR1jKDQUAB/AV9OUtA5FQBfPjkQMfRADT
 LbPVW2KKckf4KYVL/A7aE4ad6zBOjnXa+3Dhna4M++fZWTuWVheoWSXcoqrIb4Uo2PhO
 gNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763775452; x=1764380252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gX9jGmeu+KwJPxY0MI+9o8DmOfeDSzlJfBVH4f7ccoo=;
 b=dbxgMJGxpdEaho6BN9rU4XdI5qgDeGF6cppDROiI2FcjteUv0A3o2j3qrpYW9eosAe
 uJErgYTYHytX5QNvo/cVZp8SuP6tx7nlFAfk8d1Bt+cwJ0kOEYGNkETztdTni1sLrQao
 Vf3DiA4tW4zI6ngz6L9pq2cjkLndIBN3MsCLD5YxFC1Vh89GFos+v2984ok0Z68SgabK
 r868Riv229/0dxcS9BN5/PgFbQLMZFkE+QL/yGtXlakmrmSYevfduQGGqZhpUTDKaxge
 VT0AA9VJOzCugiuNRE2Myie5rvzEK2Qfv8xxeTtNoyQ4DWFPqkISwdxQuLILdrLDpixH
 xNdQ==
X-Gm-Message-State: AOJu0YwDfMfhOTGHYk142imDHFWkgALjT9f0p0M/TW+1SOVcsUWUn1pi
 zcfGBsnUTqExOF0CH7I5Nhf8YdV+YCqbXyD0bI8uPk3L/NqNmJ+Ql96etzm3SpABsZt9OTH0pjr
 xt3heNT4pqQ==
X-Gm-Gg: ASbGncs4AHoibf/XaGVLHjL/lJJ7NZrH2LoNe9MEvwEtYFPbVR51rcdNDRFHIUIqogS
 Re9lS8/TzpRrq3WnxEWBr/m7VqVu/HoZigKmvpPew8ehOzIU1qLH7Phb4EA1OcWqNDxg47iNJIy
 9aUlBNmc/AF2FXoORMxKgH1wXzKOGZr6D898NWR/zp8pXHVZTthVqA/uJarzGoLFK+hDiYFTPQo
 3BQayMxlJWP3fXMpmci12lz5x+C8Zp6bLXpnhakJW1pTLv9yfyfsYYQUGb0pyg3Hiak2LpWtfXI
 TbLLNuY3OGM8gpKhRWK9LKhbHxn7XHyeYJTdUk6Je2GeqEKOgfutjGbtn5C1K/G26xUjAQ7CDcq
 unNtWRnZVIydIkjpswWz7RE/5f4sUwlSldLCe+tRsOdh+esrXW5SktV/DM9j+6v1o+n7X/Eeb9Y
 54klCcGqBFjN2EYMWe4+fegfwRdmhDweoT00HgbSxUxTKPHcgdE5S5RvjkBky2
X-Google-Smtp-Source: AGHT+IFOH4LNpKae+OXXzyYpeXqAhEmkuW3HbrrPigIx2IrcfACRtYTQr9+u6IbBTF8irO0fqbXFBA==
X-Received: by 2002:a05:6000:288b:b0:426:fb27:974a with SMTP id
 ffacd0b85a97d-42cba7c4cc9mr7182956f8f.27.1763732745859; 
 Fri, 21 Nov 2025 05:45:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fa41d2sm10946251f8f.22.2025.11.21.05.45.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Nov 2025 05:45:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC-PATCH-for-11.0 v3 06/21] target/riscv: Use little-endian variant
 of cpu_ld{l, q}_code()
Date: Fri, 21 Nov 2025 14:44:48 +0100
Message-ID: <20251121134503.30914-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121134503.30914-1-philmd@linaro.org>
References: <20251121134503.30914-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

RISC-V instructions are always stored in little-endian order
(see "Volume I: RISC-V Unprivileged ISA" document, chapter
'Instruction Encoding Spaces and Prefixes': "instruction fetch
in RISC-V is little-endian").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/translate.c  | 2 +-
 target/riscv/zce_helper.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index e1f4dc5ffd0..847481a9b41 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1182,7 +1182,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
     CPUState *cpu = ctx->cs;
     CPURISCVState *env = cpu_env(cpu);
 
-    return cpu_ldl_code(env, pc);
+    return cpu_ldl_le_code(env, pc);
 }
 
 #define SS_MMU_INDEX(ctx) (ctx->mem_idx | MMU_IDX_SS_WRITE)
diff --git a/target/riscv/zce_helper.c b/target/riscv/zce_helper.c
index 55221f5f375..992e2f964e0 100644
--- a/target/riscv/zce_helper.c
+++ b/target/riscv/zce_helper.c
@@ -44,10 +44,10 @@ target_ulong HELPER(cm_jalt)(CPURISCVState *env, uint32_t index)
 
     if (xlen == 32) {
         t0 = base + (index << 2);
-        target = cpu_ldl_code(env, t0);
+        target = cpu_ldl_le_code(env, t0);
     } else {
         t0 = base + (index << 3);
-        target = cpu_ldq_code(env, t0);
+        target = cpu_ldq_le_code(env, t0);
     }
 
     return target & ~0x1;
-- 
2.51.0


