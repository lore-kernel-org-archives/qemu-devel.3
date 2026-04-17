Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64C1F4368D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 11:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDh1n-0000FR-Cl; Fri, 17 Apr 2026 07:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDh1f-00005K-1s
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:06:20 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDh1d-0003l8-GM
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:06:18 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43d73352cf2so475466f8f.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 04:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776423975; x=1777028775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZN14khrJwspWgCASk1X5psK/KI78gmKsSGDmKRmyCu8=;
 b=q3dsi/Tfs6irT1zknGsc1plKwDcAqEr3cuOICNTlHY+c3MOeaDcjGn3iZs7o0+UgtI
 mf7gmtRmSRekA2BRmBu5HNzp+wmmQEYhIzap0q6luEMh7UaG6oVLnqYQA5VxjblKQOp+
 jOQHyb2/lnOa0towaXVAXuSxEBnzU7JhWmwcrppjxcBiLcO8a/s6VUU2TWLp50O3gHSo
 ucZPgyGcTDbX+Y6UZ4D77ZIAyM7C6W1zUsYnffzCMW/6fve7k9p61H64zybgp67Uj8Xq
 PHCziXWx2HOPMQcTLyXR5jukxHQEyWqrQ/4MHOqL5aDsuWHFZCygcT+oSQokye1reg9v
 E2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776423975; x=1777028775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZN14khrJwspWgCASk1X5psK/KI78gmKsSGDmKRmyCu8=;
 b=T0IPO9Z8f8oHng7q7Rqj8Fqw6MYEDDbuk0yYPYUNkr+1Nyfy3h4ChTE85XSnEXGRBi
 LGaqT/pGgEsgWHfhYyPdmo1VPuHjAhTHtSUoxTe51uriK4mB/Xm76tbgk2p36/6N/QdV
 Ku2rQ9YnfBboFcQmrb91kKKihd2SaKfcQcbbh7Fx0u2sjs4pbbbjgvwCzSrtMqi+w1Bv
 cOZWwQ6GHBV0qPiBb42Vp6Voubt/A8XQ0dRkn+sgf+UP4w14tItFSLCTd6bWqQGLQHgR
 P00ef1BN4U6jpopKPpPCAQkNr6N1Xun4d/+KypD7b+GPIr215Q7kfGOFLyuZB+9libpl
 hepQ==
X-Gm-Message-State: AOJu0YwZidPCupSnA68MTYnH0/CtLcLQpWPMFcej0cbwziypUtNsGajn
 M8wad0qi6wCKWoFEZdhH2Rr32HKtN0ogUqfbHzKXDcRINQx7E8HLl4Y8uxhxeXUIbSIa2xqn7Ez
 Mj3ggp50=
X-Gm-Gg: AeBDietOoa0pGcxmf8Glpyh9V4/GBo9Nnbra6WbSkY5qjAmZpvTDqNLawcvNWUMPKcV
 gBx/D9SGwQ/ibYAeoz9FYbEP3CC/wWrnlsBs9YlPIjH4s8qMNIdCFpL2XBSUNTXST05MgnxXpm2
 o8B/TPZ5BvdIOqIVGX3QjDt0abRXkNw6kadK6AB94kFuGpsJYRd7ng7CEsjZ+Rf+4c/YoF48Uab
 OtrsEhtWzYm1nWvdUD+0Rfr7uu9FWcD7kXXlBz6qf3aOdtrEBxCmDKN2mNVBLOgDO8kmrYdHZcN
 X8ZKpV+oDiXaJkNUiMolbYBxDWNx43xxkQmd64hUb0Tq4MrUfGJr0Z4cvg+gnU2za0M3gGKZebG
 S9utgdI4RL+HIn37w79kMu2JSfU8RTmHJuzNlFaU8p8EfM0lNVR/8paZFK9rUhOvC6G8VjCDirj
 vxl94Uz/WUmspmNoFD/eEWsR9HjkOAaVxfh8XYGkvUXSTihL0yJdeateSAZlz/62vzprnIhEE03
 28gPtqIMdc=
X-Received: by 2002:a05:6000:18a3:b0:439:b8b2:fabc with SMTP id
 ffacd0b85a97d-43fe3dd4b7dmr3475498f8f.21.1776423974734; 
 Fri, 17 Apr 2026 04:06:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a18csm4250279f8f.20.2026.04.17.04.06.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Apr 2026 04:06:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 3/7] MAINTAINERS: Merge PCIe DOE section within SPDM
Date: Fri, 17 Apr 2026 13:05:45 +0200
Message-ID: <20260417110550.70068-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417110550.70068-1-philmd@linaro.org>
References: <20260417110550.70068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

SPDM depends on PCIe DOE, so it makes sense to cover
these files there. Cover the spdm.rst document. Add
Tao Tang who volunteered to be designated reviewer:
https://lore.kernel.org/qemu-devel/44abaece-6a6f-43c6-b29a-53d6eb08033c@phytium.com.cn/

Cc: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Gustavo Romero <gustavo.romero@linaro.org>
Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 11bf50a9ecf..eccc0d64331 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2150,11 +2150,6 @@ F: docs/pci*
 F: docs/specs/*pci*
 F: docs/system/sriov.rst
 
-PCIE DOE
-S: Orphan
-F: include/hw/pci/pcie_doe.h
-F: hw/pci/pcie_doe.c
-
 ARM PCI Hotplug
 M: Gustavo Romero <gustavo.romero@linaro.org>
 L: qemu-arm@nongnu.org
@@ -3693,11 +3688,15 @@ F: tests/qtest/*tpm*
 F: docs/specs/tpm.rst
 T: git https://github.com/stefanberger/qemu-tpm.git tpm-next
 
-SPDM
+SPDM, PCIe DOE
 M: Alistair Francis <alistair.francis@wdc.com>
+R: Tao Tang <tangtao1634@phytium.com.cn>
 S: Maintained
 F: backends/spdm-socket.c
 F: include/system/spdm-socket.h
+F: include/hw/pci/pcie_doe.h
+F: hw/pci/pcie_doe.c
+F: docs/specs/spdm.rst
 
 Checkpatch
 S: Odd Fixes
-- 
2.53.0


