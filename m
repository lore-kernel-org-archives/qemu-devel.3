Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AF7C02196
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 12:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfedD-0005UO-S9; Wed, 05 Feb 2025 07:35:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tfed7-0005TU-Ra
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 07:35:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tfed5-0001ky-JW
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 07:35:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738758942;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oDgRhvAVYdvoxe7XBnXUhWpJbAGWmB4L9GDPUJxPhRk=;
 b=SQSraXx3GV9WSwTQ4K0oGA/ajTvDca9DlorgLcj+D1iY1Ove1tPTM04WfUcp+80RrqTo8q
 mAVONheU4E6mvn+p57VcaAGO/PdpOeD2aI6sZlLHIRWvAbu5u7BGRKWi6sJMf+Ep1ruXnf
 dac8ZFjKz1tukziTD6gPGp/OT8Y/33M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-T92vPiuRMF6f3GJWYfDtNA-1; Wed, 05 Feb 2025 07:35:41 -0500
X-MC-Unique: T92vPiuRMF6f3GJWYfDtNA-1
X-Mimecast-MFC-AGG-ID: T92vPiuRMF6f3GJWYfDtNA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-436248d1240so34884845e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 04:35:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738758940; x=1739363740;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oDgRhvAVYdvoxe7XBnXUhWpJbAGWmB4L9GDPUJxPhRk=;
 b=gpTF2cBMMx+4q9YLA6WJMZedmDVic3Gvc9TWOwSGGnTTtBmOp8Ay9VuDw0mU5vAw3O
 zd4rb9s+ALKhaKNLzgDuUWPkNw9QxCZfVE3a+u/PHU83iBA8M60oUZO2QiCKWIuZNLOk
 wt6wy99MqbyMAvV285l3gmFl896NLZ3tujsq0Q5GsRno2j1vrtx5JO1KRv4SR6rxNbuP
 /aSRlpcnpHFf8V5RgCr1aGI+a4Oj11WLpan5KO5uMT1F79S9VaRkqBgWiSkTX5xYxkro
 gNMP6/8bCO6bDNJk/pz+jAmXesLksfrTyCq1q1x+vCB2jiIRCooYz6xnC2qkuqU80eMl
 2KDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXATkeFRipSjrUHky48u5/2kt357GfxnVICz9nz6arJ3Q0bexDzUcwXSjouKrZwO6otHHgkXRXmhpE3@nongnu.org
X-Gm-Message-State: AOJu0YwOAkzX5h3g21ile0uk0hd/Vmaf6i+pP5euWTjg2tOvvyvojH0F
 RFJmFLJ0RyAv31XAsQwXnUVQHhcCwPwr4o6FqCEfGe0u0e68VTl9vrPBeMv0aahCnG1rbe+laXK
 VXUSRt7UV6yTIPq5eRtpW3cjPWVYU7MYYBN27f5v4sGMG1PvkuBgK
X-Gm-Gg: ASbGncvtZXtNzlZCsZ7GihXxoZXw5AdUXxiStDX2Cj1YxhVxuZDEVwESyyFiANIOznL
 HQzFmAFIYYPMu5dzpGrFqO/d8DAhfj3RfVStU0lWwrc19oHJDjPr0U04jkcIFQzN3jwUuTKBfa9
 PqlONfHZverrmii1fluQLYuDDFxqSQLjRAiUaeW5jBuuecA2OC5d6jRPn6z2PxFLYhXMdtgoFr9
 +gk2g69uI0a6jEMx1Trfhj1U+045Gkl4PVhUiFlgMm1Tgm69/NQLzH2XcecpF4kr91biPwigbWn
 t55bz6sbSgKIIkasK1RGy1XAr2hYFYviMHJj4YYHaEM916wljqOS
X-Received: by 2002:a05:600c:6d52:b0:434:f0df:a14 with SMTP id
 5b1f17b1804b1-4390d8615c7mr18341855e9.2.1738758940128; 
 Wed, 05 Feb 2025 04:35:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGB8fnQ5kqlZGWJtJCSkhsxs1LCMAfEcdYl8wvMi5jpNVMYSO90kgJ+bIJcoXeQHT2UvedRKQ==
