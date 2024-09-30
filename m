Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6552ECF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 12:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svFZq-0006D8-1v; Mon, 30 Sep 2024 08:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svFZX-00067q-Lo
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:32:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svFZT-0003qA-Q2
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727699530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=K1fxgswvmt4vnUCpv6T/e9kvIB0GgmrR3JEpc6xnhx8=;
 b=EJhIODxKt2fRtkFApGdFtEPY7Bp1T1DMaP3nBgfp0kP6HdyHQN0u8ukY8e8xSCysxZu5BP
 YT3PKUtlP8nrbRpn3qhprs0WAATRCzfN8B7ztMSuwt3GGaSE1tRKZSNBl227ZAxGptpjDC
 NOuoHyME9kMIg767c9yKPnrOsMlM72M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-O4SNn5hiNROrLgHLVIoVuA-1; Mon, 30 Sep 2024 08:32:05 -0400
X-MC-Unique: O4SNn5hiNROrLgHLVIoVuA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37ccc96d3e6so1640142f8f.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 05:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727699524; x=1728304324;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K1fxgswvmt4vnUCpv6T/e9kvIB0GgmrR3JEpc6xnhx8=;
 b=PlkTFzEhRHgUwbkRN1ZdL3Md97s+6Tzpn0CXxWPQGZyvC7dv4sFHDqYKXKy7EYfqVZ
 l9yhFwOv7RUGLDSGfeiVfxGaz+7L8E97qXsyGyyN6lxN5ihD8o7GS2OrBah85pYuiCr5
 9eSPsQTVVCgmCrCG35pTu+K7SNWFn9InZoU9NgBe53Qwv1h4/29qPCYzm/OnKs1CdIdr
 2Ejf5fE9lwk5IoGtLH8WIKVTXeRRlwcbKcg3uvO9wLVnGXg/wVSDHBiuIgrcOl18WIXD
 hT0h7kCVQRnTxcmi78TfFJswz6jJ0u9w8Y/BKCh4cKZH3suDpcEdh+Jv+hmE0/wQW1+g
 dcmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/Sy6iPztEZXnLF6ZFaaHsUcNyxSTl584guxbrr/6mmUsG2tAZFnO0Oxfqbey21pb8DmuhwLf6xHhw@nongnu.org
X-Gm-Message-State: AOJu0Yyj4brz4iCGI6IsZ9uiTgjhb1G/vmyNBgs1aZK3yozlJysZmhrs
 jYY1agq2idfMZbTRPfyZ+zJAPHljVkFzyyNQ2D99KNSr9H5KgFUnjohXoiCVJ1biZSDCQ0I+qU5
 jTEws96EMx4rhZuVXbsNc7Gw0bs1FBozzP86cjRSc6I8ps7Y6pX2R
X-Received: by 2002:a5d:554e:0:b0:37c:d20d:447c with SMTP id
 ffacd0b85a97d-37cd5ab758emr6956587f8f.29.1727699524336; 
 Mon, 30 Sep 2024 05:32:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrzcQdpewlO77c2w94P9ZZJJVnxL1o6TMW4auYzRtFyc1RI42eE8oPJl1TH0YtfTKPxwJSKA==
X-Received: by 2002:a5d:554e:0:b0:37c:d20d:447c with SMTP id
 ffacd0b85a97d-37cd5ab758emr6956572f8f.29.1727699523856; 
 Mon, 30 Sep 2024 05:32:03 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-176.web.vodafone.de.
 [109.42.48.176]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd572fbebsm8963338f8f.72.2024.09.30.05.32.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Sep 2024 05:32:03 -0700 (PDT)
Message-ID: <344b4f1b-8d51-4e32-8d9b-88bc71b0d3bd@redhat.com>
Date: Mon, 30 Sep 2024 14:32:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/18] pc-bios/s390x: Enable multi-device boot loop
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20240927005117.1679506-1-jrossi@linux.ibm.com>
 <20240927005117.1679506-18-jrossi@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240927005117.1679506-18-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
