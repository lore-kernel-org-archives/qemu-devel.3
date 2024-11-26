Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9F2D3B98B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFvRc-0000O7-Of; Tue, 26 Nov 2024 08:17:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvQk-0008Rk-VD
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:16:42 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvQf-0003fK-3D
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:16:35 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4349cc45219so23565125e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 05:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732626991; x=1733231791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=decA0AqUsGYrPYvQ/Z3re+icmP1BYXUuyKugc2m0v2U=;
 b=M7VAlJR7QLDJvDTQz+cSIhQgma6JSC22UXkXZ3gzbXz0EsM9H3AY6jO2tqUufacfhm
 Z+VMYHxY7ZtFLC8nInQpYUexI7JTGdlcYjP8z5ZEoqW3Pmo6VJRAp3C/LRR2a7fN7wt3
 fhWWQNrkp6pnjiDgnu6nQthR5eThVpd69vhrtyBAl+fNC3ET9Yl3G6PEmV9o6GRK79++
 1dzguDYl2LU+8LD3GIAZegqO12Ru3uuPxk9yDscxhSTfAeozicyLk4Ec3Lsb5k/MHvPb
 KUllqMc3xxs+pMugT+FAlQ3gBGDG03VO2/qS8VzoeOVvR1mnY7E2axzfca+CVuGSNtkO
 bV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732626991; x=1733231791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=decA0AqUsGYrPYvQ/Z3re+icmP1BYXUuyKugc2m0v2U=;
 b=RWbgZ6oYjgWRD3oIHSanRtVBNi6tSpDNZGTBbeRtkRD/1u8Ii+J4iedvfNq5gp7Im5
 +6Vq5pwTlNvN6mwr9PhoB2nBrduNTrEgMzGQxYIA2I8AGhzbV9cO+U9KwTfAnMAxRvo0
 YU0ePLT9RzSKZ1HgzjEOsdAYSyUkfrNvkD8fRHrnGm9aLhoC4f8s1XReexRkh9Y/Dne2
 3k/uz+TlfNzZ4KAEgFAAYALQVxM874sOBAHA75qSV2ctmg9r6FN4cvG13Kkv4mk1MrYS
 mm56Sys1MiUBOhmivOAKi1I0zQ+Ya8NVfKptzepwqO+1MA2rA9TJBcAfPBz6c7simO+Q
 LkCQ==
X-Gm-Message-State: AOJu0YxAL2S6aoE+7fsoXGndlxa7glT3fCdf4A8zkKx9CGQ3DsBxVG34
 yoi9qgGrhJje5Vfr9N/ATdNqxZMT7Uaw+FTSDAz8Y26BtvtytWVBsSxA4C6yj4HrKW0obruS4B3
 5
X-Gm-Gg: ASbGncvm1IeXKF+LDBoUrt+Y2BagL9VZxNcL0PGZC8eeybzaUBAU8y29jAua8kQj0/V
 ftjcYrH84okLkL+aGluuVxaSNcHgUytpthdmA2HVk+EXqVMuSrq66ZIOlzrtwnd3p7PdC3wu11I
 UnUzO0weHbc4AtRXaN3TRXTbhqCswo4U1HQKZPVgNnyKSV2F+xKb2mY0F/BFoM/VQMwnioXINQk
 2BKq9qONKIkBFZ3gZcdm7ew6cNVLBdn7LNWfukIf6BD2PCj/GCJKAx3rj5FXdGIekzRHmLc
X-Google-Smtp-Source: AGHT+IHWipfHXR64dGHuB0+xqlRjApAxrFlkyDsK6ILBV46a/XF7fycBrcr8+PXx4/5Gea/bTRS9og==
X-Received: by 2002:a05:600c:35c4:b0:431:93d8:e1a1 with SMTP id
 5b1f17b1804b1-433ce4c1f1bmr143665895e9.27.1732626991176; 
 Tue, 26 Nov 2024 05:16:31 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbee043sm13335835f8f.104.2024.11.26.05.16.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 05:16:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 07/13] target/mips: Introduce gen_load_gpr_i32()
Date: Tue, 26 Nov 2024 14:15:39 +0100
Message-ID: <20241126131546.66145-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126131546.66145-1-philmd@linaro.org>
References: <20241126131546.66145-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Similarly to the gen_load_gpr_tl() helper which loads a
target-wide TCG register from the CPU generic purpose
registers, add a helper to load 32-bit TCG register.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.h |  1 +
 target/mips/tcg/translate.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 9517e18eef9..e15d631ad2a 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -156,6 +156,7 @@ void gen_base_offset_addr_tl(DisasContext *ctx, TCGv addr, int base, int offset)
 void gen_move_low32_tl(TCGv ret, TCGv_i64 arg);
 void gen_move_high32_tl(TCGv ret, TCGv_i64 arg);
 void gen_load_gpr_tl(TCGv t, int reg);
+void gen_load_gpr_i32(TCGv_i32 t, int reg);
 void gen_store_gpr_tl(TCGv t, int reg);
 #if defined(TARGET_MIPS64)
 void gen_load_gpr_hi(TCGv_i64 t, int reg);
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index ad688b9b23d..d7c83c863d5 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1198,6 +1198,16 @@ void gen_load_gpr_tl(TCGv t, int reg)
     }
 }
 
+void gen_load_gpr_i32(TCGv_i32 t, int reg)
+{
+    assert(reg >= 0 && reg <= ARRAY_SIZE(cpu_gpr));
+    if (reg == 0) {
+        tcg_gen_movi_i32(t, 0);
+    } else {
+        tcg_gen_trunc_tl_i32(t, cpu_gpr[reg]);
+    }
+}
+
 void gen_store_gpr_tl(TCGv t, int reg)
 {
     assert(reg >= 0 && reg <= ARRAY_SIZE(cpu_gpr));
-- 
2.45.2


