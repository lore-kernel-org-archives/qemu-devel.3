Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FACACD98D6
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqCN-0006kC-Nj; Sun, 14 Jun 2026 15:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCL-0006bq-Gn
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCJ-0002Js-BN
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6jMLBQCNfZ81UJ62zLcECx5FcUb5TVLKmM166QliHoU=;
 b=BBR0//+I+EJZ09LWaj4tKKnpbTtqC1iEQThp38YVTr/aqSNfxMMuQbt3GiUkZllpYdx8BX
 iLF3oxump7zJ/cdgcxtZ/rrz4D/fvPGcc0XD1Mf5QWtftg7GxORiCzAoaxy1kIvW/8gbCh
 ACB249ddftPFfZQLHLLh5Ak00ndRmAw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-aotkIBLTPdOhHpujYrzWBg-1; Sun, 14 Jun 2026 15:08:41 -0400
X-MC-Unique: aotkIBLTPdOhHpujYrzWBg-1
X-Mimecast-MFC-AGG-ID: aotkIBLTPdOhHpujYrzWBg_1781464120
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-46016bedbaaso1800218f8f.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464120; x=1782068920; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6jMLBQCNfZ81UJ62zLcECx5FcUb5TVLKmM166QliHoU=;
 b=DX38u0fCxqrKrfAMXjd2318vJ54xxCUT5iUhLiclNyobBJHdKYmQcwn4DFDc6vEuR8
 u25bkum+komz+jETipbxLV0NH9MSy7kNZv5JersKIEuZCiat+iFeLQ30+0K2ibpkS4Hh
 LQyFAk99+loiI5/slLsUs9JZBpTjDluRK2XBZz9YDJbs86srTnSfkm6U3mAfBIquiESN
 avacLgRNuc9OL8imm2cd9TCdU6JdX+S7EU4niFqN9soYhQKSU5VYpefG3ZSOMoEjY/q3
 LYti+ZdNMyp0AbYGDiFmz7qboZBYdaGJvz1yfKCVIBVBjSD//55xOwLL9Fwc+BjrOHqz
 wpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464120; x=1782068920;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6jMLBQCNfZ81UJ62zLcECx5FcUb5TVLKmM166QliHoU=;
 b=W/p1aAHoyCzNEwyLoJueSIZycgzzgEX2KjRpVKLtZ+x1l1bWphLhwUulZMgMgOWJhE
 tdmTh1SYCydZJyj9hdmRZcyMKBrISRUQEUIV4tYIwcEh83u/3L22Tp9zofoZQYIdbsMp
 5XYN/37bWGLF3ByBYs99hUPeEHw+3ByNkw4/6FggWD37TNC2hVExXDEQFaxu576xevGs
 QR83RxWe5I0HtXwkcsF2EX7QDKgAR0y2zRPp+H5qT11/s/O+OW0tpiNCkuadoDehAY6J
 T9y9+ao4L3Xye2KyVJ6n38MlxBkzQBiZ5fvg4VLwg34H0cOY6szU72hjzOVhbZ7t9qco
 ZWjg==
X-Gm-Message-State: AOJu0YyeY+7x2ONxDCFCvjmDVClmT/YxAZej2LLWMRMzhOCjvdh00AD1
 RXbhJak09fjHhD+91lH5evqr6wQ0R3ixiK8s50rNFirNnRU2hEPCtBFKl5JWf3YNtZo4wyv7Fg/
 dESYobOQsMadhyhHLBitAZHn2HXe/yTv61xSaGc4sSjIMOAzh17qYT05ndbi7rSdoKnMwSpVidF
 PgO7OyFb1ABfw9J8cPT7wQteFtPipUzl9puw==
X-Gm-Gg: Acq92OGDqi9+JWSVH5gigW5YBhkQktPqMmSvpL37hFUQRdr1+9CSb6UnsoH8QvSIkiE
 8ged5XgHOh8TD0bxu88yC1u4BbHDnBOG8QybLMZpTF3Wfpqiebmcaz/GIsKpLrrVbb14rc/wMZa
 rRNRuid1VCoT+fYASDtq674Ax5qMrHlHbYcVkr3fhtzczsXw4H5w8XdyqHnN8PC8wfiXlRMxIFP
 DR0m6vLY2EPzh1fP45sdm/tLLhcFFGeSAfjvobLixytBcpmLRxMdNmpV5B88ElBoRPEO2j/8sFB
 dJOVvZCXUPVnsfPYoW2MG2Wegbui7ye5h5wz1tfHBbUaIv2baJPe2mSZwbpBfNVJVvISbsvrKJO
 fgwXmeB6kGpVBaTP6bDkKwI2D/RqRCc6n2cFVdmCRJxs=
X-Received: by 2002:a5d:5d02:0:b0:45e:ea46:ce11 with SMTP id
 ffacd0b85a97d-4606da6307fmr16342257f8f.14.1781464120006; 
 Sun, 14 Jun 2026 12:08:40 -0700 (PDT)
X-Received: by 2002:a5d:5d02:0:b0:45e:ea46:ce11 with SMTP id
 ffacd0b85a97d-4606da6307fmr16342222f8f.14.1781464119418; 
 Sun, 14 Jun 2026 12:08:39 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d933esm25634000f8f.33.2026.06.14.12.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:08:39 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:08:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aditya Gupta <adityag@linux.ibm.com>, Zexiang Zhang <chan9yan9@gmail.com>
Subject: [PULL 068/106] hw/pci: Replace assert with bounds check and return
Message-ID: <c7209c56718107fefd5deae140a450954d31ff2b.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Aditya Gupta <adityag@linux.ibm.com>

As reported in https://gitlab.com/qemu-project/qemu/-/work_items/3334,
callers of 'pci_host_config_{read,write}_common' can pass length as 8,
causing an assert failure

The original issue with pnv_phb3 triggering the assert was fixed in a
previous commit

Instead of asserting on invalid length, check if the length is valid
(<=4), otherwise return (with the failure error code in read)

Reported-by: Zexiang Zhang <chan9yan9@gmail.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260326190438.734239-3-adityag@linux.ibm.com>
---
 hw/pci/pci_host.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 91e3885c7f..2a7fdfa563 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -81,7 +81,12 @@ void pci_host_config_write_common(PCIDevice *pci_dev, uint32_t addr,
         return;
     }
 
-    assert(len <= 4);
+    if (len > 4) {
+        PCI_DPRINTF("%s: invalid length access: addr " HWADDR_FMT_plx " \
+            len %d val %"PRIx32"\n", __func__, addr, len, val);
+        return;
+    }
+
     /* non-zero functions are only exposed when function 0 is present,
      * allowing direct removal of unexposed functions.
      */
@@ -106,7 +111,12 @@ uint32_t pci_host_config_read_common(PCIDevice *pci_dev, uint32_t addr,
         return ~0x0;
     }
 
-    assert(len <= 4);
+    if (len > 4) {
+        PCI_DPRINTF("%s: invalid length access: addr " HWADDR_FMT_plx " \
+            len %d val %"PRIx32"\n", __func__, addr, len, val);
+        return ~0x0;
+    }
+
     /* non-zero functions are only exposed when function 0 is present,
      * allowing direct removal of unexposed functions.
      */
-- 
MST


