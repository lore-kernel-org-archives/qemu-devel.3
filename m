Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B81C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 09:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1te9bF-0000yM-Dv; Sat, 01 Feb 2025 04:15:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1te9bD-0000xV-5w
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 04:15:35 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1te9bB-0000ON-IY
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 04:15:34 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385dece873cso1344217f8f.0
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 01:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738401331; x=1739006131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cjXEXOEGqtOWDtj3L7AVJPhqlVI94sPYXtErkeIQ+4c=;
 b=C4eXXw3Sb12Yp3qr5x7lgF5UNWUK6oBZIoIYwCKjkivin08jq1U5MVMCVkdB8kg1LG
 zpQEGWwm3tR7m2IYOnMJsoOD1jnmB/60rBTqDzHgT6DMH9+qvjHlFpO+ZT2mfddN92mD
 Dd9U0RZB0rTTCJTYgJvMHB4yqqEtb9kM86k0+4jwlFX/OCS5kRFCOvCt8u006gHXReyd
 w6Md6aV0eckRjYFVEZvBwTd9mQj/CHqC/mY1k0xQd/xbEcBEM6dJVNghFMZIEOQtABzB
 PqCQJeVnZ7iom7y8MrxEEALz7qK2XTLF5fayuMPKn1BUJ4RnElxXS9lttmZ6Nyk/BrJk
 galg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738401331; x=1739006131;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cjXEXOEGqtOWDtj3L7AVJPhqlVI94sPYXtErkeIQ+4c=;
 b=i1lyYYgSkCyCftnnSS81XxtN0zZI8bDZrQpr2EDylnx/B1T8++fyiNyOn1bjYIObdp
 hFslZqC9lOKddZ+zJF1gC/MmMXRHpWhFXbhhNY0V+rcKQKc82jgNudO3DYZQ/X4dxHxg
 OSBWgenlzx3aZvFggeb/Xiemdtqw9GC1PiVaoHOwt376ED8McbLHbFL0I5Flc0vI5utd
 Pu4Uqactc8RyjlflJOJz5FfIfKy3N5AdCCI2YrVkmObrmP0LiHHQDLP7h1+SSjXnEJqN
 1w9y7vGkfkpIEGVPt/DfpaIX4Tx3VYM3vz5anxMwYfTavsAwKDsCFl6cWIfIQLChAoEW
 ftIg==
X-Gm-Message-State: AOJu0Yy5uDC3JEuvx8TzCcI5h7ywlXa5wk4IJmUa5OeTo1r+0Q2LBgLi
 IRH+Krf7ppn6B5E1XHIZINZ8tmRgO3RpoQ4eqHvfUnzdca25QvPO8SZrRrKh2RK05GdGCT5RPpB
 0kJg=
X-Gm-Gg: ASbGnctnTRsnqdmQnXtuKwOhMFYi022FQFvuiZfj7yt08Vn0Rjwa+8gnU8f7w3WjSFd
 d5HKNh2qF3y3BBQU3eCVkYY6eZPxdCFTDGjJ+X0FaGvUpUOtWJmBZwbRBA0SN7x7hZNL6zo67WI
 C7D9MvrywrxGE20uXZSNPzDJea+CDNkYgo3+T4qFDPd4IdR0Zm/6/+gaqQxgymgvHbEXj64H/0v
 klq7tZnRcoZ4df+97Rq8EkCiMTfoYIEwxlW7t5ON8awuCFMX5DYF4BjKTVcWc7E1ve5tWj7UeeR
 AfZXt4ETdLxWEnCsg7PhYpKObsTgS58ffqVgQmo83wzHe4QetSsJBwMJ+NURPa3ajw==
X-Google-Smtp-Source: AGHT+IEU4u8rswIYr2HVoQ/jHBmnxyoZLH0TQG46LtAnQYxY/AsHvSSeWwAH14hKfVNS52KciRwMuA==
X-Received: by 2002:a5d:47a6:0:b0:385:f892:c8fe with SMTP id
 ffacd0b85a97d-38c5195b4b5mr15152889f8f.21.1738401331589; 
 Sat, 01 Feb 2025 01:15:31 -0800 (PST)
Received: from localhost.localdomain (232.170.88.92.rev.sfr.net.
 [92.88.170.232]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1b5122sm6800804f8f.76.2025.02.01.01.15.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 01 Feb 2025 01:15:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jared Mauch <jared+home@puck.nether.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/7] hw/arm/raspi4b: Add models with 4GB and 8GB of DRAM
Date: Sat,  1 Feb 2025 10:15:21 +0100
Message-ID: <20250201091528.1177-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

- Deprecate the 'raspi4b' machine name, renaming it as
  'raspi4b-1g' on 32-bit hosts, 'raspi4b-2g' otherwise.
- Add the 'raspi4b-4g' and 'raspi4b-8g' machines, with
  respectively 4GB and 8GB of DRAM.

Philippe Mathieu-Daudé (7):
  hw/arm/raspi4b: Declare machine types using DEFINE_TYPES() macro
  hw/arm/raspi4b: Introduce abstract raspi4-base machine type
  hw/arm/raspi4b: Split raspi4b_machine_class_init() in two (1g and 2g)
  hw/arm/raspi4b: Rename as raspi4b-1g / raspi4b-2g, deprecating old
    name
  hw/arm/raspi4b: Expose the raspi4b-1g machine on 64-bit hosts
  hw/arm/raspi4b: Add the raspi4b-4g machine
  hw/arm/raspi4b: Add the raspi4b-8g machine

 docs/about/deprecated.rst |  6 +++
 hw/arm/raspi4b.c          | 91 +++++++++++++++++++++++++++++++--------
 2 files changed, 79 insertions(+), 18 deletions(-)

-- 
2.47.1


