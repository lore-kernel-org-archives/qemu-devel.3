Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5A8C0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGbL-0003ja-97; Tue, 21 Jan 2025 10:55:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taGbE-0003f5-Kf
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:55:37 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taGbC-0001vd-41
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:55:32 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso40737035e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 07:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737474928; x=1738079728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UuwNIpKwklYn+V6xxtkFTRVjA4+AvUAZhHjmaGkwoOM=;
 b=gSG/d537p2FVWS0a2pnRitIBmlYv6CwdR2tqIizZMpMv6ZMTjQbT06fv8EZRkb7zKT
 nuAQEHLB6ykllSfhvc3p7yl+WxH7DGvcK5fehxRHZJ6kGh7eibSehpS3dTz1XdUhU9+A
 VjkC5QSZ8ApsycsbdoWOAAVTGF6niTAjDGsXiD1HEDF9QPwDTVl2tGO2dydvkeCsgUMv
 1iuC73JNz1n07TRHPxayKTzyVg/x56bG6yR6zSDXhIgJu3ZU4c1kPlZOIIM/ZPG2ZdYr
 RXnqB5f9k2c1GHV1M/RhWe44KzcvlrHyN8I8q2g2CPmhZ0HQEddUxfIimQL6S9tU0XH1
 8dvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737474928; x=1738079728;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UuwNIpKwklYn+V6xxtkFTRVjA4+AvUAZhHjmaGkwoOM=;
 b=CeSQgWtwpaCTTYtQEz3aHMUH5XH2uOw0JHR2e7fIeDxJxJm5aUBePG4dGeJkmp3NFu
 NbqCieHGAKJq+BMT3w1umde/nAiUJN+fmWIrdl3b+0kfJc5LwcswCyIMAjGkVmw2b2Te
 Tjjpgkxvt1lmRmSY4cqMravfi122ZIOlOmEch2hkr52af1Hv6AslNfsie6Vr79VS/Fuq
 VrELTKZ6bVNkFlXLO2/+hZI8C5HyFdZjMcnzSA+sFaYTfGc1FuDqcv/Obm1hSaqHeEj6
 U+GkmGBFhAZ3M3FEyS9gCrgNfWOXwfeA7XXMwzKiU0YK0iXF60RapWRXi9lTwrFMrHjX
 rKug==
X-Gm-Message-State: AOJu0Ywb8GG6fyvYmcwUtQn0B1iV584yBY44Q4kWFaLn6OasDVsPc75r
 0v8EeXMhLraYRikmhk3UMn42PXQLRVq2RsShCwRbxdMefrCaJYkzl0liL9iTVmxPImsFF9YjYVd
 8JoU=
X-Gm-Gg: ASbGncswPqRe0AkFu06N8sraq10Bf+mZgs/xImjF/n3pefXfGLTjvhu57rya7qTaKaG
 RtwW/IN5x2MfKcxukSG5HS6T0xIZWfc3GVS5dx99QfVXcgj9mztkgtjoiq5NOw7c27NVoWbxKd+
 AxEMYByzrKNCusUEClxsrx78GMSLjvNtghb0rIE1rXkhdjNifTxv0u2Kk5+LEb5Nk73PyYxazcp
 ahHjdp2K+zfNVt9km+r3D/PGyEVGeR4lGw9ODlJe6u4QVdHO3WgF5AJ2VUioZbwK7tETv6G48yz
 JvtSz2ubrFnZt2LbcK645pD37uqyWsZBGoIxMoWoZTcK
X-Google-Smtp-Source: AGHT+IEq5laFeJueoqSWUDLntPADYW71SWwzuNcXBTNFyssQG9QxSzyYrSezjvoz4I3D0ATqbJEIGQ==
X-Received: by 2002:a05:600c:3844:b0:434:ff08:202b with SMTP id
 5b1f17b1804b1-438913dbc09mr169673425e9.12.1737474928057; 
 Tue, 21 Jan 2025 07:55:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4389041f610sm182231005e9.20.2025.01.21.07.55.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 07:55:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/3] hw/ipack: Minor dust removal
Date: Tue, 21 Jan 2025 16:55:23 +0100
Message-ID: <20250121155526.29982-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
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

Clarify what is what in Kconfig,
replace qemu_allocate_irqs() by qemu_init_irq().

Since v2:
- Introduce qemu_init_irqs (Bernhard)

Since v1:
- s/qemu_irq/IRQState/ in IPackDevice state

Philippe Mathieu-Daudé (3):
  hw/irq: Introduce qemu_init_irqs() helper
  hw/ipack: Clarify KConfig symbols
  hw/ipack: Remove legacy qemu_allocate_irqs() use

 include/hw/ipack/ipack.h       |  7 ++-----
 include/hw/irq.h               | 11 +++++++++++
 hw/char/ipoctal232.c           |  4 ++--
 hw/core/irq.c                  |  8 ++++++++
 hw/ipack/ipack.c               |  5 +----
 hw/ipack/tpci200.c             |  6 +++---
 hw/char/Kconfig                |  5 +++++
 hw/char/meson.build            |  2 +-
 hw/ipack/Kconfig               |  4 ++++
 hw/ipack/meson.build           |  3 ++-
 tests/qtest/libqos/meson.build |  4 +++-
 tests/qtest/meson.build        |  4 +++-
 12 files changed, 45 insertions(+), 18 deletions(-)

-- 
2.47.1


