Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86121E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2ZE-00036n-Ul; Wed, 18 Dec 2024 17:30:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2ZB-00034v-Oo
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:53 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Z8-00031w-LD
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:53 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso1581475ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561043; x=1735165843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iGnnwtesRR6qrK2pwm9E2IBrIFTqB9mxOjCMrHowRaI=;
 b=S/X+B92yBLpZInAE0b3cEy5dOU2d/J8jBGovVya8TYhU1raOanSV9nSCtTqIqZE/dR
 waZVFtJyLFzctQKII0fN4w7ljpDlw8c6ZArO/0NiG4njc3YDZEyEVWFME6hHC4lV+XjT
 FEm8fsAoD8uLpApXQ56ZfxyGBVywwEHMWKzTNHraPpwdXJntS2FvNwRXk7U392qnx+uD
 nSlpfrwJzBdc17mPUuDDR2/cbj/9pHvHLDo584yXjIhuJc7jJnD6I+jkoKna0bKUQTZK
 VvshyqUF2XvY/zrueBfbK1kr6Z+Feqc2+NXUoRrDNM+uc5nc6VN/7SgJVYHGiRh7tpOL
 9shQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561043; x=1735165843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iGnnwtesRR6qrK2pwm9E2IBrIFTqB9mxOjCMrHowRaI=;
 b=H6jxOOz0sm5J1jIQfYc2coVmA1pu4eEO2oHQfOvTNxj7l3WfB1lgqT1G7T02LqPJdQ
 86TORdCOhEpehGOt4ZEUf29pHtIuBaLE/jEJBlHbif+B+S4VbGK+tr6YZ7O9TsLsP/A3
 UFArs9ijDtZ9bLxhN6XD6WUo9XKprPXKsiBj//1YBwQVoZdB6pUiGGRV4nK8O2FtO68v
 FLy+OnQcFpwEeBJfCxPvzYhg479Cw8zk67zT74Gh3Amry5jffYyZM26d0mf0dOKXM9II
 d1j1wTeV8Oq5BVnUp0hIXpj6gYl7llP9WJrYio0UFph2Qgv5aAJL8KPGeaic8G3wk2wl
 w2+w==
X-Gm-Message-State: AOJu0YwcbHgxcMM/BCQLj37Y/+o1+VpwAQgAOjl+FAMasUvTHH03VDW3
 BIkHGeOOI6x/e0oSBdV6J2UPWg1NecBFJCtGN16Itz1bscQwvsOTwe8XjgYF
X-Gm-Gg: ASbGnctV51bEz/UGSm7R2CJRaCqbFNYvUFMuZpsCqZiWQGTGy37gSRIt+n8XkMu5Iqq
 SOkcx9JytTAD6kU+Sbki7S0s6eYMPsUEffDq+uuAZO2Kn44J+AvUCduiy4lJciIhwvyBDvKquKx
 xRA5dKU+2Q8q/AlekXdVtjXdIdtMsJnqMJYd6Ic2rvWPHig0F1PRhg6EgduKCvPRazmOR48mhXf
 PUpgPTWRF5amVplK8GImuo+nDZPDlIfsfmOkFp3uskTLimNMFWmMfsruFpZmgIy8UEXMR4d+bgM
 QGU8ksKLXSVdM0MFZ4uMOkNQDjRpv56qk/4ZK7ipKdxqpaQTlN8zO6JBAmKUe6w=
X-Google-Smtp-Source: AGHT+IEOywlNJiBMzHEV4Qw/RsiFkZRKyzK8k9dSji0IEkr2e/v2itQnd8kyOKTXr4hUrc9UxXRBCA==
X-Received: by 2002:a17:902:ecd1:b0:216:3eaf:3781 with SMTP id
 d9443c01a7336-218d725a7bcmr57835405ad.43.1734561043334; 
 Wed, 18 Dec 2024 14:30:43 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:30:42 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 09/39] docs/specs: add riscv-iommu-sys information
Date: Thu, 19 Dec 2024 08:29:39 +1000
Message-ID: <20241218223010.1931245-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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


