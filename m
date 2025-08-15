Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17F4CA0EE6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 09:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umqJe-0003hO-UN; Fri, 15 Aug 2025 05:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1umqJa-0003fj-3q; Fri, 15 Aug 2025 05:01:34 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1umqJW-0005tH-OU; Fri, 15 Aug 2025 05:01:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45a1b00f23eso9588175e9.0; 
 Fri, 15 Aug 2025 02:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755248488; x=1755853288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j7zFtEhof/fPqe84pHFWwYVCgkcZBxKurmwcEoc0vuc=;
 b=bx47Qn/bdlt6aRmpxew4RT9bNxjl0K2rbwCNk5qR40jexgStdKBXFjd3AGiCme50kb
 8XwebJh0nqWNpHXp1G8ZcknC3xRZteM+a82Pkmoh4iXNyfGU2SsFQQ8pFDD9nKWfkxhg
 IJeKF1By17ivNz4zQZZzXcygOnCnBT3weFE/EcZn4Hj4/bKowwzKYP7eqt5jv62TVnl9
 U+TJgX6/4oXsp5z7+R6Zhm6q5yiTB39RhW1DcDKf71UdoxZhOEg9LYRW4v18KTZdb1Kq
 Ht2O0IznnaWXMFJWwnLhGBPY3WfFIrawBw2K/RQ/P9Wf7brg1FZ+j47UqwezcLjvdgkq
 X/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755248488; x=1755853288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j7zFtEhof/fPqe84pHFWwYVCgkcZBxKurmwcEoc0vuc=;
 b=lzgANx+DsDFDGwFYBAcWEVTMHsw8LoDHjU8QW25NamkOby3PvQYHlhADLfwmhfssBV
 MfGtTQnlFlSWRqJD48byQckXa6fRWv6l5pVvdD5jqUQ1koE4deZxCCIOYz879IngcOWp
 CW1/rR/JKF1De9aS/Qvj4dZEw9XGHb4b7AklXqYu89dlwTi6STHHlomDV9E1kbAa/hZf
 oMKmufl0Q0+cWNfWvJUzVOrT9A6itrFBRSmz0tSgn3mBuRT2qfAcMqwhVfqD9hR3lAFc
 twwrGenmqn+26monlD8kZFSXi8mlLO5HNzZkugZClg292p2USgQRPKUDUfxzGJuYMT5I
 Wq8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCURVJHUIVerVNGCv+uqnFL53oONDUJ6D4RQxBDTAPKOVLz+tt4hmf9EWmV7mZQ4gYHw8vyXZa/JDA==@nongnu.org,
 AJvYcCXGVhM4Ja92+zqO14r+bRVIe1Ro23H0gINhYTG3ssq1c4Cum0EuUltANURyGS/Kz/KZM9FJ9QvO6y0w9Q==@nongnu.org
X-Gm-Message-State: AOJu0YzAYUjcQxF0TMv738AB3TlW7pC4o55ExJYXGvgIJQNlOihWjovB
 zGcJQN6c4uZGH+kQ1VP2RJ2PJ05j5gV5GHUNmp9zYa6Oi2xQ7PEALIWb3OeC4fKC
X-Gm-Gg: ASbGncskx3EjAllWJVpFlhsUFG4FnnxzOWV7HL7NViMUbdL61TG5FK3a+csGUldb7Hy
 pFtjFf8tmrX+M0fdQm52Z/zTsyjqbP+so3rbGuyNpeHoRou8AJXXtaGfwXLuxvtj83YjlgnHFxJ
 XTuLHxX7vcUb3u604619CfUmIkEGvQPjNUXyYlKxKgLvV3lbmZ2bpMIJcfJ2udxbvBqWAEXJ1ZN
 NhmCT8RjArRLAVfAPThbe75l4rocUXtuXwIbeeonga1pHHb7ooDmjiH4QyLVi2gkrpY3FvbRZJh
 2gv3vhDgsAEHPwv6/9lXlevADFK2gQZGaDjw6uXzO5pJsRnudt5nfZKd3eC4+udSL+nik1oEM8c
 b/ThbXFlxj9YkP7khz93Y2/A5UMTJCgvcLzFA1YHbDbomOQ==
X-Google-Smtp-Source: AGHT+IE4Jgcuark9gRpiwE8pT6VOcNRt7Y/o8+QXDU9hksn3F3doUvts2+wZltjSu3Bf3CPeeeEm6g==
X-Received: by 2002:a05:600c:354b:b0:456:eb9:5236 with SMTP id
 5b1f17b1804b1-45a21808b2bmr13975715e9.15.1755248487602; 
 Fri, 15 Aug 2025 02:01:27 -0700 (PDT)
Received: from corvink-nb.beckhoff.com
 ([2001:9e8:dc31:6500:43b3:5eac:8d91:b512])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a22321a54sm10964045e9.18.2025.08.15.02.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 02:01:27 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 qemu-arm@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH v2 14/14] docs/system/arm: Add support for Beckhoff CX7200
Date: Fri, 15 Aug 2025 11:01:12 +0200
Message-ID: <20250815090113.141641-15-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815090113.141641-1-corvin.koehne@gmail.com>
References: <20250815090113.141641-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm1-x32e.google.com
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

Signed-off-by: Yannick Voßen <y.vossen@beckhoff.com>
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
index 9aaa9c414c..db7707725d 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -106,6 +106,7 @@ Board-specific documentation
    arm/xlnx-versal-virt
    arm/xlnx-zynq
    arm/xlnx-zcu102
+   arm/beckhoff-cx7200
 
 Emulated CPU architecture support
 =================================
-- 
2.50.1


