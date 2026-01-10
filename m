Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E927FD277D0
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Jan 2026 05:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veRZt-0005Bv-GD; Sat, 10 Jan 2026 00:31:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veRZq-0005Bi-Sh
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 00:31:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veRZo-0005zn-Ja
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 00:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768023109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dR1R9GbbOZ/SeWe4Yd2Q8wci3gHC3q6hKeAGQJQFG0c=;
 b=M7jKbIEoZiUGdTRYFwgURO6tQTnQ7h7r7rh/AIs6TzgFnGndjuMqeMWTjdbt1sN1TsxoO3
 /qHfeuHY7HNiy6MG0SvvM4PvESC/ARl4MwdDMLS+dA4+/gfjI+jn9HwC0Fq0lTkGMuLNac
 wWM5GLYb9vqu/VriEu7g51uraB53OJE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-cCMu9UAZP_mBlIJMvNd9Ig-1; Sat, 10 Jan 2026 00:31:48 -0500
X-MC-Unique: cCMu9UAZP_mBlIJMvNd9Ig-1
X-Mimecast-MFC-AGG-ID: cCMu9UAZP_mBlIJMvNd9Ig_1768023107
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43102ac1da8so3667516f8f.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 21:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768023107; x=1768627907; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=dR1R9GbbOZ/SeWe4Yd2Q8wci3gHC3q6hKeAGQJQFG0c=;
 b=HPxTBDV3j35prOE+ylivSvI9hQ0a00H7salS97Z/5VJmv1E3UmpgETo331RDtopMyh
 ygeKTbsMPGzwjjxxYYSzByOkKmwDuW+vJgRl6NkzAk25GmXQRc/+XL2s50Huum9d4MG5
 h+psxlM7ku/HrQW3fbPl0vMBasWJ9SMQo0k8OFis1DyjXsECojQ0+4JjGyoW5QAYIEAa
 k+fqDEg7LuMzZNgmujQvQ9Y1aZralsbapbtB/RdtjArduOf0ei9KBUqGviPAhVBWg5B+
 y4JV0+dJY+3ofHFi1w8LjtFPh3FAEigsnmz6M3/P5j9M15NeLqavJRLV250QHjI8ypEn
 y0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768023107; x=1768627907;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dR1R9GbbOZ/SeWe4Yd2Q8wci3gHC3q6hKeAGQJQFG0c=;
 b=j+txJFQmvjRIc+CvB6lcJHQGL/q10j25h1vF1zh584DOlGtAf+PFUGP1eap4oJBVyP
 RPVd3svOOdn8a5FuKLslyU5bQ+8gcgNtHkATOMCqy45uE+naYZRfwuIoXuV1/+sASKtL
 MLVs/Tvi1VGHNMVNKxbogqF6xRSgPQrILV7/rVQXIFcGJ9F6nh/j+rhJTrfC237DS8QD
 CAk5vjYUlyDlqMn6bvuTCyMoIjlyTWNcQuSrqp+CgA/nf2c7UkdTfc6i1U6m82wRK8qK
 rX0KfRGg5Y5kYbQSPMIt17pkINJyA/6O+wRJCD1GLWKma4uDkGgRVG/8jzCIUuyR72P0
 6sHQ==
X-Gm-Message-State: AOJu0Yx3HJO96j8Nh4FUm81d4zvCHCy+qYiGLPkeBKdI+9R+dCxzw3cV
 fBsGT2uNTGzmAuXSk+E7wtsbfN6+F7FHOGiLYdhIglYrV/sq9bEvz0sQcmUhS4yuRkSQVBq/lEb
 7eQo3gS/ZfnPUiAgvQrrWD7M9fVuLu/vFgrOYC+ZXlhVO3b9TE2FJ5W1S
X-Gm-Gg: AY/fxX72pMuFtKmN6hZ5mMHF9Q6z46JptvmMVR9fPWr00vz30kNpnl1IHoGk0IOwRsT
 cPrZfEP1bM6sL/RiB6sPpc/tGaLed3h2xYFOR0af1W1Y6ftd/tS8PKS9G9fkccXZXSYZCM2DNJA
 8K1vtwG5ZD+iuXaikOlzY5Nxv2REYGZEZIZb8j54+pkqISSLwnOBdOTKr5Gt9APPTgBZ8LoGTXB
 q/h3ZucwGTNuKYFvrBZsEqN82I7t7PN4EK4snmQPaE9DEnvqpZmrMPoLm1A6wYwVTtjPMesk3iS
 JoW2plVU6+A5VeyjjGyt4UgHBDSHdO3YhVFhleKRAMpNad6EgvFDtjD4fXPy5RCTqD/CLWDzpUa
 LRv8RogDHUOg5ictaBso1r+t//Aq717wwfKgkM0GaOiRbpmzzW4ecPgSK23HMbsBYx7sgQW/Fhv
 sibjmLUi7yJ5Vh1w==
X-Received: by 2002:a05:6000:2584:b0:432:5bf9:cf22 with SMTP id
 ffacd0b85a97d-432c3760f0amr13446603f8f.3.1768023106703; 
 Fri, 09 Jan 2026 21:31:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNZfATG1EYnjJJbTi4asf3jRUCE6holUguMeTQoMb/OeDnwCDu2g6Fz8EVNBtNz39OssOevQ==
X-Received: by 2002:a05:6000:2584:b0:432:5bf9:cf22 with SMTP id
 ffacd0b85a97d-432c3760f0amr13446592f8f.3.1768023106335; 
 Fri, 09 Jan 2026 21:31:46 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-432bd0860f5sm25933221f8f.0.2026.01.09.21.31.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 21:31:45 -0800 (PST)
Message-ID: <44a5b8b5-ec44-41bf-9cda-164a1280362a@redhat.com>
Date: Sat, 10 Jan 2026 06:31:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/22] util: Introduce ldm_p() and stm_p() load/store
 helpers
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
 <20260109165058.59144-3-philmd@linaro.org>
 <CABgObfYYx4-BcN7gbpNNiZi8nQhqYh-fgJ4j=6udogBnpz_7UQ@mail.gmail.com>
 <60994c46-d04f-461b-819b-31597a8405ab@linaro.org>
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
In-Reply-To: <60994c46-d04f-461b-819b-31597a8405ab@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/10/26 00:26, Richard Henderson wrote:
> On 1/10/26 04:23, Paolo Bonzini wrote:
>>
>>
>> Il ven 9 gen 2026, 17:51 Philippe Mathieu-Daudé <philmd@linaro.org 
>> <mailto:philmd@linaro.org>> ha scritto:
>>
>>     Introduce load/store helpers which take a MemOp argument.
>>
>>     Inspired-by: Paolo Bonzini <pbonzini@redhat.com 
>> <mailto:pbonzini@redhat.com>>
>>
>>
>> That's a new one. :)
>>
>> I think they should be inline and so should be address_space_{ld,st} 
>> m_internal (maybe even always_inline). The amount of optimization 
>> enabled by constant MemOp is huge.
> 
> When are we going to have constant MemOp?

Every time address_space_{ld,st}m_internal is called, it's done with 
constant MemOp.  For example:

uint16_t ADDRESS_SPACE_LD(uw)(ARG1_DECL, hwaddr addr,
                               MemTxAttrs attrs, MemTxResult *result)
{
     return ADDRESS_SPACE_LD_INTERNAL(m)(ARG1, MO_ENDIAN | MO_16,
                                         addr, attrs, result);
}

Paolo


