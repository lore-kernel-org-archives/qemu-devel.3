Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76D9FA3741
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 10:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp3Vu-0007X1-4a; Fri, 13 Sep 2024 06:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sp3Vp-0007Ug-0h
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 06:26:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sp3Vn-0003Wx-Kr
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 06:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726223206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=W0wmGWtqmVxk02rNWMqPGnZXlsog05mTZFAKmWBpe64=;
 b=VdTYB4vtQvp/hZS+dCENzQr5GYKAFa7IRF7FtbkJ7jdYg2koCre1LcH1JLndxOhS7wNgDZ
 iU3Qld9pBEDM8f/rR7E5/VpD35to+lrftAsGAUAWCIKzzDhlQhppRdm/fxxnHhotebGpNX
 O4PXSvnIzfmqeLmo3FlF15/Yl87+RIU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-4dAjR4oVOOGSxU-doiqirQ-1; Fri, 13 Sep 2024 06:26:43 -0400
X-MC-Unique: 4dAjR4oVOOGSxU-doiqirQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2f7593fbcecso7938091fa.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 03:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726223201; x=1726828001;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W0wmGWtqmVxk02rNWMqPGnZXlsog05mTZFAKmWBpe64=;
 b=WQ8idSU+f+iD9kwkpZTfyaOQrIxn59pCUSNEKDfKLJ8cwLMaCwuEuLa7cuuTB83fHD
 fnhd0RoRqVT1qMttXD84XFjka663cP9iaVR5HoFli+A+fas8iecFUhThMymDCcob50+K
 ZWJziNzDskW57naZxRbpIwfyB9pR3FHySFKNSO6kU7gn61awFmLgnW+zwQUHRKvmnTZY
 1SYSjHrAll8Aa7BYKSibIItpMdFq+N72UmRRudGWkHt7TI/De9JmmC54sEYTuTj7hL6O
 N8xFxRZooWevvY8+3TTzxpg5503yY/oBuEjiZVOkO8ocG9TqgepeqwzHcuEZdtJmfp9N
 krvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0Z9f2Ff1VDCEIjLPXEsZp5t5qpfl+oyBc+3JQXNY3lLa2HuDd/yRKOORNQdWlz5rN93ELzxWaVq0X@nongnu.org
X-Gm-Message-State: AOJu0YxgWiwuk0ID8z4/cbh62a0a8JIVwlGpvZc/dKV27IpIdoaFIEXR
 DIxE2Xa1GVuFbUwhvJp0n6WXRc6yamzkyP32pcP2LzZQdzua1+7Q0PRURhKl2M/TTWsorWdhIBL
 wqxcEJ/AOVRirN/9UfTTmCOuzBRdtnDmlHAnZmA0f+h+7QXCyls2w
X-Received: by 2002:a05:651c:b11:b0:2ef:2ba5:d214 with SMTP id
 38308e7fff4ca-2f7918e4af7mr19476991fa.4.1726223201482; 
 Fri, 13 Sep 2024 03:26:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK0R+09wfiuu3URlzuiSAx3BfoOTmk1JP01JZAlVU7T2IFcvPcDaAxh8OO4aw7qeIggBlF6A==
X-Received: by 2002:a05:651c:b11:b0:2ef:2ba5:d214 with SMTP id
 38308e7fff4ca-2f7918e4af7mr19476651fa.4.1726223200804; 
 Fri, 13 Sep 2024 03:26:40 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-178-122.web.vodafone.de.
 [109.43.178.122]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd523b4sm7540507a12.51.2024.09.13.03.26.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2024 03:26:40 -0700 (PDT)
Message-ID: <b227d5e6-9566-4c35-9201-1617498bbf21@redhat.com>
Date: Fri, 13 Sep 2024 12:26:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/loongarch/virt: Add description for virt machine type
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Trivial
 <qemu-trivial@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>
References: <20240913095202.2007024-1-maobibo@loongson.cn>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240913095202.2007024-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 13/09/2024 11.52, Bibo Mao wrote:
> The description about virt machine type is removed by mistake, add
> new description here. Here is output result with command
> "./qemu-system-loongarch64 -M help"
> 
> Supported machines are:
> none                 empty machine
> virt                 QEMU LoongArch Virtual Machine (default)
> x-remote             Experimental remote machine
> 
> Without the patch, it shows as follows:
> Supported machines are:
> none                 empty machine
> virt                 (null) (default)
> x-remote             Experimental remote machine
> 
> Fixes: ef2f11454c(hw/loongarch/virt: Replace Loongson IPI with LoongArch IPI)
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/loongarch/virt.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 29040422aa..8e80110b24 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -1390,6 +1390,7 @@ static void virt_class_init(ObjectClass *oc, void *data)
>       mc->init = virt_init;
>       mc->default_cpu_type = LOONGARCH_CPU_TYPE_NAME("la464");
>       mc->default_ram_id = "loongarch.ram";
> +    mc->desc = "QEMU LoongArch Virtual Machine";
>       mc->max_cpus = LOONGARCH_MAX_CPUS;
>       mc->is_default = 1;
>       mc->default_kernel_irqchip_split = false;
> 
> base-commit: 4b7ea33074450bc6148c8e1545d78f179e64adb4

Reviewed-by: Thomas Huth <thuth@redhat.com>

CC:-ing qemu-stable for getting it fixed in the next stable release of 9.1, too.


