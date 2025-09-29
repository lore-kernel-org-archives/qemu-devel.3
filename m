Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3A5CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 18:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3IMC-0007QS-IA; Mon, 29 Sep 2025 14:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3IM9-0007ND-6T
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:12:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3IM4-0002JT-PE
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759169526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gMP7BAnFkoI8mG/XmzIpouF2oHLVVwSgQHPsigTfPKE=;
 b=VkKKs/kg8eUPE5/5Lq5tjDn57JVlht8Fl2y9YKQoL/Me6jiNWFdTboXOSW/Enypob2ptQ0
 00reIDpgxZDcEvSatsiVG6qEaJGHYOUhyd1X1PH1QF+UOFIgveLnoMy5wkae2aGoEv8kl3
 t+xwLtrn/OeTi+OxpLr1JQNrnuNcoIo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-YpO_VgM0Mb232GD1Jnlx9g-1; Mon, 29 Sep 2025 14:12:03 -0400
X-MC-Unique: YpO_VgM0Mb232GD1Jnlx9g-1
X-Mimecast-MFC-AGG-ID: YpO_VgM0Mb232GD1Jnlx9g_1759169522
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ee13baf21dso3964128f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 11:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759169522; x=1759774322;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gMP7BAnFkoI8mG/XmzIpouF2oHLVVwSgQHPsigTfPKE=;
 b=JhGi3TblJqXTLnD+6TyUN4ogZ+Ev25MZMWoNDIqkxQTsZmoDl25SeEuDEKEjCKIOHa
 IOPv4tOxNQCQKZsyw6Vqa6YEVuwoZfbhDYlj5tf1qO9ZMTy3rOJ6kmXOBruHrNkgb7DZ
 UqH6Aq5FLJpBTof+sJydCCTdQk1JQQliFau35tYk8yu9Lq+Sw/YQYbZekMgst7TNM8Nc
 XSBKvrlWAepK4mM6WWfbT4nNCEC0bn2QiH/n1ORchyikgd3YJhOFxZcJzPmJZxbzu2zl
 3hjnU2gb0xT/pqIDNjflg8OyzaBRamEbIq5inSaoIdES9LnjWx9AK/oEg7vQHAelurys
 v7ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaJtOJrrTyBk+cBtStqJMpBZLBzZv4z67bEH5WnLBWG1l3Gf3kOTYU3g+b81z1ttk6YiWKTwTZQ3t0@nongnu.org
X-Gm-Message-State: AOJu0YzJ+KJXxlF23rMyaTD2TB1b3qesLJtUkRdCpW++CP/f0u7GwoBE
 G75n/sP6b85tKcLGdQMsgR4g355H0AsLww5rMSB9bYDbDPLJuJAdVIGlF2qMI6q/4w63RRO2Vss
 uScw69pw47A1tCKXO/V/CYwElAmq+HID31/hjmRNA2ChLZ/F2kCC5IIeUmw/GOWKmzJI=
X-Gm-Gg: ASbGncurhY7GevVqRL7TUFSJMDhxL7WJkILLsPhjbjaMGvMl5m345yOSKBNkyFo4pdB
 Aj9j9Qmt5xS/+eMZq9ueG58VPH5xEUDOYUHyxvaXQEIL572vG3uT39B8mnNDFALG+pPmTreXxGf
 XXtgodTAO7up3rc0l5OKySfxxLj1s+C3rR4cVmdv4Fax0xTNfBc/nV2W3fZ+i1Vwn6tQu5TWJU9
 L1FWBTBhqpGScsRaRg5/oyPgtk8FROXV5LDuWDA/Sb+VZYyn5njlcVIlMW+N+bmSti41aLEPyrR
 /DFFGHBxVL6PauVKKJUakINULuWptk0nOyYlGYzzZCew1gV3rq+u56EOHpADxGXjlUAygGmWqoG
 1jZGf1w==
X-Received: by 2002:a05:6000:2dc9:b0:3ec:ce37:3a6a with SMTP id
 ffacd0b85a97d-40e4458ce65mr16443388f8f.22.1759169522113; 
 Mon, 29 Sep 2025 11:12:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOmbhabFvv55MMSWJY4L+MJmUNWCQe5vQGwaySROSz20imA3ilAxM8ZrH92YJGxNHFBONDXA==
X-Received: by 2002:a05:6000:2dc9:b0:3ec:ce37:3a6a with SMTP id
 ffacd0b85a97d-40e4458ce65mr16443370f8f.22.1759169521668; 
 Mon, 29 Sep 2025 11:12:01 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-212.pools.arcor-ip.net.
 [47.64.114.212]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f3dcacsm24309635e9.2.2025.09.29.11.11.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 11:12:01 -0700 (PDT)
