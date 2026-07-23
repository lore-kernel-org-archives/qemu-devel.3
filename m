Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64978C531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 19:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmzTZ-0002tV-P7; Thu, 23 Jul 2026 15:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rovick@redhat.com>) id 1wmzBr-0003S9-PF
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 15:34:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rovick@redhat.com>) id 1wmzBp-0000dN-ME
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 15:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784835279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eac4E4dFfexA3BWOcM4bU+kVoBa3JZcMOMj/Da/rXB4=;
 b=htxRe7ultoUv8xpnA8IYhshqNzDT9JelWymVtGU52AdyaxxeUWawRkCgXAcWmW4bolahTn
 xUJ8i2g5gM4vhy8spv8EmIUgsm5GgmSM8o1+WymgWdsu/nNEpSJJa3mlOTTLgOCQX2SUh6
 9eIXNlYo5yd/ET+pZFP5Z/6cZXieMSs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-HfbLWkbyOuS9tZ9rjEVqlw-1; Thu, 23 Jul 2026 15:33:31 -0400
X-MC-Unique: HfbLWkbyOuS9tZ9rjEVqlw-1
X-Mimecast-MFC-AGG-ID: HfbLWkbyOuS9tZ9rjEVqlw_1784835210
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8fc6b670b4bso8500906d6.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 12:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784835210; x=1785440010; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eac4E4dFfexA3BWOcM4bU+kVoBa3JZcMOMj/Da/rXB4=;
 b=KUmIpeO5Ch4jitR0TpEOppxWVwEL5W7t5GhF+RiL3M3U4LzOwUYSuKeM8zF52AB6/U
 6ugUMxutpAU8FOFdyKWrPgMXcws+WhPQQ2/esjv3HCjlxtMNZDxZjqUkUwMmy+vs+747
 7cPE7V9FYpvVOLBNF9h+/MzvMnR2ci3IOfvZP4PUaEz5U+S+6VLV3qUWqP2HhwZsyZkh
 FcpCsFuyjQbdJiQv769bVtUXJY1EwQV+OEPA99bGnY706P+1asaYtH0yRY1MU+NRQE8P
 uuxM/0a1qM/QHblfMI2zLNARH1M8yF8YOFeD9read8iGdVPISQu4gxXClWQYPHTkQuSm
 oXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784835210; x=1785440010;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eac4E4dFfexA3BWOcM4bU+kVoBa3JZcMOMj/Da/rXB4=;
 b=DgPz5p9g8C8R1R0wrjaQKthhkDX32WNo841Gh4i5nnK+TR0lpLq/9j147/TC0dQELL
 FBSaG3Y7AD4MHck3+TMZqa8STCbWYFtAfZ1Isvnbp7kMIASXtr/CDkFQ9WbL+DSASE2v
 vgM9LAXVwyohjDvUbMRFVCAT/yAKXBbK3lPC17qa2/u9CFMxmuMfePzcTXoz1gKcyvPq
 gaJtbU11MXnCn2EtqsMlwNS95nxviRjm21Ph9egjlFNUXenV67/BkHoqwKLmcWGSz+VH
 7aDI/et5eRlUYzek1X5mS022lgoS4kg5BEXrp8UY555oD7p56JiQwv4MxmM2VUey4lrq
 /0fg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqQvGXI+G4RwSqim45ev3x0yF4bS/9be0IFhqGlSghdBlNEzVilJhntTjhTVS2uxemx0gI/Tfl4ipdF@nongnu.org
X-Gm-Message-State: AOJu0Yw5fbc9u8I27B+RV48nUQmg00B/ozoSiT4x2XZ1CGSp8JjbE2kT
 IOrj2uYHJGwgjxhzzvCCi+lVkHswzrI3vAaMceptATbf7oH3L0UTrmw+6L008Dpg6NL+jkJNvov
 v7dftOcfbHss0X1Ycu7iDbSLoXSl0xaQDqj+HgIEL2mg53FXjkaMY9MBK
