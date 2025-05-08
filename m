Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE22C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 17:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD4qj-0007pP-Md; Thu, 08 May 2025 13:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uD4qh-0007iz-HO
 for qemu-devel@nongnu.org; Thu, 08 May 2025 13:15:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uD4qf-000612-Pz
 for qemu-devel@nongnu.org; Thu, 08 May 2025 13:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746724552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5g3eQ5CalkEpL3DYznEbgbOF/SkotHgEgN+NmyFqI0A=;
 b=SrZcvRXNMCkXOiaavRxWmGfutqoLSir8ZZFyfzYMBdMuTceKv/xOIhwXWULCJpUOFzPpaL
 EVw2nfvinZZvju3NCvd924t421exf5R/VL8bRac52UyyCDEpBYdh+UWbrRzJH92feA4CGH
 7twvwk+0xczE8sVeOdD0dIyf39GQ8+k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-6HL4ukAVMhS5SXq-wGUU0A-1; Thu, 08 May 2025 13:15:49 -0400
X-MC-Unique: 6HL4ukAVMhS5SXq-wGUU0A-1
X-Mimecast-MFC-AGG-ID: 6HL4ukAVMhS5SXq-wGUU0A_1746724548
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac6ebab17d8so129350066b.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 10:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746724548; x=1747329348;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5g3eQ5CalkEpL3DYznEbgbOF/SkotHgEgN+NmyFqI0A=;
 b=B/QeX8vSHnIqwpnAqAvbSa6xUzzByVBmtgCvQGXbDH2Yx8umG1DTrjFL8nO1rzpF8a
 W4759xY45Yt4xr7ff3WYXh7sqRcfgZPVHFnwWCWEdK2iOY3px4XXyAnvJuN6E2InZqBe
 lxhfkkpry691tm8iKor+853XFrN+YO3SjXFcjX2ufrOigmi+l8oa3joRDZXqCLB3LkqK
 6A3wbfdRHN3HlleCGCka3IQjWM4do3DuQJ8H0wQGEpZVx6TH8QWeHQcwA9R3n3W2sAFA
 UOH2kfLUrYRhu6BJLe4XDCbhNjExfxY/zxRAqfJFYZXiiopPSS3PxLMM81gWKCVc2sVq
 2+5w==
X-Gm-Message-State: AOJu0YxiKak5leRENcaDmtNAXBPKaDRFq3wg/7gJXBuyKxIhWHVrJYvM
 f1WjwZeM7xpY7bcDQLuuNh1JHwi52uy/SPLrOS9vLSNPRElW6+phjfVsIkkp6Ma6lV9+IUcS/N9
 G8ihCwzYIXqB0bvQGki8AsC00jI2AEWLBzkpj16Qx2v4IGIsWGClT
X-Gm-Gg: ASbGncuX20xTPK6TU4fBMyDmvYf1rqbM45Q2SaDhDluvxOjejnR9EWYwd9fZe5j1gMJ
 nRFNHqCMkGmOi6kvR+vZnZ2TPjjMvvgsemSFKxNS+dThp4ySDWrr8Hd+u/SnIQG/8SYFFo1tuHH
 Eq/yUfH7sK1TPSwEzhES8mcNcRtG+yT4nJKlZfBkFU2lwoeEFbHFxFM6QBqi16UgJkiOtqtkjDR
 DJfKspSB4wvC782sq+tHcnBkdmh+jiBljCqsaPVz37D833VTo+FwZEBsHgdWdzKuD42jJPFkxyv
 fzAYHoqjnbYK
X-Received: by 2002:a17:907:3d88:b0:ad1:7792:93b0 with SMTP id
 a640c23a62f3a-ad2190206eamr50507366b.35.1746724547653; 
 Thu, 08 May 2025 10:15:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQpc2JC8NBf0JNFzH+9NBaloHN3TkpRxtaRvM7ZlW6qqpdqdShgL47qApX5e2K1mqk3QSXOg==
