Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E21C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 13:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY38U-0002rN-Ti; Wed, 15 Jan 2025 08:08:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tY38S-0002qo-Ja
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 08:08:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tY38Q-0001Sl-HZ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 08:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736946515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Fc7cKU/1cAWrHZdMhH5kayTeyw/WjXePQGKlqhuh3a0=;
 b=EI/6WFZVX1dyA1ToAklUg6ZFIPK3HIZU56wEM8w/UPQIyEskHic4Og3kGBwyFaN5GwfmuP
 8gK8LuEPAnFVLHZioT7n3I+mmePmB14TSSYRAjLghu8R9DqvSZd6I8m6IM2aQ/1frOzPeV
 OZ4e7xsgFKG9ZQCfoJeAUtwC4JZtfCQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-MN1Q8T-NOh-Q8gfdQ0arxg-1; Wed, 15 Jan 2025 08:08:33 -0500
X-MC-Unique: MN1Q8T-NOh-Q8gfdQ0arxg-1
X-Mimecast-MFC-AGG-ID: MN1Q8T-NOh-Q8gfdQ0arxg
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385d52591d6so395150f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 05:08:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736946512; x=1737551312;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fc7cKU/1cAWrHZdMhH5kayTeyw/WjXePQGKlqhuh3a0=;
 b=shU6gOBR5zyOTLfYhI/tEZWllGRV72doUYEDmSJp03zoxLyt0hfa3zb/lBaeJKDcif
 wx0q4Swbhqs+Qk5yvOxOk0Ec6ySI1Oas96phySX/nDvoavp6s+tO8wv774cf0bt3Q4V9
 wZg5UDcLBeLzgFlTh8FYjHVLkxLvKoviR+UbhRdgJJ5KdefTGWedqcjJVTUTZAwrB0je
 ByyJnG5NtPLD3/0dh9x0NLVbteuhdwtqWCkOPGFcfdEsdKlRNyD/1peNCmhlTD4iWfPj
 /NuAi45FRP1qXRyRBDNDEAhKoXVUje7UiSeyZOc6GQSX1ngI/ooMG5aC5JnCzz9Zy0yT
 u/7w==
X-Gm-Message-State: AOJu0YxPli5BzKs5pSc3z0h0EtSPqjT/UKtSauHoA5uM76/XL4shAT8r
 qS/5N7OkG9hxAtuFkG438PO9mzWKOJW3FlRNiMwFQKOfQ/V8Vk44tyaQ8SFcvGkEq2nfK0KIu+j
 GrVWpJbtj1ZvIX1GzGe3G7T0BCkif/OdBWSsYMxoFTOKANyMRWKXu
X-Gm-Gg: ASbGncvZQZ9SUueVbcTcHjM2qids0+ClPGZxf35Ws12Ke+y85WUFwaXF5cqy+MNt6f6
 0JoRpYHhpCNDIovKDQaKv38sMEy/qSwOpW2ZpJrhxnx6PShvGvZe9qREy0AT19paZ1zxCP/Dlg9
 JoYrjMen4d9LqiMCy/db9CuEHWORZmhmAjhRHMbwEsg9H+rGSXKnMIXIDl4TGIU5DdsPw6rusli
 Ws158qtM/zkyMAHB/LnpGwbZcTOTF00Jc9Quszzl54xy0q247jsnsUIrQZ7
X-Received: by 2002:a05:6000:2c1:b0:386:374b:e8bc with SMTP id
 ffacd0b85a97d-38a8b0d3425mr21832181f8f.15.1736946512152; 
 Wed, 15 Jan 2025 05:08:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFFLvv9fGNV3ed44rqeK71muipbLBKSIx5QwHIRdWFwIJNAaNwXcbnABzeVipixh4Jg45QQg==
X-Received: by 2002:a05:6000:2c1:b0:386:374b:e8bc with SMTP id
 ffacd0b85a97d-38a8b0d3425mr21832163f8f.15.1736946511772; 
 Wed, 15 Jan 2025 05:08:31 -0800 (PST)
