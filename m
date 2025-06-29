Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E30AC83028
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Jun 2025 20:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVyxW-0003ev-OP; Sun, 29 Jun 2025 16:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uVyxV-0003eB-Dz; Sun, 29 Jun 2025 16:49:05 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uVyxT-0000Rl-Oh; Sun, 29 Jun 2025 16:49:05 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-60780d74c8cso2658653a12.2; 
 Sun, 29 Jun 2025 13:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751230141; x=1751834941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Vv37XWZJ4hRc87onzyCYSd7bqnPUH/zjri+WbnLb8WQ=;
 b=SmhAuGYR+qvS5GAiD687gw7iPiIXaY+X0Uif5FBfwBJE2Cf54iLeKv9nZpfzliOxlO
 DwfHzqHG/MVPjHxfzYTBubMx4qFvG9+7ZKdbUadqzKuDh0rycmYznDTZPLTyKMfkodX4
 4KYrjFok31vtXAISvydDcTsgry7SMdyM6OVS7ho2dLfKgtd3C5mCxk7ugV7LP+xIxY71
 ZnfMc5rg30z53GjVz6czKakuRZDfYALZhHr6IvtNvr06tcTpKJwno6j6WdJiLTccTPci
 VZJRUtctUfn5NNIW7zZ6ZnlFnPrlo+sCHoXBjJwLntSnB6ywFi20wdI6ccEhoJPCB4Op
 fPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751230141; x=1751834941;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vv37XWZJ4hRc87onzyCYSd7bqnPUH/zjri+WbnLb8WQ=;
 b=IRBqITg+yETQI0CYJA1e4+sut9wbIhR/Sgig8OHt0hPUKJZEk9v4ReGjCkomX2Rt+Q
 ORch5/NxTAnA1kuqAj21iEUf0F1kaiERpPROH/00nzPTa19HLHcuDqDAKcFjYzhHF3LV
 u/Wpk8PDg7Eoim0nacqkWMmoAV+czAwX4Q0Wx2mwaBdIVEkLB4deSoGw4+L/gXMIyN9f
 dEPM3Co1LOhfqKjQiAUgDkuxKk51o8NZXyCFHSkiMRKM95hRDR8+woyzgb8PXXfuGGGM
 8hO/wVNXXBjU/gIJgQDYqClUI00nIV5NAq0LaMfspGUaCPHSfwLC2H5aHtrhc/xHcfXo
 3Ryg==
X-Gm-Message-State: AOJu0Ywab0xQB5jHR2xfQxofFC1xHB+FoTKAYbugOv5SpV1OOQeLYp8V
 BIvJTSA/HdcBtyKWZwpSsGsuJGhmxVyv2MfruJZ35bdDJJUpE/YhJQ0MDSX1PQ==
X-Gm-Gg: ASbGncvJs8hBc2BG1HHm/3wySEFLHRRCVi9eUhP2Z9IUuLzhyOyqXNRReVPCHSTdae9
 5vJIiz2q5Izh1wrhqrlQmc8gvkf3GrZJvhw1kYilta586KQei8Uii/djDWT7r+/fkshHBLWIRXN
 ToktIUeG0AzSsAQJheGuARdP4h+K/tzRSGg86vxW/DzBG6zI/vGYiqGwuuHj7YemAelKHILgdMr
 5nNKDLUGGfagEaj2Hlq4C5rHqwI3HIixa/iOgAB6ewMqe2BjILBeSHZdcNBeo9jN506m22dP1Ew
 yBo0DiygvP1WjFQcIw3OmRgweivlJaqv8iGbv9VTUagstVqI4ldCMsp9eVBusDsoK03HaphEpi+
 LnX28lvaJFmsZRY4pIEKFCcDmTOBiVfAHyUkpReaGTh+9F3x0LM3a+VBwNaFJiKhGRA==
X-Google-Smtp-Source: AGHT+IFk0lFZbw+HLqEHkuRiFlu3GnyEjDDAh7lMLDe/JgRJPrf4TRQzrm/i6Oeq6yQsWRIqQ59jEw==
X-Received: by 2002:a17:906:9f92:b0:ade:484d:1518 with SMTP id
 a640c23a62f3a-ae34fdcaf35mr884945666b.26.1751230140618; 
 Sun, 29 Jun 2025 13:49:00 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-2f97-a200-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2f97:a200:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae353659e06sm535709566b.44.2025.06.29.13.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 13:49:00 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/2] KVM Support for imx8mp-evk Machine
Date: Sun, 29 Jun 2025 22:48:49 +0200
Message-ID: <20250629204851.1778-1-shentey@gmail.com>
X-Mailer: git-send-email 2.50.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This series adds KVM support to the imx8mp-evk machine, both as a guest and as a
KVM host. Turning imx8mp-evk into a KVM host just required wiring up two
interrupts (patch 1) while implementing `-accel kvm` required more work, drawing
inspiration from the virt machine (patch 2).

Testing done:
* Run `qemu-system-aarch64 -M virt -accel kvm -cpu host" and
  `qemu-system-aarch64 -M imx8mp-evk -accel kvm -cpu host -smp 4` under
  `qemu-system-aarch64 -M imx8mp-evk -accel tcg -smp 4`
* Run `qemu-system-aarch64 -M imx8mp-evk -accel kvm -cpu host -smp 4` under
  `qemu-system-aarch64 -M virt,secure=on,virtualization=on,gic-version=4 \
  -cpu cortex-a72 -smp 4 -accel tcg` and `qemu-system-aarch64 -M imx8mp-evk \
  -accel tcg -smp 4"

Bernhard Beschow (2):
  hw/arm/fsl-imx8mp: Wire VIRQ and VFIQ
  hw/arm/imx8mp-evk: Add KVM support

 docs/system/arm/imx8mp-evk.rst |  7 +++++++
 hw/arm/fsl-imx8mp.c            | 37 +++++++++++++++++++++++++++++-----
 hw/arm/imx8mp-evk.c            | 11 ++++++++++
 hw/arm/Kconfig                 |  3 ++-
 hw/arm/meson.build             |  2 +-
 5 files changed, 53 insertions(+), 7 deletions(-)

-- 
2.50.0


