Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458DCC19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 18:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tniT1-0003ri-Gc; Thu, 27 Feb 2025 13:18:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tniSq-0003hl-CS
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 13:18:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tniSo-0007fj-OR
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 13:18:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740680304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=785TVKlH/oXg0JjIveQPUvowxX+WXLxIN+Z9t75+dXw=;
 b=SPXGGmq47SJYwEvHjs4VkIZwq7KWR5GYOIJKFIXn1qqc21T218uVmyw11+y6O8SEYN7y1u
 c8y9plknBNdo11VYco/TcbyxZUXMvMDdIE5yUsEI+xy1SXbh4fkZXvkn87RuM1s65vYePD
 eCXaiRYZj6s6y0Y55hIkh+ytVz9HfX0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-bfB3CLMrPvW31oRU3-Uw_Q-1; Thu, 27 Feb 2025 13:18:22 -0500
X-MC-Unique: bfB3CLMrPvW31oRU3-Uw_Q-1
X-Mimecast-MFC-AGG-ID: bfB3CLMrPvW31oRU3-Uw_Q_1740680301
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-abb76bd0feeso190774366b.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 10:18:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740680301; x=1741285101;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=785TVKlH/oXg0JjIveQPUvowxX+WXLxIN+Z9t75+dXw=;
 b=tW8bcKqdov63ZFwyxJu7EG3rG9abN4LKNHY1f3yqdg5ybAlgm/FCvn4vYXuqrFxiI1
 klYne1xVO1Lam/fStWfdvtMDatb83WyaMUdsMBm4M4SyT69fkXH5YB6X2OlLVdLKTHbA
 dkG6BPDcQBGb+4dff6gOnbzFulmfMbQBLs1D1RfVokS24cYr+Ek5T4O3hVhATtpx5Dp+
 6nbulqfUr6UaMe/rBjxzdnmzjPKJYSqgzlnAQkM7y9MCqtO0uW6K3lw2SUvURW6Qa43p
 3bWKnz0xWafxnx0kpuXoB39pF7qdFryf9vDgUWBp6cwj+UD3lHXkOOZ7ineZyE64lA9y
 uKeQ==
X-Gm-Message-State: AOJu0Yxt2ceixGoZY93idPg1wVre2BpxZtr8vn7cWdjXgB9QfiLHMrd6
 XTRaNupO01UtxeOusfWBJNPaoaG8D6orWaOvHxOfFq8o6VeO3LTeojdGUgNgsaz3ajHUEUbnD9i
 ThhQVgFNhMm1abFLg8FGJVqczZcnZnL/eRZHUeOZboh/eJkNxX8yBueatu7Pv1AY=
X-Gm-Gg: ASbGnctxb0bsjPaL23pFBsX+qDTDrNd2AqxE09G2STohadixlijCXgYLPyBnZg+iTCJ
 FIaVzwMBVzC+x4I1Y92Ya7KqhneU+Kn4QhlR+vDQCTyw6tdZ1xDzGxF7QkeyUEszDTybr2lVPQg
 yg4VeaPM3QjbUt5V3a+JRKHj8Y9JzUl/UpdvHrIvBupBgqLww1elQ3cxYlSo+gP/hLlBqeNHEQI
 w4NJc43oDjHDp0y08BoDLNCUDE0frxS44/cZCJaV6M01anCV1ZmLHGMsItQ2x2quh4DZ1cIoU0A
 /Bq738SoFGhuqfLxgQ==
X-Received: by 2002:a17:906:da82:b0:abf:27ac:2cf8 with SMTP id
 a640c23a62f3a-abf27ac4019mr34713166b.21.1740680300806; 
 Thu, 27 Feb 2025 10:18:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPv7n1JodXu9FnaKFTXeHkAYLRR4mB/uo5fhVkWtfyzSV4SpX066QLdutO64njS1vLJyxIKA==
X-Received: by 2002:a17:906:da82:b0:abf:27ac:2cf8 with SMTP id
 a640c23a62f3a-abf27ac4019mr34710766b.21.1740680300404; 
 Thu, 27 Feb 2025 10:18:20 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-abf0c756f6csm161805966b.141.2025.02.27.10.18.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 10:18:19 -0800 (PST)
Message-ID: <850cde98-4be4-4240-a8b3-428ff9f66ea0@redhat.com>
Date: Thu, 27 Feb 2025 19:18:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] rust: pl011: move register definitions out of lib.rs
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20250227164538.814576-1-pbonzini@redhat.com>
 <20250227164538.814576-3-pbonzini@redhat.com>
 <CAFEAcA86CEbeGK6mDju5jyR7JQKB7SfnO4-JoAnyiL2kRNufkg@mail.gmail.com>
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
In-Reply-To: <CAFEAcA86CEbeGK6mDju5jyR7JQKB7SfnO4-JoAnyiL2kRNufkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

On 2/27/25 18:28, Peter Maydell wrote:
> On Thu, 27 Feb 2025 at 16:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   rust/hw/char/pl011/src/device.rs    |   7 +-
>>   rust/hw/char/pl011/src/lib.rs       | 509 +---------------------------
>>   rust/hw/char/pl011/src/registers.rs | 507 +++++++++++++++++++++++++++
>>   3 files changed, 513 insertions(+), 510 deletions(-)
>>   create mode 100644 rust/hw/char/pl011/src/registers.rs
> 
> Looking at this patch I'm sorely tempted to suggest significantly
> trimming down the commentary in these comments: it contains
> rather more text cut-n-pasted from the PL011 TRM than I'm
> entirely comfortable with, and much of it is detail that
> is irrelevant to QEMU.

Yeah, that was a point that was made on the call last week, too.  I kind 
of agree, but it wasn't a decision I really wanted to take or suggest.

Also, some of the stuff does not belong in the structs but could be 
added to lib.rs, too, with more fair-use justification than in 
registers.rs.  So perhaps delay removing it until more aspects of the 
FIFO are modeled correctly, so that one does not have to reinvent the 
wording from scratch.

Paolo


