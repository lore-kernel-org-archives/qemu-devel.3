Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D27CD4F48
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOsVB-00013q-3p; Mon, 18 May 2026 03:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wOsUc-0000j9-2P
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:34:28 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wOsUY-0000Yz-KT
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:34:25 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488b0046078so16627245e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 00:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779089660; x=1779694460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PAEBPFqVQi36NfFP7Jq0Ftsf5CsUo7EyAsxwaDAqaz0=;
 b=qzWtVG6FyoWNlmJs0jXDijNEGDYmz3lhOgHBdv2agDhKM761UdoJzx3yw735/z9cdw
 0/SyKaSiFFQg/4lsilFxdndMuSBtNTaVsvn9ZEo96Y9WDm6atsB//649C29CwrfKgQSj
 7y0V5wB/ATO7GMzuNuBnD3jkuqWUwXY/Vfxh3LmrVLWXWaYYeqy/IS1G1IJN/ZUauDkD
 bbP0ijLVQj2C4+TC3/OMsIo7fwQDgp+NRAwSQSTNp4PqA0DB2jsuu6VBvqnlRkpM6+CY
 hJ5bOaFhC6Lk8aQIoPdJqM+Kwa3M48IaALGdyfEyBx5ir6XQk17vFVXL+ZTDtNrDSYVf
 fVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779089660; x=1779694460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PAEBPFqVQi36NfFP7Jq0Ftsf5CsUo7EyAsxwaDAqaz0=;
 b=JtlGCm9Q8ZSH4cAx6ux19bzrxaqPEwwWZbk3WHnua0Jc9j4sw6ymjxwhTijxTBUG7A
 7cymmf/Q8cRaIoG4lKAeJDxQi7LDmNok1O97JresROJghJ+jaJrHagWGmdnX2Cp1I9js
 PeU3c/FRBUjy2bpAlj5DQikLlQIaGTEfcr10A0NtCU4BSJJyHFJc2lrkIEWZ2c7MRDC2
 xPUjjHeXmAgnMFAM2BfsiK6rUmkjh3vLReeoPN59cTaRKuAtDCdsSLT/ueh3t46j0zyi
 XsXJ2b4Q90HzICyfx/eh2mXkIPz0hfE4cL9e0ncXFPYYw7p8+PAYrgTMwdv6ySv2MFfG
 xCCw==
X-Gm-Message-State: AOJu0YwfKH37HVxilNLQ+TTNYij4VQYTPILGfK9zauVmg5WJcjVyVD9q
 V9rdaLfldRW5TTElceejhO+GvBzCSoiDEiQAPVKWLmCCuazBKjWCko8009Qt/L84
X-Gm-Gg: Acq92OEbOPRPskG3B7dCghDtg0+wp4kfOk/uehmmMjb84mBUIF644ga81c0u0WMQgbw
 gg6yiSWRwxqLRxnnte6UGmOl7hcKa+W41SDkPnFJJIyhsPS6DKbbApJCF+33/Gel/eiUGEWwNub
 j+r5/vQ0h4I80+U1zi8zXpwOIK52U9ZttSm5bYtlz5YyxoUvqCPKudySxb8O6bgMNP0Fim1PoQV
 lh1hMiMXENinBfNV0jeMWcEC8l+0hE906glNW13F7vZK4ZbZosrKx4TRKtJ+pZXDuMvcjgt9bMb
 XuaRQAkkpsjGb5F6aKjyle/ykmiJx/xok5qavpfeoRYJnOXmUBM0NraF17KEVIyjr8w8BpyZBBK
 nEKrrRdAfnnl2l2O3wBHd+9JjEu8bkcXkj9oKlWGKqTCGgJa/MIywdLfUaTdpnSZbJiGPfZquJh
 q+MXpDuMEwAqEslluJ9DMdotcPaCJuHuM0FOXfW5mrVYnIFWQPJwX85StP
X-Received: by 2002:a05:600c:a102:b0:489:a4:e578 with SMTP id
 5b1f17b1804b1-48fe60da919mr153278085e9.14.1779089659718; 
 Mon, 18 May 2026 00:34:19 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com
 ([2001:9e8:dc08:b284:85e6:f7f4:1a4a:4dfe])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3b18fsm32590222f8f.11.2026.05.18.00.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 00:34:19 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yannick Vossen <Y.Vossen@beckhoff.com>, qemu-arm@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Corvin Koehne <C.Koehne@beckhoff.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v7 16/16] docs/system/arm: Add support for Beckhoff CX7200
Date: Mon, 18 May 2026 09:34:01 +0200
Message-ID: <20260518073401.11279-17-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518073401.11279-1-corvin.koehne@gmail.com>
References: <20260518073401.11279-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=unavailable autolearn_force=no
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

From: YannickV <Y.Vossen@beckhoff.com>

This commit offers some documentation on the Beckhoff CX7200
qemu emulation.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/arm/beckhoff-cx7200.rst | 62 +++++++++++++++++++++++++++++
 docs/system/target-arm.rst          |  1 +
 2 files changed, 63 insertions(+)
 create mode 100644 docs/system/arm/beckhoff-cx7200.rst

diff --git a/docs/system/arm/beckhoff-cx7200.rst b/docs/system/arm/beckhoff-cx7200.rst
new file mode 100644
index 0000000000..6163a0cfa5
--- /dev/null
+++ b/docs/system/arm/beckhoff-cx7200.rst
@@ -0,0 +1,62 @@
+Beckhoff CX7200 (``beckhoff-cx7200``)
+======================================
+The Beckhoff CX7200 is based on the same architecture as the Xilinx Zynq A9.
+The Zynq 7000 family is based on the AMD SoC architecture. These products
+integrate a feature-rich dual or single-core Arm Cortex-A9 MPCore based
+processing system (PS) and AMD programmable logic (PL) in a single device.
+The Beckhoff Communication Controller (CCAT) can be found in the PL of Zynq.
+
+You can find more detail about this board on
+`the manufacturer's product page <https://www.beckhoff.com/en-en/products/ipc/embedded-pcs/cx7000-arm-r-cortex-r/cx7293.html?>`__.
+The SoC is documented in the
+`Zynq 7000 Technical Reference manual <https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM>`__.
+
+The CX7200 supports the following:
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
+- DDR Controller
+- Beckhoff Communication Controller (CCAT)
+
+  - EEPROM Interface
+  - DMA Controller
+
+The following is not supported:
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
+        -display none
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
index e34492402f..e6fbdb663c 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -82,6 +82,7 @@ Board-specific documentation
    arm/aspeed
    arm/bananapi_m2u.rst
    arm/b-l475e-iot01a.rst
+   arm/beckhoff-cx7200
    arm/sabrelite
    arm/digic
    arm/cubieboard
-- 
2.47.3


