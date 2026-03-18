Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B86B103E16B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 12:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2prF-00059U-AH; Wed, 18 Mar 2026 08:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w2pr6-00058k-UT
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 08:18:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w2pr2-0000hc-QB
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 08:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773836302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1OySJbJSgKJsQ9il6G39vmwFA8l7iqFnTjBX9p53j9Q=;
 b=W499/7SxiyGGU9xPuq+yzxPkjvicxi25h1Zk57KIikbO2OwuI204ScH0BzoUwnGMyMcFd1
 mS2go5B72R9T6B1NoGYOXYOui+oG0j2XzEZNtq032jGs7pTadVaAoZ0pdDN/TrZEGEBhTZ
 d1HlZ8gOY8rF7wxuKH9jpYTBs3YrLRU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-3XYJQftHO9uaExodRqg5LA-1; Wed, 18 Mar 2026 08:18:19 -0400
X-MC-Unique: 3XYJQftHO9uaExodRqg5LA-1
X-Mimecast-MFC-AGG-ID: 3XYJQftHO9uaExodRqg5LA_1773836298
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4853f33b7dbso59853965e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 05:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773836298; x=1774441098; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=1OySJbJSgKJsQ9il6G39vmwFA8l7iqFnTjBX9p53j9Q=;
 b=qSBQJMhAa/2WZWeNkDIoriZoW95KY6yr18/dTuZEJwvYVWD+7+ceBspAUNVCwoXXjr
 UXXEQbfd1Z04zTL8mMl/g4MJiPGQe+V1l6KnPwJvDpsharg2H7RsSJwfjwhx4V2nvN4v
 NFUCjvbJa/5WYlVS/ywwUy93ANMnJXFmQZdfi/CfQE14KgsWG1Em704OKvr6kHE9K4+Q
 8VF3xT2XTLHGr0IzMIU1HfaqZZoukbeVIVJ4hx3BqFVByjVkRu7/Wb0rf7OvDJuyIZBk
 gAUFHGXVhnqGPa2qcw9dkE+pkoJX4zC3UCUmDuqMc6NuDrGoLPnz/Fvo3nzJrUuFEoNo
 50EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773836298; x=1774441098;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1OySJbJSgKJsQ9il6G39vmwFA8l7iqFnTjBX9p53j9Q=;
 b=jG+JGfBTYQWOYej1OS7PVMBEu/hamemECJy/5XeVA4ZlX69RiHLWPF8NczF3fCUGjy
 ZeHgmpVUbSX4Y95+FX3zgXasBinsXfGD891/9RhhiSLRW88eayo6dN+NzUZsemref6Bi
 RD9KYrMXYdLKnLYO6CGvaQVO3eIw1OGsGNhFqgetvip5UQELOBY3iMp6d8fbIC/A84oz
 Ie2Wot2DxFE3kHVC7YIzxCCfbinG4zc5Z8ZIQ/QX1Sc0uEzCbFUqRPwZkIJlZ4YjJLRG
 B94/ouYVqNrCWjL/GyNTajAhXRHUlJzEZ4zXbSxe7WIpof8FerOG/a/hI5n69ee9zYxs
 jRDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMRGnrMAcOYcGqu2HM0oCYmX5wvTcXSaXqDgOpfL4UYa+1bAPXMDQL0DcCipnz40KxFWqPqmk0VEAB@nongnu.org
X-Gm-Message-State: AOJu0Yw6+r7CYhDZi6A3xrIL5mBe16QQQJojcRWz6GuLBTG0PGCPn5il
 7rCPrJySd6gpEFCMV3WYYOon6RaV58iS10nXqNU/88RVffWgLYf8evIJYJSBQtLU/xSdZNXpkr1
 Uyto9Rf6cdobC8cRozWaEEtOgoF5fHGucFk/o4RRxQz9vxg543BvZRoJS
