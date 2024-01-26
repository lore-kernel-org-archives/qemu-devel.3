Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0669CC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHG-0002Io-DV; Fri, 26 Jan 2024 09:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHD-0002Fc-LX
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:51 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHB-0007tH-RG
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:51 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3392291b21bso634098f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279628; x=1706884428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qOAj+xgESAfIYVFV2UzsvAbHui7mgq2G92H1X0CLzHk=;
 b=zmYoonAcPr/gZka3/FyrwRsufjwC0Og5SZ2eSrTjMD+qCx21c/QI988JBvpaa6WB2n
 WdXcf2Rg3l0de8zkJf/QXk+SPG0/pgu0sPM1SAsCNMjmOy04ulxXd5xgt/VXC43QWp0A
 u8yAQpTPA+tz9u3C1sz6df1vziUh1CuyaUyrSmOHXP3+umeeTnZxvaPdUT4eKM3p20iR
 q8YjRXcT7Sr+wnh930esOjwaFFrf0Y/Z1Jmnq0xb2/8ZvVf9mfBYdbHMzbDVxAsk8/Cd
 TxwTZvsqgoDNHtrYNqsCps7m7UxuRJVhwakSIoS5HFDoU2XJIrgfEH4UinmobWxxrAkR
 Zv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279628; x=1706884428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qOAj+xgESAfIYVFV2UzsvAbHui7mgq2G92H1X0CLzHk=;
 b=S9rVlQfrOsl+FGiC56BgyUxeoORT8f64/9R1Cj9gM4mZA/CKVN+O97LcnNRlqvqs2i
 dQn2zJvuAGr446pZsl/K6VB26BpzPWQDly0KVbIPSY5+VTf1gfPZkBSki5PHCPjvoUAJ
 u/GpQtbq1B9jObmws4pR2GbzwtpQ7YjF/DKvE/5Z53y1mN5I3Y1TcngTmACwx52+Nf8u
 sNHuhspZTafUG2i38ECOpTV4GGDEZDp43S3H0OtQR74DYESXj88j/c1BCNtt1rRHrA+d
 R10bOpUfC191kQtXUDJEQLFiWJuJUpQfMTUJyW/0/GH1HVuiEK8sakUACSVur6jVZ37L
 al1g==
X-Gm-Message-State: AOJu0YxP70f4I4NDpmkvOdaekn1Vg6n6RiDI3C9B9ll8fkB/iFpj7ylR
 wnubeQEc/Jq90w+C/MwM0IR8xyy/eRF9aqnbKIgrcP/6c6DIe52v/x6VOKMqioL9wJ1q9rkUtZA
 q
X-Google-Smtp-Source: AGHT+IH9rm0cfiLk6G1NIGTrAjISECXOC4gRMXvJ0U4hcDOGKtJXyb2XDlITJ2n+DV5dOKSpjc/9nQ==
X-Received: by 2002:adf:e9ca:0:b0:337:c4c7:d05e with SMTP id
 l10-20020adfe9ca000000b00337c4c7d05emr1047899wrn.46.1706279628343; 
 Fri, 26 Jan 2024 06:33:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/36] target/arm/cpu-features: Include missing
 'hw/registerfields.h' header
Date: Fri, 26 Jan 2024 14:33:19 +0000
Message-Id: <20240126143341.2101237-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

target/arm/cpu-features.h uses the FIELD_EX32() macro
defined in "hw/registerfields.h". Include it in order
to avoid when refactoring unrelated headers:

  target/arm/cpu-features.h:44:12: error: call to undeclared function 'FIELD_EX32';
  ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      return FIELD_EX32(id->id_isar0, ID_ISAR0, DIVIDE) != 0;
             ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240118200643.29037-6-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 7a590c824cf..028795ff23f 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -20,6 +20,8 @@
 #ifndef TARGET_ARM_FEATURES_H
 #define TARGET_ARM_FEATURES_H
 
+#include "hw/registerfields.h"
+
 /*
  * Naming convention for isar_feature functions:
  * Functions which test 32-bit ID registers should have _aa32_ in
-- 
2.34.1


