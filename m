Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFCBC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDDT-0006LD-NP; Tue, 23 Jul 2024 06:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDDR-0005y9-UN
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:57:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDDQ-0001w8-6G
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pwA2VBCGiz4cO1daPjJvYeYj04ydpVIhSZo7OAfHiTw=;
 b=ieJD1E1+ynnlFiMnBL5nQNWS42FpabnMw82KHHncWK7jqjLCI4IeNqlve1h2hZaBfM90nt
 ww7o5ghOpxunDMmvA7b/PjZ7eCecaf6IXqdjYQfci+MvuiYfEfa5iqCsdn43qxVjUmTaus
 aXdlKh6y4fhgQIq5f48KpDUYjrmwIQ8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-xQ1RFnPvM_GFSOCOUo8rHQ-1; Tue, 23 Jul 2024 06:57:54 -0400
X-MC-Unique: xQ1RFnPvM_GFSOCOUo8rHQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a7a859d777aso61161266b.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732273; x=1722337073;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pwA2VBCGiz4cO1daPjJvYeYj04ydpVIhSZo7OAfHiTw=;
 b=eKqXjgFxHS2Sg9ravFEuvhPni9HL29Cw7aTGDHLEtrw8ABbQAOfvFcQjUv/gM1wu8o
 MmNcL7T0PlXJCszm/ml6F5F8sr+46/4vcRS9mkDU2GCHKZhzEVjipnuPANuKIIJjA3Mb
 KBHQdO+jZ4lonVWhdZesUF/02eRxOx8P7V0ZQ+4BVwM6LLUbAuWGkigjUH2PnufHbgSp
 0a4H3528OAQi7ifGSrxf9dGNGkoS7MU3NNYG6BBRJkWg5NnZ+6LatVgKBzCNBpxvwB4a
 oiBMm1WJqzKT7+PEgrzjzNv+BEeGOZNAiPm5VUjW6LWeYWVmYesRdGPc5IvmhmSM/v7q
 2xhA==
X-Gm-Message-State: AOJu0YxFgWTOZrrpZtgiqq+EdpAMlU6JXQbvULdPlnlCj/zZY1FxmN3v
 aM1krSxkvcRmxxHyJ79TjSpKFwx91TdAN/j1qfCYe3jkS0gg0WRyFoxxYfvwKix2mwCz+4GkaP2
 WsqXnERRP13lGqr5eykMdnuGP13StJVW+SQjS5AcVADKw4JiI3YzMGtdK6apK+dSjrZohJatyla
 KyPZY+/YebtR94oq2vhJqwx3LkkIrgcA==
X-Received: by 2002:a17:907:2d0a:b0:a72:48dd:46a4 with SMTP id
 a640c23a62f3a-a7a87ac5321mr200009066b.0.1721732272660; 
 Tue, 23 Jul 2024 03:57:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0ZLSssb5IJgCKYwhDNCmmX1MEgUG+E75g7V/qs+XbUujmENRP1OFMq/IjvKNvbOv5e0xlCQ==
X-Received: by 2002:a17:907:2d0a:b0:a72:48dd:46a4 with SMTP id
 a640c23a62f3a-a7a87ac5321mr200006166b.0.1721732272070; 
 Tue, 23 Jul 2024 03:57:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7aa439e40esm14094466b.48.2024.07.23.03.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:57:51 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:57:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v2 29/61] hw/pci: Fix SR-IOV VF number calculation
Message-ID: <ca6dd3aef8a103138c99788bcba8195d4905ddc5.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

pci_config_get_bar_addr() had a division by vf_stride. vf_stride needs
to be non-zero when there are multiple VFs, but the specification does
not prohibit to make it zero when there is only one VF.

Do not perform the division for the first VF to avoid division by zero.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240715-sriov-v5-2-3f5539093ffc@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 4c7be52951..cf2794879d 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1437,7 +1437,11 @@ static pcibus_t pci_config_get_bar_addr(PCIDevice *d, int reg,
             pci_get_word(pf->config + sriov_cap + PCI_SRIOV_VF_OFFSET);
         uint16_t vf_stride =
             pci_get_word(pf->config + sriov_cap + PCI_SRIOV_VF_STRIDE);
-        uint32_t vf_num = (d->devfn - (pf->devfn + vf_offset)) / vf_stride;
+        uint32_t vf_num = d->devfn - (pf->devfn + vf_offset);
+
+        if (vf_num) {
+            vf_num /= vf_stride;
+        }
 
         if (type & PCI_BASE_ADDRESS_MEM_TYPE_64) {
             new_addr = pci_get_quad(pf->config + bar);
-- 
MST


