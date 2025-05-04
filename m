Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B004EC369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 21:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBhLY-0007dD-35; Sun, 04 May 2025 17:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uBhLW-0007Zr-88
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:58:02 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uBhLU-0005DM-OG
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:58:01 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-223fd89d036so41730515ad.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 14:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746395879; x=1747000679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qsgJuJeIe1Kv1++9ujzrFlsebKeMRf8m5C9gM5J4SiI=;
 b=ple+dYG74uF6DbsErlcDqWGcR1v8RP43bJbYnwU914colck+Sb7NgwH32RVGuc4N9O
 gUYSjExHeI/hmDeGAyrPVimmJsplSBrujyqbDCdflGnSCDtMt5FX8mJCDDjmyqjfhQWq
 z5DwOtPgnuFqWtr+fe+r+Ok/V3pyLbTIGf8VieFUYIuJLDQ/3kXSwz4Tq9tstaOgTUzK
 WyoXCeWNBUsfcdrlQiBi2jFk0wSBUu7JkZ+JB+/SB5RqjOGR3eDjy16LydACW5YYTg08
 vEuEIed5JlXWdx6wXhRmWrw0ouhUW6LlXkXd9VRfbVpn809wYY7hsqzelO8j47XxquGB
 uWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746395879; x=1747000679;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qsgJuJeIe1Kv1++9ujzrFlsebKeMRf8m5C9gM5J4SiI=;
 b=Qpsmx0wNOIBmaaHhqotP9Yykqdz7GwinW9AGfIwcCJmgO4Bq44J5YmuijOYCm5SQw9
 xCTy6Dg62OsMJY7b41FklvUP6wzjc0NJ4zUqgtyxZpewecDVI/Lb25jUOtGzmX/kSDLP
 5xLRYCiipnUsmv7ZvUtnb25oCk1aFKTaOd+bEKdGh1wiJm9D8H2xAkXYFRJD3kA59IoK
 Z/ZbuwpaVmlFDkOHsGmN7WUEsa8sCYkspKTIPP6V+1pWKKziB7Wcq9KBvsjKHa4wvB3f
 yJoMbExZEz0DZ08VfYORRuifoYL96AVHw0JwqCDGRCt4YMS0FBIRHGExCKo7+e3zCS4y
 wBSw==
X-Gm-Message-State: AOJu0YzaZYA34OTZPovbJO13+bdC0Te8sY5B9grx/grdfXhRTJoh6MqK
 G36nL/ptyi+slJWwGgx5ZPgPIvlWFC8suHO10QYOWvHzWOYm76hjavTkWe8oFeud0LvK+FvM7t+
 r240=
X-Gm-Gg: ASbGncteu31W/3tcbNc3AXWgW+RKN+iHGBEUOrdMeyDTHXDL8ZHqgmDHfD9q3VSDiHx
 qk+T1lEtdkSkgrMXKvtqlrqf3ydI8jNS+689+eQk9F6TXZYywdETGSU5gEeLk1vKeIP5iq5YpIi
 PygWRFJm55Wr0zSNO88IxN9rQOr7I+n+s/mWnYNOfXjaMxjUw7sjVL4bFq6v1+W+BtuPjhguZX2
 h2o/7ikg/pPac2Cg1G2YGVu9LfPpMzpvdEpk5V5btI3XHQLZVxFutRhd5iW8VAFPdYs4b+QrQ3L
 btujmDTg2aeoO1zttEwmysREz+l+9A3p4bjtLf6rY9rJB/mn
X-Google-Smtp-Source: AGHT+IGZef+QXCdY3KweeEVKuIgzrjIfQkNCJ+TFcEAn+yTaqv1u2PdJdM8I87U5AKf9hw956BNn4g==
X-Received: by 2002:a17:903:13d0:b0:224:a74:28c2 with SMTP id
 d9443c01a7336-22e1e8f9aefmr71941085ad.29.1746395879352; 
 Sun, 04 May 2025 14:57:59 -0700 (PDT)
Received: from gromero0.. ([200.150.181.215]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e152204fesm41664875ad.137.2025.05.04.14.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 14:57:58 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 gustavo.romero@linaro.org
Subject: [PATCH] hw/i386/acpi-build: Update document reference
Date: Sun,  4 May 2025 21:56:37 +0000
Message-Id: <20250504215639.54860-9-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x632.google.com
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

Update the reference for QEMU's ACPI PCI hotplug device interface. Also,
use the possessive form in the comment.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 hw/i386/acpi-build.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
index 0dce155c8c..275ec058a1 100644
--- a/hw/i386/acpi-build.h
+++ b/hw/i386/acpi-build.h
@@ -5,7 +5,7 @@
 
 extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
 
-/* PCI Hot-plug registers bases. See docs/spec/acpi_pci_hotplug.txt */
+/* PCI Hot-plug registers' base. See docs/specs/acpi_pci_hotplug.rst */
 #define ACPI_PCIHP_SEJ_BASE 0x8
 #define ACPI_PCIHP_BNMR_BASE 0x10
 
-- 
2.34.1


