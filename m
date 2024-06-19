Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDEEC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 21:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK2PS-0002Br-Ny; Wed, 19 Jun 2024 17:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2PQ-0002AO-4O
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:00 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2PO-0000JO-HX
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 16:59:59 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-656d8b346d2so158975a12.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 13:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718830796; x=1719435596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sJSgr0Lrw8auwaqOO9jWXlr9TbttWDWK1ZwpPbwzIGM=;
 b=cH/EVC5NeAVNDE2e5YHkq1FIrmHm7M55IXSHCURsdPgRBMnxvisW8ubOknjTDxiS43
 NvNlbN618Ai1ToDryqVLqif9XAk2hNQ1NYVNqD5QmRhgRHE1Jzfxw99AXk7IbAdIHKnx
 6fR95Sy0J0Z7FBhAWt74l0ivQ5PrycDh7bEmLg0ssMACbgzDUzoDxg/w1oHvxU4dbxp5
 ksYI305jNE56yFJrMzKRUcETIQjY0P/Zm+h0yG/Ol0An7UyN6I/6ceqkhslA4wUWpdaN
 hPubuvT4oEwCdr441WjbhWHEcW/QWKgjcriHH47CQqI6am+ia1bTTdKpa0A8lXtD21s1
 L6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718830796; x=1719435596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sJSgr0Lrw8auwaqOO9jWXlr9TbttWDWK1ZwpPbwzIGM=;
 b=ToW+TnwuHMAIVQnL1XVrhBpyMnjHNV9yFh7QFjfqqODmGdpw66ALOdDUKXvkOqKbno
 9IlSTMDLdxHZJ0fPTs/EoF1aM8zMPT+2sKe4haXxxnFfG49NRTcS4k9l2IDBPJYlbEmS
 8c/BzwMOr5ePM+p3u9L/LxmNNCzcdrcUi3jC1g6NgH0XK125Ok6f79cGIcpC9XN9+Rae
 082a9Qz5oHxdlqA36kHt16y8aTZ7Zvx+vMyfHTCBBYOmKE7tU9XOo/8yDGB3LVB4Pki1
 uWu1EZqTuqB6mTR2qafZDEFLhD0jcVoFKG2w2/0U3JgVVq2sAddR5UDiUOFqb7PTtVJJ
 qM1w==
X-Gm-Message-State: AOJu0YyfyPvB3V3nbus8Mzm2MN7LgK0Phwcg79LU41FCfyylV1wjdNpl
 /GI8zDNM+ZRW5wqPXOgALGBNWBf9q67T+opA2TLqCa+DctbRr0UCRx6r3byiBMP1Pdm0XrfAWei
 5
X-Google-Smtp-Source: AGHT+IHEsM8zOWPUT/O0bOB9kZVg9/0MFB9A1blGUwdBsosP6zZJMMl/VWpAsBlKamjjRvkrKKN4Gg==
X-Received: by 2002:a17:902:db0e:b0:1f9:c3e4:4c0f with SMTP id
 d9443c01a7336-1f9c3e45052mr7190845ad.34.1718830796494; 
 Wed, 19 Jun 2024 13:59:56 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f98f8f8c42sm39183765ad.162.2024.06.19.13.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 13:59:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
Subject: [PULL 03/24] tcg/loongarch64: Handle i32 and i64 moves between gr and
 fr
Date: Wed, 19 Jun 2024 13:59:31 -0700
Message-Id: <20240619205952.235946-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619205952.235946-1-richard.henderson@linaro.org>
References: <20240619205952.235946-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index b9078ac793..de5369536e 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -303,11 +303,23 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
     switch (type) {
     case TCG_TYPE_I32:
     case TCG_TYPE_I64:
-        /*
-         * Conventional register-register move used in LoongArch is
-         * `or dst, src, zero`.
-         */
-        tcg_out_opc_or(s, ret, arg, TCG_REG_ZERO);
+        if (ret < TCG_REG_V0) {
+            if (arg < TCG_REG_V0) {
+                /*
+                 * Conventional register-register move used in LoongArch is
+                 * `or dst, src, zero`.
+                 */
+                tcg_out_opc_or(s, ret, arg, TCG_REG_ZERO);
+            } else {
+                tcg_out_opc_movfr2gr_d(s, ret, arg);
+            }
+        } else {
+            if (arg < TCG_REG_V0) {
+                tcg_out_opc_movgr2fr_d(s, ret, arg);
+            } else {
+                tcg_out_opc_fmov_d(s, ret, arg);
+            }
+        }
         break;
     case TCG_TYPE_V128:
         tcg_out_opc_vori_b(s, ret, arg, 0);
-- 
2.34.1


