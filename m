Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CB5D1D88D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 17:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0kup-0002wQ-Ju; Tue, 15 Oct 2024 13:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0kum-0002pY-47
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 13:00:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0kui-0001rC-6l
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 13:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729011632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iJ6QKfZnFpbSnHEc59jfsWbHKBjMntrybmwo2roC0wU=;
 b=ZHnx3vfPZveHziLHwvIQpTqQtqfQ1gyZmmNajb4/spJH/70v0okRkTPrNSHlGGbupBLd3M
 +4WciT23wQxFAi0MmdBAzf7nH9M6rhiSyW18N+Jnk12f6h8UsWj96wGc5yKMqblf0/KItg
 1UKLgsftL2wO4ewtFbyP4ES3cCQdkNA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-abkFGaM_Ntql_8blUsy8xA-1; Tue, 15 Oct 2024 13:00:30 -0400
X-MC-Unique: abkFGaM_Ntql_8blUsy8xA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d59ad50f3so1511020f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 10:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729011627; x=1729616427;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iJ6QKfZnFpbSnHEc59jfsWbHKBjMntrybmwo2roC0wU=;
 b=mkYomGPMZt9qd3du1ke7OYFkabkBjHDg59hHGVnH2VKWQgtpW5peVA/h2yMpIdYydE
 jo4Xpp2E7gVTetib3TdXVPb3BWQ9QJ+jjojRXbeNzfm7en5Fu4yLZqlC49gKTIQUjqyG
 z7x/gNNsumq6y6A57e6NWtDuk5VJBqP/tjUzDyma5+xaiWu2znsvaovvTBdvc1ofNT3f
 mmgdgrjirOxP0nKWs73uDSPgYMh58tv3PI31M1Ku3iEIv9RwzPt1NVOxOg/RaoNULgt9
 kQotwj4IN3rv3GXqQRvutCyqPk8sPIRuXAMizB0eXeO+N7F92mhDpUX7kc4zBa48LEb9
 PGjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkfKJVL261tQgyQzl/xE1CpiFDRMEF6y1cUDa2CJdfZ7FP1o3dtS+irZYm7udLeN6yPOb3VFDjrm6q@nongnu.org
X-Gm-Message-State: AOJu0YzQgab49m1GI/7uMB4cv4CVwftWEPjM3qH4gao1XFSg1gATz3gp
 ichPfCaY7I21Wbj8vf8K1mPuCX9KQSFE/BYLm6iv2hbYNvJj83Dd9SXfGHOtoDriqAtlQEWfVtU
 NSmNJCM9NOon8+AdqT7SlHXBqrav/P0y48VwcbZ4qBK/tMgpaGVC7oLDXCVUkL+s=
X-Received: by 2002:a5d:644f:0:b0:37d:5141:ee91 with SMTP id
 ffacd0b85a97d-37d86bba188mr800896f8f.18.1729011627511; 
 Tue, 15 Oct 2024 10:00:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUD+TCAqzehrDCI/ipbZJjNVBFUoKWaGpnXMyA7wt8RnoYxxHzJz4N00tj2yVs9jmOy8i1lA==
X-Received: by 2002:a5d:644f:0:b0:37d:5141:ee91 with SMTP id
 ffacd0b85a97d-37d86bba188mr800856f8f.18.1729011627017; 
 Tue, 15 Oct 2024 10:00:27 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.144.54])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37d7fc11aefsm2017529f8f.93.2024.10.15.10.00.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Oct 2024 10:00:26 -0700 (PDT)
Message-ID: <78485b02-8f43-43ba-8220-67c34ee2d866@redhat.com>
Date: Tue, 15 Oct 2024 19:00:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: patchew no longer pushing patches to git branches
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>
References: <CAFEAcA9CthdJz+QM=_q2NxPbdCyyf+YBGE+qDVYs7VbqWT+aqw@mail.gmail.com>
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
In-Reply-To: <CAFEAcA9CthdJz+QM=_q2NxPbdCyyf+YBGE+qDVYs7VbqWT+aqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
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

On 10/15/24 17:48, Peter Maydell wrote:
> It looks like since a few months back patchew stopped pushing patches
> to git branches: eg
> 
> https://patchew.org/QEMU/20240526204551.553282-1-richard.henderson@linaro.org/
> from four months ago had a git branch created for it, but more
> recent patches in patchew's UI don't seem to have that.
> 
> Did this get accidentally lost when patchew moved server, or
> was it deliberately disabled?

It stopped working but not when the server was moved.  I haven't had 
time to look at what's happening.

Paolo


