Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0209CD68B05
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 12:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBZKc-0002lK-8F; Thu, 14 Nov 2024 07:52:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBZKa-0002ks-7o
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:52:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBZKY-0005Nq-Sj
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:52:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731588732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aT/818/NH+4B5CZIyuGyhQaZ+iiZP1QDba/KUKzV1eQ=;
 b=TaK0ssFktACfDbc0rLuULEPTtyBWa6dUSI/YUcQigwF//7kNCIINJwqe2WOp6jaV682k7l
 EBQbwYVpQH76tSMXiMYPZAu5iMwQwcBBhQjowwbZjVDIN1ckXtTppjpZntJBsMsuH0A1bG
 OPMMt4s611uKWmN2nzl62jTEvH1Hc/4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-3rri7GqGMzSaI8EBKjCJQQ-1; Thu, 14 Nov 2024 07:52:09 -0500
X-MC-Unique: 3rri7GqGMzSaI8EBKjCJQQ-1
X-Mimecast-MFC-AGG-ID: 3rri7GqGMzSaI8EBKjCJQQ
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315f48bd70so4519285e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 04:52:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731588728; x=1732193528;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aT/818/NH+4B5CZIyuGyhQaZ+iiZP1QDba/KUKzV1eQ=;
 b=qDOYJ0MvQifRc8fNaCqTFWkpaGHXf3quXxJEHKvokGUP+27XokJ+tzpj/2rgbjK/aw
 VU08d4yI8kWAdJDzGLY+20iAblUs9GeAsRGpXzw4jtZQIcpyYPss6CNL6qDNgCp4XqMK
 KCApUViLg9MM9IaZq3iid3A3zjtgeuC+fEXuDzAc2ylaGDJflccbuRBfAALGl8X2aQh8
 nmEWh/VJ0tzqfg8ONQJFW5FqeQ4yU9LQKlmo4wlajwMlXFncQiLY8RlRxG4KmLFPhVG3
 8XUscB66d9SS+kkCHv+kk5svj6mE7oJwiolBWzzNi4AcQAiuaMErLhcMfAiAfgntohg6
 81aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQI+eipEHXk5enhu1jM29a+Ynsv5QwL563zJMDsO3TC7iRS01LCs5ntINjRD3YH0dI2e31pJd5ZUv8@nongnu.org
X-Gm-Message-State: AOJu0YzI9YfPwC+xVsGNWyHVuPUizxa9leELkF+Em86hls1CSmQfI68J
 xbFFF0hv3+g/+TPNxDS9rODvc7HTI8gEaowhfwe3otjwzSew0JV6p7DiJp89uDrnGQTqEqu52+S
 wjkoqIRoc3o+bvEmn/xjpapZ3rKsnt4tJZat33Prt+lA+ubLvOIy8
X-Received: by 2002:a5d:64af:0:b0:381:f443:21b9 with SMTP id
 ffacd0b85a97d-3820df5bca3mr5311215f8f.3.1731588727936; 
 Thu, 14 Nov 2024 04:52:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOXFTA9cCec/K0PsyMkBp5kkJPj+9tSXpLfiHfJrrUi6xiViMzNqtoS0M+4jFCr7VtOJQ9oQ==
X-Received: by 2002:a5d:64af:0:b0:381:f443:21b9 with SMTP id
 ffacd0b85a97d-3820df5bca3mr5311196f8f.3.1731588727524; 
 Thu, 14 Nov 2024 04:52:07 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3821ae3102asm1397396f8f.93.2024.11.14.04.52.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 04:52:06 -0800 (PST)
Message-ID: <b51fce7c-b4eb-4cb4-8f55-d721dc07ca8a@redhat.com>
Date: Thu, 14 Nov 2024 13:52:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: hyperv: add stub for
 hyperv_syndbg_query_options
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20241114121555.1697250-1-pbonzini@redhat.com>
 <a3ad589c-26f8-46b9-b3b0-967ad9620768@tls.msk.ru>
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
In-Reply-To: <a3ad589c-26f8-46b9-b3b0-967ad9620768@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/14/24 13:41, Michael Tokarev wrote:
> 14.11.2024 15:15, Paolo Bonzini wrote:
>> Building without CONFIG_HYPERV is currently broken due to a missing
>> symbol 'hyperv_syndbg_query_options'.  Add it to the stubs
>> that exist for that very reasons.
>>
>> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Rewviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> 
> I'm a bit confused though, - why a stub is "better" than an #ifdef,
> especially in such simple cases?

To be honest the #ifdef was the first thing I did (#ef
> Restoring the #ifdef around this place fixes the build.
> I understand if the function in question were used in lots of
> places around the code, but here it's not the case.
> 
> Another option would be, instead of stubs, to use:
> 
> #ifndef CONFIG_SYNDBY
> #define hyperv_syndbg_query_options() 0
> #endif
> 
> which will make stubs unnecessary entirely.
> 
>> ---
>>   target/i386/kvm/hyperv-stub.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/target/i386/kvm/hyperv-stub.c b/target/i386/kvm/hyperv- 
>> stub.c
>> index 3263dcf05d3..5836f53c23b 100644
>> --- a/target/i386/kvm/hyperv-stub.c
>> +++ b/target/i386/kvm/hyperv-stub.c
>> @@ -56,3 +56,8 @@ void hyperv_x86_synic_update(X86CPU *cpu)
>>   void hyperv_x86_set_vmbus_recommended_features_enabled(void)
>>   {
>>   }
>> +
>> +uint64_t hyperv_syndbg_query_options(void)
>> +{
>> +    return 0;
>> +}
> 
> Thanks,
> 
> /mjt
> 
> 


