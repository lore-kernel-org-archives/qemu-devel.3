Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F19EC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 06:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twEus-0001rz-2y; Sun, 23 Mar 2025 02:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hemanshu.khilari.foss@gmail.com>)
 id 1twEuq-0001rf-QK; Sun, 23 Mar 2025 02:34:36 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hemanshu.khilari.foss@gmail.com>)
 id 1twEup-0000TQ-5s; Sun, 23 Mar 2025 02:34:36 -0400
Received: by mail-pj1-x1042.google.com with SMTP id
 98e67ed59e1d1-2ff85fec403so9063287a91.1; 
 Sat, 22 Mar 2025 23:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742711672; x=1743316472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WwqhSpGVpYgAHl7lNT8uSfGBwD38nmoAMNw86OtCg9g=;
 b=BgRs6nOW8Fw9q8pkGPG7UIEsjaXt0SsBevUzt2g5IuRDFra2pJROO4QY9CkJcRFpki
 jNzcN9kIj6t+T6xSq3BVlLUK9nYQMz47qOK+gdLk2yFuzCILaOoqbJiRPs2T13cl/d8e
 aeCRoD6F3GtqcgVbcsibNPx0Bj4j+w1sIuVQDM/naHZUPhZv/set7ELUsEoHtvJdieHq
 bohLqrT0Mcf0mSyB2Hp+Ha9VZBq4q883f+uxsM08qhI08e0N0Kqcja5JPAuRgzwwC9v3
 AUOGKCYyHzLCIStk+/S2zCrxUHwEvmiS70pO+V7ghgV2rsw/M51DOwfmAXen+4mL2npp
 d8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742711672; x=1743316472;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WwqhSpGVpYgAHl7lNT8uSfGBwD38nmoAMNw86OtCg9g=;
 b=ktu4RFQ6ADmItPycdo9CMY6X5gLDWBPCvEst23lQ24Bxtcks3jZ0i63ccRR5mv6UZk
 5jjJpTUGVLQ0PC+8jKhJKWYKCjxS5XuiGgyCgNZhtYI3pcaqa1m3ZK2W1iOki1vAqr30
 jBC+wim+RC5E7wiDsVZ5YnGSSHH+lVOKqaGobALWBaP2InZZpH2LS5kJoiwNkZUZIPiP
 NcprhIkSro2N/ZtUM/Fp4UNaUB996QhQPGOColxtd+P13C80sx9P+6sCy3D0+hAiW/5i
 KiUgDjriAXkAqGGzppMDKxnQQ41iQMfyu/d5Wje/hfCVMu1D7w531hfWgSDOQFl81OKt
 Fsbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgd7mGjx3Zok05oM10VyQjt6kMt+AHTRQkh0k7UuqKs2FtR9khWlPm9sYGvXE8mD3i1IUHMcsjOLv9@nongnu.org
X-Gm-Message-State: AOJu0Ywned+f3VhdrKbx9pFuC9isk96D1Odn6Rkd33Z6lXE5qXFEnMBc
 aWaBtejB9EOTSbGiu9fm4OmVoXxMpRxz3+rHqQJ4kQbhOL3KhtKM6r56JHtt/dI=
X-Gm-Gg: ASbGncvEuiMLRcUvcIAF/z7oa1bYwxxFiLwbyQxQ7DTTVBL3OnEJZhvW8H/TJrO2zLI
 z3+kM/7c5az9UVks1sSTgZIbeYzek5eLi65TQQU5Ix8ooioNoKsR45uWVf626MhZyc14n+ulKlr
 8Teb9OEzfY+3HF1O0DI3EWXDwjJx+WtxXNhYEK6uc88b17QZXHwJojSLOuBrFxCOU5i7AqmP/c3
 1HJPZu3kH/9vmQsb49uvHO6HmaqaE2POUio4v2bTzVLmTID4v9x48ritBL2nLFasw0TLhE31Rcp
 d9MLmvOYtCTR4b0VXWCZoFXneRFY3ExOdxn93eCdPpw8/h2m8XmJOv0/bt4OiYX9p4zwEpW0/Q=
 =
X-Google-Smtp-Source: AGHT+IF75habzKvnlrTfzjXbcAEEKspTjnUcAGOV0zqlweaAwSBRtbWeOBTt7N5eQlB8nCvBw4qBSg==
X-Received: by 2002:a17:90b:2551:b0:2ee:9661:eafb with SMTP id
 98e67ed59e1d1-3030f38e57dmr14853447a91.12.1742711672387; 
 Sat, 22 Mar 2025 23:34:32 -0700 (PDT)
Received: from localhost.localdomain ([160.202.36.194])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf635fc2sm9347937a91.46.2025.03.22.23.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Mar 2025 23:34:31 -0700 (PDT)
From: "hemanshu.khilari.foss" <hemanshu.khilari.foss@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com, qemu-riscv@nongnu.org,
 "hemanshu.khilari.foss" <hemanshu.khilari.foss@gmail.com>
Subject: [PATCH v3] docs/specs/riscv-iommu: Fixed broken link to external risv
 iommu document
Date: Sun, 23 Mar 2025 12:04:00 +0530
Message-ID: <20250323063404.13206-1-hemanshu.khilari.foss@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=hemanshu.khilari.foss@gmail.com; helo=mail-pj1-x1042.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The links to riscv iommu specification document are incorrect. This patch
updates all the said link to point to correct location.

Cc: qemu-riscv@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2808
Signed-off-by: hemanshu.khilari.foss <hemanshu.khilari.foss@gmail.com>
---
 docs/specs/riscv-iommu.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/specs/riscv-iommu.rst b/docs/specs/riscv-iommu.rst
index 000c7e1f57..991d376fdc 100644
--- a/docs/specs/riscv-iommu.rst
+++ b/docs/specs/riscv-iommu.rst
@@ -4,7 +4,7 @@ RISC-V IOMMU support for RISC-V machines
 ========================================
 
 QEMU implements a RISC-V IOMMU emulation based on the RISC-V IOMMU spec
-version 1.0 `iommu1.0`_.
+version 1.0 `iommu1.0.0`_.
 
 The emulation includes a PCI reference device (riscv-iommu-pci) and a platform
 bus device (riscv-iommu-sys) that QEMU RISC-V boards can use.  The 'virt'
@@ -14,7 +14,7 @@ riscv-iommu-pci reference device
 --------------------------------
 
 This device implements the RISC-V IOMMU emulation as recommended by the section
-"Integrating an IOMMU as a PCIe device" of `iommu1.0`_: a PCI device with base
+"Integrating an IOMMU as a PCIe device" of `iommu1.0.0`_: a PCI device with base
 class 08h, sub-class 06h and programming interface 00h.
 
 As a reference device it doesn't implement anything outside of the specification,
@@ -109,7 +109,7 @@ riscv-iommu options:
 - "s-stage": enabled
 - "g-stage": enabled
 
-.. _iommu1.0: https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv-iommu.pdf
+.. _iommu1.0.0: https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0.0/riscv-iommu.pdf
 
 .. _linux-v8: https://lore.kernel.org/linux-riscv/cover.1718388908.git.tjeznach@rivosinc.com/
 
-- 
2.42.0


