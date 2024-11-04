Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC5AD1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84Hm-0005nG-6e; Mon, 04 Nov 2024 16:06:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Hj-0005dh-1l
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:06:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Hf-0005L3-7E
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:06:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mvlW1QwJWNe5kggYv414OUm4j2VpwLnaPYotmjUzdE0=;
 b=jAGx9GwSMsJoEgadMl7+/hr0HE+ewPONiLDU0qjtTMdQQ/lZSewndbW9bj3YTSOeicGl/8
 PtfAO0WI+eki6vYJzL++fPpivFy6ii48rq26WY3i6lhE5hYLW2xC8aWjLHfO9qNEfwbXhU
 U8Cp9oviOrIKembO+KwU1dg/BQh5o/g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-gesHf-jNM6i366OtGH7hbg-1; Mon, 04 Nov 2024 16:06:45 -0500
X-MC-Unique: gesHf-jNM6i366OtGH7hbg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d537292d7so3166616f8f.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:06:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754404; x=1731359204;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mvlW1QwJWNe5kggYv414OUm4j2VpwLnaPYotmjUzdE0=;
 b=QK/vnNKiQFDB2qqdpWzSloWcgKWXCds1iW4EfWxDGY5zo06XFuj+TTh7nvV22MzlkZ
 e0pSSstjbmHfFjJoVibx6bIbyKR/2toIEn4pi7U67n+crVkdWDmg2N1ayQxYr1+4EeoD
 XB9bSK+PQfjZoEX2wzip8BtFzZo0xaGcl/FtVr6YAvVl0JYMmA0CJsVasqtsSKscERau
 xqol9lwfF8irhiHevPH2wIvlh88fPlJ/ZMbXgo9UT3SGcuGqmmp3cHiCQZairnf6w1SU
 HQu5ktkxkzraNCTKCq/SjklvZXy9adxPWFKLlyBLtbJKhACglj3Z112ZomsMtn378EgI
 FoRQ==
X-Gm-Message-State: AOJu0YzoESRaD8q3GMcKY4apCzOoEs7yY4cIU3COTYOQN2By3ijBHDH4
 5P6ugWq31+tfbqu0Rro4198J/HKdpK5jMhl41jecNOD3+taVwLXmpAae/YraL98NXxlTa6xknbU
 NJDZihX0NnybQxbeVj/dGF2fd9PR+CNbeMSJ663ZYx6vlh/MzVc71NDPCfmF20BSmASYdShnObO
 EqZ7WoNsxNycjEGVrcz49FKBFxKcOjsg==
X-Received: by 2002:a5d:6d0f:0:b0:37d:9565:4db2 with SMTP id
 ffacd0b85a97d-381c7a469cemr15748905f8f.6.1730754403911; 
 Mon, 04 Nov 2024 13:06:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGstg4UaqKvsdNO9OWD014KkMqczeSPGWw9EyX+mw7O04nA7SsF/pefVSpUxfbyUtd8Q+x1CA==
X-Received: by 2002:a5d:6d0f:0:b0:37d:9565:4db2 with SMTP id
 ffacd0b85a97d-381c7a469cemr15748878f8f.6.1730754403453; 
 Mon, 04 Nov 2024 13:06:43 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9a99c8sm194245875e9.29.2024.11.04.13.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:06:42 -0800 (PST)
Date: Mon, 4 Nov 2024 16:06:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 18/65] hw/pcie: Provide a utility function for control of EP /
 SW USP link
Message-ID: <ea3f0ebc1a3ba380e682ea8aad38f8e8cbc0d6f7.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Whilst similar to existing PCIESlot link configuration a few registers
need to be set differently so that the downstream device presents
a 'configured' state that is then used to 'train' the upstream port
on the link.  Basically that means setting the status register to
reflect it succeeding in training up to target settings.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240916173518.1843023-5-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pcie.h |  2 ++
 hw/pci/pcie.c         | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 5eddb90976..b8d59732bc 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -141,6 +141,8 @@ void pcie_acs_reset(PCIDevice *dev);
 void pcie_ari_init(PCIDevice *dev, uint16_t offset);
 void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
 void pcie_ats_init(PCIDevice *dev, uint16_t offset, bool aligned);
+void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExpLinkWidth width,
+                               PCIExpLinkSpeed speed);
 
 void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp);
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 1ac6d89dcf..2738dbb28d 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -154,6 +154,24 @@ static void pcie_cap_fill_lnk(uint8_t *exp_cap, PCIExpLinkWidth width,
     }
 }
 
+void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExpLinkWidth width,
+                               PCIExpLinkSpeed speed)
+{
+    uint8_t *exp_cap = dev->config + dev->exp.exp_cap;
+
+    /*
+     * For an end point or USP need to set the current status as well
+     * as the capabilities.
+     */
+    pci_long_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,
+                                 PCI_EXP_LNKSTA_CLS | PCI_EXP_LNKSTA_NLW);
+    pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,
+                               QEMU_PCI_EXP_LNKSTA_NLW(width) |
+                               QEMU_PCI_EXP_LNKSTA_CLS(speed));
+
+    pcie_cap_fill_lnk(exp_cap, width, speed);
+}
+
 static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
 {
     PCIESlot *s = (PCIESlot *)object_dynamic_cast(OBJECT(dev), TYPE_PCIE_SLOT);
-- 
MST