> Allow attempts to boot from multiple IPL devices. If the first device fails to
> IPL, select the pre-built IPLB for the next device in the boot order and attempt
> to IPL from it. Continue this process until IPL is successful or there are no
> devices left to try.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> 
> ---
...
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index d7c457e0ed..e38eedd83a 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -23,7 +23,7 @@ static SubChannelId blk_schid = { .one = 1 };
>   static char loadparm_str[LOADPARM_LEN + 1];
>   QemuIplParameters qipl;
>   IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
> -static bool have_iplb;
> +bool have_iplb;
>   static uint16_t cutype;
>   LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
>   
> @@ -55,6 +55,12 @@ void write_iplb_location(void)
>       }
>   }
>   
> +static void copy_qipl(void)
> +{
> +    QemuIplParameters *early_qipl = (QemuIplParameters *)QIPL_ADDRESS;
> +    memcpy(&qipl, early_qipl, sizeof(QemuIplParameters));
> +}
> +
>   unsigned int get_loadparm_index(void)
>   {
>       return atoi(loadparm_str);
> @@ -152,6 +158,7 @@ static void menu_setup(void)
>   
>       /* If loadparm was set to any other value, then do not enable menu */
>       if (memcmp(loadparm_str, LOADPARM_EMPTY, LOADPARM_LEN) != 0) {
> +        menu_set_parms(qipl.qipl_flags && ~BOOT_MENU_FLAG_MASK, 0);
>           return;
>       }
>   
> @@ -183,7 +190,10 @@ static void css_setup(void)
>   static void boot_setup(void)
>   {
>       char lpmsg[] = "LOADPARM=[________]\n";
> -    have_iplb = store_iplb(&iplb);
> +
> +    if (!have_iplb) {
> +        have_iplb = store_iplb(&iplb);
> +    }
>   
>       if (memcmp(iplb.loadparm, "@@@@@@@@", LOADPARM_LEN) != 0) {
>           ebcdic_to_ascii((char *) iplb.loadparm, loadparm_str, LOADPARM_LEN);
> @@ -191,6 +201,10 @@ static void boot_setup(void)
>           sclp_get_loadparm_ascii(loadparm_str);
>       }
>   
> +    if (have_iplb) {
> +        menu_setup();
> +    }
> +
>       memcpy(lpmsg + 10, loadparm_str, 8);
>       puts(lpmsg);
>   
> @@ -208,6 +222,7 @@ static bool find_boot_device(void)
>   
>       switch (iplb.pbt) {
>       case S390_IPL_TYPE_CCW:
> +        vdev->scsi_device_selected = false;
>           debug_print_int("device no. ", iplb.ccw.devno);
>           blk_schid.ssid = iplb.ccw.ssid & 0x3;
>           debug_print_int("ssid ", blk_schid.ssid);
> @@ -231,15 +246,8 @@ static bool find_boot_device(void)
>   static int virtio_setup(void)
>   {
>       VDev *vdev = virtio_get_device();
> -    QemuIplParameters *early_qipl = (QemuIplParameters *)QIPL_ADDRESS;
>       int ret;
>   
> -    memcpy(&qipl, early_qipl, sizeof(QemuIplParameters));
> -
> -    if (have_iplb) {
> -        menu_setup();
> -    }
> -
>       switch (vdev->senseid.cu_model) {
>       case VIRTIO_ID_NET:
>           puts("Network boot device detected");
> @@ -281,41 +289,19 @@ static void ipl_boot_device(void)
>       }
>   }
>   
> -/*
> - * No boot device has been specified, so we have to scan through the
> - * channels to find one.
> - */
> -static void probe_boot_device(void)
> -{
> -    int ssid, sch_no, ret;
> -
> -    for (ssid = 0; ssid < 0x3; ssid++) {
> -        blk_schid.ssid = ssid;
> -        for (sch_no = 0; sch_no < 0x10000; sch_no++) {
> -            ret = is_dev_possibly_bootable(-1, sch_no);
> -            if (ret < 0) {
> -                break;
> -            }
> -            if (ret == true) {
> -                ipl_boot_device(); /* Only returns if unsuccessful */
> -                return;
> -            }
> -        }
> -    }
> -
> -    puts("Could not find a suitable boot device (none specified)");
> -}
> -
>   void main(void)
>   {
> +    copy_qipl();
>       sclp_setup();
>       css_setup();
> -    boot_setup();
> -    if (have_iplb && find_boot_device()) {
> -        ipl_boot_device();
> -    } else {
> -        probe_boot_device();
> -    }
> +    do {
> +        boot_setup();
> +        if (have_iplb && find_boot_device()) {
> +            ipl_boot_device();
> +        }
> +        have_iplb = load_next_iplb();
> +    } while (have_iplb);
> +
> +    panic("No suitable device for IPL. Halting...");
>   
> -    panic("Failed to IPL. Halting...");
>   }

Can we please keep the possibility to boot from any device (i.e. the 
probe_boot_device() stuff), in case the user did not specify any boot index 
property at all?

  Thanks,
   Thomas


