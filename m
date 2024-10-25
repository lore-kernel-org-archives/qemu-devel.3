Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82ACD0C608
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 13:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4KN4-0007CJ-Ab; Fri, 25 Oct 2024 09:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t4KN1-0007Bk-TM
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 09:28:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t4KN0-0001ej-Ex
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 09:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729862929;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jfuBxxkO8cV8uPIqOpQfVwuiKiP8AV2qLKYZ7Y6yiag=;
 b=LJxNaK0uAp+4j3bfsGoxFdfWfvJbfkZ+aF2L8YYq0BwLJasm6D45e7oHlyMKg9Sfn4Ppes
 W6PrK5KScKLK2L0uj1MCiBd4hLMKeYMB94M7yh8APJVUJOvL3bMujX044BD68H27KTVW9U
 bJ9y1wNWNeFK2g2xQd3J6h+UZORwp1E=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-C6eW1hHrMaOEvN_LTQkryw-1; Fri, 25 Oct 2024 09:28:41 -0400
X-MC-Unique: C6eW1hHrMaOEvN_LTQkryw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-539eb3416cdso1745950e87.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 06:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729862919; x=1730467719;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jfuBxxkO8cV8uPIqOpQfVwuiKiP8AV2qLKYZ7Y6yiag=;
 b=NleVQjjx7hbtC8HBez5OBjdCemKUGzUSCyZtnF7LRbGiGFdm7PGPP5omA53eCB/8GO
 cBka8Uv/GkWHqLfh+JwuQIemkxsivSjJyGDPBVQ5SCbl34hC8Mm+uRNl8NzeAmhVeHWa
 yHL5gIznCj9JcKzBCZtabLN05qxMjbpJaFe5mF8qnQWXiPf1pSkb3cyv+qBR9FU5DugN
 ARO/emhU2Iwm7Kf6YaZIsu30YO5FIIHhufflk8bLJuT9HxPEAvDet6SO2NyOlliMr96k
 Odj8ym25B0Ew8MfUBbznBGsxptBFz7Ske+HvnUkeK7pBKXgJrf0OBpxnnfPupk5c8RJd
 QANQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfwuhU9QNDBXggS9WATk1Uleu9SxyP4tzfnEudyDMnEzFTSpr9vpDVYVRnxBloMRsRN3Yzheeio66i@nongnu.org
X-Gm-Message-State: AOJu0YxqkJxubTSLBiSFGgCKjqwH1YeNK4vQlA/OLKykkNaGrW1zKXmS
 fif6r0pqCiElHBAd0T2f/gk4u1anpIAQaGVje3FIAUAk3AHhAzzvL5az4E7Wf29TPRYDtzJzmNA
 Brbnl8QH0tFz+hZ1MgnxE69/ooulHNVcbSSfzljaopk7X5HnFw/8d
X-Received: by 2002:a05:6512:2305:b0:539:e88f:2398 with SMTP id
 2adb3069b0e04-53b23e8ec21mr3935987e87.39.1729862919474; 
 Fri, 25 Oct 2024 06:28:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF38/JwpTvN+i+PqB6gp8UXbBdtyfsmOOwXFBBS3WTo0y8Vn7BqQnx8AhOIgGqem4PRWrP/zg==
X-Received: by 2002:a05:6512:2305:b0:539:e88f:2398 with SMTP id
 2adb3069b0e04-53b23e8ec21mr3935965e87.39.1729862918950; 
 Fri, 25 Oct 2024 06:28:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43193572932sm18131515e9.1.2024.10.25.06.28.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 06:28:38 -0700 (PDT)
Message-ID: <0700af51-a1a6-4b11-a4bf-0eaf6e279c6d@redhat.com>
Date: Fri, 25 Oct 2024 15:28:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 21/21] arm/cpu-features: Document custom vcpu model
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: eric.auger.pro@gmail.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 abologna@redhat.com, jdenemar@redhat.com, shahuang@redhat.com,
 mark.rutland@arm.com, philmd@linaro.org, pbonzini@redhat.com
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <20241025101959.601048-22-eric.auger@redhat.com>
 <ZxuZkUFz_bwAA1pf@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <ZxuZkUFz_bwAA1pf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Daniel,

On 10/25/24 15:13, Daniel P. Berrangé wrote:
> On Fri, Oct 25, 2024 at 12:17:40PM +0200, Eric Auger wrote:
>> From: Cornelia Huck <cohuck@redhat.com>
>>
>> Add some documentation for the custom model.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  docs/system/arm/cpu-features.rst | 55 +++++++++++++++++++++++++++-----
>>  1 file changed, 47 insertions(+), 8 deletions(-)
>
>> @@ -167,6 +196,16 @@ disabling many SVE vector lengths would be quite verbose, the ``sve<N>`` CPU
>>  properties have special semantics (see "SVE CPU Property Parsing
>>  Semantics").
>>  
>> +The ``custom`` CPU model needs to be configured via individual ID register
>> +field properties, for example::
>> +
>> +  $ qemu-system-aarch64 -M virt -cpu custom,SYSREG_ID_AA64ISAR0_EL1_DP=0x0
>> +
>> +This forces ID_AA64ISAR0_EL1 DP field to 0.
> What is the "baseline" featureset implied by 'custom' ?
there is no baseline at the moment. By default this is a host
passthrough model.
>
> On x86 we have the named CPU models each setting a baseline that matches
> some corresponding real world silicon. Arm has that too, with TCG at
> least. So that way you know what the baseline is that you're toggling
> features against.
Having named models is the next thing. custom vcpu model is not a named
model. But we don't want to TCG like CPU model (like A57) because we
want to be able to migrate between different machines like Ampere to
NVidia or different Ampere systems. So the baseline must be something
usable by both hosts.
>
> Experiance on x86 was that making arbitrary feature changes on top of the
> named models could often backfire, as there are too many scenarios where
> code will check for feature "Y", and assume that existance of "Y" implies
> existance of "A", "B" and "C" too. So if you invent custom models where
> Y is set, but B is missing, there's decent risk of things going wrong in
> horrible to debug ways.  With that in mind, best practice is to try to
> just the vanilla named CPU models to the greatest extent possible, and
> keep feature toggling to an absolute minimum.  This 'custom' model does
> not seem to give us such ability for arm.
The custom model is not yet a named model. This is rather something to
start this kind of discussion.
The code used by the custom vcpu model allows fine tuning of the ID reg
fields. This code could be reused by named models. We can also imagine
that libvirt does implement the named models, ie. hardcodes some IDReg
fields and thus implement the named model instead. Libvirt could
identify what is the baseline source and dest are the closest to, choose
this baseline and tune few reg id fields if some additional tuning are
needed.

Thanks

Eric
>
> With regards,
> Daniel


