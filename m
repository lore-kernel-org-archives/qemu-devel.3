Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6A0E77184
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 02:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSEq-0006EQ-6k; Thu, 19 Dec 2024 20:55:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEf-0006Ck-10
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:26 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEc-0004Qg-LZ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:24 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-728e78c4d7bso1114835b3a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659721; x=1735264521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iGnnwtesRR6qrK2pwm9E2IBrIFTqB9mxOjCMrHowRaI=;
 b=IY1R25R8TxvHGI3nt8dGUSsIvGFCO4BTWTEwRE2BiXZ0dYYijWX2nHpuHd3YYdR2Ak
 t6aSMtc62vFNBz6xYxRkag4CtV34vDjLj9EY7MZxUxkYgJAOzmDDu0qNy+womTNvh02P
 Q7Ph3ACD7Wvv1weMjf5bN74jRR3Mjve5QvNDXeMFAgcF2H9tHIKHeelrFQZc5WpgtcBW
 083jdItJt8iJ7QcSQCIsnXHsPltK2baPFyqBUGJqlAmMg+PoVKpt6G7EKs1tyQE5JNTm
 96ScQrJMajdGXyDa77ZCYHF4NhyEcFugPyDWuNLIL09+MQH8QJXnGcfOY7B9qGqzo1qd
 58vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659721; x=1735264521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iGnnwtesRR6qrK2pwm9E2IBrIFTqB9mxOjCMrHowRaI=;
 b=qZATswBF2SltYWNf3iyzol5PJC1AFsLIAS4j415YgOzUgEruIFudV31uLg6RyJ/3cH
 o9lvJrLskeUUHva7T5yCVKDc+jYKL7L0bgNUPp5C09g5Ka0HJtwvy1Q+lXMwYaAnCVW9
 7hOMjtMNJTiHwenKIHxmsSTjD8kXqDs9f1A6bEF1esApMtobr90Hwd5ZbG4c/WXTFBut
 vl4knlc3cPFEGLZMeUjAoJq3peC54hYbp0tYpFsyXD1YeYUf0WuXTgx6RePitb5xm+wd
 i52+K9hnAVwOtD+8qloH1EydRrhInxCpHxNZPnjVy+P1axCvGtNAna4zpqFPveq70wF7
 C/Zg==
X-Gm-Message-State: AOJu0Yxgi9HhH8HqWbeYSgvVhP+jenUpwD/JW2tfUl78qfcL/PeYBNNy
 I5tj0KmIGsS73aNZRODKPELLjJ24KtHP0UFCxQ/rCZmwLRZsEbfj9u3VdNvE
X-Gm-Gg: ASbGnctskwtBoJdG5pxyE4QK1DBKuq1uqXwYicRDK1ulMkemx3zd40lWycEHxgmrYXD
 7DZx//+1+yOP6djQkE97jN4kHyH41n4t6ifLFt3PUHxF1YCzopu/PLd3N2PB1WTHGh2/6a9UM3b
 +xciLBL5o5nr8DdPHuwny9aWTnB5XsiP2UFnnSLU/0LODVM8mCzQ2s0KvTmzwbt35rfHpb1foyD
 v3kc/Fd9aFbiWbVWF/v0vaOfxyffuilLIvQJEJohQk2S1hWYzB1FxgoeNIkHNCb/zyaZwZQzRMs
 MhF5VoQa3PjJk7VWVViDbr/HkD3YBuYN6RowSRaq12FqMSQNzgUa5xdhE74nIJc=
X-Google-Smtp-Source: AGHT+IE5DIGR/p6isxk0AX6aIm5TiMB4VHxxu2eQhngnZVvIwNF1PLtAFsUM04bJQ6B2E3jLQmUcIg==
X-Received: by 2002:a05:6a00:948b:b0:725:4301:ed5a with SMTP id
 d2e1a72fcca58-72abdab8856mr1458664b3a.2.1734659720964; 
 Thu, 19 Dec 2024 17:55:20 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:55:20 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 09/39] docs/specs: add riscv-iommu-sys information
Date: Fri, 20 Dec 2024 11:54:09 +1000
Message-ID: <20241220015441.317236-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241106133407.604587-8-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/specs/riscv-iommu.rst | 30 +++++++++++++++++++++++++++---
 docs/system/riscv/virt.rst | 10 ++++++++++
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/docs/specs/riscv-iommu.rst b/docs/specs/riscv-iommu.rst
index 463f4cffb6..b1538c9ead 100644
--- a/docs/specs/riscv-iommu.rst
+++ b/docs/specs/riscv-iommu.rst
@@ -6,9 +6,9 @@ RISC-V IOMMU support for RISC-V machines
 QEMU implements a RISC-V IOMMU emulation based on the RISC-V IOMMU spec
 version 1.0 `iommu1.0`_.
 
-The emulation includes a PCI reference device, riscv-iommu-pci, that QEMU
-RISC-V boards can use.  The 'virt' RISC-V machine is compatible with this
-device.
+The emulation includes a PCI reference device (riscv-iommu-pci) and a platform
+bus device (riscv-iommu-sys) that QEMU RISC-V boards can use.  The 'virt'
+RISC-V machine is compatible with both devices.
 
 riscv-iommu-pci reference device
 --------------------------------
@@ -83,6 +83,30 @@ Several options are available to control the capabilities of the device, namely:
 - "s-stage": enable s-stage support
 - "g-stage": enable g-stage support
 
+riscv-iommu-sys device
+----------------------
+
+This device implements the RISC-V IOMMU emulation as a platform bus device that
+RISC-V boards can use.
+
+For the 'virt' board the device is disabled by default.  To enable it use the
+'iommu-sys' machine option:
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 -M virt,iommu-sys=on (...)
+
+There is no options to configure the capabilities of this device in the 'virt'
+board using the QEMU command line.  The device is configured with the following
+riscv-iommu options:
+
+- "ioatc-limit": default value (2Mb)
+- "intremap": enabled
+- "ats": enabled
+- "off": on (DMA disabled)
+- "s-stage": enabled
+- "g-stage": enabled
+
 .. _iommu1.0: https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv-iommu.pdf
 
 .. _linux-v8: https://lore.kernel.org/linux-riscv/cover.1718388908.git.tjeznach@rivosinc.com/
diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index 8e9a2e4dda..537aac0340 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -94,6 +94,12 @@ command line:
 
   $ qemu-system-riscv64 -M virt -device riscv-iommu-pci (...)
 
+It also has support for the riscv-iommu-sys platform device:
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 -M virt,iommu-sys=on (...)
+
 Refer to :ref:`riscv-iommu` for more information on how the RISC-V IOMMU support
 works.
 
@@ -129,6 +135,10 @@ The following machine-specific options are supported:
   having AIA IMSIC (i.e. "aia=aplic-imsic" selected). When not specified,
   the default number of per-HART VS-level AIA IMSIC pages is 0.
 
+- iommu-sys=[on|off]
+
+  Enables the riscv-iommu-sys platform device. Defaults to 'off'.
+
 Running Linux kernel
 --------------------
 
-- 
2.47.1


