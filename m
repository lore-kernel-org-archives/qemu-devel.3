Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C2DC36013
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 06:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ty3b5-0004O8-ND; Fri, 28 Mar 2025 02:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ty3ay-0004MD-Jk; Fri, 28 Mar 2025 02:53:37 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ty3aw-0005LO-Pb; Fri, 28 Mar 2025 02:53:36 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2239c066347so43235705ad.2; 
 Thu, 27 Mar 2025 23:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743144812; x=1743749612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qmnZdWQzlLyYjTplGV7qmefZ1pbKTLM/vow/Mo7WpQ4=;
 b=eYRf2VnuNc4mP8O71Ro+bJHUbfbPdrIgNCzz91+xJ4GK2MmuHGftKbCjWubwSRJJQU
 iLHJ3TKV2VSEC50Uwcf4s13vVvDFWT8wOukTArbr/kzn5J/MCYAtj8PUGsYlq6KHEHxi
 uV/Fv8oq4UgBAFI5CEZGYZtOWHyGcRJ3mu+VCAhdrUEs5l9ZdAzh1+NQTAGE4dTZv153
 +82TA8PfwyuyFMQjJZl2LqZk6cKd4l3RyqGifaW57v3VE3vDjnXxRJ5i8feVN7S9oNzF
 wus8m7gGMthXg8C2VAm/f9SCbNlnAqv3sXgDS6Z60+6vZYEaeyA7hsIeTIx9Z2vIIB7J
 wGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743144812; x=1743749612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qmnZdWQzlLyYjTplGV7qmefZ1pbKTLM/vow/Mo7WpQ4=;
 b=oWGo429nNZSGMALMT58vzpyiJgEHN36Bohpyqjbx2h7oPtNNqK7aVhB2nM2kG+NidN
 l2If7FJa8soQxQcMpWaGKZ6ur0PccNK69UenZ5XXBSHlyb8csV2feYD0Tpc1u5wKSN6U
 FNdkpHmMV0wTgN/0yS5yFWOj++Au+wFg0DBaZuch7WnlxQ/7PAjG7ktg6vks5hz5/tGN
 BO2J9ZLw50MQWLciZTu0gZCummbtSP3MjGzcTp2HVhVveBWrqcqgT4X5Y6vQZDzjLyJF
 kG1Gfq3d9b1x6XVudLLuUjuY8g+16yKkMA63ZEPWCKVYZwWDclP18WQCoH5gwlRUM9Pp
 MY6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd7gXDyFJFtHIwKCA2KHZ6k4kY6IhXIVGz6RCIHFxEGOfDON3eFh4x+QozCwXgVaCynWQewZOiJ4U6ZFs=@nongnu.org,
 AJvYcCXHvea6N2IPEo7jpXsaeBmdCeToqWznV/LBXNQOssFrxOD8J/dSsS3WMoY9jFEo13LWOyayxyZ5UbPf@nongnu.org
X-Gm-Message-State: AOJu0Yyjwx6Bn4c8fW9r6mgrLRlrRKMR4ujcg4RYTsYRtSFhepGiqqN7
 8kdZfDaXx2LLWlpYlNcMfQ/s0CYpyy3QJSmctb5t1uPJCSvnMwVJgcCTzQ==
X-Gm-Gg: ASbGnct3oVQm9xLG7hheWfs7ymMEdTC0MH4L0VzX+zvx2ucjiRnEdPC93uO45p4k3UJ
 3AeOPzRRzqF7sjYVRxAOtfijlZZstOjX190qhjD3dMxgFoR/phiXvSzbzugDWp6xoMDQtuMuzxW
 jb13GVZZu86Ji+Mkb2ODhvOy9VRFdKGPfAAXyhfP4MSyrEyPMC7mw4leVJSPxJfHrlYF9jXcTLp
 +b8x+wzekxsiFAeT72qjBlX5LeRClMaWq2RJFh4UWdCQPbU/CiXnGA/hk5XcnNu+cxZaBBkjjhg
 Qle55c1SGSAUgBVLLdbiFGXkaCK0Ippm0y5IA6ysjI+bwvBagEPta6HAoiN6Tb/+la2J2sek6qG
 z3d5cRC6nVU1itb2HcxcPjdo/sBQK6NhOJ2RohSBLZXWMI5ZxT9o=
X-Google-Smtp-Source: AGHT+IFA3QA3i05W6JhgzB7Q+MvJSrm/M1O9HpHJLtsdcXbMACN0zS/rRBmJoUVjU953ILWmovg4+A==
X-Received: by 2002:a17:902:f644:b0:216:6901:d588 with SMTP id
 d9443c01a7336-228048ac56amr93772935ad.15.1743144812181; 
 Thu, 27 Mar 2025 23:53:32 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1cf8fesm10633025ad.110.2025.03.27.23.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 23:53:31 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 "hemanshu.khilari.foss" <hemanshu.khilari.foss@gmail.com>,
 qemu-stable@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 2/3] docs/specs/riscv-iommu: Fixed broken link to external risv
 iommu document
Date: Fri, 28 Mar 2025 16:53:17 +1000
Message-ID: <20250328065318.1990698-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250328065318.1990698-1-alistair.francis@wdc.com>
References: <20250328065318.1990698-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
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

From: "hemanshu.khilari.foss" <hemanshu.khilari.foss@gmail.com>

The links to riscv iommu specification document are incorrect. This patch
updates all the said link to point to correct location.

Cc: qemu-stable@nongnu.org
Cc: qemu-riscv@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2808
Signed-off-by: hemanshu.khilari.foss <hemanshu.khilari.foss@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250323063404.13206-1-hemanshu.khilari.foss@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.48.1


