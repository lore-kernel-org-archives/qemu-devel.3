Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D4ED29DF3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfawH-0006hU-On; Tue, 13 Jan 2026 04:43:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfawG-0006h7-3E
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:43:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfawE-00046q-Bj
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nOtm4xyKhbg2Dibv5J67QS/JMXVDs1HEAPPDV4NpVc8=;
 b=K63DqSY6q97v5R6gjad8f6ioRD+qJ9hpuW3rq0pbOaJ5GC4E52dRPDJUPpXBk2j3hbftU4
 hsuU7H7ugu1sa2zUy94M3Ntsxl0weFLxFNwpMNn4/l/s6k7G674mGZadDYFsmzUnSXO5vI
 trbXJugYB8a0Oe32ea/xs+1mHpwUdj0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-jVw-2FvcNkqQBTN7pWnk3g-1; Tue, 13 Jan 2026 04:43:43 -0500
X-MC-Unique: jVw-2FvcNkqQBTN7pWnk3g-1
X-Mimecast-MFC-AGG-ID: jVw-2FvcNkqQBTN7pWnk3g_1768297422
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4775d8428e8so59870605e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 01:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768297422; x=1768902222; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nOtm4xyKhbg2Dibv5J67QS/JMXVDs1HEAPPDV4NpVc8=;
 b=Iwfyft/jafcc1sX0oDsgb6hSXmHylTfkTfDcAe3B0wGKJB62NIWYZkmfJIiPQUHr9w
 onsl9wEHJ+h9C1cxlMW7ruUwOlnRffj/YkUS2oC9v8A8Mf3q/IrvUVwzA4+REd4Iflly
 jDpSh0fUeCWOjqMZ8uIhA8gxZViDqeYGTUdJcVycJHkEsC8ZoEZSHU1YIWX2fObWRoCz
 giREdmuXmbacMSnaEDgjM1LzjIXPj/dQ4PEHnq2jlV66sy6VfVana9uvYBYeXMeeMHFA
 mmwKmQSaS88sCodBnJ0IiO+2dnfAqqMjQBGnDMMirbzGvFS7O/YpuRHoeIVgoV7N5z8Q
 BP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768297422; x=1768902222;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nOtm4xyKhbg2Dibv5J67QS/JMXVDs1HEAPPDV4NpVc8=;
 b=Dvc4OhLqdf7nIRiA6OHpu4QHdeNxn/8CXlfKVJBxfVuuMs4g7ZoCSouNlUdBryUCoa
 jUpDQ4XmBi44+NR3LxffoiMJmpZBSRKfKPfRXTlwqK0p67WCJqcD006bihzWQj420Ng9
 YtB61QxHobjcrhOCaHkydi9VB+2C05VyEzvLZE6zoTRPsdwGR7dleVcW97a6jmY8OvVg
 X9oFVZwMIhwkRv6q948GWlMTrL+zrkIH5rZDG8f1CeR05uMAHqgmhGqHozt/lMgDPd6/
 loJID45CZkYzm572b30fPr+4sZ9yDYv13Cxjw/r5uiz+xIfrKzev6Tp19L0Ft8kXhlsu
 Lb/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH+QzUK5bR+OKl+YZ5HF2daTI1e2hAYUZOfj6GClerLOp+oYeyhsTTrb3a61exRUqU2BP3ACGl9xLH@nongnu.org
X-Gm-Message-State: AOJu0Yxlxg6VCyrvPsiixEiR9F3r1ClinZ+vF6l8q6Hy69gnKxoCd2TA
 IszCoA+JMoDe/evSNMv7uCa/U9w/O0Dbe2U0+H+/GCa5F4WUFz1usyr9zdCo2mW0QMd8h0/1WE5
 kUHCO9wgdjspDmyVxJ09VUhoAaaBNTjecqmxn5rlpfSkT2wt4DGvWpbC3
X-Gm-Gg: AY/fxX69oSzV40SJfXeyiiq3h6FsxahXvWiiQggVx947jPV+/eV8ITwBdYZ9UW/eEHI
 +oPUnliOXWpVSGPycIDlID9VxIqJV+EVreWOfHV21Ah9nIH+gRWy8vEQpknN+wbMrsf2wdTmIPR
 37sA9yWgVcP0ihvTnfGCulyhDwkOz1XRYbyfm1GhKclXuM60K6qYpA6jITkvwWkMtCJ0wB+ULqq
 Y8AIdNz9hG70ZgoLJ9cBb3/H9nfUYdA0wJISSE5pc6fW+VfqpeoNB5N2jma5HK9p6a7N+2xv3ox
 RSKE5EFTQX2ypFRB0HwcYFs9KbSirX6/kO0cKzWSFt72ZDdSYwSCKkCC960WFDc8sel6Qqh4AQG
 ZGHWHfc0=
X-Received: by 2002:a05:600c:3b15:b0:477:c71:1fc1 with SMTP id
 5b1f17b1804b1-47d84b33ba2mr228452555e9.19.1768297422401; 
 Tue, 13 Jan 2026 01:43:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGYdtSw0ZBW+1Ik2fvOk1q6fPC0RhBjG91JnMl8+kzN785cXWp+QS6+w0/7685QCbf4ulpvw==
X-Received: by 2002:a05:600c:3b15:b0:477:c71:1fc1 with SMTP id
 5b1f17b1804b1-47d84b33ba2mr228452295e9.19.1768297422009; 
 Tue, 13 Jan 2026 01:43:42 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e16d2sm44659188f8f.13.2026.01.13.01.43.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 01:43:41 -0800 (PST)
Message-ID: <99c65f26-fb1b-4f5c-8d2f-6c335df60c02@redhat.com>
Date: Tue, 13 Jan 2026 10:43:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 28/29] docs/specs: Add secure IPL documentation
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-29-zycai@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
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
In-Reply-To: <20251208213247.702569-29-zycai@linux.ibm.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
> Add documentation for secure IPL
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>   docs/specs/s390x-secure-ipl.rst | 55 +++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
> 
> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
> index 70388d77d8..45f58ab49d 100644
> --- a/docs/specs/s390x-secure-ipl.rst
> +++ b/docs/specs/s390x-secure-ipl.rst
> @@ -1,5 +1,60 @@
>   .. SPDX-License-Identifier: GPL-2.0-or-later
>   
> +s390 Secure IPL
> +===============
> +
> +Secure IPL (a.k.a. secure boot) enables s390-ccw virtual machines to
> +leverage qcrypto libraries and z/Architecture emulations to verify the
> +integrity of signed kernels. The qcrypto libraries are used to perform
> +certificate validation and signature-verification, whereas the
> +z/Architecture emulations are used to ensure secure IPL data has not
> +been tampered with, convey data between QEMU and userspace, and set up
> +the relevant secure IPL data structures with verification results.
> +
> +To find out more about using this feature, see
> +``docs/system/s390x/secure-ipl.rst``.
> +
> +Note that "userspace" will refer to the s390-ccw BIOS unless stated
> +otherwise.
> +
> +Both QEMU and userspace work in tandem to perform secure IPL. The Secure

I'm not a native speaker, but I'd maybe rather say "work in cooperation" 
instead of "work in tandem" ?

  Thomas



