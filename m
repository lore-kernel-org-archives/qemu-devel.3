Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F86E7DEEE
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 15:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmvyW-0008Sn-QB; Mon, 02 Feb 2026 10:36:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmvyS-0008S7-Cc
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 10:36:24 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmvyQ-0005Dw-6Y
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 10:36:24 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4806b43beb6so33929695e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 07:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770046580; x=1770651380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=j4/kwZ73A7vkmvhFZ8O1A7HoNiOiQZYmNOg6/BjiXVo=;
 b=ck/czsTFsrM/j1DNB5rak559ZJPrB0Nx46Pu7KyO4B4zeFMVT5xWkiUHE2BzyYRouo
 FkJYAs88Onjnj5vrBkn9sKIBxixrfvI62p/7czelQR49qaADB6VqjpcxCaXaTncKhg/J
 tj0CUKghHfCf1vxfD+5b9ZcIbD30dkfS9zEYf/HSyW5Rh07UucTI6yrof51vOVDCcFQa
 1vbAS7QgblD5j3HmnaSTd7Kvs+xgDodaOzg7FKAaY1jD0fvIdZQCzxCVmg2u8JBYoLCb
 GZIoUD6HNrsWy0ZgBsBOO1td3n6BmFtCecn1GGvwZBQexybTe7GPE49G9HyqzlrhAJ6/
 sVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770046580; x=1770651380;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j4/kwZ73A7vkmvhFZ8O1A7HoNiOiQZYmNOg6/BjiXVo=;
 b=J5aF4Qo/EGxfhskf1JAnQ3NuZwhwqPrjqoKk9xFWUhB1j9DK6sqxO3lHo1ogeiO7ar
 HiIIfCCz89k5lrynQbAlyEXI9Zwsow9KeptjNvApQQvwuP4u9pOh44f9wbagjTA8Eqke
 H7gkd0JApewT0MAqWP4oHUU3pc3JJKWzw3rHFKYBIXaG0NneaRRG0hzhCIvjfRaWVDrU
 1qGaGt1XBBPWy6MV8WIKafVAERi16eeB46A4YRogroWQiW1eDj9N70qVqyOCOW54ZzdK
 9DBgqPmJBdwECexfxLOnDgG2EeDk9UexSYhJxKSpUoWqFVNoWL7p1KSBWsmtkYneX4T0
 tzpQ==
X-Gm-Message-State: AOJu0YyLcpUtyt/qs3z6owCfxxvzA+jboDcmmZ+fkqJRJ2jqU/UMkPa3
 IOaGEJZ4WEF731ZVQ7ZKu6hkDiAGEB+Ffe1ASDEen1KiKY417J7wT/B3agc4PTk/hsXrkT6F/Oz
 JQq2w22s=
X-Gm-Gg: AZuq6aIOYmTp+Vn9x9GlCRNS0v9vR+F2v7GjkT+30rh4hix6An/t+QND5ykKWnjBUeQ
 TcLBgiUH6YHLzsUgtyZtGluC1L8oIbGNqQIzDo09SF/VHZw8Hxp55JmDOgCDTjYz945MhKfSldX
 9iilAV0nscYJm45ujR9fXc2mtQVceLDiKMsT+vwyK6MPRueL6X3toXbds4QrE0DcpA4uuVOVnZ+
 /JQrJX6KuxagDRhL0Fk7/CWlrKV3jG8n/4RR0S1SVLryPSihagXEx+lBFHlF45Q926B5YPm2EVc
 6r1Y8OyxjEmngLTs01O1KnPuaXiF8ax0zGmHZslCirSejqwtaU7PAVhQi2f4TBMWHtxplGQ2aQJ
 GqfSrw8rhdJeTEou/M40Gysb7lU8pfR7GJyTaygwKWMXZ72VsbQnYKjgJWJsSAUO4zD0WZWT3th
 Cl4OpOJT8rIP0DdgK5mF0mCBEFWM9GGjLcnuH2jXryiH/x6E/a6N3/8akxH6PxRGGd7f+aLw4=
X-Received: by 2002:a05:600c:1f14:b0:471:14f5:126f with SMTP id
 5b1f17b1804b1-482db4ac1d8mr150386725e9.33.1770046580156; 
 Mon, 02 Feb 2026 07:36:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066be77b5sm444483915e9.2.2026.02.02.07.36.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 07:36:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/2] target/arm: Deprecate '-cpu any'
Date: Mon,  2 Feb 2026 16:36:16 +0100
Message-ID: <20260202153618.78675-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Arm '-cpu any' is aliased to '-cpu max' since more than
5 years. Deprecate the former in preparation of removal.

v2: s/any/max/ in target/arm/cpu.c comment

Philippe Mathieu-Daudé (2):
  target/arm: Remove dead code
  target/arm: Deprecate '-cpu any' (remplaced by '-cpu max')

 docs/about/deprecated.rst | 8 ++++++++
 target/arm/cpu.h          | 2 +-
 target/arm/cpu.c          | 1 +
 target/arm/tcg/cpu32.c    | 3 ---
 4 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.52.0


