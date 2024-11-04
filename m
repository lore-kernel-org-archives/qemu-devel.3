Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F08D132D6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 14:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7yKb-00036d-Q1; Mon, 04 Nov 2024 09:45:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t7yKZ-00035p-3n
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 09:45:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t7yKX-0004b5-IP
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 09:45:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730731520;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JhlNDrXlUzM5p8FZMA7dRiQzkSxBvDnj3EpKeGQ8LMg=;
 b=cEBqX4WGAsX/4mFOCN948/RjFwD3EF5GOdq5ZBqvvgNTyfeAviQKXzBy4ZD/GSqx+m+J3B
 WFIa67c0Akx5rBF+5AbMRNNlJRA9UQjK78e4JGxdxKO9cd/jdUinzpxnp1OIrGoho1ds8X
 C9pNeJDx7RzUjP+mdhumvtMI4UjkcQ0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-d4FaFsZKNQK8tzU0yfRdCA-1; Mon, 04 Nov 2024 09:45:18 -0500
X-MC-Unique: d4FaFsZKNQK8tzU0yfRdCA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4327bd6bd60so28907125e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 06:45:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730731517; x=1731336317;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JhlNDrXlUzM5p8FZMA7dRiQzkSxBvDnj3EpKeGQ8LMg=;
 b=WdHx0mvkUqjjVyBXfSOp8oFWCCAJ2/fIcGrjkTUojBSY4xZ5pXpnu3ZO0kXQ5Ryw6I
 l4r1hcWlPO1nxTN7wg9CHxq+mlhE+QTVeRE1hnKLaKyJTI8bejOiG13K/GnsUzAdAlyE
 zdfGc7Vf/YRt730A96fj970DqgTfLFZjoqeKgxUf+6wJu1+HIJr+g4cH5/toVvVt2Uci
 2ReHaI1OVUDUljG9Psluifmukj6AfKXFF0YJYSFiuHrkr9VP226nGzMYDk7XBwctHYYS
 +w8OCxDq1so8Ar8ALK2xrzWGOLUrPTf2KHqGqh9M6pJZmhLuJS/V0XP6Jp+u0CkO2p0c
 YpKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3HKDveulgq/sdqigNYobhZhLLloQxc2ZoNFjRRqkoKQggTG2dDdsZ3EL5bKTD2fKBro50P6uodxU+@nongnu.org
X-Gm-Message-State: AOJu0Yxy2Cd938iD3sJtxF/kWyCQKoqeRKVpDnk8dFizzJqWTEh46O8E
 +vg6b4fsOLhDnJztiKrNa5ntK9VziqGS6dOPyBFq8g77DHW7jacY+Ik+CF4Pgbce4MaHb4jUI2C
 VAjpbUJ4Fe1ooH3G8OsA4ki7qv/7DkDB4NnQQmyaVBOtQYVOzSpl/
X-Received: by 2002:a05:600c:4f83:b0:42c:c28c:e477 with SMTP id
 5b1f17b1804b1-4319ad089b0mr249763575e9.23.1730731517245; 
 Mon, 04 Nov 2024 06:45:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEK7DnUTIUKjcmX0ueGziHtEgez9caMGryr8uN8uniSi+BuEypdN+ho4a6Av64MwJgDD1dOlA==
X-Received: by 2002:a05:600c:4f83:b0:42c:c28c:e477 with SMTP id
 5b1f17b1804b1-4319ad089b0mr249763345e9.23.1730731516834; 
 Mon, 04 Nov 2024 06:45:16 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9180f2sm184056535e9.19.2024.11.04.06.45.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 06:45:16 -0800 (PST)
Message-ID: <24ca0278-5018-41e3-a097-ac560a16f8fa@redhat.com>
Date: Mon, 4 Nov 2024 15:45:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 21/21] arm/cpu-features: Document custom vcpu model
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 abologna@redhat.com, jdenemar@redhat.com, shahuang@redhat.com,
 mark.rutland@arm.com, philmd@linaro.org, pbonzini@redhat.com
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <20241025101959.601048-22-eric.auger@redhat.com>
 <ZxuZkUFz_bwAA1pf@redhat.com>
 <0700af51-a1a6-4b11-a4bf-0eaf6e279c6d@redhat.com>
 <Zxudl5-fZV1vIaEL@redhat.com> <87y128nrfr.fsf@redhat.com>
 <Zx-3OUioG1l47hW3@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Zx-3OUioG1l47hW3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Hi

On 10/28/24 17:09, Daniel P. Berrangé wrote:
> On Mon, Oct 28, 2024 at 05:05:44PM +0100, Cornelia Huck wrote:
>> On Fri, Oct 25 2024, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>>> On Fri, Oct 25, 2024 at 03:28:35PM +0200, Eric Auger wrote:
>>>> Hi Daniel,
>>>>
>>>> On 10/25/24 15:13, Daniel P. Berrangé wrote:
>>>>> On Fri, Oct 25, 2024 at 12:17:40PM +0200, Eric Auger wrote:
>>>>>> From: Cornelia Huck <cohuck@redhat.com>
>>>>>>
>>>>>> Add some documentation for the custom model.
>>>>>>
>>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>>>>> ---
>>>>>>  docs/system/arm/cpu-features.rst | 55 +++++++++++++++++++++++++++-----
>>>>>>  1 file changed, 47 insertions(+), 8 deletions(-)
>>>>>> @@ -167,6 +196,16 @@ disabling many SVE vector lengths would be quite verbose, the ``sve<N>`` CPU
>>>>>>  properties have special semantics (see "SVE CPU Property Parsing
>>>>>>  Semantics").
>>>>>>  
>>>>>> +The ``custom`` CPU model needs to be configured via individual ID register
>>>>>> +field properties, for example::
>>>>>> +
>>>>>> +  $ qemu-system-aarch64 -M virt -cpu custom,SYSREG_ID_AA64ISAR0_EL1_DP=0x0
>>>>>> +
>>>>>> +This forces ID_AA64ISAR0_EL1 DP field to 0.
>>>>> What is the "baseline" featureset implied by 'custom' ?
>>>> there is no baseline at the moment. By default this is a host
>>>> passthrough model.
>>> Why do we need to create "custom" at all, as opposed to just letting
>>> users toggle features on "-cpu host" ? 
>> We could consolidate that to the current "host" model, once we figure
>> out how to handle the currently already existing properties. Models
>> based on the different architecture extensions would probably be more
>> useable in the long run; maybe "custom" has a place for testing.
> If you can set the features against "host", then any testing could
> be done with "host" surely, making 'custom' pointless ?
Yeah I do agree that we may not need to introduce this "custom" model
bus just enhance the custom host model with the capability to tweek some
features. For instance we have the case where migration between 2 Ampere
systems fails with host model but if you tweek 1 field in CTR_EL0 it
passes. So I think in itself this modality can be useful. Same for
debug/test purpose. As mentionned in the cover letter the number of
writable ID regs continue to grow and this enhanced host model gives
flexibility to test new support and may provide enhanced debug
capabilities for migration (getting a straight understanding of which ID
reg field(s) causes the migration failure could be helpful I think)

Thanks

Eric
>
> With regards,
> Daniel


