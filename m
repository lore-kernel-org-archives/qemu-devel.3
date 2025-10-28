Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E41DCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 08:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDfLp-0004C4-9U; Tue, 28 Oct 2025 04:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vDfLm-0004B2-9y
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:46:42 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vDfLi-0006Sx-FB
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:46:41 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-34003f73a05so2623941a91.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 01:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1761641194; x=1762245994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NcmS5eSVVHZBTH578A5sV7MzSCEtEH7mlQHouzUnnQ8=;
 b=XhL/jBhPNCmAzEqMnLAjCLUejbr4KfDY757oYrZxVzlS/1L0LFfa02w42PNG1IaUNW
 a2huHAT7Ut8EGmHnO4e1M8cwUQpRT2l4ullqkqsAAA/5i+bwuQ5JnLxU/E5YYUqDf4hr
 O+ocuyRQqoCplnueJWTBuYbTvISOg/3aaV5q8KGtgXm/xdu9k27akGMLkqC+dM/kJ94M
 T9QppWEO0EVzs9KsOdN2sDFqGkJdDZWoHH1L36UEmiCsZIvyrovOdmgzF5WMQGqWiXMc
 +3GnKhyCZhlEUSQgqO0A4mauIBnOPfV1f4Mt+pBg991YPF1BXHGOI8ZaUhptXkzosfKE
 AKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761641194; x=1762245994;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NcmS5eSVVHZBTH578A5sV7MzSCEtEH7mlQHouzUnnQ8=;
 b=b+b3SXNp7LxZwTdmlK73+UYrQ4DAeLi5Xr03WMGcjtPxD7r31XQJGBSRU7pyl7wgAU
 4vgTmQOhxCyBslEW2X9FCgbIutLd0ZIxeOilq6wIirUfkZrgKKfXA6E9+0pxLzx1Hr5o
 9z2ynpT6tsZd2OPiZr+0yayjnABISTePVS6SN7eucfW/x60zSS00Auo2w8IVw/Ar29K3
 StMnhRxAadBGKdLi9wZ+WqaTIuD6VPoLWiFIuQMtoMHb2Ed8HcBHQN9cPHb2cHGl7f3C
 PwlZFdJtuDRa0W3HZ65ue2SdjdgEfMW1AX/sv2B4O9HgiL0i7D+j3FQ1J4GFpZX7QHBL
 EmLQ==
X-Gm-Message-State: AOJu0YwFRt3dBJiVv8FFDKzF+ibs3o/MXXwyWuWJRoGGjYTloWa/Uuck
 jeLvFai8g/LYI5LU1gJrGObGJp/TxNTMydOJUORO5GArJGxBrHk5463/tMH13ydUqJ7uYSc0xkv
 s29UFEM8=
X-Gm-Gg: ASbGncsGepqy6q35jEoW6Ez+LMu30ddFQbwFYCEGE4Ec0fJ2fHG3pVv0rNUXWDj/Y4I
 xGutNRCg7A8L5Pxj92kn+xFUv7DwqnhQYJHM990h6iXKvhCa4LTedFgEb6AHkGQZQfXZl0E+b9b
 AEtVeU87lK9vVdOCifP896Qg99JOo65a/FSKnyno7uj+YMOKe4e7crdEGHYmTSOhJoZl6UnpxUm
 QFEvYWJxi7XeEzsH305FjnXEKzuN0fZEdIg21onHzAGIXKg3Zf11zrv3ffWQRuVU4DRWEQvVAAM
 m3bRgVpygizafvgmq/88RKNsxMR8r8he7+8ajWh4WqdohOX4XNq9fbLTCPyG1Gh6smmtXClXaTX
 c1rSKzAdPCi2NwJvSfloT05QaN5ytORJq4Yq4ElMUy4TckCgcW249HZdDb7C959JJP+YYukp9/G
 4rj4fnwaGGaDnFB+Vzpz5nt3EHEQ==
X-Google-Smtp-Source: AGHT+IG/3xDOEkCqPLEful9dpkqv84BRHwAiR1n0BvreEcJXi0pCvJnT+DBV3hrwyuT2NkBo6IWd5w==
X-Received: by 2002:a17:90b:38cf:b0:33d:a6a6:2e26 with SMTP id
 98e67ed59e1d1-34028989872mr3220349a91.13.1761641194289; 
 Tue, 28 Oct 2025 01:46:34 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([189.38.141.22])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33fed81c8e0sm11343909a91.18.2025.10.28.01.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 01:46:33 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH] docs/specs/riscv-aia.rst: add 'riscv-aia' accel prop info
Date: Tue, 28 Oct 2025 05:46:22 -0300
Message-ID: <20251028084622.1177574-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1032.google.com
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

Add a small section talking about the 'riscv-aia' KVM setting we
implement and how it affects the provisioning of the IMSIC s-mode
in-kernel controller.

While we're at it, fix the formatting of the AIA bullet list.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 docs/specs/riscv-aia.rst | 43 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/docs/specs/riscv-aia.rst b/docs/specs/riscv-aia.rst
index 8097e2f897..f3c6ab7fcb 100644
--- a/docs/specs/riscv-aia.rst
+++ b/docs/specs/riscv-aia.rst
@@ -8,10 +8,8 @@ RISC-V machine for TCG and KVM accelerators.
 
 The support consists of two main modes:
 
-- "aia=aplic": adds one or more APLIC (Advanced Platform Level Interrupt Controller)
-  devices
-- "aia=aplic-imsic": adds one or more APLIC device and an IMSIC (Incoming MSI
-   Controller) device for each CPU
+- *aia=aplic*: adds one or more APLIC (Advanced Platform Level Interrupt Controller) devices
+- *aia=aplic-imsic*: adds one or more APLIC device and an IMSIC (Incoming MSI Controller) device for each CPU
 
 From an user standpoint, these modes will behave the same regardless of the accelerator
 used.  From a developer standpoint the accelerator settings will change what it being
@@ -81,3 +79,40 @@ we will emulate in userspace:
      - n/a
      - emul
      - in-kernel
+
+
+KVM accel option 'riscv-aia'
+----------------------------
+
+The KVM accelerator property 'riscv-aia' interacts with the "aia=aplic-imsic"
+to determine how the host KVM module will provide the in-kernel IMSIC s-mode
+controller.  The 'kernel-irqchip' setting has no impact in 'riscv-aia' given
+that any available 'kernel-irqchip' setting will always have an in-kernel
+IMSIC s-mode.  'riscv-aia' has no impact in APLIC m-mode/s-mode and
+IMSIC m-mode settings.
+
+
+.. list-table:: How 'riscv-aia' changes in-kernel IMSIC s-mode provisioning
+   :widths: 25 25 25 25
+   :header-rows: 1
+
+   * - Accel
+     - KVM riscv-aia
+     - AIA type
+     - IMSIC s-mode
+   * - kvm
+     - none
+     - aplic-imsic
+     - in-kernel, default to 'auto'
+   * - kvm
+     - auto
+     - aplic-imsic
+     - in-kernel, hwaccel if available, emul otherwise
+   * - kvm
+     - hwaccel
+     - aplic-imsic
+     - in-kernel, use IMSIC controller from guest hardware
+   * - kvm
+     - emul
+     - aplic-imsic
+     - in-kernel, IMSIC is emulated by KVM
-- 
2.51.0


