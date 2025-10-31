Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B682CCF9FF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEn7s-0001KD-KT; Fri, 31 Oct 2025 07:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEn7g-0001IO-MG
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEn7V-0006q5-Ck
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761909379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lxdolFDsTujvT9LT6E5LiK49G0YH+Xsi6x2bzoXKkxs=;
 b=CnXgi/wq9xuwrnUVG3czNMEQHW/5v688vTUTdmSxiCSsQqZSRw+AJoLeAV0ei7U0YdmcST
 kDndzx5hT3DAywZETOHk6GB9FZDrn5lDFiJJToP0MZt/T3MaxGKiUB0cZ8j1/dJiavA4LA
 2MuaQy2KH5ma8M2GoVM8k8QpQtyDL+I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-pr2l-3_aOniYBIaUzOWc2w-1; Fri, 31 Oct 2025 07:16:17 -0400
X-MC-Unique: pr2l-3_aOniYBIaUzOWc2w-1
X-Mimecast-MFC-AGG-ID: pr2l-3_aOniYBIaUzOWc2w_1761909377
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4284525aecbso1416942f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 04:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761909376; x=1762514176;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lxdolFDsTujvT9LT6E5LiK49G0YH+Xsi6x2bzoXKkxs=;
 b=CPIkL5KLXnIYT7fYIww/WBaGSBeSfAxWDle9NvetyCqLE+iedB76JfXNSP3ep5nZsM
 njiezK/nUkwTAU4JBClkhEHSvNbj7Ozxn8kTgP8hwFtcVMrhafbE4aX6B7nKuBcTN6je
 giO+trdkUkmziJxJFh2Gu0GPUsZSdU4qDEDuJzAW/TumT9hIfy2IhXRfYnxLLBATV/I1
 eNAFuobZX9Tutl7pxiM7DAAmCXLfZCHnpj3Md7H4tEyOew7/Z5j2mE9OXl7+C/HK+eG+
 xKoFvSRVmzlbF3G/+2Sm5VR3HT9B/GGuXgauzEDMvUjW5EmQWxhiB8dbhWQwPvS9Jd0E
 tPFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFN496ERtd2+k8dnfiknzU12GEXwdu2/bhfJp+uFbX9s6C8qJ/ttn//EdUrMlfb15uuOhKyBscNAAX@nongnu.org
X-Gm-Message-State: AOJu0YxtYDdQHmONez8JRYJig6MvfQn7jpN4OQe4pVSjZGJB0hnHi4Ou
 We5gPA6UmXXG8+K6dssynVbAmkXlqm9HyXU70gY0ISIH043o6Hk9Nkeb/l0QiKW9OUzglSBhQMc
 6CNtK/EFQc+Osx5uIryUe0pyDJ5SMJeHdjv8QnqNQYZmAOu1YO6WvIfGa
X-Gm-Gg: ASbGncvJzBSOohJapBh2Z0mpb8Se8teEF7MnmUe9H8f5dYUAvaL1n02qGissDdIh+Bf
 WIWTY4QXkzGZ76kURKNa3YnrH0FHHrDrZKdvjVtBzqisA9niNkry2b1ItHLRpzE2WncyX2MhBQn
 jj8rzWErsMOCMS7nBdTvHAH/PDh4zCBj+hqihfbNrQZdEq9J6KfffHLsKpIh2j7V8m0IkFOfQL4
 io1kKpVXCZTDqSSz57n6saU34zqztzbtFepk+ZggUEjIqqxrb55cf779ctwDq+UgcKw9ptDyfP+
 a1Pp9e1t5zfXgG+CVRxu/XWb5QorqEDBW92RSTVDVHKnNVn3imDh9fLQxqy+fM5BeK8MT8s=
X-Received: by 2002:a05:6000:240c:b0:427:72d1:e3b1 with SMTP id
 ffacd0b85a97d-429bd6addcfmr2447016f8f.41.1761909376519; 
 Fri, 31 Oct 2025 04:16:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkShtkRdd+TvcG80lTxtF+QNii/k5RRKWpMl8UrZkwrRiv7qf43uFnnL5caH10BWLtbvwazg==
X-Received: by 2002:a05:6000:240c:b0:427:72d1:e3b1 with SMTP id
 ffacd0b85a97d-429bd6addcfmr2446986f8f.41.1761909376098; 
 Fri, 31 Oct 2025 04:16:16 -0700 (PDT)
Received: from [192.168.0.7] ([47.64.112.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c13f3278sm2990127f8f.42.2025.10.31.04.16.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 04:16:15 -0700 (PDT)
Message-ID: <35c01798-adeb-4f40-9667-cd223810b52b@redhat.com>
Date: Fri, 31 Oct 2025 12:16:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tests/functional: Mark the MIPS replay tests as flaky
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20251031094118.28440-1-philmd@linaro.org>
 <20251031094118.28440-2-philmd@linaro.org>
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
In-Reply-To: <20251031094118.28440-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 31/10/2025 10.41, Philippe Mathieu-Daudé wrote:
> MIPS test_replay.py often times out (likely hang) under GitLab CI:
> 
>    2/21 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64el-replay   TIMEOUT   180.12s   killed by signal 15 SIGTERM
> 
> The console.log file is empty, and recording.logs only shows:
> 
>    qemu-system-mips64el: terminating on signal 15 from pid 344
> 
> Since this is a long term issue affecting our CI, disable the tests.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/functional/mips/test_replay.py     | 2 ++
>   tests/functional/mips64el/test_replay.py | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/tests/functional/mips/test_replay.py b/tests/functional/mips/test_replay.py
> index 4327481e35b..747835bf008 100755
> --- a/tests/functional/mips/test_replay.py
> +++ b/tests/functional/mips/test_replay.py
> @@ -5,6 +5,7 @@
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   
>   from qemu_test import Asset, skipSlowTest
> +from qemu_test import skipFlakyTest
>   from replay_kernel import ReplayKernelBase
>   
>   
> @@ -16,6 +17,7 @@ class MipsReplay(ReplayKernelBase):
>            'linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb'),
>           '16ca524148afb0626f483163e5edf352bc1ab0e4fc7b9f9d473252762f2c7a43')
>   
> +    @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/2013")
>       def test_replay_mips_malta(self):
>           self.set_machine('malta')
>           kernel_path = self.archive_extract(self.ASSET_KERNEL_2_63_2,
> diff --git a/tests/functional/mips64el/test_replay.py b/tests/functional/mips64el/test_replay.py
> index 26a6ccff3f7..05cc585f854 100755
> --- a/tests/functional/mips64el/test_replay.py
> +++ b/tests/functional/mips64el/test_replay.py
> @@ -5,6 +5,7 @@
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   
>   from qemu_test import Asset, skipUntrustedTest
> +from qemu_test import skipFlakyTest
>   from replay_kernel import ReplayKernelBase
>   
>   
> @@ -16,6 +17,7 @@ class Mips64elReplay(ReplayKernelBase):
>            'linux-image-2.6.32-5-5kc-malta_2.6.32-48_mipsel.deb'),
>           '35eb476f03be589824b0310358f1c447d85e645b88cbcd2ac02b97ef560f9f8d')
>   
> +    @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/2013")
>       def test_replay_mips64el_malta(self):
>           self.set_machine('malta')
>           kernel_path = self.archive_extract(self.ASSET_KERNEL_2_63_2,

Thanks, this also bugs me since a while already (not enough to send a patch 
yet, so I'm glad you did it now)!

Reviewed-by: Thomas Huth <thuth@redhat.com>


