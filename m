Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571EAC3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 10:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFsQg-0003oM-NG; Fri, 16 May 2025 06:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFsQT-0003Wp-Re
 for qemu-devel@nongnu.org; Fri, 16 May 2025 06:36:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFsQR-0001mS-Ht
 for qemu-devel@nongnu.org; Fri, 16 May 2025 06:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747391777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xhc8nPEtdnlSJAau+Tcm2HYkHH/kHSnuDrKAzIVfN54=;
 b=SKUZFo9RF0/Kr7Rk92iEpG7GijPebprYmQp6Ihw7dwyHY4X7rK0TZ95mumXtNAwkhXwmJZ
 SN8n+lW0TD/mSpyFR6kCP7iNeu9lubEwDhW2PJkYYp/QWaNiBECg3L4KmaZN0TQL8ryTCQ
 nrnDaVtAZF1CCLia+34mo63U3ZsSQg8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-G8ZBr4nJN36DknU1-m2hDg-1; Fri, 16 May 2025 06:36:16 -0400
X-MC-Unique: G8ZBr4nJN36DknU1-m2hDg-1
X-Mimecast-MFC-AGG-ID: G8ZBr4nJN36DknU1-m2hDg_1747391775
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a20257c758so1292681f8f.0
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 03:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747391775; x=1747996575;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xhc8nPEtdnlSJAau+Tcm2HYkHH/kHSnuDrKAzIVfN54=;
 b=V6hS7s3ch5RHuoYzsJYmcdFf6fiM0ZNl+lGoJTjz9Bo9IVMOPzXS5Nhme4T4eLcnlV
 eqZCOg94f0orsgcGrPhFnKmZ8rwE1pAa6tQm/DH3zPYRHfoUjFkNwQvRZfr5iRSufclP
 ofW0cqhr4JYKeU19x/0s+aMJyBItky7eUOoUaGGbTNI7NJ1/jJTjQH+PkG7eM44+Oj7J
 isEcXmYA2uAeJp6xgrG3Me/xhXHVE9DkT5m6MUEmK8Yn6scP0Gc2qwkPFvj12+sKQSmk
 7R2p9VWuhMAY4hwuMfyZqw8EBLLAWSKye5V/1B7jSS0w7XvrYWywlYfFxpaxN4AEbtIH
 IyyQ==
X-Gm-Message-State: AOJu0YxgsNePst/uTOcQJwB3W8fnjGgsd0EFxCb8bDWUVriJwz6ttc/5
 y8Afo3Qm3R5ZXXDgOa8cZk+85YDNSzNXFUWjyl+8qgpfEBkFT2l7CVskJvjMVIss3iDODOUarxT
 ZrNvM2vjhmLpJrvOeQuXtkV58Nkn4DyfUcBiH2neX3Hb0+cKsNkgnRTIG
X-Gm-Gg: ASbGncuvgd+I+2WF8zmnAnpqSOBf4oXeDqBZrGrQVF89X6zW2cqsY0WWDnHYCTtwSNL
 hjzfs4pdgXK2/zETwXlfdLAx1S1Xba7TmVtRudLt2TX8bZmB/o65x7k82piFcCoM9qeIlK0fA3R
 qp0xuvSCJrVCsbJYh0YJ6IXq9fX0y/5e1YmxcrVg2xuQnvNcKSlUWEo3iA5aDzb534IcXqW7d5w
 be8T6fRlegVk97LZzdIjX9xs43Ky0/gLnMuoBQiV1M3d/+TrBNzPB8afl4smogwMP3wpZPEgqZv
 /FZ+sA==
X-Received: by 2002:a05:6000:144e:b0:39f:7e99:5e8c with SMTP id
 ffacd0b85a97d-3a35c84ae15mr3541553f8f.51.1747391775370; 
 Fri, 16 May 2025 03:36:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU615z65YZXa1JerNnvB4Qz2BQa9Bw8EfdV/X9ckN8CHI4xvboljgC9fwnxqTTr+XDcagI0w==
X-Received: by 2002:a05:6000:144e:b0:39f:7e99:5e8c with SMTP id
 ffacd0b85a97d-3a35c84ae15mr3541529f8f.51.1747391775034; 
 Fri, 16 May 2025 03:36:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca88899sm2375303f8f.80.2025.05.16.03.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 03:36:14 -0700 (PDT)
Date: Fri, 16 May 2025 06:36:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: qemu-devel@nongnu.org, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 suravee.suthikulpanit@amd.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com
Subject: Re: [PATCH v3 0/2] amd_iommu: Fixes
Message-ID: <20250516063605-mutt-send-email-mst@kernel.org>
References: <20250516100535.4980-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516100535.4980-1-sarunkod@amd.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, May 16, 2025 at 03:35:33PM +0530, Sairaj Kodilkar wrote:
> Fix following two issues in the amd viommu
> 1. The guest fails to setup the passthrough device when for following setup
>    because amd iommu enables the no DMA memory region even when guest is 
>    using DMA remapping mode.
> 
>     -device amd-iommu,intremap=on,xtsup=on,pt=on \
>     -device vfio-pci,host=<DEVID> \
> 
>     and guest forcing DMA remap mode e.g. 'iommu.passthrough=0'
> 
>     which will cause failures from QEMU:
> 
>     qemu-system-x86_64: AHCI: Failed to start DMA engine: bad command list buffer address
>     qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS receive buffer address
>     qemu-system-x86_64: AHCI: Failed to start DMA engine: bad command list buffer address
>     qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS receive buffer address
>     qemu-system-x86_64: AHCI: Failed to start DMA engine: bad command list buffer address
> 
> 
> 2. The guest fails to boot with xtsup=on and <= 255 vCPUs, because amd_iommu
>    does not enable x2apic mode.
> 
> base commit 56c6e249b6988c1b6edc2dd34ebb0f1e570a1365 (v10.0.0-rc3)
> 
> Sairaj Kodilkar (1):
>   hw/i386/amd_iommu: Fix device setup failure when PT is on.
> 
> Vasant Hegde (1):
>   hw/i386/amd_iommu: Fix xtsup when vcpus < 255
> 
>  hw/i386/amd_iommu.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

changelog?

> -- 
> 2.34.1


