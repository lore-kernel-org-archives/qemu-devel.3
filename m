Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17060D2F7EA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 12:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRUak-0006fV-50; Fri, 05 Dec 2025 07:07:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vRUae-0006aN-ES
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 07:07:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vRUac-0006Cj-9S
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 07:07:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764936427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QiSSodrK156D8ElT+QlnCe1HXfdYFutHWcKpRoV/rI8=;
 b=Q8NS9Td/OxZtKMYfjxBParsAGJRhvu1NVSohSS3SSICcqPuFLGltblXviqwjoZpgfWG/7n
 oS+7rPej8T9reawXBv0yGicNHvjqHxFKaZ6uH5EXCb7q177qYxRKxGLE5lvXfOz20LWhNK
 KUXU/Yh9S6vz3eFgoY4v8uds5WNazZA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299--it05Ct7M56BQZnHZXN17w-1; Fri, 05 Dec 2025 07:07:06 -0500
X-MC-Unique: -it05Ct7M56BQZnHZXN17w-1
X-Mimecast-MFC-AGG-ID: -it05Ct7M56BQZnHZXN17w_1764936425
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42b2b9c7ab6so997034f8f.2
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 04:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764936425; x=1765541225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=QiSSodrK156D8ElT+QlnCe1HXfdYFutHWcKpRoV/rI8=;
 b=SQC8dybMidZID6DAtjz4b5wjKW+G4hRij6Rj/3wU8gQSsR4ty4MpJEs5UtYC23CN3W
 YgE3tSm+rzrFeEMBbvZTcdS6a7DxYneEmUrpVBADegLxEUWqIGYCYEZcLd1LlYOHDyN5
 EuN2mOowa/6TGJLmqMgPP4jUWcPDRp5sM0pE9LrhPC2D2II/gjIKMLIg86KNAioGLB4b
 dKtDWSA8O8RHkaJNa4m3G7q3G17mc7v3WT8ReT/hREhZjgNolskBWW1FFJoO9QN59KB8
 xWh8q3oXV/gYnJYiG5FHutadj9KUiKKUiBMjvW/HZ4nZMUB28et937ZXzCs03ICvZyDp
 kZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764936425; x=1765541225;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QiSSodrK156D8ElT+QlnCe1HXfdYFutHWcKpRoV/rI8=;
 b=dLANN/X0s0a77GzYKn5druHs0DaongubWL1eJsvKZbwBXsOrP9PtXSRJb6DkrW8XWL
 99/69XJ9OIWpBxWRD8RL2V5QjMKcpb0BwN25jpBs4t2ISsciG+o+qNRiwQt9vgkQrH/w
 THnZeoJnsEiieGylToBlNQhJKTnhZArLUeQuXKcN9MkVbN3aOtDBZxSfElGJsmpKGsaY
 V9pZI6Gf9QTgvt/IdSQBrx1UYf1U7CkPxAxPoIBc2KEElgneEK8q7diNZxAKFRn1yJ/w
 x0rzWlKaGRXYWFVyCoVPHzGDW0j3EkF0nlA264rqwZ7cPU8JuKuz6M1x00CGzeAXCJkJ
 IrvA==
X-Gm-Message-State: AOJu0YwV4MoN88NMaVlZWPJ9R5nJLcZydD/iTd0Zxf2SUxHUjOG8M0Jp
 Yl7WrG9T48XPejecuuK5AbxP+xofiefWycEoQqDGBNmxggLQ/sBr85GKsKd2wpwSOCRUzWkFeXO
 Cn3UGLnwoC6p8J/lVZpv2g2Eh9OZxpAkXgJ+WTkbHo8EZjmnRxvl3aC99
