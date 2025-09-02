Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FDCCA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 15:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utT7b-0007J2-Ik; Tue, 02 Sep 2025 11:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1utT7Z-0007ID-AO
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 11:40:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1utT7Q-0006Qp-3i
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 11:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756827609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VUTtIDrgT/Muh+9t66DbRllYQSzmgxBAaz3A72dChg0=;
 b=WqnsIykG2AoIyBF1xiUtJLbOEBeZv0td/gxBFKjr6Q/I2nywwp5w5A19Zp55ZBEAfPRhI1
 4t0PjDxJ9ovh/Gt6MtIo7IAt25HHtVKoR1Nc08y/wyLNaRw83yxFN/nGy0sQy60+MFRVZQ
 kZQuTHJgK6IpB0ZjbnpawE1bQnzme7g=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-vl1Y6V6XMrGAqFxyKqgnHQ-1; Tue, 02 Sep 2025 11:40:07 -0400
X-MC-Unique: vl1Y6V6XMrGAqFxyKqgnHQ-1
X-Mimecast-MFC-AGG-ID: vl1Y6V6XMrGAqFxyKqgnHQ_1756827607
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-3f65bfe0d27so632755ab.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 08:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756827607; x=1757432407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VUTtIDrgT/Muh+9t66DbRllYQSzmgxBAaz3A72dChg0=;
 b=dPKLqhoehli5xFnhyRiT0hd/0kALxKvG5l04kJUKTdPdAD/eunJ/QRIDSHwayqumig
 /AfJ9GxOLaqZhtrmmZv0MwnIMUihG5eLTm+07dzhWaFG90cdW7GxmLW8/AEQJqiG0hOW
 7iSEWFccr+QyjjV3ZHx5csZoj+cf2e6qbO7njAlKTu9qaqbUWrHtmFcoPUvCTc2h0/jz
 pmJqPTsvAvrsAhBVmZTe6zq3eqiIFVpGc5e2Ai4Ti+j+EP8FrsmEX5vzVSkG9zgYqw8x
 5lx4YlfevWr49zMQq3AFneRqnjxcKs+dJZSmWu1ObFmrhlyf829R+zGtwwZfGUe4h/wG
 IMYA==
X-Gm-Message-State: AOJu0YwwW5PjgjO/7xdFdCiXM9qNb3is/rYo+oTzQbV8EOp+f2BOIZcl
 t+kqW1gdyO2BWp/grGkgbqDF4iDkaaSmJX7LV3PD6Zr55+mwqwyg5gn2uC66lTiyg6KyIP5jmVd
 sRD/iFiPG/kaMkIVE8lG3atUUxQNUiPLrq50EALnF5j3nJPB1J4C22FDp
X-Gm-Gg: ASbGncsy5qhCWAYHUzc76NGeUq3avPUc08wDWgpXgXbfbr7aaQpe/pATzTBn3UdGfes
 Ir698cUo9H2V2JVovaj5ujRweSd8fyk0/BlHfB+Nx6HWOtpZ4pWS6yilVkC8w/oUY2F6rXcvdYF
 dNxNGpqx0zA+u5bo1watZVztt0IE/N449VHIaqpaV7IrJXSXj1Okas9u919q0sZ/3NhO+ovlqHB
 4gVr7WbG0nQNqgwCi2PAQPIkNkWYiAdKvuAdZ8R0OT+IQjCwXqy8KNnvoYXlmZmpJu9yRi9Abl5
 7Se74KnKy/N0RAVf1POpDa4JdjkSKv2mYfl31XfcyK8=
X-Received: by 2002:a05:6602:13c7:b0:87c:46f2:7075 with SMTP id
 ca18e2360f4ac-8871921eb42mr960545839f.5.1756827606880; 
 Tue, 02 Sep 2025 08:40:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw97vzpPB2V9N9tJPjPniCu+9uJ0WHjAaoa+4i8uB/iZpB6fjMmodPBe9RPhLf3XUxwCFjGg==
X-Received: by 2002:a05:6602:13c7:b0:87c:46f2:7075 with SMTP id
 ca18e2360f4ac-8871921eb42mr960544639f.5.1756827606437; 
 Tue, 02 Sep 2025 08:40:06 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50d8f0d5787sm3273506173.19.2025.09.02.08.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 08:40:04 -0700 (PDT)
Date: Tue, 2 Sep 2025 09:40:02 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, clg@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com, chao.p.peng@intel.com
Subject: Re: [PATCH] vfio/pci: Recover sub-page BAR size when base address
 is not aligned
Message-ID: <20250902094002.20842f39.alex.williamson@redhat.com>
In-Reply-To: <20250715065952.213057-1-zhenzhong.duan@intel.com>
References: <20250715065952.213057-1-zhenzhong.duan@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 15 Jul 2025 02:59:52 -0400
Zhenzhong Duan <zhenzhong.duan@intel.com> wrote:

> Currently region_mr and mmap_mr size are recovered to original size when
> base address is updated to non-PAGE_SIZE aligned, but still leave base_mr
> with PAGE_SIZE size. This is harmless as base_mr is a only container but
> still a bit confusing when executing hmp command mtree.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/pci.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 1093b28df7..0455e6ce30 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1348,9 +1348,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
>  
>      memory_region_transaction_begin();
>  
> -    if (vdev->bars[bar].size < size) {
> -        memory_region_set_size(base_mr, size);
> -    }
> +    memory_region_set_size(base_mr, size);
>      memory_region_set_size(region_mr, size);
>      memory_region_set_size(mmap_mr, size);
>      if (size != vdev->bars[bar].size && memory_region_is_mapped(base_mr)) {

Has this been tested with MSI-X relocation to the sub-page BAR?  The
lowest level MR here is meant to fill the gaps not backed by other MRs,
for example between the region MR and the MSI-X emulation MR.  We call
this function based on the region size, not the BAR size.  For example I
think if we had a 4K host, 2K BAR, and >2K MSI-X table, bars[bar].size
might be 8K, with the MSI-X table offset at 4K.  We'd want the
underlying container BAR MR to cover the full 8K, not just the 4K that
we're expanding the region access to.  OTOH, if host page size were
64K, then we would want to expand the base MR to page size.

I think that's the original reason this is conditional, but maybe you
could share the confusing mtree output and provide any comments
relative to the scenario above.  Thanks,

Alex


