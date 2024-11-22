Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0CDE65D32
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 08:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEOuS-0006iY-RA; Fri, 22 Nov 2024 03:21:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tEOuQ-0006iA-Ct
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 03:20:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tEOuO-0008En-Ps
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 03:20:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732263655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SMiTLXqPrQJxKJ37ZL8bN8EGF9omAw7ifdKAnxt4DII=;
 b=iuOoFLpoU1wvg+LR9+17/vuOLhsg/y+Nln37Vtb/K/AG3DAU38InF2Pvav41g4GPdOmn75
 F7l75m0kLkYNjY1iw47d0VmxEPX7lKDqjcUW1rGci73JwrlUlCCQbi+Kcx8zEiq5oax/up
 5Ar9A/Q/wBR/T/ttDxu6FF9Z6wWRWB0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-aJQ_yQl_OpmzG7VRf874fA-1; Fri, 22 Nov 2024 03:20:53 -0500
X-MC-Unique: aJQ_yQl_OpmzG7VRf874fA-1
X-Mimecast-MFC-AGG-ID: aJQ_yQl_OpmzG7VRf874fA
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-431518e6d8fso13967345e9.0
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 00:20:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732263651; x=1732868451;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SMiTLXqPrQJxKJ37ZL8bN8EGF9omAw7ifdKAnxt4DII=;
 b=So0oDswns0MS/d1ibk9SOdJTforEGNkP0vT1OLVGdPs0oTov7x99iHYT+PUi4sHHQH
 WcfRquO0ppOSgHJYAapPooTub9mxpdIhYTmjB/s7LpxpbXQdXMng2cvrgHx7O8n202DJ
 ks+gSoE471KyTjf/qeM2ugPNGjuxF9zRMbWVgVo4WSxKHbPd9x0/jxLb0FN4/cbTze4G
 VZKuOoEumkQCKLAvSc0sfdStQUe9dWoPc4VOEoay1VmSiK4vQZHa/oj96GpZBJSIQIum
 MvJRXQ7NNmZqrnvIkRX0INoxp/EC0C+BzYJLOcJH6JtJrgJjZimTl+N9xXaW3jPDmPAy
 tTwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO90PRSF4pzJra5tOM0RJfwz66opCJ5lXuaFAh4HsGreQoNyxxDKPwIeJ0RsLBuVxFH91EEpWgSDcB@nongnu.org
X-Gm-Message-State: AOJu0YyQHCaoup8D2XSPyMs9ahiCNuPp0fw7ijS6O+U5nF3KrumJ5wjZ
 n8vy5qeynEQaqES7XIEJj9rcp7KaA68ybBRFL4RYDeYnwPn3Qq7AMbSqSTnAnU4e/iyZfSaPYM7
 WHGnoPvkzuPYUzkcCgWNykFvyWZ0M+vNKCbVy38UbPOO12fFXkgbzfJccTaEK
X-Gm-Gg: ASbGncvlaLA5l0MTv29K2n+T11zsy2s8lbBUfKgOymgule2yUNAd9uUpaa98ojxwUQ9
 lAuQ5+b/9/cY7NAi5g9y8jeFzZGElFzZdHLic1Zg7Nkw9w85FTfsSsytohK9Eq/iaWko0e1i3HF
 yjvhZkxR11MDXco68zp7kK07sbFxctYca0I9WnICs/uBYXl8kPGho5kWHb9/t68LNEeBaDSj6X3
 UymvB7d3iVulNCNfUfbe9yGBJsFTCXm6f2E3lfrp6HZIeLUoFNYaQ==
X-Received: by 2002:a05:600d:2:b0:431:5ba1:a513 with SMTP id
 5b1f17b1804b1-433ce4267b2mr17036335e9.10.1732263651378; 
 Fri, 22 Nov 2024 00:20:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGibK+LEosluRe8iM4Bypqi3T7EBT9N8zvJFM57G3Rxm3/x1Nku9asgh4aoJDzfdiYSHWKwNw==
X-Received: by 2002:a05:600d:2:b0:431:5ba1:a513 with SMTP id
 5b1f17b1804b1-433ce4267b2mr17036105e9.10.1732263651049; 
 Fri, 22 Nov 2024 00:20:51 -0800 (PST)
Received: from [192.168.10.3] ([151.49.204.250])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-433cde16a95sm19550855e9.18.2024.11.22.00.20.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 00:20:50 -0800 (PST)
Message-ID: <0facde38-6026-4c08-bcb5-4ba2ec562cf9@redhat.com>
Date: Fri, 22 Nov 2024 09:20:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pc-bios/optionrom: when/why do we build it?
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel <qemu-devel@nongnu.org>
References: <5c90aeb4-2773-4c1b-b727-0f2221860761@tls.msk.ru>
 <ec822e92-179a-44e3-80d4-48763544689f@tls.msk.ru>
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
In-Reply-To: <ec822e92-179a-44e3-80d4-48763544689f@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
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

On 11/22/24 08:05, Michael Tokarev wrote:
> Maybe a more general question would be:
> what is our main build entry point?  Is it `make` (or `make all`)
> still, or is it meson now?

s/meson/ninja/

But no, it's always make.  Using make ensures that:

1) you build stuff that is not emulators (option ROMs, TCG tests). 
Meson is only for stuff that runs on the host

2) you rerun configure if it changes.

> For this specific optionrom thing, I'd say we should add a separate
> rule to the top-level Makefile (or to meson.build) which is not
> run by default but can be run explicitly, like `make optionrom` -
> this will check if pc-bios/optionrom/config.mak is there and either
> run make in this subdir or complain saying no i386 compiler is found.

The optionroms are built by default to ensure that they do not bitrot. 
I think they're not copied (this is really old policy...) so that, if 
there is no need, the binary does not change at all across releases.

But yes, adding an explicit makefile target is useful.  It could also 
copy the build products over to the source directory.

Paolo


