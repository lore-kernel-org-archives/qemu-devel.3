Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AE3C53219
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 17:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp7qe-0006E0-Vs; Wed, 29 Jul 2026 13:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1wp670-0007kJ-D9
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:22:26 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1wp66y-0006pp-Br
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:22:26 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6a168dc590cso686065eaf.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 08:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1785338542; x=1785943342; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CBmdf56EYLwZeQDdu0YfiTsea5ggFrXhk0M3G8m9ebk=;
 b=UcdDlvdofghiz6S1RSOYKG000ydIqiyQ7OK+n2bvYPfNW/H47peMSa1BUaHMLln9Co
 D/mlEITtbprQrP9JJmDFxeyn3l/t7TTaK/QixapjJfLLeecpkZHBXBbkNjGIINPHDWkh
 wy/an3e/k1uQt91TprIbFZBKxUgnByfibyzEklZ3kT+hPKCpLJS8dEEbHYmKVThotVIe
 9fPbT7oH0+vZFYxoqB5aJdWBAB559D1AzjEptgZbEajXCi9ndUYPBJ3XJ+ADVRtrP9CA
 TMQy67lCaVsu+iX/7LnhC7mkq+PnBFSM1Kv/ZAU8ULiKo+EWg6HXFlHyEJVi5a1Ws63k
 ambw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785338542; x=1785943342;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CBmdf56EYLwZeQDdu0YfiTsea5ggFrXhk0M3G8m9ebk=;
 b=JuQ3Zi7m0zt2qcA8U4ihwn+PF/OXj3HxzBssIIJxa20yw9/GJ1s0Y61pF0XdomAEuh
 m/Hu7fDKl+KgcJ0DZkNGXh6AnH889yIZuJsmPt1lgh6FpJRnCuW2CWol3mVPkrm3rWzP
 58TemLbNudSPWMFZzF8n+EwYQdLuvZblaxqJ8YSzpA7KhvTB5vZ7KjAJqn611DAqxQel
 AN74RtL67gC4+NTNt4nRt8cEhc4chzz4gQT1dmtKMzscxsalCAI6B4QCs3e85jRVTcYU
 jaH6F+zKxNPbuHXez7vIXasK/3oWyM7Q0qKY8de3NTUzi8gfUpCPKjVIzqLtYHZkU6Q+
 pC8g==
X-Gm-Message-State: AOJu0Yy4qx5mqCQFGq3vk6U3I1yieTv8zrmvKc6v/DHR7vd111dl2Kyc
 PG9yJ5lGDcnE7BNrcVmXA3OMcQ9p/p1kPbV/vL87MUvOWP6zuNsazt3wP2JTHMLovHs=
X-Gm-Gg: AR+sD133cGfAxbRXAiOh+XnOgPBRrDzEE4nmZYG1YyYyRX9GajRYMa42PYJB2G9EwtM
 WTBQb6DzU199SAgL+13Vhw6e+vTNVZ6o3LfSnAHwor8yzyJRqK8KA7HZSe34eLHH/hS4xa+q5wZ
 O/D6Baa7D5ku7fRYmcTxZjQROMiJrG2ozzgcxlMpqN+JyqzmTNweoMRxsgNR/4HZKNduoDbCTTN
 kn63PYqq35Bz6AfMFyancw0aEYZaXxq1arPSnxJhdjRssvYkq9J9LkyuK0EdBgHlTmaR2FoHPj3
 YB+QmJ0WIrt1WMAB68mmamZaQY0Jbge5ruRzSyLhk3AVGo+eslcTyHS5vtHfYzdJr4z/PoMrmWL
 FluB3EbOT8cj3sRuuXa+RA0dwtNZCFe3FKnl4JfI8CPJHrpI/LwqF52HEZM46TYWue4oeTuu7OW
 gqJJFh/PJfqzRF0+OUexDSs/Tx0AER2irJ3lstG3844kPjLJxXcS2UufAaOBSbZ+EtF+pFHA7ez
 znpKT/zLm1q2qEvlfHj0bXukWxU1LG5RW0uMQ==
X-Received: by 2002:a05:6820:f0a:b0:6a1:44aa:86ce with SMTP id
 006d021491bc7-6ac96a07437mr2988543eaf.22.1785338542233; 
 Wed, 29 Jul 2026 08:22:22 -0700 (PDT)
Received: from [10.200.56.99] ([12.55.13.134])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-458867fb651sm2476451fac.11.2026.07.29.08.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:22:21 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Subject: [PATCH 0/2] Add Model for Tenstorrent Atlantis PRCM
Date: Wed, 29 Jul 2026 10:21:33 -0500
Message-Id: <20260729-atlantis_prcm-v1-0-502882933e51@oss.tenstorrent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH0aamoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyNz3cSSnMS8kszi+IKi5FzdJDMTo+S0JGPzFFNzJaCegqLUtMwKsHn
 RsRB+cWlSVmpyCcgQpdpaAKx8ne1xAAAA
X-Change-ID: 20260727-atlantis_prcm-b642cfb37d57
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Michael Ellerman <mpe@kernel.org>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 29 Jul 2026 13:13:39 -0400
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

This series adds a qemu model for the PRCM blocks present in Tenstorrent
Atlantis. This block controls clock, reset and other misc functionality
in the SoC. Linux support for the Clocks/Resets served by the RCPU PRCM
was added in [1]. This PRCM model has been tested with a linux DT that
enables the PRCM and sets the UART clk to the one provided by the PRCM.
This DT will be sent out shortly.

[1] https://lore.kernel.org/linux-riscv/20260306-atlantis-clocks-v8-0-6c9b14a4aa8e@oss.tenstorrent.com/

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
Anirudh Srinivasan (2):
      hw/misc: Add Tenstorrent Atlantis PRCM model
      hw/riscv/tt-atlantis: Add PRCMs to tt-atlantis model

 MAINTAINERS                        |   2 +
 docs/system/riscv/tt_atlantis.rst  |   1 +
 hw/misc/meson.build                |   1 +
 hw/misc/trace-events               |   4 +
 hw/misc/tt_atlantis_prcm.c         | 436 +++++++++++++++++++++++++++++++++++++
 hw/riscv/tt_atlantis.c             |  92 ++++++++
 include/hw/misc/tt_atlantis_prcm.h |  51 +++++
 include/hw/riscv/tt_atlantis.h     |  19 ++
 8 files changed, 606 insertions(+)
---
base-commit: 499039798cdad7d86b787fec0eaf1da4151c0f05
change-id: 20260727-atlantis_prcm-b642cfb37d57

Best regards,
--  
Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>


