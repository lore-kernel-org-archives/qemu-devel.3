Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85C1C47DDB
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 22:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSPCm-00050t-GR; Tue, 23 Jan 2024 17:25:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSPCl-00050c-3F
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:25:15 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSPCj-0000ef-JM
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:25:14 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a293f2280c7so501913066b.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 14:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706048712; x=1706653512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZeiKOnBoequrPQZzDdyzONO25ItemP7ZTxOfuGihuUY=;
 b=L1xaNiSfzTqDbWdxdTxL3Oa2rGYn3Z7SYQj/xggTI6LJcWq4Wu/ITyBViDU5g327eu
 sw1JS1uD9NAGwfdi9MmnwplghzACK7xkf40GNctsgQBWztCVNkXNrC1QFKKxpowySAEE
 gKqLud2uXXBlSDN0W7WYExMfkZZLKiNU0pp20RiYHr4BMmr6R1KsvbLbjf/4ig2lYKgV
 eYEzJ3tdKI/lE5exH6tWUI8PtjMeDuikqdKPB5jOf0PwgbGp+evNHiCkT1x3T7fVukEl
 j33qKJ99H1eHNtTn/CZQYeOTw1zy9ZlQg0i4t9X0fUdk6rZ7qYV9GZ1zzn0pP3BcfIU4
 RvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706048712; x=1706653512;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZeiKOnBoequrPQZzDdyzONO25ItemP7ZTxOfuGihuUY=;
 b=DfbOb7o19nt1YUtollFef5iPZfZPmubrnYATTBSblXT+6MwvHKrR84o33CziRVsPAr
 Rjp6T5+Y6JRdOxZoszMsY8Rjv21pP/FM7CxM6Pfu8ss2wE+ocT4Kzs6bkQ+APuqc738s
 YQ/QL/lhvt73ZcbMLB1obhKz762dYVHjBdYFo79mWlTx94zCkAS3B4kptkKmVXK+r/k/
 puA0yexbPJIC34LfPlBPoVETI9Okp9ix9QwedZSZtzhgvkSWdPxNl3zu4vMdELBXH3aG
 TkG8ob+SmhZrJ5Fj/KXaBbrm4SDlgw7GjlmwVJ0kgNRH/RT64oz3CpX2EQpSJwPQtMyT
 8Wqg==
X-Gm-Message-State: AOJu0YwQnHcYrp/i38IyLiYWCT0PGY0r/t/pblG8DW8I2LsSLjKsKokd
 tj7YZ5jbgU375/HXJOQ7RgeeF6CkSQTnhgwuW9aRwRHhNH9YMb0LSDdHD2JXYJPNhUJuYGKY4E1
 6
X-Google-Smtp-Source: AGHT+IHzkmOxz2R2AY8HeRWOx10HBqGJU56VW2/CZ2fLSpb7Bs/bLMagGIUbK6K5IJI9gn+72qcvdw==
X-Received: by 2002:a17:906:7f8b:b0:a2f:617b:fa0f with SMTP id
 f11-20020a1709067f8b00b00a2f617bfa0fmr141646ejr.223.1706048711612; 
 Tue, 23 Jan 2024 14:25:11 -0800 (PST)
Received: from m1x-phil.lan ([176.187.194.78])
 by smtp.gmail.com with ESMTPSA id
 j15-20020a1709066dcf00b00a2a6e8f693esm14834307ejt.152.2024.01.23.14.25.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jan 2024 14:25:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Joel Stanley <joel@jms.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Gavin Shan <gshan@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/6] hw/arm/cortex-a: Check for CPU types in
 machine_run_board_init()
Date: Tue, 23 Jan 2024 23:25:02 +0100
Message-ID: <20240123222508.13826-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since v1:
- Add missing QOM parent for CPU cores
- Dropped Aspeed changes (Cédric)

Following Gavin recent CPU type enforcement cleanups,
restrict more single-CPU ARM machines (here Cortex-A SoC).

Based-on: <20240118200643.29037-1-philmd@linaro.org> (arm-next)

Philippe Mathieu-Daudé (6):
  hw/arm/exynos: Add missing QOM parent for CPU cores
  hw/arm/exynos: Check for CPU types in machine_run_board_init()
  hw/arm/highbank: Add missing QOM parent for CPU cores
  hw/arm/highbank: Check for CPU types in machine_run_board_init()
  hw/arm/vexpress: Check for CPU types in machine_run_board_init()
  hw/arm/zynq: Check for CPU types in machine_run_board_init()

 hw/arm/exynos4210.c     |  1 +
 hw/arm/exynos4_boards.c |  8 ++++++++
 hw/arm/highbank.c       | 11 +++++++++++
 hw/arm/vexpress.c       | 10 ++++++++++
 hw/arm/xilinx_zynq.c    |  5 +++++
 5 files changed, 35 insertions(+)

-- 
2.41.0


