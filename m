Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A675AD75E59
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 14:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEUkU-0004hx-Nw; Fri, 22 Nov 2024 09:35:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tEUkS-0004ge-Vh
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 09:35:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tEUkQ-0007Qr-Pt
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 09:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732286098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SqJEYzNmzB9FPM1BNofRXj1rutk/NFkNcI7ZyZ0kwUI=;
 b=OaW8srw+WyiOl4nUHnkH/bajn1GCRZihLdxWa8OE++dSdUboqKw7x20YYC6jT82vxDrjfq
 l4MSdn/T0Dt2AgRK4pG/p6k9JN2N6tFtuvJtvLUi0AnbwtnddFN+LRQfJ8M/QbAcMPk+Up
 Ni2cxz3sPfWy2iH/emlAeWzRZ237KPY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-M35WoWy3MCyyuQNYn685Wg-1; Fri, 22 Nov 2024 09:34:55 -0500
X-MC-Unique: M35WoWy3MCyyuQNYn685Wg-1
X-Mimecast-MFC-AGG-ID: M35WoWy3MCyyuQNYn685Wg
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315c1b5befso14819775e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 06:34:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732286094; x=1732890894;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SqJEYzNmzB9FPM1BNofRXj1rutk/NFkNcI7ZyZ0kwUI=;
 b=MgYovm/wukmA+C+PAzlaDdQ48hp7sBK9pYeWk1Mpfd8QknJX/AtX7U8g+HCehVvK/2
 7OSRArWuNCDqTT//e43UC+H+73qSwtsAcqpbkXozo8m1Xxjone1CMEr/MvMUNzjXMylE
 hHmQqFzpgCQwstVesA0E4QKL9G/9RuOPyMaLK3yNa3Inl89B98HqpoFLrfFIegCusPba
 mmNzepJOof63mjcu5HGM9ueqWqQUePKYvIrUUemX9PfUr6tuHCknX/3yYDCYMVnXNxWg
 wZLK8f4hWzct8NEI/Vd+yes5AWr2AdE6HoSeVDSAkSc3JIoq2MWiVKVYefGbCI0T2fJW
 Z/Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrGEFOfOI2i0HNr0OfBG0z5tAqM7VNrjTaGncuJhYBIiiF6BkFqeCukjQsx60QTUX4+CgrUmwFCNWM@nongnu.org
X-Gm-Message-State: AOJu0Yxo3G6XLJhxCrtG3kBAry/ky0MWOhmeUjA8iQts92iOF5kQ+/ET
 CZLKvuacQ58zcyxPx9AqUMIx3ss4LxT1KE+y5UG95Cx9Yn13ilnCVb2hywJpuPLl2E6MignlQz9
 RmjPitET+HQSY+9O6e/HWtozlLDdG16By1VVcD8Z3dUQjlSFnKpWI
X-Gm-Gg: ASbGncsrgQKN1e1LChcdXUlrjH9UWv3WIqsmUegjxDxXYCiI/+9VsRNvavfG7Vbb1Tp
 ypmLkMgLAxJ4z5cRhjOr6JgxOVr/EiaI+OMO3yb54yxrT5nzrKwCrufnmbcATVzvIU063G/rBab
 Hf+tsE+MxpdQZUBG3wwOw+zYNNjACDLTXN7GCcUQnvzybDuyWWDPmoj5yRWHLD03zaPXPnVnKca
 D6yREE0zBrfS+UsoqLUbJEf3ZrfYLwwC9wIZVmQbTK4OYbZET9Xpkq+e+o4RH0B+bW6IqP/MDw=
X-Received: by 2002:a05:600c:1d22:b0:431:3bf9:3ebb with SMTP id
 5b1f17b1804b1-433ce4c1f63mr26556145e9.24.1732286093096; 
 Fri, 22 Nov 2024 06:34:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5+aE07eQMIBGe/YgfS8kK0qBIJvBPUp20OOEmeJtbcq69fb3QTkTZwEr1gPrh0hq+K8mkdQ==
X-Received: by 2002:a05:600c:1d22:b0:431:3bf9:3ebb with SMTP id
 5b1f17b1804b1-433ce4c1f63mr26555165e9.24.1732286091306; 
 Fri, 22 Nov 2024 06:34:51 -0800 (PST)
Received: from [10.33.192.206] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45bd7d7sm95301365e9.13.2024.11.22.06.34.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 06:34:50 -0800 (PST)
Message-ID: <b8b312bc-c68d-4866-92c3-b4803a3e6e31@redhat.com>
Date: Fri, 22 Nov 2024 15:34:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: Remove sleep workarounds from sh4
 test
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20241122141827.2039984-1-clg@redhat.com>
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
In-Reply-To: <20241122141827.2039984-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 22/11/2024 15.18, Cédric Le Goater wrote:
> These were introduced in the avocado tests to workaround read issues
> when interacting with console. They are no longer necessary and we can
> use the expected login string instead.
> 
> Test always passes now. Remove skipUnless test on QEMU_TEST_FLAKY_TESTS.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/functional/test_sh4_tuxrun.py | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/functional/test_sh4_tuxrun.py b/tests/functional/test_sh4_tuxrun.py
> index 352cb360ef74..b33533fc7e7b 100755
> --- a/tests/functional/test_sh4_tuxrun.py
> +++ b/tests/functional/test_sh4_tuxrun.py
> @@ -15,7 +15,7 @@
>   import time
>   
>   from unittest import skipUnless
> -from qemu_test import Asset, exec_command_and_wait_for_pattern, exec_command
> +from qemu_test import Asset, exec_command_and_wait_for_pattern
>   from qemu_test.tuxruntest import TuxRunBaselineTest
>   
>   class TuxRunSh4Test(TuxRunBaselineTest):
> @@ -27,8 +27,6 @@ class TuxRunSh4Test(TuxRunBaselineTest):
>           'https://storage.tuxboot.com/20230331/sh4/rootfs.ext4.zst',
>           '3592a7a3d5a641e8b9821449e77bc43c9904a56c30d45da0694349cfd86743fd')
>   
> -    # Note: some segfaults caused by unaligned userspace access
> -    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable')
>       def test_sh4(self):
>           self.set_machine('r2d')
>           self.cpu='sh7785'
> @@ -46,10 +44,8 @@ def test_sh4(self):
>                            console_index=1)
>           self.vm.launch()
>   
> -        self.wait_for_console_pattern("Welcome to TuxTest")
> -        time.sleep(0.1)
> -        exec_command(self, 'root')
> -        time.sleep(0.1)
> +        self.wait_for_console_pattern("tuxtest login:")
> +        exec_command_and_wait_for_pattern(self, 'root', 'root@tuxtest:~#')
>           exec_command_and_wait_for_pattern(self, 'halt',
>                                             "reboot: System halted")
>   

Thanks for taking care of it!
Reviewed-by: Thomas Huth <thuth@redhat.com>


