Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18609C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 06:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZm7w-0003SX-Rg; Fri, 02 Aug 2024 02:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZm7v-0003My-JS
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 02:50:59 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZm7t-0000zv-St
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 02:50:59 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2cb4c4de4cbso5285055a91.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 23:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722581456; x=1723186256;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C5Qkc2xHJDIrJ32DpraIz8uFeHLkPAtAdY7nT6vwWJE=;
 b=AYUeW5JQttS1UCC4MrTrlWb78TURWhHrD1cN291+9hrfSZQgldxT4UL+xq/s0GibiD
 7sLh6a445InCci+9NmUFcvjel2Z47JmIYcFnxM4Vb74xBWcvqCa8nOumE4UaTkXFY1tv
 DNrTVMPEVbxT32Usmlvc/X3lHcKvKAH1Wf8j4uAlw+y00wh0nfgbmNpNyWRTmXMTGgxn
 VdZI4k/obwWY3sltQ5K07BWcJhsKa81lfkX7OAnOOVeGnd//D+zHbdqN7kX+UtZLKcmv
 sUfFvMzWAl77l3qZ5snbjYLtu3LMoLAeX8KTnEG6SQRm1qj7ZTPKTZUdZ57qj0a0eFNR
 BYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722581456; x=1723186256;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C5Qkc2xHJDIrJ32DpraIz8uFeHLkPAtAdY7nT6vwWJE=;
 b=EATFdwlWHBGs/+L44NriEeOiok5o32t4CJFzh82cNOt3vwzfu/hhjD77xtYSUd0rN6
 gq4FDET3VCGJaifHN4MYbwGz3b869EP5mmgzsXAibAvdr6RBD8HIq+VLkQ70+lraSATp
 jpHRWElo7kh/42hckoh17ZEkE3a8HV4Rb30GhXWkvCou1W+/+MrAQCLeeIdrQq3VSO9O
 acpe+LLQXyUXjn4Z+Jog4Zn+2GI7f9rw6OT2z4OW37yrDK9kwDspMTsQvHKaFdV2EoYI
 l/MfPXwqDGajj7ufwS/E05+MC9/RJFELiSFzeRK+VvGxI3TAesVFnp76ZdIdqqF4/S3b
 MYHw==
X-Gm-Message-State: AOJu0Yy6SG2mdULsfrRs2Y3cyrhL5tR/7clkpxCdfs2fn9whoj4d4Gs4
 t+Ig85qGS5KFZusWPJ6l5TR0ZIwm65x7pPaETMVkbkeHPbpKtqiIoC+4tXdvm4g=
X-Google-Smtp-Source: AGHT+IHbP57HzdQgdOoAT09Ovx6+WonHPvuUhuDJfxkQknuIax702CuZfvqS0a4NczNyMxxYXhJA2Q==
X-Received: by 2002:a17:90a:e006:b0:2cb:6419:5b53 with SMTP id
 98e67ed59e1d1-2cff9475f78mr3375451a91.24.1722581456480; 
 Thu, 01 Aug 2024 23:50:56 -0700 (PDT)
Received: from localhost ([157.82.201.15]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2cffb38d3fcsm1018670a91.50.2024.08.01.23.50.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 23:50:56 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 02 Aug 2024 15:49:52 +0900
Subject: [PATCH for-9.2 v6 8/9] docs: Document composable SR-IOV device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-sriov-v6-8-0c8ff49c4276@daynix.com>
References: <20240802-sriov-v6-0-0c8ff49c4276@daynix.com>
In-Reply-To: <20240802-sriov-v6-0-0c8ff49c4276@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::102c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
index e34c2bd4cda2..72b3c6736088 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2011,6 +2011,7 @@ F: hw/pci-bridge/*
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
2.45.2


