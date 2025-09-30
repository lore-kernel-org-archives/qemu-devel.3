Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C29CCA472
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 09:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3WoO-0004sb-W7; Tue, 30 Sep 2025 05:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3WoL-0004pi-6o
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:38:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3WoE-0001yW-Jd
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759225088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2L7MHvNODAsCYdS53CbvoFRY7jALUq7mp1TL2zIN9X0=;
 b=ZAojtVPwu4/TgUIZm7Z1B9RFuzHrDezAHXVHBo3e1rVlY9xFTMPGDuCalrl6VVaopIf+Z2
 wCxeMl1GPOwnouP4eBNPJnFuX37zSmMfL7Kg+yymJKc29xNe6KqvI4ViU6RqWU99pUmtYc
 R/UL3Ye2VQQcKdR3P1sr4ZLSeEnjR00=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-VFx_P-ZCMXGAe9VZgp-2yg-1; Tue, 30 Sep 2025 05:38:06 -0400
X-MC-Unique: VFx_P-ZCMXGAe9VZgp-2yg-1
X-Mimecast-MFC-AGG-ID: VFx_P-ZCMXGAe9VZgp-2yg_1759225085
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-40cfb98eddbso2705965f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 02:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759225085; x=1759829885;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2L7MHvNODAsCYdS53CbvoFRY7jALUq7mp1TL2zIN9X0=;
 b=Yv5sU+sw2SeqLg6zwn0rJ9TohDoyTh5WNAVdyknOcmM49r0Ql2Itnr36BOHwe8OB7/
 aAjOvhnch5o1ivXKfh0df8ZZc68dQniSeJ2mtqHEenOPrLIuo6C069j/u5WG28YwWQfa
 UhhC9+dddz4H1ec96qZoftGXkuEgalIbzYxsEDs/KPfRitvPdawb9cuzRBdAf0f9ivsg
 o0aVzqUMbdUYxUGEJiyK2vx65nJbPh68QU3yYaX6JvZnEE62VC6ntjyxKIF89trUAelo
 uQPLlRPxW6LSgcK73uloy3ji7yK+GS30JJP4VwHsdugnvIRVQJmR5yU9YoOj6K9kxtRg
 WzBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE5yNfNw2jeXdtqTNHo+PfHdJWnkDEtubUuBCqpxlWgL9UivpovOYZmtO8Jg4oP63NwPsrqICXMere@nongnu.org
X-Gm-Message-State: AOJu0YxBuoLPhYdAMnL5/mfUPLw52Epd8FY7vl+V4FFMDHWJBHptxC+w
 Xe0AriSk2ePLivxOA1LLoySJpH+DLjheSadkWey7bO0O1kpgQVxFtRbQ7aCANoAxU6TM3HTTkY3
 2Skp3lJCjkuhyfZyo0SlgBNgYm9OPGmUxEjQfPe5Qx9+y19FrvMZ4ueHh
X-Gm-Gg: ASbGncvf5c7koIWMNwKR8bY/ztSPabnKL7HHCd0IekgXTbUdDXLVSKlDBdRfqLcG0Fz
 ydCRmQTa5v2a/BrcfpUTSWX0kigi5Gnw6ETkg3KMbXQWlvg3VF7sJrcIkHIskh4x5/Ii5t/DtiJ
 kjZmnjmt8o/nuSJOMnu2yf238Lu7No/V7GJNiZPxo3wiSqvrYm5hPzwrmTarrVksZaWbXfW+aHx
 SN58kCQUFIDKGNRahBTf+reu5YfGdWrW7xQrAtKEqu2zU9d+27H7dl4ZsL8H1OhzVqU4hfUBfuO
 LAVLnpXhB1TS+b3z1UejfcQJdJ0d5nZ4TZg+tAI4LQIaLP5s7EH5GgX/L3qfJGY0EzQFOJ81zTw
 8I5lH3LVCbA==
X-Received: by 2002:a5d:5d12:0:b0:3ea:71c4:8e27 with SMTP id
 ffacd0b85a97d-424119d24demr3007061f8f.22.1759225085132; 
 Tue, 30 Sep 2025 02:38:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHedJn2W76nl7bpVvn9bPUDW4r8mbN0K5/LQO2ilrPmtVeCLLWEQoonpzzZluPVI2i8ECt66A==
X-Received: by 2002:a5d:5d12:0:b0:3ea:71c4:8e27 with SMTP id
 ffacd0b85a97d-424119d24demr3007035f8f.22.1759225084702; 
 Tue, 30 Sep 2025 02:38:04 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-056.pools.arcor-ip.net.
 [47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc560338csm22499280f8f.41.2025.09.30.02.38.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 02:38:04 -0700 (PDT)
Message-ID: <32cf7da4-9eb3-4320-941e-5de12bca8ff7@redhat.com>
Date: Tue, 30 Sep 2025 11:38:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/28] crypto/x509-utils: Refactor with GNUTLS fallback
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-3-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <20250917232131.495848-3-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
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

On 18/09/2025 01.21, Zhuoying Cai wrote:
> Always compile x509-utils.c and add a fallback when GNUTLS is
> unavailable.

Maybe add some rationale to the description, like "we are going to need 
these functions in the s390x code even if GNUTLS is not available" or so?

  Thomas

> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   crypto/meson.build  |  5 +----
>   crypto/x509-utils.c | 16 ++++++++++++++++
>   2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/crypto/meson.build b/crypto/meson.build
> index 735635de1f..0614bfa914 100644
> --- a/crypto/meson.build
> +++ b/crypto/meson.build
> @@ -22,12 +22,9 @@ crypto_ss.add(files(
>     'tlscredsx509.c',
>     'tlssession.c',
>     'rsakey.c',
> +  'x509-utils.c',
>   ))
>   
> -if gnutls.found()
> -  crypto_ss.add(files('x509-utils.c'))
> -endif
> -
>   if nettle.found()
>     crypto_ss.add(nettle, files('hash-nettle.c', 'hmac-nettle.c', 'pbkdf-nettle.c'))
>     if hogweed.found()
> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> index 39bb6d4d8c..6176a88653 100644
> --- a/crypto/x509-utils.c
> +++ b/crypto/x509-utils.c
> @@ -11,6 +11,8 @@
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
>   #include "crypto/x509-utils.h"
> +
> +#ifdef CONFIG_GNUTLS
>   #include <gnutls/gnutls.h>
>   #include <gnutls/crypto.h>
>   #include <gnutls/x509.h>
> @@ -78,3 +80,17 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>       gnutls_x509_crt_deinit(crt);
>       return ret;
>   }
> +
> +#else /* ! CONFIG_GNUTLS */
> +
> +int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
> +                                      QCryptoHashAlgo hash,
> +                                      uint8_t *result,
> +                                      size_t *resultlen,
> +                                      Error **errp)
> +{
> +    error_setg(errp, "GNUTLS is required to get fingerprint");
> +    return -1;
> +}
> +
> +#endif /* ! CONFIG_GNUTLS */