Message-ID: <554a136e-bd74-4f06-b9f9-b198422487b9@redhat.com>
Date: Mon, 29 Sep 2025 20:11:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 25/28] pc-bios/s390-ccw: Handle secure boot with
 multiple boot devices
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-26-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250917232131.495848-26-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 18/09/2025 01.21, Zhuoying Cai wrote:
> The current approach to enable secure boot relies on providing
> secure-boot and boot-certs parameters of s390-ccw-virtio machine
> type option, which apply to all boot devices.
> 
> With the possibility of multiple boot devices, secure boot expects all
> provided devices to be supported and eligible (e.g.,
> virtio-blk/virtio-scsi using the SCSI scheme).
> 
> If multiple boot devices are provided and include an unsupported (e.g.,
> ECKD, VFIO) or a non-eligible (e.g., Net) device, the boot process will
> terminate with an error logged to the console.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/bootmap.c  | 31 ++++++++-------
>   pc-bios/s390-ccw/main.c     | 75 ++++++++++++++++++++++++++++++++++---
>   pc-bios/s390-ccw/s390-ccw.h |  1 +
>   3 files changed, 88 insertions(+), 19 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 3ab89b91fb..8297f22c3c 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -1136,25 +1136,35 @@ ZiplBootMode zipl_mode(uint8_t hdr_flags)
>       return ZIPL_BOOT_MODE_NORMAL;
>   }
>   
> +int zipl_check_scsi_mbr_magic(void)
> +{
> +    ScsiMbr *mbr = (void *)sec;
> +
> +    /* Grab the MBR */
> +    memset(sec, FREE_SPACE_FILLER, sizeof(sec));
> +    if (virtio_read(0, mbr)) {
> +        puts("Cannot read block 0");
> +        return -EIO;
> +    }
> +
> +    if (!magic_match(mbr->magic, ZIPL_MAGIC)) {
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
>   void zipl_load(void)
>   {
>       VDev *vdev = virtio_get_device();
>   
>       if (vdev->is_cdrom) {
> -        if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT ||
> -            boot_mode == ZIPL_BOOT_MODE_SECURE) {
> -            panic("Secure boot from ISO image is not supported!");
> -        }
>           ipl_iso_el_torito();
>           puts("Failed to IPL this ISO image!");
>           return;
>       }
>   
>       if (virtio_get_device_type() == VIRTIO_ID_NET) {
> -        if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT ||
> -            boot_mode == ZIPL_BOOT_MODE_SECURE) {
> -            panic("Virtio net boot device does not support secure boot!");
> -        }
>           netmain();
>           puts("Failed to IPL from this network!");
>           return;
> @@ -1165,11 +1175,6 @@ void zipl_load(void)
>           return;
>       }
>   
> -    if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT ||
> -        boot_mode == ZIPL_BOOT_MODE_SECURE) {
> -        panic("ECKD boot device does not support secure boot!");
> -    }
> -
>       switch (virtio_get_device_type()) {
>       case VIRTIO_ID_BLOCK:
>           zipl_load_vblk();
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index c5b425209a..228b52a37e 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -271,8 +271,43 @@ static int virtio_setup(void)
>       return ret;
>   }
>   
> -static void ipl_boot_device(void)
> +static void validate_secure_boot_device(void)
> +{
> +    switch (cutype) {
> +    case CU_TYPE_DASD_3990:
> +    case CU_TYPE_DASD_2107:
> +        panic("Passthrough (vfio) device does not support secure boot!");
> +        break;
> +    case CU_TYPE_VIRTIO:
> +        if (virtio_setup() == 0) {
> +            VDev *vdev = virtio_get_device();
> +
> +            if (vdev->is_cdrom) {
> +                panic("Secure boot from ISO image is not supported!");
> +            }
> +
> +            if (virtio_get_device_type() == VIRTIO_ID_NET) {
> +                panic("Virtio net boot device does not support secure boot!");
> +            }
> +
> +            if (zipl_check_scsi_mbr_magic()) {
> +                panic("ECKD boot device does not support secure boot!");
> +            }
> +        }
> +        break;
> +    default:
> +        panic("Secure boot from unexpected device type is not supported!");
> +    }
> +
> +    printf("SCSI boot device supports secure boot.\n");
> +}
> +
> +static void check_secure_boot_support(void)
>   {
> +    bool have_iplb_copy;
> +    IplParameterBlock *iplb_copy;
> +    QemuIplParameters *qipl_copy;
> +
>       if (boot_mode == ZIPL_BOOT_MODE_UNSPECIFIED) {
>           boot_mode = zipl_mode(iplb->hdr_flags);
>       }
> @@ -281,14 +316,40 @@ static void ipl_boot_device(void)
>           panic("Need at least one certificate for secure boot!");
>       }
>   
> +    if (boot_mode == ZIPL_BOOT_MODE_NORMAL) {
> +        return;
> +    }
> +
> +    /*
> +     * Store copies of have_iplb, iplb and qipl.
> +     * They will be updated in load_next_iplb().
> +     */
> +    have_iplb_copy = have_iplb;
> +    iplb_copy = malloc(sizeof(IplParameterBlock));
> +    qipl_copy = malloc(sizeof(QemuIplParameters));

While IplParameterBlock is huge (4k), a malloc is justified for that. But 
QemuIplParameters is just a bunch of bytes (28 if I counted correctly), so I 
think it would be nicer to use a stack variable for that instead.

  Thomas

> +    memcpy(qipl_copy, &qipl, sizeof(QemuIplParameters));
> +    memcpy(iplb_copy, iplb, sizeof(IplParameterBlock));
> +
> +    while (have_iplb_copy) {
> +        if (have_iplb_copy && find_boot_device()) {
> +            validate_secure_boot_device();
> +        }
> +        have_iplb_copy = load_next_iplb();
> +    }
> +
> +    memcpy(&qipl, qipl_copy, sizeof(QemuIplParameters));
> +    memcpy(iplb, iplb_copy, sizeof(IplParameterBlock));
> +
> +    free(qipl_copy);
> +    free(iplb_copy);
> +}


