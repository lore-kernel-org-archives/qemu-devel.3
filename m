Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596D6C8303F
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 07:37:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urAhD-0005NF-F7; Wed, 27 Aug 2025 03:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urAh2-0005LI-Hc
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:35:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urAgy-0007K8-Gc
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756280117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4N4b34oFspQ+PKrZHcJjsYddOlFF/nRmzx7u9zfgifE=;
 b=Aa+O9pScGM+Xa5nzEa9wuugOfMixivJsgiZcglx5RGx+Hbycp66KRJdhQabfXdl4Q8zK05
 EKCmwk5jLhE5GN1la0E09y8gc+ozeH3Nobutuuq2pqShnx0d6qeSOqrppG9549zIjquGPg
 sw7V+OEGWmK+rNVvbEvJTKc81uJ7+/k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-Gtko79QCMqC2vLNMnf20Ow-1; Wed, 27 Aug 2025 03:35:15 -0400
X-MC-Unique: Gtko79QCMqC2vLNMnf20Ow-1
X-Mimecast-MFC-AGG-ID: Gtko79QCMqC2vLNMnf20Ow_1756280114
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3cd34034c02so80143f8f.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 00:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756280114; x=1756884914;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4N4b34oFspQ+PKrZHcJjsYddOlFF/nRmzx7u9zfgifE=;
 b=SBTpIyIrV69bvWDYGGYJJ8SgP6GaglsxHz6yjJBDxh8x0z8oO23CyHNrIDfK3Y5V/l
 U5P1RP1to0sSvJkvV76VPTW5/YWSn1kKon5gezTpezqixzYXxIRS7fIfO71wN7j90rHk
 8fAqxSfDStS/qJR2COJG5+DzpjicYKxN5kG9u4kLO3+4h43NwZWKywK8eVek6nZP8vnh
 FxxbthnDF6sYKXcrcIpGdyMjgNVqHUz4CQthFFNejIL8t/Ljlxr53q0ZfhO1Rv27Imj/
 uvYYhp/Wvk/2Z9K+OjMJ5U2UalhQSJh6vLB3MbyCCGYtP2lIs5Va52uP7IaUf2sXdZiK
 PsYA==
X-Gm-Message-State: AOJu0Yw3rkID38+5n2uKScaX4yoLON4/D2Ebr6vxB7nIzUDtJ+lPOO/K
 3WvPV+94olD3cpchHIy2Bru+twCGzJOcG3towODW3KGDlt9oHvY7rZU6u6/HkLYF1dQdXi33hyl
 m7f6oMGvqGFjmzHcOxqxAycJHa51Dk7wCIA19nxDGoP/wkr+62zpHIXmM
X-Gm-Gg: ASbGncvLBWymR1IkmmYdsuI69trFovrJVceiFSlhfwketCWTnu+f31YujKKMyY8R5cq
 mVDuWSFySbsyjdohV9yP3vrASsMUH/5+3WLLsHXG8X/lqQczD9fPhDATMBAZiS8qkeXKKAjZw70
 YWXAZpcdbceUS+rPIwX47uzw96pjKFAzzOjluv2jSXKfNxCKyJsT98S7HYGgbw2FIbTqzb/skL8
 Q42Dqf9G8tmcvJwwUKFjOqiX2r0QhyP2dj4L9eAXnfDYT5pKi2ateSBRnF8OQhdceksAuL59q1d
 FsmIyFU0Uk65OprTNvB20tZsih0UHjNA96Hn/+QyKx/oTo7un9U+Ilj3ZtkV04Dy27tc/f5yQx/
 A+f7G78RLkN0zvERnjk7jUwkUuwUPjVRLncZtCCyaNRcAEQKw8IwDtyzGuzP59OMjULAMaAOFQA
 I=
X-Received: by 2002:a05:6000:25c2:b0:3c9:c344:1652 with SMTP id
 ffacd0b85a97d-3cbb15ca08amr3101045f8f.6.1756280113908; 
 Wed, 27 Aug 2025 00:35:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnnOBtzQuaPMm3PN0NQ+vZRJTWKlcAc3y5uK54/ifu0qhSfzl70pOpam7wVVffnPzZcMmLSw==
X-Received: by 2002:a05:6000:25c2:b0:3c9:c344:1652 with SMTP id
 ffacd0b85a97d-3cbb15ca08amr3101019f8f.6.1756280113480; 
 Wed, 27 Aug 2025 00:35:13 -0700 (PDT)
Received: from [10.163.96.123] (93-40-78-231.ip37.fastwebnet.it.
 [93.40.78.231]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3c70b634943sm19228601f8f.0.2025.08.27.00.35.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 00:35:12 -0700 (PDT)
Message-ID: <8a5741dc-7ce3-487d-8991-3e16a2327948@redhat.com>
Date: Wed, 27 Aug 2025 09:35:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 07/18] rust: move Cell vmstate impl
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-rust@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
 <20250826140449.4190022-8-marcandre.lureau@redhat.com>
 <456e56b3-00d5-48af-b757-79037ab8185a@redhat.com>
 <CAMxuvayw7zLYB0OY3=rR5QeEUj_p_d443zJkcExDDb43ha+8XA@mail.gmail.com>
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
In-Reply-To: <CAMxuvayw7zLYB0OY3=rR5QeEUj_p_d443zJkcExDDb43ha+8XA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/26/25 21:06, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Aug 26, 2025 at 10:28 PM Paolo Bonzini <pbonzini@redhat.com 
> <mailto:pbonzini@redhat.com>> wrote:
> 
>     On 8/26/25 16:04, marcandre.lureau@redhat.com
>     <mailto:marcandre.lureau@redhat.com> wrote:
>      > From: Marc-André Lureau <marcandre.lureau@redhat.com
>     <mailto:marcandre.lureau@redhat.com>>
>      >
>      > This will allow to split vmstate to a standalone crate next.
> 
>     Can you explain why this is needed?  Could "migration" depend on "bql"
>     (or even, "bql" could stay in util), and keep the implementation of
>     VMState for cells, just like you do for Opaque?
> 
> 
> vmstate doesn't require bql. Why should we enforce it at rust level?

In some sense it does: pre_load/post_load/pre_save/post_save run inside 
the BQL.  It doesn't require it at the language level, but it does at 
the conceptual level.

Anyhow the code is fine, I just wanted to understand if there was 
something else.

> If we merge bql in util, then sure we can make vmstate keep the VMState 
> impl for BqlCells. But why should we do that? To save one crate? I think 
> it will more future proof if we have a lower-level util crate without 
> bql, and higher-level crates that rely on it. Perhaps "bql" should be 
> renamed though (qemu-loop/iothread or something?)

I'm okay with keeping bql separate, no problem. event_loop is also okay 
as the name.

Paolo