X-Gm-Gg: ATEYQzzhf6ZCi3lPt3oUkgebTArYk30dteg+zBji7Y28Np7CBu77xMYMriEM8Z1C8ed
 C4hB6rn7/4Gi05+3gXIO8qb3GBjRBJZVhSV1Lc84QjD3eiZ6Gkab/Wmat0dc0bAwVVqig63zAD2
 Ta9Jb07mWdMfv+6vCXDi7yyTKtfR9OeYeucGlLZZxxGNDY8DzZ38sMOpOJY10+zLJD3jrTNFZia
 Z9dO6UOSNAX4nUzsVxi6hSa91+kWWfMwO90aLRmMMOCbRG+/V+0V8CwnJALiWIz5gTf/QiiuN/9
 isy+KV/JvPaA9spre64Nf3FDJWlCWWXvNbpeGFsoR2G6h3K2bCSHhO+s+f3ZS/AMkWo2okyHMUG
 2azN7JCvb3d6SvFefhSmMF1LvwgEkMDXJwSHe6IqJ2UFcY03vzD2Q282KFq4b
X-Received: by 2002:a05:600c:1f11:b0:485:3ae8:2231 with SMTP id
 5b1f17b1804b1-486f4460586mr51780155e9.30.1773836297698; 
 Wed, 18 Mar 2026 05:18:17 -0700 (PDT)
X-Received: by 2002:a05:600c:1f11:b0:485:3ae8:2231 with SMTP id
 5b1f17b1804b1-486f4460586mr51779535e9.30.1773836297218; 
 Wed, 18 Mar 2026 05:18:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51892161sm7961402f8f.21.2026.03.18.05.18.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 05:18:16 -0700 (PDT)
Message-ID: <af3fdb2e-7c0b-46ab-807c-4c0527f6734c@redhat.com>
Date: Wed, 18 Mar 2026 13:18:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] backends/iommufd.c: report error when /dev/iommu is
 not available
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Alex Williamson <alex@shazbot.org>,
 Eric Auger <eric.auger@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>
References: <20260317225751.1325098-1-pierrick.bouvier@linaro.org>
 <20260317225751.1325098-2-pierrick.bouvier@linaro.org>
 <IA3PR11MB913683DE47A156F52C77AE7C924EA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <068a3098-4e4d-490c-9cef-ac39a7e9c29f@redhat.com>
 <IA3PR11MB91364D3734AA30AB6C474E1D924EA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <IA3PR11MB91364D3734AA30AB6C474E1D924EA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/18/26 09:37, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH 1/2] backends/iommufd.c: report error when /dev/iommu is
>> not available
>>
>> On 3/18/26 08:36, Duan, Zhenzhong wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> Subject: [PATCH 1/2] backends/iommufd.c: report error when /dev/iommu is
>> not
>>>> available
>>>>
>>>> In case current kernel does not support /dev/iommu, qemu will probably
>>>> fail first because /sys/bus/pci/devices/*/vfio-dev/ is not present,
>>>> since QEMU opens it before /dev/iommu.
>>>>
>>>> Instead, report an error directly when initializing iommufd object, to
>>>> inform user that kernel does not support it, with a hint about missing
>>>> CONFIG_IOMMUFD.
>>>>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>> backends/iommufd.c | 5 +++++
>>>> 1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>>> index acfab907c03..c4eb3de1307 100644
>>>> --- a/backends/iommufd.c
>>>> +++ b/backends/iommufd.c
>>>> @@ -32,6 +32,11 @@ static void iommufd_backend_init(Object *obj)
>>>> {
>>>>       IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
>>>>
>>>> +    if (!g_file_test("/dev/iommu", G_FILE_TEST_EXISTS)) {
>>>> +        error_setg(&error_fatal, "/dev/iommu does not exist"
>>>> +                                 " (is your kernel config missing CONFIG_IOMMUFD?)");
>>>
>>> If hot add an iommufd object with object_add QMP, may this kill QEMU
>> instance?
>>
>> yes.
>>
>>
>> Unfortunately, backends are Objects. So we don't have a realize
>> handler and a 'Error **' parameter :/
> 
> Maybe do it in iommufd_backend_complete()?
Yep. Perfect.

Pierrick,

Can you please move the test under the complete handler ?
May be add a  #define for "/dev/iommu" while at it.

Thanks,

C.




