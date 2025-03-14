Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414ECC28B2F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 06:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsyL4-00050e-1i; Fri, 14 Mar 2025 02:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tsyKn-0004dN-Ci
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 02:16:00 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tsyKi-0005Ql-W3
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 02:15:50 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2235189adaeso32584885ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 23:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741932946; x=1742537746;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=22fCYQFZajZ8TXm+rAJSoEKggXvSpPBIabKdwyTVXv4=;
 b=aOMdHdC3NgE6vHziNOcGGFNoSREn8oBbQtRoBBBMrzA7ml+mRnsQlBTzQSu4jdaXB/
 O/9YSbxmGe5G3Z5SJLQHH/3K4q/qj+SowpJwrumN8SM67/l4KoG2umxS7XpMvssTlVg+
 lkr+cBuyC3klYNnor9ybKVMvNcZnzGi1EBKiyLBKFDT4VjzJMmbPO4m+zJ/1rBBqyGHJ
 az+xEWFFCFIm9dlSUZ22sPr2EeO2uYPykDRj6a7+FUTS3G2M7u/prvntg/l/YSd2v2a0
 TMLLBHf1RMR2E+oVdH8kD3JwkM5IdO8rRMebiH4DhD8K5SOjgJ7U8qe4a/OAgZIOQqBx
 EX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741932946; x=1742537746;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=22fCYQFZajZ8TXm+rAJSoEKggXvSpPBIabKdwyTVXv4=;
 b=ieE056YPZtjLhMutiI2AcP3kfedSEiSgLK7V4kPhmUGLhCnRfNK4DU2MInsxVUXEWx
 HUXMg+/josCBENcw2MYkmH+qs+dWWHNsioEkFZl6C9Y38kHrLAO9LEITKmKlSoD0niNt
 YNg31eUw5cxveEUq1PMbZrOB7h/nlentxKrTX5b96ZxALW3u4q63DsbRL/dVN3Zcv5yO
 johGTkI6fm76l4GsBX0rmuU6Upg8IgmuR82aIOmpf7OCk5cGgpj3wrzek9g0fJWG0QVx
 8LipH7PcAIjBRL1Jx5GXXMDTghwUsJaolrvxlKuFWG8Qf24jlsGtQCfl2h2EyTP45quM
 aETQ==
X-Gm-Message-State: AOJu0Yws+UvjUkj+d/SmnCfPmGhe7r2gpuxwDBbwL94cUjd0eahciRx8
 76WRI+tpUkp/rESOl8R6IIjCyQYq4+oMQYYa2ppGQld7IfOKG2mlFdOoTDWV2QI=
X-Gm-Gg: ASbGncs9kxL0o/DF8Uspou5ZC7qcJlnmZsGCrwb2Ujo1VqDNzRV96k9FGHvEAAsAnJk
 6LLimrJxZpuPgDXMEBTndWw+Enav3upjJdahXnqgXV6pTrMuVbHc/rnoZRxwSYMYhT8Hj2nVzSj
 bIeKREdhStSJ5iv7zx8Cb7dg+xuu27bJu6VsqCq6NerDEGU3Omks7Iw5FyHXbvRaKqfd9Q7KJ0y
 2WCB26pbxQpugT14nMr8NaAnFQu5PD1S3yiTpGOTCdCDdHXKHApD3LmvM/Oxvvs1Wzd7WjBYWSR
 CFUWUNrVgDcTJT5wl23DJ/r8agVlHPShl6x40MBh3PFNbq6l
X-Google-Smtp-Source: AGHT+IFtv/NBOn29RTeG14AinCIOW2a44zi+h1AX8Bs9ehGit81yOOwXvpbTY7z2TX2IOP0L4+6sTg==
X-Received: by 2002:a17:903:1107:b0:215:a2f4:d4ab with SMTP id
 d9443c01a7336-225e169ba5emr14043435ad.7.1741932946550; 
 Thu, 13 Mar 2025 23:15:46 -0700 (PDT)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-225c68aa62csm23339445ad.92.2025.03.13.23.15.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 23:15:46 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 14 Mar 2025 15:14:57 +0900
Subject: [PATCH for-10.1 v9 8/9] docs: Document composable SR-IOV device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-sriov-v9-8-57dae8ae3ab5@daynix.com>
References: <20250314-sriov-v9-0-57dae8ae3ab5@daynix.com>
In-Reply-To: <20250314-sriov-v9-0-57dae8ae3ab5@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
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
index 0e5db7a57449..4cde71687645 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2029,6 +2029,7 @@ F: hw/pci-bridge/*
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
2.48.1


