Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C59CCFA03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 07:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGup3-0006h1-Rc; Thu, 06 Nov 2025 02:54:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vGup1-0006ge-JN
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 02:54:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vGuox-0000Ul-5o
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 02:54:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762415651;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tVL7hZ4j2kAuKul0PBILcZSs61/aRtgQLFDp1GSjUgM=;
 b=DRLYw3tChqznJVFMlLH4XowLwr8fVlU1BOTLLMbKQpcklfpVJibpQZqAfHznyosHG5mZ1i
 I6nVdKsDnaUy4+HIX4f+TgNu5oCYkxV10n+UJhbS9JL8345W64N8t56aGlRvE60gtTpqrI
 0iQimxQfBiGlZn4v8OnsOPn+YGuDx8k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-7fKEGa-yPbiXh0g8Mqs-ug-1; Thu, 06 Nov 2025 02:54:10 -0500
X-MC-Unique: 7fKEGa-yPbiXh0g8Mqs-ug-1
X-Mimecast-MFC-AGG-ID: 7fKEGa-yPbiXh0g8Mqs-ug_1762415649
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47496b3c1dcso4866635e9.3
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 23:54:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762415648; x=1763020448;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tVL7hZ4j2kAuKul0PBILcZSs61/aRtgQLFDp1GSjUgM=;
 b=gZIyubKtUuSWn0RHxbh66beXQ4mm6EcIe1XqzTUufCTXO8T6/IT3D3RMJI4FmhO8AV
 JfoSMrTS4/Dn9sfM13ACfStof9pulSpyiCan+Z+l9gBwXXri96im6uyzsZKa+JAJuL3u
 GNG995sdzlx7o+RewlizFDnxZmkO7R91L7b2/fYF3V8PJ+/O5yr4Hh4Wp3jLvhMh3ISp
 ycgWGUYKDNVuUKkaWglxfUSlcIbn36NpujkKp0FouNk1q4MewgBhrb7A9prP5Xiwh0gw
 zrXgQxc/wNklLUvYmVxbdcxzbnxJuUpOMDxmW1j7RWH02i02vTxNBy5gZrpk5oMUkrWp
 4RIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjtpD6o3VQKi3iyk22FFIavKL6eVdQJIV6QharSzoLD4GrhoabWZELlr5mm/JLQ+Ge73UuZsEp+NIw@nongnu.org
X-Gm-Message-State: AOJu0Yx4JXfYjwCpLHRUdpuTenSfEIWXCOf/sgtMEvetg7mmqG6uiTxB
 3z9bIUo48phg2Cnpwm3RtSv0vTCY6GBm+u+YTadN2sVvySgfsDEa4be0foISUR74XOvS3TwhC3r
 B0YAwXLHhcHYMq7pXqvCoJUcjUUEZDWP22z8lRGvaZP7WKkF2xDiWo9Yr1Wz0CsQl
X-Gm-Gg: ASbGncsAK7rwfoaI6kJklWvzq1yaJqyuZgY0kXQ0tVpamIeTrHgUri6jYk7pMFeYXxZ
 0ltWTxD61WP9zzkH0dXd9tGz0Yo99DavM6RfPJvzYGaXddM5xxW1q1kPhxZXBsDqTmsnl4RtSV+
 Mx+koOS3mYYIj9CyNKq4EXHcbfjoAvJheG2cYvlVGN7kTKlsih6Xs1z9mo2ewO9kmtAqUiCUqb0
 PrTs2GwL77cNX/x5cZPHWEBF3hW4hKjlUg/e3l+sDYltjSIT2u+ytMYD5QezrM1U3m3AsK5K7kD
 5qWNTAhdh7qgwmIxKcf9EfEaL11ZCYDe+pcz3KSiLn/fg++CkwpVDm9B8L++x33iOilMgbELfAn
 v4gCIdU4sF/LJg/zAo+CSH5Fyo6yzOTClI5QJObGznkBD3w==
