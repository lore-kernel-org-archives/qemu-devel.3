Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07498CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 11:10:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDha6-0002Z5-PW; Tue, 28 Oct 2025 07:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDha1-0002WE-Vk
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:09:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDhZs-0000D9-V5
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761649761;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fapeBS9BlMiWanMAmjo5FOfv9HzZKkc/WpK7c6FKcGc=;
 b=A21y0snpXmioW1ueLBDGHNt4lR8w8E2By2zvaTVmH5MRo77aamhY1kQOnrxtEiCF30YmWF
 prYAn6ZEKsLzlls/CuUktx+LxR72yBkolrt76hxHNEVVCVL77e/PHn802pcDFu00T2nFJd
 3Ydgeb7ST+cm8qEshiIxg/zJVJpobpA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-qr_XLkUtNum7y5kg2cRegg-1; Tue, 28 Oct 2025 07:09:20 -0400
X-MC-Unique: qr_XLkUtNum7y5kg2cRegg-1
X-Mimecast-MFC-AGG-ID: qr_XLkUtNum7y5kg2cRegg_1761649758
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4710d174c31so54562025e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 04:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761649758; x=1762254558;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fapeBS9BlMiWanMAmjo5FOfv9HzZKkc/WpK7c6FKcGc=;
 b=sKsL3I2rluHm9yGNsloGS/o9XknEf3ipQ6su3MUV+2bmVHbli4cuBg13SinJQyeeKb
 klhOkfAf9piCmC4koH58kmWjkd2Aeu9WvRyW0Bnt4LClJ5XkHGqUhvLZlgpp/Y9n4yLQ
 D3DnxDYP2AV97XwF1MUImf1oyK5Bt3Guq/VQAufBMxzrS1Lu2Cghn7enrf19pfrn7924
 TU+ox+anxuDDm8cnTf+Z3sITO6aDHMQ8BZ7zHI0g1G2p/Ldqyqb/uqQ+okFuJ5Ecw4aC
 xJHbkXJv5zVbF9dYvXzd4F2YalJEMb7Ym4+JdsGIHexuduvJHRIxjufoSOg9t0YAtL7O
 E9Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSHwXYTFXtXKcjmqSw6L7NwC2oXc45Qcm1ouEUCZz4wvRCZ9qSZFxpHHGPgzOIcP3+yq0COorY2WDM@nongnu.org
X-Gm-Message-State: AOJu0Yzam9vCWFxNPOSlRh3xcs/nrbKYpcXb8PMBUKu23gOAuNGUYa7Z
 UsKvzmfPt7SLx9SsFucOmkEJyP1DdBj0Yg1nJl9i+zFim+QoiXLEonh4heVh7xrhPrwNJ/MYZpP
 MVtiqH4MWca70kRwrGMGff8/aeWQIpg+H3S6qfTYoKyxaTlQ8uc/qIfx4
X-Gm-Gg: ASbGncv+MXYepB+zT+MVmEmV0sGtQnPILRGdQxCW1qdvkIv+ovV8lat9KTvKJ6xd386
 jAMexM2pX+qAkzz5M/0KqNziUHjLu1ZQNOCJFGXFypaTIEvvA7vqRuU4aQKzIXLT2BWLBGDn4/h
 qEnUFIV6c7MAZZx4jH3l8A5eLDuGzFeKJ/u74yVTk5SKnvZrY2/f8OU46bd5on8PSaK4i6DpJz1
 PfgUuLjPkckAPRegAPvrKb+qjbzj/sQJA816oATmzzndq9DOUWsC8Vpy8rjALmhof3h31qQ/7P7
 OKnGgU8OcqDt+air0E3qGDVHmTm2DPl8AEWg7ZRZUpU27MMTYphRtFSuCUBSWm3YkGIF6HBu3TY
 D+RfQ+6V+TdN+YIK0DtXYQq6/ypHVSWEvg+NozLdc4qPHMQ==
