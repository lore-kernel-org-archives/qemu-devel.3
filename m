Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F1DE7719F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6Ki-000566-LZ; Sun, 12 Jan 2025 17:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Kf-00052A-Bc
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:21:21 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Ka-0006uK-JU
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:21:21 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so2617724f8f.2
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720475; x=1737325275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jtVBq+1S8gj7ukLJ3NiNvNBhPg5TIcwGGRynG81nGiQ=;
 b=ST8f3yKrmJx6qiX+G9ZfLhVk0SBloDUqGo2OQRv5KjDQDeauEMdHzSwfAbT/hAfrJN
 YmUzbvxLG2ETgUzSv89LseTHN6PYCMYphgVI/mHO4TusHUzKEMzqYfyHm5f74DvRPXxE
 +cdbCE5JhV42qJRFYLW+JnKlTN0J45nCVcAUouCiVpn++DERVc8oxfCmCO4B+3TDcL1Q
 Ty6KNLjBQLcz+xjD7Cy9Ofz1eLnRukWfxmsxcUSD5D868//OOIXifoavg/OBEFMoypF9
 VeWTItwgSfXF+8wkARYWI6OfkALVKKWZ12cTj462wFbELm+1yrtGx3T2uUPOLVGinjcc
 PmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720475; x=1737325275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jtVBq+1S8gj7ukLJ3NiNvNBhPg5TIcwGGRynG81nGiQ=;
 b=gargckGJWv74FV2LVYh4fUSoIW/8vseWp6L3owUhk95TmphjRJ+l5s5lIJtiH2IXYb
 KterMVlMp9DRxGK+BJjGBcwCy5C8nD/x3R/5o+BdLSHHNAiUYtcks0Kkt9cH4ubq1fwW
 lUsTr9/Y98wIfRvyZgQxHL5wQrlphKxPI0RNguSiHaNqSYyentjXdDQD1jyEpEMFvhD8
 mpJkhAw/hVC2Prw3UmzY2BSI/YNpPTsXV/vilAqzLF9etgMn14Htk7teM6s+xI3Z5bJJ
 YxAwC9E/QrIYFXJ/kU3/hivcyM0G9IvK0G1xdKRsdKPz8zK7WvXiBQ52XsPL1zDvAKzn
 5uPg==
X-Gm-Message-State: AOJu0Yx1zFbR2NBZcYFj2e0MvcH64HW3CZ1MxoiYWtAbXSoxrthXfpYf
 w9UfPRuoCOcQ6XlGABl+gOnOWmNpI4kftyDQ61iwDGbTXP2lEYORKgaLkmhlRAp952ViIPOgbFG
 99+E=
X-Gm-Gg: ASbGncteGMSQaCk2Nh5F6zE45hFl9uI8G2gBtB9lDfGEQ/YCfOUTZnfQejulJ4PJ8OR
 RzlY6CkJ/w3M50XFUvbCYnBgv3sHkMGfaEIBOID6B4a02jPPst9uvjkp/E5PyqhMk4ZeCxFG+3F
 Zu103FjIyxuPwRpdOdy7/dsHwoPubve5S5G6pdBlQzAwHGX+rRzGjWKXg2N1UjKckUcwdDFul4v
 6ndgAD+hN/iGlnhnGVVqTvkLzV5aL8lxOQfnw0SriHTHls190oElhlRfqbMenfcwTZLi3oamoyl
 KVY1ZOXvEL2wdY7/kwdR5L4UEY8Bkes=
X-Google-Smtp-Source: AGHT+IEXnVubudZ3uKgDJyifmL0f3xkBlCOy9PQJMwMJs/it0oS9ZWXcdYatNuM9gIs9YMqgMuNvbA==
X-Received: by 2002:a05:6000:4714:b0:385:fc70:7eb with SMTP id
 ffacd0b85a97d-38a872fc1bfmr13807502f8f.12.1736720474942; 
 Sun, 12 Jan 2025 14:21:14 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38ef6asm10834186f8f.60.2025.01.12.14.21.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:21:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>
Subject: [PULL 46/49] MAINTAINERS: remove myself from sbsa-ref
Date: Sun, 12 Jan 2025 23:17:22 +0100
Message-ID: <20250112221726.30206-47-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

I am ending my time with Linaro and do not have plans to continue
working on SBSA Reference Platform anymore.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
Message-ID: <20241218123055.11220-1-marcin.juszkiewicz@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 770bbf9f233..4ca3981dd25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -923,7 +923,6 @@ SBSA-REF
 M: Radoslaw Biernacki <rad@semihalf.com>
 M: Peter Maydell <peter.maydell@linaro.org>
 R: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
-R: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/sbsa-ref.c
-- 
2.47.1


