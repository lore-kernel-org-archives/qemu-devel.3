Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1BEC87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 11:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufGoj-00027l-Rd; Fri, 25 Jul 2025 07:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufGoZ-0006LS-4G
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 07:42:16 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufGoW-0000Nt-B2
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 07:42:14 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3b77377858bso1203260f8f.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 04:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753443731; x=1754048531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S7dUODUWWd+agD+0iis1dgtZor5mLl9A30mFizv3r1k=;
 b=Jf0U083jp5Hvp/ARMRm98yVpsCVn0mxWfoI+Uy1uO9HlS27MKy04xzn9QfEOT7geMP
 88Y4sQmZxaSfweuECulFjr/SgfjOIg6pKSeWk41tUir8AOXNaRC2BL5AUi2mgBMCJqQp
 kWgGlNQQBBbiSAwsP3gezpL8xxEvx768kAqfE5kxRCMWNN19DYUTsLoFUvbZauDOgLbr
 WZmfKRmPD2UU/xXoFQkyk689YKI/oBq7bBLXW54b48VuMFoYaJnWvOKxeN+4p+d4KjKs
 TIks+PqcbaFJMvHCxyxZxRKDPz2RdaDlRTl7k+nHGCxRLxztYtuTPjEO3bkhynWSgN+F
 /OPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753443731; x=1754048531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S7dUODUWWd+agD+0iis1dgtZor5mLl9A30mFizv3r1k=;
 b=ib58w8oK2E2PrpK04I+Kn36Vd5HtliSesJRnaYPLNDFr6HPdKEInbmc05VjyMgRWbO
 Aj6HAbGUnK/F0F4qYQ+Y2cr4fT5747CAutENSpkMHerfofYgTmZvmGRgHbsWuw6+D6vJ
 2nLOxvvBIqWRtA452HIAZaLW7lAdFKPKkTOFtOdUZojqu063d0o+a4K73wWRnOx9iWdE
 TNg3QMQTIVbaAmiySXKYBDFIRxksKU+E23RuNiMEAOQLvsgxuAES65nOV2kNArDHjzhZ
 7AxEyxmsLjgTXoeFpaZ1KaNTRu4qismkFOFIFc6ogjUY9Ehua1E29kYHeL6MNBMnON8M
 PZ1g==
X-Gm-Message-State: AOJu0YwScQOJeD0tLa19yN5O9RzybTcruFbXNhDldOoHuWZ8qdDssSFr
 TDOrF8KOeDz3CH68BYhvlTpqlztWy1Rw6cyoBeEjyD9vGVCUIOi7mFRJaMsH5CYzGzbrkivmdiR
 SEDSN
X-Gm-Gg: ASbGncvTCcoiwOWwf1ZXHBqM+G67GCcQ8Ih5w1Y8AzuIRS7OjS0Kn1JXUJVGf0VNqN5
 H+/iHgf0HcdtTwDeDvx6ngmGzoMsZriv7MAV/Whc8870fCvhTxxo4Sx5AQ6Qo0/aflu1bqp75EA
 WlWAn4sCi0laz/SpJIm0Rzf+mPFED7W7He6b6J+4oNt+QPdp7UyTfdl2e7ZyVOVpxliYPFW1+sb
 +ihJ92aUr3UnVMsVoeEJJOQeP0hl8sHZEAkVKVHwkColhTqgnx5Zrwjd7HLeoIMeGzSJojD1iJO
 avBKwI4ggiJj+WSgILLvaIs5JVbecvOHqNXMLvsN+n+OKkpoi9GWXRPA3ufXf6N+ItBl2H2lYsR
 WVeBUKA1ytCr8kdfO0+fR8tH9r+MV
X-Google-Smtp-Source: AGHT+IE97OdWrtbLZRA/XEzAxWTsnqQQ6MUjB6CLBwRp7J8YSJp4tODg0Un6PYYLXE730GH82M3QDw==
X-Received: by 2002:a5d:5f8d:0:b0:3a4:f644:95f0 with SMTP id
 ffacd0b85a97d-3b77679a449mr1415909f8f.54.1753443730579; 
 Fri, 25 Jul 2025 04:42:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45870568fb1sm51230105e9.27.2025.07.25.04.42.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 04:42:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 8/8] target/arm: hvf: stubbing reads to LORC_EL1
Date: Fri, 25 Jul 2025 12:41:58 +0100
Message-ID: <20250725114158.3703254-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725114158.3703254-1-peter.maydell@linaro.org>
References: <20250725114158.3703254-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Linux zeroes LORC_EL1 on boot at EL2, without further interaction with FEAT_LOR afterwards.

Stub out LORC_EL1 accesses as FEAT_LOR is a mandatory extension on Armv8.1+.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index bd6b5d11de8..47b0cd3a351 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -186,6 +186,7 @@ void hvf_arm_init_debug(void)
 #define SYSREG_OSLAR_EL1      SYSREG(2, 0, 1, 0, 4)
 #define SYSREG_OSLSR_EL1      SYSREG(2, 0, 1, 1, 4)
 #define SYSREG_OSDLR_EL1      SYSREG(2, 0, 1, 3, 4)
+#define SYSREG_LORC_EL1       SYSREG(3, 0, 10, 4, 3)
 #define SYSREG_CNTPCT_EL0     SYSREG(3, 3, 14, 0, 1)
 #define SYSREG_CNTP_CTL_EL0   SYSREG(3, 3, 14, 2, 1)
 #define SYSREG_PMCR_EL0       SYSREG(3, 3, 9, 12, 0)
@@ -1657,6 +1658,9 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
         return 0;
+    case SYSREG_LORC_EL1:
+        /* Dummy register */
+        return 0;
     case SYSREG_ICC_AP0R0_EL1:
     case SYSREG_ICC_AP0R1_EL1:
     case SYSREG_ICC_AP0R2_EL1:
-- 
2.43.0


