Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F546C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFI-0003aa-V4; Fri, 04 Jul 2025 12:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjF9-0002j0-LL
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:31 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjF7-0006rH-5V
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:31 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a50956e5d3so814095f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646388; x=1752251188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PcYeEZexeoPGuiuqnCkDIO//jKT7XOFYWx8s1iiYCDY=;
 b=j3YhfrbcMHTrEbxd5i1I66UUx+EEUptsxkNCCVtn2LABOaSrV/NWJm071cwYG9nBYN
 immuCbrX4z3t0kd9TXNKx08JBVUAV+cnBuqyBvk35k0TQkGa6beLYMbMrP30YrEEDeBL
 Vnhr24HRPtrAcZ1algLMnTkun4vfqQafXYf1lHZSKNotdy+hFR7Zv/WJWnDf+i/LbfO4
 qFsRJMdZFnK/51wbEooN4QTiQPuX6rBfPUw3/b4Gbab6Fw9MsPFuKYuLrBDejNzX1xB0
 Csgn9HyTCeiy7IxHRJWjrd0eUy2FOrmUyTUqjjFhOE54lC0aLWJLRp87GEW9J/bH0dN2
 trqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646388; x=1752251188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PcYeEZexeoPGuiuqnCkDIO//jKT7XOFYWx8s1iiYCDY=;
 b=FF8ro9WeSFO4LSkt8lHNAYZHfR6Cx9LgdaUdrdci9jvyzWkEiUlVrST3hYoRvukUDA
 +kxlfLnMRnlA5XCJMswfRYrMc9xhjiCJznxgcZvU7BTlBLN0CQXbDORt6E1AjzLq+7fq
 27bba236PNyzdiZoduTOdsWMQkoSnI8HPbhbjUt+FZcbPZSMMsjpGUkBIIUqcwDlL/YM
 XDkRjwQIRl932C0oUzlkG5/B/pzVPyALzIVRjQHTD4zhmUGgwFXxSYXeQaGMSzgsUvGl
 FrCjSBjVqmgiYs4QnDn67CUyug+WFOYUIsCKQKYJLkK07C6BEUr4BP7hA3UHJZAiIuwi
 UTsA==
X-Gm-Message-State: AOJu0Yz/J/GOJ7L8oS33PV6qPtcwvHs32Hk3/Q/f2wt7R+YQJ8emvV/z
 m9FHf8hfKySyWYxLr6fGt2sTwGle28AkWBhtf19cORM/zowaatemShDqtWXyzTTITchGTTizw+q
 l/kxC
X-Gm-Gg: ASbGncvy+XZYdB4izbFRhBVQUM1bmMzzUXhMBkwdpDpAwsCH4nV5hMsAnJSuHrpwU3E
 XWSs4cW4RiG3fy1wwKTBnG+ikIvbPrX7qELt0Lva+ErvneNjwYrYvU0vZR1KTvjxYkZXnuyO3lD
 BgYsgoUnL19Laa2XylFD6ngryUuj6B6f+pNU04vJf6U1q/QlAP7+Jnsy/MTxfUnPhSaxDDW9qho
 mqMh53io9ykJ26L0L+WwD4o9ay/Qk+BKJBxTfWpnDdxo5NB33RY+W4Pn6hWSH5qYRBgiQKv+gjT
 JNYOclntNro/LA+z0XPEMwWKsGgsdLL23onIYs35KkeLosZmLhurlN6qLZXT6GxKYH/hqIhTHEP
 3FOw=
X-Google-Smtp-Source: AGHT+IESMbhQkkkHa6UAr2x2MLgyNezXui8j5IaWluMNCgD9g0lW99wlD1UM0CQX1cwvHTDQDmcVpw==
X-Received: by 2002:a5d:452f:0:b0:3b3:a6b2:9cd3 with SMTP id
 ffacd0b85a97d-3b496604df8mr2883010f8f.48.1751646387649; 
 Fri, 04 Jul 2025 09:26:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 089/119] target/arm: Enable PSEL for SVE2p1
Date: Fri,  4 Jul 2025 17:24:29 +0100
Message-ID: <20250704162501.249138-90-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-78-richard.henderson@linaro.org
This instruction is present in both SME(1) and SVE2.1 extensions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-sve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 62d3e2efd69..cb60b533e9f 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7273,7 +7273,7 @@ static bool trans_PSEL(DisasContext *s, arg_psel *a)
     TCGv_i64 tmp, didx, dbit;
     TCGv_ptr ptr;
 
-    if (!dc_isar_feature(aa64_sme, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve2p1, s)) {
         return false;
     }
     if (!sve_access_check(s)) {
-- 
2.43.0