X-Received: by 2002:a05:600c:1e0f:b0:471:9b5:6fd3 with SMTP id
 5b1f17b1804b1-47717d48706mr22441265e9.0.1761649757852; 
 Tue, 28 Oct 2025 04:09:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY9PtLRhmhOJVgaKLuJAd1yQ3XJUdvEIF9JnQKeEWI8/jDORg2dqxJeXrB8HT4Jx/+n8WWNA==
X-Received: by 2002:a05:600c:1e0f:b0:471:9b5:6fd3 with SMTP id
 5b1f17b1804b1-47717d48706mr22440925e9.0.1761649757415; 
 Tue, 28 Oct 2025 04:09:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd02cbc6sm194271915e9.1.2025.10.28.04.09.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 04:09:16 -0700 (PDT)
Message-ID: <96597d95-f338-46e8-b353-567a10913e57@redhat.com>
Date: Tue, 28 Oct 2025 12:09:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 7/7] hw/arm/virt: [DO NOT UPSTREAM] Enforce
 compatibility with older kernels
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 cohuck@redhat.com, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com,
 philmd@linaro.org, pbonzini@redhat.com
References: <20251016140039.250111-1-eric.auger@redhat.com>
 <20251016140039.250111-8-eric.auger@redhat.com>
 <CAFEAcA_DSo7COpwXF_W4sMiwwmGvZy21GON7UbKWm4H5uDxb4A@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA_DSo7COpwXF_W4sMiwwmGvZy21GON7UbKWm4H5uDxb4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 10/28/25 11:37 AM, Peter Maydell wrote:
> On Thu, 16 Oct 2025 at 15:01, Eric Auger <eric.auger@redhat.com> wrote:
>> This is an example on how to use the new CPU options. This catters to
>> distributions who want machines to be migratable (forward and backward)
>> accross different host kernel versions in case KVM registers exposed
>> to qemu vary accross kernels. This patch is not meant to be upstreamed
>> as it is really kernel dependent. The goal is to illustrate how this
>> would be used.
>>
>> In this example, For 10_1 machines types and older we apply the following
>> host kernel related compats:
>>
>> 1) Make sure the KVM_REG_ARM_VENDOR_HYP_BMAP_2 exposed from v6.15 onwards
>>    is ignored/hidden.
>> 2) Make sure TCR_EL1, PIRE0_EL1, PIR_EL1 are always seen by qemu
>>    although not exposed by KVM. They were unconditionnally exposed before
>>    v6.13 while from v6.13 they are only exposed if supported by the guest.
>>
>> This will allow 10_1 machines types and older machines to migrate
>> forward and backward from old downstream kernels that do not feature
>> those changes to newer kernels (>= v6.15).
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/arm/virt.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 175023897a..c4f9b82c38 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -97,6 +97,23 @@ static GlobalProperty arm_virt_compat[] = {
>>  };
>>  static const size_t arm_virt_compat_len = G_N_ELEMENTS(arm_virt_compat);
>>
>> +/*
>> + * if a 10_1 machine type or older is used:
>> + * 1) make sure TCR_EL1, PIRE0_EL1, PIR_EL1 are enforced, even if they are not
>> + *    exposed by the kernel
>> + * 2) hide KVM_REG_ARM_VENDOR_HYP_BMAP_2
>> + */
>> +static GlobalProperty arm_virt_kernel_compat_10_1[] = {
>> +    /* KVM_REG_ARM_VENDOR_HYP_BMAP_2 */
>> +    { TYPE_ARM_CPU, "kvm-hidden-regs", "0x6030000000160003" },
>> +    /* TCR_EL1, PIRE0_EL1, PIR_EL1 */
>> +    { TYPE_ARM_CPU, "kvm-enforced-regs",
>> +      "0x603000000013c103, 0x603000000013c512, 0x603000000013c513" },
> Strings which are lists of long hex numbers? Is there a
> more readable way to do this?

forgot to mention that we could use x- prefix for those properties to
enphasize they are rather experimental and not meant to be used commonly.

Eric
>
> -- PMM
>


