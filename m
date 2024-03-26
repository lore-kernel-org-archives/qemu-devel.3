Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6CCC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 15:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp90C-0004Pj-AW; Tue, 26 Mar 2024 11:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp8zx-0003zm-07
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:46:01 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp8zt-0001Ea-72
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:45:59 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d6ee81bcd4so6777701fa.2
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 08:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711467954; x=1712072754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pILgX4qmWPDEo+FllF7pXDQL2dWnRzBzAqVL780ebL0=;
 b=qd4XxyWrCrUcGvRO7kuuWoY6Wi6laaGq6BfdtucybR0jNF6v6sjhh7ZlqxhjeOW7H+
 YgmnW9WChgHOOopV7wChhrtTTxsHhCejBcFzvkYVMBAcX6ZNMlu7vSMAXMEps1btWy4e
 kfU6fWI74cJ0902WOrAMNaYUz/3B6TU/eDexDKbht7XaECU+o/ygRrHqdWrwN3KJ00PY
 i/cEDQwE6ss3mYFUd3stHUXatea3NuOzB0tRJoHp3i56Fbif/4/Nif4TEISbZfOAWA2U
 sOGfhuZ738k7ptayJT2HxhhkGUfxMJx1acsOayqLT/pajGASdQjL68SO18Z1CYCPT3cq
 8PXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711467954; x=1712072754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pILgX4qmWPDEo+FllF7pXDQL2dWnRzBzAqVL780ebL0=;
 b=Ezfdcb1PljyqIW/0rAvFTc9fIxeecWkByZXjqIz4ZmEebxHV1i1BV3MQlG01G+99Rq
 /D/Vskwul6L62rRphIwX6A00tspcsaoz+Tvgz78HFprByAnK+1QRLrJPPRE/WDCUIg2z
 1kBASWLjcejNWPeLnR/MK9gR3n6Ap4Yuyu6ztXptinTfBFNy4HzVzX1W7OYuXtgQx+DC
 7/OVKVRJGWSduTqhd1nKaDksGLO9b0yKPaHMCDghhtoz//d3BKAb5ZyAu373J/V88Yzn
 dGrbIevHredU5yDa9UrNCH2I/knHA9NuOl4sTfbmrpGfpGq/i06dE9mWhdwvUmJPvMIH
 +7Iw==
X-Gm-Message-State: AOJu0YwPqVN5fZMyOJrVfar4RUTfm7MOKtjF3Kj2MPQ7kt+6+4kHWS10
 2cgkTwyMLEWr1hNLKrrUY/cZxYt1fAcKuoUmIWJNLgjt5NdKY1pP1pl0lFEqZmkpP7Dwi7gDG0B
 i
X-Google-Smtp-Source: AGHT+IFPSZ+KbdkoTCVxyOu8c8tHBPXiiJjv3g/xhUl6hvPn6M9vNgNFoHQCM/Gc34BJN7BWsUr/1Q==
X-Received: by 2002:a2e:914b:0:b0:2d6:f100:6e6b with SMTP id
 q11-20020a2e914b000000b002d6f1006e6bmr888577ljg.18.1711467953968; 
 Tue, 26 Mar 2024 08:45:53 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 b2-20020a05600003c200b00341ddb65b07sm112154wrg.63.2024.03.26.08.45.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Mar 2024 08:45:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/13] docs/system/ppc/amigang.rst: Fix formatting
Date: Tue, 26 Mar 2024 16:44:59 +0100
Message-ID: <20240326154505.8300-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240326154505.8300-1-philmd@linaro.org>
References: <20240326154505.8300-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Add missing space to fix character formatting where it was missed in
two places.

Fixes: 623d9065b6 (docs/system/ppc: Document running Linux on AmigaNG machines)
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20240324161148.4650D4E601F@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/system/ppc/amigang.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/system/ppc/amigang.rst b/docs/system/ppc/amigang.rst
index ba1a3d80b9..e2c9cb74b7 100644
--- a/docs/system/ppc/amigang.rst
+++ b/docs/system/ppc/amigang.rst
@@ -16,7 +16,7 @@ firmware to support AmigaOS 4.
 Emulated devices
 ----------------
 
- * PowerPC 7457 CPU (can also use``-cpu g3, 750cxe, 750fx`` or ``750gx``)
+ * PowerPC 7457 CPU (can also use ``-cpu g3, 750cxe, 750fx`` or ``750gx``)
  * Articia S north bridge
  * VIA VT82C686B south bridge
  * PCI VGA compatible card (guests may need other card instead)
@@ -73,7 +73,7 @@ https://www.powerdeveloper.org/platforms/pegasos/schematics.
 Emulated devices
 ----------------
 
- * PowerPC 7457 CPU (can also use``-cpu g3`` or ``750cxe``)
+ * PowerPC 7457 CPU (can also use ``-cpu g3`` or ``750cxe``)
  * Marvell MV64361 Discovery II north bridge
  * VIA VT8231 south bridge
  * PCI VGA compatible card (guests may need other card instead)
-- 
2.41.0


