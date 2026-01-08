Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B813D1D47D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 15:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdsKZ-0006iG-4H; Thu, 08 Jan 2026 10:53:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdsKX-0006fI-Cv
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:53:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdsKU-00070X-E9
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767887620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gbPzLpA8WLhv4/kp5p6zTSvOtxHMBETIlFMofmkM/oE=;
 b=NJ+STSKBgeBnqBT+YtZHsTuRVR6ZrZ39ewGVaBDcHH4bsuTGUa2xLMv2OJPikpGy203Mll
 HBDo+EG4wnhjhv5uWqmVgM/gq/K4DNnyyRXg2nN+RKvowc888HnXrcl3aVLIwWIeHmu3nH
 zdoZfOsYsxkz0gxnNG0CrJuApdmK4lo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-X-9WXAwaPN-P2Ioak6xMXQ-1; Thu, 08 Jan 2026 10:53:39 -0500
X-MC-Unique: X-9WXAwaPN-P2Ioak6xMXQ-1
X-Mimecast-MFC-AGG-ID: X-9WXAwaPN-P2Ioak6xMXQ_1767887618
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430fc153d50so2439395f8f.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 07:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767887618; x=1768492418; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=gbPzLpA8WLhv4/kp5p6zTSvOtxHMBETIlFMofmkM/oE=;
 b=Un6MBmR7H+suTSvbIUH0IXnXlZRd9OzbNKWmz5nZIkPFbbPjTvO69W4YfWlMVVAiAj
 vE6ua2Reae0kh0yiarZUx89VnQbeAY5Aa9Y8686aS6rgaieDY+7u6xbnyyubNdzTxk51
 vcqgq2pBZSzr0fNXnTyv5o+GVHCetNQfQLJPlcqXzPUNqBMbE5okC30r4Khlk6N+Iajl
 AnV7HMQ8ZN71b6xrfX9nN5XOJEd29OMYKlpru119XSjbIyxqPr95G8bHGvHJ54i2/Wz0
 uEw1y+Na8cnusDqxb9gIjpfJH1gqBwQ+XvxcEvHfPdwTDe4h/lR/dnCvg6gj6OGHE5tn
 jRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767887618; x=1768492418;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gbPzLpA8WLhv4/kp5p6zTSvOtxHMBETIlFMofmkM/oE=;
 b=r+k9UurLpUDMNh6iwunndOdafqtfkv9jlodgeFay/fHFa9EsLtCHK3vUFX0wsB85LH
 2DLCx01QeSRvbgCvmS0TL/fLV8uTE2jjmPkHhOr2JV+Qpyty2tbJMkFZhya2rP7C3HLF
 ZbQiDapx21TTpPYzc5/wqt/wFTewK+Vn2OHbEHDK4Bc4bUBI3rq4wsHMpddhmz/p4h4H
 7s1DkPSvPPStTgSmr7hcOSNer5bF9Ema38RR5Ak/KQa3zXjSQ1ll7lRe1TKpU3FFjRef
 +WWFpDfvcxcS254g210HEIiYnLuZX5XqdIbuUYHkP9NsuR8JKZbIRMrvtWG1a624y5Ms
 bujA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ/rD0Ma9SLUK7/yINYKNS9VdpLCMupxZ1W3gwh0NGnNBaPOnfAqD8zVHBCFNY8LSSnfAwUA/vS65Q@nongnu.org
X-Gm-Message-State: AOJu0YxrlEvXUIU0abTwRc3WxSueBxAmPqlGxDdGo4ZNkSRpfT1j4Rzm
 rkY0zgPc2vQ4vBa+wODkbpAhyk13FpL6KIRQnql7FGxODcASA5XmtbN/o0a8mPQVhv3X/s1OMw4
 o5syKa4N7iSxeETX+PQtTWBvoEsNndUMyW5WerBb71a8GTE0jnQzwKjC3
X-Gm-Gg: AY/fxX7SiHoFZQWNvL2rLgk8y36KCU40EnC+GnyGfa0u8l1sWQmqThVsjgjtDphzdXc
 7BQYF61Ybi43yqXct24IP7+tYXYhnktUFpx4glq1wRm/xjRq9VRzXlHG6vWpDzIDxrbw4N5tpb0
 RiPb7y/7i8yQpXq+NoEui0GsSj2iqOMPULI8nk/JKzs72zg/hVDlPSY6IvHWzUqlJOJO6osZZSK
 YXspxo4GsdxbPiyIFaBvasEasTCHGvk3xR6wENqUoambwWXSYOMxg6+JdqyhkjjzL3HQlY011rC
 oFA/y8IDojdpLtK8CXtUSi3S0IV78HCY6DUrh+pkF0mb1wjhxl03lcuIdjKK2Q5I6svcHzWOz1B
 IiFgWaw0=
