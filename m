Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2E3C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 14:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuuXJ-0001me-Fx; Wed, 19 Mar 2025 10:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tuuXA-0001d6-Cu
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tuuX7-0008H7-MX
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742394985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=koe5j68PabD4GkHOib/tBOlUPg1kxjdv7mljJ/4/xQY=;
 b=X/Qiyw/p1D33A0P3zIAxfnqhLquVZCnz4HH081iZdsZF7MBBMp8NY5UByBYwCi1oaEQJ7L
 ho4TVaRkc4fmsB9XWi1QxwX/+QQNX8IQaVU9lh1bgyoZ/coh9uu7s46KQNlrsB2KwIJ05C
 I5Rkz4ML4QNO5jEvbCK9IAXkZX9jINE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-uElMvg2uMdOlDowvb4skXg-1; Wed, 19 Mar 2025 10:36:24 -0400
X-MC-Unique: uElMvg2uMdOlDowvb4skXg-1
X-Mimecast-MFC-AGG-ID: uElMvg2uMdOlDowvb4skXg_1742394983
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-438da39bb69so35779925e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 07:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742394983; x=1742999783;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=koe5j68PabD4GkHOib/tBOlUPg1kxjdv7mljJ/4/xQY=;
 b=E8qhWHqmhP5u1uK+yDBU74Tj/wFAzEuyXJLt24QA/Ss6LGLuFc3vFAeQ/qor1zTytr
 /T0iwkTAdeTNl7G99/dfG8Y6oPOCFXU4hV3ClpNWsswV0w/+K0VxDOBeKE/Q/2FxYiEi
 4LKDIMYA0J/eu8+gf89eDo2LoI8jjbstjkoP+mPhi//qVJz89Egyq7UdCHtOjZMjOMew
 CAR+NMarPh/ISI4Yx/BGg3Fe+KbUK54adaxPENjo+/6zZjkYtSm2cKo1IuuWJe/U/nnI
 oQjUDGbIZlfIoiTz7yh4FyQVYPEA6JvAZvykFPhrR3QXyJ7X+AqpXCyE6Xw+rPzCOE3i
 O0pg==
X-Gm-Message-State: AOJu0YzkmK1ZwFKBbv86XCUEA2RV4+/7QKWQf2I8coIKdeDWyVuS9FF6
 M6L6oX+zprLa85rWzUDNZ13Kjyiw1+JFWXaRyMxE/8xyzvMLICSAg6aX495gg5Ltm6kzTR/zkpu
 vMTgkx5F7FUh4pJeildXu0NFHoBM2ynm7xMBZWc8mkxehzgIrAQuh
X-Gm-Gg: ASbGncs5Nepb8ceZp3bWAVumkDmoOxzTeJD5khzTkM4nCPm4KBSNJkc0YwNOoF9gGr/
 3xM+lJ/SVuNLAelduTI1/2KSapJLrtrUx7uWdQOqTNDx8yimNMz2nOUoHBArMhJu1UAs5Z8OKAs
 57NJU7MtxeS5Bjk4mNnTh92MYbEU4Bpu0Xt6+dFhcmJW4Ce6JyxJUb8PiYk24k67kuQ/dFS8CQ5
 zr402a7eoBUdUqlSeots6FsKnurVyqRoxrsVwGxOIxtKyT6UUZeu/pMG4KtndQt9AQfK9RxUBpu
 utxFLhgW2iHZNdeZFXY2
X-Received: by 2002:a05:600c:3d17:b0:43d:b51:46fb with SMTP id
 5b1f17b1804b1-43d4378617dmr28916685e9.2.1742394982796; 
 Wed, 19 Mar 2025 07:36:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmGE5Ni6kRDGnM5cNrhCBEFCjj02J6ZPcwO4IYHQJy9T0tyt+KZktO3kooKWKCcLj/z6cCsg==
X-Received: by 2002:a05:600c:3d17:b0:43d:b51:46fb with SMTP id
 5b1f17b1804b1-43d4378617dmr28916475e9.2.1742394982374; 
 Wed, 19 Mar 2025 07:36:22 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.194.153])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43d43f589bfsm20595355e9.22.2025.03.19.07.36.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 07:36:21 -0700 (PDT)
Message-ID: <2b217943-709a-4b1b-8622-077eadbe8d17@redhat.com>
Date: Wed, 19 Mar 2025 15:36:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix duplicate symbol error on MacOS build
To: Peter Maydell <peter.maydell@linaro.org>,
 Tanish Desai <tanishdesai37@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20250319023036.71493-1-tanishdesai37@gmail.com>
 <CAFEAcA80b54NZUxPv_QoXQXakTwEuRvK-hxy==c=-PEB2dB3sg@mail.gmail.com>
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
In-Reply-To: <CAFEAcA80b54NZUxPv_QoXQXakTwEuRvK-hxy==c=-PEB2dB3sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 3/19/25 14:44, Peter Maydell wrote:
>> -    select PL011 # UART
>> +    select PL011 if !HAVE_RUST # UART
>> +    select X_PL011_RUST if HAVE_RUST # UART
>>       select PL031 # RTC
>>       select PL061 # GPIO
>>       select GPIO_PWR
> 
> Paolo: we seem to have quite a lot of this
> 
>      select PL011 if !HAVE_RUST # UART
>      select X_PL011_RUST if HAVE_RUST # UART
> 
> duplicated for every PL011-using machine. Can we factor this out
> in Kconfig? e.g.
> 
> config PL011
>      select X_PL011_RUST if HAVE_RUST
>      select PL011_C if !HAVE_RUST
> 
> (and update hw/char/meson.build to use CONFIG_PL011_C for pl011.c).
> Then all the machines can go back to plain "select PL011" and
> don't need to care whether it's the Rust or C version.
> 
> Or does that not work?

Yes, it works.

Paolo


