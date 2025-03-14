Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7EE6C35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 06:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsyKy-0004kG-ET; Fri, 14 Mar 2025 02:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tsyKN-0004Rg-VP
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 02:15:28 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tsyKJ-0005Nj-4A
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 02:15:26 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-223594b3c6dso34790115ad.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 23:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741932920; x=1742537720;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PBq5rAr4J4hH2t8yEZvrT03kQi3atZwMbOmf5i2HDzE=;
 b=PS0pIuag8XyhFJppjhll2A8SB3OVs87ZqsDCXDgqHWg989ksYr13849yCMFxekN4hh
 4lEYcr1hNL2xypBKelq0FFAq1NqmJtnfVn89gszr6QvXM0DfUiGFguG05P/+OIi6VZjr
 hw7SjEtRHLaPeUOt2qXgvCOfgODbQy63Q5abZbgbNm5fxZ3Mp3Gx4m4LZZyvam6mBC+c
 rWWtcQr9g/UhuXVDEweIXGye2CEFsJ212+nWRBBSvAWe2Um+VwQuMYeINEWsnLGN8fxG
 JMRpxu2z0Y9MN7E9MOU6erTEF/jEhqmsPSjN00jUYQHvpq23u4A0ewftHA9DK4Vqu1+1
 JTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741932920; x=1742537720;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PBq5rAr4J4hH2t8yEZvrT03kQi3atZwMbOmf5i2HDzE=;
 b=rt2kliL7hRWSlzYQeT2aOketKjGKpMZ5z7FTeA6LuW+JUS8VILrc0vkNwJyHtEZI7o
 IlBviOZ008jUN78QXOl7Q64kgJyaUnAS5Ehv4X52kRvqErm69F6FE4+M+/tZUXtZmLFD
 AS3BHwdQeN/VDmK/hpC2xTskET7JU4bM9J/ZbMAkHHRsuCztgSkdfKF0Y2A7d1SHtvbB
 +SvnDBvoIBWmUI3MzpE2px8vgcmGAaLrAFxlnawv+nYQ3VBi1ymA6TD/xgFnn1dyekgP
 NSujjzGhMlhXU3erlp5WEkclz9eKhXJshyde1KMpz3J2YwfpCJIlVXW0qjRNYU71KnoV
 CH2g==
X-Gm-Message-State: AOJu0YxlMSwAb+gufY55WmmYK6GHGVUi2lTACvycXxP0gSt1+xs/T8f+
 hFvhk1bOerqjMIo1cdbWdVLDlDV+i5cXUxOOT9yGe5tJbXLOKBDtJM2eyaOnEdQ=
X-Gm-Gg: ASbGncs54tJKkVWQxT6Bt8HeZMB5iI8h0AgIvSjWOo9P9GkpFf4CNhMwWMeqE6pz/vD
 z4CoWF40zqjt/pxb5thkWjS6kEJojHEtqGAi/AK3tWf/5GMtMyrCcKTo8Y30mdJNMEAWuKUkK0K
 hcdHJ6mCO24vUFxwA/QvPca5f3kTWwiF5kuwH6QomUB6mGEZg5hGvtwZtr4vYyLKXVsX/p3wJDa
 c/wYAJLRRmF8K85c+6q40E4c73dViL9tYoGi7EpRY4ib45iAdD1XXBipzvohXh76+m6VYVzLulw
 SI/tmhsenjWDVgkqKHCjJKxoDEi6vG5uC4AjUQ8lsxn4WY7OdHs9aGgxO1c=
X-Google-Smtp-Source: AGHT+IGY8awK5IU1ZXRfAQHGnFvTiP/np+OY2FDjZQ9ywMX79L2ShTI3Hoza2TC/FZRMz6E1Y6bHdA==
X-Received: by 2002:a05:6a00:2190:b0:736:5725:59b4 with SMTP id
 d2e1a72fcca58-73722339c79mr1907742b3a.3.1741932919882; 
 Thu, 13 Mar 2025 23:15:19 -0700 (PDT)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-af56e9c94cesm2262607a12.6.2025.03.13.23.15.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 23:15:19 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 14 Mar 2025 15:14:52 +0900
Subject: [PATCH for-10.1 v9 3/9] pcie_sriov: Ensure PF and VF are mutually
 exclusive
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-sriov-v9-3-57dae8ae3ab5@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
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

A device cannot be a SR-IOV PF and a VF at the same time.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 1eb4358256de..109b2ebcccba 100644
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
     if (total_vfs &&
         (uint32_t)devfn + (uint32_t)(total_vfs - 1) * vf_stride >= PCI_DEVFN_MAX) {
         error_setg(errp, "VF addr overflows");

-- 
2.48.1


