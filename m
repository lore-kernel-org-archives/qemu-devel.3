Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DC3C021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 16:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiFud-0003LD-81; Wed, 12 Feb 2025 11:48:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tiFub-0003KL-Kc
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 11:48:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tiFua-0004Jt-7Y
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 11:48:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739378911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XLcm+GYuwWup40Gm8eKU9GKMwCAH9+g9RxmfHL3bkfA=;
 b=Cho/OyKCaRvhcByG2PPJ6N3bGm4A1bTzZlRn9f68vbRujz0q29KheVRqkbv5JcJqkUZ8fB
 olpxEe3H0RYFhc6rofp7a8Mm0J0ELM0TBq77Jopk/8sIQ9olPk6PXw9NzU9mJJPf2IG1Fz
 dNqrs/Q6Ol8iv/tuKcmj/SbzRy5xo/I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-Wlf8KSDoPhOMGY9zpZ7TqQ-1; Wed, 12 Feb 2025 11:48:29 -0500
X-MC-Unique: Wlf8KSDoPhOMGY9zpZ7TqQ-1
X-Mimecast-MFC-AGG-ID: Wlf8KSDoPhOMGY9zpZ7TqQ_1739378907
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38dd533dad0so2841193f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 08:48:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739378907; x=1739983707;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XLcm+GYuwWup40Gm8eKU9GKMwCAH9+g9RxmfHL3bkfA=;
 b=KeGQgW4S3EMHqRxfvsVVXI0uXXk8+6OR9BdV8stgz/+yDUWc31BqUMG6xbU3/mCtoB
 MaTR/dkbAgzD9xDAvZkjtLvwGELNT1g4trkTmcJmgtsU79tK4MI+jFg/aOXRobFJpmC9
 Wg4GYrgWxUD9O0RJMmEIm04inU9FmGeP2MQ9XcE65R54spWBwdGwU+YUTDcWwRekZBQ1
 rErDJu41MXLfystvvNQoVwG5VPXjbUi8kZoXOfCaczR6q//Sm4w6G3YfcLTvMa0D89vA
 ba6rg4rcHv1ap0N6WzxNFg0mLezeKxnLMqqBzvwoNSdup52byiPbdbZeEKPn1Ke2tCbO
 4GHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVTtyLIfRy8RN9jny2ufzvqq8FTkJ627pLYc1sAy3PXkh1WKBGldbztcHginWNh0OK61/QEemFfvn9@nongnu.org
X-Gm-Message-State: AOJu0YwjppDrq11C7gHhfO/aNLyb2Q+5SQsN7oe5uXoMN8xcKHmimVZN
 VOQxt8TIB+P1ICXwhuGi+f5TxEwMhXAW2q3biu6Vyp+DykLoGaBkq2obTqy/5lj3PtzVTodcFe7
 Cmz93Ke8GMn9x+1CTmqwJOGjVmSeEpY1q5SxQ8ussRP576iX/8hufZ53PvCHU1Ws=
X-Gm-Gg: ASbGnctxGUzSf/bilAwTEePKsn4QpKWmTEsnUwi4p8RRWhhkpddsRA9W05GFCyX3RWS
 Xnr6fmhzFsu302usQyR0xCYsUcPJ6xhlEuZJSSj+r5QprOW8Knicp2HS2s39xSRLrKhUhhbzVyo
 /Bts26ttIQUY7rY1curLsAi7E9M6dc6Pqvt6hMywyGVHn8hIEbkZjGLe0E2jgQ8DU0eGVj7jfth
 sgfNCgACRr1FYnzPgbP0pBxFzPLuGeWsK1w2JPHlVNpRLYQaHWXDirhegImQA3QqtqcWDrXBnG0
 UyomOfs=
X-Received: by 2002:a5d:47a7:0:b0:38d:d946:db15 with SMTP id
 ffacd0b85a97d-38dea256d3amr3421642f8f.5.1739378906686; 
 Wed, 12 Feb 2025 08:48:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/3IzBLAkl3QS5/HsQIFGtVwPsBq+6HuVhGxay9cGnipnFazPxFwi6E73IAnlwNdF2xDQYOw==
X-Received: by 2002:a5d:47a7:0:b0:38d:d946:db15 with SMTP id
 ffacd0b85a97d-38dea256d3amr3421615f8f.5.1739378906260; 
 Wed, 12 Feb 2025 08:48:26 -0800 (PST)
Received: from [192.168.10.81] ([151.95.148.6])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38dd44c5e3dsm12558165f8f.62.2025.02.12.08.48.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 08:48:25 -0800 (PST)
Message-ID: <b3241aed-0470-41c8-ae82-e492fd3802ee@redhat.com>
Date: Wed, 12 Feb 2025 17:48:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] rust/block: Add I/O buffer traits
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: hreitz@redhat.com, manos.pitsidianakis@linaro.org, qemu-devel@nongnu.org, 
 qemu-rust@nongnu.org
References: <20250211214328.640374-1-kwolf@redhat.com>
 <20250211214328.640374-7-kwolf@redhat.com>
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
In-Reply-To: <20250211214328.640374-7-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/11/25 22:43, Kevin Wolf wrote:
> +/// Implementing `SizedIoBuffer` provides an implementation for [`IoBuffer`] without having to
> +/// implement any functions manually.
> +///
> +/// # Safety
> +///
> +/// Types implementing `SizedIoBuffer` guarantee that the whole object can be accessed as an I/O
> +/// buffer that is safe to contain any byte patterns.
> +pub unsafe trait SizedIoBuffer: Sized {

This is similar to the ByteValued trait in rust-vmm.  Can you name it 
the same so that we can later consider replacing it?

> +    fn from_byte_slice(buf: &[u8]) -> Option<&Self> {
> +        if buf.len() < std::mem::size_of::<Self>() {
> +            return None;
> +        }
> +
> +        let ptr = buf.as_ptr() as *const Self;
> +
> +        // TODO Use ptr.is_aligned() when MSRV is updated to at least 1.79.0
> +        if (ptr as usize) % std::mem::align_of::<Self>() != 0 {
> +            return None;
> +        }
> +
> +        // SAFETY: This function checked that the byte slice is large enough and aligned.
> +        // Implementing SizedIoBuffer promises that any byte pattern is valid for the type.
> +        Some(unsafe { &*ptr })

If you want, the function can be written also

     // SAFETY: implementing SizedIoBuffer promises that any byte pattern
     // is valid for the type
     match unsafe { buf.align_to::<Self>() } {
         ([], mid, _) => mid.get(0),
         _ => None
     }

(trick stolen from rust-vmm, in fact).

Paolo


