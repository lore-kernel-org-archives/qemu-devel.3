Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8956FC02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 13:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfIzb-0008Pu-CT; Tue, 04 Feb 2025 08:29:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tfIzZ-0008Pk-3j
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 08:29:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tfIzX-0006Re-6J
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 08:29:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738675764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fxUZz4wnSgd/5QYgaFzXJj0301A1j7nTo2KIu2PFX9E=;
 b=aSxDJpgFJa0AeJoUHwJYmcgYxYTRHnUa3iocfv1EqGslGpXXchtQrLnFbmUb4c/0EuVnAp
 7vEOFK4lnMsyC/mcvmZwk7tkLqyYc1694EEv0bfWdp1LJtU/4ajt9W6EahTx1OEflNK3DS
 Bf2P/kjThEL0Os28moLxG6GQZDCkxH4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-G8y4DZtdNz-nx-LbK0o3XA-1; Tue, 04 Feb 2025 08:29:22 -0500
X-MC-Unique: G8y4DZtdNz-nx-LbK0o3XA-1
X-Mimecast-MFC-AGG-ID: G8y4DZtdNz-nx-LbK0o3XA
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38c5dcb33a5so3681348f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 05:29:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738675761; x=1739280561;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fxUZz4wnSgd/5QYgaFzXJj0301A1j7nTo2KIu2PFX9E=;
 b=q7VlugNHd0oZrCoatFkymmKbQPc/B8Tn4RNlDrx+WBI1sGV1MJ6gfYKM2upxDij1+t
 mOb5NHbBjV+mC+cEfC1cUPs5JqOW+Cf0aAQxE7dWtwLNPt3lFWrckBJO40ts/PbQirBd
 y+F0blBpoDmW1FvHBfeWl3cjForMyAxqNyPnwLfrP5Iw8gZmDhUCM+sC/3UCkwoDdy06
 tzw4F8F/DxUdCB0PxZDxpf7s0GzIqhoqSIQ2IZ8VXYGXqrk/qb1zwZ/QcmWeY2+GR2zK
 xbgx7cDfO3hiaJe/bcqCLrITrSHfjz8SC3ByPAEWJ6EMcJfzsqTfyZDlr2UXLcDFomzl
 eSUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnD1qBQEP5nDA69T3Z5QHWddhhSKA0onRBgWzvXeA5yJGSxUZbCAOMY0zjIqqkqREgLXt0bzZ7iiE3@nongnu.org
X-Gm-Message-State: AOJu0Yxc+xJninksdm0zTtLWIs3xKB51ljnha6+kMqK09djcC5fv/z6W
 vVU9tnkk2SlFbHMlvu+RlREZKzN9ADzbWZUFYa/FFfQBeHq/63jFdc/IsdyuJkwVXOikXBpGDCR
 NB7Bm0loJSAXA/30g2OXlj05c/zid+A1V3xi18+HGixQFmTMOT1e7
X-Gm-Gg: ASbGncvesf/FPf4Ia8i+GnBDfEeb8dRV9QvYtnOsf2CqhhesNpk3Fz8QiRs4+uvTqHh
 4hTUs0NPVraAst2ttnfdbeN5BYLkwcLqLKa0id0cpNw7ZrFBcGyqOYI5CMl+9ptKNjHi513JlHR
 ZuI2/Mp9fjSkef5IWgFShHsThKDuXLyGH0KD6GqcFPrI/7lbw5efIgQhouYUEpHM3+d4jgv9azq
 Yx/FcdPWl5EszUmV7TaPMGQgZqorhnrOU0BsKPNNHxmfi21V3W+NOr+bLELlPmxVCBMUTVolxR3
 Kwh4Ti8=
X-Received: by 2002:adf:f981:0:b0:38a:4b8b:295a with SMTP id
 ffacd0b85a97d-38c5195e8e5mr16074366f8f.31.1738675761444; 
 Tue, 04 Feb 2025 05:29:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErysUd3OCmiLZgiBz1MHk+FSr2OdAXBUm//ME9UHm6iNkCnCA82sBlKR+qWvHIaTGsWRZHsw==
X-Received: by 2002:adf:f981:0:b0:38a:4b8b:295a with SMTP id
 ffacd0b85a97d-38c5195e8e5mr16074348f8f.31.1738675761103; 
 Tue, 04 Feb 2025 05:29:21 -0800 (PST)
Received: from [192.168.10.28] ([151.62.97.55])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38c5c12247esm16323937f8f.53.2025.02.04.05.29.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 05:29:20 -0800 (PST)
Message-ID: <71b208c1-c61a-4498-8200-0850548f4d74@redhat.com>
Date: Tue, 4 Feb 2025 14:29:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINER: Add a maintainer for CPR
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
References: <20250204082859.846886-1-clg@redhat.com>
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
In-Reply-To: <20250204082859.846886-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/4/25 09:28, Cédric Le Goater wrote:
> The CPR feature was added in QEMU 9.0 and it lacks a maintainer.
> Propose the main contributor to become one.

Why can't changes go through the migration tree?  The only addition 
seems to be hw/vfio/cpr*.

Paolo

> Cc: Steve Sistare <steven.sistare@oracle.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   MAINTAINERS | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index db8c41fbe0f9..efb9da02f142 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2943,6 +2943,15 @@ F: include/qemu/co-shared-resource.h
>   T: git https://gitlab.com/jsnow/qemu.git jobs
>   T: git https://gitlab.com/vsementsov/qemu.git block
>   
> +CheckPoint and Restart (CPR)
> +M: Steve Sistare <steven.sistare@oracle.com>
> +S: Supported
> +F: hw/vfio/cpr*
> +F: include/migration/cpr.h
> +F: migration/cpr*
> +F: tests/qtest/migration/cpr*
> +F: docs/devel/migration/CPR.rst
> +
>   Compute Express Link
>   M: Jonathan Cameron <jonathan.cameron@huawei.com>
>   R: Fan Ni <fan.ni@samsung.com>


