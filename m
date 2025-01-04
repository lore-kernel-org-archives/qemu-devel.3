Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528EEE77199
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 08:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTz7E-0004NP-Tq; Sat, 04 Jan 2025 03:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTz6j-0003ot-S2
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 03:02:10 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTz6h-0006ix-NE
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 03:02:05 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2166022c5caso159893335ad.2
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2025 00:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735977719; x=1736582519;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=urRn/q5yC0SUy3lJXp0X0hOtR2WXLfh8pzdTuyPYr0Q=;
 b=S0uO3pFTsjQRIHOeZjWJhC1IVkRVqqEJ2kBZVY4wP/S8FqRQN1pHsGWsl4tWFsAnl2
 Crcyl2i7+3sBiRty78dBzd/iINCLYoi5tgV9i6v5Pj6AY7Xgf80pgHmKYaIR/myWtk1S
 of46MN5k1tRk0Cp9RdFQwl7EiFlmdN1bdO8cNGHoVnDN2NMUvLS7PGxTDLd5bny4lDcw
 dZVMRz0LnqDMFqtNoWUGF04bGUHgKJ3vvNGIkPup9emXVIAS2LsOZHeMyDN8u3R1tckU
 kI5gQmvjOIpBg3Ib9+ruCo+4xpkvpSfW1DCeKy2bvixyxxJWQ5BIKXVJ5IGzFfB5nDhh
 4RXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735977719; x=1736582519;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=urRn/q5yC0SUy3lJXp0X0hOtR2WXLfh8pzdTuyPYr0Q=;
 b=rM11cY6dkzGCr0iEFz3UktI+mzxexMS9rEqpzAXRsCy1Qk1pbaCm69TIeOl9GnldEk
 cwvjvBzjrd2k56Jihl3vofPPwWg5izgF1Fzxj9AoMGByEXIi+UvRZ/ipJKsR9KYa+/zT
 Wd8EJpD9LKLq4UsWpkk070FCF/fPFN7Vd7a0Y/QUQBOz7o7jBAh622gsKaoCYVUwQEqd
 mEiYQ2DEgdh7Audk0CA4X7iTKp7yyyLCldN8ven8zE9fIG/2DiIAd9BF1ewoAL2ZAzGm
 InYZ3eo/LgQMRlfiGQKxmadbFU861LSNexEZ8bC066S7JuMjuc5FjL+JT4VPCA+/Ho0B
 R6VQ==
X-Gm-Message-State: AOJu0YwXp0zB4x/p85SmX8nyc5NpgUoUaPy3cug8KNd0T4HdGValEBX/
 uozIsFa5wGutMizkd+bbJ8BoA5E6jf3KkhO44FbnpF7OgQsGKPxojtNYeY0kW/A=
X-Gm-Gg: ASbGncvkdetduHOJF6euvFBG+cmFyNakqvc+PhD18s+X4jwGado8zRf/lXQOfoTLIPX
 VVR0x3fs1dXSPlxHUIZjjIVFdywZNbVmIQKyBZOauOK80XdTBmwpu9DNpHUBlLnZPtqJoa/Jg/D
 YXk1ujbcsZHUpkxQGSs4gANelTLq9Th+2xxfkreKJc4kxK83heVUuJR2G5aiBXjA+jweJvwAVOl
 oEoq1ocXRDTYokP6BNYE3+q/OukWh3aToyC1tXtYv+F9uKJ3LzZJSjJEozK
X-Google-Smtp-Source: AGHT+IFzqH3FwxnV0+2gacVSJBofHG086EFQkXM1PAAyZWgyzEmRMm8ot1fnJK6bWc3WYY1YQsj0Og==
X-Received: by 2002:a17:902:db05:b0:216:725c:a11a with SMTP id
 d9443c01a7336-219e6e8c9ccmr655314325ad.10.1735977718995; 
 Sat, 04 Jan 2025 00:01:58 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-219dc9cddf2sm256588875ad.166.2025.01.04.00.01.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jan 2025 00:01:58 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 17:01:01 +0900
Subject: [PATCH v8 8/9] docs: Document composable SR-IOV device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-sriov-v8-8-56144cfdc7d9@daynix.com>
References: <20250104-sriov-v8-0-56144cfdc7d9@daynix.com>
In-Reply-To: <20250104-sriov-v8-0-56144cfdc7d9@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 MAINTAINERS           |  1 +
 docs/system/index.rst |  1 +
 docs/system/sriov.rst | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38a290e9c2ce..b0821a17c4fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2006,6 +2006,7 @@ F: hw/pci-bridge/*
 F: qapi/pci.json
 F: docs/pci*
 F: docs/specs/*pci*
+F: docs/system/sriov.rst
 
 PCIE DOE
 M: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
diff --git a/docs/system/index.rst b/docs/system/index.rst
index c21065e51932..718e9d3c56bb 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -39,3 +39,4 @@ or Hypervisor.Framework.
    multi-process
    confidential-guest-support
    vm-templating
+   sriov
diff --git a/docs/system/sriov.rst b/docs/system/sriov.rst
new file mode 100644
index 000000000000..a851a66a4b8b
--- /dev/null
+++ b/docs/system/sriov.rst
@@ -0,0 +1,36 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Compsable SR-IOV device
+=======================
+
+SR-IOV (Single Root I/O Virtualization) is an optional extended capability of a
+PCI Express device. It allows a single physical function (PF) to appear as
+multiple virtual functions (VFs) for the main purpose of eliminating software
+overhead in I/O from virtual machines.
+
+There are devices with predefined SR-IOV configurations, but it is also possible
+to compose an SR-IOV device yourself. Composing an SR-IOV device is currently
+only supported by virtio-net-pci.
+
+Users can configure an SR-IOV-capable virtio-net device by adding
+virtio-net-pci functions to a bus. Below is a command line example:
+
+.. code-block:: shell
+
+    -netdev user,id=n -netdev user,id=o
+    -netdev user,id=p -netdev user,id=q
+    -device pcie-root-port,id=b
+    -device virtio-net-pci,bus=b,addr=0x0.0x3,netdev=q,sriov-pf=f
+    -device virtio-net-pci,bus=b,addr=0x0.0x2,netdev=p,sriov-pf=f
+    -device virtio-net-pci,bus=b,addr=0x0.0x1,netdev=o,sriov-pf=f
+    -device virtio-net-pci,bus=b,addr=0x0.0x0,netdev=n,id=f
+
+The VFs specify the paired PF with ``sriov-pf`` property. The PF must be
+added after all VFs. It is the user's responsibility to ensure that VFs have
+function numbers larger than one of the PF, and that the function numbers
+have a consistent stride.
+
+You may also need to perform additional steps to activate the SR-IOV feature on
+your guest. For Linux, refer to [1]_.
+
+.. [1] https://docs.kernel.org/PCI/pci-iov-howto.html

-- 
2.47.1


