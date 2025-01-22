Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0413AC02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 06:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taUBf-0000ii-A0; Wed, 22 Jan 2025 01:26:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taUBW-0000iA-DH
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 01:25:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taUBU-0004Wp-Jt
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 01:25:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737527150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mveUcbZs+xP2e8cYxAErRLXdbthtLZNnoGJIC07D4zg=;
 b=Lkcmo43wBnCkfeDJ0B6pzLluMBOawAgB97yoRr9MBSOkl53ciYdJhQgLzoLyzyrqSVG4ma
 /ASb+eODjVUxkdZ0HuxecEkPlGVEC/lPKQ3MHLqnv1RTZpbAjvFfeT5egbXGmCkzD2Skk5
 +rafjQgLc76gijsUSoaf+bcn7tUJmPc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-85JY5bWaMv6-wYfri1HOag-1; Wed, 22 Jan 2025 01:25:45 -0500
X-MC-Unique: 85JY5bWaMv6-wYfri1HOag-1
X-Mimecast-MFC-AGG-ID: 85JY5bWaMv6-wYfri1HOag
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa67fcbb549so717629266b.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 22:25:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737527144; x=1738131944;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mveUcbZs+xP2e8cYxAErRLXdbthtLZNnoGJIC07D4zg=;
 b=cVsf92zh2FxV59JmeX38a8+Syr+Uh8mBXyXax2sPj4OGgmpSjo/5IpGBkrrTYbeBH3
 CHvy+sl5xnDI9nljAiGUJ519KikF0Wdrt2QFEM+VCew6xPE8aD0LPWrQ+PuJ1UtXeFjH
 4XjUHyBtt1F76aSyhmmfz+IcG0DvmhELpNUxzbW40QHtnNjVv+bK2I7ribOnKA2iEtBP
 NOquBR/sM1XepVGEpx/Hu9ovnmTID41A4tHg/JzPB11W2fgUUXHKCk6uKKfDYj0Ht1Rf
 WDAVgkMJ957qT/qOESIGuhU8a0VjW8lBEdAvhEOUL3ZXFab51RG6dsUyKTMLePRa097w
 gN6Q==
X-Gm-Message-State: AOJu0YyUvaE9O6BQ2gocuv+FYJJBXpY58JDXa4c5KsVEce5MIJSnnIOv
 e2AyqVHE8TAfaXqFe8ISvfqar3bqyXfKiwH/9IujYgu6sEvMqOuPKLd5/qGc3xGtBYBMkvTH76g
 m8+t0NFxi1b7plF5pu0E0+x6jtwcSmX04Oru51rv/eaovZRj7CeuZtc1z3Eu4
X-Gm-Gg: ASbGncv7sv48j+QYfj59Z7xVxe06bAUKmfM4vTmvR3pvfObUwEoIpLw+Z2+D6r4CMxw
 SHk7TQyrFZyHeMdJgMv3KEgyG4iSfWruCrcxrWbBBbZaZnJzvygPwn8AkjLUbm9qR/N1gKPGg4M
 39lRVB2mz6BIrz6AWI+wVxuqxUw+SVGXiTrESDcj2h0pOY/qvrM0gbrVw38nKIT6a/FVpdDaGTZ
 fyFg695BXeeE8Xsb+dLu3yN52Cp+aPhT5ka63MTzLZaPqbav/SpXVvCPSIFad6w9C7xuGF2TwFb
 3HvF/hZDa/JmZ6LQiBMLt9VIXw==
X-Received: by 2002:a17:907:7f9f:b0:aab:d8de:217e with SMTP id
 a640c23a62f3a-ab38b163550mr1894754066b.26.1737527144399; 
 Tue, 21 Jan 2025 22:25:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiyAntG+OMYsA4IjrDN+6eRkKyol2hm9zhwKvwzO1LAnF7zDCfrckknYdia40qCOVXdzunPg==
X-Received: by 2002:a17:907:7f9f:b0:aab:d8de:217e with SMTP id
 a640c23a62f3a-ab38b163550mr1894752966b.26.1737527143983; 
 Tue, 21 Jan 2025 22:25:43 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-103.web.vodafone.de.
 [109.42.48.103]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f2ab60sm860292866b.99.2025.01.21.22.25.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 22:25:43 -0800 (PST)
Message-ID: <5aadb293-f9b8-485c-a71a-196f6834024a@redhat.com>
Date: Wed, 22 Jan 2025 07:25:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] s390x and test patches 2025-01-21
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
References: <20250121105613.1286672-1-thuth@redhat.com>
 <CAJSP0QXSckBRdx_K4Sg92D9uyZ7jrF_Owry9WhmKOt6B_jF9Uw@mail.gmail.com>
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
In-Reply-To: <CAJSP0QXSckBRdx_K4Sg92D9uyZ7jrF_Owry9WhmKOt6B_jF9Uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 22/01/2025 01.27, Stefan Hajnoczi wrote:
> Hi Thomas,
> Please take a look at these CI failures:
> https://gitlab.com/qemu-project/qemu/-/jobs/8913471007
> https://gitlab.com/qemu-project/qemu/-/jobs/8913471508
> https://gitlab.com/qemu-project/qemu/-/jobs/8913472011

Ah, thanks, nice catch, unlike the gitlab shared runners, these runners 
obviously have an older version of KVM enabled and thus ran into an error 
path that should skip the test - I need to replace cancel() with skipTest() 
here. I'll fix it up and send a v2...

  Thomas


