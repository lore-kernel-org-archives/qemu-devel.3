Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EE8CCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 19:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCNiK-0001FI-Qb; Fri, 24 Oct 2025 15:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNiI-0001CH-I1
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:44:38 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNiF-0003Fy-9c
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:44:37 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47112edf9f7so14063535e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 12:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761335073; x=1761939873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iWqdsWphgLc+QVv88TKSvSZYRQX2C7Bxl/0CgoqZnEo=;
 b=h1zkMX3RCOSGSUPxWKuMt6S2MwGE2zOt4WkdKxriuqupjn2uQCm3syQ07GGAXOmJcs
 OrEvFkNtXqQlN/hcuHCnhX0Myz9xppbHSXk1Hw5DMD1mRPXxnnIh4otpu5iAVj67NKLL
 htQp1VA5CPRZaWfpV2pSqssr0D+FyZsJl/RuHJYYsYBruFOTH3qeU6ckdoSwC1FYuMrs
 QbHU4gLsKMOn5gFL3JR7Z/ba9v8KcJ1fkByhM+ogld3v1HbgWtqrsLrcJ7tOnrAiyKZs
 nll7HySsaOxm4dypPz6O5WS8ymTZi3m2fc6OJon2kJQncKGds7cVJoN9UX7aYHatW2Rl
 F4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761335073; x=1761939873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iWqdsWphgLc+QVv88TKSvSZYRQX2C7Bxl/0CgoqZnEo=;
 b=NoQThDrBcB9GL5pAWk1ikZ9C6cOC8JyhxOnJ6Ls6PR5UO8lXRSZH/QW1bDCuAFshma
 3XMfhxt7HU0Pp/6ftoeizYsboq1W3OE9ZbbHV0fMnRnocg82NQTEoDXqJjC2lnyi0AEQ
 4bxxMghX9BBHh+85tTR3bPWImLE7F0ztMnFV55wO/w3DGMxULpPvXZuI7iAg9xwKGJqE
 r9Tz6FHmBSoZ77jc+calEykioJbsafsJYUaSyeSeAKFUrYvh4q/1mY40jzm/S4srMZBl
 m6HGyu3XQcce+pm5vJ8kFySMO36ybLPuU14xeXYD8tIIol4ib90oqdEcsoLTpeo95FrZ
 bWJA==
X-Gm-Message-State: AOJu0YyReEd3zuSzhGwoydAQf39vAexvW43IwMataNxmxQF0TtVQsSfP
 VfYRQaRp2e3ULeTFnuq8I0IT4OuCY7A7jNcBFuCNy7TSfvARBMGVesu4fW5auuu9JgxykIutFq8
 DBoMUm/I=
X-Gm-Gg: ASbGncuB8gqm9/VaDo9m8MJwgG2p+6nHy016OvO2hPXQ8h17igXypOUx8guEbHR9XkG
 anpPsuh4WJ/E1Q8OBo4qRhDwa4GpZxCL2pDQUXBK6wpgGig2u/dUO7zWuLHW+2XlRgszKsS+wJG
 1noiN3ebU2Awxi7GSmYJfgPewMt9lGud6fVJS1dWkajxpNGm8J0C+BRRbXjTZDVzxFgFUIB5vcs
 VLsakvPsAR0Kk26zKn+3Ck4zIyIDZ5GRS9mW278GKTQidih1GDlVoV8Nl1DibsvlP6Rzalypog0
 OrEokSEczi1W5a6m4JCJ3Gp4ta7Bwmc9te7vxSd2qeqQdM65FMFAeC05uQjoRQ8UuML0pifu7b9
 VeK0phjTL7onIjAXvL+a1knyloI+3Ikaz/xtJzxp0qqZeyKUVRokra5BgPYv1z34XowWIXwTaVN
 YLwIp0vBzKA/WUI9PFlL/COSSq6guF2uQnZOnas/EHdDnDJ6pIW1boS453UxHl
X-Google-Smtp-Source: AGHT+IHlzCxSlCeSGI8jf2AUoZfXxaAhTfjIFAJDOAHu84Rp8tnT702tDBtSOcqbv63mNL4ufaoqmw==
X-Received: by 2002:a05:600c:1988:b0:46f:b43a:aeed with SMTP id
 5b1f17b1804b1-475cb0670e3mr56872135e9.40.1761335072817; 
 Fri, 24 Oct 2025 12:44:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c41cc92csm161017375e9.0.2025.10.24.12.44.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Oct 2025 12:44:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Vijai Kumar K <vijai@behindbytes.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Jason Wang <jasowang@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ran Wang <wangran@bosc.ac.cn>,
 Anup Patel <anup.patel@wdc.com>
