Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1628C021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjns2-0007oq-7k; Sun, 16 Feb 2025 18:16:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnqG-0001Iy-JU
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:32 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnqC-0005TK-Lf
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:28 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2f441791e40so5402150a91.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747648; x=1740352448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sof/uzW5h2Ec1uqsF0LsdHyWvNflLyyFXYvZsx9e2cg=;
 b=MVdoTYwbXndvN2u0PgXPi+CJMP6YHYUgTF9v9W46v9tohN0DH/AzCz59qnYPRS0h0G
 S18hwF5wELQG6AnXtkb34XHM9ra6Ym3UhwWr/cEoe4YPQ1g+IR4SgWQlT5htCmG0hqh6
 ml3RljoWC0P5Pd8zSBUIgf/qZPFdK0a15fe7cGvahWephH98Dqc9NFbtdUe4DR96nnLV
 WIGMK/Mwr7qCsakJvkF9e/81WrkK5kNRWptIiYRGUpYIwcpKlU5e/n1mweW10kyFc3es
 FOZcrBUygC3bx+UuIoXIVCXy4wRPI6+KRnvxAklQBYwqKa2j8tSX/H3K92eGuYz4Qn3Y
 UXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747648; x=1740352448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sof/uzW5h2Ec1uqsF0LsdHyWvNflLyyFXYvZsx9e2cg=;
 b=StuqQZkGoFcK64peMA62EUyW8+aF/+H+NJi+saBN5FI/UmKfLr/g2MvrGdtDjJa0MV
 zdwRkYdV7+5p9XrBLvKHupajDB4lQrr/48P1ZEtVBElbpdsT4RrjPpj5Q2GWafGUV3fk
 9tvCCpXBpkX/+XtXkBpt9fH8R5+sBvKK89LuNsl/OHKTd6AoN6IEKYzMxkQP4h3UURTd
 jS/HpFpPCZ+rn3w1Bi9zPLsu4LytbdbuY8kRWeY21h69FgGUDofiXx0pBJ35UKZ1/LmN
 YlwE6r+dv43toS1XKG3XlP0lVDUi7SKU8kH+L+x/5sCXlxCHeuUbQaKL38zpog493qQv
 ZJeA==
X-Gm-Message-State: AOJu0Yx2r2SVxZkjsfkDcS2HunewO9dCz4n3Jl+krQaP9cBW6xJ6LeYl
 vtLQAO0A0ttuNKK5zXwtw+dtY3zyKWnRR07DlJVLxsybmC/qQcNf8RKJ32/Jn28Wik5DkfJ4N+5
 o
X-Gm-Gg: ASbGncv7lAF/WNAfI5CE43PjIeNQfkYbRDqVfsKwjIWHSWF+5JxXP0QRFoUBiY3kPvt
 iY8eSwUNAO+rp0/in4YX0UamYmljkjlSr48BsoNhVnlQrzT5zbYC3DOSeZxI6Y3/wxPAeNpnd6n
 bDiEtlNpdjcLrdpVZTn4iH88IsY3V7ENNadk96v1hRdkK36ZJIXEtRIZCtiZErQCdTTljQJwtP4
 r6KnvKvpklkRKmDb/Z6wr2tsOAJyFie6MqyZZTre//Mj0Thne6f2PrBzTLEcIeGfLUATUS5716r
 5X164dbv69hlkOxBFYG1CRiYeaEN3FfYDwANSPL/6HPzJjg=
X-Google-Smtp-Source: AGHT+IGWgUjFKC7i6tT0zyoH40MAKcHQjm4qbXOQ9IwWcgQjB9uZ/mX5ZYIz0xMmn0VzYRGkfRmD3Q==
X-Received: by 2002:a17:90b:2243:b0:2fa:1f1b:3db6 with SMTP id
 98e67ed59e1d1-2fc41153d9dmr11855389a91.29.1739747648478; 
 Sun, 16 Feb 2025 15:14:08 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366882sm60565615ad.95.2025.02.16.15.14.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:14:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 073/162] tcg/tci: Support negsetcond
Date: Sun, 16 Feb 2025 15:08:42 -0800
Message-ID: <20250216231012.2808572-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci/tcg-target-has.h |  4 ++--
 tcg/tci/tcg-target.c.inc | 13 +++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 2402889bec..7787347e05 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -10,7 +10,7 @@
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_negsetcond_i32   0
+#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
@@ -19,7 +19,7 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_negsetcond_i64   0
+#define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_add2_i64         1
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 563529e055..2eb323b5c5 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -79,6 +79,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
+    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond_i64:
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
         return C_O1_I2(r, r, r);
@@ -966,6 +968,17 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                           args[3], args[4], args[5]);
         break;
 
+    case INDEX_op_negsetcond_i32:
+        tcg_out_op_rrrc(s, INDEX_op_setcond_i32,
+                        args[0], args[1], args[2], args[3]);
+        tcg_out_op_rr(s, INDEX_op_neg, args[0], args[0]);
+        break;
+    case INDEX_op_negsetcond_i64:
+        tcg_out_op_rrrc(s, INDEX_op_setcond_i64,
+                        args[0], args[1], args[2], args[3]);
+        tcg_out_op_rr(s, INDEX_op_neg, args[0], args[0]);
+        break;
+
     CASE_32_64(ld8u)
     CASE_32_64(ld8s)
     CASE_32_64(ld16u)
-- 
2.43.0


