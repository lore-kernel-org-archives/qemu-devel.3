Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7F2E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 06:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVm5A-0002bW-Hf; Thu, 09 Jan 2025 01:31:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVm52-00024X-Fl
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:31:45 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVm4z-0003qc-Cd
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:31:43 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ef8c012913so750462a91.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 22:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736404299; x=1737009099;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G+grDXHur9J/jwUY9QwZbIqXsMTDER7ge0BcGnvjEE8=;
 b=iRK/mkGO14PPNfA4GFerbawxDUL26PYn1NZmK6kTzZdpnb/UoAhUpnR/GDUMspXeWW
 bNtSb6cpsIIUzXBqSQKNeqwVYnCRA12g4bk/OuC/0BBzxnFZPkgld6EBT+A5JSXJ8Xzq
 Vvz8q/6PK2VdhALYyrcz2z6tNN+k0h/HeGFFI3YqVK34tmrs33OrYFbyeOC4prlaVQOP
 tepWVDlhhc6uGCQzGhjedYWVtvIdd8YbOBTUfVHFA47iQ5gqaQoLnJBQNbhZsdGbg3L4
 TcBIcstbWpMMvA9WUF+9yBZuJ3GWVlC2XPZBFW4xO62/LlAvAEBMOnLuG/rRpjadKbsD
 QR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736404299; x=1737009099;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G+grDXHur9J/jwUY9QwZbIqXsMTDER7ge0BcGnvjEE8=;
 b=KYkTF9XF4ZuNpibfW47k4rEIrqodoMI61dk6E50U/rcxuSTEQOEDsiNJMLzvupQpJK
 p4JA1ZDRflQG+O5Q7IFSx1QjKsWbgqBdHTciyadhOOEhrlp299kbD8u5f7JQdyOR9qXN
 /GRBwwWs0qIUGyvLOJl7PdzXfy7HFHXbuz7XPX+vhINvs+/XMPqh/hjOXGxXg52+iAli
 FprufYOu2FRywE/M49x5y/a0OgopN4FvEctyZ3fwIazlvhCpKjwVHXvburFi1mLmIsTE
 IXIp92OFtjINtHY+VeT3zaOwLUdEc5wEPIoKoolQkObE7scRIKmtBjJn6yE3un3SS26x
 +MQA==
X-Gm-Message-State: AOJu0Yx1A4P08bkHOMT4PwZNZfIzHgy1Kas8WwNdZK2wsNwfmW3O0y79
 3hgE0Sk2NE4lqk5h5M2dlwl0qizR8gYDZZw8JSU3F07cVOQm/FAZ4u1owTDr+5U=
X-Gm-Gg: ASbGnctLxFSAR6ZYNTPi+3DvexVDtwahNV9Wmn+v8sbgCLi3bQs5yqbSY+B7y0OwimW
 PSPS8Re2nJqjTf28okneS9aqC4YpFC1iOvTfCXrcKKZ3dWGnkEEIVZJzVrTuPXEAaajf1frFDYB
 r3hY7y413pw88S8ZNIlYYrxj1gtusVSyGXICOIicYGqR+J9wkp0XNRZq35P6NNqv+wH1oJr8Zsw
 m6PrHsCIpFGQctB5pwYH0jmqXNzXMx3y+7JSzpy+xUHWp/QiDMDF0WOYgg=
X-Google-Smtp-Source: AGHT+IHjOO/J1WqaVxsOqLKbfOSVFrp9Nn/d4UKlYzuayfzA6Yz7q1Xmso7NuD18+zXSmM51irgzqQ==
X-Received: by 2002:a17:90a:dfcc:b0:2ee:ad18:b30d with SMTP id
 98e67ed59e1d1-2f548e98f31mr7927842a91.6.1736404298989; 
 Wed, 08 Jan 2025 22:31:38 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-21a9174444esm4920035ad.81.2025.01.08.22.31.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 22:31:38 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 09 Jan 2025 15:29:57 +0900
Subject: [PATCH v19 12/14] pcie_sriov: Register VFs after migration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-reuse-v19-12-f541e82ca5f7@daynix.com>
References: <20250109-reuse-v19-0-f541e82ca5f7@daynix.com>
In-Reply-To: <20250109-reuse-v19-0-f541e82ca5f7@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

pcie_sriov doesn't have code to restore its state after migration, but
igb, which uses pcie_sriov, naively claimed its migration capability.

Add code to register VFs after migration and fix igb migration.

Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pcie_sriov.h | 2 ++
 hw/pci/pci.c                | 7 +++++++
 hw/pci/pcie_sriov.c         | 7 +++++++
 3 files changed, 16 insertions(+)

diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index 5148c5b77dd1..c5d2d318d330 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -57,6 +57,8 @@ void pcie_sriov_pf_add_sup_pgsize(PCIDevice *dev, uint16_t opt_sup_pgsize);
 void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
                              uint32_t val, int len);
 
+void pcie_sriov_pf_post_load(PCIDevice *dev);
+
 /* Reset SR/IOV */
 void pcie_sriov_pf_reset(PCIDevice *dev);
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c02562e6063f..f7445aebadbb 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -803,10 +803,17 @@ static bool migrate_is_not_pcie(void *opaque, int version_id)
     return !pci_is_express((PCIDevice *)opaque);
 }
 
+static int pci_post_load(void *opaque, int version_id)
+{
+    pcie_sriov_pf_post_load(opaque);
+    return 0;
+}
+
 const VMStateDescription vmstate_pci_device = {
     .name = "PCIDevice",
     .version_id = 2,
     .minimum_version_id = 1,
+    .post_load = pci_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_INT32_POSITIVE_LE(version_id, PCIDevice),
         VMSTATE_BUFFER_UNSAFE_INFO_TEST(config, PCIDevice,
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 69609c112e31..1eb4358256de 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -248,6 +248,13 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
     }
 }
 
+void pcie_sriov_pf_post_load(PCIDevice *dev)
+{
+    if (dev->exp.sriov_cap) {
+        register_vfs(dev);
+    }
+}
+
 
 /* Reset SR/IOV */
 void pcie_sriov_pf_reset(PCIDevice *dev)

-- 
2.47.1


