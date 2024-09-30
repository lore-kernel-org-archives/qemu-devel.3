Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69DCCF649D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 10:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svDO9-0004o8-Ir; Mon, 30 Sep 2024 06:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svDNz-0004iE-Ey
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 06:12:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svDNv-0003OC-L8
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 06:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727691126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Fp7/SaUYbjuSbxP51QoStwEB85xLjve2nhlHHltpWhc=;
 b=dmQNetQGR2SU7FSaYh6dJbQqGH6a4MGi8ns6fE8B1NKAwoBCIQAkgJ15X9aHtbu2y9EAiB
 jFJeaWJDbzC0H6N3hXN1Jqb1NhjLMjX4pilZpiTWDsD3zA5PiRsN6jtg7KjiKDncuc+ZyU
 NjWH2ZVqNdv52xL3E0l22Ri+dHAnH0c=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-3I1V7Q8gMjiqpQkXxGETuQ-1; Mon, 30 Sep 2024 06:12:02 -0400
X-MC-Unique: 3I1V7Q8gMjiqpQkXxGETuQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7a9a6634b08so733704385a.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 03:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727691122; x=1728295922;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fp7/SaUYbjuSbxP51QoStwEB85xLjve2nhlHHltpWhc=;
 b=IccM+NjW/uqzZYwhytEMU5m75elv7MmhNmz3oZZJSapRn5gne5DV2jLLg7JV3+wy/y
 mrFOnM6UDPMWwoE1+7Tte9kIpIxdzvIFbNHNrXHgbXTMBgy4Do2pUqtVcYfGXg+BxnGB
 IxwzHPWRu2X15ZzLkNMGdC8LODDe36pi8X1Fv9oziG0glP0VEdsRyWz/zoQv4Onwd9ds
 Hg0UaBdKsNlznJ0pwS0hcVfmBPIz5E3FGlAuYANnm4+9SLX3u/H3A0a+wyfwoitCjUjy
 pIn9ViGuFI6UIC3SrMuUGF4cR0wfN9LnJGRpsb13Zxs0krD9oAQ6jsvNapYHzVrsedPb
 /JUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlFjIPFuSefy4C5WHVOELEwk/7j2NRsqf5VK9LNrbNtdafQo3ek9aDTT+ljfgoSXti6Hk0msN6MOgf@nongnu.org
X-Gm-Message-State: AOJu0Yzm5v9YHr34POFQvvKmqgA0TZwi6ROujMCIoFutuYwmM/lvnl8+
 N7/T/Am1c08MxpQFcqHjVKKRdyQ6tvlWClpO7sA001fOSQ9ZDOTU/33TmJKVhm1bP01a2sfDhj/
 NT3C9cTVYMyu3cVatS3HsDN+1il3WlhXb+FajOw/VZl6VBP5UTOqe
X-Received: by 2002:a05:620a:424a:b0:7ac:a9b2:9374 with SMTP id
 af79cd13be357-7ae2c5ec905mr2454137485a.4.1727691122013; 
 Mon, 30 Sep 2024 03:12:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeDwLLbkThJpQpgveVTxxJXmbkCnGQj5Y4eoSBsleMuDVLDKVAtI0uatprk+GP3VvUYKhNVw==
X-Received: by 2002:a05:620a:424a:b0:7ac:a9b2:9374 with SMTP id
 af79cd13be357-7ae2c5ec905mr2454134685a.4.1727691121617; 
 Mon, 30 Sep 2024 03:12:01 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-176.web.vodafone.de.
 [109.42.48.176]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae377bccddsm400945885a.14.2024.09.30.03.11.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Sep 2024 03:12:01 -0700 (PDT)
Message-ID: <e935ee2e-6e6e-44fa-a580-e0ac848d7686@redhat.com>
Date: Mon, 30 Sep 2024 12:11:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/18] pc-bios/s390-ccw: Enable failed IPL to return after
 error
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20240927005117.1679506-1-jrossi@linux.ibm.com>
 <20240927005117.1679506-13-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240927005117.1679506-13-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 27/09/2024 02.51, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Remove panic-on-error from IPL functions such that a return code is propagated
