Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11EFCFD376
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 07:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQL1p-0000iH-4V; Tue, 02 Dec 2025 02:42:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vQL1j-0000h5-CQ
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 02:42:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vQL1h-0007SW-CY
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 02:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764661338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZAauWGgy4ApDyt1Si+YltjTa8dpfVYM/y+FPEZr/QQY=;
 b=FTZh60C+2qKS1WLku2HJm91O/8rCnqBxbtvXAYC3tmu6B7/c+HEo9ieJTrldpku1aw7Ro8
 ONCMuBlu0J37Z4S+KJc6IKvVpkoGBPNSVSCWU+CgdO8W1SiGYs6OpqDZFD6ItOcXbEjMBm
 i28mX4KZ4wdkjksXz1WgKO1b+BNsTcw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-V1N5ABQIM7macP-5lXIUOw-1; Tue, 02 Dec 2025 02:42:16 -0500
X-MC-Unique: V1N5ABQIM7macP-5lXIUOw-1
X-Mimecast-MFC-AGG-ID: V1N5ABQIM7macP-5lXIUOw_1764661335
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b739f418149so541801266b.1
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 23:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764661335; x=1765266135; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ZAauWGgy4ApDyt1Si+YltjTa8dpfVYM/y+FPEZr/QQY=;
 b=Wm4LqNRittabHT1xotWmr3EZdxsbrMjfc9NmoLC1p9hhP2c9EaEQrQOKpppz76EVNn
 DvWBdzPrFwxZf6kceZyNJa3AAPtxgHhtk+6ZuI0HbTfLJjyavByIUFx0eXe8eC2Gtcj7
 iKkRkQTLNouW6JEppJi+2O5x/qdociFhDFFC62JumNg6rfps7zLrldp7O3v8C3gkIjAG
 yTHF/v0vpqOGlQthUhZygbwEIoaqIAKVw7LgYjMrElGsCdOjvkNVx6HylzK1UCvfFhB0
 7sXZ2N3QWHIJxMaqKALXb40I5w+kSzUDs3CNg6UXfBZ1Cvhs31usHEtbPud2QexfjH0s
 NPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764661335; x=1765266135;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZAauWGgy4ApDyt1Si+YltjTa8dpfVYM/y+FPEZr/QQY=;
 b=lUdhcq0YjyX5lXBUr+X/rOlmnnuHb99Xi/qoNuFlKIV38mVnpj7mp2HoPNbA1eVmo7
 OyjDUA1patGU5s23j3w3TXMrGOblJvTa1p0zwyPpe5wm5PF8FRrCwTQUpMPTz1MbfMMM
 mSs5ryvOhFwRe+4LT1DF+N9rTvu02nw/NZ80rJWfWP1kWm0m8ca0SC9XZEEaySxgSIIm
 JKW2mmNg4FFXbHLmDVzYmFK2bOezqx/64T63FkhP+abdt2nNIq4U8dMkK1T8whC7s5tP
 xFQnTXfHadGRyN3m8LA+ijSmnAWNBxZNX3ypVQoiECdt38xs2AICvtj7zvxRGV3gQche
 vOWQ==
X-Gm-Message-State: AOJu0YyYYA8nFzl8XOLxFSrihPBT7hLZbtnWmcLK8W31Qb1Omh7px1EK
 L8sgEt9VSNn0kimWeampV/WqfLcut710YI05Qwk6YFTvw8ZdwHIb561Y1dSuOPoIxc1bOBa2S4u
 zUIe/jyyibESAzA3juP/02y7zBXpk9PTY46sVH5Rpl5lv8JKNvgcCS/JT
X-Gm-Gg: ASbGncsjOqaZnTQKCYHjrVHOw2Dwuvi6oeCSycTYiR2h7n3RfK+aGy/gkJaWq9LnqWZ
 mp1P5zarvNZvLCN1R0Kx6fPsovgvQljru+HK5i4ZzeWf5TwAvOQdzBIwURCnoe9xxJgaUDvIVyV
 cjvYAIqLPxTI/NkZQNli5R7vj6f0kx2CrH3OqTAP7Vpn8G9Cz4XuAblttC2oOtZ0A6yv+sCPMBO
 P83jvyEKywf7AhsMfI1SiKpP2zzimiSqnmegmw8aW83ZHDZwoNGMQkDe01VurK6MYufIFLxRV8Z
 Rsy49JioUXKv5YVWV6CDljQv7/rphWMpDpqQ5THCSekQUiy0Mx9y9bl9tFLOmwIvOvynYo8mC9X
 FrR1oBIl26SpTDIGehJ3yFG8+wZ93AQqYVQESUW8twM3U1Qy7Gp719OgbvZ01SX1bQCHLawSwC8
 VFDioKIv1C8Mmr3+k=
X-Received: by 2002:a17:906:eec4:b0:b73:6f8c:612a with SMTP id
 a640c23a62f3a-b767150be15mr4605817066b.11.1764661335055; 
 Mon, 01 Dec 2025 23:42:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1QaCEH8Tlom7zcrbeCJFCVWKGN31f12RCwYYAKirBMODjqqafNDab7Yy40sE+JGSGOAYI8A==
X-Received: by 2002:a17:906:eec4:b0:b73:6f8c:612a with SMTP id
 a640c23a62f3a-b767150be15mr4605814566b.11.1764661334649; 
 Mon, 01 Dec 2025 23:42:14 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b76f59a6a67sm1427470966b.34.2025.12.01.23.42.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Dec 2025 23:42:14 -0800 (PST)
Message-ID: <93ab4c50-08d6-4692-82bd-1d01121f7362@redhat.com>
Date: Tue, 2 Dec 2025 08:42:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: split qemu/aio.h out of block/aio.h
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20251128101555.227630-1-pbonzini@redhat.com>
 <CAE8KmOwfKfTpE8YOwd6GV0vAetf+rfLW648ALvNWdC0ciL9k8w@mail.gmail.com>
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
In-Reply-To: <CAE8KmOwfKfTpE8YOwd6GV0vAetf+rfLW648ALvNWdC0ciL9k8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/28/25 14:14, Prasad Pandit wrote:
> Should  block/aio.h include qemu/aio.h?  User can include them both
> where needed.

block/aio.h is quite useless without functions like aio_co_wake(), so it 
includes qemu/aio.h.

Paolo

> Otherwise looks okay.
> Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
> 
> Thank you.
> ---
>    - Prasad
> 


