Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD485CFC61B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 08:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szArR-0000CJ-Oh; Fri, 11 Oct 2024 04:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1szArQ-0000CA-Vt
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 04:18:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1szArN-0003Ru-E9
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 04:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728634731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OWHz4dio5v2bcOfx1lDETEcIErAWvAKFXb04jALG9t8=;
 b=CgwiC2k+p3W1wX1SrdpvWpbd6dGA7rwJtxsVhAnLe3SzJYBJmvQbTcbD991zSdsiyH/269
 E+jt+tCmfrZih9vQHg5sW5hqS6/lxrPccAfETt7sgzJsrxGTcYEQeYvj3VS1yXMwN89fjv
 PiQyDrkMdpx6ID8kc0M2t9ahaz+6QHY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-VvK1RoqmOQOYgaQo4UtStg-1; Fri, 11 Oct 2024 04:18:47 -0400
X-MC-Unique: VvK1RoqmOQOYgaQo4UtStg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2fad296738fso12574511fa.1
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 01:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728634726; x=1729239526;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OWHz4dio5v2bcOfx1lDETEcIErAWvAKFXb04jALG9t8=;
 b=CAePpliyuEu5Uw/gWk8pv65b++QBSLV/3aoiiYf+HvUTXfpYWx4V6fwE9qNiVqzfvv
 kABmVMY3bfc/BKhwBXbiVN/yM7wrw6xc/waXGFlf8ukS45x1zjFTvVI5vxFFf3iZaeLN
 T++vO9P7g3TRo1kEh7pEKXFYP5yhjHdk4RRxRB0IuOKKS1RHnm/MRpaq1KW1PN1Cu49y
 P/4XyCgN03rnB4LPwxTWRjbqgRFZfVHmFeftAkDqnm9eUXM7Ra6+TrZoUjLvSsJvAv2F
 c+ruseH+RAH8IJLr2W8Eyo+Dej1DBY6AidXAwvkTx6cVWk4Qm0fLczT4JTPt0gfnppyG
 lDvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrZJOhEAkhO5UKCbDWQahGLyjGYnse6tLx3KwKh95jjTGWNGFWZu6lopmot8jOVuupev1IwDLIBWm/@nongnu.org
X-Gm-Message-State: AOJu0YxodvcMg0nhlL5SmqyEw9/9qL57Bkx8Es9cLjCiS48e094NRTQm
 X1yDYBKR0Cr12fQmDHGn2NkhD6iVuP3jW2UEClVloP52XRIu0Kenk3vbvaz/vB+KRT0bS4KZZJI
 qZECVH1yg7WWf1nyj3PdBcMysEJc0ZV3STgPFW9YhVsOWpS/OG4Qi
X-Received: by 2002:a05:6512:31c5:b0:539:937f:7806 with SMTP id
 2adb3069b0e04-539da5ae41dmr603678e87.61.1728634725879; 
 Fri, 11 Oct 2024 01:18:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9BGdjd/xqIK1sWCUmSW52nOIDiEZ+RhhTcteIUxOlzEDNoVjkVpZ2/OrfOowx/DjeJFnAtA==
