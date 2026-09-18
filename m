Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB28C982D9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 10:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7VZp-0003MA-5a; Fri, 18 Sep 2026 06:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1x7VZj-0003KX-PM
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 06:12:12 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1x7VZh-0007bf-Hp
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 06:12:11 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e66390995so3087705e9.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 03:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789726328; x=1790331128; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+Tba0fUw+dKCG8Nc6qa/TYAA8fu11i0LHY6WGu/c/1Q=;
 b=eaZiHo/oW3HyXhvPTTiMf2Wp50UmSdCI6NDeDS44SBn7l6fULNAXBkjeYo5xXQmHJx
 MJ3j/DHTo6rZMcOht9phbEcS+8FDG+Z37nk9gh9ymMCvOL6slYMzwE+zEUSD00uHdfex
 kJyFvtH6VWB3q0/x2fI3jk6CRLLDVMTKNYBJOLv+wGtG+4uBMq+fDlQzkYTRV2OiVAE5
 ok2JlV8oSh5TUrZJXW0nf75Ncm03bmC1SjWs7grrjJwzlC/3DmIqifv8EJBXBUATedQW
 0RyaxKa7B1gzmPzNgj+dMfe4GtnrlJSFSEu2FjZnJ6Q/bYVzkcaoFw8HRCiGBkVdm6VX
 Otuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789726328; x=1790331128;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+Tba0fUw+dKCG8Nc6qa/TYAA8fu11i0LHY6WGu/c/1Q=;
 b=zNzz+apd8dP2Hpbo+9h9WfepUcRvd6Sm650yZj3lrS1lA+081txRS1nxG78pQOlWeB
 gw8spU5U8b4N5NmpAHceWMvRktMWPnvwdqYiSVkLgubYJdQgan2KfHVUcf5347mOlx5z
 dqJ0kJCg/iptiexTbiEYkEA++tt7fDQeQoovw/B4U0A8zfxxGvfDczwqminQ1JM7LIdP
 tGcZhtKSwzH3PchD5wfCyAI9pV0AzJ7FkRBZll58DN+YrgeT3/0SmprOUbTKRMc4fyZF
 a73LZ399yLaz6LwUQJ2W3MD/ncrXyhqWrucP4jbZz/I7qKcVOLy/U8H528GloMAHChvf
 V5UA==
X-Gm-Message-State: AFuF++miYOUpZP+/YxJRPv24VJDe6nVaLpqW5lYREJkHIx2SgSn8GWBI
 X3HleTKBAW1dY+QHDjaMqxdXPSv8pz66MdC30opXy3SekpHhYM4kFjg6vGmK7DqW
X-Gm-Gg: AYBFou1tanblTmYeLUgbhoF8XUxrirbyE9kzcY2AcurMRJN5eaXXxN8s4HekF7P1zt8
 fOvH78JLWMTBjuJudJeFxxQ4cT1HhxI5kBm/3sKu7ENr010TDafG4JVc8gBrXTcw3XZyD4i/Dz9
 sAgL7ufteOM0lDts/HXYzAyTXx/Go0sMk9uAGjRa7CxjsIIASyAxBlMZ+EwlDJsrmJh8gumkkUj
 /8sJzCUQ6ZWvHOqsejSY7C6kcBXdyXPrD55pHlAzQ8QvAXKdHhJvsv35FduFYTtbJGcsTkFnRnA
 oid6V9zqIf926EA/PDDzghe8NfYnoG39K9S6/UDjIgIqGjp5U8/Sg03asW2e03ypkU+h29fYeF0
 DgaooxZ94yr8+TYaEYD/bm04YPx5JC6K+u14JjXsk+ef6Eo33YyM5alxJI37tKakVMB7YqM+HBR
 05WGNTYv89lJa1x/7ElCbOe90PWA1uA6GaA+e5GKG+5vLbHo+OUQFg6hxJVjTR750IL1FSI/X4Q
 YJiddbnczn6GPOHG1afs3bVvSM8IgMZ
X-Received: by 2002:a05:600c:1993:b0:49c:ffe3:2b3f with SMTP id
 5b1f17b1804b1-49fc56dbc54mr25709875e9.3.1789726327723; 
 Fri, 18 Sep 2026 03:12:07 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com
 ([2001:9e8:dc20:5e84:de9d:56c6:df83:7819])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd225898sm153886245e9.9.2026.09.18.03.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 03:12:07 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Corvin Koehne <C.Koehne@beckhoff.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Yannick Vossen <Y.Vossen@beckhoff.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v8 7/7] docs/system/arm: Add support for Beckhoff CX7200
Date: Fri, 18 Sep 2026 12:11:58 +0200
Message-ID: <20260918101158.42101-8-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918101158.42101-1-corvin.koehne@gmail.com>
References: <20260918101158.42101-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm2-x10.google.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/beckhoff-cx7200.rst | 68 +++++++++++++++++++++++++++++
 docs/system/target-arm.rst          |  1 +
 2 files changed, 69 insertions(+)
 create mode 100644 docs/system/arm/beckhoff-cx7200.rst

diff --git a/docs/system/arm/beckhoff-cx7200.rst b/docs/system/arm/beckhoff-cx7200.rst
new file mode 100644
index 000000000000..a46fded324b3
--- /dev/null
+++ b/docs/system/arm/beckhoff-cx7200.rst
@@ -0,0 +1,68 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Beckhoff CX7200 (``beckhoff-cx7200``)
+=====================================
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
+
+- I2C
+
+Running
+"""""""
+Directly loading an ELF file to the CPU of the CX7200 to run TC/RTOS
+(based on FreeRTOS):
+
+.. code-block:: bash
+
+  $ qemu-system-arm -M beckhoff-cx7200 \
+        -device loader,file=CX7200_Zynq_Fsbl.elf \
+        -display none
+
+
+For setting the EEPROM content of the CCAT provide the following on the
+command line:
+
+.. code-block:: bash
+
+        -drive file=eeprom.bin,format=raw,id=ccat-eeprom
+
+The size of eeprom.bin must be aligned to a power of 2 and bigger than
+256 bytes.
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 260cd7e4d6b5..66d7dc43b538 100644
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