X-Gm-Gg: ASbGncthmWH2mZf9gNgOfkloIbxMqJkkPdLt3E7lMPY657B2jyO9vPlXh2tSjZar8L4
 BgbaAze0QUw9+0TKLm8Kr+tkmuHjeCt7FRDB0v4rQGZ9n/KWGOmwyvBrMaX+e0/tn1YEUeN6fOi
 RJw3QguEL4XwgfYkMzxLuoZUlHBgk9QXdkICMNvRTQQSsRsvgDxyak625FktYYV6TZ6CNMsrQ/e
 67mnrMNn8eYMRu3SkH0zwoB4zCHAUZFX4hAOIUT7Jsduf0vmuf/1+gduEQdAxXiy+rjVK8DvJvc
 cv9B/pra792XlYGYFCakJUUW7WhKn7aXHYd2dNQl9/XYenS1xOqojRnRlnlIUTWW2jTl7dpnBqB
 HyXhZ7o6avg4rxR0IAefuuOXWMnhItWqXFmg8QhiaqYcknf3WXsq9BcaxT7D1JonHC39QuUxNPM
 vIcmdlLhvr280P4k4=
X-Received: by 2002:a05:6000:18a3:b0:42b:3272:c4a7 with SMTP id
 ffacd0b85a97d-42f731a2e9amr10341131f8f.29.1764936424832; 
 Fri, 05 Dec 2025 04:07:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZmi2fvSL69gQzd78JkZaXjxZbXG0wqMt02wFm8bhvC2iXYuQnzuOUJKPyeS+4GxVNJJCfMw==
X-Received: by 2002:a05:6000:18a3:b0:42b:3272:c4a7 with SMTP id
 ffacd0b85a97d-42f731a2e9amr10341091f8f.29.1764936424345; 
 Fri, 05 Dec 2025 04:07:04 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-42f7d331df0sm8833874f8f.36.2025.12.05.04.07.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Dec 2025 04:07:03 -0800 (PST)
Message-ID: <25df019b-62ad-4f38-bf79-000ba1a7d750@redhat.com>
Date: Fri, 5 Dec 2025 13:07:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/19] rust: do not add qemuutil to Rust crates
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, qemu-rust@nongnu.org
References: <20251010151006.791038-1-pbonzini@redhat.com>
 <20251010151006.791038-4-pbonzini@redhat.com> <87ldjhz5xe.fsf@pond.sub.org>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
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
In-Reply-To: <87ldjhz5xe.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/5/25 09:30, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> This fails due to https://github.com/mesonbuild/meson/pull/15076.
>> The config-host.h file from the qemuutil dependency ends up on the
>> rustc command line for targets that do not use structured sources.
>>
>> It will be reverted once Meson 1.9.2 is released, or replaced with
>> an update of the minimum supported version of Meson if 1.9.2 is
>> released sooner.
> 
> I tend to put reminder comments next to such temporary workarounds, so I
> don't forget to revert them.

It turns out it wasn't temporary 
(https://lore.kernel.org/qemu-devel/20251127132036.84384-9-pbonzini@redhat.com). 
  I'll post a separate update-meson-and-clean-up-rust/ series once Meson 
1.10 is out (which is soon, and I've already tested the rc with QEMU).

Paolo

>> Reported-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   rust/chardev/meson.build | 2 +-
>>   rust/util/meson.build    | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/rust/chardev/meson.build b/rust/chardev/meson.build
>> index d365d8dd0f4..36ada7c4546 100644
>> --- a/rust/chardev/meson.build
>> +++ b/rust/chardev/meson.build
>> @@ -39,4 +39,4 @@ _chardev_rs = static_library(
>>     dependencies: [glib_sys_rs, common_rs, qemu_macros],
>>   )
>>   
>> -chardev_rs = declare_dependency(link_with: [_chardev_rs], dependencies: [chardev, qemuutil])
>> +chardev_rs = declare_dependency(link_with: [_chardev_rs], dependencies: [chardev])
>> diff --git a/rust/util/meson.build b/rust/util/meson.build
>> index b0b75e93ff6..8ad344dccbd 100644
>> --- a/rust/util/meson.build
>> +++ b/rust/util/meson.build
>> @@ -43,7 +43,7 @@ _util_rs = static_library(
>>     dependencies: [anyhow_rs, libc_rs, foreign_rs, glib_sys_rs, common_rs, qom, qemuutil],
>>   )
>>   
>> -util_rs = declare_dependency(link_with: [_util_rs], dependencies: [qemuutil, qom])
>> +util_rs = declare_dependency(link_with: [_util_rs])
>>   
>>   rust.test('rust-util-tests', _util_rs,
>>             dependencies: [qemuutil, qom],
> 
> 
> 


