Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC682C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 09:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhQdn-0003wH-P8; Tue, 05 Mar 2024 03:59:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhQdm-0003vg-N8
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:59:14 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhQdl-0003hJ-8b
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:59:14 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dcd0431f00so33538405ad.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 00:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709629152; x=1710233952;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uGqy4+tpzaC83CNC1aw1LjIzpM4137yW+W5QGCQBPRk=;
 b=j127QpBNBCgfYeC3nsMHZWRkVw4DptAbdkJGov/QLP0YlLEewzqCmwlwcssrPb4TK+
 /x6lF9eb63xd8YPUzUACLs30p4i3NvqLpAV7KXAc205FcVeumpKcOyD7f7mtYmqImbwW
 kFLocOvPRa1Pc6ioStBzYk2Hj41mJgEHGdaS6jSixEYNFYg50IF/EzlMcvw+qm3Q8lf+
 ya2xboT7oLApmdZqAAc7AfpRzGjvN0xdHMkNt6lqYHRlyIhQAxpgcO7pErzkDbjyEX5u
 8ftzX6AvWN+eFzUytcKxlrHhXNbdRkmo8SQRBx+tR2y7k8aWgz++jsY81CcaITxKiI7S
 LGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709629152; x=1710233952;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uGqy4+tpzaC83CNC1aw1LjIzpM4137yW+W5QGCQBPRk=;
 b=tkMsJh91CBlPPQbvlpS+ifR6EFW8zmhg+XfoUAXD0lyn44iQLdRG9FUSXpIbqzq8Ln
 P0uSf9OeteY/HBmfl+UT+DIYrdt7YkitjIp/lG9jgE4AKEjiqGczafap7BV0cKXXLLFf
 cKlBnV56Vw3XIAsPDAoJsirGDRessPwQJQFPK/Xt+bzSjF19wOVnAsO9pnfvrWgfb0uk
 gz5pPuw5aJle+zO5KFM1r1diXufxJ7c7C7zGDEFHADfajVCovvR08nLBzAm50u/PO40v
 +1K8RJApubKhfV4U6yOzlusu3pOodCgwN9jCjtd4jq4IssZBXif5VTFmh4lZboBq4ZnU
 BHtw==
X-Gm-Message-State: AOJu0Yzg915dVZ+BJ6u2iiPjWwf0FAuELX1FXagGlkFYMTDOrYpZNzn5
 NYUZMJEqp0UJFiLMXaO1aJp+A8Aopr/YijDBeDE6zRUu30RKofjHhP+l0/luRjA=
X-Google-Smtp-Source: AGHT+IHYu3yhFha2jQeP0Ol9JLt8XPNY/+sA3Utq973I+kYxbtDCsEVPsBK+sIycXUYU3g9KV1KM/A==
X-Received: by 2002:a17:902:cf0c:b0:1dc:cba3:f909 with SMTP id
 i12-20020a170902cf0c00b001dccba3f909mr1327907plg.54.1709629151901; 
 Tue, 05 Mar 2024 00:59:11 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 q3-20020a170902a3c300b001dbcb39dd7dsm10091529plb.125.2024.03.05.00.59.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 00:59:11 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 05 Mar 2024 17:58:50 +0900
Subject: [PATCH RFC v3 3/6] pcie_sriov: Check PCI Express for SR-IOV PF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-sriov-v3-3-abdb75770372@daynix.com>
References: <20240305-sriov-v3-0-abdb75770372@daynix.com>
In-Reply-To: <20240305-sriov-v3-0-abdb75770372@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 20240228-reuse-v8-0-282660281e60@daynix.com, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
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

SR-IOV requires PCI Express.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index aac12e70f122..c449ddd0ac39 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -41,6 +41,11 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
+    if (!pci_is_express(dev)) {
+        error_setg(errp, "PCI Express is required for SR-IOV PF");
+        return false;
+    }
+
     if (pci_is_vf(dev)) {
         error_setg(errp, "a device cannot be a SR-IOV PF and a VF at the same time");
         return false;

-- 
2.44.0