X-Gm-Gg: AR+sD13JTU+OyHHu+SGKNoip7mEP6soz7aum3909dhpJgQGG79k9omKTv+wLiRu8yRF
 C6zBlT0FsN2ORbpeLynUGN2uPmLtrvtsdUtprbV3TQWgMO0ALNavMF205bCFiy2V48I44F1q6CW
 wGZEIcgEhWbVc2v2TiP1I1A65cYFPl1FqidOjDTwMmDE8iTCxJtddFWaO4mfTPzIIVgFawG6mNK
 5NwWh/omdfg9ZQU2YHtrkkRvjr+mlcm/nr+T2pPlTB2wJjlnp4ipX5NGdS4eO2Z/V1LldkKRf+V
 hV/YgfSTv/mYVmWwp3X1xJ7ZA9Jz9p3dqf7PFhOKmibO3IKHeEGm2VKcpc4FZFY+4EzGaN0HNi3
 fiw==
X-Received: by 2002:a05:6214:328c:b0:8ea:a89:4da1 with SMTP id
 6a1803df08f44-907ca665918mr49638496d6.47.1784835210271; 
 Thu, 23 Jul 2026 12:33:30 -0700 (PDT)
X-Received: by 2002:a05:6214:328c:b0:8ea:a89:4da1 with SMTP id
 6a1803df08f44-907ca665918mr49638126d6.47.1784835209626; 
 Thu, 23 Jul 2026 12:33:29 -0700 (PDT)
Received: from [192.168.15.9] ([179.116.24.175])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907ba9ddd4bsm52052746d6.26.2026.07.23.12.33.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 12:33:28 -0700 (PDT)
Message-ID: <1c544c93-165b-4a79-a199-ef9cfaa9424d@redhat.com>
Date: Thu, 23 Jul 2026 16:33:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/region: Clarify dma-buf failure messages
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Nicolin Chen <nicolinc@nvidia.com>
References: <20260715070622.198400-1-clg@redhat.com>
Content-Language: en-US
From: Rodolfo Vick <rovick@redhat.com>
In-Reply-To: <20260715070622.198400-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=rovick@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 23 Jul 2026 15:52:55 -0400
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


On 7/15/26 04:06, Cédric Le Goater wrote:
> The dma-buf failure messages in vfio_region_create_dma_buf() say "PCI
> BAR IOMMU mappings may fail", which suggests the BAR is broken. In
> practice, only P2P DMA is affected -- normal passthrough uses the mmap
> fallback.
> 
> Reword both messages to mention P2P DMA explicitly and clarify that
> the mmap fallback is in use. Use warn_report_err_once() at the call
> site so per-BAR repetition on mdev devices is suppressed.
> 
> Fixes: dcf1b77e834d ("hw/vfio/region: Create dmabuf for PCI BAR per region")
> Cc: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/region.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index dbde3391802691888ca31d5e329aba5ba680feb4..54ad11a6c8ed8e04fa365262ccb8bd694bdb45f7 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -321,13 +321,12 @@ static bool vfio_region_create_dma_buf(VFIORegion *region, Error **errp)
>       ret = vfio_device_get_feature(vbasedev, feature);
>       if (ret < 0) {
>           if (ret == -ENOTTY) {
> -            warn_report_once("VFIO dma-buf not supported in kernel: "
> -                             "PCI BAR IOMMU mappings may fail");
> +            warn_report_once("VFIO dma-buf not supported in kernel, "
> +                             "using mmap fallback, P2P DMA will not work");
>               return true;
>           }
> -        /* P2P DMA or exposing device memory use cases are not supported. */
> -        error_setg_errno(errp, -ret, "%s: failed to create dma-buf: "
> -                         "PCI BAR IOMMU mappings may fail",
> +        error_setg_errno(errp, -ret, "%s: dma-buf unavailable, "
> +                         "using mmap fallback, P2P DMA will not work",
>                            memory_region_name(region->mem));
>           return false;
>       }
> @@ -448,7 +447,7 @@ int vfio_region_mmap(VFIORegion *region)
>       }
>   
>       if (!vfio_region_create_dma_buf(region, &local_err)) {
> -        error_report_err(local_err);
> +        warn_report_err_once(local_err);
>       }
>   
>       return 0;

Reviewed-by: Rodolfo Vick <rovick@redhat.com>