X-Received: by 2002:a17:907:3d88:b0:ad1:7792:93b0 with SMTP id
 a640c23a62f3a-ad2190206eamr50503566b.35.1746724547147; 
 Thu, 08 May 2025 10:15:47 -0700 (PDT)
Received: from [192.168.1.84] ([93.56.161.39])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ad218ece730sm16918666b.0.2025.05.08.10.15.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 10:15:46 -0700 (PDT)
Message-ID: <80b7d468-5ba9-46b7-8e50-b995655eb4b0@redhat.com>
Date: Thu, 8 May 2025 19:15:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/30] Rust, wasm changes for 2025-05-06
To: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250506152927.222671-1-pbonzini@redhat.com>
 <CAJSP0QX0wL1qJzfMoH6Di+QY3K9ML3HTLeY2gXZHNNJm_jDTTQ@mail.gmail.com>
 <70e9c1a7-b586-41f3-a500-347483f6c1d6@redhat.com>
 <1ca26b2d-91e9-408a-885e-87b8ef1ab944@redhat.com>
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
In-Reply-To: <1ca26b2d-91e9-408a-885e-87b8ef1ab944@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
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

On 5/8/25 19:05, Thomas Huth wrote:
> On 08/05/2025 18.08, Paolo Bonzini wrote:
>> On 5/8/25 16:26, Stefan Hajnoczi wrote:
>>> On Tue, May 6, 2025 at 11:30 AM Paolo Bonzini <pbonzini@redhat.com> 
>>> wrote:
>>>>
>>>> The following changes since commit 
>>>> a9e0c9c0f14e19d23443ac24c8080b4708d2eab8:
>>>>
>>>>    Merge tag 'pull-9p-20250505' of https://github.com/cschoenebeck/ 
>>>> qemu into staging (2025-05-05 11:26:59 -0400)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
>>>>
>>>> for you to fetch changes up to 
>>>> e6b9b79c3076777b791f72ebdbc9d37ad8005fe9:
>>>>
>>>>    gitlab: Enable CI for wasm build (2025-05-06 16:02:04 +0200)
>>>>
>>>> ----------------------------------------------------------------
>>>> * ci: enable RISC-V cross jobs
>>>> * rust: bump minimum supported version to 1.77
>>>> * rust: enable uninlined_format_args lint
>>>> * initial Emscripten support
>>>> * small fixes
>>>
>>> I'm not sure why, but the following CI failure seems to be caused by
>>> this pull request:
>>> https://gitlab.com/qemu-project/qemu/-/jobs/9974291215#L4684
>>>
>>> Please take a look, thanks!
>>
>> It is a transient failure; it reproduces 30% of the time with
>>
>>     meson test --repeat 100 func-hppa-hppa_seabios
> 
> Please not that you should use -j1 when using --repeat ... otherwise the 
> same test will run in parallel multiple times and the instances might 
> destroy the output files of other tests while running.

Yes, I noticed that later but it also fails with

for i in $(seq 1 100); do
   meson test --no-rebuild func-hppa-hppa_seabios
done

>> even without the pull request (commit 
>> a9e0c9c0f14e19d23443ac24c8080b4708d2eab8).
>>
>> Before finding this I had already sent the first half (which should be 
>> safe since it's all Rust code that isn't compiled on that runner---and 
>> for hppa targets in general), but if you still have the merge commit 
>> perhaps you can push it?
> 
> Looking at the log and tests/functional/test_hppa_seabios.py, it seems 
> like this test just fires up the hppa BIOS, checks for some strings and 
> that's it. However, it seems like qemu-system-hppa quits completely if 
> the BIOS cannot boot from any device - so it's likely a race: QEMU quits 
> too fast, while the test still tries to talk to it to shut down QEMU 
> gracefully?
> 
> If I'm right this could likely be fixed by simply adding "-no-shutdown" 
> to the QEMU options here...?
Good idea!

Paolo


