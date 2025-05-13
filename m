Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADE9C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 15:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uErND-0002c8-9a; Tue, 13 May 2025 11:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uErN4-0002bO-MR
 for qemu-devel@nongnu.org; Tue, 13 May 2025 11:16:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uErN1-000541-6a
 for qemu-devel@nongnu.org; Tue, 13 May 2025 11:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747149397;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/XoJ42U2y/9zd0YP7um9oFc+AhPWl/ZEz6pZ6QwMtwA=;
 b=ELDXdnihxaUgfT2eycVLKFOU62Hh+uwpDUJdCSRDPs+ziylGLMNLYEns5mddeO61aFXSFJ
 0xBCFeTe7S/c0A2QBX1uj9yvE6sJ9/2l7GLgHcqPUAuNusrQovCUViBbKa510QZTOfNmaV
 ymxqneJhgcqvPWuNs5pH+RBWCZYCCug=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-mNmeTjIHMD-3mfnNU_uGdw-1; Tue, 13 May 2025 11:16:35 -0400
X-MC-Unique: mNmeTjIHMD-3mfnNU_uGdw-1
X-Mimecast-MFC-AGG-ID: mNmeTjIHMD-3mfnNU_uGdw_1747149394
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a1f9ddf04bso2499336f8f.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 08:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747149394; x=1747754194;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/XoJ42U2y/9zd0YP7um9oFc+AhPWl/ZEz6pZ6QwMtwA=;
 b=EI0DrjVCyDpUyD/TP3jw04FJST/laD0Dez/R0LIlLyMYCyXAmSgB5juAiKlh4/MELx
 Kebqcqeg/s5BY2Xrvb/iLGxS+m0ckIVvb8D4MUavwBn3D0x/TyuidrufrZYi6St4esdA
 r/MbjsrEIbpxFZnidq2LsRZjaT00bEUSIq8zFbtPYhHwueYEkikFN43C//oUI4uit1T5
 dqmHCQhCfadwX5MevKMWes8PTcchzcsd31R3ofkLF83qhM928OIUmrQS7ilsC5jGKFzF
 mDtKf1dlIg5KrVjyZTUwFNOdXJjZHkMcU4P0ov/1pIosdgfg/jTSYY4wdZ3vcQz83VDO
 9nNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUNflb1KN0gyKepm075XRF0NKbSzIZpgNPFm8WvIkHr7iwLd0ptbS+/cJSTK0bgEYItMF7j4C2gJ++@nongnu.org
X-Gm-Message-State: AOJu0Yyp4JlW2MnrgWS0WqLdCRNtMT4MqASudATAX8MWWZcb8GQgAL5N
 gqEtMVF1ijXfkC8czzo8me7HiE03h4rTDkZCy5vVCgphOVgS8DK5ijmdeb4ITNWU40eX7m/AQ2l
 S0EUFLZXkrovO3T+/LQFnWz+0mnn+3gHoJ8fjuO/XHrPYHCIZ6cza
X-Gm-Gg: ASbGncvURhqTUXiQauEeEBAXmAWuSvliDXIvZQqdvZJI/L7eyNRgToPYuj0vOJI2x5V
 iI46LJp7NxxXaDiVdyIKPsfsQZBFscXEWMOB5MK9YmsKPjY31NlPkaGQyx1eFijEahbH4xycVFo
 SQvK3KqR+uhQF0zU4tMcaPqiVQ04oTU3lgF/5XmEGChqKvvU5oy0QfUPwcH1wl6zUYOGsvBSAeq
 ZfasRiK4figYTk0gGGGQpn5fqbM2H3sEtTU06epqyLCJWQmMQl936VoROvabo33CJ6UfYUMakD+
 D4wja0P9xoH4H8WYkhIa/Wx1lgabKS7n7x9m2moQX6dSed41Y/LZpdgtWQc=
X-Received: by 2002:a5d:598e:0:b0:39c:2688:612b with SMTP id
 ffacd0b85a97d-3a1f64277femr15647008f8f.7.1747149394192; 
 Tue, 13 May 2025 08:16:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO9N1Muxi40863izt+xRGg83Sc69SpQT6SZfRFMKC1kCRtYNKU+SmXOLs5AdVDo+SN9lle3Q==
X-Received: by 2002:a5d:598e:0:b0:39c:2688:612b with SMTP id
 ffacd0b85a97d-3a1f64277femr15646959f8f.7.1747149393817; 
 Tue, 13 May 2025 08:16:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58ecb46sm16707990f8f.30.2025.05.13.08.16.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 08:16:33 -0700 (PDT)
