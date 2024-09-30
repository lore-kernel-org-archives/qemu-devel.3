Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CE5CF6499
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 11:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svF3h-00077N-60; Mon, 30 Sep 2024 07:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svF3f-00076t-WA
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 07:59:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svF3e-0007Ye-6T
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 07:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727697557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eLIeqm6jYEGcH1k/wGtF4KSKAbH+2lw4pKvMHDRt40A=;
 b=MsZ7DhgpYU80bD2CZqjGwWzeq/Zux9O0jJOsq22PmuGi6aPk31FDU3dwUDhMto472JlPpx
 aaeqj+izlrl1wYjJEH/QtC21KSkwoNwI0mLTgj383LbGlxIQ8rwEKxqeFtHjYRzV6aZ5md
 xTNfEytqgkpUXPzeEztYNQRcG3zeh7w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-BD_BIshINS2sPHfZ30E_NA-1; Mon, 30 Sep 2024 07:59:15 -0400
X-MC-Unique: BD_BIshINS2sPHfZ30E_NA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37cd4acb55aso2335826f8f.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 04:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727697555; x=1728302355;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eLIeqm6jYEGcH1k/wGtF4KSKAbH+2lw4pKvMHDRt40A=;
 b=lMx49zGuZdW6xqjxN/6JzrP7T38CyyzgcuwF5W8BXGLvnZZryLPxaMhl3ouiq3OsUT
 8wxDwEqSxAcBbFDPb8muJBIxCcT/hmyKRljqSwdh44NVFHpHH1Vdpq1DM0k7Af92vbeq
 OqBUxGjmV2WFCFMf9FCS5AZy5o1yfzfCL+6LsZ7DgdLq9Dkp0Sjgk5CScqqTvVkYAX/h
 Ga9S7k7jQENKahTqZ9uTSeECqV7lJZnKqcPC3v1Yp9j/JinXHLUULGNI9LlfMufQzZIs
 9hiEo4bGSCRB6nbwL4QAC0UoEDW2nHLPt6hSDVfNGyQz2N/eTwc31FZ0s21ieCqPBMIq
 uYsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqc0aiBHviZWRcbKcrF2PU/qsIIAvqCNBprqhnZAjb5/1weKQ5olVMnAn+gWh6OplVf9uBfOLzDeXO@nongnu.org
X-Gm-Message-State: AOJu0YwH2/6JLUIWbRZfJswd8Uto5Bfa4Ek5iKo13bxTUsT/Tt4DhAzG
 9tIkq7LmpXrkx9TehiQbBUnLPrOLP3ZaQRhkfMuUa11ydClqzs7cmwvsLtnr/hxn8m1xQNSX25V
 3hPpuaLHHYc3j6mqKa4Aim0DUWKVh9dY6GHalGGV9xulMK5jYJbUU
X-Received: by 2002:a5d:530c:0:b0:37c:d1fb:82f4 with SMTP id
 ffacd0b85a97d-37cd5b04d71mr10425118f8f.36.1727697554679; 
 Mon, 30 Sep 2024 04:59:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxgAyZxeQUZPLN2/UqDyH5ia8AveWJzwGbticiTwjNBS0IY5axbXr0s/251+OC9nLOi9zo3Q==
X-Received: by 2002:a5d:530c:0:b0:37c:d1fb:82f4 with SMTP id
 ffacd0b85a97d-37cd5b04d71mr10425104f8f.36.1727697554142; 
 Mon, 30 Sep 2024 04:59:14 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-176.web.vodafone.de.
 [109.42.48.176]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd5745696sm8850004f8f.106.2024.09.30.04.59.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Sep 2024 04:59:13 -0700 (PDT)
Message-ID: <b3674e3b-5a23-41a0-a100-7fb2810a2775@redhat.com>
Date: Mon, 30 Sep 2024 13:59:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/18] hw/s390x: Build an IPLB for each boot device
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20240927005117.1679506-1-jrossi@linux.ibm.com>
 <20240927005117.1679506-16-jrossi@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240927005117.1679506-16-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On 27/09/2024 02.51, jrossi@linux.ibm.com wrote:
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
> 

Note: There's an empty line below your SoB in most of your patch 
descriptions ... it's just cosmetics, but in case you touch the patch 
anyway, please remove it.

