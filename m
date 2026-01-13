Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D655BD29DE8
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 08:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfZsq-0008G0-Ac; Tue, 13 Jan 2026 03:36:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfZso-0008Bl-KD
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 03:36:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfZsm-0000pq-FC
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 03:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768293367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lun3fTJhTxxrjMIhDVtfnUDHVn1uEc8YvS/Pya/c6g8=;
 b=S/XNyA4rTOpRkjv0IOTO8jVMr6jk1jbL+TXYuEr2dvOMBhkGoXyUyQ6j8PHVVtxbunax0D
 5fD0kdzeUJOwUa90bb4Erg2Pf8l9gRdtXnXVlGzbH5TCdqLUtD2HiK5agr5GiPI2PeESXA
 tR6BIF+Z0TJvaShX/rA/diHQqg5V36k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-KNtYeGQuMluDn1tXJWSzaw-1; Tue, 13 Jan 2026 03:36:05 -0500
X-MC-Unique: KNtYeGQuMluDn1tXJWSzaw-1
X-Mimecast-MFC-AGG-ID: KNtYeGQuMluDn1tXJWSzaw_1768293365
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b871403f69eso242304566b.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 00:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768293364; x=1768898164; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=lun3fTJhTxxrjMIhDVtfnUDHVn1uEc8YvS/Pya/c6g8=;
 b=fYApO5NZ3/ZVnthuq5Ex5IqQudGvRYuvYGijxsqGHk2/BH2SaaRoRK37TssZmNd56c
 eNU0ovnNBjNyT6/KtKi5tq1+QcocIw/CS++2HBiyiNiCJFh8He7e/pj2yLX5ZaLCIeug
 Dy53/l0A0n1emcaprrwEaBwgqqJAjlYS4PQ7PsGsM/7pXcmKX9LnXcO5nYjDYvgZLbpx
 nPZVaoGsf2GpdU7B38mmoDlAwa1TY6T3wiiPTUwrh/uPSoDab19UlGLFm+iKgI5eUBFZ
 X/YgN6ODZqajTI1lRE9eVAA0jW73mH4APpnlO9mB67Hf/UkWdnKPm1Lh1QKySxaHJ80y
 /20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768293364; x=1768898164;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lun3fTJhTxxrjMIhDVtfnUDHVn1uEc8YvS/Pya/c6g8=;
 b=dLVeB176pkaMF4uFIbNGYEN8FCZz+4/vuhgg6kgCqcXmW3YyYKd6jOokyIfVULFlzq
 O9FHFjWuxzYtekew+dsVGfecpCBtndPrzpnoO3vqqyotNZ8uc2rySAbktvGBCjuOifZ5
 H90uE/m3gmxQfWiXh+HhHzUF7gz+zwqeFiWUQ+m8Ow6AxFeU+JQowoYTApPZ5hllapmq
 rYKLHZPorfcd+B/d9XvZ0axYTmU9Zya6shPTEgIt0R1XfCB2aC5S9sbACUn/WcNU61oM
 Ym2kcssNiJywrX5KpESDUE+eMWjf5e4A5G41YRd7QrdDSJsRklsfpEWFw+4jQ1RYVEV7
 /Q0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0N91y1UXyBH0B11JFiY2QtTH6B3h7YUrKkvlMYRKobauxTQX4rYKypwJSA9x4cHgkt+geB537jU+f@nongnu.org
X-Gm-Message-State: AOJu0YzzEkrLc7xZYN3P+Joun9XipxViRQh9D6prP1w2iVqma3WSTk7A
 eWzaCOzid5fGukikCMpNufQ5iWDpOe2mFNRKw24vdXDBON9Fb07Z1iSYxzlQsCmDAfgkOA84Uey
 5mx1EHbe+X1Nip7Wt1KF0i98EbLaymz/B0V964BF5V8QbcwkvV4SKXKYp
X-Gm-Gg: AY/fxX7YGlEqKLMaDaWfaJLyoEVN0jt/vrBQCbpxHF93mbWafFa+OaDbXPpZ3m4BmMe
 6opwq/nMS86q+KG73Sxc1xxfmQ2bhKGPKbm8c1oVmb2kPuVdZBRzLjaukNOVOtY3VerVc9nBdlk
 lw1wuPQy+b4+NEM0K/kUH82cWc0Ul9N0hWq2diahwiePrG2aLJZJ353vUpjuTQUNyp40zp2k1W4
 IZF/+qwjhX2cV2MzRKC+wJluPJnUEXLpNV75RhsILCAwaEdzbeJkuvE3MGZtEWDGld/FcXLyX/U
 fEey0gk/q4xfF0RIMckaFYh5cAE8Lno9febAiFDg6OeLn7Oqt1luVrOm8BA7Gb8Fk72jGQKyFqb
 nfwxsmoQ=
X-Received: by 2002:a17:907:1b0f:b0:b76:3bfd:8afe with SMTP id
 a640c23a62f3a-b8445179e0bmr2024416066b.5.1768293364412; 
 Tue, 13 Jan 2026 00:36:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG41GUwsghzlBtoaRCRIXLA5/7GNUZwlsSeTozobtnq4SfZSofa3UmN5gZbVdUJSCD4qafyPQ==
