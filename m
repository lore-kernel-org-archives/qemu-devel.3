Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABA9C3DA45
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 05:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTE8V-0001K7-NL; Mon, 15 Jul 2024 01:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTE8Q-0000gJ-DL
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:20:26 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTE7y-0007Rw-8R
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:20:10 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70b07bdbfbcso3599032b3a.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 22:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721020793; x=1721625593;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZZGRu8v6oxuF32W/xrA/69BjX55/YFUQg7PXZsmlE7o=;
 b=Ak4EJU3VSqk1eCVWAUb0+PbMC+ctopGi9UG+dTE0YWMpwdVHFLnlfC2w1mSPB/muIc
 zcYrSV2TAyLC0dpFHTvAnrHbSsZbsziJfENZJ0OmMxFxmM4ecp+z16BN8gJCroJKr2bA
 02LTDoVZjqJ1J2tJ2e2baQ2ZCpR5YxNf26QRf5FoCrlgoKT1tNVqPXmaw3EBuH8PppGy
 tZdi3T8/FIkmyBolzREeptdG3LCZrVHN0s2xAlodNcE/n5mSSs4Z24H5BY/Rfs9MUPT8
 ysi8N4WOatshT/uZU6PeTDv44rL0HS0agx/tsMzjJQq0L7NiqGEXFro4WvYYYGmtiW0y
 fz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721020793; x=1721625593;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZZGRu8v6oxuF32W/xrA/69BjX55/YFUQg7PXZsmlE7o=;
 b=lGe5tmhlbV8KtefONo+v460mdQ52ZDaHPF/5UUICkKRkEXALcLGFVanOj47nhG7vCe
 l22mbbbWTV3CrWS99C+6yfHBW1LEE67VRiTyAkBM8iIixIQKaKHEKbGULWSaouhQD3z1
 ZaK5ryWdIwiE7U1Vnbw5s8Sq9h24V+rcN127hKY472eD6S7ZOFn4QH89PWr/Dp1ki69Y
 BDg+tAfm1rD5aw/c/nRBPNQGjxpE2ydHZsZX8+eozqT+SmCheHJpKr8glSrkGR9FVlHk
 Lo5EJ+5gsReT0TApIxlwgaiu4NjHUD0Ii9SjzPrt/DMZ/a3DKwqeU9ika8NISvyENwNo
 xraA==
X-Gm-Message-State: AOJu0YwlnszXhyqSTeN7arfWWEVDBoXzJW1Cx0mpqRG7Wp1XHCRRHsRY
 r7CFZilVMweJwtKrwTTK+DLC1QQ/ySgJ2s1ZL0T7NG32uBE6iAfsa0dfgX395r8=
X-Google-Smtp-Source: AGHT+IG4YjG0ntIffx9f8EzYgy5fvK5gEa4orev9+ojliP35f+0nuEj+8HiWLZO6H79kpdfZStR7vA==
X-Received: by 2002:a05:6a20:cfa9:b0:1c2:8d1b:2776 with SMTP id
 adf61e73a8af0-1c3bed16a76mr12920506637.20.1721020793302; 
 Sun, 14 Jul 2024 22:19:53 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-70b7ecd362dsm3394705b3a.215.2024.07.14.22.19.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 22:19:53 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 15 Jul 2024 14:19:09 +0900
Subject: [PATCH v5 3/8] pcie_sriov: Ensure PF and VF are mutually exclusive
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-sriov-v5-3-3f5539093ffc@daynix.com>
References: <20240715-sriov-v5-0-3f5539093ffc@daynix.com>
In-Reply-To: <20240715-sriov-v5-0-3f5539093ffc@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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
2.45.2


