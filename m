Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02514D44C56
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 14:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgOJ4-0003Xj-QG; Thu, 15 Jan 2026 09:26:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgOJ3-0003XG-B4
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:26:37 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgOJ0-0004jc-Tw
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:26:37 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so12206635e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 06:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768487193; x=1769091993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pAnwY4PzPHpEbddcfZS0lRxYq0htrXKjp/HZmwpKGDk=;
 b=M7vZcOkOjFRb830QQUSRk4+6Kcbd7yIG7ugn1cqyig09UAKd1fRsg+t2rTOyeJrUTe
 gp40pAmkub8ee2Xdr4LPWhjkcQ3IsscgJRi02aUcvXn8VJhaVOmES40FE4y3FKmi8xOp
 6bfUeAisdohVlRVY0fV2qPlZSE2R2eCexDund12P034U06l9nW57R4cItjBgzZnccEce
 xos1/5DEvP1mzWEWBYwPrY1eVXTAIXn9Y1v2XGOTWiZ8gbBFgazPOvkMx7QM2ufyWwWJ
 pjwSyJWRaxmey/km8dYUUsHXnClSh0TeVN/0FcgIueR57RgCi2uvS79JCrefGY9sq7kq
 GQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768487193; x=1769091993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pAnwY4PzPHpEbddcfZS0lRxYq0htrXKjp/HZmwpKGDk=;
 b=eVxJHizU+Bcty7yBHPqdFD1YxI/cMt33AuSxFlmqvOuLXNTyWp9qrqG9SGHSqEpHPm
 vThJqTki7Mktqdsu8/y3R7ycG4j7jKX9+yUou9xd6PKPAcWU+hZPGvlKna6M+7rVkLBn
 io9poFY6k6SBVhwXfEWvzXNDwrC2zR7bhoDFsY67EltjeR2n9ffITlCBEtrtxVxS7ZoK
 qhvxlDLTS7+Kr7Lp4AfU1uflJEusouDOoHBXwZDaqsrmJp8eAK2bcmzDalExtLtuuMGZ
 uXm2vNxGuoAeMTyEYYcnv+Mgn9MLr570h+Y3s7WMZK5CEjU498gxnerJiS53zCI725tZ
 vN4g==
X-Gm-Message-State: AOJu0Yw/sQYsFjQJXIQav9WMOWxnrlocOKNCXDfHOUJX91tY1NZQJ61G
 KPUGObKeNRkHYdJP0KRXVhKhI7waR74DjrRAQZUMK77joOMmVgub4vlqQhxqyKqmKEhDeQJ5cxz
 DgZ49
X-Gm-Gg: AY/fxX5Ak6JBQje8t4B4qhR3aIqoBPMZJ9cG0/a8WTo4ch8bWpBPfnoEPnMi7RN+wWs
 uwVnWtqOWwUILzNaWJ9ImJrohGWMNLWWbGtbbO+/CBy/ta5qcOecMg+719TwRibQIS4V4bm32Xi
 0No1hM6LnrSshX3XW1PEM8ABs2LWygVgoUSHs2Ch9L0lTGz/YPK3ixwHM1YEsghpyAWkzVF7iO6
 ZLQ3HDqPWo4yyjHQKb15RmTtSj9oEgoK2ny8sfhterCNHHaS7ndxiMW3l7TYLsE4BGsyemkIf+D
 TQxvFJF4ZD5lElW8k5UTE4+7Ym+rfk4fk1QHIujTBjUlj8vFdYg4m7L7xwF1ge7gMOlESBbuFR9
 Y0p2W5mBYnI4HOt4sXAZAOVYrehXnIlPEU4jNRMsaKhuLyqZxtVXqzQqy/XxJ80QUbgw7CBK6Iu
 uJ48EXFR+9WF65qmb6Hv/b4mXcdH+qRXT7pB1rJG9WEOBvztcgqZbSGSJ877OcM7jq+yqEWrM+d
 7YJRb4OxLhIl1udY5flbowOAhoW5uW0/uZ+LIaFLHhaKQ==
X-Received: by 2002:a05:600c:34cd:b0:477:54cd:200e with SMTP id
 5b1f17b1804b1-47ee32e5d05mr79663955e9.1.1768487193006; 
 Thu, 15 Jan 2026 06:26:33 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4b2672d6sm50759435e9.14.2026.01.15.06.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 06:26:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 1/4] docs/system/arm/xlnx-zynq.rst: Improve docs rendering
Date: Thu, 15 Jan 2026 14:26:26 +0000
Message-ID: <20260115142629.665319-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115142629.665319-1-peter.maydell@linaro.org>
References: <20260115142629.665319-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

Make some minor improvements to the rendering of the docs for
the xlnx-zynq-a9 board:

 * use a proper hyperlink rather than a bare URL for the
   link to the reference manual
 * drop the hex address of the SMC SRAM: the bare '@' is
   rendered as bogus mailto: hyperlink, and the information
   is not very interesting to the user anyway
 * expand out the abbreviations in the list of Cortex-A9
   per-CPU devices
 * correct the bullet-point list markup so it doesn't render
   with odd highlighted lines
 * capitalize 'Arm' correctly

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/xlnx-zynq.rst | 51 ++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/docs/system/arm/xlnx-zynq.rst b/docs/system/arm/xlnx-zynq.rst
index ade18a3fe1..aa37df2926 100644
--- a/docs/system/arm/xlnx-zynq.rst
+++ b/docs/system/arm/xlnx-zynq.rst
@@ -4,32 +4,35 @@ The Zynq 7000 family is based on the AMD SoC architecture. These products
 integrate a feature-rich dual or single-core Arm Cortex-A9 MPCore based
 processing system (PS) and AMD programmable logic (PL) in a single device.
 
-More details here:
-https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/Zynq-7000-SoC-Technical-Reference-Manual
-
-QEMU xilinx-zynq-a9 board supports following devices:
-    - A9 MPCORE
-        - cortex-a9
-        - GIC v1
-        - Generic timer
-        - wdt
-    - OCM 256KB
-    - SMC SRAM@0xe2000000 64MB
-    - Zynq SLCR
-    - SPI x2
-    - QSPI
-    - UART
-    - TTC x2
-    - Gigabit Ethernet Controller x2
-    - SD Controller x2
-    - XADC
-    - Arm PrimeCell DMA Controller
-    - DDR Memory
-    - USB 2.0 x2
+The SoC is documented in the
+`Zynq 7000 Technical Reference manual <https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/Zynq-7000-SoC-Technical-Reference-Manual>`__.
+
+The QEMU xilinx-zynq-a9 board supports the following devices:
+
+- Arm Cortex-A9 MPCore CPU
+
+  - Cortex-A9 CPUs
+  - GIC v1 interrupt controller
+  - Generic timer
+  - Watchdog timer
+
+- OCM 256KB
+- SMC SRAM 64MB
+- Zynq SLCR
+- SPI x2
+- QSPI
+- UART
+- TTC x2
+- Gigabit Ethernet Controller x2
+- SD Controller x2
+- XADC
+- Arm PrimeCell DMA Controller
+- DDR Memory
+- USB 2.0 x2
 
 Running
 """""""
-Direct Linux boot of a generic ARM upstream Linux kernel:
+Direct Linux boot of a generic Arm upstream Linux kernel:
 
 .. code-block:: bash
 
@@ -44,4 +47,4 @@ For configuring the boot-mode provide the following on the command line:
 
    -machine boot-mode=qspi
 
-Supported values are jtag, sd, qspi, nor.
+Supported values are ``jtag``, ``sd``, ``qspi`` and ``nor``.
-- 
2.47.3


