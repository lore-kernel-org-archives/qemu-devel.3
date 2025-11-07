Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA352CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 07:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHH6Z-0006ny-TL; Fri, 07 Nov 2025 02:41:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vHH6W-0006mo-Mm
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 02:41:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vHH6U-0002dM-1K
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 02:41:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762501307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eYaTNPftnqRwGBqW4bzktRKdVKSxJpsDIArFa9YOrug=;
 b=bd6BAfWkqYDCG+eHguqs3JriwqDLlKLgiQU+SsZFhW2S/+tCK0job2Rz+x8yhVh6VIIt+4
 ZWlGu/JeX+DO+xVNpk4CouJ+wR9Ou6jz2RKTNyV0aJk2IqX7hUrGF/Cq9vkYabfDmyWZjI
 7r2WDEzKHoK9p/IohCnO63neLzGBn5I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-iA1m5bypM8qRJ0UVhqpJ2w-1; Fri, 07 Nov 2025 02:41:46 -0500
X-MC-Unique: iA1m5bypM8qRJ0UVhqpJ2w-1
X-Mimecast-MFC-AGG-ID: iA1m5bypM8qRJ0UVhqpJ2w_1762501305
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-475dabb63f2so1909795e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 23:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762501305; x=1763106105; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=eYaTNPftnqRwGBqW4bzktRKdVKSxJpsDIArFa9YOrug=;
 b=kXLlqBMbeSGe9kJA2f/A3OUvje2LcJZDDhAhy7exp68M/jWexyilBI4x5mb9eS+dMO
 twodM2q9Cr88oE+nSDNrvyl8MVtiaVZWp+L1dIebKpydwAHVtzGc3/juvcMqZW9/AT+d
 ua2htGWFidg5dnFGPGfA1dmX25aUkNN+hWHDbxnHBeffm7vVon1N9PO6saa0I4k6ivvF
 1pS7UWcM+HsnepOx+QygbgssPM7ARpOGp/WHbPOSkuGGZso8OiANwoXtrJ1zpacAMBmy
 IfqsobxYEUc90EdpXwvBbkO2QuXTApVGYxom9d1ickLrzDYQzwDsnMiCQXYrkm7RMFNm
 9Y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762501305; x=1763106105;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eYaTNPftnqRwGBqW4bzktRKdVKSxJpsDIArFa9YOrug=;
 b=J7wyMubs0x03YmUmTunFOPCuImNv1lnStgSLzTwKI0wLD3jPSe22NZFwKUiLwr0ddB
 xgTFTYbIBezchpVrO4nvIFWYyljMYcFUytL3FwPjIltUE2rwKCPLU82/BZE2dDnAiiKa
 SwzZdvb93FCGYwUE5qJ1iLn5miFty29kuINnTnaf3FefAIlYscp1cCl25IXGiROJv/Z+
 v0nXLrJYTtFbTT9lX54tx2+uxU2ZvKK/E+Ffyhfqvyi0unvOro/0q8psllpu+aihoH3Y
 bdiVFZ0pEHCJVAkzyExG/M/mxCO9+Z0rLF0OQU4OegnpAWcHbRh5t2nqjztXlN6bYxOe
 4t+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi0qBArHIZNau1W5xD6bg0D55sc4FcANzi2zGXiG+1rJJhnHKKoyV5OHsM4pJvofHvUQhYgdKeNIJm@nongnu.org
X-Gm-Message-State: AOJu0YzKeth7LdXpykL0Pc/4DZ6CEsYQA4nMNnSFQeHu++9gxgJpmV+t
 E5AkkE60a2MBnL0DqhV2n2tvs+CTmeJU+r9YD0wU1Mq/oHM/aY4aYjfR/QkcNOfvMdxMchDG9xI
 8crJgR/leHrmHKpnjLATbXuFDd02p3Se5ArLrUrQfbfOxATO/beyev9k51PkKQH+T
X-Gm-Gg: ASbGncv3Wh3NeoV4UmLoACTvYi0Os5ftRp0szyu9E/fI6pmuRWSC4zgUWLhFhs47LKP
 2GBaPLdHw7BXk7P+hFTksT/vld8wkzgY2fcbc6E5LiqVuJN1DUJ8INOr62dao5f62ghK1Zu18/A
 qgDevJGPxiyh+krRTEuDzoe4dugcKgMgq6o7cMWEZSQlCdWQfxlyUY76+qumMgXrNqhWVIMxqd9
 lWCMnIHVu0SZdm/BHgBJhUgajh6OZwCgUOWPRMOpH3oQ9ddLHyh55eVgNtSWr/0dvyx022dmWXC
 QyAe6L8D77GFqfsngC2MR02FNihPTySUMddV4FsS7YbpZiS4LQlC7cW5mXvl43Rim/WCYOjk
X-Received: by 2002:a05:600c:354c:b0:46e:37fc:def0 with SMTP id
 5b1f17b1804b1-4776bcba3e5mr14268295e9.9.1762501304888; 
 Thu, 06 Nov 2025 23:41:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/h6LZouWCehGqAdzNIwwy5sv/7SIfQwWxezhYnrqwLenp9x24gfrktXmp9CSq2fiT9lUT2A==
X-Received: by 2002:a05:600c:354c:b0:46e:37fc:def0 with SMTP id
 5b1f17b1804b1-4776bcba3e5mr14268115e9.9.1762501304516; 
 Thu, 06 Nov 2025 23:41:44 -0800 (PST)
