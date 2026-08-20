Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A031C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5DB-0001Se-7G; Thu, 20 Aug 2026 12:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wx5D9-0001Qv-HL
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:01:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wx5D7-0001ZQ-Sn
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787241705;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jgxfJA5YmAPMWiGBYOTfNd4f6lfx0My1rIrOn4iPbsE=;
 b=MObRl0X8gt7ZZps5NfFTz4zxuHQF6l8d4ZidiwE4z1hzbHGK1FgP6tXE3fYDvNKORo43PO
 ZjY8F+a7jGPPo21S5F+KiUirHg9KmBO1QMlMLCVc+84PZf/DNW54U0QHqnvaM0+1Qlekyg
 gUlvhBnqw4Q4Z5HiOP+IkMKeBtfevKM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-6ZpywneoPfqb0UbdlPkF-g-1; Thu, 20 Aug 2026 12:01:38 -0400
X-MC-Unique: 6ZpywneoPfqb0UbdlPkF-g-1
X-Mimecast-MFC-AGG-ID: 6ZpywneoPfqb0UbdlPkF-g_1787241698
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47eaa4006a1so565724f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787241697; x=1787846497;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jgxfJA5YmAPMWiGBYOTfNd4f6lfx0My1rIrOn4iPbsE=;
 b=Lce2HUdU0VWzE9eXyxgOwYEIEomYNTGTvoTwhXHAOftGLWQzPO782zB/KgraxcN6tx
 +vswVEbFPKuRfbSHsTbh022ddR/2Bc7+3atviSHEiNQMaRUXRmrqlHLrFGJEA4r8RTNb
 ALGxz66Fb+Gx9yPLMIbI73EAXBWh/Vjl6l+SCJd7DCHA1ELj2UbtJ/T3u4bNd/fd4SjE
 eIRMqpkZlyO3HrqP4pWuGgDK2hIMOoebiL5TQ+SnExjsbPTeog5IUq7S7KWzYEpSBjZP
 TPjyUrZq3oDN6oohJqBtk+xteF3YgpjNsqyoLvScA/t/ZLMAYVgN2I+EYb2Q2Xc4duJn
 JI2w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoiS0kjr1dlu3Ep3Abnzfsznx2EF/JPDIde1uqc7F18Sa2g1i2Kx3r35DtlmBcNulyLdPkGq5Lqm5nB@nongnu.org
X-Gm-Message-State: AFuF++l9/WJsvYuvgi6fr+njmjfj0wdmleqjeTugzappmqYLQ2xoSeg6
 CNKl9jfJ9pS1kFd1lTVp3+dYG8EKU/HbU9dOLW8Bcv6kPzXO+kTfsnG2iIHiJCTWn6wvDEzIv+Z
 IxxWefy6PPPCGiM3jgrppf7o/dt5Xh4j72HGt/BAXI62DGH7R5PHCWD81
X-Gm-Gg: AR+sD11dM0lHWznLwMClaR4Qxoru9zg9nqnMMPHiwWtoUWUN1Los8slwEGl8qrp7bmT
 YkQuYKHl4HeOkk1feuFyONptvSPyKDzRBM8Mfp55mpAmBFhPlxRlG9GnCOhqqhX0XgUo+7fZI6I
 Uv2wq+Xg3IW9rvfBRZPZlVgLZB67hP9UiAUf4ZHCaXhWkdoguymo4YF+N7sO5bO5YygUFGZaYpW
 Y4TWQo7ur3EKsRpIb4pkyKL4udUGG1KRjfizQYXc8vwxGTIIRcXAv3NEiO/YLXbtIiqIN/zF4n5
 NT3kUvUfYdx7HsIUoLDl+avUBtGQWAoxRZrDkf33IA7nYPjofCVdGK4eUTG1VyMyJ0DZUb4YSmR
 /xpsyahb+jIXjtB8/kIDjuf0Jc0WTr21yc2V7zvBvjDjkEL00