> ---
...
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
> @@ -493,6 +508,58 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
>       return false;
>   }
>   
> +static bool s390_init_all_iplbs(S390IPLState *ipl)
> +{
> +    int iplb_num = 0;
> +    IplParameterBlock iplb_chain[7];
> +    DeviceState *dev_st = get_boot_device(0);
> +
> +    /*
> +     * Parse the boot devices.  Generate an IPLB for the first boot device,
> +     * which will later be set with DIAG308. Index any fallback boot devices.
> +     */

The comment looks like it rather belongs to the whole function, and not to 
the if-statement below? So maybe move it at the top?

> +    if (!dev_st) {
> +        ipl->qipl.chain_len = 0;
> +        return false;
> +    }
> +
> +    iplb_num = 1;
> +    s390_build_iplb(dev_st, &ipl->iplb);
> +    ipl->iplb.flags |= DIAG308_FLAGS_LP_VALID;

Isn't DIAG308_FLAGS_LP_VALID set within s390_build_iplb() already?

> +    while (get_boot_device(iplb_num)) {
> +        iplb_num++;
> +    }

I'd maybe move the code block below to this spot here, so you've got to 
assign ipl->qipl.chain_len only once:

+    if (iplb_num > MAX_IPLB_CHAIN + 1) {
+        warn_report("Excess boot devices defined! %d boot devices found, "
+                    "but only the first %d will be considered.",
+                    iplb_num, MAX_IPLB_CHAIN + 1);
+
+        iplb_num = MAX_IPLB_CHAIN + 1;
+    }

> +    ipl->qipl.chain_len = iplb_num - 1;
> +
> +    /*
> +     * Build fallback IPLBs for any boot devices above index 0, up to a
> +     * maximum amount as defined in ipl.h
> +     */
> +    if (iplb_num > 1) {
> +        if (iplb_num > MAX_IPLB_CHAIN + 1) {
> +            warn_report("Excess boot devices defined! %d boot devices found, "
> +                        "but only the first %d will be considered.",
> +                        iplb_num, MAX_IPLB_CHAIN + 1);
> +
> +            ipl->qipl.chain_len = MAX_IPLB_CHAIN;
> +            iplb_num = MAX_IPLB_CHAIN + 1;
> +        }

i.e. move this code block -^
and remove the "ipl->qipl.chain_len = MAX_IPLB_CHAIN;" in there.

> +        /* Start at 1 because the IPLB for boot index 0 is not chained */
> +        for (int i = 1; i < iplb_num; i++) {
> +            dev_st = get_boot_device(i);
> +            s390_build_iplb(dev_st, &iplb_chain[i - 1]);
> +            iplb_chain[i - 1].flags |= DIAG308_FLAGS_LP_VALID;

Again, setting DIAG308_FLAGS_LP_VALID should not be necessary since it is 
already done in s390_build_iplb() ?

> +        }
> +
> +        ipl->qipl.next_iplb = s390_ipl_map_iplb_chain(iplb_chain);
> +    }
> +
> +    return iplb_num;
> +}
> +
>   static bool is_virtio_ccw_device_of_type(IplParameterBlock *iplb,
>                                            int virtio_id)
>   {
> @@ -620,7 +687,7 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
>                * this is the original boot device's SCSI
>                * so restore IPL parameter info from it
>                */
> -            ipl->iplb_valid = s390_gen_initial_iplb(ipl);
> +            ipl->iplb_valid = s390_build_iplb(get_boot_device(0), &ipl->iplb);
>           }
>       }
>       if (reset_type == S390_RESET_MODIFIED_CLEAR ||
> @@ -714,7 +781,9 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
>       if (!ipl->kernel || ipl->iplb_valid) {
>           cpu->env.psw.addr = ipl->bios_start_addr;
>           if (!ipl->iplb_valid) {
> -            ipl->iplb_valid = s390_gen_initial_iplb(ipl);
> +            ipl->iplb_valid = s390_init_all_iplbs(ipl);
> +        } else {
> +            ipl->qipl.chain_len = 0;
>           }
>       }
>       s390_ipl_set_boot_menu(ipl);

  Thomas


