Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5838CC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 10:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raZK1-0001qb-DZ; Thu, 15 Feb 2024 05:50:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raZJy-0001q9-NN
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 05:50:26 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raZJu-0007Sg-S3
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 05:50:25 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a3c2efff32aso82370266b.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 02:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707994221; x=1708599021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BAH3pRl8NdjwsLsFeBrWu9AhqGGOoFB4lYhbe8BInAI=;
 b=YLCjYjUKlJkqwvVM0nI7yOpBSci0AIlA9tyZRpk9b3zEg09hnWva5lsWGzcOyP6S75
 wMFj9ZRsL844YzvHEPOXR0k3pgZ4SKCfFr1JAotG9rPHpKmVXk4d6XUsbsPhTnjF7TG7
 I7mxFfUYYCkQFXSZ6HqjsbTuuRVeyeSqzhIQExwTfyXQ0f3TWwJroQ1zaHX9x78P/Y1o
 GRLshUXkDak6Lo/gb/TFfVWuOEEzTUSFVUpSmgigkXiPqGjEeygDTj6d7mTwey7w/TPJ
 lSRH+YbI2Q1pqhn6swdRW0aOOltTZz22MQxOFupS2mX+qq+KmXq5I9Vnbh77t3U4TNWq
 nR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707994221; x=1708599021;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BAH3pRl8NdjwsLsFeBrWu9AhqGGOoFB4lYhbe8BInAI=;
 b=uJsKewwiwwx4pQMtK2GmzC7syD78pf/vVvgtivSOSbM6pZOo3p0D70Xw27nP5R06S6
 Gh1lrxBtTB81fYD4iF5pLAZ+TlODwjX43EThoOTH06xvUuCSCJtOKZloT+6HgcEuQUJ4
 O0+h9/aXuHNbZti8qWQEIi1SvYq4oRuf5L9dM/mgT6srgd1TW8pSFnGIdR1JJd/fXuEO
 8paUnBUql2Q6fFoyIKdu7NDzdc9NUhu7w4DHU2MmTcRA4OCfDXBeQ7cDZULTsPfMcZwo
 15LDN4gCqoEWUKkV09ISLdEzuGU2IFrHdQwXSubTc62aK3SMVkB7Px6yXJsWw9maMZ7m
 EJZQ==
X-Gm-Message-State: AOJu0Yy3QOq3zOrykZia6AZY3exEvoJ7Z7XNiqWe1EVcvu88Qcqgr7QG
 tFJrrgKL1sBVlALDo1hbKXdkod5HZeXQbvJUbk7qC5BYR+hsIMQ+ZclDyCJrEvtezOGfPSMiHJt
 HdD8=
X-Google-Smtp-Source: AGHT+IGo3mVC5AUGj9OMwwe/0k7vY9hdYLeBd+4cRFceRHR5xGSjSgTdirVgsZFrbE+Rz65eiYla9g==
X-Received: by 2002:a17:906:2a97:b0:a3d:83e2:bc9 with SMTP id
 l23-20020a1709062a9700b00a3d83e20bc9mr1146673eje.50.1707994220715; 
 Thu, 15 Feb 2024 02:50:20 -0800 (PST)
Received: from localhost.localdomain ([92.88.170.215])
 by smtp.gmail.com with ESMTPSA id
 fj10-20020a1709069c8a00b00a3d7cf59a55sm421280ejc.149.2024.02.15.02.50.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 02:50:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/4] hw/pci-host: Build ppc4xx_pci.c/ppc440_pcix.c once
Date: Thu, 15 Feb 2024 11:50:12 +0100
Message-ID: <20240215105017.57748-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

v3:
- PPC440_PCI -> PPC440_PCIX (Zoltan)
- MIT -> GPLv2 (Zoltan)

v2:
- Squashed 2 patches (Zoltan)

v1:
- Move ppc4xx_pci.c/ppc440_pcix.c from hw/ppc/ to hw/pci-host/
- Build them once for all targets

If it is convenient for PPC maintainers I can queue
this via my misc-hw tree.

Thanks,

Phil.

Philippe Mathieu-Daudé (4):
  hw/ppc/ppc4xx_pci: Remove unused "hw/ppc/ppc.h" header
  hw/ppc/ppc4xx_pci: Extract PCI host definitions to
    hw/pci-host/ppc4xx.h
  hw/ppc/ppc4xx_pci: Move ppc4xx_pci.c to hw/pci-host/
  hw/ppc/ppc440_pcix: Move ppc440_pcix.c to hw/pci-host/

 MAINTAINERS                        |  4 +++-
 include/hw/pci-host/ppc4xx.h       | 17 +++++++++++++++++
 include/hw/ppc/ppc4xx.h            |  5 -----
 hw/{ppc => pci-host}/ppc440_pcix.c |  3 +--
 hw/{ppc => pci-host}/ppc4xx_pci.c  |  3 +--
 hw/pci-host/ppce500.c              |  2 +-
 hw/ppc/ppc440_bamboo.c             |  1 +
 hw/ppc/ppc440_uc.c                 |  1 +
 hw/ppc/sam460ex.c                  |  1 +
 hw/pci-host/Kconfig                |  8 ++++++++
 hw/pci-host/meson.build            |  2 ++
 hw/pci-host/trace-events           | 12 ++++++++++++
 hw/ppc/Kconfig                     |  3 ++-
 hw/ppc/meson.build                 |  3 +--
 hw/ppc/trace-events                | 12 ------------
 15 files changed, 51 insertions(+), 26 deletions(-)
 create mode 100644 include/hw/pci-host/ppc4xx.h
 rename hw/{ppc => pci-host}/ppc440_pcix.c (99%)
 rename hw/{ppc => pci-host}/ppc4xx_pci.c (99%)

-- 
2.41.0


