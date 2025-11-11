Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0622DCCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 18:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vItAQ-0000Bl-8r; Tue, 11 Nov 2025 13:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vIt8W-0006gO-3q
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 13:30:41 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vIt8S-0007xA-JT
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 13:30:34 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-343774bd9b4so34581a91.2
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 10:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762885830; x=1763490630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rtwyPP7veGakivKkZ5RT11DzhVP7xIaN1NJCE3YY26c=;
 b=OqwInSKdHm3Z0JIt5O7Lz+Y85AJW3L1QR/4HRNz5GRMRTM4Br4hQfhRduozzijquYo
 IU1eWxVQQnTQYp9a3a80xhJb9sXFzx0sSB9JTvUzwFKx/mpDb6HoR0cMc9FQbBaHDolD
 ei3u1t+h8jjTIvnhGuUc6P/TcKDxr2Ndk9aawUDvydv8LWLHhR2ETc/NrJ78QReWJ3bv
 7s/kZZ2QY3dzYo957APmEcdzQU0cincoVcrDaiRat8HxQiHv+SR6F+65+MjD4pmtYMI1
 zFfxb4Utku4aM2Zuq60NaWLf+5Jaox7PJ7Jwls/CCVJAwQAlnGTPr/60zrIEkMOqepV6
 Zr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762885830; x=1763490630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rtwyPP7veGakivKkZ5RT11DzhVP7xIaN1NJCE3YY26c=;
 b=HHNDpmsQJ4SSgwD7qCLHpk5//hxTP5s1bn082PYup/q2lJKEfrnJ4a4QqS5DOeiH78
 GYF9261Nwr/9l86oMiClDhFM3qdrGUEssSQO+KI/E0VlkTEt/plMORc+SJ5kPgrEs2F2
 qCvkTMePs1KIFq1cKMGsXV7fp1B05oiTk5tVCwoKwdXexfYNrwE297+fVtUhlX5SBlNh
 3+5fIXDQylV9yuqJVP+pBCsC45GaS2AwWzJ2lGMu7X5cOnUXzRsD2LyVMQV0CQ0kOVGo
 NVp/SM2WDrsDhSaqbyRxFOMrLOQrdAxTKe9DF3VqjeYmnYmJuA7i9iW56O+NZWJqUJQW
 UQ6A==
X-Gm-Message-State: AOJu0YyZeTLDH+3Xv4mSUYxVjiFDLWnlgwU5IihX1Aeov5biee+lJLzE
 tQmN3+ag0ELbJj6U7w2W5D1sUH7DLbZ1soanv6XJcSIQI2cro8RWbf/AXFlgi1Ure1tT7Sgs8b/
 vcRTvorg=
X-Gm-Gg: ASbGncva5UTzA/q+ajPvNbVwSZXHdrQVcaoDWowxBdxlUV9QF4Nta/xvAGYvWZSAF1b
 20S5cTwYee50iTYBM5uP6sDcgKRVkfMUzqjw2cdwIsAjomUMHQDHruQGwxGvVH3PrSlrceF3bYf
 ITeTVrp2y6ipM4+s/fa2XE85Ef+Nn2hqx/cAkRThtymbBm9e9/cD/ppFjJlcixSI9Y2hC9eO9AL
 QO6onMktCH125CwKmUw2bUxU9g84ndgPt6PeraE0QHCp2vLmCXxf1xNNnhXT8fBGc8DfJQwxTmG
 EWrvQgpMukXLaobTgbkcFj0Z05jTONP5NAUOQLi4k/QO4VV4uWohC1ydWSq/75avXvpfXzJQLX3
 nhNJKTQ99T992czrL3s6I1R1ZWYnLRuKCeufPjjd88FX8sCGcFm4FEQUd6luAqkaAkwgbGPtlEk
 AQfNdoTyHWpDE5n6GIPHG8bedv0oU=
X-Google-Smtp-Source: AGHT+IGLxd2arqkC7GOAX6hXmU8L63K9XsVIo/gsSdPGKgIXkDrrxyjvnersYW22odnfr5V4hBrVjg==
X-Received: by 2002:a17:90b:554d:b0:341:c964:125b with SMTP id
 98e67ed59e1d1-343ddec54e9mr292955a91.31.1762885830250; 
 Tue, 11 Nov 2025 10:30:30 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([179.93.21.233])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3434c2ffdecsm15207419a91.2.2025.11.11.10.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 10:30:29 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 5/5] docs: add rvsp-ref.rst
Date: Tue, 11 Nov 2025 15:29:44 -0300
Message-ID: <20251111182944.2895892-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111182944.2895892-1-dbarboza@ventanamicro.com>
References: <20251111182944.2895892-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102e.google.com
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

Add documentation on the new experimental board rvsp-ref.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 docs/system/riscv/rvsp-ref.rst | 28 ++++++++++++++++++++++++++++
 docs/system/target-riscv.rst   |  1 +
 2 files changed, 29 insertions(+)
 create mode 100644 docs/system/riscv/rvsp-ref.rst

diff --git a/docs/system/riscv/rvsp-ref.rst b/docs/system/riscv/rvsp-ref.rst
new file mode 100644
index 0000000000..3889fce413
--- /dev/null
+++ b/docs/system/riscv/rvsp-ref.rst
@@ -0,0 +1,28 @@
+Experimental RISC-V Server Platform Reference board (``rvsp-ref``)
+==================================================================
+
+The RISC-V Server Platform specification `spec`_ defines a standardized
+set of hardware and software capabilities that portable system software,
+such as OS and hypervisors, can rely on being present in a RISC-V server
+platform. This machine aims to emulate this specification, providing
+an environment for firmware/OS development and testing.
+
+The main features included in rvsp-ref are:
+
+*  a new CPU type rvsp-ref CPU for server platform compliance
+* AIA
+* PCIe AHCI
+* PCIe NIC
+* No virtio mmio bus
+* No fw_cfg device
+* No ACPI table
+* Minimal device tree nodes
+
+The board is being provisioned as *experimental* because QEMU isn't
+100% compliant with the specification at this moment - we do not have
+support for the mandatory 'sdext' extension. The existence of the board
+is beneficial to the development of the ecossystem around the specification,
+so we're choosing the make the board available even in an incomplete state.
+When 'sdext' is implemented we'll remove the 'experimental' tag from it.
+
+.. _spec: https://github.com/riscv-non-isa/riscv-server-platform
diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 89b2cb732c..2ed337c8cf 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -72,6 +72,7 @@ undocumented; you can get a complete list by running
    riscv/sifive_u
    riscv/virt
    riscv/xiangshan-kunminghu
+   riscv/rvsp-ref
 
 RISC-V CPU firmware
 -------------------
-- 
2.51.1