X-Received: by 2002:a05:6000:4b06:b0:47f:e746:dcab with SMTP id
 ffacd0b85a97d-482b785dc08mr13918654f8f.10.1787241697497; 
 Thu, 20 Aug 2026 09:01:37 -0700 (PDT)
X-Received: by 2002:a05:6000:4b06:b0:47f:e746:dcab with SMTP id
 ffacd0b85a97d-482b785dc08mr13918516f8f.10.1787241697127; 
 Thu, 20 Aug 2026 09:01:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482bf82594esm267911f8f.29.2026.08.20.09.01.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 09:01:36 -0700 (PDT)
Message-ID: <9ac6089a-2dad-441b-8ec7-f6c03cdad312@redhat.com>
Date: Thu, 20 Aug 2026 18:01:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 16/19] qmp: add query-cpu-props-info command
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "yangjinqian1@huawei.com" <yangjinqian1@huawei.com>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Prerna Saxena <prerna.saxena@nutanix.com>
References: <20260716213858.609699-1-khushit.shah@nutanix.com>
 <20260716213858.609699-17-khushit.shah@nutanix.com>
 <878q6m5qox.fsf@pond.sub.org>
 <3099C064-6051-4B93-BE0F-C54B7FD91D82@nutanix.com>
 <9909725f-7dd8-4f88-b016-2a6134906a60@redhat.com>
 <676C0BA3-A842-4784-84D2-8B446E8CAB67@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <676C0BA3-A842-4784-84D2-8B446E8CAB67@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 8/18/26 11:46 AM, Khushit Shah wrote:
>
>> On 14 Aug 2026, at 7:08 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> Hi Khushit,
>>
>> On 8/5/26 8:47 AM, Khushit Shah wrote:
>>>> On 4 Aug 2026, at 12:15 PM, Markus Armbruster <armbru@redhat.com> wrote:
>>>>
>>>> !-------------------------------------------------------------------|
>>>> CAUTION: External Email
>>>>
>>>> |-------------------------------------------------------------------!
>>>>
>>>> Khushit Shah <khushit.shah@nutanix.com> writes:
>>>>
>>>>> Introduce the 'query-cpu-props-info' QMP command. For CPU model
>>>>> properties it reports the type (boolean or number) and the set of values
>>>>> supported under the active accelerator and host.
>>>>>
>>>>> For numbers the supported values are expressed as a list of inclusive
>>>>> {min, max} ranges; for booleans as the list of allowed true/false
>>>>> values.
>>>>>
>>>>> The command and its return types (CpuPropertyType, CpuPropertyInfo and
>>>>> friends) are defined in qapi/machine.json rather than an Arm-specific
>>>>> schema, since the concept applies to other targets (e.g. x86, riscv)
>>>>> too. Target that do not implement it return an error.
>>>>>
>>>>> The Arm/KVM implementation spins up a scratch "host" vCPU object,
>>>>> walks its QOM properties: SYSREG_ ID-register fields become 'number'
>>>>> properties whose ranges come from arm_field_get_supported_values(),
>>>>> and the advertised feature toggles become 'boolean' properties.
>>>>>
>>>>> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
>>>> This explains what the command does and how it's implemented.  It's
>>>> silent on the most important aspect: why do we want the command?  What
>>>> is its intended purpose?
>>> Will add something like:
>>>
>>> This helps the management stack to discover which values are supported
>>> for a given CPU property. This is especially important for non-boolean
>>> properties, where knowing that the host has value 'x' does not inherently
>>> reveal the full range of valid values supported on the host.
>> How does x86 handle this at the moment, they don't have the cmd either?
>> How do they currently introspect what are the valid values for a
>> specific host? Is it easier for them?
> x86 is much simpler, all the cpu features properties are backed by cpuid bits
> and assumption is simple, if host value is “true”, “false" is supported, and
> if the host value is “false", “true" is not supported.

OK thanks!

Eric
>
> Warm Regards,
> Khushit
>>
>> Thanks
>>
>> Eric
>>>
>>>


