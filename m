Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53413CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 10:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDgZv-00016S-Td; Tue, 28 Oct 2025 06:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDgZs-000126-44
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:05:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDgZk-0008Aw-9p
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761645905;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nOo9uR7J0l315HU73AtoT4K1wWyDT5B/ZPYqPZT/ZxQ=;
 b=PTi7fhyQcrOIBUzezemy2MfgCTiZEBj2e+w9Bgvgx8g2dreoHP3e2rFDSIX3kj+hDvLn5W
 cis2skaoH/rUyFA64+lUMjKMvOZu3HGSG4ix5m4y81byYnbwIvTHq15xz+1ZMwcGVo2ZLp
 863BDnCr/IQsZJ1mioQLaUl5rKXtMZw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-irI_I310PViqtL89SUMOhg-1; Tue, 28 Oct 2025 06:05:04 -0400
X-MC-Unique: irI_I310PViqtL89SUMOhg-1
X-Mimecast-MFC-AGG-ID: irI_I310PViqtL89SUMOhg_1761645903
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-475dca91610so15389145e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 03:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761645903; x=1762250703;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nOo9uR7J0l315HU73AtoT4K1wWyDT5B/ZPYqPZT/ZxQ=;
 b=ZvlPoJIBRtaD+cwlGnLrhQOlTSf9iFkFC8+EIVDF6sYF589H1P4a5wJgkd5Kgk1Ll0
 PSZ4eq+dCBz9v8sxmHWwr+kgZJeYOJuwnqoDXVjyL3mvDSw2EMp2RO5qSmjiOHg386mX
 HsYe0rGCQKwimHXhWZ0q7/uF8l4qeCbyFbiLQATsOarwywDT7vN3b8HSozUI5vBLtH+k
 XUvTj3ykJ1MuYJCWNNCPocEt8mW/wXwQiLi2IUSC4hpQGull0Fp02wg9YKOkitk2fUeK
 nZJWY4FzfgtWKuT6vJuQVupPaC0/4ZZdemNWZ8j5w5aj/fzrgi927mAqc2uWQCO6g9Du
 BVUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmM/iw3WUJ7x1o9WK8ESar5Jo8J4ZbtUCsGfOqXP8Gleucs6BI99hV8jiDsYE00TnsA/IIhZrHH2Zf@nongnu.org
X-Gm-Message-State: AOJu0YyRGkuw2utfOtNIO8nuULqDEIzGrn23X1h7Ar+Avcx603XkUQ4v
 scOklqGLC1O2rr/LnxdVm6LcXLkWfSPQYTN9CPGarghwmdO6vIwW9RQzXLrXyJI8GMOQPy0Xjs1
 Ws/+UQHLXY/S8wL31Wocb8FTv83ziQd9vXWkFqyb/BJ4I319d6bbC8PTw
X-Gm-Gg: ASbGnct5uVxHp9Z2N+ESEBru4T8OSzeHd0oGkkaAkRCfbtIPgz08Zw3bGQD8speoLCQ
 KmMzAhYEffSOYK4wN9Hqk3bvKTQwdQvzCXtV+hwf3dTe/AgdE3YEZAUp02ghGXPI9rbC9dIXd6D
 8l3Fpl9+n2zHzc0o++nWg6IKcVjQDeAwGnvUaflwXELmKiFQRWNLa78N7ySe7E1+VrwJSnnOddE
 NCHMCaV/726bjUlg6Il/yQASbxgiBkG2D41eCuRMpCxDBcLyliUaPZsEmH0QFl4mNQy4U9loPtf
 M0j7wKdPek1lN6q3Lom+JvTjIsv3aMK+X37uV3oFwVqtZk73JKRkN5k6OVmZaRFl0SdJ3A59c17
 2H2jn0DEomNzheC8cE8E4WBYFYOJeN+uoJKFMNaKaNIInaQ==
X-Received: by 2002:a05:600c:6383:b0:477:58:7d04 with SMTP id
 5b1f17b1804b1-47717df9758mr23550505e9.9.1761645902772; 
 Tue, 28 Oct 2025 03:05:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+UUEfQtFIt2rgEkIWSSt/759ewXcSx3BrSbDBO5NttH5A9aBYdOo3B5QTPPuRjL8Gua5vFg==
