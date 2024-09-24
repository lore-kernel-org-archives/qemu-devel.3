Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E670FCF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 08:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st12f-0000it-Cy; Tue, 24 Sep 2024 04:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1st12d-0000he-Q9
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 04:37:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1st12c-0002b6-DP
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 04:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727167020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rfMUqXO6ITrOFTtY48f3adVxnaUQkMn2zyEFSmxcMP8=;
 b=gljMTkg5as0Wy7USjj9AjBPJpqSJraWRKbfjd6vdJqSNue94dOyeXKKFpR6kECOeMr4pPt
 w1H41bwoAx87Bn3cpnBnJh5edIjOCkk4BGfsjC4/Ahp/VJm3Bh2qsoqf3OSuKO4LDuzftV
 UuqkGKS4RsuEmpxjNeXw9Hh0LPP+2Ak=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-IPsLhQzyNbKHw77eC5MPlQ-1; Tue, 24 Sep 2024 04:36:59 -0400
X-MC-Unique: IPsLhQzyNbKHw77eC5MPlQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a8d26b5857cso418688866b.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 01:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727167018; x=1727771818;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rfMUqXO6ITrOFTtY48f3adVxnaUQkMn2zyEFSmxcMP8=;
 b=QpYH65mmH3s/Nhnf08C0KgB/KbblP/SyZBH8HQs9WyygUIATgYt0VbdVrp/KgwpIGQ
 teHv2QklVRIoss+qxFBhjCvG0lzKEw/WEUgW513Vc1NmNDUdRgT3F5VVb4H0/0CMwYFE
 AKjWCxTxVKUPXgj7wQX/Ajn1c9A0FTGbAl7xWcKTevqQyhvoOv0j6WOwGIeYug5Uzgjz
 TBE1VSCeB4zXlhcP0zeMm7vc1NOAAaaPbVoG8q/Ey7kGUtsClvv5q+/706KJo3/DHVpd
 tdw5/WQsUdENWezO7Or5Bo/P1QqykekDaxOoh6n0ngPL630mgXZ8YDhAe5m9qXEvmB/3
 c/yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBPjgEXqkM8/n7B38NfmzKLnMvbOwFN2wdGI+BhbyDs0Vg1D23U74B0/F9XuXxonDilAoO2Gau6KMX@nongnu.org
X-Gm-Message-State: AOJu0YyxcHfLUjxN0xNrce1TtpCoua6p2JxUND3TCiUMbLpwJq1XElPE
 dduHhs7ym6xqgtHz5yX/6DB1fZzagLcW94+2GOmZsc+M1IpVM5Gxqyx6NYhU3v0Zd/V1ofEQy4e
 hw+DB7re1wtMr1DoKJYQwcNxq0rmshDA4yuextqraHCgySORSrrin
X-Received: by 2002:a17:907:e6a1:b0:a77:cf9d:f495 with SMTP id
 a640c23a62f3a-a90d5813b2fmr1571659766b.40.1727167018131; 
 Tue, 24 Sep 2024 01:36:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvcfy1Uum7K7uDFwVkIENTwGFKKlIHfa/QweyRbXsBnrZDjR5JDRfUionFhMPx8UEc7Q/5+g==
X-Received: by 2002:a17:907:e6a1:b0:a77:cf9d:f495 with SMTP id
 a640c23a62f3a-a90d5813b2fmr1571657366b.40.1727167017738; 
 Tue, 24 Sep 2024 01:36:57 -0700 (PDT)
Received: from [10.5.51.18] (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930cae67sm56425266b.121.2024.09.24.01.36.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2024 01:36:57 -0700 (PDT)
Message-ID: <3270bf81-eebb-451b-a1ed-bc53890498e1@redhat.com>
Date: Tue, 24 Sep 2024 10:36:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/23] hw/vfio/platform: Let
 vfio_start_eventfd_injection() take VFIOPlatformDevice pointer
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
 <20240923093016.66437-24-shentey@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240923093016.66437-24-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 9/23/24 11:30, Bernhard Beschow wrote:
> Avoids one downcast, making the code more type-safe.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

That's a bit unrelated to your e500 series. Anyhow,

Reviewed-by: Cédric Le Goater <clg@redhat.com>


Thanks,

C.


> ---
>   hw/vfio/platform.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index a85c199c76..77bbfbf62c 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -318,13 +318,12 @@ static void vfio_platform_eoi(VFIODevice *vbasedev)
>   /**
>    * vfio_start_eventfd_injection - starts the virtual IRQ injection using
>    * user-side handled eventfds
> - * @sbdev: the sysbus device handle
> + * @vdev: the VFIO platform device handle
>    * @irq: the qemu irq handle
>    */
>   
> -static void vfio_start_eventfd_injection(SysBusDevice *sbdev, qemu_irq irq)
> +static void vfio_start_eventfd_injection(VFIOPlatformDevice *vdev, qemu_irq irq)
>   {
> -    VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(sbdev);
>       VFIOINTp *intp;
>   
>       QLIST_FOREACH(intp, &vdev->intp_list, next) {
> @@ -417,7 +416,7 @@ fail_vfio:
>       kvm_irqchip_remove_irqfd_notifier(kvm_state, intp->interrupt, irq);
>       abort();
>   fail_irqfd:
> -    vfio_start_eventfd_injection(sbdev, irq);
> +    vfio_start_eventfd_injection(vdev, irq);
>       return;
>   }
>   


