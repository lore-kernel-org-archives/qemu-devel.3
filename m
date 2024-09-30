Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB9DCF6499
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 12:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svFKG-0005wq-VA; Mon, 30 Sep 2024 08:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svFJw-0005ds-Ck
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:16:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svFJq-0001hF-OY
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727698561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RwN8BMGMCsRHMAX1I7a2uqACNWaZhGVwjYZLBxUvnSk=;
 b=eBoCqEm9HZ6ZxRtpuMkCH3bjdrglXLefnXlY779Xi1dDzAN3izo0HN+fKl0XO5xfuuA223
 YNkpApUvWYIemR1+ITQxbVcRDRSfgGWjaMw6Dat6AzbTkxvON0i648nPoancg+6lJj0rBc
 Ijx5CwV59NBIZ4x6Usdb6IZvPw7trQ0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-kzyCFaUcNtCc2FMzPdgtAQ-1; Mon, 30 Sep 2024 08:15:59 -0400
X-MC-Unique: kzyCFaUcNtCc2FMzPdgtAQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7a9a85e4a85so1030052685a.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 05:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727698559; x=1728303359;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RwN8BMGMCsRHMAX1I7a2uqACNWaZhGVwjYZLBxUvnSk=;
 b=ld+VUUPPFccZJxhPen2xxH6t3hVG9JKg5VHFjok+cs0eIIvzj7DTcw50O+EWoDNTaq
 lTPjIrsp+ojfWdJgyxhbDSVOzPD0v7sJGWZKRvr1uOfenkyr2YJjd98dPB/5TsjZmTwW
 1YM7vtNm8C61whAr3d5SKLRYiqhoRqwSOH43N3oxGKDmZoy6IyE5iPJR7APnR/ZGRbNl
 6uQKnxcpAE2yUfV892+2OmFKkgZNMWogy3/Wz+ZVcYX+6G9oy4XkLDhVezvZT9F+tXTV
 y3TbHznutDX/wWYkAequOu113KGMUf/IW8VmdoyvyZLhA9ImwcuZroa5Uc3+HIxzb3HO
 BuSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF5bJpHhyJmgi/iwCykB0/BuVlfNoj6OxAZa7bmL1uoP3Lvy9vCLlJFO9pdYRTZZ5WuJNpLQFLhX/Q@nongnu.org
X-Gm-Message-State: AOJu0YyXj1e1GqX2sieee18NTBqFLRDG/oq5345DHJRdjQMGzYMcC/Pb
 KOrzt775vzva9urag5r+1pBtnaNgdxlPpibaT8uvY1FiFYvwKMqDqEhOf1vkePUMy+kgVxA2Fny
 69BSMRJza4Fev4zSM256a2NKl5mwhRJlk7t4QIM4Yf1Zk1K2vHs4U
X-Received: by 2002:a05:620a:1987:b0:7a9:b4d2:9d70 with SMTP id
 af79cd13be357-7ae3783b22emr1863906785a.14.1727698558820; 
 Mon, 30 Sep 2024 05:15:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFziVmFQR9F7oiTKIlIp+1eMRukYKE8BJQ/ag+87yJ5OTGM1ZuI1COI0HvK6Nja4OwkA2SCQ==
X-Received: by 2002:a05:620a:1987:b0:7a9:b4d2:9d70 with SMTP id
 af79cd13be357-7ae3783b22emr1863903385a.14.1727698558410; 
 Mon, 30 Sep 2024 05:15:58 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-176.web.vodafone.de.
 [109.42.48.176]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae37858425sm401030485a.135.2024.09.30.05.15.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Sep 2024 05:15:57 -0700 (PDT)
Message-ID: <7fdb3ac0-7745-4d97-b575-867b068d17eb@redhat.com>
Date: Mon, 30 Sep 2024 14:15:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/18] s390x: Rebuild IPLB for SCSI device directly from
 DIAG308
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20240927005117.1679506-1-jrossi@linux.ibm.com>
 <20240927005117.1679506-17-jrossi@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240927005117.1679506-17-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 27/09/2024 02.51, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Because virtio-scsi type devices use a non-architected IPLB pbt code they cannot
