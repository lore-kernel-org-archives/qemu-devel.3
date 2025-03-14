Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B446BC28B2F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 06:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsyL5-000553-PZ; Fri, 14 Mar 2025 02:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tsyKQ-0004Si-2O
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 02:15:32 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tsyKN-0005OB-Ue
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 02:15:29 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22403cbb47fso34150825ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 23:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741932925; x=1742537725;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yCDjOO/ynZyfiOssUp+ZtbkI9iAK3kJTcWDHc04ncl0=;
 b=aUCNg8iRbZ7OmSYp6XDBoQAAl+fG2MSyAN9MjSRss20wOYdi8BJCrmD1M8nFuu67fZ
 CILA6062P8i1Vfwb758oHkwsFM88/dvHwDeCGUKYGH7rty2q4cCDssXAl6xXsEXbcOGF
 mKxbS46cYdGDUCnR0veqqUcTqIHRFpA+gH+56sFN2TIeG3oxlgiV7GYPhT7CkuKP7Ttr
 o9Ldlh4TB7uzU/rgCgw15HHRDStvlG+w9MgurT6eI8eJYPkOmPJ61DBvocubrO1sdPXa
 aC60C9YKJso8jF9rjFkpJ6EeBAt0a8ssIqeI6KDsu/IH+aBp/HjVypI9bt0JoHQ55dhJ
 j7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741932925; x=1742537725;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yCDjOO/ynZyfiOssUp+ZtbkI9iAK3kJTcWDHc04ncl0=;
 b=rJRtX3YPfo0wEMoq/CLZ/r06nc5XuymgrBDSRu0trht5tm55rh8z13xgQmg7bULHD3
 XafVZkHqkpEgxz4wwOt/2192/omxuQCm+5xFrOxDLACMnM+QAWEkSLNC7AmyDQN29lEf
 a2obv1mM+2TT+89bgWuy8oguETwFMKg8QAuSLG/Xbn8a4SJMk21pHy9hnelc9QKmFvRB
 P5QKIAUlLihXiGV1/osSXhjGFugbiAHmEr6Po6sqKfED+yg+qJSqIC/AZ86mtkUEQL1g
 HLWudk+ZJeuUiivqfEX1WrBBIDyHyYGHkQMi5oApJuKpA37lVhcj7QamC2eBABLSD2Ze
 DKMw==
X-Gm-Message-State: AOJu0YyPyzwrHUGloq6Sp21jtoshhlq9VYfSvflqg7/Tu1sEoEL0CEXP
 ZfalkLIZ1VtFhZOX6iyI3IWa7jrZlbmJI8iIZ/fW8VSDTEu16XDiXPS/QAZbtMHtoC6YaVLv3Nd
 AyTY=
X-Gm-Gg: ASbGncsqhnaVe0G4AI4JNZYlhvUOojPoyrVYj5IwZfGqdI6kyQthEr3QGnXtAxTXlxK
 pFslApTTo0+zGBTMyaud3unbNot9F5B5pkmu9HvEMEusGmUGWY0hllXm8pHEPCRtmnVqI9+wvZ1
 9Kp1A75UywVYi+QArDLDMt9HrWtimNt9yt6s6TSSYCMzTVttFXjHPk4dF0EOayxjQ4uUjUVxLPw
 ZH/F4zvGLf/NvCq/KDLMdtD4zL1erUktFPNmcJfTz3HPMWA/8VW4XftTP0JgCpOWkgPqByyhniI
 XDOYgg2pEyYYReFvyXMK2ww4fotBbpkLQ1XG475ezV/hZPCFN/5Fc7SEpEQ=
X-Google-Smtp-Source: AGHT+IGek+mzx/grqWHgVMop1t6poUGkkk4XgknPycNrFOntZA1E1wpES5gT8YuoqPYb1llZfbc1tg==
X-Received: by 2002:a05:6a00:1411:b0:736:4b6d:82dd with SMTP id
 d2e1a72fcca58-7372233494dmr1271761b3a.2.1741932925002; 
 Thu, 13 Mar 2025 23:15:25 -0700 (PDT)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7371167d764sm2398912b3a.98.2025.03.13.23.15.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 23:15:24 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 14 Mar 2025 15:14:53 +0900
Subject: [PATCH for-10.1 v9 4/9] pcie_sriov: Check PCI Express for SR-IOV
 PF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-sriov-v9-4-57dae8ae3ab5@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
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

SR-IOV requires PCI Express.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 109b2ebcccba..a5b546abe8bb 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -42,6 +42,11 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
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
2.48.1