X-Received: by 2002:a05:600c:5291:b0:477:c71:1fc1 with SMTP id
 5b1f17b1804b1-4775cdf76d3mr58571925e9.19.1762415648206; 
 Wed, 05 Nov 2025 23:54:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+2ZvyuTHT6PZfX7p3dbGMOYj+5he1F6P5Wccv1LQq9yrpXLYJG4Delw84HlJ0LMhaYsxfmQ==
X-Received: by 2002:a05:600c:5291:b0:477:c71:1fc1 with SMTP id
 5b1f17b1804b1-4775cdf76d3mr58571595e9.19.1762415647815; 
 Wed, 05 Nov 2025 23:54:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477632bda1asm27432985e9.3.2025.11.05.23.54.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 23:54:07 -0800 (PST)
Message-ID: <d58b17ae-ed38-4012-9da7-7c3efd484428@redhat.com>
Date: Thu, 6 Nov 2025 08:54:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 28/32] hw/arm/smmuv3-accel: Add property to specify OAS
 bits
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 kjaju@nvidia.com
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-29-skolothumtho@nvidia.com>
 <49215c9d-feb1-4f72-bfe0-799572ecfac2@redhat.com>
 <20251104145041.GE1537560@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251104145041.GE1537560@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Jason,

On 11/4/25 3:50 PM, Jason Gunthorpe wrote:
> On Tue, Nov 04, 2025 at 03:35:42PM +0100, Eric Auger wrote:
>>> +    /*
>>> +     * TODO: OAS is not something Linux kernel doc says meaningful for user.
>>> +     * But looks like OAS needs to be compatible for accelerator support. Please
>>> +     * check.
>> would remove that comment. Either it is requested or not.
>>> +     */
>>> +    if (FIELD_EX32(info->idr[5], IDR5, OAS) <
>>> +                FIELD_EX32(s->idr[5], IDR5, OAS)) {
>>> +        error_setg(errp, "Host SMMUv3 OAS(%d) bits not compatible",
>>> +                   smmuv3_oas_bits(FIELD_EX32(info->idr[5], IDR5, OAS)));
>> let's be more explicit then and say
>>
>> Host SMMUv3 OAS (%d bits) is less that OAS bits advertised by SMMU (%d)
> It isn't OAS that is being checked here, this is now IPA. OAS is for
> use by the hypervisor.
>
> When the guest looks at the vSMMU the "OAS" it sees is the IPS
> supported by the HW.
>
> Aside from the raw HW limit, it also shouldn't exceed the configured
> size of the S2 HWPT.
>
> So the above should refer to this detail because it is a bit subtle
> that OAS and IPS are often the same. See "3.4 Address sizes"
>
> * IAS reflects the maximum usable IPA of an implementation that is
>   generated by stage 1 and input to stage 2:
>
> - This term is defined to illustrate the handling of intermediate
>   addresses in this section and is not a configurable parameter.
>
> - The maximum usable IPA size of an SMMU is defined in terms of other SMMU implementation choices,
>   as:
>     IAS = MAX(SMMU_IDR0.TTF[0]==1 ? 40 : 0), SMMU_IDR0.TTF[1]==1 ? OAS : 0));
>
> - An IPA of 40 bits is required to support of AArch32 LPAE translations, and AArch64 limits the
> maximum IPA size to the maximum PA size. Otherwise, when AArch32 LPAE is not implemented, the
> IPA size equals OAS, the PA size, and might be smaller than 40 bits.
>
> - The purpose of definition of the IAS term is to abstract away from these implementation variables.
Thank you for the clarification and pointer. I fully agree.
maybe we can rephrase the error msg as:

"Host SMMUv3 OAS (%d bits) is less that physical SMMU maximum usable IPA (%d)"
which is more accurate despite in practice here we assimilate max IPA to OAS (
TTF[1]==1 case)

Eric

>
> Jason
>


