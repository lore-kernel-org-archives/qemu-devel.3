Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F552D1D89E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 09:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR5kr-00021I-MA; Thu, 04 Dec 2025 04:36:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vR5kE-0001Fi-ON
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 04:35:28 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vR5kA-0003Uy-K4
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 04:35:26 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6408f9cb1dcso1037864a12.3
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 01:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764840920; x=1765445720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z3TwBBdLUHAKhGiv26iGeP2UfTRRDnunnjZgIo/sg9k=;
 b=NyBNLpMn/c8E5XJkmPOZ4O+1b6aNn0sLj4Ub5c2qRxVD2QUI8ekdwHVxkSRQ53nM6w
 XX/QqJUYd9nFt76bASE8D1NwfPPcsIiPWCmzlcZzQ64RyBOWYDaEh5gAt3wiWpDmxfFF
 gYloJMVGPyX0f8C5/2SrhuAXoKdpWX2w9fpPzeSFTJTUJUaFj5oGAYqZwWd743o5KJ0s
 WBY8Wk3q4u4QjKgvqzIoGUSGKTpxWzOMCkRNLcKf+60E6VvaNXkZw7IH9lGR0MjANwuW
 shweUmbeiDr8MB825BFUwtoEO+lU7mQgoY3+JbvpGkInDPAQSLgglhBGd1HFaMjqlnDO
 vckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764840920; x=1765445720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z3TwBBdLUHAKhGiv26iGeP2UfTRRDnunnjZgIo/sg9k=;
 b=mwZYEHsmkpiD5tniJRwV46ahVU3TLdxp/SwMxzcizh7eJYBv8bL+jNAwf9G8k4SF+Y
 dMwsNHBU86LnZB5y6TW073572msTs+1o7VJdx2qd1yEEVPaLMLKuVcMznXUI1hO7cPlm
 cwFhV/GZpMqYUswMBejKA+oPy8xTachvei0d/joJZRk5tSCrfOkeSab9sFKx677lfC/p
 CaaRwGKxqGRexkgtCfBJx2n6wGzKr958z1M7a2ajk+sb19Tb0sIWE9Fy6olp89yYVSq5
 mT1ggAviDtUObc57dvaF5AfCFVv7KNp+MMcu5q8J/w6es/qFt0qPs7CdRyNct/1n/9xu
 /WEg==
X-Gm-Message-State: AOJu0Yzd17z06B2g7hO+9en/U9dP/RaoC7DDxvqfCWEjn0W+pOL/TmwQ
 /Ns2gMfFLx49utyKghVkgvupaaIFQhZHDpltqBWm9kL0QMuCqMqSPfiFeuDhIVlO
X-Gm-Gg: ASbGnct5spPwksVRi6WrL9sVzoKplJBz5Sm9crp5UIYYbZkXRrw9VCKIihx75i7VS+W
 W+G7dGd0GGoWp17U4B0s7RLtIP2NaNbwXborIf/AHs6J5WH5Fn0uWRAnGNxPiRUCduoKX9q3m5u
 a5VhnhAHzPYOc3Lp4zAoX+/FPULH3q1/jIlAVfBvWylPXu8e9WPowxiHaMCVIJv/xsS2tO8bNFb
 nAOpi/dsrR0UWaZrYn4o8pu10K/4xSpsiVf6dDPoqJmStWBL04rczWYv3jHMusrSktPeixzYkys
 JNr6lemFkOjKSutJaKSmij85+kHR8Nnh73xNRdUuOf3l9BaMW9ZHZZuq7V28AORZgAz6LCG+xey
 5dfaTvheEjAdK43Woayvc6tQ3jE8jPDeW92AKVqLNmUOm/bokxde0QaCnguHhO4guS3EN2KFjm1
 SDTZnUr1lYDACy6UplEfV+ISxyjC0n6so=
X-Google-Smtp-Source: AGHT+IFUbH+VuW2Dbg3FCQP2dHb9srcTkmh0WK3swKkSr4kJHoyBHQH0LztS0gY+Yj1ieeB8bpXmkA==
X-Received: by 2002:a05:6402:27d0:b0:640:c643:75dd with SMTP id
 4fb4d7f45d1cf-647abd98f99mr1960795a12.12.1764840920370; 
 Thu, 04 Dec 2025 01:35:20 -0800 (PST)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647b2edf72asm856573a12.11.2025.12.04.01.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 01:35:19 -0800 (PST)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH v5 15/15] docs/system/arm: Add support for Beckhoff CX7200
Date: Thu,  4 Dec 2025 10:35:02 +0100
Message-ID: <20251204093502.50582-16-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251204093502.50582-1-corvin.koehne@gmail.com>
References: <20251204093502.50582-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ed1-x52b.google.com
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