X-Received: by 2002:a05:6000:3102:b0:429:c851:69ab with SMTP id
 ffacd0b85a97d-432c38d22e5mr6749649f8f.55.1767887617851; 
 Thu, 08 Jan 2026 07:53:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IES7jTbCg1Cvffxs23iKAbbs981yryRhOGHdPSwRX+Sx1PzfdoBLc67NPKiRv9IdL9K2wkgVg==
X-Received: by 2002:a05:6000:3102:b0:429:c851:69ab with SMTP id
 ffacd0b85a97d-432c38d22e5mr6749629f8f.55.1767887617369; 
 Thu, 08 Jan 2026 07:53:37 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e17aasm17377334f8f.15.2026.01.08.07.53.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 07:53:36 -0800 (PST)
Message-ID: <a360963c-62be-4b5c-bf0c-ea5f89809048@redhat.com>
Date: Thu, 8 Jan 2026 16:53:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/29] s390x/diag: Implement DIAG 320 subcode 1
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-8-zycai@linux.ibm.com>
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
In-Reply-To: <20251208213247.702569-8-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 08/12/2025 22.32, Zhuoying Cai wrote:
> DIAG 320 subcode 1 provides information needed to determine
> the amount of storage to store one or more certificates from the
> certificate store.
> 
> Upon successful completion, this subcode returns information of the current
> cert store, such as the number of certificates stored and allowed in the cert
> store, amount of space may need to be allocate to store a certificate,
> etc for verification-certificate blocks (VCBs).
> 
> The subcode value is denoted by setting the left-most bit
> of an 8-byte field.
> 
> The verification-certificate-storage-size block (VCSSB) contains
> the output data when the operation completes successfully. A VCSSB
> length of 4 indicates that no certificate are available in the cert
> store.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>   docs/specs/s390x-secure-ipl.rst | 12 +++++++
>   include/hw/s390x/ipl/diag320.h  | 22 ++++++++++++
>   target/s390x/diag.c             | 59 ++++++++++++++++++++++++++++++++-
>   3 files changed, 92 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
> index c2e8f7aba5..d3ece8a82d 100644
> --- a/docs/specs/s390x-secure-ipl.rst
> +++ b/docs/specs/s390x-secure-ipl.rst
> @@ -26,3 +26,15 @@ Subcode 0 - query installed subcodes
>       Returns a 256-bit installed subcodes mask (ISM) stored in the installed
>       subcodes block (ISB). This mask indicates which subcodes are currently
>       installed and available for use.
> +
> +Subcode 1 - query verification certificate storage information
> +    Provides the information required to determine the amount of memory needed
> +    to store one or more verification-certificates (VCs) from the certificate
> +    store (CS).
> +
> +    Upon successful completion, this subcode returns various storage size values
> +    for verification-certificate blocks (VCBs).
> +
> +    The output is returned in the verification-certificate-storage-size block
> +    (VCSSB). A VCSSB length of 4 indicates that no certificates are available
> +    in the CS.
...
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index a347be7633..0e1897e03d 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -197,11 +197,50 @@ out:
>       }
>   }
>   
> +static int handle_diag320_query_vcsi(S390CPU *cpu, uint64_t addr, uint64_t r1,
> +                                     uintptr_t ra, S390IPLCertificateStore *qcs)
> +{
> +    g_autofree VCStorageSizeBlock *vcssb = NULL;
> +
> +    vcssb = g_new0(VCStorageSizeBlock, 1);
> +    if (s390_cpu_virt_mem_read(cpu, addr, r1, vcssb, sizeof(*vcssb))) {
> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
> +        return -1;
> +    }
> +
> +    if (be32_to_cpu(vcssb->length) < VCSSB_MIN_LEN) {
> +        return DIAG_320_RC_INVAL_VCSSB_LEN;
> +    }

Do we maybe also need to check for an upper limit for vcssb->length ? (see 
below...)

> +    if (!qcs->count) {
> +        vcssb->length = cpu_to_be32(VCSSB_NO_VC);
> +    } else {
> +        vcssb->version = 0;
> +        vcssb->total_vc_ct = cpu_to_be16(qcs->count);
> +        vcssb->max_vc_ct = cpu_to_be16(MAX_CERTIFICATES);
> +        vcssb->max_single_vcb_len = cpu_to_be32(VCB_HEADER_LEN + VCE_HEADER_LEN +
> +                                                qcs->max_cert_size);
> +        vcssb->total_vcb_len = cpu_to_be32(VCB_HEADER_LEN + qcs->count * VCE_HEADER_LEN +
> +                                           qcs->total_bytes);
> +    }
> +
> +    if (s390_cpu_virt_mem_write(cpu, addr, r1, vcssb, be32_to_cpu(vcssb->length))) {

So this uses vcssb as source, but the length is controlled by a value that 
is provided by the guest? ... this sounds dangerous, I think we should 
definitely limit vcssb->length to be <= sizeof(*vcssb) !

> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
> +        return -1;
> +    }
> +    return DIAG_320_RC_OK;
> +}

  Thomas