X-Received: by 2002:a05:6512:31c5:b0:539:937f:7806 with SMTP id
 2adb3069b0e04-539da5ae41dmr603667e87.61.1728634725431; 
 Fri, 11 Oct 2024 01:18:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c749:9100:c078:eec6:f2f4:dd3b?
 (p200300cbc7499100c078eec6f2f4dd3b.dip0.t-ipconnect.de.
 [2003:cb:c749:9100:c078:eec6:f2f4:dd3b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430d70b4420sm68806625e9.34.2024.10.11.01.18.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2024 01:18:45 -0700 (PDT)
Message-ID: <f8702c07-442e-488c-8093-2b6ff89c82a2@redhat.com>
Date: Fri, 11 Oct 2024 10:18:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] virtio-pci: fix memory_region_find for
 VirtIOPCIRegion's MR
To: Gao Shiyuan <gaoshiyuan@baidu.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: zuoboqun@baidu.com, qemu-devel@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>, wangliang44@baidu.com
References: <20241009095827.67393-1-gaoshiyuan@baidu.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241009095827.67393-1-gaoshiyuan@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 09.10.24 11:58, Gao Shiyuan wrote:
> As shown below, if a virtio PCI device is attached under a pci-bridge, the MR
> of VirtIOPCIRegion does not belong to any address space. So memory_region_find
> cannot be used to search for this MR.
> 
> Introduce the virtio-pci and pci_bridge address spaces to solve this problem.
> 
> Before:
> memory-region: pci_bridge_pci
>    0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
>      00000000fe840000-00000000fe840fff (prio 1, i/o): virtio-net-pci-msix
>        00000000fe840000-00000000fe84003f (prio 0, i/o): msix-table
>        00000000fe840800-00000000fe840807 (prio 0, i/o): msix-pba
>      0000380000000000-0000380000003fff (prio 1, i/o): virtio-pci
>        0000380000000000-0000380000000fff (prio 0, i/o): virtio-pci-common-virtio-net
>        0000380000001000-0000380000001fff (prio 0, i/o): virtio-pci-isr-virtio-net
>        0000380000002000-0000380000002fff (prio 0, i/o): virtio-pci-device-virtio-net
>        0000380000003000-0000380000003fff (prio 0, i/o): virtio-pci-notify-virtio-net
> 
> After:
> address-space: virtio-pci-cfg-mem-as
>    0000380000000000-0000380000003fff (prio 1, i/o): virtio-pci
>      0000380000000000-0000380000000fff (prio 0, i/o): virtio-pci-common-virtio-net
>      0000380000001000-0000380000001fff (prio 0, i/o): virtio-pci-isr-virtio-net
>      0000380000002000-0000380000002fff (prio 0, i/o): virtio-pci-device-virtio-net
>      0000380000003000-0000380000003fff (prio 0, i/o): virtio-pci-notify-virtio-net
> 
> address-space: pci_bridge_pci_mem
>    0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
>      00000000fe840000-00000000fe840fff (prio 1, i/o): virtio-net-pci-msix
>        00000000fe840000-00000000fe84003f (prio 0, i/o): msix-table
>        00000000fe840800-00000000fe840807 (prio 0, i/o): msix-pba
>      0000380000000000-0000380000003fff (prio 1, i/o): virtio-pci
>        0000380000000000-0000380000000fff (prio 0, i/o): virtio-pci-common-virtio-net
>        0000380000001000-0000380000001fff (prio 0, i/o): virtio-pci-isr-virtio-net
>        0000380000002000-0000380000002fff (prio 0, i/o): virtio-pci-device-virtio-net
>        0000380000003000-0000380000003fff (prio 0, i/o): virtio-pci-notify-virtio-net
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2576
> Fixes: ffa8a3e3b2e6 ("virtio-pci: Add lookup subregion of VirtIOPCIRegion MR")
> 
> Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
> Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
> Signed-off-by: Wang Liang <wangliang44@baidu.com>

Why the two additional SOB?

You're the author and you sent out the patch.

If the other two were co-authors, it should be something like


Co-developed-by: Zuo Boqun <zuoboqun@baidu.com>
Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
Co-developed-by: Wang Liang <wangliang44@baidu.com>
Signed-off-by: Wang Liang <wangliang44@baidu.com>
Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>

[...]

>   
>   static void virtio_pci_reset(DeviceState *qdev)
> diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
> index 5cd452115a..bd12fbe4ef 100644
> --- a/include/hw/pci/pci_bridge.h
> +++ b/include/hw/pci/pci_bridge.h
> @@ -72,6 +72,8 @@ struct PCIBridge {
>        */
>       MemoryRegion address_space_mem;
>       MemoryRegion address_space_io;
> +    AddressSpace as_mem;
> +    AddressSpace as_io;

address_space_mem vs. as_mem is really confusing, likely 
"address_space_mem" shpuld be called "mem_mr" ot sth. like that. Anyhow, 
that's independent of your patch

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


