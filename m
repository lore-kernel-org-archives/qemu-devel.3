Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1A9C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYP4-0002EI-60; Mon, 10 Jun 2024 02:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYP2-0002Db-2X
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:21:12 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYP0-0004Ha-9G
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:21:11 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4218180a122so5513615e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718000468; x=1718605268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lEW/qFqRvf1Ue1gQbjp7+E0dqhff+FhZ7GMHEsEvvbU=;
 b=SJgZTpRQKVft4j3nS86xWbJrNy3xJ/DUknrdLW/vpzGs4nlq1e0/HncyrudpGkqyrj
 BohFPQTrZPiQ21BJ4pSSMD+hJ7M2E2WWcSEtZCGZUYE2inzneeLpoHhDC5s56gYNaHZ4
 DT0qtszFyMVr+gGUDFsHWfhRfmmDo82aL/CPq7hCie5lYXSdvnIqL6z2+EDKu0wP6vPG
 s57g6/UILAU+1X2a04v6DUeza19ecUoLBRZ/rf/ZEaBEx6ADaaOdUiVGpvL7kAwl+NtO
 PTaShPCZCHXg4rOnvBV7ENNW6wDYoND6C0693Ykh/XMRUZgORjqDHBXw9L6u0lz3gqPQ
 n52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718000468; x=1718605268;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lEW/qFqRvf1Ue1gQbjp7+E0dqhff+FhZ7GMHEsEvvbU=;
 b=G3JDmZSt0IbZov4wmJxdTY1uprd2To2r1lkf5FzJI2Ew093qxtcRxBMMQBADBIra1T
 UQ3xNfb1qLxqlFzIZsEqIwWWX0mBAm/HlmDq8jpp0ASsa2cKV/G490HlpozM5q++lrHF
 XZhoqN0WTslFkCWd1K1Bdw7mvKct+JfgRYehJZ+mV5R28fkfbELsB6vKSTqz2vHy9N1H
 OKXIjr+qvr0q4glo+MmKclxFn2p6OXmPyggliT1V8hCmvVRS2Aq90y3t3zjEFBBe6WjY
 cJvDBzMqXIqDTC+xLhGF2L3FH7Aie7HL4+Daufbp0JiATy9ek4EfT7P4vE0c92D7zEvI
 s/ng==
X-Gm-Message-State: AOJu0Yy/Nr89c6NjRf3meQMnzRdkgmj9r0RnrMWAZvwrbYjwMa5jBzH6
 rBoGnJXcnlCBRf8Jefsn5cDABrpdk4VWEiIPmzYPKHAU93dTymG7KG+wvyMB+ABLYsa/q3wAYRy
 J
X-Google-Smtp-Source: AGHT+IGYRRKYE3AFgsqbOocvqvtAJWxVGyBzDPNQaCzfSsjg9Yi4oNyntDs9BCkuWxj1qj/IKjpR/Q==
X-Received: by 2002:a05:600c:4e88:b0:421:7aa1:439 with SMTP id
 5b1f17b1804b1-4217aa108c9mr49703805e9.30.1718000468092; 
 Sun, 09 Jun 2024 23:21:08 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421818907b6sm44823455e9.27.2024.06.09.23.21.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:21:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/26] hw/ppc: Prefer HumanReadableText over Monitor
Date: Mon, 10 Jun 2024 08:20:38 +0200
Message-ID: <20240610062105.49848-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
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

Hi,

This series remove uses of Monitor in hw/ppc/,
replacing by the more generic HumanReadableText.
Care is taken to keep the commit bisectables by
updating functions one by one, also easing review.

For rationale see previous series from Daniel:
https://lore.kernel.org/qemu-devel/20211028155457.967291-1-berrange@redhat.com/

Regards,

Phil.

Philippe Mathieu-Daudé (26):
  hw/ppc: Avoid using Monitor in pnv_phb3_msi_pic_print_info()
  hw/ppc: Avoid using Monitor in icp_pic_print_info()
  hw/ppc: Avoid using Monitor in xive_tctx_pic_print_info()
  hw/ppc: Avoid using Monitor in ics_pic_print_info()
  hw/ppc: Avoid using Monitor in PnvChipClass::intc_print_info()
  hw/ppc: Avoid using Monitor in xive_end_queue_pic_print_info()
  hw/ppc: Avoid using Monitor in spapr_xive_end_pic_print_info()
  hw/ppc: Avoid using Monitor in spapr_xive_pic_print_info()
  hw/ppc: Avoid using Monitor in xive_source_pic_print_info()
  hw/ppc: Avoid using Monitor in pnv_phb4_pic_print_info()
  hw/ppc: Avoid using Monitor in xive_eas_pic_print_info()
  hw/ppc: Avoid using Monitor in xive_end_pic_print_info()
  hw/ppc: Avoid using Monitor in xive_end_eas_pic_print_info()
  hw/ppc: Avoid using Monitor in xive_nvt_pic_print_info()
  hw/ppc: Avoid using Monitor in pnv_xive_pic_print_info()
  hw/ppc: Avoid using Monitor in pnv_psi_pic_print_info()
  hw/ppc: Avoid using Monitor in xive2_eas_pic_print_info()
  hw/ppc: Avoid using Monitor in xive2_end_eas_pic_print_info()
  hw/ppc: Avoid using Monitor in xive2_end_queue_pic_print_info()
  hw/ppc: Avoid using Monitor in xive2_end_pic_print_info()
  hw/ppc: Avoid using Monitor in xive2_nvp_pic_print_info()
  hw/ppc: Avoid using Monitor in pnv_xive2_pic_print_info()
  hw/ppc: Avoid using Monitor in
    SpaprInterruptControllerClass::print_info()
  hw/ppc: Avoid using Monitor in spapr_irq_print_info()
  hw/ppc: Avoid using Monitor in pnv_chip_power9_pic_print_info_child()
  hw/ppc: Avoid using Monitor in pic_print_info()

 include/hw/pci-host/pnv_phb3.h |   2 +-
 include/hw/pci-host/pnv_phb4.h |   2 +-
 include/hw/ppc/pnv_chip.h      |   4 +-
 include/hw/ppc/pnv_psi.h       |   2 +-
 include/hw/ppc/pnv_xive.h      |   4 +-
 include/hw/ppc/spapr_irq.h     |   4 +-
 include/hw/ppc/xics.h          |   4 +-
 include/hw/ppc/xive.h          |   4 +-
 include/hw/ppc/xive2_regs.h    |   8 +--
 include/hw/ppc/xive_regs.h     |   8 +--
 hw/intc/pnv_xive.c             |  38 ++++++------
 hw/intc/pnv_xive2.c            |  48 +++++++--------
 hw/intc/spapr_xive.c           |  41 ++++++-------
 hw/intc/xics.c                 |  25 ++++----
 hw/intc/xics_spapr.c           |   7 +--
 hw/intc/xive.c                 | 108 ++++++++++++++++-----------------
 hw/intc/xive2.c                |  87 +++++++++++++-------------
 hw/pci-host/pnv_phb3_msi.c     |  21 +++----
 hw/pci-host/pnv_phb4.c         |  17 +++---
 hw/ppc/pnv.c                   |  52 ++++++++--------
 hw/ppc/pnv_psi.c               |   9 ++-
 hw/ppc/spapr.c                 |  11 +++-
 hw/ppc/spapr_irq.c             |   4 +-
 23 files changed, 256 insertions(+), 254 deletions(-)

-- 
2.41.0


