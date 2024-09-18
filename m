Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA08CCD1A0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 12:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1squ4I-00070y-3V; Wed, 18 Sep 2024 08:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1squ4A-000703-BV
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 08:45:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1squ48-0001s1-5o
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 08:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726663551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ejr5JWrQIoU1swxcEEV3cnUKbzAH2KOF/COTyJo7ahM=;
 b=c/06fucRqY7lfDGkpoSpFKpTop887GVzao1yyOcwak5ryVhiTBziOqlLeOJke3CSeQuxpn
 DPc+B9eEuY+qznqTH0/8A0bg8TQNhXwwrPD27yP5/8F12xFfjXQDQHtelEOUa52GZO+icU
 JYGm5ZOzGYLE7uU2vnpbm7DdR6BelN4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-KiygHPDLPtme7tWJjRpzmQ-1; Wed, 18 Sep 2024 08:45:48 -0400
X-MC-Unique: KiygHPDLPtme7tWJjRpzmQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-374b35856aeso2546615f8f.3
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 05:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726663547; x=1727268347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ejr5JWrQIoU1swxcEEV3cnUKbzAH2KOF/COTyJo7ahM=;
 b=oRn2OioByThzvcwsE1S6vuYOxGV53KEuVob+qjjZ0/71LCtJxHeOpMKE99g1tkaDDq
 li10TZa5FOM5cn4hrIsAJYvDcHozFsrxRmHT0s9wovx3xJPHC6h5iDG0EgdnPWMt8MBw
 fvnOZzz7D0nKEiqTRy1EW4HwMbvlZlfJwqCmgjml1s54eM8ZyiY4WVmDcfTlVP6wjvFB
 J+DaK01VD1u0J59PEqEbicwrbFjvcv3mx3blxA2LCAv6z62EuHghAhCva0NTCRoFplND
 vCt/Onin9iOFB+yRVljddRvesO2mssn0VlA4Nl4FHzK+hO/df3nKDfGcqSVeD3hker/A
 j0/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7PMWKdYhR2xgnamiAie10W8MNXZIOWT2AweiRHsLWQMtHGlYFXRJlkJ+HdtaDNTdnlsaTv5bypmv7@nongnu.org
X-Gm-Message-State: AOJu0YwuYFH/CPt6ECDSMDphUi8lwZ0BWfNn7KRe/iElxUSyEK51T00o
 NpX3OBT6YWoViG/dJshg65JsFBSJJnI6Zg684N2wOJ/q5/1hw45qv/f3veXQ+jwtTQJ8KJ5Rorv
 ciCQ0oHqDek5qBFctCSEC5ebSwAue45Uz00OGvBEUWloH560Enl3CEASkLmf1
X-Received: by 2002:a5d:4b82:0:b0:374:babf:ac4f with SMTP id
 ffacd0b85a97d-378c2cfec6bmr12946649f8f.12.1726663546727; 
 Wed, 18 Sep 2024 05:45:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE3D5hGmvZdCDRE4DxPd/3e1Wm77lEGjJ/ndqXxYjr27CspC8JxOmwQvuy9qcmlF92NGL50w==
X-Received: by 2002:a5d:4b82:0:b0:374:babf:ac4f with SMTP id
 ffacd0b85a97d-378c2cfec6bmr12946627f8f.12.1726663546194; 
 Wed, 18 Sep 2024 05:45:46 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e73d8f78sm12179590f8f.22.2024.09.18.05.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 05:45:45 -0700 (PDT)
Date: Wed, 18 Sep 2024 14:45:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: dave@treblig.org
Cc: philmd@linaro.org, kraxel@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw: Remove unused fw_cfg_init_io
Message-ID: <20240918144544.303ee004@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240918123542.25319-1-dave@treblig.org>
References: <20240918123542.25319-1-dave@treblig.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, 18 Sep 2024 13:35:42 +0100
dave@treblig.org wrote:

> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> fw_cfg_init_io has been unused since
>   918a7f706b ("i386: load kernel on xen using DMA")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/nvram/fw_cfg.c         | 5 -----
>  include/hw/nvram/fw_cfg.h | 1 -
>  2 files changed, 6 deletions(-)
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 2dadfd6e1f..b644577734 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -1171,11 +1171,6 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>      return s;
>  }
>  
> -FWCfgState *fw_cfg_init_io(uint32_t iobase)
> -{
> -    return fw_cfg_init_io_dma(iobase, 0, NULL);
> -}
> -
>  FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
>                                   hwaddr data_addr, uint32_t data_width,
>                                   hwaddr dma_addr, AddressSpace *dma_as)
> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index d173998803..fa42677619 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -321,7 +321,6 @@ void fw_cfg_add_extra_pci_roots(PCIBus *bus, FWCfgState *s);
>  
>  FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>                                  AddressSpace *dma_as);
> -FWCfgState *fw_cfg_init_io(uint32_t iobase);
>  FWCfgState *fw_cfg_init_mem(hwaddr ctl_addr, hwaddr data_addr);
>  FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
>                                   hwaddr data_addr, uint32_t data_width,


