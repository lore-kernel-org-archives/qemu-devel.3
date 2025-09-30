Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BF0CCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 13:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3aAr-0007Pa-C5; Tue, 30 Sep 2025 09:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3aAm-0007O2-Dj
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 09:13:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3aAa-0003DN-JT
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 09:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759238005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kNPdn7SHrJ7RSZFo+x766syUCIuz2wQ3urtpRumP08Q=;
 b=XqxXdiNCJh54qV23onLsZPLQxK6cHy2Z3Zqpu7cdvepADInY+4m4WOUWNphebjpdncuRGZ
 iM0zw31UnLP78y88VzTHNSBEEaEwkvL+LD4fIzUqjDKCpIeAubvGCK8MRokCNB0+BLI9my
 v4g0RqXQITAauvj/teo42Zi36vZqw14=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-cL2hLNOcPtWLKhV09zdROA-1; Tue, 30 Sep 2025 09:13:23 -0400
X-MC-Unique: cL2hLNOcPtWLKhV09zdROA-1
X-Mimecast-MFC-AGG-ID: cL2hLNOcPtWLKhV09zdROA_1759238003
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3f384f10762so3784339f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 06:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759238002; x=1759842802;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kNPdn7SHrJ7RSZFo+x766syUCIuz2wQ3urtpRumP08Q=;
 b=FJS7rHBI8nJNaS7PtNRlB6ow5JpJS4nw9Jplpqtn3Dzs5iNeW9QUI+u4Rrhlj5fVbu
 c1hs7BTOuh2QiQFz0j+iVA6G4ks4M+yUJ1KNUHZujdbWKiDXNvB1bm9MMtpmR21kDxq/
 sraDlmIM7RMy86WwwDnsUzLUC7zB10LBcmxbbiYCGQvYtRXTB3YVhtqQC978p7/IAho6
 exVGNiaKHBvPyTCNJq8Xyq5/0Lz0glIhEXfBALVGoIfB78i95liSCrcRZWd5b9KvB+/I
 +pn3NXy3BIhbp+eTBnTdTFNwDDIEry2P7pm87g0/mgVdDMqhzgJcjc+UeHot1E2C4+pq
 hrRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2yfBfxaqiYa243C/Xod/ak0nGVYEAEa8W2k5iXHpykiGVDixHrTyBjxQ+ru1Z8wHr4JuTRI2KjMGW@nongnu.org
X-Gm-Message-State: AOJu0Yy84LTxvuz9jf+/+bSqIF4i5Trr6jS3bB02jRVybxPcPUT9rPkI
 njfKyiNlPTZdoo4SXkujU1A0KN9L4vuWmYsFGXnQB3pkl6H2Bu0LoiI1S0gJhl/xNOfVbxuiFNT
 ddIGsQqQ9z1aXw4KNsxpHbJHjaBj8icQdieM7z8VvN8rT/Fh/Jxn2rpUY
X-Gm-Gg: ASbGncux83iCy5Ek0RbkQR8TtVNUEFgzn88NL4B0bR+kQWDyxtFsMfLgytXk7QeJr2O
 Pcd6G7XwFI2ZvlQC6B6cxaaGmvZ4NtiAUbzLDEuNEBV9QX1V4qqA5J18n6DSx8cq/XfZmHgRBYK
 oWlXGnCeS0amGtHjSNxVnX341WdM+2/QItOqc7Fqk3kEi07RKOb67sZg7JpkBLsiNJY16URa4ax
 voH8lLrpdJxi6CeuScPdJA93srPXG6vgCBbGOkeTtstUKVuaDmCeSfYS38Kme6lANlzFKRv0Gvi
 elSvuHsb8PalTVHmUv6EanYX+opmyiUw3Z+jsR0BbdvYXx5qAPYT5wLgwff57RhAKCCGwIGjLVu
 MmLFijMUjhw==
X-Received: by 2002:a05:6000:4024:b0:3ec:d7c4:25d5 with SMTP id
 ffacd0b85a97d-40e4be0cb3amr16446591f8f.50.1759238002556; 
 Tue, 30 Sep 2025 06:13:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+sGvMHrzt1mRk8umXZcW4HkmCuFefy2IJdYhwvVcyylP7nnF+c3/e/Szcm5SU0BVvGsE3Bw==
X-Received: by 2002:a05:6000:4024:b0:3ec:d7c4:25d5 with SMTP id
 ffacd0b85a97d-40e4be0cb3amr16446513f8f.50.1759238000630; 
 Tue, 30 Sep 2025 06:13:20 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-056.pools.arcor-ip.net.
 [47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5b63b407sm14941425e9.2.2025.09.30.06.13.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 06:13:20 -0700 (PDT)
Message-ID: <644467f0-f72a-493a-b59f-752163f6bb24@redhat.com>
Date: Tue, 30 Sep 2025 15:13:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/28] s390x/diag: Refactor address validation check
 from diag308_parm_check
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-7-zycai@linux.ibm.com>
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
In-Reply-To: <20250917232131.495848-7-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 18/09/2025 01.21, Zhuoying Cai wrote:
> Create a function to validate the address parameter of DIAGNOSE.
> 
> Refactor the function for reuse in the next patch, which allows address
> validation in read or write operation of DIAGNOSE.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   hw/s390x/ipl.h      | 6 ++++++
>   target/s390x/diag.c | 4 +---
>   2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index bee72dfbb3..e26fc1cd6a 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -118,6 +118,12 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
>   #define S390_IPLB_MIN_FCP_LEN 384
>   #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
>   
> +static inline bool diag_parm_addr_valid(uint64_t addr, size_t size, bool write)
> +{
> +    return address_space_access_valid(&address_space_memory, addr,
> +                                      size, write, MEMTXATTRS_UNSPECIFIED);
> +}

The function is only used in diag.c ... could you please move it to that file?

  Thanks,
   Thomas


>   static inline bool iplb_valid_len(IplParameterBlock *iplb)
>   {
>       return be32_to_cpu(iplb->len) <= sizeof(IplParameterBlock);
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index a35d808fd7..e67ee57f01 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -65,9 +65,7 @@ static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
>           s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>           return -1;
>       }
> -    if (!address_space_access_valid(&address_space_memory, addr,
> -                                    sizeof(IplParameterBlock), write,
> -                                    MEMTXATTRS_UNSPECIFIED)) {
> +    if (!diag_parm_addr_valid(addr, sizeof(IplParameterBlock), write)) {
>           s390_program_interrupt(env, PGM_ADDRESSING, ra);
>           return -1;
>       }


