Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916F5C87FD2
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwRM-0001Xp-Cr; Sun, 27 Jul 2025 04:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPT-0002He-Pb
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:08 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPR-0004mE-GS
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:07 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2400f746440so1203835ad.2
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603624; x=1754208424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FTtFiV0an9RhLFd9ouBN3Y+ST0hrHevuMmYKg7N5y/k=;
 b=EyOggIoiXbM3OrEa6s7UDiRFLefGumhfPweuO/h2zW0oj3WGi3RllEjHhcw2gPinDs
 +UbQz5V+Kq5O4g3pmrNhoAi4fLBqRUlH8M7JjtB4mukocD0refusi6zAvXiqWsT1rNGh
 y6DqqeyULTSCiHMfxzwhO/6K78kz/TKnE1I/6bTpyOPxl4f2eTEolymffxBJN9Lhgjpd
 //0pP98MZ94nKE3JDq4WLNZ8PQxk6Hf6S6GjwUlyr/MwMnr0dScfni8rLZAFL3oSNoON
 gv13fULJ+FOZRxuXBnejwqjNHtqA5e6/3up5M+qGxOfSbRA81QfnftRZx/4KPDIiq0DZ
 Yr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603624; x=1754208424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FTtFiV0an9RhLFd9ouBN3Y+ST0hrHevuMmYKg7N5y/k=;
 b=tCdQw+o1SFyNe2Wc2MPfNzsadzWUJuG5rJSwr25nhufVC6OqG+F/cvG9NHByQMluGj
 qFqQIMG39sONC1MIf6HxN0qktXuTahcy4Xqfo/85cHYfYPWuZ32vTJcLDB5/oxws6f1X
 ABeYUW9xWqpia4n2zlyzVi4eMCdZ8yRqN0gMT1pRxQ9DEQuzU1fQ+aBqedig0fd8QPMx
 K9sGxuhqi3bOGi2PF4+XaVyi0q/JK9AbR/IPh3E8YLrqEqJHbPRYbW1H5lQlJbB1hXC/
 KOIRhT5AmQDU5t+pvGlIr6PNRI8uVerxBYVN/sMDrNQEIO2HBT0Hq8cTBwFuBDKfynjc
 xysQ==
X-Gm-Message-State: AOJu0YxriEp57XewqylFFNuj41vr8T9/JBnqRpsWJXZPJ/HR2ubx0dwA
 OfYJtZsjrCtRg9Nt/skKCzlQ+NpIkDtsSQCAr1OHai1gSXckXLPqhDBd/Teg7PztdIkbXK/b3M3
 WS1Kg
X-Gm-Gg: ASbGncsLQP5z1R2cGWEWc4waIdPWfixvuoli9YlHKGL4tfTtvwEY74wiwRXwXs5zr2N
 3rrqx0S6262slJsAgG0mTQ2DFTaD+JmhnJrMHJkS1WT7p7IRFrjg4rMS9beO5t7b03KfTHcOe8D
 w1R9i9yJQzKWG6oBanVKuXwt16lzCPQk4GR7NFCypzd+Ocs+Mw86vN/5mRZp845X3NEJK2SDkNB
 XNNrHEuLi646oiWJ+4meue8pSwZAefXtqIIKHLDbnXlxReuWTkPyM2TB4Bqze1orTxLre9yqLpo
 xQSyL1JSh59qhMk81xJm48w5KwX5PbqjgSN6yB0yg6sqkCxKtbWWkmBLL3iPCZXr9oOiFKN3qXm
 riWyJtwIUkKz4dim3sxfmgjNG06oHUqasDESh+8obYf0z4F9ijDndWguWPak6yZPVB7QbKLbIGc
 tJ1vLFrltLeIKOfVN5vR8x
X-Google-Smtp-Source: AGHT+IE6vX4jo34NmC7DNBiNa7fLgG0kAJ8oMwYLk+ZYdX+g5pw5YJKKxaizdXQ1juFMo+pt4JPpVw==
X-Received: by 2002:a17:903:1b05:b0:234:b743:c7a4 with SMTP id
 d9443c01a7336-23fb30e42a3mr127818165ad.38.1753603624225; 
 Sun, 27 Jul 2025 01:07:04 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24011d5bcbesm3908065ad.10.2025.07.27.01.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:07:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 55/82] target/arm: Implement GCSB
Date: Sat, 26 Jul 2025 22:02:27 -1000
Message-ID: <20250727080254.83840-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
 target/arm/tcg/translate-a64.c | 8 ++++++++
 target/arm/tcg/a64.decode      | 1 +
 2 files changed, 9 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index e0548f7180..45ff7bb0b2 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2072,6 +2072,14 @@ static bool trans_ESB(DisasContext *s, arg_ESB *a)
     return true;
 }
 
+static bool trans_GCSB(DisasContext *s, arg_GCSB *a)
+{
+    if (dc_isar_feature(aa64_gcs, s)) {
+        tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
+    }
+    return true;
+}
+
 static bool trans_PACIAZ(DisasContext *s, arg_PACIAZ *a)
 {
     if (s->pauth_active) {
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index d034d96b37..e8b0ef07eb 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -238,6 +238,7 @@ ERETA           1101011 0100 11111 00001 m:1 11111 11111 &reta  # ERETAA, ERETAB
     AUTIA1716   1101 0101 0000 0011 0010 0001 100 11111
     AUTIB1716   1101 0101 0000 0011 0010 0001 110 11111
     ESB         1101 0101 0000 0011 0010 0010 000 11111
+    GCSB        1101 0101 0000 0011 0010 0010 011 11111
     PACIAZ      1101 0101 0000 0011 0010 0011 000 11111
     PACIASP     1101 0101 0000 0011 0010 0011 001 11111
     PACIBZ      1101 0101 0000 0011 0010 0011 010 11111
-- 
2.43.0


