Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4C9C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 15:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzGwZ-0007Ec-U8; Mon, 31 Mar 2025 11:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzGwU-0007BA-6b
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 11:20:51 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzGwQ-0007NQ-CR
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 11:20:49 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so3922304f8f.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 08:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743434443; x=1744039243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8fZQ/jWuVgumxwu0tM3Cq9QmlHQyh2uem8M+GBR9J8Y=;
 b=dtwv2VyhZeCSLplD3Qs4+G+vif0ug49JRPKbhH5yZF1IfEHPC8PzEBFfCCTlrBsmXo
 XLYtOOfLXbTsy0Ft9DD5trDKlcet5PSoU7hokFfuPy4h5m0dSAzCnQM9NM++u7ZAnS5i
 uLuWnX7B83VNw5uhdIYqvmgzUo5G4WP4icJTjPmx0ITIABMZUcpmcUkN/rRl83CUjRy5
 EKXlqSvk8td2b1eSr8vxLH0Gn3X5lDFPw0wkaHRfwj1JEj9Lx5HFia8nbonCV8vTqlzz
 5cNYgxTMj+c5phllKaUF1GyBm9NkOKjWEW8QHURsAqaM4zkOiMCm/zDTbbyzfwaZ/LXe
 zuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743434443; x=1744039243;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8fZQ/jWuVgumxwu0tM3Cq9QmlHQyh2uem8M+GBR9J8Y=;
 b=XgiQQfNbBqYSgJWV6XMZNuRJwJyzlJdjMMXJJzbP9viWR9hU2FwQmd4sFdHGgxlZz4
 tDMYbgDwkAB9cuSjdG+HwYKeCTEPll38wXbQC0uUd+u2aoKBE+eq9mLjfKzWI2arqaSl
 70/iUG+wZEdowC/YsYDtRiMzB947DibtM1W6aMJ+Wtbd7o04YcSZN6raYQ6rz/LkNydC
 LnN5lNQ86t6/yOpA3SKIMXRU8F2gQWmGcvbKcQl+aObR1XaCdCFR9G0VqyTmmHrlq+JZ
 tDkQ1XuWaZhDrzcbM7hM3Fx6uwU2lpAMigNQwbcwqeDPS8jIp5+kei5fVDF2p8Uhlut7
 9Ekw==
X-Gm-Message-State: AOJu0YxykEmPB9llvUpKIeTL+rERc148iqk9GwkOTuNxooiFOFbX/HnU
 gaby/E4iADAF7BFjAfnGBoGtG3aA5m4XHcOnXpDWwH+cwmMYembnVO3JaDiR0Ribq04nPCEUkU0
 y
X-Gm-Gg: ASbGncuy+QqChKpAEZUCKe6tFhc6lYF6mQiRL5jGBe0nAc6TwopEV/iTnNJY3xUUSWw
 buujXTgik2T6/qw9EugSYgIbZ7bo0nO/oEHUbD7rQXBzXharRxRpUVpLhtQv+eXEb58UaEPNgOV
 MBbXpeTJbVJ2qFXFHxhNacZ3jrdGsVb49kZjdOk5bKhlhNeSjsgIWdAke+XkxN2ZR0Logq/xGCN
 pqmqa7kt5tpqz/lLqm3PfaIxsl01HMoIWbscW+Z0QEW7G733R0rAXvG0gm5eC9RMYbNo0lTsPq6
 erMtUIUgohLELULcmXfLAO7T3fpnfWY1WT9zuxSZQc1X/deELXdjUGXH0uS4d/TXWdgs0pF/45L
 hyYaZ7ONJkgU6Y+76Uoc=
X-Google-Smtp-Source: AGHT+IG7avYraxYq0Sb2IDtToM/Wsawr8fDiwA/RJjqxW5rjncAL5sCmFHRQadvyNkFNd8QG1y9dKw==
X-Received: by 2002:a5d:5f48:0:b0:391:47d8:de2d with SMTP id
 ffacd0b85a97d-39c120e3585mr7717333f8f.23.1743434443014; 
 Mon, 31 Mar 2025 08:20:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a4498sm11816188f8f.99.2025.03.31.08.20.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 08:20:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>, Joey <jeundery@gmail.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 0/2] hw/pci-host/designware: Fix ATU_UPPER_TARGET
 register access
Date: Mon, 31 Mar 2025 17:20:39 +0200
Message-ID: <20250331152041.74533-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Trivial fix for issue #2861.

Philippe Mathieu-Daudé (2):
  hw/pci-host/designware: Fix access to ATU_UPPER_TARGET register
  hw/pci-host/designware: Use deposit/extract API

 hw/pci-host/designware.c | 47 ++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

-- 
2.47.1