Received: from [192.168.0.7] ([47.64.114.171])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4776bd08834sm32571895e9.15.2025.11.06.23.41.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 23:41:44 -0800 (PST)
Message-ID: <185927c2-9386-4935-8bfb-64eeb87f06a7@redhat.com>
Date: Fri, 7 Nov 2025 08:41:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression with the "replay" test on target alpha
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
 <20251028173430.2180057-4-pbonzini@redhat.com>
 <cb41dc20-5a87-42b6-8819-08f5a1ee4303@redhat.com>
 <ebb0ac51-fbf0-4f93-8a9b-12880d2a0126@rsg.ci.i.u-tokyo.ac.jp>
 <30a9e854-e37b-4494-b372-f76ce6bdce25@redhat.com>
 <d9db8f08-f207-45b4-9637-9f13a04ab606@rsg.ci.i.u-tokyo.ac.jp>
 <81072e45-182f-419a-a44e-fca22ed54167@redhat.com>
 <d4921688-b3b3-45f2-a3c9-dee2977750cd@redhat.com>
 <889e6be6-0cef-4a23-9d57-2e0611f9588a@rsg.ci.i.u-tokyo.ac.jp>
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
In-Reply-To: <889e6be6-0cef-4a23-9d57-2e0611f9588a@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 05/11/2025 07.29, Akihiko Odaki wrote:
> On 2025/11/04 21:18, Paolo Bonzini wrote:
>> On 11/4/25 09:38, Thomas Huth wrote:
>>> Thread 4 (Thread 0x7f31bd1ff6c0 (LWP 89223) "qemu-system-alp"):
>>> #0  0x00007f31c47150cd in syscall () at /lib64/libc.so.6
>>> #1  0x00005593dd2b578d in qemu_futex_wait (f=0x5593ddad9e50 
>>> <rcu_call_ready_event>, val=4294967295) at /home/thuth/devel/qemu/ 
>>> include/qemu/futex.h:47
>>> #2  0x00005593dd2b59a1 in qemu_event_wait (ev=0x5593ddad9e50 
>>> <rcu_call_ready_event>) at ../../home/thuth/devel/qemu/util/event.c:162
>>> #3  0x00005593dd2c12e3 in call_rcu_thread (opaque=0x0) at ../../home/ 
>>> thuth/devel/qemu/util/rcu.c:304
>>
>> The RCU thread is simply waiting.
>>
>>> Thread 3 (Thread 0x7f31bc8fd6c0 (LWP 89224) "qemu-system-alp"):
>>> #0  0x00007f31c469c462 in __syscall_cancel_arch () at /lib64/libc.so.6
>>> #1  0x00007f31c469075c in __internal_syscall_cancel () at /lib64/ libc.so.6
>>> #2  0x00007f31c46907a4 in __syscall_cancel () at /lib64/libc.so.6
>>> #3  0x00007f31c470a7c6 in ppoll () at /lib64/libc.so.6
>>> #4  0x00007f31c6916890 in g_main_context_iterate_unlocked.isra () at / 
>>> lib64/libglib-2.0.so.0
>>> #5  0x00007f31c6916a4f in g_main_loop_run () at /lib64/libglib-2.0.so.0
>>> #6  0x00005593dd0d1ab0 in iothread_run (opaque=0x559405a567a0) at ../../ 
>>> home/thuth/devel/qemu/iothread.c:70
>>> #7  0x00005593dd2b3311 in qemu_thread_start (args=0x559405a571a0) 
>>> at ../../home/thuth/devel/qemu/util/qemu-thread-posix.c:393
>>> #8  0x00007f31c4693f54 in start_thread () at /lib64/libc.so.6
>>> #9  0x00007f31c471732c in __clone3 () at /lib64/libc.so.6
>>
>> This iothread is doing nothing.
>>
>>> Thread 2 (Thread 0x7f3137fff6c0 (LWP 89225) "qemu-system-alp"):
>>> #0  0x00007f31c469c462 in __syscall_cancel_arch () at /lib64/libc.so.6
>>> #1  0x00007f31c469075c in __internal_syscall_cancel () at /lib64/ libc.so.6
>>> #2  0x00007f31c46907a4 in __syscall_cancel () at /lib64/libc.so.6
>>> #3  0x00007f31c470b2be in write () at /lib64/libc.so.6
>>> #4  0x00005593dd2af441 in event_notifier_set (e=0x559405a56a54) at ../../ 
>>> home/thuth/devel/qemu/util/event_notifier-posix.c:117
>>> #5  0x00005593dd2cdcde in aio_notify (ctx=0x559405a56980) at ../../ home/ 
>>> thuth/devel/qemu/util/async.c:506
>> In this backtrace the CPU is waking up the main loop (thread 1), but the 
>> main loop is running so I don't think it's really a deadlock.  It's more 
>> likely that the replay is not matching the record, or there's a similar 
>> reason why the replay is not proceeding.
> 
> I agree. It is more likely that debugging the replay code instead of the RCU 
> change will lead to the real cause.

This now also impacts the Gitlab-CI :

  https://gitlab.com/qemu-project/qemu/-/jobs/11984309870

How do we tackle this? It feels bad that we have such a subtle problem at 
the beginning of the freeze period. Shall we revert the RCU patch 'til the 
problem is understood?

  Thomas


