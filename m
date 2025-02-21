Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6DEC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS5d-0003Ty-Bl; Fri, 21 Feb 2025 07:25:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS5Z-0003Gd-7F
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:25:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS5X-0007Gh-5Y
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=21MZvzcuowvqSXzQXl2K9YuO6KQY2fQmr4euw2anaeY=;
 b=PGfHx/39Br2NMlMKIG+sgtoVldWf7YSZRqdo9R8cv97PzesBmx8kVXv3ZS0oA/o1UTdBVP
 hNOnlbLVbSKm/YW8YU66+lPoqn93fnwXitiwq+T36NsWHM9sgoxxVkTQ+ycf3fO1cr+A5L
 59SGnpFlpo0+t6FJaMNbHgu1QEo6y/c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-PytxyZotMneRmvC2W6923Q-1; Fri, 21 Feb 2025 07:23:48 -0500
X-MC-Unique: PytxyZotMneRmvC2W6923Q-1
X-Mimecast-MFC-AGG-ID: PytxyZotMneRmvC2W6923Q_1740140627
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f32ac838cso1775796f8f.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:23:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140626; x=1740745426;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=21MZvzcuowvqSXzQXl2K9YuO6KQY2fQmr4euw2anaeY=;
 b=EXf0dmXGq5d1RWBtPk3TqbCTJVTIsaJMZ0c5Fn7Cj0nAXtHFQ1EgjCfPF9qe2HDVOF
 PivIf8l9tF7fphsSz7KREnyNpAyTPa018m9jT8rjiOODGp1G/KKhzqr8D1iqoOmbO6RK
 QpTUI3x1qh8NpuVAsEwAYUEsyXkYjJOsHOqn1gSag0P5t5remXLDKm2s2BqW4CqMGJEM
 xfcVU8+fBFxpHevGLBlpVjbAMy6tmJzmA4O4HCtsULc+AD6GhHQ0Yewzp0K6IdGaOKks
 VkTkCzm49O+g/XpdghAuoaUKESEhKWIGeuiayIVaS5l/2N6bEyNlGr48/YQE6xa5zqbQ
 8K7Q==
X-Gm-Message-State: AOJu0YyYHqF9p/ZL8Y51Qhc12ntdowyapWDq/ztlVihfbp/sYM/KP4CV
 Gj7cpDiRBvBmXNnAhDA3L+PcNdqq16TQSuOKqerRbbe5gHEJQx/WxJ2uQou+okACFi2ZMaIIgLm
 nM+8m4kb6O+FSOdNZGzUnLHMWY9ucyil0zcp0PbEJvSvfZY4XTSErUPEmc7aTvxKCMPHj8Vv6h1
 BCNJsymrWMEQQ9ghLQgaa58VHFwGgXqw==
X-Gm-Gg: ASbGnct5OdTECNF64/1sJcw1VwZhHmQgDPJFIVSZngcNTJ0cDYKucYaff0GuRNrKIF1
 +MzhQTIyjL3vPAi3BGrhXZpLf9lx6G6gesk+GgqOGQRDPccYzq2VkBeKtMWTIKZmjm+oq1JUNzN
 NcLqjVbhUH4JhkbvdL60aIVrc63E3R+pKEH6Q/WjeoNptAlWnyQxewUVzkzkfbq/YLbujMhk6MW
 dL1hDRR3Mk/iOkwkkpBE4PGsBUkwirBcx+tbd0mWhFXAx+NJpNt1bJREHsM5uCW85rSA8jCY8Rm
 cZClwQ==
X-Received: by 2002:a05:6000:1f8f:b0:38d:d223:f8e6 with SMTP id
 ffacd0b85a97d-38f6e4c20damr2693644f8f.0.1740140626489; 
 Fri, 21 Feb 2025 04:23:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2KGV9KW75NIzNkWG0SW6peFEkOFc/jU+KcSZPzdoAVv5xo2diToCCT3MD2+GZhM03uTHZcw==
X-Received: by 2002:a05:6000:1f8f:b0:38d:d223:f8e6 with SMTP id
 ffacd0b85a97d-38f6e4c20damr2693617f8f.0.1740140626064; 
 Fri, 21 Feb 2025 04:23:46 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f25915785sm23929271f8f.58.2025.02.21.04.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:23:45 -0800 (PST)
Date: Fri, 21 Feb 2025 07:23:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li Zhijian <lizhijian@fujitsu.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 21/41] hw/mem/cxl_type3: Add paired
 msix_uninit_exclusive_bar() call
Message-ID: <0401c4328f4d18be540fd432c2bbacce4531d14f.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

msix_uninit_exclusive_bar() should be paired with msix_init_exclusive_bar()

Ensure proper resource cleanup by adding the missing
`msix_uninit_exclusive_bar()` call for the Type3 CXL device.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20250203161908.145406-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/mem/cxl_type3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index ebc0ec536e..4775aab0d6 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -944,6 +944,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
 err_release_cdat:
     cxl_doe_cdat_release(cxl_cstate);
 err_free_special_ops:
+    msix_uninit_exclusive_bar(pci_dev);
     g_free(regs->special_ops);
 err_address_space_free:
     if (ct3d->dc.host_dc) {
@@ -967,6 +968,7 @@ static void ct3_exit(PCIDevice *pci_dev)
 
     pcie_aer_exit(pci_dev);
     cxl_doe_cdat_release(cxl_cstate);
+    msix_uninit_exclusive_bar(pci_dev);
     g_free(regs->special_ops);
     if (ct3d->dc.host_dc) {
         cxl_destroy_dc_regions(ct3d);
-- 
MST


