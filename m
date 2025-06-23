Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9434FC7115D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 08:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTcHC-0006pu-04; Mon, 23 Jun 2025 04:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uTcHA-0006pU-Pq
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 04:11:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uTcH9-0006d5-1g
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 04:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750666293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+4kwDZoN4WuZV3NRgPforPSd1oPFe1fZw2u/4KSFCas=;
 b=gLAnU5vOUDfz8K+y8QB7zVpuP8qoNdJyXqaLQgCna+mQ0XhFmGvRKefBw4KUH5g90PcnCa
 zmS0oRC/FHPzQGtrKCjWQ449XjnYHMMBZYV1b+0g6kJ2NmmbP58bAKOOV3uj7HerVO1Gqf
 eB87w94GDrZOzTtPUtlRnVmstoxpgkQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-cZfonDOwNYiuMrdtFZCgCA-1; Mon, 23 Jun 2025 04:11:31 -0400
X-MC-Unique: cZfonDOwNYiuMrdtFZCgCA-1
X-Mimecast-MFC-AGG-ID: cZfonDOwNYiuMrdtFZCgCA_1750666290
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43eed325461so23335765e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 01:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750666290; x=1751271090;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+4kwDZoN4WuZV3NRgPforPSd1oPFe1fZw2u/4KSFCas=;
 b=vj878EHQejk1aBzcpLdxluAI/q5hUIWrEBMZGipdbiltZ18yV/cy5k7mhywHVdsMpz
 zPkqc9VjbpxAzMt1ReF94FoJS434RGpF0ucjtTGXUT1+pNwOuuT8Y7CbwmqGaJMLFAE7
 vrXoEw2EGRu+/ZvCemWdrAvbhq1gZNc9g6hkCq7K86Zl9xGvYNnIh6sEbvZVI8Zr+zpf
 YwSUuNva7zLVSJNtATwEKBBTaKpiHA9PVXhqkXdvqkmdRj52QyTIFCq60ldGvzq1HDHc
 7rJ88PqsTBY0rR8cjAMKPX2WRP6416Kq+wXNVhV3W++xvM2beVnQi7aLqGBMh1talTn8
 X+zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjVukL4c+VNSg5pYq9DRzI6yMJTPM1cbaMSvV+GOVQBmkf4Y4VZFmxcJd01x1+4GK9m8yGTToQ5TFY@nongnu.org
X-Gm-Message-State: AOJu0Yy3NvBfj+rI892wazo/YZpX1UaYwxYDmHwILYIuKZMpLOUGMNDf
 VC8njaJG0CfYYpF0dCZt+dc2KbFDVzBrJhLVlG7/LCQVthKZEhbHsRo6pTX+qo8tSbUsu8nGsIl
 K82uXNqzJs2589tSycPOaBp9Rbsvd0vwz2PhEUVhLZCin4nykhwZShfQG
X-Gm-Gg: ASbGncsHJXa65kOhRxiRPCHH/0GkbHsk3+7tu9Wodtgf5Wujn/TXVnT/xfS8QEY1XZC
 70YWBEUfMt5EISMqHpNnFElUMsQ+TjFP04q24uvM2NQQLoqJKX5ambKXF4nTdgpBbasQqZhvSfv
 o6N6qNyQxU7CjyB+XcLmJWEUzzbKnxMLHi7EP/xX0fjN1g2Ch5sxaAelWAmit3Nm/77NZvS64dT
 nzCI2WGOGyevvfFp56z9AXiLajxqMXu+BfAqODeWCVVm1ny8eiM8sDZSHqXMv4EsQSyyqLSmiWI
 cpIiTnVZoEJCwlIZPqQKT1+IxiPpbMMQLNLf1ypfLhg/puIRGmpULzN/KcYoRkc=
X-Received: by 2002:a05:600c:8b16:b0:450:d07e:ee14 with SMTP id
 5b1f17b1804b1-453659ec1abmr113476215e9.17.1750666290154; 
 Mon, 23 Jun 2025 01:11:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHSYgSB4RkTnj610mYZpPuQtR08xMN75sCP8xsdfL+ouLLJm/LeU7UknZje+KpOoeMWPUthQ==
X-Received: by 2002:a05:600c:8b16:b0:450:d07e:ee14 with SMTP id
 5b1f17b1804b1-453659ec1abmr113475855e9.17.1750666289717; 
 Mon, 23 Jun 2025 01:11:29 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-166.pools.arcor-ip.net.
 [47.64.114.166]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45364708658sm103184065e9.39.2025.06.23.01.11.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 01:11:29 -0700 (PDT)
Message-ID: <497fc7b1-dfd2-49ad-938c-47fca1153590@redhat.com>
Date: Mon, 23 Jun 2025 10:11:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/26] tests/functional: Restrict nexted Aarch64 Xen
 test to TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Bernhard Beschow <shentey@gmail.com>,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, John Snow <jsnow@redhat.com>
References: <20250620130709.31073-1-philmd@linaro.org>
 <20250620130709.31073-24-philmd@linaro.org>
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
In-Reply-To: <20250620130709.31073-24-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 20/06/2025 15.07, Philippe Mathieu-Daudé wrote:
> On macOS this test fails:
> 
>    qemu-system-aarch64: mach-virt: HVF does not support providing Virtualization extensions to the guest CPU
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/functional/test_aarch64_xen.py | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/functional/test_aarch64_xen.py b/tests/functional/test_aarch64_xen.py
> index 339904221b0..261d796540d 100755
> --- a/tests/functional/test_aarch64_xen.py
> +++ b/tests/functional/test_aarch64_xen.py
> @@ -33,6 +33,7 @@ def launch_xen(self, xen_path):
>           """
>           Launch Xen with a dom0 guest kernel
>           """
> +        self.require_accelerator("tcg") # virtualization=on

What about kvm (or xen) as accelerator? Would that work?

  Thomas


