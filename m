Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301AACD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wShHs-0000XO-Qh; Thu, 28 May 2026 16:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShHg-0000RI-LV
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:24:53 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShHe-000506-77
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:24:51 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-45eee266c6cso447978f8f.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779999888; x=1780604688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eSVVNA/NSDXVe8kxIL/IcFnG2S9NfUFmjMTB2ZYAz+E=;
 b=bWr29rZ26UBYJJ4y6khq5/1x2KN7FuzCIel2o5tMuBCwReg5v9/u1qKPf0U0zlXxK7
 RIdu4txbYN9dVSY1h7cNjIiai0HsgTzk8rSd4or406DEhAYvsiJvvP8wIUvngbNekV5+
 1TutmtnfY3koYNPcHZk8jTXTZvVvk55ZoWd1sIlwrvsz4gXNQsLetF65PV8oKOJp5oLH
 hcS0y7U7lvQ+rEQ/s3G0u6F1o6ToJmiiSQa6zN7kOaSaClscBtowbxEb7juDXJdmn+Yc
 78nx8SOF0lQXFkemF3BPibOIjcehUqyO3FG8LxU9Vc4uzWKtwAZkhWKoHz9NZuJ03oNu
 cUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779999888; x=1780604688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eSVVNA/NSDXVe8kxIL/IcFnG2S9NfUFmjMTB2ZYAz+E=;
 b=YQgHjZ+XYVzRnn3eGHuOGn3mLH1ugsWFSgC3AYaL+YA+zSb+KzCahmktH8uTGgIRTE
 c4hdOka+5BJJsX3NYojflM85rTWaUlN9+C4SdWuXyCt+NCcDUpgj2CCphsgGReopyOM2
 nqD2ldte0cHP/e5tCE0+Q0yaPRFMSg/jCra+atQvBhDBNSOP4thfkdlTNelaPpleVikY
 xnwELQ4iTnWx2mPj1MGxCPvwgcvTs/YHzb9lIbtrpGEEZC5LyxYgsvWEXb30XDBKkB+w
 4lJwwUko9qZEV5R/B+q8d/SXkjUYdjsjtCWxgJvQwlf5w1O3R5KdMZOtdm0xv+VChESy
 Rcsg==
X-Gm-Message-State: AOJu0Yz7wnWOF9SrrvGTvoP0yoLdxJMzozc9rXsKtykWEbECTWeqjLPZ
 5K/nPYys9+J1EDRvhGeREncG1O+OMkeNQVRc0xpLJUOLltYFdZ3L7jVexpr0V3hQpSmZcV6GjJJ
 J6RT1tYiwdw==
X-Gm-Gg: Acq92OFergQIV0Mm9YZb5wuM8g/LvSNmBphdYpSPNkpYwNp3cZRvgBJlxNmV52iKR+f
 Dial3n8Wq+nmzp3CzBqllJgIYt8iO7NnGVq4vvlFfNCVOB7NGwTdk0mLg0pJGXqtAWU2LdpYiqb
 rZ3Tya3MODJkESu9sPk1bKEuc7VjGmSvPXIZU9wX74e1MtzeE8mWZLkk079BJnCpbD/sqBmhiy0
 nzlZFNSEKRvM1Ae6VIyrSFVOTRXyi+XSe1jHDMLEjqI8e87ioZiuKUWDGeprlc/r8EMoGBf2i/w
 U4MHQInR5gz+CCiR4IRXt88KcJiP1BhXmOXr4EIGJ1Uwn2R8NaFsivc09kwiuhDTLv5qBbD2Qz4
 9Sxvmrzt+Q+kt4LppHRb3rQtgrC2Nuh2rU49gG4gQXMKMcO/ps+68fyyaW70/YlRGOpQWO86FOj
 jWnmL2KiktMKBP8bOD6IPrlUnKzzVRaHK+nCzEaOEG0WevtIaPWPhjHf6IiUbuPEXlrz9K6yEN3
 ff3
X-Received: by 2002:adf:e503:0:b0:45e:ec27:b4bd with SMTP id
 ffacd0b85a97d-45ef02b9f0fmr999275f8f.15.1779999888463; 
 Thu, 28 May 2026 13:24:48 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ee5a84e92sm6971292f8f.35.2026.05.28.13.24.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 13:24:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/22] hw/vfio: use stub_ss for iommufd-stubs.c
Date: Thu, 28 May 2026 22:22:45 +0200
Message-ID: <20260528202253.49122-16-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528202253.49122-1-philmd@linaro.org>
References: <20260528202253.49122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Solves conflict for vmstate_cpr_vfio_devices.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20260528051642.115721-11-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index fa0ea6ecf0e..c7c31b78f68 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -34,7 +34,7 @@ system_ss.add(when: ['CONFIG_VFIO', 'CONFIG_IOMMUFD'], if_true: files(
   'iommufd.c',
   'cpr-iommufd.c',
 ))
-system_ss.add(when: 'CONFIG_IOMMUFD', if_false: files('iommufd-stubs.c'))
+stub_ss.add(files('iommufd-stubs.c'))
 system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'display.c',
 ))
-- 
2.53.0