> back to the main IPL calling function (rather than terminating immediately),
> which facilitates possible error recovery in the future.
> 
> A select few panics remain, which indicate fatal non-devices errors that must
> result in termination.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> 
> ---
...
> @@ -1054,16 +1073,19 @@ void zipl_load(void)
>   
>       if (vdev->is_cdrom) {
>           ipl_iso_el_torito();
> -        panic("\n! Cannot IPL this ISO image !\n");
> +        puts("Failed to IPL this ISO image!");
> +        return;
>       }
>   
>       if (virtio_get_device_type() == VIRTIO_ID_NET) {
>           netmain();
> -        panic("\n! Cannot IPL from this network !\n");
> +        puts("Failed to IPL from this network!");
> +        return;
>       }
>   
>       if (ipl_scsi()) {
> -        panic("\n! Cannot IPL this device !\n");
> +        puts("Failed to IPL from this device!");

I'd maybe say "Failed to IPL from this SCSI device" now, just to make sure 
that it is easier to match the message with one of the boot device types later?

> +        return;
>       }
...
>   void jump_to_low_kernel(void)
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 2345432abb..f818bd7210 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -77,6 +77,9 @@ static int is_dev_possibly_bootable(int dev_no, int sch_no)
>   
>       enable_subchannel(blk_schid);
>       cutype = cu_type(blk_schid);
> +    if (cutype == CU_TYPE_UNKNOWN) {
> +        return -EIO;
> +    }
>   
>       /*
>        * Note: we always have to run virtio_is_supported() here to make
> @@ -194,10 +197,10 @@ static void boot_setup(void)
>       have_iplb = store_iplb(&iplb);
>   }
>   
> -static void find_boot_device(void)
> +static bool find_boot_device(void)
>   {
>       VDev *vdev = virtio_get_device();
> -    bool found;
> +    bool found = false;
>   
>       switch (iplb.pbt) {
>       case S390_IPL_TYPE_CCW:
> @@ -215,10 +218,10 @@ static void find_boot_device(void)
>           found = find_subch(iplb.scsi.devno);
>           break;
>       default:
> -        panic("List-directed IPL not supported yet!\n");
> +        puts("Invalid IPLB");

Maybe rather say "Unsupported IPLB" ? At least the original message sounds 
like it was rather something that has not been implemented yet, and not 
something that is wrong on the disk...?

>       }
>   
> -    IPL_assert(found, "Boot device not found\n");
> +    return found;
>   }

...
>   unsigned long virtio_load_direct(unsigned long rec_list1, unsigned long rec_list2,
> @@ -73,13 +73,13 @@ unsigned long virtio_load_direct(unsigned long rec_list1, unsigned long rec_list
>       unsigned long addr = (unsigned long)load_addr;
>   
>       if (sec_len != virtio_get_block_size()) {
> -        return -1;
> +        return 0;
>       }
>   
>       printf(".");
>       status = virtio_read_many(sec, (void *)addr, sec_num);
>       if (status) {
> -        panic("I/O Error");
> +        return 0;
>       }
>       addr += sec_num * virtio_get_block_size();

Ah, here's the fix for virtio_load_direct() ... since you changed the call 
site in patch 09 already, I think you should move this hunk to patch 09, too.

> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> index 8c6b0a8a92..e3fdb95b3c 100644
> --- a/pc-bios/s390-ccw/virtio.c
> +++ b/pc-bios/s390-ccw/virtio.c
> @@ -217,16 +217,19 @@ int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd)
>       return 0;
>   }
>   
> -void virtio_setup_ccw(VDev *vdev)
> +int virtio_setup_ccw(VDev *vdev)
>   {
> -    int i, rc, cfg_size = 0;
> +    int i, cfg_size = 0;
>       uint8_t status;
>       struct VirtioFeatureDesc {
>           uint32_t features;
>           uint8_t index;
>       } __attribute__((packed)) feats;
>   
> -    IPL_assert(virtio_is_supported(vdev->schid), "PE");
> +    if (!virtio_is_supported(vdev->schid)) {
> +        puts("PE");

Do you remember what "PE" means here? ... might be a good opportunity to fix 
this error message as well...

> +        return -ENODEV;
> +    }

  Thomas


