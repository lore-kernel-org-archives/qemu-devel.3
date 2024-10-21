Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD7DD15DA8
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 14:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2tiG-0002TP-5M; Mon, 21 Oct 2024 10:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2tiE-0002T9-32
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 10:48:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2tiC-0001BJ-A7
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 10:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729522125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=J7qlszkR0WjMJVJEJNATub/RSNL27MnnNWGOu3+BzKM=;
 b=GvoNT9WoQqcmG1D5aQlNVMlK5HhJh5JoO8QzHLBHEeeJ72HKbghxoZu2IYtWmISua9cSrw
 jv4rC1caWjf1eigy69DILR9ikUn9RerGhkO+sfG8QYv+SAQGEnKcKmWCJuETiclwXnN7tU
 +hVj0BsZzVelubMCD0oy+T+phYwPb/E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-GyPaovdFP4-86VcxArJfJg-1; Mon, 21 Oct 2024 10:48:43 -0400
X-MC-Unique: GyPaovdFP4-86VcxArJfJg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4316ac69e6dso16214755e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 07:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729522121; x=1730126921;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J7qlszkR0WjMJVJEJNATub/RSNL27MnnNWGOu3+BzKM=;
 b=Ohe6dbYjrjedJUYCaJj8zWtFsZv9YHC8f94hv75aTvHNv3apmpAaTPUoT3u0OZLMDh
 Q1Nfiv1T3TNVrNz2zUj7M+P/czuNFl7vTAqPFs3g/hHm4FARquJ7OuZc9LzOxutcvYTz
 Vspz3V8IhWnT3QoxsX3/pYGyX0ITqoM+DcVWLDguvjnvcmj/qi8eKeNo5+L8s293VAtT
 jX9b/7h4p4RS4YNNAK4E8nCxjUiX0S6TAlcBrdSP33BLlXLPfNied6AOrAbfPb+styKM
 uZ2R/DUl9h8PV/HQ2lCm2JHccKraLUNOqirnj6PjAMxlP6VsQq/UrtbWXgxeF02I8k3f
 7NWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHR9xII0/fjKz+0N+kAZ+CI8vSPjAH6swpH9gPAn+dmO4GLgeeowVwgI7UP3JIlzGqmool8u4VxnTm@nongnu.org
X-Gm-Message-State: AOJu0Yw8TiHayYuiaXVcM07Z/CgrVdPnkDWE6c4I1QY9W5R9StD46QXY
 16I6R3TmuXawcjA4hdTeuICNfc73WvRYseKmJY2bfaRt6eqMtVmGu51DYRy8Cg3YGY7QjQh6f9D
 x0+8t4TNorrUOgZslXmz2/L+tzvweN8W5tRUy3NgSfwbaGzxy097o
X-Received: by 2002:a05:600c:3b08:b0:42c:b4f2:7c30 with SMTP id
 5b1f17b1804b1-43161687de8mr94733555e9.23.1729522121126; 
 Mon, 21 Oct 2024 07:48:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0b1a7+reuLyU7tj0k1Hlzl+urKz7/YJJCDpbknxJ0alYVMS2fCrdpm6HpozY8BvoMghsBYA==
X-Received: by 2002:a05:600c:3b08:b0:42c:b4f2:7c30 with SMTP id
 5b1f17b1804b1-43161687de8mr94733385e9.23.1729522120771; 
 Mon, 21 Oct 2024 07:48:40 -0700 (PDT)
Received: from [192.168.10.47] ([151.95.144.54])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37ee0ba7480sm4479939f8f.113.2024.10.21.07.48.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 07:48:40 -0700 (PDT)
Message-ID: <e8b2187b-78a9-4181-b72d-dbec3008633f@redhat.com>
Date: Mon, 21 Oct 2024 16:48:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/16] rust: allow older versions of rustc and bindgen
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <ZxJjLpDe0-A_6PEL@redhat.com>
 <2f34640b-77ad-4267-975e-7898b6f8e38d@redhat.com>
 <CAFEAcA8HBNkbWOJ26jfopah1CDAm2qfJiudVJ1n2aeKayDFZ6w@mail.gmail.com>
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
In-Reply-To: <CAFEAcA8HBNkbWOJ26jfopah1CDAm2qfJiudVJ1n2aeKayDFZ6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/21/24 16:15, Peter Maydell wrote:
>> Very simple - "cargo install bindgen-cli", as already seen in the
>> fedora-rust-nightly container's Dockerfile (note: building QEMU does
>> _not_ need cargo).  In fact we could in fact do it via libvirt-ci, and
>> it's quite possible that MacOS or some BSDs will need it.
> 
> Why doesn't 'rustup update' do this automatically? My Ubuntu 22.04
> system I'm using 'rustup' to provide the rust toolchain,
> and 'rustup update' updates rustc, cargo, clippy, etc, so
> why isn't it also providing and updating bindgen?
> ('bindgen' for me is ~/.cargo/bin/bindgen, so not the system one.)
> My expectation here was that "rustup update" would keep
> the whole toolchain up-to-date...

I'd agree with you, but bindgen is not part of the toolchain. :/  In the 
Cargo way of doing things, bindgen is specified in build-dependencies 
and it's rebuilt together with the rest of the library that uses it.

This is as wasteful as it sounds; I guess it makes it easier for bindgen 
authors to "move fast and break things"?  Even in the 3-years span of 
bindgen versions supported by QEMU we have the case where 
--size_t-is-usize is needed on older versions and was removed only a 
handful of versions after it became the default.

Hopefully, this becomes less problematic as Linux forces the tools to 
mature (my hope is that, in general, Linux will force the Rust team to 
give more consideration to non-Cargo mixed-language projects).

Paolo


