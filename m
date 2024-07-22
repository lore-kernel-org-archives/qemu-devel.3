Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EC0C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgkf-00072j-2x; Sun, 21 Jul 2024 20:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkc-0006pD-2D
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgka-0005pN-Kb
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YsjbOlvo43JAEesCygimaYMAVGDqCDgHnftdBHHCG1k=;
 b=Jame7BYmofqLV6GV69L3RedE6CjHhulOVvdR0wgaIkjyO8qqM+mOicf3X3kZJg4lrAW15k
 LiOEBk7BJfuO05vCX0Ibln2chn4a99fT50IwtPjbFMW3bixnIMUEwTFo1S1C29i6fbHzD5
 hEk0xTVwmCcACRYZAVBO9httV8+swdg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-f4JoZPfWN3KzAKWpCl5yVA-1; Sun, 21 Jul 2024 20:17:58 -0400
X-MC-Unique: f4JoZPfWN3KzAKWpCl5yVA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-367962f0cb0so2112121f8f.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607477; x=1722212277;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YsjbOlvo43JAEesCygimaYMAVGDqCDgHnftdBHHCG1k=;
 b=aoYUySKaNmm5iVLyApRTbTwE1R+YSShC9RpyUxZIzaZ1fLstjZ2xbL8T4oMSUOersn
 H+cqxCZ6XNcVmIctBrq4/oChZ0e5VfdtS69dLsZTZrvsqZD+vOVZmD2W/APxT+IqPD/y
 GZzn8Mn2w3gXWkaCA0xGucFm+VazXWSnTDJVsc6OLEOr3LtLeQ+ugJ/Q9zXLTyFHvG0b
 3NgVJ6mglgLclIiWEPoa2VOlFiVBsvftz3rA/FCPendYDqPj8LzlsNfFaVA2MagYURyP
 YfGQokysYKegIGzFwdWcS8nKc+9hLNUlTiXVzzW2809KOwQBIPofZvYqpe/dWygE5u/R
 0EFg==
X-Gm-Message-State: AOJu0Yw/9RIcryC5m34GZFwYr0pP3z53wZoHLUcFb2osvBalfD4VZwy2
 gBhoG6PAOEZrP/JZ1K8aHMljgvHU+J47mjT2/zhjQFSN/CUdn90XjpJ0FocEW9vxUNjlRwcoH73
 pDJqW41u50A7nKDF557K47hslCAY8qPXAGBE0mielY/sx/+YzaUV29h35/arGThWk8XH6Pg6Rg7
 5s1VkP1IYwg/wCo0ZCbSLiTAViGz2L5Q==
X-Received: by 2002:a5d:6d08:0:b0:367:8fc3:a25b with SMTP id
 ffacd0b85a97d-369bae6adcdmr3890739f8f.42.1721607476970; 
 Sun, 21 Jul 2024 17:17:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp9fc8vx9XKKXRF9DrIWuQQZ1Rq8vZati0wdVvpF80Fnjy8lhkZuVDG8DEWdOFP6jNLoipXA==
X-Received: by 2002:a5d:6d08:0:b0:367:8fc3:a25b with SMTP id
 ffacd0b85a97d-369bae6adcdmr3890723f8f.42.1721607476204; 
 Sun, 21 Jul 2024 17:17:56 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ceda0sm7006837f8f.87.2024.07.21.17.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:17:55 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:17:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 31/63] pcie_sriov: Ensure PF and VF are mutually exclusive
Message-ID: <22c343dd303098c9ae2e19363b3571aedb383052.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

A device cannot be a SR-IOV PF and a VF at the same time.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240715-sriov-v5-3-3f5539093ffc@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie_sriov.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 56523ab4e8..6c79658b4c 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -42,6 +42,11 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
+    if (pci_is_vf(dev)) {
+        error_setg(errp, "a device cannot be both an SR-IOV PF and a VF");
+        return false;
+    }
+
     if (total_vfs) {
         uint16_t ari_cap = pcie_find_capability(dev, PCI_EXT_CAP_ID_ARI);
         uint16_t first_vf_devfn = dev->devfn + vf_offset;
-- 
MST


