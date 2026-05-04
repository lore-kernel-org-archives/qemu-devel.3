Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44A4FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 16:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJwWw-00046W-Bi; Mon, 04 May 2026 12:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wJwWt-00046A-Nv
 for qemu-devel@nongnu.org; Mon, 04 May 2026 12:52:23 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wJwWs-0005Ci-3V
 for qemu-devel@nongnu.org; Mon, 04 May 2026 12:52:23 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43d7badbd7dso1960448f8f.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 09:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1777913540; x=1778518340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NpQNrT+aL0KrLZASgXBs5V+GURsbVbGn5z4J20euJ8U=;
 b=WbolIgHmeEsP3/fNTpXZpYesXOWhuiuhlLWI0HwTfiA6lcr0GjOfhQVLBJVoikZkcw
 nHJxD3N2SVGixn/bdr3V6zMt3/zmBsUS2a36JXExNbsL9o4P9ea48ECzTSurqEBOaNLr
 GHVxjFc/Sng+zzPue+ge3oGITTuMkHJehAX1l4tB/oZ9r75MwpaaHkSTJSAEn0SgSw9l
 co046eTITcK5No15eE3yep7BtVFQrt4mkaoJHKNRJAQeiLu1yfo0yJDRF/KfagvmyiDQ
 5Q2MeoEdHjbOzHwBHAu0m9wiLk4YrQEoG0nHKWjX5UGSuIifQFQRuoFuyJZfivlgfsg1
 Y4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777913540; x=1778518340;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NpQNrT+aL0KrLZASgXBs5V+GURsbVbGn5z4J20euJ8U=;
 b=pUM9KwvL/mfJ7/j0/aBf833D6KkQimhIJrfz1SfxpiMo2ZukmZe/V0CD6OCoZnG8Lw
 tFQwBcoIP0iXakwklFeq6/pltY4F64ptkGwfeyMgvgvOjDZUiKlDs1dlrs/Ulnm7KBp3
 HjCWivC//kestIzBvP2oVslpojCw0Fsg1V2IvA6hvWVOqUZvAeULrLcrpSHj8SY5+w9O
 Ga1GE0dihO73hPwDMwBikXObm0Y8NGZX9iH+hVZE0UUL5LqP62iF5/Bi2/uv7ZX13WIN
 rx+CZFbNr80nOo4WNZ1nPcrTCxaiyIKPOCqU0e3wM9WgXObNhQ8VnAufJLrE50EH2a42
 5iwg==
X-Gm-Message-State: AOJu0YykE8UULPa4f4LlcfViU8tC8XYImxjSNRU7U3725C98mvFO3lOh
 dPam7w7OwTbIPDglpzRZD2fASxyx7cbiSQRKcug2NDkMtsbi42+yJahTo07DPrIZ/c+yiJoUFrA
 mm0kb2aY=
X-Gm-Gg: AeBDietlEwK3VA+S0BN4mSPtfAVTiv4VmW4sv30+Y3K9M+lfS6yWm1TGnWCirb+6q5Y
 CGGv58Ft8HuM1Cb40VrQgyDA7iRTkjjS/O7tnShKXfxakGGY6TgDTR5pu0dgDVAdrwwC3AdaoDL
 jNJT+90AjLxMRaMD4F8RuFjWNPjcDsfSrDrIUC3GVmjbVPOPofuP9kA7e6cbKT/hgyoEo0cYIQY
 oATKkZRREyLUIWR6Dbaz6N2PUps+wo1IhWz71g+c9MG3p4AKp4xa1H7SGT/Pe7tiSYETViCeVY5
 swv4GMKbDprfeyJwExXS7vgwA5ePFk46HAPQLYyof7TEP/rHrT4Xw8PI+VB2XfpfvBGvFTkvjyt
 t21hJqc5dxh5T5fHZU7l0p6VA7c4TGZsqsPrLZfPKGdJtB/8tD+QmMz0ApdY8TA6N7AMBZajDzj
 iSx2Gy/K0NB+EouifqSsKTyfEzKCPir6VOe098VKEXermQmW1QSJVgJCY=
X-Received: by 2002:a05:6000:228a:b0:446:38ec:b35b with SMTP id
 ffacd0b85a97d-44bb6ab1b02mr16067112f8f.40.1777913539640; 
 Mon, 04 May 2026 09:52:19 -0700 (PDT)
Received: from alexanderarchlinux ([188.111.3.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44a8ef50e59sm26482830f8f.10.2026.05.04.09.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 09:52:19 -0700 (PDT)
From: Alexander Hansen <alexander.hansen@9elements.com>
To: qemu-devel@nongnu.org
Cc: Alexander Hansen <alexander.hansen@9elements.com>
Subject: [PATCH 0/4] initial support for yosemite v4
Date: Mon,  4 May 2026 18:48:32 +0200
Message-ID: <20260504165043.213704-2-alexander.hansen@9elements.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alexander.hansen@9elements.com; helo=mail-wr1-x432.google.com
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

Add initial and incomplete support for yosemite v4 BMC-side emulation.

As part of this effort 3 new sensor ICs are added.

Alexander Hansen (4):
  hw/sensor: MAX31790 support
  hw/sensor: support MAX11615
  hw/sensor: support Texas Instruments ADC128D818
  ast2600: yosemite4 initial support

 hw/arm/Kconfig                 |   3 +
 hw/arm/aspeed_ast2600_fby4.c   | 298 ++++++++++++++++++++
 hw/arm/meson.build             |   1 +
 hw/sensor/Kconfig              |  12 +
 hw/sensor/adc128d818.c         | 414 +++++++++++++++++++++++++++
 hw/sensor/max11615.c           | 200 +++++++++++++
 hw/sensor/max31790.c           | 497 +++++++++++++++++++++++++++++++++
 hw/sensor/meson.build          |   3 +
 hw/sensor/trace-events         |  24 ++
 include/hw/sensor/adc128d818.h |  20 ++
 include/hw/sensor/max11615.h   |  20 ++
 include/hw/sensor/max31790.h   |   7 +
 12 files changed, 1499 insertions(+)
 create mode 100644 hw/arm/aspeed_ast2600_fby4.c
 create mode 100644 hw/sensor/adc128d818.c
 create mode 100644 hw/sensor/max11615.c
 create mode 100644 hw/sensor/max31790.c
 create mode 100644 include/hw/sensor/adc128d818.h
 create mode 100644 include/hw/sensor/max11615.h
 create mode 100644 include/hw/sensor/max31790.h

-- 
2.54.0


