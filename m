Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF88CF64B6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 13:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svG8d-0002Mn-RN; Mon, 30 Sep 2024 09:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svG8b-0002Kb-ID
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 09:08:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svG8Z-00081c-BR
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 09:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727701705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YtlK5ovkdeFBwumlO1XUbDm6T3maCPJLX5vX+pp6mZ8=;
 b=JEBpmhcXZoQTVu3W8clTLd7wzrIJxdObbbEGbtzkc7k7zQMuj/68IamMq3wtIcPztO2efY
 Prcn6lDiayk7eo+nYnWXZIRt/uyKjRxUL9rI5v63CNgP+Ym1avmu7woYoSaf/EEGbwksaR
 korO8voKQmY54gJCPfFKOFxXJ7/b15s=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-pWEuq0WhP0uYE1OrsZVHCA-1; Mon, 30 Sep 2024 09:08:24 -0400
X-MC-Unique: pWEuq0WhP0uYE1OrsZVHCA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7acb118ba04so48734585a.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 06:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727701704; x=1728306504;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YtlK5ovkdeFBwumlO1XUbDm6T3maCPJLX5vX+pp6mZ8=;
 b=QN2rQnQjwNKyScEtLs/hwn/LFlZuVu7YYAtogZLsAlSx1W4waaOqRNnSzZZpcezUiX
 s6Hq+1i+xWubv+TcNaS4CEjzvoa16g9tG3j1qsWZrVRb62DNZqbBExadg/jRrgr9jK4t
 hSuIbl+EEnD/RAVbylQt4mTWqw4oCbzgaCewt7arMaGIHkdlS/yUg60COMQw0f5gKrkk
 mCDJqWpNq/bmIChDOojmVp4T0SHfWdyVNngVd9ZiWBD8/TbHFOpYUb0yINRrmpIqdoor
 uSHwaeQNXD3bxUdz+ete1thrz6V2gVxy2cUhmivQduRJxclGCekTnJINbKXDCGeHzHWg
 K1Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRZcykzoKRe1AvKynzOUELBjnWEeym6Q1suly9x6DvRvA/KNYVu6udQI633yVe1T2u+6zxP8JLLqJs@nongnu.org
X-Gm-Message-State: AOJu0YyzwtGNlEiBMFt4Mw2+Jm2PldXgq37otqX6+724ZPEtlgCI/fFN
 PZE7VIg5xMxAfNROtx9gloU5QyweV95cZc6V3qtFriEmXGCBHj6cySVVmqOMjFjUB/c6hLSCwNZ
 ZogD/Th8sV3HHGVbXhKVkNy2IntjdhEHQpXf6iG2AgfoEVtlysd5hdOgT3psEVxs=
X-Received: by 2002:a05:620a:31a1:b0:7a9:be54:4b00 with SMTP id
 af79cd13be357-7ae378598aemr1905525485a.35.1727701704053; 
 Mon, 30 Sep 2024 06:08:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmNgevSArJlph21zB0RaZx3jS6qhh6tTGq12I3KgyZHzXMrDa3FUfZc3BilPOgW8iNuqMTyg==
X-Received: by 2002:a05:620a:31a1:b0:7a9:be54:4b00 with SMTP id
 af79cd13be357-7ae378598aemr1905520785a.35.1727701703665; 
 Mon, 30 Sep 2024 06:08:23 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-176.web.vodafone.de.
 [109.42.48.176]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae3782cd54sm411350785a.94.2024.09.30.06.08.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Sep 2024 06:08:23 -0700 (PDT)
Message-ID: <6c85a009-284b-4fe1-8bab-06d55137090f@redhat.com>
Date: Mon, 30 Sep 2024 15:08:19 +0200
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

That looks supsicious ... did you mean just one "&" instead of "&&" here?

>           return;
>       }

  Thomas


