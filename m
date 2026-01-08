Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82FECF6AB6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 09:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdmUh-0001ZX-E0; Thu, 08 Jan 2026 04:39:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdmUe-0001ZA-Jp
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:39:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdmUc-0007D1-Vl
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767865186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XojOHjApRsfRYlwZkVcmTgQKGqR9C5oon1RD5/J1iVg=;
 b=Rtq40R+/zRcIpYYKEG+PzJlG/sDBszSLDCPo+shPmnVdh9q10oLZIl5o6PLu48N38xJTai
 URhFvDOgKWfNGlhZoFb4OR5mnnJfGU+10b//CU9UKktWbrf9xq1SjiVyRXpajOGe5aPLOU
 srW2upYId4WjGnlmri6vy/Yhm9x2xvo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-GufQGJ_UN3Oqtb4OX0R0Ng-1; Thu, 08 Jan 2026 04:39:44 -0500
X-MC-Unique: GufQGJ_UN3Oqtb4OX0R0Ng-1
X-Mimecast-MFC-AGG-ID: GufQGJ_UN3Oqtb4OX0R0Ng_1767865183
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47a97b719ccso19034395e9.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 01:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767865183; x=1768469983; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XojOHjApRsfRYlwZkVcmTgQKGqR9C5oon1RD5/J1iVg=;
 b=BXdvZh/42UKd7mURjKj2aPjU1ksyfzEpxuVJj0NRNTSwfC2+66W1+wlfVHW4bJZwb3
 TmR43Dq65RbcHxjyJlMRcJnd/gueBw1bDtKHQO2NmXFakxoNgtE6pgiyikyo+LY//Sbo
 kHCTLUT+fEN+40YMSCIK0kL5XusoDq9dqVq5H2FGNuZIhU4omqWaEFH/7WkYXoHg6KKo
 v0wcfGtgPLGRl6U2JhN1gH5jrxgZPJkzELDcxckQ6UPtega1kiJcgzlp9iztOs6dc8rD
 4bTve8tTDh5BtdOctWTe0SSAsxCMrbdVu8L4Sn+YEnI0SfS8aH3c5BnAsYZe23sAqRCo
 e1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767865183; x=1768469983;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XojOHjApRsfRYlwZkVcmTgQKGqR9C5oon1RD5/J1iVg=;
 b=xLHJlmqzwpu787ldLNnlMyj4qDL8hed0adtIcPzTEQ/7k6dfXoMQqfPD0XOH0FWmZA
 7tcxktfl//PYARIeZYjuOHF8e0DJbDjJpm4So0ESw2PNgtLczRWF3BhHGFbt+yZZYz12
 fz5y5qKQMmMslQJYFIxaLg/Xr6yk2IhXI4xsssQbc01rcSHiP3V13NMJ5fs3DFB2b8Ws
 vB1aAy6w9751aD7FruMkhjfLg57K3srt8ZrdEN6j8JrNq1VAts3eWtCz35ryDpetwhid
 oa5LFkP5MdT4HfaAmC/6Ix04CyHwEngH7f0Bvz1lodSRHdA8UJqCjDi8ZZqDZ01VLLEu
 uAXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvY/7q+DArj6zDiwb4BLOFwK/cfulpxCxf0+nIT+neCHuwew5ArYRyjv0A87wtQVq05ByIQH16+5Kj@nongnu.org
X-Gm-Message-State: AOJu0YyK1lTVa0o5AuKb6Hwn4v+Lz8CO7ADCI5XJ/Y1pJpwJYfvQOik4
 dSittYr26S7TZcv2zPwcY2xdyWIRS27cT36M4nVcQYLBEpf01wLBRaGojF8GR5bemZCgiLC/WjD
 2QPZherL8rsUgfOMGC4iSiR0EahAA7ygI9Oz+/0iwkFfrk4rDJdGhhjG5UKI4axMP
