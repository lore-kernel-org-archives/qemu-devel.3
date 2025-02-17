Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51FCC021A7
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 07:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjvbc-0007m1-JE; Mon, 17 Feb 2025 02:31:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tjvbG-0007kU-1g
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:31:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tjvbC-0004SI-Hl
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739777483;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1mgPwNvFo80Y/h1i6hS2G2/GiYmVIt1qcN3yJXz5F+s=;
 b=GpvL5OR2DWEvXgTMh7WDqw/lj3NN8SOhQqwaMACA6cF8aw+cdKIHc2CkTul5ofEzVaZ4fA
 2MBsLveWLQRoRWZ97Ab5cGY/2/pZvUJ1Eo98D/DLjFmwTx4h6vbad81xdLNpE0VHMb8Awy
 kGrXnWdEvLJRiL7ESAhhj74r9SG/Tas=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81--WUD5pBIMWqiv9avCdEtRA-1; Mon, 17 Feb 2025 02:31:20 -0500
X-MC-Unique: -WUD5pBIMWqiv9avCdEtRA-1
X-Mimecast-MFC-AGG-ID: -WUD5pBIMWqiv9avCdEtRA_1739777480
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4393b6763a3so21270475e9.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 23:31:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739777480; x=1740382280;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1mgPwNvFo80Y/h1i6hS2G2/GiYmVIt1qcN3yJXz5F+s=;
 b=rpc9VzUNrQUlLwn/K9xzwY6feH+OYF6i7xZ6BWiyVZwNOTdqeNntewZgctzmgd55G6
 sEkpkKdkGS5oR1oSWR4EkfKeMtfudOVFQUytGqO+M/tWZ0fTD73L2EjuWzTrS7aauJ21
 Wem3fdQqb8HA+w4LoWhPNON0KQrH0A7SMkrgEcowuRdb+MgB1vkOgMH+HkAgU3b6jVW2
 PIDjQIVPS3LuK16SGSTpAAO7ibM/dDeHIonoLjS+SI8+sTfdYbpI1CmdYkbZ9ZV5PAGU
 9FJQGIrPq2Zx2DHyydN4h9oyfbWvTjltS65uqB1NTSpJjLU5CJ/BKsa57Li9Z9Wa3rla
 ybYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgiR1RLmUV1NRi1Hf+IpqFgYnHhRYpEZ6jetQOFPwzHNiK7sK10SYYjuQMMrjbH4aAsasM3goCtwIq@nongnu.org
X-Gm-Message-State: AOJu0Yy8DqlJs/xIjotfL7U8KrGJ5HbfTKCcq8yjKa4CPlavtL5km7ba
 TqIdB0ooXXojequ7TIQ8S+F4q6d6tbQfWENHDaQh/Q+agwNOO+tg1rgt+EpJKyCCchY6UI/X1vv
 TJwQV0NWaFbg8QjaaV6Nxaf0V+m/m/DyiARA+sNvNdhycbEYagQcL
X-Gm-Gg: ASbGncsVJueTD/5dcJrxhy0YhSDKrmCtANRhMZh+rjZLEpgNvPbp+yA9Rz+ohO9FAfQ
 HXzA6kn3Zinnt6dT4aeIwB5knJoJiiaFweZJparZ2F95n0v5HEXg/rR/S9G1XtM/75c5ObtUQuY
 Qgq+lLObQZ+Y0hUAj/VsfCm3IH2Neg7Kfd7//QG44lFu7ML5Zcp3xPDOD7eBifcO1HAfn21cCpW
 j2gzH8542+j+g4aJueK/gLdFVxsUjUaJgci1R5SFER21vrlFZDOVSb0Ei+KTqYAEuFg/n/fw9aW
 Zu4bIRs9396Irg0wvcjsWK07NJo4JmDplV31zxtRq4e37n7YRR3T
X-Received: by 2002:a05:600c:1c21:b0:439:45e2:897f with SMTP id
 5b1f17b1804b1-4396e6e32a7mr99796815e9.11.1739777479745; 
 Sun, 16 Feb 2025 23:31:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzlycmL13mme1B4nuzhQWUAK2Zqbv6n6wVgbWxBL4hko8tk2yjvXZ7CDP+VvHw0xxBhFaKIg==
X-Received: by 2002:a05:600c:1c21:b0:439:45e2:897f with SMTP id
 5b1f17b1804b1-4396e6e32a7mr99796535e9.11.1739777479386; 
 Sun, 16 Feb 2025 23:31:19 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4396b0aa4e9sm74734875e9.16.2025.02.16.23.31.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2025 23:31:18 -0800 (PST)
Message-ID: <ad754ae8-0d0d-4a19-bde7-b3df1e56546c@redhat.com>
Date: Mon, 17 Feb 2025 08:31:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] hw/i386/intel_iommu: Tear down address spaces before
 IOMMU reset
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "ddutile@redhat.com" <ddutile@redhat.com>
References: <20250206142307.921070-1-eric.auger@redhat.com>
 <20250206142307.921070-4-eric.auger@redhat.com>
 <SJ0PR11MB67444138EAFE0660733B315D92FB2@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB67444138EAFE0660733B315D92FB2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhenzhong,


On 2/17/25 4:02 AM, Duan, Zhenzhong wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: [PATCH 3/5] hw/i386/intel_iommu: Tear down address spaces before
>> IOMMU reset
>>
>> From: Peter Xu <peterx@redhat.com>
>>
>> No bug report for this, but logically tearing down of existing address
>> space should happen before reset of IOMMU state / registers, because the
>> current address spaces may still rely on those information.
>>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>> hw/i386/intel_iommu.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index 21a8bf45f8..1bd9ae403b 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -4702,8 +4702,8 @@ static void vtd_reset_exit(Object *obj, ResetType type)
>>     IntelIOMMUState *s = INTEL_IOMMU_DEVICE(obj);
>>
>>     trace_vtd_reset_exit();
>> -    vtd_init(s);
>>     vtd_address_space_refresh_all(s);
>> +    vtd_init(s);
> I'm not sure if we should have this change. vtd_switch_address_space() checks s->dmar_enabled and vtd_init() updates s->dmar_enabled. With this change, will we leave stale mapping there after reset?
Yes I do agree. This could break the as switch. I will remove this patch.

Eric
>
> Thanks
> Zhenzhong
>
>> }
>>
>> static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int
>> devfn)
>> --
>> 2.47.1


