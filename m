Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03D7C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 09:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txjHU-0007Bl-EX; Thu, 27 Mar 2025 05:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1txjHQ-00078Z-1u
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 05:12:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1txjHO-0005lW-14
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 05:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743066719;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KxJ16tDeYAGFS0tk1Xhh+SQUoUEZcKzgVt37yURehds=;
 b=BeS8k180fyJCN/FXZ3Ih2d5VehpHQwJpoQHUp7GZza4ihERQTFaqdaQ5We/aapfZrqp25z
 11dS7yJfgnsvyZ58FcNQtwb/9IVDRhu/ldXrHrg8VHmbol9VtfV9hxUdrpw1EMJG3v0WUv
 7tSUIHk6aqqEKtU79PJ46E/i5YkB70s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-lrPt-mfvOSSdbvRKSDsLHw-1; Thu, 27 Mar 2025 05:11:56 -0400
X-MC-Unique: lrPt-mfvOSSdbvRKSDsLHw-1
X-Mimecast-MFC-AGG-ID: lrPt-mfvOSSdbvRKSDsLHw_1743066715
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3912a0439afso243990f8f.3
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 02:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743066715; x=1743671515;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KxJ16tDeYAGFS0tk1Xhh+SQUoUEZcKzgVt37yURehds=;
 b=pKGiICQW/OhzA2AOks+Or8i12GmxJja96dIKwRg+CMKUT86OZj6a1EZWo26g95hn/E
 UQiPVr5jeAL6SV8dsJABFDRJlzyevKmliROF3UxpHylHlB1YuaSGDJuSIWCOxX4Qomzt
 5Uld1wTUGCDDSO+7shHjKe15bgxRrjvm3KxzBKHrw/TfHeueUV1E7legCaUh4CWzBQPh
 KXPUx62Ir+kSsoG78v+6iEG4kcN2F+zOWGt6lty+BT8KYYa5ByUsfloeMil8MsFHCbxV
 ZxtaBmCJ4VBY/d9Nor9FYh5NAT0YD61bmvqUl8uz/qivo6KHCkvGSLVjT+GM0FX4e35W
 nnmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrQZzVit3S8g40pCYntgJh8tS9bygG0yco+hgrToA8RpfDLMtY0LwW9y+C/6gUdjo7clFeI5XsuV6m@nongnu.org
X-Gm-Message-State: AOJu0YxgC0UyhyEG7gN8PEUsD11Gb3RK3nMU765jwCOrqwpSyFee6uUV
 gtjU1rqE6HX1xRyYex5Io39s47G58YoM2DU7gIJ1IZ/KJITReATTAWuURCLxDS7Sm74moNK7E9J
 TOLNo0k3KhBhwy7PSm6/mh8qptS84DYk5Gg6G49vLMPSENUDZm935
X-Gm-Gg: ASbGnctJYZUXsFWWSgXF2T4xm5r7Ko9HqvtkkxfI98EhUmftgrfLZIGw5pA0HQEsJpR
 mSA2Kf+mdHJ5YEv76K5eksJ9Wi14RuAWrzdyVeUcZJbZSaW87fnA3Ht4tJUxmmUuszpEJjz2okY
 ijCYlMnM25ovC7hy8PWJfUy76qLeFBPICxDwWh6a9kp+2k0+Kcb2Af/8GH16LGv4FRV5wmJZrBk
 HG9K3P9tAQg5gohGSi4OELdQYhIiRjxobvq2QRbCQLFkTFjoAxWjFo4KilHR37KZPROKm0cnuVG
 mU+jNj9LznucVknmF3KAwi6qrzte6Vp8tdCaQy1JxSQIl/kvcp6HVN7qJfHG9JE=
X-Received: by 2002:a05:6000:2913:b0:391:48f7:bd8a with SMTP id
 ffacd0b85a97d-39ad17596e3mr1874950f8f.30.1743066714867; 
 Thu, 27 Mar 2025 02:11:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEG5FSrBR8J4J9AB2bJFJl2bP2huEg6tmBliFAA1iBIBed7Jpr9bCE4PAoPA4+tN24wuZRbg==
X-Received: by 2002:a05:6000:2913:b0:391:48f7:bd8a with SMTP id
 ffacd0b85a97d-39ad17596e3mr1874930f8f.30.1743066714449; 
 Thu, 27 Mar 2025 02:11:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9a3f2asm19488557f8f.30.2025.03.27.02.11.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 02:11:53 -0700 (PDT)
Message-ID: <c081ba1e-4e6a-48ec-ab8a-36474cdce8fe@redhat.com>
Date: Thu, 27 Mar 2025 10:11:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 17/20] hw/arm/smmuv3: Check idr registers for
 STE_S1CDMAX and STE_S1STALLD
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-18-shameerali.kolothum.thodi@huawei.com>
 <477323cb-12d3-484c-8ad9-61229ede3efe@redhat.com>
 <Z+RZsES0+Ywxi7Xx@nvidia.com> <cd1393939aaa43bebce8bd926b4b00de@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <cd1393939aaa43bebce8bd926b4b00de@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On 3/27/25 8:54 AM, Shameerali Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Nicolin Chen <nicolinc@nvidia.com>
>> Sent: Wednesday, March 26, 2025 7:47 PM
>> To: Eric Auger <eric.auger@redhat.com>
>> Cc: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>> qemu-devel@nongnu.org; peter.maydell@linaro.org; jgg@nvidia.com;
>> ddutile@redhat.com; berrange@redhat.com; nathanc@nvidia.com;
>> mochs@nvidia.com; smostafa@google.com; Linuxarm
>> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
>> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
>> Subject: Re: [RFC PATCH v2 17/20] hw/arm/smmuv3: Check idr registers for
>> STE_S1CDMAX and STE_S1STALLD
>>
>>> Again I think we need to understand the consequence of having a more
>>> comprehensive support of SSID. This also holds with old the IDR fields
>>> that may be inherited from the HW and we don't support yet in the
>>> emulation code
>> To support guest-level SVA, it must support SSID. We can keep the
>> SSIDSIZE=0 in an emulated SMMU. Would you elaborate the concern of
>> doing so?
I just want to make sure we dissociate both accel and emulated paths and
we do not advertise SSID in one mode while we do not fully support it.
>>
> Regarding adding support for SSID/SVA in emulation code, the support also depends on
> device PRI/IOPF feature as well. Do we have any emulated devices that can make use
> this? I would say we can add that support later if there is any real use cases for that.

x86 may be ahead of us in this area. Maybe this was tested by Zhenzhong
when contributing emulation for S1 support in intel_iommu?

Eric
>
> Thanks,
> Shameer 


