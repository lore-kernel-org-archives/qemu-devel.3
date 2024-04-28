Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6978BC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 09:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s10UE-0007cL-Bu; Sun, 28 Apr 2024 05:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s10UC-0007bm-JX
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 05:06:16 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s10UA-0003qj-G5
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 05:06:16 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e5aa82d1f6so29474575ad.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 02:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714295173; x=1714899973;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sosBLOLGJ/+f5xdSXkG6/l52CVTrWiRMfrUK+w7fEV4=;
 b=b1gPYdVCwmSjmZohAO6RCknrHrpx5fHTJduavSTFovE2N1Tna4Zl6HeoEDp4YYgLe9
 33n8j0RfCF3qpQEaZ24ffc3v77qvc0hiBohh2PRVQAs+69/oLRtrr1p7MnBQlCfUWMGg
 3n9u+jNgI0kWtkn451xC6e4o47hWhra1hbA7Om/PUnqqXsW+JvVn04cxf9eOow6TU+rf
 hGSakq+8K7+VZ3c/Rw1K45ghVlGDV5Y72wFrzMQzVT5JcK7hWnG003IIqKCAqfFl1nx7
 wUbQbXJxFHYJrCtVZRR+eEWta4BisnK111iPGoOUJ1LdxGbH3n6HrDADpVfPqy00e2ww
 VnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714295173; x=1714899973;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sosBLOLGJ/+f5xdSXkG6/l52CVTrWiRMfrUK+w7fEV4=;
 b=hNTxG9Lc3860DrKwZUuiGU8989Zx3BuTZq+0JawfpEEmXMUtAISKO7UGjbD/avOetk
 uWcQKyswzgqxE3VmgH6lNOJ7xwoGSVwH09UAf1UqGmjkcU5OiRJHVOi9zud/KdCH4TBH
 W4gStsrre7ydnFg93vwUqnIXkV34fVVLManm6aJnksjPANP6X3GSbWUkuyPwB36Nuxkf
 ImBkFdtUceIQUtPXdy0KD0ineHc7vivr+rcr/eGaQ+DRUWYn5uG8pJV4kUcnEuzEVAIq
 0ZpTMopFAq2j23nuxdEMVS1gFFZN8HgHXzQLwLpwDN+m74XmdQwu1kaWk68ZIL0y6Kwm
 IFeQ==
X-Gm-Message-State: AOJu0YydGFS4xUDLvXOHDqltX+LSq9/OiiFq286ezkjCbE4JnHzx+xxd
 BjaV9vQXathNQWZX9k+DESkrkvIYJbKDOsTVaaDTJde2JIuAWN4yGMDVdnZY1Rs=
X-Google-Smtp-Source: AGHT+IHHC91YYorDAzbjDdrw6L2Lv3mm10pUM6/aiGMKfwQc3vsLWSumfdrldzuI0yjLPzWmLZIT6A==
X-Received: by 2002:a17:903:2312:b0:1ea:964f:9b0b with SMTP id
 d18-20020a170903231200b001ea964f9b0bmr6554933plh.5.1714295173086; 
 Sun, 28 Apr 2024 02:06:13 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 bf5-20020a170902b90500b001e7b82f33eesm18171672plb.291.2024.04.28.02.06.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 02:06:12 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 28 Apr 2024 18:05:43 +0900
Subject: [PATCH RFC v4 3/7] pcie_sriov: Ensure PF and VF are mutually exclusive
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-sriov-v4-3-ac8ac6212982@daynix.com>
References: <20240428-sriov-v4-0-ac8ac6212982@daynix.com>
In-Reply-To: <20240428-sriov-v4-0-ac8ac6212982@daynix.com>
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
X-Mailer: b4 0.14-dev-a718f
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
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

A device cannot be a SR-IOV PF and a VF at the same time.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 56523ab4e833..ec8fc0757b92 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -42,6 +42,11 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
+    if (pci_is_vf(dev)) {
+        error_setg(errp, "a device cannot be a SR-IOV PF and a VF at the same time");
+        return false;
+    }
+
     if (total_vfs) {
         uint16_t ari_cap = pcie_find_capability(dev, PCI_EXT_CAP_ID_ARI);
         uint16_t first_vf_devfn = dev->devfn + vf_offset;

-- 
2.44.0