Subject: [PATCH 26/27] hw/riscv: Include missing 'system/memory.h' header
Date: Fri, 24 Oct 2025 21:04:13 +0200
Message-ID: <20251024190416.8803-27-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024190416.8803-1-philmd@linaro.org>
References: <20251024190416.8803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

"system/memory.h" header is indirectly pulled by "hw/sysbus.h".
Include it explicitly to avoid build error when refactoring the
latter.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/char/cadence_uart.h      | 1 +
 include/hw/char/ibex_uart.h         | 1 +
 include/hw/char/shakti_uart.h       | 1 +
 include/hw/char/sifive_uart.h       | 1 +
 include/hw/gpio/sifive_gpio.h       | 1 +
 include/hw/intc/riscv_aclint.h      | 1 +
 include/hw/intc/riscv_aplic.h       | 1 +
 include/hw/intc/riscv_imsic.h       | 1 +
 include/hw/intc/sifive_plic.h       | 1 +
 include/hw/misc/mchp_pfsoc_dmc.h    | 1 +
 include/hw/misc/mchp_pfsoc_ioscb.h  | 1 +
 include/hw/misc/mchp_pfsoc_sysreg.h | 1 +
 include/hw/misc/sifive_e_aon.h      | 1 +
 include/hw/misc/sifive_e_prci.h     | 1 +
 include/hw/misc/sifive_test.h       | 1 +
 include/hw/misc/sifive_u_otp.h      | 1 +
 include/hw/misc/sifive_u_prci.h     | 1 +
 include/hw/net/cadence_gem.h        | 1 +
 include/hw/riscv/opentitan.h        | 1 +
 include/hw/riscv/shakti_c.h         | 1 +
 include/hw/riscv/sifive_e.h         | 1 +
 include/hw/riscv/xiangshan_kmh.h    | 1 +
 include/hw/rtc/goldfish_rtc.h       | 1 +
 include/hw/ssi/ibex_spi_host.h      | 1 +
 include/hw/ssi/sifive_spi.h         | 1 +
 include/hw/timer/cadence_ttc.h      | 1 +
 include/hw/timer/ibex_timer.h       | 1 +
 include/hw/timer/sifive_pwm.h       | 1 +
 28 files changed, 28 insertions(+)

diff --git a/include/hw/char/cadence_uart.h b/include/hw/char/cadence_uart.h
index e7f7cd84683..d2b48313d4e 100644
--- a/include/hw/char/cadence_uart.h
+++ b/include/hw/char/cadence_uart.h
@@ -25,6 +25,7 @@
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "qom/object.h"
+#include "system/memory.h"
 
 #define CADENCE_UART_RX_FIFO_SIZE           16
 #define CADENCE_UART_TX_FIFO_SIZE           16
diff --git a/include/hw/char/ibex_uart.h b/include/hw/char/ibex_uart.h
index 9deadf223bf..f95780063fe 100644
--- a/include/hw/char/ibex_uart.h
+++ b/include/hw/char/ibex_uart.h
@@ -29,6 +29,7 @@
 #include "chardev/char-fe.h"
 #include "qemu/timer.h"
 #include "qom/object.h"
+#include "system/memory.h"
 
 #define IBEX_UART_TX_FIFO_SIZE 16
 #define IBEX_UART_CLOCK 50000000 /* 50MHz clock */
diff --git a/include/hw/char/shakti_uart.h b/include/hw/char/shakti_uart.h
index 526c408233f..c15b5f9c82c 100644
--- a/include/hw/char/shakti_uart.h
+++ b/include/hw/char/shakti_uart.h
@@ -27,6 +27,7 @@
 
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
+#include "system/memory.h"
 
 #define SHAKTI_UART_BAUD        0x00
 #define SHAKTI_UART_TX          0x04
diff --git a/include/hw/char/sifive_uart.h b/include/hw/char/sifive_uart.h
index 0846cf62188..a46c4d12766 100644
--- a/include/hw/char/sifive_uart.h
+++ b/include/hw/char/sifive_uart.h
@@ -25,6 +25,7 @@
 #include "hw/sysbus.h"
 #include "qom/object.h"
 #include "qemu/fifo8.h"
