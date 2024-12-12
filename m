Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603E4E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 13:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLjGC-0007OQ-8F; Thu, 12 Dec 2024 08:29:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1tLjG9-0007Ne-Lj
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:29:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1tLjG6-0006df-2I
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:29:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734010176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gwEJLU8VfEe4WpG6Kyyy8koTZmYNzH3QNWOlLWxrr8c=;
 b=EQLH9IsDNhhN9BPxTbm9f4Au8DhacMvhSIeSqZSEogy+eFXwRyUmAAnKdzJ1iSNVA4waNI
 IaFe/bZmmsPAomciVQEPMlcLJMBwzdRNFlTYMAjCsXbzk9k+lsnl+XWk4aySNSfFrW89Bj
 zcTJm8/1NVT2gO5tRfOJxpBORkBaQ8Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-utSibjJmMe6mHbybqrmKbQ-1; Thu, 12 Dec 2024 08:29:35 -0500
X-MC-Unique: utSibjJmMe6mHbybqrmKbQ-1
X-Mimecast-MFC-AGG-ID: utSibjJmMe6mHbybqrmKbQ
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43624b081f3so5702865e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 05:29:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734010174; x=1734614974;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gwEJLU8VfEe4WpG6Kyyy8koTZmYNzH3QNWOlLWxrr8c=;
 b=cuRMCJd3jy4Dt+2VILO9NrukPbofuD0vAHVPltkWXpuVL6FkijshBDo0/Do6JxLsfU
 Z+D6ijSgbFXUL8OXH6N/rUgNHSda7qqlYrGoF6NK0mTAZ3skPL61caUqbaucDHLJ6JEf
 Uq2Can89kw6lUxb4a2tPgluBAyWjOfOx3QphBfPS2kfw+pR4B4Tz09gbPSVuf2Hi+rE0
 nT83vtN8KSERr1cRqOjhXXUTuTjnb5vaE1M8b7U+/abOGalRUnRKmQBaJgucRTKbOQhZ
 cMyuq+LaFErtU/gtA93NTPf+1xItW+tJoe8KT4pwLqcEVm4cdCPd2yT1Ry6l4vkKs/Q3
 ZUoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8cf6W5x30IqvkOYV3DwlHxvk0Y1Wp8Yq+79LXbOwYN6og9drprYwpYXpgV4DDVJbQenLW+zneIZh6@nongnu.org
X-Gm-Message-State: AOJu0YwKNHNWUDQz87G6rMWt6AlbtoEuEAfiU/LvLrX3YI56ZE2Bwo6K
 UxNP0fzosVCwfJljs22TcyN4BX8V7CIKOuCljynUpeqJavQzXDrAK5HJiWqKpF6Qep6LKgnGbNA
 L7PBZeB4EJybVUqSRewOPFe6GMz7MC3LgXhwSd5YZpCnH3D6pX48R
X-Gm-Gg: ASbGnctBu2/YJvE8L4xMWO+j6CSnwBeVLriu3kt6ZaZVshOEzI7vXkp7cp+VhDaAZcT
 /28lZ5Z4+ndXoYBS2CErIyi8/NEA3Dmy29Ypm59fnksMQXBwPtLzPspK09XDU3kn/x45BKDUftG
 S6c38jFKsSW+u83K32ZXrSV0NBC7rjJUiKfcw+ivI8AN2u+sjosfWwhSbejH2Lmjv8KGVmmbYTG
 t6lMt2/WSCIZguHXsYXrqyyXb63AGUUdVY60PY+QYXXOh7FdR4f+u1p/I/kkNM9+E/nR+BnBxcO
 PxyAZDhxZayCnhVXUp101yA=
X-Received: by 2002:a5d:64ab:0:b0:385:c511:240a with SMTP id
 ffacd0b85a97d-38787696b5amr2543347f8f.25.1734010174184; 
 Thu, 12 Dec 2024 05:29:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTfSI/0zDLuU0Exc652J9apgcTbTgWAF7L89bL0PLGIQC9v8M+acncx/nDbCMCg2misxlIvw==
X-Received: by 2002:a5d:64ab:0:b0:385:c511:240a with SMTP id
 ffacd0b85a97d-38787696b5amr2543320f8f.25.1734010173698; 
 Thu, 12 Dec 2024 05:29:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38782514db8sm4103844f8f.84.2024.12.12.05.29.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 05:29:32 -0800 (PST)
Message-ID: <7b29665f-a9b5-4f51-ace1-7bad4eaba10c@redhat.com>
Date: Thu, 12 Dec 2024 14:29:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2 00/20] kvm/arm: Introduce a customizable aarch64 KVM
 host model
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
Cc: "shahuang@redhat.com" <shahuang@redhat.com>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, Linuxarm <linuxarm@huawei.com>
References: <20241206112213.88394-1-cohuck@redhat.com>
 <edc12140-6345-4868-938d-c80c4d2c2004@redhat.com>
 <38604260-6f92-4f16-9a4d-c310cbc52d77@redhat.com>
 <4fb49b5b02bb417399ee871b2c85bb35@huawei.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <4fb49b5b02bb417399ee871b2c85bb35@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Hi Shameer,
