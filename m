Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD893D2C54E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 13:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Ehs-0000T2-RF; Tue, 22 Oct 2024 09:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3Ehp-0000Se-7s
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 09:13:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3Ehl-00064p-VS
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 09:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729602823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7FUiy2SOO4Qvkcg20FmEbndUxjqJdQWEOR65bLnLnGY=;
 b=EEqQSO1m8GFBwDIgToB/aMYqG0GQGZL/enzPHVDxzbqSzLnSDFNKD2EpeKKIvAT2B9QVCJ
 +cq3ghSiuVW8dB8C7jQB8NhPNCe2UOj4pSqF5LD51VCXtrDx5rH0CqnjRfnqPLQXS0swPk
 u4NogIfe+eKtxy+ory9S/XmIjFz3NzI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-abnbsJJCMpanOf-67wNrSQ-1; Tue, 22 Oct 2024 09:13:41 -0400
X-MC-Unique: abnbsJJCMpanOf-67wNrSQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4315cefda02so41531245e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 06:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729602820; x=1730207620;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7FUiy2SOO4Qvkcg20FmEbndUxjqJdQWEOR65bLnLnGY=;
 b=otB2A37jOGSdD86KoNlu057poQPIG+883CSkLoDF/RfetbSuROQ63mQ47QsF3FmOcb
 ZLJ7467AKLDnCRsP/7r1uaG13zbYZTUBQQgztMahoAFSpcRff0dJ/zkjUn+WbP95uRl/
 9QdOwM7jvpxkD4WQsFgjGSYlb3psjSRh+yZ0BfFVV9E4fGyJ/GXHxe4IsOLHQCsHVstm
 yyZj18MsVxqS/o4e54V4ToTlII3CYFyMNX19CYz542QN+mEDjrrIX9IV0c8LcnruPBmG
 UWCMXyJsjMCn4YZnlvNUa76n1TgAkS+ttIDurXQJUh/DewsqIWcnYz40fgqvKTC+hzql
 GcDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQJJRkXIEkiKLPzkq+PDuG4uLTpQpjgveRdqVVeVQp8juTznm4LTMGr8CtvBpozvnfpLgG0hpk7TWW@nongnu.org
X-Gm-Message-State: AOJu0YzlwMY+loZMAaIqmB4ICqY/Gsxct1zDh4dksY7PSXJXDKAe9If5
 yqowB1fLtBwgfiC+yKc5PL7KnbN6tTu+AXPemg1F8Jro1iymRza4ivJsXEh6MguNWBEMEmJDLcm
 AM+xiOyemA+DEYqbUZDXIZjJmCIZDcrJVBrfCceXIUV0TwxphQwsS
X-Received: by 2002:a05:600c:1d9b:b0:431:7c78:b885 with SMTP id
 5b1f17b1804b1-4317ca9809bmr17382585e9.4.1729602820393; 
 Tue, 22 Oct 2024 06:13:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCfigvsEowrajaH7z5ZRiC4JRWkvYYHmko0X1rt1vY/Y0i/NyVTHX/HeAVWxJiu/HiC009/Q==
X-Received: by 2002:a05:600c:1d9b:b0:431:7c78:b885 with SMTP id
 5b1f17b1804b1-4317ca9809bmr17382345e9.4.1729602819861; 
 Tue, 22 Oct 2024 06:13:39 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-40-241-30.web.vodafone.de.
 [109.40.241.30]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4317dde77a5sm11845625e9.1.2024.10.22.06.13.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 06:13:39 -0700 (PDT)
Message-ID: <9891e2f8-c5b9-4bc6-84a3-dd0b49920cc6@redhat.com>
Date: Tue, 22 Oct 2024 15:13:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/19] hw/s390x: Build an IPLB for each boot device
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20241020012953.1380075-1-jrossi@linux.ibm.com>
 <20241020012953.1380075-16-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241020012953.1380075-16-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
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