X-Received: by 2002:a05:600c:6d52:b0:434:f0df:a14 with SMTP id
 5b1f17b1804b1-4390d8615c7mr18341585e9.2.1738758939746; 
 Wed, 05 Feb 2025 04:35:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dad9a8663sm4386021f8f.6.2025.02.05.04.35.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 04:35:38 -0800 (PST)
Message-ID: <e191a394-e70d-4c9c-ad6e-8e2f1111112e@redhat.com>
Date: Wed, 5 Feb 2025 13:35:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "ddutile@redhat.com" <ddutile@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z1wh69_gZ9izr1iU@redhat.com> <Z1wsslDnwlth3A8+@nvidia.com>
 <CAFEAcA8TW2RKyFnh-TZRpfaKfZipHD5TZy_hymUr41GJ4rs4xA@mail.gmail.com>
 <329445b2f68a47269292aefb34584375@huawei.com>
 <Z39Ugx2M+FRFVVpB@Asurada-Nvidia>
 <f4e64a3a-5c1d-49f2-ac72-b84ecd353c9d@redhat.com>
 <Z6EQENkHJy7TrkYy@Asurada-Nvidia>
 <77f736f6-9ef9-462b-916e-c8cfff279044@redhat.com>
 <Z6KsAE9wnjWU0xMs@Asurada-Nvidia>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Z6KsAE9wnjWU0xMs@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_BTC_ID=0.498, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Nicolin,


On 2/5/25 1:08 AM, Nicolin Chen wrote:
> On Tue, Feb 04, 2025 at 06:49:15PM +0100, Eric Auger wrote:
>>> In summary, we will have the following series:
>>> 1) HWPT uAPI patches in backends/iommufd.c (Zhenzhong or Shameer)
>>>    https://lore.kernel.org/qemu-devel/SJ0PR11MB6744943702EB5798EC9B3B9992E02@SJ0PR11MB6744.namprd11.prod.outlook.com/
>>> 2) vIOMMU uAPI patches in backends/iommufd.c (I will rebase/send)
>> for 1 and 2, are you taking about the "Add VIOMMU infrastructure support
>> " series in Shameer's branch: private-smmuv3-nested-dev-rfc-v1.
>> Sorry I may instead refer to NVidia or Intel's branch but I am not sure
>> about the last ones.
> That "vIOMMU infrastructure" is for 2, yes.
>
> For 1, it's inside the Intel's series:
> "cover-letter: intel_iommu: Enable stage-1 translation for passthrough device"
>
> So, we need to extract them out and make it separately..

OK
>
>>> 3) vSMMUv3 patches for HW-acc/nesting (Hoping Don/you could take over)
>> We can start sending it upstream assuming we have a decent test environment.
>>
>> However in
>> https://lore.kernel.org/all/329445b2f68a47269292aefb34584375@huawei.com/
>>
>> Shameer suggested he may include it in his SMMU multi instance series.
>> What do you both prefer?
> Sure, I think it's good to include those patches, though I believe
> we need to build a new shared branch as Shameer's branch might not
> reflect the latest kernel uAPI header.
>
> Here is a new branch on top of latest master tree (v9.2.50):
> https://github.com/nicolinc/qemu/commits/wip/for_shameer_02042025
>
> I took HWPT patches from Zhenzhong's series and rebased all related
> changes from my tree. I did some sanity and it should work with RMR.
>
> Shameer, would you please try this branch and then integrate your
> series on top of the following series?
>    cover-letter: Add HW accelerated nesting support for arm SMMUv3
>    cover-letter: Add vIOMMU-based nesting infrastructure support
>    cover-letter: Add HWPT-based nesting infrastructure support
> Basically, just replace my old multi-instance series with yours, to
> create a shared branch for all of us.
>
> Eric, perhaps you can start to look at the these series. Even the
> first two iommufd series are a bit of rough integrations :)
OK I am starting this week

Eric
>
> Thanks
> Nicolin
>