Received: from [192.168.10.3] ([176.206.124.70])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b81ccsm17816154f8f.65.2025.01.15.05.08.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 05:08:30 -0800 (PST)
Message-ID: <f1e17aac-543a-4d9b-906b-8ee98d1ff55e@redhat.com>
Date: Wed, 15 Jan 2025 14:08:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/9] rust: vmstate: implement VMState for scalar types
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, junjie.mao@hotmail.com
References: <20241231002336.25931-1-pbonzini@redhat.com>
 <20241231002336.25931-6-pbonzini@redhat.com> <Z34fAFD4d/BVZQkn@intel.com>
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
In-Reply-To: <Z34fAFD4d/BVZQkn@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
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

On 1/8/25 07:45, Zhao Liu wrote:
>>   #[macro_export]
>>   macro_rules! vmstate_of {
>> -    ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])? $(,)?) => {
>> +    ($struct_name:ty, $field_name:ident $([0 .. $num:tt $(* $factor:expr)?])? $(,)?) => {
> 
> Why change ident to tt?

Rebase mistake.  Initially I had $num:tt, however that becomes unclear 
if you have [0 .. 0] where the second 0 is a field name.

>> +impl_vmstate_scalar!(vmstate_info_bool, bool);
>> +impl_vmstate_scalar!(vmstate_info_int8, i8);
>> +impl_vmstate_scalar!(vmstate_info_int16, i16);
>> +impl_vmstate_scalar!(vmstate_info_int32, i32);
> 
> missed VMS_VARRAY_INT32 :-)

I left that out intentionally, as Rust is probably going to use 
IndexMut<uNN> instead of i32.

>> +impl_vmstate_scalar!(vmstate_info_int64, i64);
>> +impl_vmstate_scalar!(vmstate_info_uint8, u8, VMS_VARRAY_UINT8);
>> +impl_vmstate_scalar!(vmstate_info_uint16, u16, VMS_VARRAY_UINT16);
>> +impl_vmstate_scalar!(vmstate_info_uint32, u32, VMS_VARRAY_UINT32);
> 
> If we want to expand in the future (e.g., support vmstate_info_int32_equal
> and vmstate_info_int32_le), then introducing new macro variants will be
> straightforward. So, fair enough.
> 
>> +impl_vmstate_scalar!(vmstate_info_uint64, u64);
> 
> What about applying this to "usize" with vmstate_info_uint64?

There's 32-bit hosts too...  So one would have to add vmstate_info_ulong 
which is serialized as 64-bit.

We can add it later, but perhaps we could also create a derive(Index, 
IndexMut) macro that makes it possible to specify the type of the index. 
  While Rust uses usize instead of uNN for array indices, that does not 
have to be universal; using uNN is a lot better if it means you can get 
rid of casts from register values to array indices and back.  See for 
example commit 6b4f7b0705b ("rust: pl011: fix migration stream", 
2024-12-19).

That is indeed also an issue for HPET, but in that case it can be 
isolated to a couple lines,

             let timer_id: usize = ((addr - 0x100) / 0x20) as usize;

and it could even be wrapped further

     fn timer_and_addr(&self, addr: hwaddr) -> 
Option<&BqlRefCell<HPETTimer>, hwaddr> {
         let timer_id: usize = ((addr - 0x100) / 0x20) as usize;
         if timer_id > self.num_timers.get() {
             // TODO: Add trace point - 
trace_hpet_timer_id_out_of_range(timer_id)
             None
         } else {
             Some((self.get_timer(timer_id), addr & 0x18))
         }
     }

     ...

     match self.timer_and_addr(addr) {
         None => 0 // Reserved,
         Some(timer, addr) => timer.borrow_mut().read(addr, size)
     }


So for HPET you didn't reach the threshold of having to create "pub 
struct HPETTimers([BqlRefCell<HPETTimer>; MAX_HPET_TIMERS])" and 
implement Index<>.

Paolo