On 20/10/2024 03.29, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Build an IPLB for any device with a bootindex (up to a maximum of 8 devices).
> 
> The IPLB chain is placed immediately before the BIOS in memory. Because this
> is not a fixed address, the location of the next IPLB and number of remaining
> boot devices is stored in the QIPL global variable for possible later access by
> the guest during IPL.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
...
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 656996b500..ed152a9dd2 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -56,6 +56,13 @@ static bool iplb_extended_needed(void *opaque)
>       return ipl->iplbext_migration;
>   }
>   
> +/* Place the IPLB chain immediately before the BIOS in memory */
> +static uint64_t find_iplb_chain_addr(uint64_t bios_addr, uint16_t count)
> +{
> +    return (bios_addr & TARGET_PAGE_MASK)
> +            - (count * sizeof(IplParameterBlock));
> +}
> +
>   static const VMStateDescription vmstate_iplb_extended = {
>       .name = "ipl/iplb_extended",
>       .version_id = 0,
> @@ -398,6 +405,17 @@ static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
>       return ccw_dev;
>   }
>   
> +static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
> +{
> +    S390IPLState *ipl = get_ipl_device();
> +    uint16_t count = ipl->qipl.chain_len;

I ran into problems when running the cdrom-test on my x86 laptop.

I think the above line needs to be changed into this to get it working on 
little endian hosts:

     uint16_t count = be16_to_cpu(ipl->qipl.chain_len)


> +    uint64_t len = sizeof(IplParameterBlock) * count;
> +    uint64_t chain_addr = find_iplb_chain_addr(ipl->bios_start_addr, count);
> +
> +    cpu_physical_memory_write(chain_addr, iplb_chain, len);
> +    return chain_addr;
> +}
> +
>   void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp)
>   {
>       int i;
> @@ -428,54 +446,51 @@ void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp)
>       }
>   }
>   
> -static bool s390_gen_initial_iplb(S390IPLState *ipl)
> +static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>   {
> -    DeviceState *dev_st;
> +    S390IPLState *ipl = get_ipl_device();
>       CcwDevice *ccw_dev = NULL;
>       SCSIDevice *sd;
>       int devtype;
>       uint8_t *lp;
>   
> -    dev_st = get_boot_device(0);
> -    if (dev_st) {
> -        ccw_dev = s390_get_ccw_device(dev_st, &devtype);
> -    }
> -
>       /*
>        * Currently allow IPL only from CCW devices.
>        */
> +    ccw_dev = s390_get_ccw_device(dev_st, &devtype);
>       if (ccw_dev) {
>           lp = ccw_dev->loadparm;
>   
>           switch (devtype) {
>           case CCW_DEVTYPE_SCSI:
>               sd = SCSI_DEVICE(dev_st);
> -            ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
> -            ipl->iplb.blk0_len =
> +            iplb->len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
> +            iplb->blk0_len =
>                   cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN - S390_IPLB_HEADER_LEN);
> -            ipl->iplb.pbt = S390_IPL_TYPE_QEMU_SCSI;
> -            ipl->iplb.scsi.lun = cpu_to_be32(sd->lun);
> -            ipl->iplb.scsi.target = cpu_to_be16(sd->id);
> -            ipl->iplb.scsi.channel = cpu_to_be16(sd->channel);
> -            ipl->iplb.scsi.devno = cpu_to_be16(ccw_dev->sch->devno);
> -            ipl->iplb.scsi.ssid = ccw_dev->sch->ssid & 3;
> +            iplb->pbt = S390_IPL_TYPE_QEMU_SCSI;
> +            iplb->scsi.lun = cpu_to_be32(sd->lun);
> +            iplb->scsi.target = cpu_to_be16(sd->id);
> +            iplb->scsi.channel = cpu_to_be16(sd->channel);
> +            iplb->scsi.devno = cpu_to_be16(ccw_dev->sch->devno);
> +            iplb->scsi.ssid = ccw_dev->sch->ssid & 3;
>               break;
>           case CCW_DEVTYPE_VFIO:
> -            ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
> -            ipl->iplb.pbt = S390_IPL_TYPE_CCW;
> -            ipl->iplb.ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
> -            ipl->iplb.ccw.ssid = ccw_dev->sch->ssid & 3;
> +            iplb->len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
> +            iplb->pbt = S390_IPL_TYPE_CCW;
> +            iplb->ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
> +            iplb->ccw.ssid = ccw_dev->sch->ssid & 3;
>               break;
>           case CCW_DEVTYPE_VIRTIO_NET:
> +            /* The S390IPLState netboot is true if ANY IPLB may use netboot */
>               ipl->netboot = true;
>               /* Fall through to CCW_DEVTYPE_VIRTIO case */
>           case CCW_DEVTYPE_VIRTIO:
> -            ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
> -            ipl->iplb.blk0_len =
> +            iplb->len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
> +            iplb->blk0_len =
>                   cpu_to_be32(S390_IPLB_MIN_CCW_LEN - S390_IPLB_HEADER_LEN);
> -            ipl->iplb.pbt = S390_IPL_TYPE_CCW;
> -            ipl->iplb.ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
> -            ipl->iplb.ccw.ssid = ccw_dev->sch->ssid & 3;
> +            iplb->pbt = S390_IPL_TYPE_CCW;
> +            iplb->ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
> +            iplb->ccw.ssid = ccw_dev->sch->ssid & 3;
>               break;
>           }
>   
> @@ -484,8 +499,8 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
>               lp = S390_CCW_MACHINE(qdev_get_machine())->loadparm;
>           }
>   
> -        s390_ipl_convert_loadparm((char *)lp, ipl->iplb.loadparm);
> -        ipl->iplb.flags |= DIAG308_FLAGS_LP_VALID;
> +        s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
> +        iplb->flags |= DIAG308_FLAGS_LP_VALID;
>   
>           return true;
>       }
> @@ -493,6 +508,62 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
>       return false;
>   }
>   
> +static bool s390_init_all_iplbs(S390IPLState *ipl)
> +{
> +    int iplb_num = 0;
> +    IplParameterBlock iplb_chain[7];
> +    DeviceState *dev_st = get_boot_device(0);
> +    Object *machine = qdev_get_machine();
> +
> +    /*
> +     * Parse the boot devices.  Generate an IPLB for only the first boot device
> +     * which will later be set with DIAG308.
> +     */
> +    if (!dev_st) {
> +        ipl->qipl.chain_len = 0;
> +        return false;
> +    }
> +
> +    /* If no machine loadparm was defined fill it with spaces */
> +    if (memcmp(S390_CCW_MACHINE(machine)->loadparm, NO_LOADPARM, 8) == 0) {
> +        object_property_set_str(machine, "loadparm", "        ", NULL);
> +    }
> +
> +    iplb_num = 1;
> +    s390_build_iplb(dev_st, &ipl->iplb);
> +
> +    /*  Index any fallback boot devices */
> +    while (get_boot_device(iplb_num)) {
> +        iplb_num++;
> +    }
> +
> +    if (iplb_num > MAX_BOOT_DEVS) {
> +        warn_report("Excess boot devices defined! %d boot devices found, "
> +                    "but only the first %d will be considered.",
> +                    iplb_num, MAX_BOOT_DEVS);
> +
> +        iplb_num = MAX_BOOT_DEVS;
> +    }
> +
> +    ipl->qipl.chain_len = iplb_num - 1;

... and this needs to be changed into:

     ipl->qipl.chain_len = cpu_to_be16(iplb_num - 1);

> +    /*
> +     * Build fallback IPLBs for any boot devices above index 0, up to a
> +     * maximum amount as defined in ipl.h
> +     */
> +    if (iplb_num > 1) {
> +        /* Start at 1 because the IPLB for boot index 0 is not chained */
> +        for (int i = 1; i < iplb_num; i++) {
> +            dev_st = get_boot_device(i);
> +            s390_build_iplb(dev_st, &iplb_chain[i - 1]);
> +        }
> +
> +        ipl->qipl.next_iplb = s390_ipl_map_iplb_chain(iplb_chain);

And this needs to be change into:

     ipl->qipl.next_iplb = cpu_to_be64(s390_ipl_map_iplb_chain(iplb_chain));

I am already in progress of picking up your patches, so if you agree with my 
suggestions, I can fix it on my side, too.

  Thomas


> +    }
> +
> +    return iplb_num;
> +}


