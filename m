Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9AED0D172
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 20:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vda6q-0003ns-U0; Wed, 07 Jan 2026 15:26:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vda6p-0003n4-53
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:26:23 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vda6n-0006Q6-M6
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:26:22 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so26472105e9.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 12:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767817580; x=1768422380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ydQ4hyKcRIPoui770YEugM394L3KtDMNtyKzwbflh9A=;
 b=zLZQNbN0WyPWzDDSfnOw2NhnsDrjeq3zQ8FYLmpVmJ4g0E275Quk2MMHUeZXgWLOYs
 4F/TZFbzOLMbVGfYd+ytLlraadvnBvRH85lfdwFO+8ghVp5G9QJM8Li2erNnULOnFtgG
 nPwzHIJLD/nEylEMP2dC0H1OjWjqjQROu/MBMJu7lW8vaDA2MyeNWNHLhnH8ODYe4JCc
 uB7UrlnUtoSiuRRh79GiY9/zDyPkl76R2RNPnj9ntqx5K2SOBh/zYzX7ZBbwZDRxSEWw
 IlwdTcYNEdhxLjTZRZhHk+TE5s5RfZvXS+Co4PMiptfcMEMrTw8DeNLG7tWzVHvN6aKu
 WRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767817580; x=1768422380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ydQ4hyKcRIPoui770YEugM394L3KtDMNtyKzwbflh9A=;
 b=s493lj7pls7cw3hrlBTCgxKIXfaKvQQ+7ceFtlnow5OZMxKklY4tq+Z6pYV0UcWJkf
 QC7bc015iQ0ygwoRZgAei3xhLEjdvWknzwXKniQjO6uqDjuzS033GkCzGz2C8j+btPpn
 QoJrrvxqKa9wvm+C154/X+QBhoC7c295JbVFKHXeqt2q52j1eaysrLI/daY99liyBJyx
 wwlKpvM0F0NrhiEFwsHZc4wQPXY/j+jUX4HvCu+5lmTGvCRKHt6zvXHeQqOT4RGN+fYt
 ZhxtBaD3cVVdHqSn3V++sRKMVk02SerMHO5Cx5A1PIh7whDlmnUVNwGDG6M+P7TnJmVj
 gLoA==
X-Gm-Message-State: AOJu0YyJGolTdy/yw2ezCvDeanTiFjwQ+KmSafFUacYmpgLUm4lHMHTq
 4D2KsUZkEj4xLtUl/2dyEZzVB0cb3J7qJSUvhR7Q/XB9/bZiaqhPAhz7KAFTTwSvLULkFX8qdZJ
 NNh7VUZ8=
X-Gm-Gg: AY/fxX53M7enjZM4qYNE515Oa9SAAI+rzOqHGscJE9YeWx8iOsSKIj6229rs9l5UMhi
 zbEghVVbE3LlKzNATVqd8Nz5XUE5St4tIfr5EZ8gTDZ86aOYKb3DYqDq+eU7RuGB13hSGKFPGd7
 kcgrWe9mNJlkW3UA/zJd4O/avtGHjCQKJGXLOz22Hvpr6Wc6rvJVplACJUdFPGViUrxycBNWAth
 aS4zYVy0GPfkZW0hwTGcqUwOZp7ZbRwkOurZgT/G7IDkHKPSNXbjpf5yZ4GWmbKFMz3QdsJ5G5O
 EIKJbX/UdZxusZiM/2v+U+FcPUCRd+QAgLfMKINZu7FWzOFlfMYn6C71nHp/qRQMk+D3MqYqD1Z
 3lMRLcc56pkXLqNGjtfcHO2Y1ucl1rGaKI8X8DhTOjVzx+BaH9XKgoyBbstWwjpJ1aVuyQeMG9o
 hKA3csghB1rlS0z9FDPqlkwcYCGJQIjEovIAFnD+q0pH5D/gnPW+/jofDSoCbh
X-Google-Smtp-Source: AGHT+IFRy0jBzumLZlQVwZs3x82r3sn+hltUmV3B9xr0yzcrvGj7KBV/x9LjdZ3MfrPzTOMZKLu9ZA==
X-Received: by 2002:a05:600c:1d0a:b0:477:8b77:155e with SMTP id
 5b1f17b1804b1-47d84b17b55mr49350065e9.15.1767817579680; 
 Wed, 07 Jan 2026 12:26:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8717a48asm20620035e9.8.2026.01.07.12.26.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 12:26:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/7] target/xtensa: Replace TARGET_BIG_ENDIAN ->
 target_big_endian()
Date: Wed,  7 Jan 2026 21:25:52 +0100
Message-ID: <20260107202556.55787-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107202556.55787-1-philmd@linaro.org>
References: <20260107202556.55787-1-philmd@linaro.org>
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

Check endianness at runtime to remove the target-specific
TARGET_BIG_ENDIAN definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/translate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index bb8d2ed86cf..36f069d70ca 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -34,6 +34,7 @@
 #include "tcg/tcg-op.h"
 #include "qemu/log.h"
 #include "qemu/qemu-print.h"
+#include "qemu/target-info.h"
 #include "exec/translator.h"
 #include "exec/translation-block.h"
 #include "exec/target_page.h"
@@ -1381,7 +1382,7 @@ static void translate_bb(DisasContext *dc, const OpcodeArg arg[],
     TCGv_i32 tmp = tcg_temp_new_i32();
 
     tcg_gen_andi_i32(tmp, arg[1].in, 0x1f);
-    if (TARGET_BIG_ENDIAN) {
+    if (target_big_endian()) {
         tcg_gen_shr_i32(tmp, tcg_constant_i32(0x80000000u), tmp);
     } else {
         tcg_gen_shl_i32(tmp, tcg_constant_i32(0x00000001u), tmp);
@@ -1394,7 +1395,7 @@ static void translate_bbi(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
-    if (TARGET_BIG_ENDIAN) {
+    if (target_big_endian()) {
         tcg_gen_andi_i32(tmp, arg[0].in, 0x80000000u >> arg[1].imm);
     } else {
         tcg_gen_andi_i32(tmp, arg[0].in, 0x00000001u << arg[1].imm);
-- 
2.52.0