X-Received: by 2002:a17:907:1b0f:b0:b76:3bfd:8afe with SMTP id
 a640c23a62f3a-b8445179e0bmr2024412766b.5.1768293363739; 
 Tue, 13 Jan 2026 00:36:03 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf66214sm19342355a12.27.2026.01.13.00.36.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 00:36:03 -0800 (PST)
Message-ID: <2b0560ce-cbc4-41e1-84f5-aeb9b10c3a91@redhat.com>
Date: Tue, 13 Jan 2026 09:36:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 25/29] pc-bios/s390-ccw: Handle secure boot with
 multiple boot devices
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-26-zycai@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251208213247.702569-26-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 08/12/2025 22.32, Zhuoying Cai wrote:
> The current approach to enable secure boot relies on providing
> secure-boot and boot-certs parameters of s390-ccw-virtio machine
> type option, which apply to all boot devices.
> 
> With the possibility of multiple boot devices, secure boot expects all
> provided devices to be supported and eligible (e.g.,
> virtio-blk/virtio-scsi using the SCSI scheme).

Just double-checking: Wouldn't it be easier to do this on the QEMU side 
already? Or is there something in a spec somewhere saying that this has to 
be done by the guest?

> If multiple boot devices are provided and include an unsupported (e.g.,
> ECKD, VFIO) or a non-eligible (e.g., Net) device, the boot process will
> terminate with an error logged to the console.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/bootmap.c  | 31 +++++++++-------
>   pc-bios/s390-ccw/main.c     | 73 ++++++++++++++++++++++++++++++++++---
>   pc-bios/s390-ccw/s390-ccw.h |  1 +
>   3 files changed, 86 insertions(+), 19 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index cc9a8cec6a..e3c12697e0 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -1139,25 +1139,35 @@ ZiplBootMode zipl_mode(uint8_t hdr_flags)
>       return ZIPL_BOOT_MODE_NORMAL;
>   }
>   
> +int zipl_check_scsi_mbr_magic(void)
> +{
> +    ScsiMbr *mbr = (void *)sec;
> +
> +    /* Grab the MBR */
> +    memset(sec, FREE_SPACE_FILLER, sizeof(sec));

Mixing different pointer types that point to the same buffer always make me 
nervous - with regards to GCC's strict aliasing optimizations.
(see e.g. 
https://stackoverflow.com/questions/98650/what-is-the-strict-aliasing-rule 
if you don't know that yet).

Since you're only interested in the MBR magic here, I suggest to replace the 
above memset with:

     memset(mbr->magic, FREE_SPACE_FILLER, sizeof(mbr->magic));

That's certainly less risky and also faster.

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
> @@ -1168,11 +1178,6 @@ void zipl_load(void)
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
> index 5cea9d3ac7..7ce4761d34 100644
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
> +        panic("Passthrough (vfio) CCW device does not support secure boot!");
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
> +    QemuIplParameters qipl_copy;
> +
>       if (boot_mode == ZIPL_BOOT_MODE_UNSPECIFIED) {
>           boot_mode = zipl_mode(iplb->hdr_flags);
>       }
> @@ -281,14 +316,38 @@ static void ipl_boot_device(void)
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

Please add:

     IPL_assert(iplb_copy != NULL, "out of memory");

or so.

> +    memcpy(&qipl_copy, &qipl, sizeof(QemuIplParameters));
> +    memcpy(iplb_copy, iplb, sizeof(IplParameterBlock));
> +
> +    while (have_iplb_copy) {
> +        if (have_iplb_copy && find_boot_device()) {
> +            validate_secure_boot_device();
> +        }
> +        have_iplb_copy = load_next_iplb();
> +    }
> +
> +    memcpy(&qipl, &qipl_copy, sizeof(QemuIplParameters));
> +    memcpy(iplb, iplb_copy, sizeof(IplParameterBlock));
> +
> +    free(iplb_copy);
> +}

Do we really have to check all devices in advance here? I don't quite get 
the logic here yet, if we check the MBR of each and every disk in advance, 
that means that each of the devices has to be bootable in secure mode. But 
what sense does it make to specify multiple devices if all of them are 
bootable, i.e. we will always boot from the first given device?

Should we maybe rather simply disallow multiple boot devices from the QEMU 
side already and only allow one bootable device when running in secure mode?

  Thomas


> +static void ipl_boot_device(void)
> +{
>       switch (cutype) {
>       case CU_TYPE_DASD_3990:
>       case CU_TYPE_DASD_2107:
> -        if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT ||
> -            boot_mode == ZIPL_BOOT_MODE_SECURE) {
> -            panic("Passthrough (vfio) CCW device does not support secure boot!");
> -        }
> -
>           dasd_ipl(blk_schid, cutype);
>           break;
>       case CU_TYPE_VIRTIO:
> @@ -338,6 +397,8 @@ void main(void)
>           probe_boot_device();
>       }
>   
> +    check_secure_boot_support();
> +
>       while (have_iplb) {
>           boot_setup();
>           if (have_iplb && find_boot_device()) {
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index 389cc8ea7c..3009104686 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -93,6 +93,7 @@ typedef enum ZiplBootMode {
>   extern ZiplBootMode boot_mode;
>   
>   ZiplBootMode zipl_mode(uint8_t hdr_flags);
> +int zipl_check_scsi_mbr_magic(void);
>   
>   /* jump2ipl.c */
>   void write_reset_psw(uint64_t psw);