On 12/12/24 14:09, Shameerali Kolothum Thodi wrote:
> Hi Eric,
> 
>> -----Original Message-----
>> From: Eric Auger <eauger@redhat.com>
>> Sent: Thursday, December 12, 2024 8:42 AM
>> To: eric.auger@redhat.com; Cornelia Huck <cohuck@redhat.com>;
>> eric.auger.pro@gmail.com; qemu-devel@nongnu.org; qemu-
>> arm@nongnu.org; kvmarm@lists.linux.dev; peter.maydell@linaro.org;
>> richard.henderson@linaro.org; alex.bennee@linaro.org; maz@kernel.org;
>> oliver.upton@linux.dev; sebott@redhat.com; Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; armbru@redhat.com;
>> berrange@redhat.com; abologna@redhat.com; jdenemar@redhat.com
>> Cc: shahuang@redhat.com; mark.rutland@arm.com; philmd@linaro.org;
>> pbonzini@redhat.com
>> Subject: Re: [PATCH RFCv2 00/20] kvm/arm: Introduce a customizable
>> aarch64 KVM host model
>>
>> Shameer,
>>
>> On 12/12/24 09:12, Eric Auger wrote:
>>> Connie,
>>>
>>> On 12/6/24 12:21, Cornelia Huck wrote:
>>>> A respin/update on the aarch64 KVM cpu models. Also available at
>>>> gitlab.com/cohuck/qemu arm-cpu-model-rfcv2
>>>>
>>>> Find Eric's original cover letter below, so that I do not need to
>>>> repeat myself on the aspects that have not changed since RFCv1 :)
>>>>
>>>> Changes from RFCv1:
>>>>
>>>> Rebased on more recent QEMU (some adaptions in the register
>> conversions
>>>> of the first few patches.)
>>>>
>>>> Based on feedback, I have removed the "custom" cpu model; instead, I
>>>> have added the new SYSREG_<REG>_<FIELD> properties to the "host"
>> model.
>>>> This works well if you want to tweak anything that does not correspond
>>>> to the existing properties for the host model; however, if you e.g.
>>>> wanted to tweak sve, you have two ways to do so -- we'd probably either
>>>> want to check for conflicts, or just declare precedence. The kvm-specific
>>>> props remain unchanged, as they are orthogonal to this configuration.
>>>>
>>>> The cpu model expansion for the "host" model now dumps the new
>> SYSREG_
>>>> properties in addition to the existing host model properties; this is a
>>>> bit ugly, but I don't see a good way on how to split this up.
>>>>
>>>> Some more adaptions due to the removal of the "custom" model.
>>>>
>>>> Things *not* changed from RFCv1:
>>>>
>>>> SYSREG_ property naming (can be tweaked easily, once we are clear on
>> what
>>>> the interface should look like.)
>>>>
>>>> Sysreg generation scripts, and the generated files (I have not updated
>>>> anything there.) I think generating the various definitions makes sense,
>>>> as long as we double-check the generated files on each update (which
>> would
>>>> be something to trigger manually anyway.)
>>>>
>>>> What I would like us to reach some kind of consensus on:
>>>>
>>>> How to continue with the patches moving the ID registers from the isar
>>>> struct into the idregs array. These are a bit of churn to drag along;
>>>> if they make sense, maybe they can be picked independently of this
>> series?
>>>>
>>>> Whether it make sense to continue with the approach of tweaking
>> values in
>>>> the ID registers in general. If we want to be able to migrate between
>> cpus
>>>> that do not differ wildly, we'll encounter differences that cannot be
>>>> expressed via FEAT_xxx -- e.g. when comparing various AmpereAltra Max
>> systems,
>>>> they only differ in parts of CTR_EL0 -- which is not a feature register, but
>>>> a writable register.
>>> In v1 most of the commenters said they would prefer to see FEAT props
>>> instead of IDREG field props. I think we shall try to go in this
>>> direction anyway. As you pointed out there will be some cases where
>> FEAT
>>> won't be enough (CTR_EL0 is a good example). So I tend to think the end
>>> solution will be a mix of FEAT and ID reg field props.
>>>
>>> Personally I would smoothly migrate what we can from ID reg field props
>>> to FEAT props (maybe using prop aliases?), starting from the easiest 1-1
>>> mappings and then adressing the FEAT that are more complex but are
>>> explictly needed to enable the use cases we are interested in, at RedHat:
>>> migration within Ampere AltraMax family, migration within NVidia Grace
>>> family, migration within AmpereOne family and migration between
>> Graviton3/4.
>>>
>>> We have no info about other's use cases. If some of you want to see some
>>> other live migration combinations addressed, please raise your voice.
>> In relation to [1] you seem to be also interested in the migration
>> between heterogeneous systems with qemu.
> 
> Yes. That is correct.
> 
>> Do you think targeting migration within a cpu family is enough for your
>> use cases. How different are the source and destination host on your
>> cases. Do you thing feat props are relevant in your case or would you
>> need lower granularity at idreg field levelto pass the migration?
> 
> I think, from the current requirement we have for migration, the source and
> destination mostly can be handled by FEAT_XXX. But like Ampere, we do need
> to manage the CTR_EL0 differences[1].
OK
> 
> Also we do have differences in GIC support as well(AA64PFR0_EL1.GIC) which 
> I am not sure how to manage with FEAT_XXX.
interesting. We need to further look at this one.
> 
> And we are checking with our Product team whether we need to support migration
> from an old CPU type in which case we have to do a bit more analysis.
Sure, please come back to us whenever you get more insights. It will
help us define the scope of this upstream work

Thanks!

Eric
> 
> Thanks,
> Shameer
> 
> 1. https://lore.kernel.org/kvmarm/20241022073943.35764-1-shameerali.kolothum.thodi@huawei.com/
> 
> 
> 
>  
>  


