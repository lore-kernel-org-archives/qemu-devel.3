Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889C4E937E4
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 12:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBuAN-0007mb-1J; Sun, 12 Apr 2026 08:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wBuA4-0007l5-Hh
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 08:43:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wBuA1-0004g6-Ac
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 08:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775997810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
 bh=t2TuB0xjQPcx3cB6P7qeUy1BqhMMM1ezdA1+xi2yrgM=;
 b=WE7xnv1ZikfDPfERa8yGUhciV/l20YPO3Kz01sXSA2Qfa8H2ZL2Ds7YV05RLaXLrwJF8ck
 lujM5GnPzGwRf8kLZLG2pu8/vpZEMRF+8b7fM2mL/hbr1ZIvKxgK4pJKQcD85B68RKbLKL
 7Uql1lURYgOM+ciuDks3ddfsJCrvnZI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-4ls7hPsWO1q6DLMpPO14dA-1; Sun, 12 Apr 2026 08:43:29 -0400
X-MC-Unique: 4ls7hPsWO1q6DLMpPO14dA-1
X-Mimecast-MFC-AGG-ID: 4ls7hPsWO1q6DLMpPO14dA_1775997808
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48378df3469so23827025e9.1
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 05:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775997808; x=1776602608; darn=nongnu.org;
 h=content-transfer-encoding:autocrypt:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t2TuB0xjQPcx3cB6P7qeUy1BqhMMM1ezdA1+xi2yrgM=;
 b=LjmrfXocQQlj6OXhJOWNj46F2+ov1rGlSkDjV/BnPvLskSgkHVZ+ZJlOg3N56eZzKg
 +8aL1LQqhErdR8phc9Aa1Lk1sk853q0qWV5qX8VyJlv73xqxEj+qZQQgd16ohpVGSf3Q
 M4IqJ5l9JHJu6Ocpt5GVdCTJ7mjx1dhWC1ZN4P5UOXADh5l0yh9hiIbkqnonacMxFOVx
 vQ4Yrw3JLSBl4uiq9SIver4WT8Vm5spY4IrHJIAaoe5ssW02kV6TydFCLKuxE1kwXUIY
 1eDxRqQPYnJw10G2OVnklZU9D2vTTlEldVra7vysA2pBve3rIRy31o151gL80dE9fG90
 p38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775997808; x=1776602608;
 h=content-transfer-encoding:autocrypt:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t2TuB0xjQPcx3cB6P7qeUy1BqhMMM1ezdA1+xi2yrgM=;
 b=gnRDGn5hwl09BE2o8ubhJ06ENAs5ICq5BwD2uqcBRmF823P/6Vn6PtTU530zB1nHWS
 S6U6i6WIimdvskKDt2pwJpyq2lyDeESl0XRMpLJjjlfwDOZj/UsMl0wFazDxtyfnzWBB
 6GN4Xgotpea5Eq7Fk4QBrg+QNJwEXdlIv5e3VG2Sjau2Jx3z0IRJfsZTvdw+afTEacZP
 bcknAd8hk7dG+0vXdzPll6peT4//FdyRbLNmfKCld8/cbXNVYD8LAwxce2SxOBIByFo9
 DKoDe4nsMfY3tM3XpjaRcvvI0wonlQDdDZCP5DiUxv/GhnMooQOAUVu7CxK+xd+hV4wc
 74Sg==
X-Gm-Message-State: AOJu0YxZ3j4XRWm3xX0n8vt7/hisw8Tg0Zc79Ea497mwGaKei+5WBOjq
 2jqAzlSOaFWe0rSonZB1ZDQZncx2cfBhVTjOXLrVRT5bS2vxC8/f7zuPV3E+3jnrDQxpioilS5U
 ht+m+O/JxVqWJYqlb1oBgDEEL+j3CnOuueQnZoJxKJlzVZoAwNXgHOdEFiRwp8pnHVk9boxgjmR
 IsXhCO7XAPBv800vGYcDBt2XroxWbE5j4yUNVe
X-Gm-Gg: AeBDieu49BTb1i7/thOQ7cvbHjpgDdxfjcp1nGBJ/lp1lLasYdaTjj6ZrxaF6RCWZuk
 KB424GhLuvHqQnhBBkHj7M41kjl5lXn2XWC/p7bLY87RJBWPrWVlVnxATsKI8U+4X8LLprYjHcG
 BjZfTYX4Xu1Yf835ae4TiRKMTRSwr0fLkk5Zta8mPzOanbpK9LqEbkRqsghcIFoVso5P3ZiylmR
 JCoQb90yBeaViYgcVaMqWrkX1PvwEGtlYBLYFnpLvK9wJoubVY316RVLbZia8qHNB23DOi/USre
 DwzQA9AxE1FKdTeQ2hA2jtBgQF/M4WMAkYNipQ748cYRKejvdxNKq7nADDojp+7IYEZuuNAyPoE
 uLco834vUa7TRhZKlGQ==
X-Received: by 2002:a05:600c:4ecb:b0:485:3cef:d6ea with SMTP id
 5b1f17b1804b1-488dc76d45amr94369725e9.13.1775997807813; 
 Sun, 12 Apr 2026 05:43:27 -0700 (PDT)
X-Received: by 2002:a05:600c:4ecb:b0:485:3cef:d6ea with SMTP id
 5b1f17b1804b1-488dc76d45amr94369365e9.13.1775997807377; 
 Sun, 12 Apr 2026 05:43:27 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d67b128dsm114163505e9.2.2026.04.12.05.43.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 05:43:26 -0700 (PDT)
Message-ID: <b8a73eb5-aa21-481b-9120-aa6277492b26@redhat.com>
Date: Sun, 12 Apr 2026 14:43:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Cirrus CI about to shut down
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


  Hi,

according to https://cirruslabs.org/ :

  Cirrus CI will shut down effective Monday, June 1, 2026.

I guess that means we have to find an alternative for doing the builds on 
macOS and FreeBSD?

  Thomas


