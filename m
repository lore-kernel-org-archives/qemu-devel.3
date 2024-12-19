Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7814E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJJm-0004Qj-LV; Thu, 19 Dec 2024 11:24:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOI2S-0005ro-Sb
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:02:08 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOI2R-0005iI-E5
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:02:08 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso6666755e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 07:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734620525; x=1735225325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1hA4CDTNLNW6yvALiotELs/bBcdhAetXzVLsZ7NjS3Y=;
 b=xrWJGFOUrMhfLT4Z4WbirOhYkkRxrii/ZDqvHrlJN2wip8/8e7ISFqF/GpGGAVNbd1
 8XsrD8dh3BF57NGhPFI2zK2No5XbtVBeFu7zCpTTRna499Q8rMkHXhenfo5Vhfg3hFIh
 6nUpSf6NQGIE6r8Moybc3J1JrKHBGpu8jw6guZSQPoJ+2oEv0RuoqJq38dvbM5JvW0Hl
 tLD4OF9gJf4CqG8BOy74pU4GjgJpY6F3zkCRJzNZ/EH5zqiiBVxhNJ9RkYkxDtHEsVZb
 xVyD+oxy7PGPnnpAPXUXUezHIQ9mFkto2hdga0McKe4mbd4GmA/R6GTAsl59kBXzn7kw
 hdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734620525; x=1735225325;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1hA4CDTNLNW6yvALiotELs/bBcdhAetXzVLsZ7NjS3Y=;
 b=UlsJ+LDI+OmFd8HOHzPkXSx3FDI9r7QzlHPep35Ui4rtogMXlY8V9p8LJ04zuzR4Mg
 YwZyBeibUg2fNwbDgFciQ306qYMVSQ+5c4tOk9MZCuqWvmRIbswSu/6/9IEtKOd/66Jo
 dfvssm93og1XWtCco8r/Qo7ScrjO9PYVzeMR5oU3J8sW0aqKc3yRHT/DrSxex8kfhA86
 dGlH7Eeg0Uqf/QEJKK1MLV1lWTY155cyhpY0dpRpYi8sUgcL6jKbnG5i3hHtbyu3vv/w
 D1SeL6aSX3avrBvJ6e3FknBy7XR7FeeBCln1NFETqL/fDbXwtey/buEhGLQxpRqO1371
 xURg==
X-Gm-Message-State: AOJu0Yyovam8P17FceoTwC7sod8ViHrOhVR7Jy1YNnyn6LeATMFSfjuS
 nOkxRUQCsQRq1kNzaHOT9u02AFrJLO8wg1t2cxdbxPe1cSMFZ02gXTjcSQRGzZD4Z0irTyMw/yu
 6
X-Gm-Gg: ASbGnctDhYtJp8bk3d0mGrq9/QH4EH+KZ3UEQdXC2g5MnUn0/2yXsyDHDozcVSb5liW
 uiKv5+95N0yK2jjD6vATpTRO+mKHxSG/z4QCY/WpvGpimovIODzMQRujky6asnwDf/N5wg5Xt5i
 D61e4nCpPxiBDUCp+Cvx+XpYARcuPDfT2zPNNmFOoAelQm2L2CyW6Uw19JsLIVF3zbIBovq4zbf
 mY9b9W+hEPWBouvn/rCaT62LJNHP/B36P7ZM7OSfRuvlsu2/nsgXCjBOWxdZfH0EeS8ogeeFMQR
 5lqd
X-Google-Smtp-Source: AGHT+IGEE0WNMm0p5sIDKltciWNEVYUoAZpLbQLePVw4WNRlti5Dko9+vPSe4P62zhymbqxcKHrppw==
X-Received: by 2002:a05:600c:154b:b0:434:eb86:aeca with SMTP id
 5b1f17b1804b1-4365535c515mr84658785e9.10.1734620525403; 
 Thu, 19 Dec 2024 07:02:05 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366128a62asm19788135e9.44.2024.12.19.07.02.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Dec 2024 07:02:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] docs: Trivial cleanups
Date: Thu, 19 Dec 2024 16:02:00 +0100
Message-ID: <20241219150203.55212-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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



Philippe Mathieu-Daudé (3):
  docs: Correct '-runas' and '-fsdev/-virtfs proxy' indentation
  docs: Correct release of TCG trace-events removal
  docs: Replace 'since' -> 'removed in' in removed-features.rst

 docs/about/deprecated.rst       |  2 +-
 docs/about/removed-features.rst | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.47.1


