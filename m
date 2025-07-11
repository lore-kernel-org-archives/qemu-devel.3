Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8370EC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 07:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua8Sz-0007RU-TX; Fri, 11 Jul 2025 03:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua8Sw-0007NH-T7
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 03:46:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua8St-0004in-V5
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 03:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752219998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YhudSPprKYHZ/MzRgQ5lsemVPgOV01PCRNHtve3MWaQ=;
 b=T1n652lQDLAt0rJP9QEMnK+x+XaFyrihx1U4ZiBnlIVXe5up1jSxGEg5BKDdiO4ApVk2QG
 7H6+RHSTM0erGYljBvgBaCozggOGCiNTgMF9HrkGzTL16p8uPmYqcMEgX4bFih+DrdKdp4
 1zl83N3IjUoZnLW/dwjAGX1tXcYV3+8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-Zz_9sacRNbe7MBbO41HSQA-1; Fri, 11 Jul 2025 03:46:36 -0400
X-MC-Unique: Zz_9sacRNbe7MBbO41HSQA-1
X-Mimecast-MFC-AGG-ID: Zz_9sacRNbe7MBbO41HSQA_1752219995
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4eb6fcd88so1267068f8f.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 00:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752219995; x=1752824795;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YhudSPprKYHZ/MzRgQ5lsemVPgOV01PCRNHtve3MWaQ=;
 b=MgCwohk15zpi+iyamqqOkcM3hqg5D/ugMWn1BKETTKJ6jLqYvpE2Rh9K6FcGs5fMW1
 USZgDiDeiQ2B3diPxAN/X/X2XbMTebF7mUSNVgvJaBlnBxVhaAejBrbUqIb3jKvaiqIu
 JkTv18xHXvCQ35LbBIutbbjN9kX2qauo0DknkhAOQRyoXCOuZNTRyTqszTOsV8sa47cn
 3NhEY0jq3lPIXbBXtMXYx2bYUhS+aqyktCETj+v4DK2nzO1E9fUPTGHAsdp7BFYso7EQ
 2iYCq0kd85jmRAqXWKIBsqg+MHKnkeg3PbrfRZyWGzYGXWE7SvgFUKh5sYztTTCmqWR9
 RY6w==
X-Gm-Message-State: AOJu0Yxk2bV4M3vgtFxci3IhJWf8UlnFkmX3YazOQUvmK4R9ahVxOqOH
 hvOK3dlBQPVwgsM3DAL5rwdgsao7jV32oDE01CP/p4aBA2vFePaNDPhuL5mr8WL8KUDeALIv8SL
 tmHG7LmY04n19DjP6mfjkpvS9Wzn5Hoov3F6LoQkkAQMaqAKMBlUZOK/qJTJv4HF0
X-Gm-Gg: ASbGncvwsrt+8WhU26QFt5cZlYzNFefNwu9EWgR4kjcnBaNFEodonHbuH3oVwtf+aBm
 pFfXEM6HouA2yzRoK/4171OOtvkh/3n6Z7pMf/dWRitFGr17X9hBctOqG/kBXvUPidEJgnK9FE+
 6uAVDdm2emNho2NAFGIC6pd698OCTetDo+eIAtwpVY6OeL/ban9iPy9/aRM8N3yOZ9GI/etGg4w
 yTHL9xuce6vokXKDtpyUnPolOmLPBs4pOAsUtU486JFrXKPDRwEIvh36HWoTdHeMRp8IU66zZ9j
 kg1KfhhObDBdOuJmD0a2/tpIf5HwYU6AfJC8t/wKywcA
X-Received: by 2002:a05:6000:4b1a:b0:3a4:f7ae:77ca with SMTP id
 ffacd0b85a97d-3b5f2db1588mr1386176f8f.3.1752219995014; 
 Fri, 11 Jul 2025 00:46:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG495B16slqErVjzHV9UQiAIjDgPhHQ0Ik7bCxPxFS3stR9ghOfClqlP9pzmbPH9zrwfWZtow==
X-Received: by 2002:a05:6000:4b1a:b0:3a4:f7ae:77ca with SMTP id
 ffacd0b85a97d-3b5f2db1588mr1386152f8f.3.1752219994555; 
 Fri, 11 Jul 2025 00:46:34 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.202.169])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d4b5sm3824220f8f.53.2025.07.11.00.46.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 00:46:33 -0700 (PDT)
Message-ID: <51b63329-6ee5-43cc-809d-1b06cc8d12f2@redhat.com>
Date: Fri, 11 Jul 2025 09:46:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/i386: nvmm, whpx: add accel/CPU class that
 sets host vendor
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Zhao Liu <zhao1.liu@intel.com>
References: <20250711000603.438312-1-pbonzini@redhat.com>
 <20250711000603.438312-3-pbonzini@redhat.com>
 <92d23086-7866-44a0-b54e-7690c0306248@intel.com>
 <CABgObfbPXmBLrScC3nQMT5A7mf1xz0hSnkLdrvcFS=hGr3dxSg@mail.gmail.com>
 <523e1e29-67f7-4103-bd39-3e06329adc6d@intel.com>
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
In-Reply-To: <523e1e29-67f7-4103-bd39-3e06329adc6d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/11/25 08:40, Xiaoyao Li wrote:
> On 7/11/2025 2:35 PM, Paolo Bonzini wrote:
>> Il ven 11 lug 2025, 04:18 Xiaoyao Li <xiaoyao.li@intel.com> ha scritto:
>>
>>> Besides, do we need to call host_cpu_max_instance_init() for the case of
>>> xcc->max_features, like what has been done for kvm and hvf?
>>
>> I am intentionally skipping that because it would not have any effect and
>> there is no equivalent to KVM_GET_SUPPORTED_CPUID2 implemented for those
>> accelerators.
> 
> I meant host_cpu_max_instance_init(), not the upper function like 
> kvm_cpu_max_instance_init() or hvf_cpu_max_instance_init().
> 
> host_cpu_max_instance_init() is for the case "-cpu max/host", which not 
> only sets "vendor" to the host value, but also the "host-phys-bits", 
> "family" "model" "stepping" and "model-id"

Ah, thanks - it also does not have any effect so I didn't think about 
it.  But the separation between host_cpu_instance_init() and 
host_cpu_max_instance_init() is confusing.  I'll send a patch to merge 
them into one function, which should resolve your doubt.

Paolo


