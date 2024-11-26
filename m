Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015C8D3B98E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFvS6-0001fW-04; Tue, 26 Nov 2024 08:18:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvQo-0008ST-0E
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:16:44 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvQl-0003gW-2J
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:16:40 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3825c05cc90so3646265f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 05:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732626997; x=1733231797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NRFaOAbwvwcs4m43OVY/bnuL6cj5pbeln7bkTpDrxFM=;
 b=OXdIOn9dBfFnD+2nqN7fo3wmixSxutpwOF32ZwvHUQSw00rXai5IYeoJup5vsdIPpb
 gwQ2b12vo8FxpsNd+z3X1pOnPmOQrgDrKVBIC6XdHb8VA2r0ozRH8K3Rclow6E+SzwRa
 EFQGqjPttnrJON+MQ6fhPeYj81PgLeOxd2RqA2Jxdc/USP2AgnAQ3yMTvlErdo5BNskF
 RKZ2Z209ZymawJxMooLOYsjfI0H0lb9ial3TTaz02BYJ3R25ySDo3rmZPajhHe5xjKts
 pg97OG+qQmz7HksgP7Z7dv/ilQpkyM7zI0OZiwFajCL4pEYBR8bqmMhm1dyR3jWIuK5h
 hxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732626997; x=1733231797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NRFaOAbwvwcs4m43OVY/bnuL6cj5pbeln7bkTpDrxFM=;
 b=KB4pyPDfYPVmJBjWgZ5r6HSrpolP5BIDG91WsL5PEa88HOFifOQQy7jk7VvK1LT1K8
 Q/2OhoicHH8KciK89gaYAG93j9ZhypqKxorkBNH1n4hbZ2r16Qr9KUqrmeISn+XTohaV
 o9vQ8drtbYoIoxkQrt+xQ7RLVpweM0z0DsVluulGMc59nIN2P3Mkpg3dCZs1vMDi8oWt
 1Sh7d5/PT4q6g91feZFXjjLs2G0bfpwY8eLAQrxr8mRC4JYp9PX7/gypNQmXkNI+nCXU
 U4TrY1s075Sg/C0hhZRavTsbHtCOr4QDnEm0ETU2GY8z/RdvNq/OpkiPTzBgjFLcS42t
 qPcQ==
X-Gm-Message-State: AOJu0YwfUeQVGfJrGLHsYdvlMTXuW/ucQ9yZOs3TStZ1ebPuUBZ0Ty7t
 cvO99hPYU2mJNGnY8eni1qt3/JMOVcghxKuGhhr6/Zct8LsahqtMWu/8uLjEKKrljd7INxpmUmL
 z
X-Gm-Gg: ASbGnctH8Ep2QjmWErvmC2ST+fmhDO+uJDfcTngtGWqmrV14UMLAO/LREYIFasmqpvf
 UP5xsf9DAbZo9c1Suj1KGL+wMJQEaSEGXJXvwTo9ujTt2t8qK7bddmQqWzMlPNggsscxLZQYm5l
 +WdRXSkZLG2rQf1SJXkZzw/Q3eLKg5M0PUAK46x0puQ4AbNvQoXMaLAI2CGniH8STi8iyy+k+XA
 +Z/X2ieGlfzsfdHTMaBv1wmRt97VjQqzQhg4OkJ017iQLO1DETWNAg2CxqM9Gk6lOp0lJMq
X-Google-Smtp-Source: AGHT+IHYkhzo1tdW73+SJSCXtnDzdiXeJ9xv4DhnAzIngIqAcFcOZavgX+D+2UuOhfVTMfTbK67L1g==
X-Received: by 2002:a05:6000:2cd:b0:382:498a:9cf5 with SMTP id
 ffacd0b85a97d-38260b5ae29mr16808245f8f.14.1732626996769; 
 Tue, 26 Nov 2024 05:16:36 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a59c46casm25977585e9.7.2024.11.26.05.16.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 05:16:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 08/13] target/mips: Introduce gen_store_gpr_i32()
Date: Tue, 26 Nov 2024 14:15:40 +0100
Message-ID: <20241126131546.66145-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126131546.66145-1-philmd@linaro.org>
References: <20241126131546.66145-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Similarly to the gen_store_gpr_tl() helper which stores a
target-wide TCG register to the CPU generic purpose registers,
add a helper to store 32-bit TCG register.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.h | 1 +
 target/mips/tcg/translate.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index e15d631ad2a..d9faa82ff70 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -158,6 +158,7 @@ void gen_move_high32_tl(TCGv ret, TCGv_i64 arg);
 void gen_load_gpr_tl(TCGv t, int reg);
 void gen_load_gpr_i32(TCGv_i32 t, int reg);
 void gen_store_gpr_tl(TCGv t, int reg);
+void gen_store_gpr_i32(TCGv_i32 t, int reg);
 #if defined(TARGET_MIPS64)
 void gen_load_gpr_hi(TCGv_i64 t, int reg);
 void gen_store_gpr_hi(TCGv_i64 t, int reg);
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index d7c83c863d5..6ac0734d1b2 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1216,6 +1216,14 @@ void gen_store_gpr_tl(TCGv t, int reg)
     }
 }
 
+void gen_store_gpr_i32(TCGv_i32 t, int reg)
+{
+    assert(reg >= 0 && reg <= ARRAY_SIZE(cpu_gpr));
+    if (reg != 0) {
+        tcg_gen_ext_i32_tl(cpu_gpr[reg], t);
+    }
+}
+
 #if defined(TARGET_MIPS64)
 void gen_load_gpr_hi(TCGv_i64 t, int reg)
 {
-- 
2.45.2