X-Received: by 2002:a05:600c:6383:b0:477:58:7d04 with SMTP id
 5b1f17b1804b1-47717df9758mr23550205e9.9.1761645902305; 
 Tue, 28 Oct 2025 03:05:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d5768sm19974464f8f.24.2025.10.28.03.05.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 03:05:01 -0700 (PDT)
Message-ID: <ef080164-0e4b-4799-a43b-3ff69225e073@redhat.com>
Date: Tue, 28 Oct 2025 11:05:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 1/7] target/arm/machine: Improve traces on register
 mismatch during migration
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com, gshan@redhat.com,
 ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org, pbonzini@redhat.com
References: <20251016140039.250111-1-eric.auger@redhat.com>
 <20251016140039.250111-2-eric.auger@redhat.com> <877bwtvaj7.fsf@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <877bwtvaj7.fsf@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Connie,

On 10/17/25 4:59 PM, Cornelia Huck wrote:
> On Thu, Oct 16 2025, Eric Auger <eric.auger@redhat.com> wrote:
>
> More information is really valuable here. I have some nits :)
>
>> Currently whenthe number of KVM registers exposed by the source is
> s/whenthe/when the/
>
>> larger than the one exposed on the destination, the migration fails
>> with: "failed to load cpu:cpreg_vmstate_array_len"
>>
>> This gives no information about which registers are causing the trouble.
>>
>> This patches rework the target/arm/machine code so that it becomes
> s/patches rework/patch reworks/
>
>> able to handle an input stream with a larger set of registers than
>> the destination and print useful information about which registers
>> are causing the trouble. The migration outcome is unchanged:
>> - unexpected registers still will fail the migration
>> - missing ones are print but will not fail the migration, as done today.
> s/print/printed/
>
>> The input stream can contain MAX_CPREG_VMSTATE_ANOMALIES(10) extra
>> registers compared to what exists on the target.
>>
>> If there are more registers we will still hit the previous
>> "load cpu:cpreg_vmstate_array_len" error.
>>
>> At most, MAX_CPREG_VMSTATE_ANOMALIES missing registers
>> and MAX_CPREG_VMSTATE_ANOMALIES unexpected registers are print.
> s/print/printed/
>
> If we really get tons of register discrepancies, I'd expect the reason for
> that to be something more obvious, so limiting should be fine.
>
>> Example:
>>
>> qemu-system-aarch64: kvm_arm_cpu_post_load Missing register in input stream: 0 0x6030000000160003 fw feat reg 3
>> qemu-system-aarch64: kvm_arm_cpu_post_load Unexpected register in input stream: 0 0x603000000013c103 op0:3 op1:0 crn:2 crm:0 op2:3
>> qemu-system-aarch64: kvm_arm_cpu_post_load Unexpected register in input stream: 1 0x603000000013c512 op0:3 op1:0 crn:10 crm:2 op2:2
>> qemu-system-aarch64: kvm_arm_cpu_post_load Unexpected register in input stream: 2 0x603000000013c513 op0:3 op1:0 crn:10 crm:2 op2:3
>> qemu-system-aarch64: error while loading state for instance 0x0 of device 'cpu'
>> qemu-system-aarch64: load of migration failed: Operation not permitted
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  target/arm/cpu.h        |  6 +++++
>>  target/arm/kvm.c        | 23 ++++++++++++++++
>>  target/arm/machine.c    | 58 ++++++++++++++++++++++++++++++++++++-----
>>  target/arm/trace-events |  7 +++++
>>  4 files changed, 88 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index bf221e6f97..a7ed3f34f8 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -936,6 +936,12 @@ struct ArchCPU {
>>      uint64_t *cpreg_vmstate_values;
>>      int32_t cpreg_vmstate_array_len;
>>  
>> +    #define MAX_CPREG_VMSTATE_ANOMALIES 10
>> +    uint64_t cpreg_vmstate_missing_indexes[MAX_CPREG_VMSTATE_ANOMALIES];
>> +    int32_t cpreg_vmstate_missing_indexes_array_len;
>> +    uint64_t cpreg_vmstate_unexpected_indexes[MAX_CPREG_VMSTATE_ANOMALIES];
>> +    int32_t cpreg_vmstate_unexpected_indexes_array_len;
> "indices"?

Thanks, all those will be fixed in next version.

Thanks

Eric
>
>> +
>>      DynamicGDBFeatureInfo dyn_sysreg_feature;
>>      DynamicGDBFeatureInfo dyn_svereg_feature;
>>      DynamicGDBFeatureInfo dyn_smereg_feature;
> (...)
>