Message-ID: <b62b7529-e782-41d6-91d4-c59af1b92020@redhat.com>
Date: Tue, 13 May 2025 17:16:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] kvm: kvm_get_writable_id_regs
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com,
 philmd@linaro.org, pbonzini@redhat.com
References: <20250414163849.321857-1-cohuck@redhat.com>
 <20250414163849.321857-5-cohuck@redhat.com>
 <4f370fae-8234-48ca-97e2-3b7038092974@redhat.com> <878qn0po69.fsf@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <878qn0po69.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 5/13/25 4:42 PM, Cornelia Huck wrote:
> On Tue, May 13 2025, Eric Auger <eric.auger@redhat.com> wrote:
>
>> Hi Connie,
>>
>> On 4/14/25 6:38 PM, Cornelia Huck wrote:
>>> Add an helper to retrieve the writable id reg bitmask. The
>>> status of the query is stored in the CPU struct so that an
>>> an error, if any, can be reported on vcpu realize().
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>  target/arm/cpu.h     | 26 ++++++++++++++++++++++++++
>>>  target/arm/kvm.c     | 32 ++++++++++++++++++++++++++++++++
>>>  target/arm/kvm_arm.h |  7 +++++++
>>>  3 files changed, 65 insertions(+)
>>>
>>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>>> index d27134f4a025..bbee7ff2414a 100644
>>> --- a/target/arm/cpu.h
>>> +++ b/target/arm/cpu.h
>>> @@ -856,6 +856,26 @@ typedef struct {
>>>      uint32_t map, init, supported;
>>>  } ARMVQMap;
>>>  
>>> +typedef enum ARMIdRegsState {
>>> +    WRITABLE_ID_REGS_UNKNOWN,
>>> +    WRITABLE_ID_REGS_NOT_DISCOVERABLE,
>>> +    WRITABLE_ID_REGS_FAILED,
>>> +    WRITABLE_ID_REGS_AVAIL,
>>> +} ARMIdRegsState;
>>> +
>>> +/*
>>> + * The following structures are for the purpose of mapping the output of
>>> + * KVM_ARM_GET_REG_WRITABLE_MASKS that also may cover id registers we do
>>> + * not support in QEMU
>>> + * ID registers in op0==3, op1=={0,1,3}, crn=0, crm=={0-7}, op2=={0-7},
>>> + * as used by the KVM_ARM_GET_REG_WRITABLE_MASKS ioctl call.
>>> + */
>>> +#define NR_ID_REGS (3 * 8 * 8)
>> We may rename this define to better associate to the KVM API. I tend to
>> mix it with NUM_ID_IDX now ;-)
>> maybe something like KVM_NR_EXPOSED_ID_REGS
> The kernel calls it KVM_FEATURE_ID_RANGE_SIZE, but I'd like to avoid
> adding 'KVM' in the name, as it is basically a range of registers and
> nothing really KVM specific... maybe ID_REG_RANGE_SIZE?
what about NR_ID_REG_MASKS
because it is masks actually.
>
>>> +
>>> +typedef struct IdRegMap {
>>> +    uint64_t regs[NR_ID_REGS];
>>> +} IdRegMap;
>> I would add a comment saying this is the mask array, just to prevent the
>> reading from thinking it is the actual reg content.
> "More comments" seems to be a theme :) I'll go ahead and add them where
> it makes sense.
yeah. I am sorry. previously we had a single indexing and on top of that
we have several kinds of definitions for id regs and writable masks.
Even for me who contributed to that mess it can be difficult to parse so
I imagine it can be painful to read for other readers too ;-)

Eric
>
>>> +
>>>  /* REG is ID_XXX */
>>>  #define FIELD_DP64_IDREG(ISAR, REG, FIELD, VALUE)                       \
>>>      ({                                                                  \
>>> @@ -1044,6 +1064,12 @@ struct ArchCPU {
>>>       */
>>>      bool host_cpu_probe_failed;
>>>  
>>> +    /*
>>> +     * state of writable id regs query used to report an error, if any,
>>> +     * on KVM custom vcpu model realize
>>> +     */
>>> +    ARMIdRegsState writable_id_regs;
>> maybe rename into writable_id_reg_status that would better reflect what
>> it is.
> Indeed.
>


