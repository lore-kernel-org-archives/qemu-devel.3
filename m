Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0FCC369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4lvh-0000jM-2A; Tue, 15 Apr 2025 15:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lun-000081-Re
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:51 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luf-00081q-7F
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:44 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso4700581b3a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745139; x=1745349939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZz3zwe1jbLewTGTEgCXYdDo/Xsfe7IRGb0MUaOjH/o=;
 b=T2ANuSPRYmXeonF2Mc5y6Qri5vn2P7LhfTkQbXUTOidQTpdJ9vkxcZOSX1qP6Aiequ
 i2+epZkpBH0oFsYP2+U2BC0bhfvmRoIWZUo4BdhGT2WOuXgzZreY6uH22tpsPXR6k4F+
 QKGJIYbMg79smlDznFB8g9/3woxKYCrmoBiNOYylf4WyYqfA728jUUytAVkSd08yBcnE
 qKdb8G6pGe4Eca5ArGNOHkvgQddDzLR7spp0LSv8ASLQo1yzb0UJGoapqX6UAJDAOYEJ
 eiYzilcseOt+mH5BnvWiHEukHUWZswDvyi9Ynf1Xb92PTmxlbjU794q8GQZu+9KKOsX7
 xFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745139; x=1745349939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NZz3zwe1jbLewTGTEgCXYdDo/Xsfe7IRGb0MUaOjH/o=;
 b=BpszzxwIuETDolh9vXvfCdZZVGKLCP8mlXIdnt/hVBWI5LqbD9Tfo0408Rg05x+RL3
 IyLlfe3CYgwOoNE2/YAsAFjSiE3dvT/vUzxCFc+tx9Alc0+tmh4PM1sj7jFLmfJtgWyl
 ndU4x6i+f19C+a21mwj3MgRuKbM9ytR+uPzET6TPrVL2nx9uArtk2NGyHRjX71W6uNJV
 XY9XSHRqC8D88KpKJMyu+Twk0sA1AkCug86xJsQI1heZnuC2CIN87ZNWtkux6iBqNoHj
 flJk0LeZkFYDraOTXAAn3W/vV1dS1T4+Tec3wcNPqQF0D36B7eez65jVt+3WwbH8gEjW
 YWgw==
X-Gm-Message-State: AOJu0YzZQrLFNZBLl962xh+3p3jwpcFQXopHSNRVnnw62V8PYk+iZghS
 9T+KjPvWCDwsdkyDqFXN/CCFpJveKU0nSfnvL7XBvrZGfEOFaexunFWc5JUw4PIqoNCF3xy9faX
 m
X-Gm-Gg: ASbGncsPMjVxPm2EyfcnCZ6MunR6tANnPhDdeg0PG60w0SKbVNaJu1GTLE0jbV4IH4n
 wXGTuJdw2rifVUuEyq1hEjHkOo0b4D2oQm2D9CyISV0ZyPcYJBRX8Y+HWRZmvfJCYl6NKANlUT9
 uq6D/Brqkz5eICuNWkFFQ9B0vsYg5l32XKX+Mjwznr2apSnCixctUK88llfoj0Kw/hOhNZOXq1X
 DbJub3uTsXS9K8qLXmnL0yVOWhYu0GsmoZDzFtEqNquQR8zZqh7YdUxB6OzrsTGoKiIfUjd5ptk
 VPdIKn9lm0Fp4qKpOhgi6QIjwnUBZSnf+ti1aGsGID3EbSlpSC0liYF3yrjTcTVUfjnCr8XeAao
 =
X-Google-Smtp-Source: AGHT+IHz4WiCQ+V+ssRJypg0Y9KiUiNZ+aJwb8+VwFzr0iHiKT1GZ7syxr+MhWsh5z4Lvy2GqKWQbA==
X-Received: by 2002:a05:6a00:4642:b0:736:5969:2b6f with SMTP id
 d2e1a72fcca58-73c1f9313b0mr961955b3a.6.1744745138973; 
 Tue, 15 Apr 2025 12:25:38 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f82ebsm9225124b3a.92.2025.04.15.12.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:25:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 025/163] tcg/loongarch64: Do not accept constant argument
 to nor
Date: Tue, 15 Apr 2025 12:22:56 -0700
Message-ID: <20250415192515.232910-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

The instruction set does not implement nor with immediate.
There is no reason to pretend that we do.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index e061ba1654..72e068255c 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1413,12 +1413,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
 
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
-        if (c2) {
-            tcg_out_opc_ori(s, a0, a1, a2);
-            tcg_out_opc_nor(s, a0, a0, TCG_REG_ZERO);
-        } else {
-            tcg_out_opc_nor(s, a0, a1, a2);
-        }
+        tcg_out_opc_nor(s, a0, a1, a2);
         break;
 
     case INDEX_op_extract_i32:
@@ -2308,8 +2303,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
-        /* LoongArch reg-imm bitops have their imms ZERO-extended */
-        return C_O1_I2(r, r, rU);
+        return C_O1_I2(r, r, r);
 
     case INDEX_op_clz_i32:
     case INDEX_op_clz_i64:
-- 
2.43.0


