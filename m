Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA44EFDEE52
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 21:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG1bp-0007zK-Do; Thu, 23 Apr 2026 17:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wG1bn-0007yq-Es
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:29:15 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wG1bl-0004jQ-Qe
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:29:15 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488ba840146so64396245e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 14:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776979752; x=1777584552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lvzdIkgGOuGYWeFX0xgPzydOA02nxpawlufVurJ26Do=;
 b=lLVKeNAt5VqerSZoBqfO1VK28dI1JYR9+huizxP/AW1c0KLZLV8qcfh+y5uXdSPoQ6
 i8qYpesg7hXHMW9CCO1qt5CistGvDP4pGepuiEzNKtdmJ+frDEVKD6qpjjXtE3y/st4T
 XOTeiGxVFAuKR6dqYsrIVxdPeKAWFHa7GJGIKO1Xtv/5EjnEiURD1gJ4GUxVFKYKemcX
 pvg9wpFsZ9ti0TaBFDrtiIsyvUI6wDH6L1f2b2NQvWucVicJQlBQhf8g0x0bURE8FtFP
 cwH+dK1rfFutr+/OFPx/eLRyvrVvmVDkcIITM7JD+FAU9lkH53qrDU6FAdAZtryJSue/
 h61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776979752; x=1777584552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lvzdIkgGOuGYWeFX0xgPzydOA02nxpawlufVurJ26Do=;
 b=Tv/V5lBeNN0aSkX+5/5kqlcqlNRp0Vbjdxv5ZakRTGzaHpzh+GAFkBku9tf97zsou/
 i/dOmfVNWXkQFyzlXiqBIwpUZCDNutR4Ja0QhJnlTt+VIIt+zZsBg4Kg+wzdt0SdBsGy
 BJUoyDd7LjryD+XplQjQIZe8ZiNnnSqLA26jlGBT1Re3DQO2SRvR51XMY7Czmj7b8rO9
 VP+DXg6x7PSZqczFaI1XBQOrtnN2D8bOmor8GMknro1y4jsYkg1Rkxp0Onfl1tMU09zE
 vexSXacLxOH66aSDHempxnBRhPnoSds1eOFgi9Ae2gsl0Y3Zm1x2UGpwSGDHaLBmNFke
 B//w==
X-Gm-Message-State: AOJu0YyAMacZWI1xpj7Z5o5tkAAKuf5NYWtKi0hPzqCdSTrY9GGeYkiR
 kBbLB05XzuSxzzKs3JW0ODb7eGKO31tYFyqWxOmCUH0V737Q7YbJ7cmPV1209/08P0g7uX+rdzq
 nf7ekCvE=
X-Gm-Gg: AeBDieuPrNHWEcNLwgMM2EvqJNNNluVaF7N7400jo4vuyL5cUMD9+y2qXNEfIdwa/3t
 PWcNGsfRMqnnmN7a2aLHfk3VZM7Hy3MFox6dH9fos+fB/6Ix3saApDpLxZTavRFDAtAbyOLgU+s
 UwUkUJJaTbaKtrSlSuWLobgx1/IhiyZ2Ss68lMJaYqg7tL5/A35Ig1P4ECTWWnl3fyAlFCQOPsx
 YsXp78mEPT7RkLz//DmhMeryMV/vwiMdnlkEUxxoEFACuNom374c7ZL0Lra4JnIQoMZW4TfTjYb
 GYbwWOxywsYJ+MU+KxsoIkzMOzDXAaa9ZPyxGmetdyUEP2rufsKZDzUtlG76ED3W5YIfKNl1vEM
 +qn0f7OZJ7l7JTK0R0/NCdDE2mxz8NJeUCLIJ2nz2yEB4pZ71fpsFwJXMTBBVBbR/RoIhY7yXsx
 ISuHlrCYU6Q2hGm+6PW+Xb+LzTlOAkmwiuWUOd76avfAFUVSFQgWzQi1TJYNc2WoP6kGj0KcrlT
 1PwRQfVVJU=
X-Received: by 2002:a05:600c:1da1:b0:488:79a3:f04c with SMTP id
 5b1f17b1804b1-488fb7863femr434367125e9.27.1776979751838; 
 Thu, 23 Apr 2026 14:29:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f8188sm572963755e9.2.2026.04.23.14.29.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 14:29:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 47/52] MAINTAINERS: Cover hexloader tests under the Generic
 Loader section
Date: Thu, 23 Apr 2026 23:28:55 +0200
Message-ID: <20260423212856.68734-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423212856.68734-1-philmd@linaro.org>
References: <20260423212856.68734-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Drop the orphan 'Intel Hexadecimal Object File Loader' section
but keep the tests covered under the Generic Loader section, since
both loader.c and generic-loader.c calls load_targphys_hex_as().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20260422080406.62638-7-philmd@linaro.org>
---
 MAINTAINERS | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d639114467..a0a8e9ab143 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2697,6 +2697,8 @@ F: hw/core/generic-loader.c
 F: hw/core/uboot_image.h
 F: include/hw/core/generic-loader.h
 F: docs/system/generic-loader.rst
+F: tests/qtest/hexloader-test.c
+F: tests/data/hex-loader/test.hex
 
 Guest Loader
 M: Alex Bennée <alex.bennee@linaro.org>
@@ -2705,11 +2707,6 @@ F: hw/core/guest-loader.c
 F: docs/system/guest-loader.rst
 F: tests/functional/aarch64/test_xen.py
 
-Intel Hexadecimal Object File Loader
-S: Orphan
-F: tests/qtest/hexloader-test.c
-F: tests/data/hex-loader/test.hex
-
 CHRP NVRAM
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
 S: Maintained
-- 
2.53.0


