Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E71D3B98B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFw7P-0002i8-7f; Tue, 26 Nov 2024 09:00:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw7E-0002gq-CV
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:00:32 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw75-00057r-QE
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:00:26 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5cf6f804233so6515538a12.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 06:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732629621; x=1733234421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t1Jxtp13mmLrRw+IUS8eEqglrbhhv+f8+zgRopmtS3I=;
 b=J7VcZv3iShRz3EXvz8i2tlh3f8rV+Tcpl9LSpSKsEQCkngzHSsP3iLYzitPDDwuGmI
 581vVw5kLTUivY0Gw4+TkrJ+xZ+YdC25e8mTnVxHTTCvDLGbUspKEV+N3riSLrA+hOSI
 j5GPa6BCYF/SVmnhkftEV4FZbluwP+S+l60tZfovmEHUzMYbcyE70M9oUALTaJX40G4N
 ttmaiAzGqtmnEgNib3MnfksTCVM4LaV4CVIBD85zwTMv1a/xg7iPAzZbI/ccHLLjGDPz
 ArG56RylkxSKHBbik3TxEMkGYancfbPHHW76D/zncee2AW5j48hucP1VLV/K0pDRO8W1
 R20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732629621; x=1733234421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t1Jxtp13mmLrRw+IUS8eEqglrbhhv+f8+zgRopmtS3I=;
 b=tcovDMzYMxSxvi10rWqdPIZIQ9rpblAs6x8ZAR8Cd6Z4hPDAMbyxHOlHPJY3d51q51
 yOWdK+VEXoifgaC+NkOYlYIg/BYu9NJbeML0BN31ZRZU92PKYUVmkdkuEtPz4QrKOmNS
 ofBhMWl/4crAsWOLpgTBGSr/teyjntCQt+F68afKvpJ9Ci/Q1h9iFXAWuMLAIsrtmbTH
 ORu5NNRGMxraiN+/p5ZqQLtJnJt+FmesNubtNC0sKBdgdJ5IM2ijQpJtvOj9U8C2HVHk
 phpX4i13Ktplp17i5iaSTlkHBuMpVeKFnqmAOsbQVdjMssei7hz4B8vDLmBc4Kg8yN9L
 Y7pA==
X-Gm-Message-State: AOJu0YwozIeP6aYNWWbwmwqnSmJYzApwFW3em0SSqPyQtHK6Y4d+whwY
 67fwpxPxzZLO8jnRxFysN7a9Cd2mu/31Nym1/VMwzjIhloli/3eXGju+jsN4MeCx04T7pIdcX4B
 R
X-Gm-Gg: ASbGncuCknQ427wFmhvX9ed7Ox6m2tFxFlJWSI+q9XPq54C1wU7KRreRgHIs3yDXCYp
 1wiB1K3CKAfDCWGmEQVd5/elfsQFqUn8AaO47h9kFFSKH+ZAEGO1nTDEhlM/Kr78OPUnvqWx+Xs
 n79Yot1RX3srIVjC6eHR8SyT6FMtEgTyf8IYaZM6Zr/4rcaEWbvMUYS9sPJ9duvnfwt6lQ5R3tb
 cDgbaLNAqzMbgSlN83+llhWH2j6LDnJp+4bdDldQccc9gULb318UzlTTNgUw3Jiu1nDkbOVfCag
 mA==
X-Google-Smtp-Source: AGHT+IFMqHUZn0kMYd+iRaYcEWq0aKBjr92CeApZBO26KlyJ2Zl20oDhECg2BQ4JGhw5z3TMgFwwDA==
X-Received: by 2002:a05:600c:4691:b0:42c:b187:bde9 with SMTP id
 5b1f17b1804b1-433ce4ac22cmr159337905e9.30.1732629611339; 
 Tue, 26 Nov 2024 06:00:11 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc42d4sm13722095f8f.85.2024.11.26.06.00.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 06:00:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 01/16] target/mips: Extract gen_base_index_addr() helper
Date: Tue, 26 Nov 2024 14:59:47 +0100
Message-ID: <20241126140003.74871-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126140003.74871-1-philmd@linaro.org>
References: <20241126140003.74871-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

Factor out gen_base_index_addr() which is used twice
but we'll use it more.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241111222936.59869-2-philmd@linaro.org>
---
 target/mips/tcg/translate.h |  1 +
 target/mips/tcg/translate.c | 27 +++++++++++++--------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 1bf153d1838..ed69ba15e58 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -153,6 +153,7 @@ void check_cp1_registers(DisasContext *ctx, int regs);
 void check_cop1x(DisasContext *ctx);
 
 void gen_base_offset_addr(DisasContext *ctx, TCGv addr, int base, int offset);
+void gen_base_index_addr(DisasContext *ctx, TCGv addr, int base, int index);
 void gen_move_low32(TCGv ret, TCGv_i64 arg);
 void gen_move_high32(TCGv ret, TCGv_i64 arg);
 void gen_load_gpr(TCGv t, int reg);
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index de7045874dd..7152f5418e1 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1956,6 +1956,17 @@ void gen_base_offset_addr(DisasContext *ctx, TCGv addr, int base, int offset)
     }
 }
 
+void gen_base_index_addr(DisasContext *ctx, TCGv addr, int base, int index)
+{
+    if (base == 0) {
+        gen_load_gpr(addr, index);
+    } else if (index == 0) {
+        gen_load_gpr(addr, base);
+    } else {
+        gen_op_addr_add(ctx, addr, cpu_gpr[base], cpu_gpr[index]);
+    }
+}
+
 static target_ulong pc_relative_pc(DisasContext *ctx)
 {
     target_ulong pc = ctx->base.pc_next;
@@ -10545,13 +10556,7 @@ static void gen_flt3_ldst(DisasContext *ctx, uint32_t opc,
 {
     TCGv t0 = tcg_temp_new();
 
-    if (base == 0) {
-        gen_load_gpr(t0, index);
-    } else if (index == 0) {
-        gen_load_gpr(t0, base);
-    } else {
-        gen_op_addr_add(ctx, t0, cpu_gpr[base], cpu_gpr[index]);
-    }
+    gen_base_index_addr(ctx, t0, base, index);
     /*
      * Don't do NOP if destination is zero: we must perform the actual
      * memory access.
@@ -11333,13 +11338,7 @@ static void gen_mips_lx(DisasContext *ctx, uint32_t opc,
     }
     t0 = tcg_temp_new();
 
-    if (base == 0) {
-        gen_load_gpr(t0, offset);
-    } else if (offset == 0) {
-        gen_load_gpr(t0, base);
-    } else {
-        gen_op_addr_add(ctx, t0, cpu_gpr[base], cpu_gpr[offset]);
-    }
+    gen_base_index_addr(ctx, t0, base, offset);
 
     switch (opc) {
     case OPC_LBUX:
-- 
2.45.2


