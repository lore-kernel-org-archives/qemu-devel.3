Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FFCC021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 17:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmc3H-00078x-1L; Mon, 24 Feb 2025 12:15:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2z-00073y-8D
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:16 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2v-0005mC-4y
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:10 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-221050f3f00so105832705ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 09:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740417307; x=1741022107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f02dUK2/HYOHK+IxOxM9vZGLdU2Cvo0XSrJ+BwEQnuo=;
 b=I6MAEQ/prWe+BrUboRXtYNyneGdnJ10tLZJz9z6bNA3kl+TbCSVVciGC86a6GaDMT4
 zRfTQ+w1Onty8X/nqOSUTYlwzs/Z+1gDvlT2ZGcQqlQufxm4+FGZQqpsebW5gGV6GXdL
 33qpPCnO/E0yc3DO2a/pTDANmAf2t6liSKKqx6bnx+rHfKY8jP4Deibqm/4fz0wHsFsM
 cDskxmT38huw5nM0yh+Qtl7e01XohmHZMHx4ZIx15H0xZyhSG726oGJN9fRn3AHhAj9G
 hzf5NVAhcheHnfN/4FGcdYTg2xfLCFyaHhv7HyjY02hUYuDuTiHdq3pcyguF9yQ/3uBy
 9rBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740417307; x=1741022107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f02dUK2/HYOHK+IxOxM9vZGLdU2Cvo0XSrJ+BwEQnuo=;
 b=c6dF2XzKTkytTkdGRWqdiGQmXktZvEPSyhdwdHSzi2V6m36vcF1DEfuZKUGYlI38EY
 7//uSd23JjSWzh/cFYAwdBiv9HjqAm2EAr+DWkcmaO5AmwWXpgZ00Uwrqg/HEi1LYAot
 wqZhSJ3WX7DXo+KBb92h0DF+JEYcemlMC2vSWvNAPVlQyQOTLPwQ4D2jB3/52UxFch0G
 gk0r+DUI3dt2SEG14VKM1ZWv7JXIusHxmR6dAYmAFzVEN+XjDj55KCVqFR1pjvkJmuXF
 pH+aKLSlgEHFMM+ZtDrvTl1G83DFmk1OB2shlTPMWltoxMP+WoqiRncc15/ZzG/Ocn0n
 7yPg==
X-Gm-Message-State: AOJu0Yx8g7+Se7ow8qOBkKY1lYLSEbp5ak9GTKBd4eKo2BWx10t0AY+1
 efHYuW4NbgCuFgNwoMC0gCrhicNJV1KYicXWJdZ+XSeELPE0SwaNlZUhYW3OsmFlrlhoVs2wyk6
 6
X-Gm-Gg: ASbGnct/+xRiiCN75O64zY6Ut26ZlD5DXg6w9VILQZ6RlgU/NYKIcgpxQkL+yJVLxa6
 lwjJSkaOnQAvst9cOVEZrTFFVKiW6564OsUNCbJsItKAnONDBO0DCOAvqPto1s8urWVf5fkyFGi
 zEKpjO/hjkVwIs4zca3Cftt/tnS2z1A0EA1/7DGcCJroODDz3wEf9D8mwVbrD+kUgpAtZjK0Eu/
 O82Z+YbSBR1U2Yi4OAlw39uGwtmg0rCgAjUes3I7nXtZCjq6V0nhebw+MNBX6pcku3E0AfuBYP/
 higURJ7d0ZM5zvPeJQlCZDlrV+yh0Hfk8bY=
X-Google-Smtp-Source: AGHT+IGp27OhBFEIkoqP5/2zsUoPSS4V+s2dOBwonRHnhx/22mGUwJnbQCQp2okKnHk2+Sl+B9wfhw==
X-Received: by 2002:a05:6a21:a24b:b0:1ee:de1d:5abc with SMTP id
 adf61e73a8af0-1eef3d71075mr24950708637.33.1740417307163; 
 Mon, 24 Feb 2025 09:15:07 -0800 (PST)
Received: from stoup.. ([2607:fb90:c9e2:d7e3:c85c:d4f0:c8b8:8fa7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732425466besm20580780b3a.9.2025.02.24.09.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 09:15:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 15/24] target/m68k: Remove env argument to gen_store_mode
Date: Mon, 24 Feb 2025 09:14:35 -0800
Message-ID: <20250224171444.440135-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224171444.440135-1-richard.henderson@linaro.org>
References: <20250224171444.440135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Use the env pointer in DisasContext.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 47938b9cb4..df1bfe6786 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -844,8 +844,7 @@ static TCGv gen_load_mode(DisasContext *s, int mode, int reg0, int opsize,
     return ret;
 }
 
-static bool gen_store_mode(CPUM68KState *env, DisasContext *s,
-                           int mode, int reg0, int opsize,
+static bool gen_store_mode(DisasContext *s, int mode, int reg0, int opsize,
                            TCGv val, TCGv addr, int index)
 {
     TCGv reg;
@@ -1335,7 +1334,7 @@ static void gen_exit_tb(DisasContext *s)
 #define DEST_EA(env, insn, opsize, val, addrp)                          \
     do {                                                                \
         TCGv *addrp_ = (addrp);                                         \
-        if (!gen_store_mode(env, s, extract32(insn, 3, 3),              \
+        if (!gen_store_mode(s, extract32(insn, 3, 3),                   \
                             REG(insn, 0), opsize, val,                  \
                             addrp_ ? *addrp_ : NULL, IS_USER(s))) {     \
             gen_addr_fault(s);                                          \
@@ -1704,7 +1703,7 @@ DISAS_INSN(abcd_mem)
 
     bcd_add(dest, src);
 
-    gen_store_mode(env, s, 4, REG(insn, 9), OS_BYTE, dest, addr, IS_USER(s));
+    gen_store_mode(s, 4, REG(insn, 9), OS_BYTE, dest, addr, IS_USER(s));
 
     bcd_flags(dest);
 }
@@ -1738,7 +1737,7 @@ DISAS_INSN(sbcd_mem)
 
     bcd_sub(dest, src);
 
-    gen_store_mode(env, s, 4, REG(insn, 9), OS_BYTE, dest, addr, IS_USER(s));
+    gen_store_mode(s, 4, REG(insn, 9), OS_BYTE, dest, addr, IS_USER(s));
 
     bcd_flags(dest);
 }
-- 
2.43.0


