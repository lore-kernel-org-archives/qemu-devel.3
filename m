Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B5F109E544
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 09:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w63a1-0005UH-C4; Fri, 27 Mar 2026 05:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w63Zz-0005Tm-Py
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 05:34:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w63Zy-0006LP-EZ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 05:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774604049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=D6RUq/LuPHszX24GjhleHuoK61e9FoFCgBQAfa85XEQ=;
 b=IxPZEwVTgz5WbP60Dvwr/tDH5umsm10XTU4dg1ozeaWa7ztI6khm/bM4+lylj/cO2s7VKA
 vga0aWxAC/1+siIn/oC8YVjufmKAZZbp/vV6atUBMzFQxfo3qEpijJBzB5GyIrh4ysRMxf
 r7nFU1mI4R/CP1FdwrxEjB0KoQbI8Nk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-OIwQNxidM5W5nlaYPd4UiA-1; Fri, 27 Mar 2026 05:34:05 -0400
X-MC-Unique: OIwQNxidM5W5nlaYPd4UiA-1
X-Mimecast-MFC-AGG-ID: OIwQNxidM5W5nlaYPd4UiA_1774604045
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439c112b1a4so1536490f8f.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 02:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774604045; x=1775208845; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=D6RUq/LuPHszX24GjhleHuoK61e9FoFCgBQAfa85XEQ=;
 b=S58J2OJI47sCYflWuWQFc4uLLx0m0pnyO1nQtzq1Am+MMOd6WkrbTKy/G5bur3Y8rv
 kUfifNbnKpFd269+c1I3KcNDo8QZiE/dbSQuc77tTs0wmA4TbPZSj3j2zxWmtJfm3iOY
 OKZgaWGKb5ZB/VJcUn8kkn4F7SWtQeRZqkcUttUE+4WHZVEei9fugeLqEW33QZYT4Rjs
 0ayENZ3a6fJonI6xfmzQ7FumdNmMoJ+pERUlzVSekxr0LNmPqtj74Iz309sTDFYSLx3A
 4Fa1IIZA03WccuShd468LSs4IFwPvGXb7ZXVv16LH18yWxJOTfh9oIWNGQkVLvLyVxXl
 69Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774604045; x=1775208845;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D6RUq/LuPHszX24GjhleHuoK61e9FoFCgBQAfa85XEQ=;
 b=IO6wFRvSqJcdbO/JZKA5p/MuN9j2p2BCKX+DdbVKebTm1Xrq5BUadOjMX9mX4U6OWg
 LWWEk74HAsjaqb3edNc9wl6ZJRpFGdZJ06JYMQW8/9SYjnESPGBPESrG9SkmFgjwxlXX
 IP/UKwTqFTaDCxEGm2MQtD+7LbtQJjRGlgZY9/K3ptDwTmMgqsN83D2s3ef8eHS2gmPf
 mmCLG8aEzPxoYGLV5mGgxViuySvAQQkfPFeDpo/4rAiDpEJthricp49BRMSugrms+3UM
 7IISH5GxWW2DKtp9CmOA+wW+83+0VoRVZs/E7gAEbBHt89bJ5MMzGWqaBldEYx/o0C7S
 4/jg==
X-Gm-Message-State: AOJu0YxUJk4YgYipuf6SeU4Y491VG8IotMmWZPq27/MWJ3UgG2U2KrNA
 7OKKPQEDUWjYGqrYH+TIHili40gC9itWW5T/RaMGm9wF7Pyj5rpaqzNtK0RMyG5QVxSBQlWKgFb
 XUNB4AEMkcgMUdkbudLEJlo6SMIf3f7Z7/KPn6B2VLVBlfoABUYwrEVQJ
X-Gm-Gg: ATEYQzzOxkJKvoOvxM6LOq2j5dMAXXxyshWCWW9Gjo4TOPcxQ15ZrmdTvI2iY49nLbs
 avUQdl4Be3mIAQcZTaihbWW0JElwpfeFfO7FR7Qqlvas4Jyrb80IUW4WFnCDcgrtVR0a0vXHGPQ
 S0+AgoHOJ6IhpYprnfCXEIR29jHe3ibXXKS3mnzoPOgxFQjlME/fOaad2hr2ESM3F3w8nNp3HMp
 FzDs2b9+VReqLoYRD+bHn2VQM21q1g7+XnmFejWG2cDMVb37GU6tB8REMLuOQXo9IRIK3Is/vqd
 Vwyr4fZm1dkhH44hwNmcBcvlwbD15zfgi0HaMLlUnxpNXuae8JCSpH6ohXVRbGI1k4y5gPHS8wv
 wm/CFKiqyS9KQN8kbcwcecRwkYYKUDs12BMzknxE0pmGh+58r4g0K48Hx1lX0
X-Received: by 2002:a05:600c:46c5:b0:485:39d1:b4dd with SMTP id
 5b1f17b1804b1-48727ef0bcemr28252835e9.10.1774604044614; 
 Fri, 27 Mar 2026 02:34:04 -0700 (PDT)
X-Received: by 2002:a05:600c:46c5:b0:485:39d1:b4dd with SMTP id
 5b1f17b1804b1-48727ef0bcemr28252205e9.10.1774604044122; 
 Fri, 27 Mar 2026 02:34:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487270dd790sm25040405e9.5.2026.03.27.02.34.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 02:34:03 -0700 (PDT)
Message-ID: <e97aec85-c9f0-449c-99e9-bc4b4f2d33d8@redhat.com>
Date: Fri, 27 Mar 2026 10:34:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks to
 support pasid
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex@shazbot.org" <alex@shazbot.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Hao, Xudong" <xudong.hao@intel.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-3-zhenzhong.duan@intel.com>
 <acWwwzfNEzBg4n96@nvidia.com>
 <IA3PR11MB9136FC71017C3B05CE3C881D9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <acX9/RjKaO0bBI/d@nvidia.com>
 <IA3PR11MB9136D9DAD0B8698841CEF4429257A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <IA3PR11MB9136D9DAD0B8698841CEF4429257A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/27/26 07:44, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Nicolin Chen <nicolinc@nvidia.com>
>> Subject: Re: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks to
>> support pasid
>>
>> On Fri, Mar 27, 2026 at 02:32:57AM +0000, Duan, Zhenzhong wrote:
>>>> -----Original Message-----
>>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>> Subject: Re: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks
>> to
>>>> support pasid
>>>>
>>>> On Thu, Mar 26, 2026 at 05:11:16AM -0400, Zhenzhong Duan wrote:
>>>>> @@ -138,14 +138,16 @@ struct HostIOMMUDeviceIOMMUFDClass {
>>>>>        *
>>>>>        * @idev: host IOMMU device backed by IOMMUFD backend.
>>>>
>>>> Not commenting against this patch, but I just found the "host IOMMU
>>>> device" and the "HostIOMMUDeviceIOMMUFD" a bit ambiguous. It's not
>>>> an "IOMMU device" right? Perhaps somebody can help me understand :)
>>>
>>> A host device under host IOMMU?
>>
>> "host device" would make sense, not "host IOMMU device", right?
> 
> We want to emphasize that it's a "host device" backed by "host IOMMU",
> "host device" is not enough, I think.
Yes. These are related to the Host IOMMU device backends :

   - VFIO IOMMU Type1, a.k.a legacy backend
   - IOMMUFD,

There are other implementations. VFIO IOMMU Type1 is versioned and
a ppc flavor exists.

Thanks,

C.


