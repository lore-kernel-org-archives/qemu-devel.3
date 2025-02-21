Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5DDC021B5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS4X-0006tu-DU; Fri, 21 Feb 2025 07:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4V-0006lU-GQ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:23:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4T-000783-QP
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:23:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cvBWmFUXdZkhnxIEnnyEww3jMhD10rJHEduWob1P8ko=;
 b=FeCZlR4ZTVhbT3x/wsXY4BB8NHwuqTn/HtX34BX2E3LtFNBxdzZU0lpmYKz0hugs6btrds
 GLfvZCwidl3d8p+a91g8DbxrWQ08sO6VaJgVYHDqOLDCyArTMO07g8hujcMpWTNiBu1n/z
 VXxH3DKrNi9n4aGYhKrQYELwlk//TOg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-ZvWvn7_aOqmdbfvw94YhIA-1; Fri, 21 Feb 2025 07:23:54 -0500
X-MC-Unique: ZvWvn7_aOqmdbfvw94YhIA-1
X-Mimecast-MFC-AGG-ID: ZvWvn7_aOqmdbfvw94YhIA_1740140633
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4394b8bd4e1so10341555e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:23:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140633; x=1740745433;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cvBWmFUXdZkhnxIEnnyEww3jMhD10rJHEduWob1P8ko=;
 b=udLBdeQk5dERLfZC3JQWfJRNIanG3t4eXaAAO+KZk57Cby2k+Wo93U2DjvCW4r6gtj
 5WyNVQ/wTEWyjCcSW5DLeR+jHVyPpjuNl9dj2Z+rLqEzY8GUN642nEMSi1vpYqmL2KGC
 CAR0VuPVHTvCIvOJwM8PwkBO6mFjCxho87pNt/ilM36S0b3kS/KJG/rE9kr8OAmpS1DZ
 Z+Tx5ZydYJVctYyphDfeQtsMKrAWbCgu51PQ6BNIMZyY6hHrC1pNHkQGXRJsGtqATOAM
 b2w3XnPW8p3F+DHUtMxEKqoOEBJqvtBoSwAg0EDFzuoX16yF4ucQtYvQsfWMz3PPK3DN
 Blug==
X-Gm-Message-State: AOJu0Ywmd2BeOeo/816nLErp4lm9YviuB6FlPttGAlZJmnfwWsgcntA9
 We3ChJuAEmh/HJPwlY0RwBuseuP1/070BzOlkym4CVSNxafRBg+vvReJuP6xVitTT+4VqovguRn
 9xHysDsRK0Vx9rsUmGTOWdjiczegGrzc4/gSPsLpM2vJErcPfNng2YDmtJ7YZepEBrCMiybEdnZ
 tmj8VivLQtj1BEaHVPyYclCguhjZ8acA==
X-Gm-Gg: ASbGnctxYsT4DeURFeGTpYDLWiGwYXQHgGw71/3yjZPjgK0C6o85lZAaRDSfC+zGiYg
 KTXgv3rB8KtZeVD3q7qM5iOC9zlGZ1CMRmdx0lPBHIsi3RPPP57nqcrw6OPUeJulyXPK+HXpBQP
 maDRSH1xxWAcweMF4nRm2nVhx2cNKlbtAZTstz3pfgB/PYdFSdZnwUkxQPwcBE8/SwSJOpDlaSS
 jlSTLEuyrpYpk+cYEhMr5Zx6HDBAbPUS9sYVgvIWmwNWRjbRAwKxvf+dTkNR9WAi1eo+qyI+GHc
 A4AeSg==
X-Received: by 2002:a05:600c:350a:b0:439:8e3e:b0d6 with SMTP id
 5b1f17b1804b1-439aeb2ab04mr21261405e9.13.1740140632831; 
 Fri, 21 Feb 2025 04:23:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXgxX+Us+Oq4NHZZ7PokBtBmgoOeq85WQiUNg/YON7wMRdu/OuvN5CwHTRnEPaU/P996S3+A==
X-Received: by 2002:a05:600c:350a:b0:439:8e3e:b0d6 with SMTP id
 5b1f17b1804b1-439aeb2ab04mr21261225e9.13.1740140632493; 
 Fri, 21 Feb 2025 04:23:52 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02f24acsm15849555e9.21.2025.02.21.04.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:23:52 -0800 (PST)
Date: Fri, 21 Feb 2025 07:23:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li Zhijian <lizhijian@fujitsu.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fan Ni <fan.ni@samsung.com>
Subject: [PULL 23/41] hw/mem/cxl_type3: Ensure errp is set on realization
 failure
Message-ID: <d3c92cf6dcab028d05f306d4d50511aa805d2385.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Li Zhijian <lizhijian@fujitsu.com>

Simply pass the errp to its callee which will set errp if needed, to
enhance error reporting for CXL Type 3 device initialization by setting
the errp when realization functions fail.

Previously, failing to set `errp` could result in errors being overlooked,
causing the system to mistakenly treat failure scenarios as successful and
potentially leading to redundant cleanup operations in ct3_exit().

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20250203161908.145406-5-Jonathan.Cameron@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/mem/cxl_type3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index ff6861889b..d8b45f9bd1 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -891,7 +891,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
                      &ct3d->cxl_dstate.device_registers);
 
     /* MSI(-X) Initialization */
-    rc = msix_init_exclusive_bar(pci_dev, CXL_T3_MSIX_VECTOR_NR, 4, NULL);
+    rc = msix_init_exclusive_bar(pci_dev, CXL_T3_MSIX_VECTOR_NR, 4, errp);
     if (rc) {
         goto err_free_special_ops;
     }
@@ -912,7 +912,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
 
     pcie_cap_deverr_init(pci_dev);
     /* Leave a bit of room for expansion */
-    rc = pcie_aer_init(pci_dev, PCI_ERR_VER, 0x200, PCI_ERR_SIZEOF, NULL);
+    rc = pcie_aer_init(pci_dev, PCI_ERR_VER, 0x200, PCI_ERR_SIZEOF, errp);
     if (rc) {
         goto err_release_cdat;
     }
-- 
MST


