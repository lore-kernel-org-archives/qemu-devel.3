Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866CBC3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMf8-0000xE-Ae; Thu, 18 Jul 2024 04:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMf5-0000nr-V2
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:38:52 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMf4-0004fo-4x
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:38:51 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52ea2ce7abaso113950e87.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 01:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721291927; x=1721896727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NZhVPPESYyOA2ZSzQn5rT4TavGDsoy7sQe+a6ueTJ9I=;
 b=bKw3Vvn9ClqdxpNMMHtLC3wmceKLswlluVxeaEMrn2a0/OpjlZOumKT0SN5tDYWbd7
 lzw3YnYBZvYQHZIahWb/vlbu0NGXEws+qmq0HDVzILZseiz29MRZlC+qHB4L1ZcBeJdu
 4S4EzfuaiUvKBVpSioFsBZDbP4fXhGk8Qo6UjFOBe+vTUFcvbUC5TBpL96Y74jjOzKgD
 Whe+Emc48JLeC/lsAcIe2NjIVE5aIMhIQnGRPPpLAiWlfVSIPelzO8XeiEsWqgFKINYG
 6xNeLO0Ji/AGXvhj7VtWBnuucEHQqkPYec4SV/UAH4Sa90oownROg9F5F73xj0WTuZFI
 Zs+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721291927; x=1721896727;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NZhVPPESYyOA2ZSzQn5rT4TavGDsoy7sQe+a6ueTJ9I=;
 b=twSP2mcewqEMZqoHuo1ZlQVIW1WXpQOzJTc3RRLVqFFchdvAFKQ2aurZgGZ7SgJkBB
 ltly58RoU93QDIHuidMT0urEsJMWZi5JrWv4T9Z0q3RigtFNRDbQds1pzzcEdI56F0Tx
 igBZ2Bw3lhTVGjXqQShCsKZCGB2JGnZW9Gevm2D0ZsH13PXLekcOiyaV90zYJYMbB3vv
 1oYkBkN1TKeeUGDLzna16a5bY8Q4gsVyu+v7GqDftxUbilt0tkp4qB+H+JBgbwyo3xsE
 PS9HcUoYp/6KrwZOQJmsi97qlO4QqTpI1VuUCHWr1kfaZI6CFxmChgO0Gj+21EPQigM2
 Inzw==
X-Gm-Message-State: AOJu0YzK0OXRVV1Pn+Tc82u6ADYEa+1UrZGjVjf0/NDfgXwszteuIqJI
 +zxQMQTCDDEPKGNQ33Sh1BAvtZ3ov9zxxev10EqZ6xjWyj9GpscsYQQGdGJ539APY3bqPTVDcN7
 KscY=
X-Google-Smtp-Source: AGHT+IE8IUAvoW4Ndth7XKY+e/uq9pCwbupSrLOKsJ62Z/bPsfXSExoyqGJfqQ3DtoS2FOkWKI8R0w==
X-Received: by 2002:a05:6512:3b92:b0:52e:7f09:aaae with SMTP id
 2adb3069b0e04-52ee53c50e8mr3728974e87.27.1721291927422; 
 Thu, 18 Jul 2024 01:38:47 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b136absm1440335e9.2.2024.07.18.01.38.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 01:38:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 00/18] Reconstruct loongson ipi driver
Date: Thu, 18 Jul 2024 10:38:24 +0200
Message-ID: <20240718083842.81199-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

Since v3:
- Use DEFINE_TYPES() macro (unreviewed patch #1)
- Update MAINTAINERS
- Added Bibo's tags

Song, since Bibo reviewed/tested, if you provide your
Acked-by I can queue that to my next hw-misc PR (pending
Jiaxun testing).

Thanks,

Phil.

Bibo Mao (16):
  hw/intc/loongson_ipi: Access memory in little endian
  hw/intc/loongson_ipi: Rename LoongsonIPI -> LoongsonIPIState
  hw/intc/loongson_ipi: Extract loongson_ipi_common_finalize()
  hw/intc/loongson_ipi: Extract loongson_ipi_common_realize()
  hw/intc/loongson_ipi: Add TYPE_LOONGSON_IPI_COMMON stub
  hw/intc/loongson_ipi: Move common definitions to loongson_ipi_common.h
  hw/intc/loongson_ipi: Move IPICore::mmio_mem to LoongsonIPIState
  hw/intc/loongson_ipi: Move IPICore structure to loongson_ipi_common.h
  hw/intc/loongson_ipi: Pass LoongsonIPICommonState to send_ipi_data()
  hw/intc/loongson_ipi: Add LoongsonIPICommonClass::get_iocsr_as handler
  hw/intc/loongson_ipi: Add LoongsonIPICommonClass::cpu_by_arch_id
    handler
  hw/intc/loongson_ipi: Expose loongson_ipi_core_read/write helpers
  hw/intc/loongson_ipi: Move common code to loongson_ipi_common.c
  hw/intc/loongarch_ipi: Add loongarch IPI support
  hw/loongarch/virt: Replace loongson IPI with loongarch IPI
  hw/intc/loongson_ipi: Restrict to MIPS

Philippe Mathieu-Daudé (2):
  hw/intc/loongson_ipi: Declare QOM types using DEFINE_TYPES() macro
  hw/intc/loongson_ipi: Remove unused headers

 MAINTAINERS                           |   6 +-
 include/hw/intc/loongarch_ipi.h       |  25 ++
 include/hw/intc/loongson_ipi.h        |  50 +---
 include/hw/intc/loongson_ipi_common.h |  72 ++++++
 include/hw/loongarch/virt.h           |   1 -
 hw/intc/loongarch_ipi.c               |  68 +++++
 hw/intc/loongson_ipi.c                | 355 +++-----------------------
 hw/intc/loongson_ipi_common.c         | 344 +++++++++++++++++++++++++
 hw/loongarch/virt.c                   |   4 +-
 hw/intc/Kconfig                       |   8 +
 hw/intc/meson.build                   |   2 +
 hw/loongarch/Kconfig                  |   2 +-
 12 files changed, 568 insertions(+), 369 deletions(-)
 create mode 100644 include/hw/intc/loongarch_ipi.h
 create mode 100644 include/hw/intc/loongson_ipi_common.h
 create mode 100644 hw/intc/loongarch_ipi.c
 create mode 100644 hw/intc/loongson_ipi_common.c

-- 
2.41.0


