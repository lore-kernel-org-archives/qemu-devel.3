Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD48AD5CCB0
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 13:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t68rd-0005s7-H3; Wed, 30 Oct 2024 09:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t68rX-0005rd-9Z
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 09:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t68rU-0004UP-60
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 09:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730295346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ycbpiS8YtDS5t2sn+UJcDpR5DNcvGO84dDS36EoLcb0=;
 b=cwqVknKtsdQnMT//tKQioZ1ZG0nAblAXZU1DBbkQ1edjlUxXZPwcVXpPiC8wWr9gtsQ2y2
 RXcKFso3xhwzxKsNGcdUpu6MrVAvLuiEnAvsj4wLfYN14QFfKh7vg8bcb9dJ581O6cr1Mm
 U5LL0H9/LVRoCuDRKRIgbKzFhsDRo2Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-Lvru3AA3M-qvrHMuTigeiQ-1; Wed, 30 Oct 2024 09:35:43 -0400
X-MC-Unique: Lvru3AA3M-qvrHMuTigeiQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d533a484aso505655f8f.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 06:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730295342; x=1730900142;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ycbpiS8YtDS5t2sn+UJcDpR5DNcvGO84dDS36EoLcb0=;
 b=LAiSYruRPTAe/7UPD60uPb7O9ZXikRTNp7NXElg7jB5Bkgsc71QdQcq9tsHMxHdjZa
 ZcjaMBCIIzuxCXe5r5Ku2Wuxnuc8VvhbaEwMOhbvX+rdYfszJIOsQCXRJQM6oe/YThRh
 wVsjAdou4H1nzUSaOTV4iujDQ4MNdINkTPTGrz0dpxwXgUODWcUP5C6B96mIRUt9vu+M
 rqMOcBYE+JTP9PySSty/6x9fg1e6fxUeaQ16fYGLYqmNK+PxkV7t9ZRhh+GjHVxVvLJP
 v8qb9BO18jYeNSlh6sa3D9M/SnSLya92D9oAJFW+I07nP8xNZT72DG+9BD4aNohRNZmx
 1u7w==
X-Gm-Message-State: AOJu0Yx8+GOgQRvapm2QPPEPzN65hQ8DOSxKvaJs/aXU6E+/6axAafE3
 FmuHJkj73i8dbVJIAVYZ0AueH3Owf+fYiYE1lf3cQuNv8zOu7j/K9QlqU5CU1PkwtPhhB719dsN
 8n+aO5p3BxGoslgRUh2xHx5Fny10wa5Rsf38upLJTpHFN4adOo/fh7qpui1hGfRk=
X-Received: by 2002:a05:6000:c8b:b0:37d:443b:7ca4 with SMTP id
 ffacd0b85a97d-381b97159fbmr2051073f8f.14.1730295342298; 
 Wed, 30 Oct 2024 06:35:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfTrxUh8sCayiJdEUbJFvyroKXCAw58212gi0ABOBMz2uTSCcw3cJX3AE6lWRRsB48zIn0bg==
X-Received: by 2002:a05:6000:c8b:b0:37d:443b:7ca4 with SMTP id
 ffacd0b85a97d-381b97159fbmr2051047f8f.14.1730295341785; 
 Wed, 30 Oct 2024 06:35:41 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-431bd918333sm22082635e9.10.2024.10.30.06.35.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 06:35:41 -0700 (PDT)
Message-ID: <5eedaf78-78f5-40c1-a240-942b55a2450e@redhat.com>
Date: Wed, 30 Oct 2024 14:35:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/hvf: hide MPX states from XCR0
To: Phil Dennis-Jordan <lists@philjordan.eu>
Cc: qemu-devel@nongnu.org
References: <20241029130401.525297-1-pbonzini@redhat.com>
 <CAGCz3vtb9Afiq0JbthJQrn=hkXJ=X6cEKywuCs++bAqsf_+HMg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <CAGCz3vtb9Afiq0JbthJQrn=hkXJ=X6cEKywuCs++bAqsf_+HMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/30/24 13:30, Phil Dennis-Jordan wrote:
> On Tue, 29 Oct 2024 at 14:05, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> QEMU does not show availability of MPX in CPUID when running under
>> Hypervisor.framework.  Therefore, in the unlikely chance that the host
>> has MPX enabled, hide those bits from leaf 0xD as well.
> 
> To clarify: is there some kind of issue with MPX in Qemu in general?
> Or is this a consistency effort - normal Macs don't expose this
> feature, so we have no idea if it were to work if someone did manage
> to hack up some frankensteinian host system that somehow does have
> those bits set?

That, and also that real hardware will only show XSTATE_BNDREGS_MASK and 
XSTATE_BNDCSR_MASK if the MPX bit is set in CPUID; which it isn't in 
hvf_get_supported_cpuid().

In fact, for completeness it should also go the other way: if 
XSTATE_YMM_MASK is not set in the result of XGETBV, AVX should be 
hidden.  And if any of OPMASK, ZMM_Hi256 and Hi16_ZMM are not set in the 
result of XGETBV, AVX512F (and AVX10 eventually) should be hidden in 
hvf_get_supported_cpuid().

By the way, could you check if Macs set the PKRU bit of XCR0 (bit 9) 
and/or the OSPKE bit in CPUID (that's bit 4 of CPUID[EAX=7, ECX=0].ECX)?

Thanks,

Paolo

> 
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   target/i386/hvf/x86_cpuid.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
>> index e56cd8411ba..4b184767f4a 100644
>> --- a/target/i386/hvf/x86_cpuid.c
>> +++ b/target/i386/hvf/x86_cpuid.c
>> @@ -110,9 +110,9 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
>>           if (idx == 0) {
>>               uint64_t host_xcr0;
>>               if (xgetbv(ecx, 0, &host_xcr0)) {
>> +                /* Only show xcr0 bits corresponding to usable features.  */
>>                   uint64_t supp_xcr0 = host_xcr0 & (XSTATE_FP_MASK |
>>                                     XSTATE_SSE_MASK | XSTATE_YMM_MASK |
>> -                                  XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
>>                                     XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK |
>>                                     XSTATE_Hi16_ZMM_MASK);
>>                   eax &= supp_xcr0;
>> --
>> 2.47.0
>>
>>
> 
> 


