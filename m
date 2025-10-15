Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8D3CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 09:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8xea-00028i-1u; Wed, 15 Oct 2025 05:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1v8xeT-00022z-4d
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:18:33 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1v8xe0-0007Hs-1P
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:18:32 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b5a8184144dso380818666b.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 02:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760519875; x=1761124675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z3TwBBdLUHAKhGiv26iGeP2UfTRRDnunnjZgIo/sg9k=;
 b=Oi9A5rvVpwcpO2fhL43PQvh00Y4XwC7n9AMjkxFn7iMl5Nqzd7MOmx7t6fuw0tGl1o
 4OKHxGYo2xGbRpJPLeif9oZ8Wz/0d7o2UWLAkt54gIQ/e8/0+l3S0UbgxTxRpLnRLFIn
 rllF1IYE17v+kaXBdv+aivixfcWyj+Wnv9+zUmIpw2+biNMTGWDZXOU+oVZJFkHW4nOm
 OuPprTm5bGVshG3Y256Y9l9QNFxzcwTj/q26LeiLO3TVeQhS1zQnMvIIsrHlxKj0k0gD
 XcFTAKo6bVkI7qY/l2dH+dzVI2oBctTcwxQyQm33iNLGt2xl6zy42dma4bGo3EZuui0d
 YyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519875; x=1761124675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z3TwBBdLUHAKhGiv26iGeP2UfTRRDnunnjZgIo/sg9k=;
 b=BT/jLSTk+kVFt0zF85A2L+KpRaZAJJM7oqvGPow59YuTVf1TZBfSh7Af2+G7TeVT1K
 ZX2lFmcqxYqYarjy6XPdcZ9iaUhUtcISFU79foyKayNAML7jCipCJpQTD5Srn3DbGo/4
 wzdIuSQhkpV3Keq7Sp9yXC8AzAvWqjO2jqz53YnugQihFMtRusn5LByFWRFHvxlFIwIE
 gjv5XGPBhkbi5erQS0UJ3SIJoxcofcosbNY9QNdGQh3d0EwpDVJ7YCF7vLGNLAhaLB0H
 EcdksESmrbjLOumf9CRF72j8Hl2c68b32xdkpJIawxIBtwzYnslnrNThbhOvzLJtEzRQ
 wcIw==
X-Gm-Message-State: AOJu0YzwioQMHjhR3FljhLRBgCQe08HAp4GIStVGw2AphLpK+BBdKB4C
 RjJY9n9jAmGtr2IFBnbeAKtjQ4Kp0G/EnEaYpQMjAwrDjo+HsNeQa+Sp77v4NjqRpjc=
X-Gm-Gg: ASbGncv/HkGlyr2JnKlL9HyrvJuRnaItjrMrfXu+oL6HSg4qkInKcz8q23vvCj+gZWF
 hqIWko1vs/G86TQ3SYtAzlFoZHXJZTEKRNpQUHTcXJv7lIWJfsWR3TZdR27Xf50DFkUw5zWLMdS
 4gQjLrtbk1M9AFajvuJFtW/fzFcB4a+eGaypaTRhAAEk9cM35j4Z0yUn0Wiwzlb/ikHzL2AwINV
 /iC0V4rLeGNhIFFO9S0Pwea+R/lCdmus4a8XwTHVepYo/SmoZUOWjJq16irHEY7sOxxS+5NRaGM
 HFeKW2/WDuAjh5u5s8TLgbwRhxNOswv4R0NY06nEZ+iWzdhOdtQf0lUER7+ZWlQzQeVm8TB87NR
 Q93R8kXTlCafJBkJxMeyXedxYOJYaLg1WLESbccjSrhiKCJ39fgFi+7czn7WnoqNCg989DaNg
X-Google-Smtp-Source: AGHT+IHUguSygxcid9NBMRmtzkqRkLlbFkDo7Z+do6kIUo0reSSQnIOjB9aVImbBfTWyTiL7i/fkIA==
X-Received: by 2002:a17:907:3f8a:b0:b3f:ccac:af47 with SMTP id
 a640c23a62f3a-b50ac1ccce8mr3300142566b.31.1760519875438; 
 Wed, 15 Oct 2025 02:17:55 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b5cb9e7a23dsm182069966b.23.2025.10.15.02.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 02:17:55 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH v3 14/14] docs/system/arm: Add support for Beckhoff CX7200
Date: Wed, 15 Oct 2025 11:17:29 +0200
Message-ID: <20251015091729.33761-15-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251015091729.33761-1-corvin.koehne@gmail.com>
References: <20251015091729.33761-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

From: YannickV <Y.Vossen@beckhoff.com>

This commit offers some documentation on the Beckhoff CX7200
qemu emulation.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
---
 docs/system/arm/beckhoff-cx7200.rst | 57 +++++++++++++++++++++++++++++
 docs/system/target-arm.rst          |  1 +
 2 files changed, 58 insertions(+)
 create mode 100644 docs/system/arm/beckhoff-cx7200.rst

diff --git a/docs/system/arm/beckhoff-cx7200.rst b/docs/system/arm/beckhoff-cx7200.rst
new file mode 100644
index 0000000000..f060319b0f
--- /dev/null
+++ b/docs/system/arm/beckhoff-cx7200.rst
@@ -0,0 +1,57 @@
+Beckhoff CX7200 (``beckhoff-cx7200``)
+======================================
+The Beckhoff CX7200 is based on the same architecture as the Xilinx Zynq A9.
+The Zynq 7000 family is based on the AMD SoC architecture. These products
+integrate a feature-rich dual or single-core Arm Cortex-A9 MPCore based
+processing system (PS) and AMD programmable logic (PL) in a single device.
+The Beckhoff Communication Controller (CCAT) can be found in the PL of Zynq.
+
+More details here:
+https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/Zynq-7000-SoC-Technical-Reference-Manual
+https://www.beckhoff.com/de-de/produkte/ipc/embedded-pcs/cx7000-arm-r-cortex-r/cx7293.html
+
+The CX7200 supports following devices:
+    - A9 MPCORE
+        - cortex-a9
+        - GIC v1
+        - Generic timer
+        - wdt
+    - OCM 256KB
+    - SMC SRAM@0xe2000000 64MB
+    - Zynq SLCR
+    - SPI x2
+    - QSPI
+    - UART
+    - TTC x2
+    - Gigabit Ethernet Controller
+    - SD Controller
+    - XADC
+    - Arm PrimeCell DMA Controller
+    - DDR Memory
+    - DDR Controller
+    - Beckhoff Communication Controller (CCAT)
+        - EEPROM Interface
+        - DMA Controller
+
+Following devices are not supported:
+    - I2C
+
+Running
+"""""""
+Directly loading an ELF file to the CPU of the CX7200 to run f.e. TC/RTOS (based on FreeRTOS):
+
+.. code-block:: bash
+
+  $ qemu-system-arm -M beckhoff-cx7200 \
+        -device loader,file=CX7200_Zynq_Fsbl.elf \
+        -display none \
+        -icount shift=auto \
+
+
+For setting the EEPROM content of the CCAT provide the following on the command line:
+
+.. code-block:: bash
+
+        -drive file=eeprom.bin,format=raw,id=ccat-eeprom
+
+The size of eeprom.bin must be aligned to a power of 2 and bigger than 256 bytes.
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index a96d1867df..e634872b97 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -82,6 +82,7 @@ Board-specific documentation
    arm/aspeed
    arm/bananapi_m2u.rst
    arm/b-l475e-iot01a.rst
+   arm/beckhoff-cx7200
    arm/sabrelite
    arm/highbank
    arm/digic
-- 
2.47.3


