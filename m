Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4286CC87FCC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwQO-0005LZ-13; Sun, 27 Jul 2025 04:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPI-0000yf-Sr
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:06:57 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPG-0004it-S0
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:06:56 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-23dc5bcf49eso46938105ad.2
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603613; x=1754208413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=++Cy69LINFZDrXdrTLqtc7wtmB6LxpThVdWCRFE8Wj0=;
 b=HZjf8yH04XHIprUoWm2eHUSbVHSyWZEsyEfmQri/eyKhvG+QYgctKQaT/1EpDohbAr
 Y/TmlrQ9ro25aYy+xmXSIoZH0KVUY3a2yuVrkb7TR5GvLl1LZsdGBG7FpG/b0+JzS6Z1
 27RQsk/l+npvG5pAJgApKkoAUIoU4Ut2k9C95CtvhrdncTraFAg4uzFJ7yEFEoLKKeWR
 62KQP2fmeo8SpN8aUYie//RiOOSepWvCSElO8BOmXFPb6U/t3hNEsWTQnquX1h97ra3H
 NaVZGKrBD99jFdZTtNpyCkVSseC+Ir7vUXmMa8fb03exv9oMKMg0hmEaJ8U+MsDlIP7L
 MlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603613; x=1754208413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=++Cy69LINFZDrXdrTLqtc7wtmB6LxpThVdWCRFE8Wj0=;
 b=FVqIcraiJguTFclIeswIk+aGslWAu/pug7xWKuURQU+AQRkGAsWie2/ClG2yV3a1BX
 5UI5dP4SZNULCPNSQRXyc1QfGHTClxtlKJiM0HfOjVHI7LOlaa+VbxJP9dojKXjTNYG8
 NH+RDR4pwD1gI0CXw3cadOx83vB95wf59dgX9yjc/f6kzxB9DRiIjkfL4Eh6DgNKABwp
 t47rBmyNtxFZALcBRnurHaaX3DH2MLpTLaWu+vJLT6ruGXLRvIOU4sHLo3xtM99Af1Vt
 EmR2Zw7f9V86/CvHZu0SfrS8cMFhDAatpXDEsAXSlu0ElSaZryxiexhQWQ24Yq3ARrlT
 n/zQ==
X-Gm-Message-State: AOJu0YyL1QMXMTZlOtjrMrzqBfTtjzjO1AGa6wRjJoOO1yInCqy8kwtz
 a+cG2LtF3YvZ1htcZGDQIsxzYWd6+qxxSgFnXYI1E7Dt8K7SFcPv9nK6Yx3gIOkWDpRBQXtLfVL
 MkVd0
X-Gm-Gg: ASbGnctIiTMM7nf4fFGaoiyGKzUI7dzSHB168eWDYnonN6fquqh56edT+w56IbhBRw4
 Ovhslikzpw60dbFWE8Lu3DfBtevdmb20YU+J+i5MMmV0rJLmqKiSXAR0U/x/rXd08XZbMjFeSwH
 8qriVR34fb5xC2qcaaMItRUa70MttJ2ZdXu2nQZNEkfPevr9PZ5Qnsa6rSoxzfo8ZcVYOVtLqFT
 UEZ23k5itZWRqvImKaK8t8NJddiFV76scxEcB6YenA4PH9L1kOMFMwKf55slRJQ8RQ9jV0k2DkX
 YyZZx4aRh3H/bk/4dGwlE7Goebgp7yswHuPo6yaUYf/Wjl43OVvsC2/2gg8QCMytFYpnWZk8PI6
 pQH2Dxh1gA9d7IYQeBaTSBRkFGbotnAw9nA1fJ6hTm+781mixM+WTM/sn49DmcLNyuDtAu97lrZ
 HbsC2lYz32hg==
X-Google-Smtp-Source: AGHT+IHOUX/HL/pMvbV6Y1ALjFzm1L/dAQ3ppwp7NGAFiIn0x2lHOWBsR9QoqSka7Zymiw9EuHTslw==
X-Received: by 2002:a17:903:3c26:b0:237:f76f:ce34 with SMTP id
 d9443c01a7336-23fb3082c1bmr121104465ad.15.1753603613488; 
 Sun, 27 Jul 2025 01:06:53 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24011d5bcbesm3908065ad.10.2025.07.27.01.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:06:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 46/82] target/arm: Implement FEAT_CHK
Date: Sat, 26 Jul 2025 22:02:18 -1000
Message-ID: <20250727080254.83840-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This feature contains only the CHKFEAT instruction.  It has
no ID enable, being back-allocated into the hint nop space.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 14 ++++++++++++++
 docs/system/arm/emulation.rst  |  1 +
 target/arm/tcg/a64.decode      |  1 +
 3 files changed, 16 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 7831b3dab3..34d22cac8a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2124,6 +2124,20 @@ static bool trans_AUTIBSP(DisasContext *s, arg_AUTIBSP *a)
     return true;
 }
 
+static bool trans_CHKFEAT(DisasContext *s, arg_CHKFEAT *a)
+{
+    uint64_t feat_en = 0;
+
+    if (s->gcs_en) {
+        feat_en |= 1 << 0;
+    }
+    if (feat_en) {
+        TCGv_i64 x16 = cpu_reg(s, 16);
+        tcg_gen_andi_i64(x16, x16, ~feat_en);
+    }
+    return true;
+}
+
 static bool trans_CLREX(DisasContext *s, arg_CLREX *a)
 {
     tcg_gen_movi_i64(cpu_exclusive_addr, -1);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 6ebf9c9ce9..b894aced89 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -28,6 +28,7 @@ the following architecture extensions:
 - FEAT_BF16 (AArch64 BFloat16 instructions)
 - FEAT_BTI (Branch Target Identification)
 - FEAT_CCIDX (Extended cache index)
+- FEAT_CHK (Check Feature Status)
 - FEAT_CMOW (Control for cache maintenance permission)
 - FEAT_CRC32 (CRC32 instructions)
 - FEAT_Crypto (Cryptographic Extension)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 8c798cde2b..4315ed8dab 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -246,6 +246,7 @@ ERETA           1101011 0100 11111 00001 m:1 11111 11111 &reta  # ERETAA, ERETAB
     AUTIASP     1101 0101 0000 0011 0010 0011 101 11111
     AUTIBZ      1101 0101 0000 0011 0010 0011 110 11111
     AUTIBSP     1101 0101 0000 0011 0010 0011 111 11111
+    CHKFEAT     1101 0101 0000 0011 0010 0101 000 11111
   ]
   # The canonical NOP has CRm == op2 == 0, but all of the space
   # that isn't specifically allocated to an instruction must NOP
-- 
2.43.0


