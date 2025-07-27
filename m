Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECC6C87FCE
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwMX-0000XL-3M; Sun, 27 Jul 2025 04:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLq-0005Je-PH
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:26 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLp-00046e-3q
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:22 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-23dea2e01e4so45471695ad.1
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603400; x=1754208200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g/H+VBjLr5/lNaQTqOOTzzKgeKFHDBsmPau28iTb4mI=;
 b=gihswkdc1yG5zWDmxfP3qPRO3JMzQCb77ovU0Vja85xvReliclYePA/yW1SwEn3UXF
 5kay344Otb+igmvZfU1kxKLPL/84iTfZ173TVN8cx1PIq42sfdluzxRTNcUFkeeMudgy
 ot8vD9dTgIeinoIn6QbnVLFcdMPyswbhqJQVWjyseIq5E6jaje2op+4+rae1I2OGaaB9
 sJE8bQrBSHq9h5GCbLgXaO9lkiDPp1JWhJDc/uCto1sKWMhtAjrsfhHSYd5J1+hrl2+j
 DAAy/ZS9ktt/0GW6EnHxt16kGdtrFEPkARo67xEmcxicYCKb0ywI8S1PA0wvnf8UtrHU
 zFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603400; x=1754208200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g/H+VBjLr5/lNaQTqOOTzzKgeKFHDBsmPau28iTb4mI=;
 b=I6vS805Lpm+d9mpbySGe+4hLo0u/0GwkPVEWXwgn64hjlmrgp0gRAE9i6TqYcj11BS
 bJxkvdKHKN6q+1ZXH7Jea5Y2X1hcUUPACmhg0amvDQkPcz9ktQ4EYKmDAeDNnwuY5EDM
 dkxjWMkYLcCwV1rPwqR+KFCYa2LZLTkKoLJCwwTnTxFLTkvqijkm5F2k5EknS8nZF476
 daA+ILDpkgHiKbOQLXVx/IVehCqBxnhMr09mdfD0vftPBLsJUIuuRaS3nn+xYocs5qhq
 Vso0mAfoRYcIjgm8ePtSZVHfazW5a5jjBZBCIV7xlbCtytnHs3mSRQemRzU0mrjxCq/v
 yMFg==
X-Gm-Message-State: AOJu0Yz8Uf7ncT7nCVdPoL74j+oU1aq45x1jmmfZ4HPyWv93dDu/GzZ2
 vBxsqbC9TSLaQo96T9etFog/upwgmdSuixB5f8R+FNS0seiDfIvUNm5fpPWQQk3cVg1V2CHFIKK
 W9qah
X-Gm-Gg: ASbGncv8XmlRxmV8aw0jwySHAb+p0rLkYAca076UJj9YJJAPGhOMO21z1Dlp4BREe1G
 DBpirc9Ls9dUVKOZ6yyAhK2+JLv9IJ3RWKqJdJq0tLCM/+J7w/3raH9UtUkB4RM5mQHvofay6Z/
 IWz15r+PUB8QTuCzCML+1082e0zr21oAry3pMvTed1edFrkW2cdRyl8A4uJKNzGTnLik/y7Laqy
 lovg88REvRKrlKDvQlgyG7Hstk1L8c1h+XlhWbMhU0FGUUa2oufGGW/EY0KviVaSTZmRd1DZAUD
 YCAQ5Ri2Za3JTM8bbF6yyX7P8dNhfrTgJPmV0iGfwy5pIWPBpY/+HLgYwydrhUvwSymYC9OF+hR
 EJM6xU2XW51rqKPyVJjqMgRknRRrKLmYLmY/zV6i59DDuG+yQ/NBzLMaFJdv2FmztvRfoLOHCIg
 n3qHLLo0VZnQ==
X-Google-Smtp-Source: AGHT+IFWl3mYtL4BVjPxu7XrjmhNtAST6JwW8VgxkFgsUafWT5AcS3A379PaQEj7JzojeSE0JE6NBw==
X-Received: by 2002:a17:902:cf12:b0:235:ecf2:393 with SMTP id
 d9443c01a7336-23fb313a940mr108350245ad.53.1753603399873; 
 Sun, 27 Jul 2025 01:03:19 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe333efesm30016415ad.65.2025.07.27.01.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:03:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 19/82] target/arm: Expand CPUARMState.exception.syndrome to 64
 bits
Date: Sat, 26 Jul 2025 22:01:51 -1000
Message-ID: <20250727080254.83840-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

This will be used for storing the ISS2 portion of the
ESR_ELx registers in aarch64 state.  Re-order the fsr
member to eliminate two structure holes.

Drop the comment about "if we implement EL2" since we
have already done so.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    | 7 ++-----
 target/arm/helper.c | 2 +-
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index fb87fcc3e6..4940bd6a45 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -644,13 +644,10 @@ typedef struct CPUArchState {
      * entry process.
      */
     struct {
-        uint32_t syndrome; /* AArch64 format syndrome register */
-        uint32_t fsr; /* AArch32 format fault status register info */
+        uint64_t syndrome; /* AArch64 format syndrome register */
         uint64_t vaddress; /* virtual addr associated with exception, if any */
+        uint32_t fsr; /* AArch32 format fault status register info */
         uint32_t target_el; /* EL the exception should be targeted for */
-        /* If we implement EL2 we will also need to store information
-         * about the intermediate physical address for stage 2 faults.
-         */
     } exception;
 
     /* Information associated with an SError */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index ecce93fb97..154bda3cd4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9438,7 +9438,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
                   new_el);
     if (qemu_loglevel_mask(CPU_LOG_INT)
         && !excp_is_internal(cs->exception_index)) {
-        qemu_log_mask(CPU_LOG_INT, "...with ESR 0x%x/0x%" PRIx32 "\n",
+        qemu_log_mask(CPU_LOG_INT, "...with ESR 0x%x/0x%" PRIx64 "\n",
                       syn_get_ec(env->exception.syndrome),
                       env->exception.syndrome);
     }
-- 
2.43.0