+#include "system/memory.h"
 
 enum {
     SIFIVE_UART_TXFIFO        = 0,
diff --git a/include/hw/gpio/sifive_gpio.h b/include/hw/gpio/sifive_gpio.h
index fc53785c9d0..72e116252b7 100644
--- a/include/hw/gpio/sifive_gpio.h
+++ b/include/hw/gpio/sifive_gpio.h
@@ -16,6 +16,7 @@
 
 #include "hw/sysbus.h"
 #include "qom/object.h"
+#include "system/memory.h"
 
 #define TYPE_SIFIVE_GPIO "sifive_soc.gpio"
 typedef struct SIFIVEGPIOState SIFIVEGPIOState;
diff --git a/include/hw/intc/riscv_aclint.h b/include/hw/intc/riscv_aclint.h
index 4b7406eec00..07e562fd6c1 100644
--- a/include/hw/intc/riscv_aclint.h
+++ b/include/hw/intc/riscv_aclint.h
@@ -22,6 +22,7 @@
 #define HW_RISCV_ACLINT_H
 
 #include "hw/sysbus.h"
+#include "system/memory.h"
 
 #define TYPE_RISCV_ACLINT_MTIMER "riscv.aclint.mtimer"
 
diff --git a/include/hw/intc/riscv_aplic.h b/include/hw/intc/riscv_aplic.h
index 489b9133c26..86bbe0cf859 100644
--- a/include/hw/intc/riscv_aplic.h
+++ b/include/hw/intc/riscv_aplic.h
@@ -23,6 +23,7 @@
 #include "qom/object.h"
 
 #define TYPE_RISCV_APLIC "riscv.aplic"
+#include "system/memory.h"
 
 typedef struct RISCVAPLICState RISCVAPLICState;
 DECLARE_INSTANCE_CHECKER(RISCVAPLICState, RISCV_APLIC, TYPE_RISCV_APLIC)
diff --git a/include/hw/intc/riscv_imsic.h b/include/hw/intc/riscv_imsic.h
index 58c2aaa8dc6..4b9de5eb612 100644
--- a/include/hw/intc/riscv_imsic.h
+++ b/include/hw/intc/riscv_imsic.h
@@ -21,6 +21,7 @@
 
 #include "hw/sysbus.h"
 #include "qom/object.h"
+#include "system/memory.h"
 
 #define TYPE_RISCV_IMSIC "riscv.imsic"
 
diff --git a/include/hw/intc/sifive_plic.h b/include/hw/intc/sifive_plic.h
index d3f45ec2481..85524711da4 100644
--- a/include/hw/intc/sifive_plic.h
+++ b/include/hw/intc/sifive_plic.h
@@ -23,6 +23,7 @@
 
 #include "hw/sysbus.h"
 #include "qom/object.h"
+#include "system/memory.h"
 
 #define TYPE_SIFIVE_PLIC "riscv.sifive.plic"
 
diff --git a/include/hw/misc/mchp_pfsoc_dmc.h b/include/hw/misc/mchp_pfsoc_dmc.h
index 3bc1581e0f2..d3bc38a8ddd 100644
--- a/include/hw/misc/mchp_pfsoc_dmc.h
+++ b/include/hw/misc/mchp_pfsoc_dmc.h
@@ -24,6 +24,7 @@
 #define MCHP_PFSOC_DMC_H
 
 #include "hw/sysbus.h"
+#include "system/memory.h"
 
 /* DDR SGMII PHY module */
 
diff --git a/include/hw/misc/mchp_pfsoc_ioscb.h b/include/hw/misc/mchp_pfsoc_ioscb.h
index 3fd3e749665..276e2a1c533 100644
--- a/include/hw/misc/mchp_pfsoc_ioscb.h
+++ b/include/hw/misc/mchp_pfsoc_ioscb.h
@@ -24,6 +24,7 @@
 #define MCHP_PFSOC_IOSCB_H
 
 #include "hw/sysbus.h"
+#include "system/memory.h"
 
 typedef struct MchpPfSoCIoscbState {
     SysBusDevice parent;
diff --git a/include/hw/misc/mchp_pfsoc_sysreg.h b/include/hw/misc/mchp_pfsoc_sysreg.h
index c2232bd28d0..29ea39fe5c0 100644
--- a/include/hw/misc/mchp_pfsoc_sysreg.h
+++ b/include/hw/misc/mchp_pfsoc_sysreg.h
@@ -24,6 +24,7 @@
 #define MCHP_PFSOC_SYSREG_H
 
 #include "hw/sysbus.h"
+#include "system/memory.h"
 
 #define MCHP_PFSOC_SYSREG_REG_SIZE  0x2000
 
diff --git a/include/hw/misc/sifive_e_aon.h b/include/hw/misc/sifive_e_aon.h
index 2ae1c4139ca..77351e2ef84 100644
--- a/include/hw/misc/sifive_e_aon.h
+++ b/include/hw/misc/sifive_e_aon.h
@@ -21,6 +21,7 @@
 
 #include "hw/sysbus.h"
 #include "qom/object.h"
+#include "system/memory.h"
 
 #define TYPE_SIFIVE_E_AON "riscv.sifive.e.aon"
 OBJECT_DECLARE_SIMPLE_TYPE(SiFiveEAONState, SIFIVE_E_AON)
diff --git a/include/hw/misc/sifive_e_prci.h b/include/hw/misc/sifive_e_prci.h
index 6aa949e910d..adf9bd6da7e 100644
--- a/include/hw/misc/sifive_e_prci.h
+++ b/include/hw/misc/sifive_e_prci.h
@@ -20,6 +20,7 @@
 #define HW_SIFIVE_E_PRCI_H
 
 #include "hw/sysbus.h"
+#include "system/memory.h"
 
 enum {
     SIFIVE_E_PRCI_HFROSCCFG = 0x0,
diff --git a/include/hw/misc/sifive_test.h b/include/hw/misc/sifive_test.h
index 88a38d00c59..a995b397f66 100644
--- a/include/hw/misc/sifive_test.h
+++ b/include/hw/misc/sifive_test.h
@@ -21,6 +21,7 @@
 
 #include "hw/sysbus.h"
 #include "qom/object.h"
+#include "system/memory.h"
 
 #define TYPE_SIFIVE_TEST "riscv.sifive.test"
 
diff --git a/include/hw/misc/sifive_u_otp.h b/include/hw/misc/sifive_u_otp.h
index 170d2148f25..99e9c0b6bcf 100644
--- a/include/hw/misc/sifive_u_otp.h
+++ b/include/hw/misc/sifive_u_otp.h
@@ -20,6 +20,7 @@
 #define HW_SIFIVE_U_OTP_H
 
 #include "hw/sysbus.h"
+#include "system/memory.h"
 
 #define SIFIVE_U_OTP_PA         0x00
 #define SIFIVE_U_OTP_PAIO       0x04
diff --git a/include/hw/misc/sifive_u_prci.h b/include/hw/misc/sifive_u_prci.h
index 4d2491ad46d..07dce36055b 100644
--- a/include/hw/misc/sifive_u_prci.h
+++ b/include/hw/misc/sifive_u_prci.h
@@ -20,6 +20,7 @@
 #define HW_SIFIVE_U_PRCI_H
 
 #include "hw/sysbus.h"
+#include "system/memory.h"
 
 #define SIFIVE_U_PRCI_HFXOSCCFG     0x00
 #define SIFIVE_U_PRCI_COREPLLCFG0   0x04
diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
index e63941f18fc..5057ec42032 100644
--- a/include/hw/net/cadence_gem.h
+++ b/include/hw/net/cadence_gem.h
@@ -31,6 +31,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(CadenceGEMState, CADENCE_GEM)
 
 #include "net/net.h"
 #include "hw/sysbus.h"
+#include "system/memory.h"
 
 #define CADENCE_GEM_MAXREG        (0x00000800 / 4) /* Last valid GEM address */
 
diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan.h
index 609473d07b4..39fc92c9d69 100644
--- a/include/hw/riscv/opentitan.h
+++ b/include/hw/riscv/opentitan.h
@@ -26,6 +26,7 @@
 #include "hw/ssi/ibex_spi_host.h"
 #include "hw/boards.h"
 #include "qom/object.h"
+#include "system/memory.h"
 
 #define TYPE_RISCV_IBEX_SOC "riscv.lowrisc.ibex.soc"
 OBJECT_DECLARE_SIMPLE_TYPE(LowRISCIbexSoCState, RISCV_IBEX_SOC)
diff --git a/include/hw/riscv/shakti_c.h b/include/hw/riscv/shakti_c.h
index 539fe1156de..7bed56be91c 100644
--- a/include/hw/riscv/shakti_c.h
+++ b/include/hw/riscv/shakti_c.h
@@ -22,6 +22,7 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/boards.h"
 #include "hw/char/shakti_uart.h"
+#include "system/memory.h"
 
 #define TYPE_RISCV_SHAKTI_SOC "riscv.shakti.cclass.soc"
 #define RISCV_SHAKTI_SOC(obj) \
diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
index 31180a680e6..3f547b0acdc 100644
--- a/include/hw/riscv/sifive_e.h
+++ b/include/hw/riscv/sifive_e.h
@@ -24,6 +24,7 @@
 #include "hw/gpio/sifive_gpio.h"
 #include "hw/misc/sifive_e_aon.h"
 #include "hw/boards.h"
+#include "system/memory.h"
 
 #define TYPE_RISCV_E_SOC "riscv.sifive.e.soc"
 #define RISCV_E_SOC(obj) \
diff --git a/include/hw/riscv/xiangshan_kmh.h b/include/hw/riscv/xiangshan_kmh.h
index c5dc6b1a9a7..5c7bc3a06ee 100644
--- a/include/hw/riscv/xiangshan_kmh.h
+++ b/include/hw/riscv/xiangshan_kmh.h
@@ -12,6 +12,7 @@
 
 #include "hw/boards.h"
 #include "hw/riscv/riscv_hart.h"
+#include "system/memory.h"
 
 #define XIANGSHAN_KMH_MAX_CPUS 16
 
diff --git a/include/hw/rtc/goldfish_rtc.h b/include/hw/rtc/goldfish_rtc.h
index 162be338636..357fbea4203 100644
--- a/include/hw/rtc/goldfish_rtc.h
+++ b/include/hw/rtc/goldfish_rtc.h
@@ -24,6 +24,7 @@
 
 #include "hw/sysbus.h"
 #include "qom/object.h"
+#include "system/memory.h"
 
 #define TYPE_GOLDFISH_RTC "goldfish_rtc"
 OBJECT_DECLARE_SIMPLE_TYPE(GoldfishRTCState, GOLDFISH_RTC)
diff --git a/include/hw/ssi/ibex_spi_host.h b/include/hw/ssi/ibex_spi_host.h
index 5bd5557b9a1..d2abeb916e2 100644
--- a/include/hw/ssi/ibex_spi_host.h
+++ b/include/hw/ssi/ibex_spi_host.h
@@ -32,6 +32,7 @@
 #include "qemu/fifo8.h"
 #include "qom/object.h"
 #include "qemu/timer.h"
+#include "system/memory.h"
 
 #define TYPE_IBEX_SPI_HOST "ibex-spi"
 #define IBEX_SPI_HOST(obj) \
diff --git a/include/hw/ssi/sifive_spi.h b/include/hw/ssi/sifive_spi.h
index d0c40cdb11b..0b1bc86e540 100644
--- a/include/hw/ssi/sifive_spi.h
+++ b/include/hw/ssi/sifive_spi.h
@@ -24,6 +24,7 @@
 
 #include "qemu/fifo8.h"
 #include "hw/sysbus.h"
+#include "system/memory.h"
 
 #define SIFIVE_SPI_REG_NUM  (0x78 / 4)
 
diff --git a/include/hw/timer/cadence_ttc.h b/include/hw/timer/cadence_ttc.h
index e1251383f2a..0640bc54ca0 100644
--- a/include/hw/timer/cadence_ttc.h
+++ b/include/hw/timer/cadence_ttc.h
@@ -20,6 +20,7 @@
 
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
+#include "system/memory.h"
 
 typedef struct {
     QEMUTimer *timer;
diff --git a/include/hw/timer/ibex_timer.h b/include/hw/timer/ibex_timer.h
index 41f5c82a920..9e58079e391 100644
--- a/include/hw/timer/ibex_timer.h
+++ b/include/hw/timer/ibex_timer.h
@@ -26,6 +26,7 @@
 #define HW_IBEX_TIMER_H
 
 #include "hw/sysbus.h"
+#include "system/memory.h"
 
 #define TYPE_IBEX_TIMER "ibex-timer"
 OBJECT_DECLARE_SIMPLE_TYPE(IbexTimerState, IBEX_TIMER)
diff --git a/include/hw/timer/sifive_pwm.h b/include/hw/timer/sifive_pwm.h
index 6a8cf7b29e4..bc68cca8efc 100644
--- a/include/hw/timer/sifive_pwm.h
+++ b/include/hw/timer/sifive_pwm.h
@@ -30,6 +30,7 @@
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 #include "qom/object.h"
+#include "system/memory.h"
 
 #define TYPE_SIFIVE_PWM "sifive-pwm"
 
-- 
2.51.0


