Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3436CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0ljA-0002It-DD; Mon, 22 Sep 2025 14:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lgA-0005Kf-Mt
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:26 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfQ-00051S-OI
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:24 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-26c209802c0so31463785ad.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567217; x=1759172017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DxayGpcvk1WgEIrwtrnI87HtMykvmuTE7R78plec4rY=;
 b=LwHbNeeabulAN7CMWS11hWC5UFJGybtvI7ZZzXFg3bYUT1RzDWeYknGhq2MH6zQBK6
 tPUGs6c22+dvJNSPT3Cv6H4ZEEj77FE/zRCUyWsMmmfVhKTuvr+V3j1jdvF5KXGkZ9X5
 gJDy6q8tdufEmWmvA9akdgYumC1jx2592XFddkmP6kBoslDcCYX9v2QVSnvQY/ukB81o
 n9xbfQyoG/zWDsc6pFrHsIi4yulNdRO3ktxtDoLbStbyiAz9SykWsymurTYMf4KxEE3p
 GTpN+KoM5PqtAGe5XO74fek44PnQcwqNEVunI8TXv0T+QhT8EdQwgAGaEYvOaG0qrDuq
 eC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567217; x=1759172017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DxayGpcvk1WgEIrwtrnI87HtMykvmuTE7R78plec4rY=;
 b=YA1sllsyUiFS3PziOnQ56exe8Ryzm0zqrD6jIw91F2TNy33sHoTLxxwxN5h1MKvAGG
 lkrc0ky6BuBaHZATeoYK9pqZ9EFaWfEC/K5/hcG7xdEeQ1TXrzXjrOWOU8I2FZi3eb8X
 kH0SpwBc3rbuIrjueQPSC0RnKvUAhaVDlihjLyO26F+MTYN4n9RZRrjuiy8exCiZVYmK
 F1kkAor8po6d2L+T49010uaShcUAOvmihVr61B8XkL+VMFDF+awhoK/ZlLUpzD5SBpon
 aNexVP2H0aTDyicS4I3484EFyXXbDOSn9ab/F1PgMALL1Dr9tAZV05gWiACY71sBOsy5
 nR7g==
X-Gm-Message-State: AOJu0YwXD79BS5G0ReC2ICEIgQm93iNPy9e+CxotAy6feBuUPaE+ua4S
 mPExJTM3O8EJF0nyRnPJVRnBvzNyQEppltVwPt/56EHYyCXcLcJhjZ0vkq2mP+FTvJPHhaRkboE
 zTcxc
X-Gm-Gg: ASbGncvAdZ/zhKHdRMELuvay2sSLqj9h43sSwIddyOsowsQr5yhYiqyATl7qMv6it1L
 jBWQl+SNlGD8u064w3ITm8dGpU1N4Xb7471YAyRaoBh9fOCrtLgcb2XuGdrpMICo5N8wuaNisqF
 0Rh8859rvBlfbGCDP7gWqEFPyNrXb4Ked1iMSTW85Cg3h3UIcuwlnmkGCl3BI2Ms7hDeor1fDPN
 UG7jUerEzQ7aWFcDZG9uXlHxhwn+zeVoe41SLx1BBNrjHCQ/XudvvwUeaRP/+WFu3zM1AsADt00
 xrpDtUaYo8TWqQ9XHR7BnWnVeXYMTLJ/sdqdsOZAQTFocBX5fCcaBPzDAWieuvnfIbi0QYGvi4K
 Ht14AzOk6/HLwdFbn6fAYGSXkNrjAjqtsDly0NCk=
X-Google-Smtp-Source: AGHT+IEm9BhY6XZh+EPo6/ymXEwgd3OZCdbT8xKrbgcmfPWJRCaeBcQuysGOQpYSyQtzzxvxkZYe/Q==
X-Received: by 2002:a17:902:be12:b0:267:87be:505e with SMTP id
 d9443c01a7336-269ba45a54dmr131390525ad.23.1758567216739; 
 Mon, 22 Sep 2025 11:53:36 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698018a472sm138554795ad.58.2025.09.22.11.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:53:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 65/76] target/arm: Enable FEAT_GCS with -cpu max
Date: Mon, 22 Sep 2025 11:49:13 -0700
Message-ID: <20250922184924.2754205-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Tested-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 76193826ce..8ebb0a91db 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1206,6 +1206,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, SME, 2);       /* FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_3 */
     t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
+    t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
     SET_IDREG(isar, ID_AA64PFR1, t);
 
     t = GET_IDREG(isar, ID_AA64MMFR0);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 4b07af9eac..21c187a464 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -73,6 +73,7 @@ the following architecture extensions:
 - FEAT_FRINTTS (Floating-point to integer instructions)
 - FEAT_FlagM (Flag manipulation instructions v2)
 - FEAT_FlagM2 (Enhancements to flag manipulation instructions)
+- FEAT_GCS (Guarded Control Stack Extension)
 - FEAT_GTG (Guest translation granule size)
 - FEAT_HAFDBS (Hardware management of the access flag and dirty bit state)
 - FEAT_HBC (Hinted conditional branches)
-- 
2.43.0