X-Gm-Gg: AY/fxX7bKEYfenyimg9unJU1BPV6o2fqvxa39fN34jzCb5FCuBHSwTynFeC+7bKJ81J
 6ZXZQJnx9B9fDKd2R9NpdUSzF96U8chJU4bYk1xsSTrdbIVukZoLDTyBpRY61hzY8noq6tsf69Z
 ZgALa6JJdTfesXTUEi9uPq3Vx8fclyNHkjmq2Ig3U0CHW9N0BW7lpb3DlPB70qfVGQAWDJdm0zM
 xyH20L7gf+violqnekhRqF9VQBCHOM7zTj+PxEYXoSMwLtaMtimSwkNerWhrg64iRroxwWqNDMW
 KCGMb++483fGtTm0u37d0VhDR9d4lIfjG2uEfq9U1OysS9XLBtQ/4x99aVntl60gGiy14/l2fjy
 29vQnURI=
X-Received: by 2002:a05:600c:1385:b0:47d:4fbe:e6d2 with SMTP id
 5b1f17b1804b1-47d84b2cd6dmr63273605e9.12.1767865183102; 
 Thu, 08 Jan 2026 01:39:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3rpLJnmbl3h53Ie/uKJOaBhMM3jWFdC3oUlwaa6rwBCh1PYymh4RpvVHGi8q5hbcmNVig/Q==
X-Received: by 2002:a05:600c:1385:b0:47d:4fbe:e6d2 with SMTP id
 5b1f17b1804b1-47d84b2cd6dmr63273405e9.12.1767865182706; 
 Thu, 08 Jan 2026 01:39:42 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8662ffaasm33570355e9.6.2026.01.08.01.39.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 01:39:42 -0800 (PST)
Message-ID: <d95362b1-081c-46e6-9669-c02638a2fa25@redhat.com>
Date: Thu, 8 Jan 2026 10:39:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/50] *: Remove arm host support
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-4-richard.henderson@linaro.org>
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
In-Reply-To: <20260108053018.626690-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 08/01/2026 06.29, Richard Henderson wrote:
> Remove tcg/arm.
> Remove instances of __arm__, except from tests and imported headers.
> Remove arm from supported_cpus.
> Remove linux-user/include/host/arm.
> Remove common-user/host/arm.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/osdep.h                      |    2 +-
>   linux-user/include/host/arm/host-signal.h |   43 -
>   tcg/arm/tcg-target-con-set.h              |   47 -
>   tcg/arm/tcg-target-con-str.h              |   26 -
>   tcg/arm/tcg-target-has.h                  |   73 -
>   tcg/arm/tcg-target-mo.h                   |   13 -
>   tcg/arm/tcg-target-reg-bits.h             |   12 -
>   tcg/arm/tcg-target.h                      |   73 -
>   disas/disas-host.c                        |    3 -
>   hw/virtio/virtio-mem.c                    |    2 +-
>   linux-user/mmap.c                         |    2 +-
>   MAINTAINERS                               |    6 -
>   common-user/host/arm/safe-syscall.inc.S   |  108 -
>   configure                                 |    7 -
>   meson.build                               |    7 +-
>   tcg/arm/tcg-target-opc.h.inc              |   16 -
>   tcg/arm/tcg-target.c.inc                  | 3489 ---------------------
>   17 files changed, 5 insertions(+), 3924 deletions(-)
>   delete mode 100644 linux-user/include/host/arm/host-signal.h
>   delete mode 100644 tcg/arm/tcg-target-con-set.h
>   delete mode 100644 tcg/arm/tcg-target-con-str.h
>   delete mode 100644 tcg/arm/tcg-target-has.h
>   delete mode 100644 tcg/arm/tcg-target-mo.h
>   delete mode 100644 tcg/arm/tcg-target-reg-bits.h
>   delete mode 100644 tcg/arm/tcg-target.h
>   delete mode 100644 common-user/host/arm/safe-syscall.inc.S
>   delete mode 100644 tcg/arm/tcg-target-opc.h.inc
>   delete mode 100644 tcg/arm/tcg-target.c.inc

Reviewed-by: Thomas Huth <thuth@redhat.com>


