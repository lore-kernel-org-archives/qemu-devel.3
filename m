Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D02E77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 18:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJcq3-0001I5-B0; Fri, 06 Dec 2024 13:14:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJcq1-0001Hd-6Z
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 13:14:01 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJcpz-0005Nv-LQ
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 13:14:00 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3862b364538so630139f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 10:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733508838; x=1734113638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IY1xd8opRoZk/886AEA9wTe2MQaSyJsx/L7Nvi5q+Po=;
 b=Ktg+vYJ/jFCPz61/1ZvmDlVbAnFPG0rbAK5iOCcJjrbWxe0e1x8goDse5Dnm4wn19e
 nMWwcuI3nIyFZzZIsAD5Lvz5EtcSvw+a4WzcJ2O9qTeEyqbYQwrQ0nQJFo8S4Pb57Gvt
 maI0Acsx1arNR4WT7DVjA2HdXBEaB+komwGqiF5EodXydEQaxb1vxn26s4ipuBp8LOo5
 Kqm3X8Hwqcm2TKx1IJtkrOzuzYsxs8SjX2kJaHWMrONDiV83YnWHzsz0aZVGHoYbbAbv
 hA/iYc6P7+BnpVrgFWDqQxJ/9QpXBlIlh+P4gz1ZsA0GGAkMPGtSAi+jOwNbodG7N0j/
 GwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733508838; x=1734113638;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IY1xd8opRoZk/886AEA9wTe2MQaSyJsx/L7Nvi5q+Po=;
 b=LN6vq55edL1g8nUDDMxYInvI9AsFd2wrH+NoUhGrPMfWTO7DCXOp6srsPC69Y+w0Jx
 MTSLMvSgvxlBlyqfiDAeMpWfw7fuzIH0g3oYhd9LWebT53txoxb7XplIkEmIBVJ4Tx+S
 0Hl7lhFB+0ZrxpQFph0kPpnhh53/0hZ12oKOY0BdKkYYXtlXy3uv54eQkp7Q/5HL1eOO
 e0C1D9W/bf4i/1FxrsBnx9JAnT+DDj9PRrAuQNc8dCyXfI1Up4tlYifBDJYR39LpRDal
 yNTOA2QdVNd9N0dICI6IIcQhOg5c1PB6tGu6rWv9tagR2p1aoKWvKRcorNuSpbfbqjCk
 oriQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXh6LaP+0e0nMFMNkql2Fy/gYHT2A+aUMeaONewjGxcQ2pv/AsJ5pHxrkDJ8P3DyvCr5y7HbyPDCSQc@nongnu.org
X-Gm-Message-State: AOJu0YzBG0ogX8z04M+BKkSeW1VtHF9JaSbvhP7NQ01y+L+YctZif0DX
 /zDVlolu6DnJGI/G5cUjQ8eK8OfJJZn9kxGzYf9MVU7N+vXgAl7hN/jeSDXwLTw=
X-Gm-Gg: ASbGnct2NLKJjAX9tXmPZYxUULBeswX8ugEQwo3znOwfzpZ2HqXSHcFU3NspY+yYdtg
 1RxpRwRTP4L5i07btCZ6wWJn5AAnEiq2h6YpZQMY6KflCrExqnRzTTQadLYyqOp3hft2/SJCovk
 YLc5lv8lqH+GWruz+DC1gtANyXJPlIsSTJgZaxylWLK91LkR2NIdNssAIikSU7lF0lOZ+b71ZKs
 P6H3rbfU8eaXBX1ZPDo8Z0O/Dtun6RciYdzlXWQz1IDGsyoiLaZ4ec4UORmwpf9oRY=
X-Google-Smtp-Source: AGHT+IEU2BPlmxhYPLdUABxsDUF8nf0CVXsZH3dFkokR8Nz6+Q4s3Ooxz4SpHMEZO/nrDgtOHJnkWg==
X-Received: by 2002:a5d:64ef:0:b0:385:f892:c8be with SMTP id
 ffacd0b85a97d-3861bf7382emr5757158f8f.23.1733508838056; 
 Fri, 06 Dec 2024 10:13:58 -0800 (PST)
Received: from localhost.localdomain ([95.127.41.180])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-386219098d3sm5256260f8f.70.2024.12.06.10.13.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Dec 2024 10:13:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Jiahui Cen <cenjiahui@huawei.com>,
	qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 0/6] hw/nvram/fw_cfg: Move PCI bus methods out
Date: Fri,  6 Dec 2024 19:13:46 +0100
Message-ID: <20241206181352.6836-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

In order to keep fw_cfg device model clean, remove the PCI
bus specific code. Instead, the equivalent functionality is
implemented within the PCI_BUS object in hw/pci/,
implementing TYPE_FW_CFG_DATA_GENERATOR_INTERFACE.

Philippe Mathieu-Daudé (6):
  hw/nvram/fw_cfg: Rename fw_cfg_add_[file]_from_generator()
  hw/nvram/fw_cfg: Pass QOM parent to fw_cfg_add_file_from_generator()
  hw/pci: Have PCI_BUS implement TYPE_FW_CFG_DATA_GENERATOR_INTERFACE
  hw/pci: Add pci_bus_add_fw_cfg_extra_pci_roots() helper
  hw: Use pci_bus_add_fw_cfg_extra_pci_roots()
  hw/nvram/fw_cfg: Remove fw_cfg_add_extra_pci_roots()

 include/hw/nvram/fw_cfg.h | 21 ++++++----------
 include/hw/pci/pci.h      |  3 +++
 hw/arm/virt.c             |  3 ++-
 hw/hppa/machine.c         |  2 +-
 hw/i386/pc.c              |  3 ++-
 hw/nvram/fw_cfg.c         | 34 +++++--------------------
 hw/pci/pci.c              | 53 +++++++++++++++++++++++++++++++++++++++
 system/vl.c               |  3 ++-
 8 files changed, 76 insertions(+), 46 deletions(-)

-- 
2.45.2


