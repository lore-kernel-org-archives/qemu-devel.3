Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B11C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafeg-0008HV-Hs; Thu, 15 Feb 2024 12:36:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeO-00082M-KF
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:56 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeJ-0003zm-8b
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:56 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33aea66a31cso641302f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018550; x=1708623350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pKs+G+6C/JfE8C7mwxRiU1ycw8HBab5TyuPtSYaZWAw=;
 b=sE3lygMXznrwX1W/fNZNxaLits7Ez4ZVpGkDrQ/ZWtH7whYrmMYKbqoNSPat28Vjgh
 J4nYOuCCeVdiXKe9JO3T0E5TH9r+q6eZw7NfH3YfzTqa+eKKwElar3c87N7Z1ukv40w7
 a+WiA8h8U+xjEyMTAIDfL/xMQbpwj2KKjGzSh7kdD8yzC7/HPuFF2fcbnKS6TAR3JM00
 WQvz4/Rf6ZiVKhpkioLaC1Yl3oaDliRV+FL/aNuW9LgS4HL7DVCscoqi3+a8vT0IEnBJ
 HJ5Rv/v/rPRhLtJmtGOtdRbX1x1Gd4YS1qUHGAR8CKgdZBhD1qPpkLzdYKMNVAwB6igN
 zfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018550; x=1708623350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pKs+G+6C/JfE8C7mwxRiU1ycw8HBab5TyuPtSYaZWAw=;
 b=Q9eb8IS15YncdvQxvuvo93XLzEDtCEu7+7OmYCsY/z9qxjNbMjecsQhKD9oMD/giUH
 JqgYyMX7ag6qgNOnsmpBflfyNiu+JsShXxvNVVF80pFljJsKCGvZXlkUYPXdrZufDKvP
 Mt2rnqvKyhrQpTnkcmxADFLPty8PNSfhOL+8P9EHE16sjbnxy3+CCHHhgyfJv0aysKCO
 ajNAzWUUCV41gZxsVf8CgLXW6SyvlGN61iKBxwDkKlwV+KjMrj0/ejx29h0PAMy5bQqM
 CGVEy05FNQFnj+eHmrOrAH9ZK28GpQBKnaF1ilUBPbuFuhtUHuUULUaFckV6jCJFTmdQ
 U30w==
X-Gm-Message-State: AOJu0YwKQS4rQ5ygUW+7kPnykhujW+KENMU2Wn5tqw0GKhVkwNs5CbPW
 mJ5GV6Y0wgi5Dd/JFwHuPTsh16ACjNj7D7Jdyezo4waJZpGO2sSiz/Xuv+Y0CkOUuhcF5r+7UY0
 /
X-Google-Smtp-Source: AGHT+IHG5iYCS7aeyTXlu25SMFksRivQYLLuQCzt07sTCj31RhrkIslZDAw/4zFPsUXSW+oWK6pELQ==
X-Received: by 2002:adf:e6c3:0:b0:33c:dd33:90cb with SMTP id
 y3-20020adfe6c3000000b0033cdd3390cbmr1886736wrm.14.1708018550014; 
 Thu, 15 Feb 2024 09:35:50 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/35] target/arm: The Cortex-R52 has a read-only CBAR
Date: Thu, 15 Feb 2024 17:35:27 +0000
Message-Id: <20240215173538.2430599-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

The Cortex-R52 implements the Configuration Base Address Register
(CBAR), as a read-only register.  Add ARM_FEATURE_CBAR_RO to this CPU
type, so that our implementation provides the register and the
associated qdev property.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240206132931.38376-3-peter.maydell@linaro.org
---
 target/arm/tcg/cpu32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 11253051156..311d654cdce 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -809,6 +809,7 @@ static void cortex_r52_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_PMSA);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     cpu->midr = 0x411fd133; /* r1p3 */
     cpu->revidr = 0x00000000;
     cpu->reset_fpsid = 0x41034023;
-- 
2.34.1