> be set and stored normally. Instead, the IPLB must be rebuilt during re-ipl.
> 
> As s390x does not natively support multiple boot devices, the devno field is
> used to store the position in the boot order for the device.
> 
> Handling the rebuild as part of DIAG308 removes the need to check the devices
> for invalid IPLBs later in the IPL.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> 
> ---
...
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index ba66847b9c..86c995b580 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -448,7 +448,6 @@ void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp)
>   
>   static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>   {
> -    S390IPLState *ipl = get_ipl_device();
>       CcwDevice *ccw_dev = NULL;
>       SCSIDevice *sd;
>       int devtype;
> @@ -481,9 +480,6 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>               iplb->ccw.ssid = ccw_dev->sch->ssid & 3;
>               break;
>           case CCW_DEVTYPE_VIRTIO_NET:
> -            /* The S390IPLState netboot is true if ANY IPLB may use netboot */
> -            ipl->netboot = true;
> -            /* Fall through to CCW_DEVTYPE_VIRTIO case */
>           case CCW_DEVTYPE_VIRTIO:
>               iplb->len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
>               iplb->blk0_len =
> @@ -508,6 +504,16 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>       return false;
>   }
>   
> +
> +void s390_rebuild_iplb(uint16_t dev_index, IplParameterBlock *iplb) {

Please put the curly brace on a new line for function declarations.

> +    S390IPLState *ipl = get_ipl_device();
> +    uint16_t index;
> +    index = ipl->rebuilt_iplb ? ipl->iplb_index : dev_index;
> +
> +    ipl->rebuilt_iplb = s390_build_iplb(get_boot_device(index), iplb);
> +    ipl->iplb_index = index;
> +}
...
> @@ -661,35 +629,33 @@ IplParameterBlock *s390_ipl_get_iplb(void)
>       return &ipl->iplb;
>   }
>   
> -void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
> +static void s390_ipl_prepare_qipl(S390CPU *cpu)
>   {
>       S390IPLState *ipl = get_ipl_device();
> +    uint8_t *addr;
> +    uint64_t len = 4096;
> +
> +    addr = cpu_physical_memory_map(cpu->env.psa, &len, true);
> +    if (!addr || len < QIPL_ADDRESS + sizeof(QemuIplParameters)) {
> +        error_report("Cannot set QEMU IPL parameters");
> +        return;
> +    }
> +
> +    memcpy(addr + QIPL_ADDRESS, &ipl->qipl, sizeof(QemuIplParameters));
> +    cpu_physical_memory_unmap(addr, len, 1, len);
> +}

Why did you move the s390_ipl_prepare_qipl() function around? It does not 
seem to get moved in the new code below, so the movement does not seem to be 
required?

> +void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
> +{
> +    S390IPLState *ipl = get_ipl_device();
>       if (reset_type == S390_RESET_EXTERNAL || reset_type == S390_RESET_REIPL) {
>           /* use CPU 0 for full resets */
>           ipl->reset_cpu_index = 0;
>       } else {
>           ipl->reset_cpu_index = cs->cpu_index;
>       }
> -    ipl->reset_type = reset_type;
>   
> -    if (reset_type == S390_RESET_REIPL &&
> -        ipl->iplb_valid &&
> -        !ipl->netboot &&
> -        ipl->iplb.pbt == S390_IPL_TYPE_CCW &&
> -        is_virtio_scsi_device(&ipl->iplb)) {
> -        CcwDevice *ccw_dev = s390_get_ccw_device(get_boot_device(0), NULL);
> -
> -        if (ccw_dev &&
> -            cpu_to_be16(ccw_dev->sch->devno) == ipl->iplb.ccw.devno &&
> -            (ccw_dev->sch->ssid & 3) == ipl->iplb.ccw.ssid) {
> -            /*
> -             * this is the original boot device's SCSI
> -             * so restore IPL parameter info from it
> -             */
> -            ipl->iplb_valid = s390_build_iplb(get_boot_device(0), &ipl->iplb);
> -        }
> -    }
> +    ipl->reset_type = reset_type;
>       if (reset_type == S390_RESET_MODIFIED_CLEAR ||
>           reset_type == S390_RESET_LOAD_NORMAL ||
>           reset_type == S390_RESET_PV) {
> @@ -725,20 +691,6 @@ void s390_ipl_clear_reset_request(void)
>       ipl->reset_cpu_index = 0;
>   }
>   
> -static void s390_ipl_prepare_qipl(S390CPU *cpu)
> -{
> -    S390IPLState *ipl = get_ipl_device();
> -    uint8_t *addr;
> -    uint64_t len = 4096;
> -
> -    addr = cpu_physical_memory_map(cpu->env.psa, &len, true);
> -    if (!addr || len < QIPL_ADDRESS + sizeof(QemuIplParameters)) {
> -        error_report("Cannot set QEMU IPL parameters");
> -        return;
> -    }
> -    memcpy(addr + QIPL_ADDRESS, &ipl->qipl, sizeof(QemuIplParameters));
> -    cpu_physical_memory_unmap(addr, len, 1, len);
> -}
>

  Thomas



