Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9894C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 06:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdlAK-0008A8-TO; Tue, 13 Aug 2024 02:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdlAF-0007gw-HY
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:37:53 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdlAC-0006Up-Sz
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:37:50 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7bcf8077742so3675161a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 23:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723531067; x=1724135867;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+42c5gGiKcfaS9Ju95w5EqxMNlhh/OqheyuSjM0gous=;
 b=GMeet9QwIcSW7CccUi4Kb2fWUW8va2TCpa0Bnavbb+F6dW3zuGu+bokZ8fsFtm53bm
 w2KZWKY8vV+Fx/hkWSPoj8x1XgWjAJuIKxu/KFk5nmBKBE4bSmApfFOSsaZiILyti7vJ
 c4ZmDVOxMZiTYXx1Q9ChPMskXBtD8KknmxHarKyUBIbDKTlJqqaY13L4NzfPb6KJe96m
 wLoIn5mIC4aZrGswWWG7EP9ET62OKpBZ3zD00c4TEFpLIYSjQPR/mdx5HZR06rlI2+Mn
 PylLnW2KpWUw5mlRZOuDs05dtx/xRNBACqkeBsUF84ypYWTVpmhHqChfzaABcIu919Mk
 YFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723531067; x=1724135867;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+42c5gGiKcfaS9Ju95w5EqxMNlhh/OqheyuSjM0gous=;
 b=Rhqxis6DAH0D6fIzEXoijQZzcutx79ehB8jqD9EgLzKTw84T24QvqefiyT1UP1EL1H
 RWDknfCLp3FybvPcjpj71gUfnJavaulKdHj1Bi0I5pljCuCq/0fROsEWqu4qPRLupZBV
 nh2Xg8PvLpobE+caVSsbsC3Epf1iDoOV3JSefSMBElCa9MJjZdbAJz2IuwIgnDIR3RDS
 JIyY8AjUZ3/VDBDVx4k9RChsB3WZhbzl1VC6XfMfMUXWA9FHLu5FRN5ABpkgg5SU2Xeq
 yv+6ZQ424TVb9/tQZRQrmB6TQx8ZmUvoTPcybcdw0gQUC3ez89A6IOYlVR0r5Sj9keZ+
 dLZQ==
X-Gm-Message-State: AOJu0YxrC0cNhbYkJ+rIFakIHtOldvg38qpQZZ9YVAQUbPhip4SMlBS8
 8ScvFrA59yuOVUit2Oyja52I9SSN84p6RJxyb6r1Y6iA3W/BkaUSLALUgl98oC0=
X-Google-Smtp-Source: AGHT+IGajeKLi0558siYbfsWxIpwxXWp2zMyvjMsCw/alMSaWIZ7QC3KtxAia44f7w4ZWqfDo6HT2g==
X-Received: by 2002:a05:6a20:2d0c:b0:1c4:a7a0:a7d4 with SMTP id
 adf61e73a8af0-1c8d74456eemr3800627637.7.1723531067336; 
 Mon, 12 Aug 2024 23:37:47 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-201cd130045sm6672135ad.50.2024.08.12.23.37.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 23:37:46 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 13 Aug 2024 15:37:07 +0900
Subject: [PATCH for-9.2 v7 8/9] docs: Document composable SR-IOV device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-sriov-v7-8-8515e3774df7@daynix.com>
References: <20240813-sriov-v7-0-8515e3774df7@daynix.com>
In-Reply-To: <20240813-sriov-v7-0-8515e3774df7@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::530;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
2.46.0


