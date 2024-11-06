Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FB0D44D5E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 13:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8gBR-0001oc-Qd; Wed, 06 Nov 2024 08:34:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t8gBL-0001lD-Gc
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:34:51 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t8gBI-0001cl-L4
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:34:46 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71e61b47c6cso5933033b3a.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 05:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730900082; x=1731504882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vd7uhK27iZe8oGBrkgQRn9OqHPo3B4lI9DZBvvRNQAw=;
 b=ED6dm29JhmItjFuKV6GGt3d82psMLkklaDgjBkidusGR0UAG76JEdfVHRm9IZss2TC
 xeDN6V57nmqtymDp2vm19ZZ+fwc+dK2bQx8jyGv+gefgFUSlMoGlcmSVKGC3E/ho3uTr
 cKCx6h6Hjqa9GUOx2B/Pbu5odwaVz6b0rWO1AjaEo5OfWpQ6YwjfCDraxNxKC9w9pjNr
 aXONisjd4QQX3AICNOvq+aYQarO+WEWBmW1PushUI1XvhmfejzeiMLBBHhWQI0+wJpSH
 dtBKLjvCYUP63LXSwneOjQBnNzVu7v2jybtBTKiMhHbsS8Kre0/eLLIU+YHy5qj3MZYA
 XiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730900082; x=1731504882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vd7uhK27iZe8oGBrkgQRn9OqHPo3B4lI9DZBvvRNQAw=;
 b=GS1cXzGrXi5dy9nBkqjveL/5/kARGknHaBE/ExkhfogI12p0hgOjkIXMYc7JTVGQVM
 pCSP4MLh7Gi9C8zxS/Wst49sCksjJtgrB0jzhM7JBfRMxdOeyIn1VhWamJC0y2dUfoS2
 wCM2GOTC1y+TNlovJV5FLyz2YGFvv8CM7/3acUkFnyjOzdpYWVfmkwFl1GVxNZjbsn6y
 SfiZjFK4+KhNojvEUowz5uaVCdzKzes7dhou/lzh/WSiqBRliHDmigl6/ThYZn0semef
 3ifrmp+B5K2s513QZDL9lOKgj8a2duAHkYkMcPeskR3kC0NMUdIo90d7L0T+QsAIekpE
 XMiw==
X-Gm-Message-State: AOJu0YwbV9OrIpwOl9Th5Cz1eOZsw7oTIGqhp0JN1VYFS99sBrVccBWF
 in72R8y7bShkOqigrGXbqToPdc9VFjsmyDRYaLaKw4gy0VjxqrMJuR5Ru1z3V1hM4lEA0Yzn2an
 e
X-Google-Smtp-Source: AGHT+IEZKfSgSVAVgJgnMiXagw99BIg7rWlohlX9ZyOP82KF7HOyFN5o02dadtm82Nn9O2VsmgZWoA==
X-Received: by 2002:a05:6a00:1303:b0:71e:4df3:b1d3 with SMTP id
 d2e1a72fcca58-72062f80b4cmr58116023b3a.4.1730900082498; 
 Wed, 06 Nov 2024 05:34:42 -0800 (PST)
Received: from grind.. ([189.79.22.174]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc2eb64esm11749765b3a.168.2024.11.06.05.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 05:34:42 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 7/7] docs/specs: add riscv-iommu-sys information
Date: Wed,  6 Nov 2024 10:34:07 -0300
Message-ID: <20241106133407.604587-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241106133407.604587-1-dbarboza@ventanamicro.com>
References: <20241106133407.604587-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x435.google.com
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

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
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
2.45.2


