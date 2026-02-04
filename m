Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42B3E83EF4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnY97-0002c2-MX; Wed, 04 Feb 2026 03:21:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vnY94-0002a3-FO
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 03:21:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vnY92-0003ew-Kz
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 03:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770193311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L4oUX3UTF+YI7fKQrTMby77ImDJci/UDzSHjGFV5R8s=;
 b=eSFtUv3ZR8X2lucv3eaiPRSXuir6gqneBma57izc2bwrKJFDP8OCMd04iM4cZUxZIf6Mbh
 p+TlSX1ojrVH/u/AX3trMOpY3Oclo524zVttLvNRgWF7Gk+ALvjVSJSkNgYjH/HlpRPQu/
 v4hZjRq7DWftY1STkJMnbrkImuY88UQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-n4_rwkwkMCmhM51--bbB1w-1; Wed, 04 Feb 2026 03:21:49 -0500
X-MC-Unique: n4_rwkwkMCmhM51--bbB1w-1
X-Mimecast-MFC-AGG-ID: n4_rwkwkMCmhM51--bbB1w_1770193308
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4801d21c280so3217525e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 00:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770193308; x=1770798108; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=L4oUX3UTF+YI7fKQrTMby77ImDJci/UDzSHjGFV5R8s=;
 b=nODiU7RqeIJ5w7mThWzCcztmNULhpCsSi8+a6Z4avIKndT11l1hhjDHEqX9N6NF+uu
 BrUumXcWmKZ2DePe9QBtOfinlhFp2ccutGQO42BP/y4u94TYvNp0yij6M1k7d7uFw5N+
 ZhiNo8qSHKa8811MwvauPobP4rPXLGEsL1bnTdy5MApwU5CC77xZBACmGCKNfFASYP9F
 ye5M19XFynmtZtUa2xxpsfNZU+xMn0GLxxMc9YYbU1E2Tv/SZt5BVWvzRQnFbUdxdO7n
 7moEyYHZib5rjvmonjUc+xCdlEqHjlhPHjLJwKJzEk00BBHyGHJ/gsj6V41esOXC8GGF
 QVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770193308; x=1770798108;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L4oUX3UTF+YI7fKQrTMby77ImDJci/UDzSHjGFV5R8s=;
 b=UqHAxzuRjTv1qmZL1Y8aNIBsjLgpcvn1CgRzuYC0/SN9TcMQ9Obdj9ykkNZNWNXdNc
 WlHqx5f8sjCmCO+Lgeh36dACvDvUw57UYNoRSs2JdRys2vSlygmRCnTLH+4AYh8WVIAc
 ZX+xixt8RLGSRCf2bEEzAVSqcDFD/Rec+1zRgj6MGcpOTYpaCp/Am1uXVZFdMEOrHCgK
 zDF+hNE8oKOJbxy3b8Dx3bGYRKWaQ9d/u+HdulpcjQxj3j78e+GO18UCYphDHBtTR2KG
 +KrJZcPsLlwJhPhUnf9lgp2rTGv3ntwfve+EgebP9xsJuV8ZzkcFfKPlXvJLIySCDaMD
 C8zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgpWv4ZTWddo2+DhIRJg0Uc4yb/BubxoS+hNPs/FjAYjUMHvHNCC9x1XyNXeb7rxUnlWqXtIm/lEBc@nongnu.org
X-Gm-Message-State: AOJu0YxX8hdgXbrDTXq3yof+eEVZKF1RkEbA9+j0EQLY4TWvAAVqDEKw
 WTa4ydjeJzOk5AL7oJ3DPCuni/PMAHRMYgxVny3rdpXzc/uGLravcZy7O4XyoDv6bShh0aPP9gN
 VTKbAR0AOwilNRXmJQQsopKb+C6IgojqdvDFl0P9R/botC1rx66vhtxV0
X-Gm-Gg: AZuq6aKlLEDecQ3lABOOISINshzhAgBnzZ7DV2zEI3Hl8Rm+bEFtmD3TD8f5ZBX1rkf
 Az0UsnxQNWxahfZSfGlrfOn7ik6sNHH+GVgZV3HpVaR11jLhOWn8y7fEVogOYZKEJaHYw4Kq4fA
 KT0AkpQRgY0Sn9XQ7skAsoDchdcTwIxE+R+g1ilhkB+ogN1ucRHhkjXspoXzU3h59qRSN/92LtX
 89yQ4iNe+RUcehb8gMZqxEtEmgVir1n80RPBw/JSegODb4cF5cfJpC8rZAkRRo9MBQifQfPOfvp
 u2jxpra/IWIOdNyrxLwZV/ymHmFWSwAe/KSviR8D2uG/iFFHtd0PCYD2axcYxYbn4Xtx7EB7YB7
 YTAo4mgfA5x+yOR5cFlPDVdVhDH6iJNKQRR8=
X-Received: by 2002:a05:600c:628b:b0:479:2f95:5179 with SMTP id
 5b1f17b1804b1-4830e931e2amr28579235e9.15.1770193308322; 
 Wed, 04 Feb 2026 00:21:48 -0800 (PST)
X-Received: by 2002:a05:600c:628b:b0:479:2f95:5179 with SMTP id
 5b1f17b1804b1-4830e931e2amr28578945e9.15.1770193307889; 
 Wed, 04 Feb 2026 00:21:47 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48310919211sm38678715e9.11.2026.02.04.00.21.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 00:21:47 -0800 (PST)
Message-ID: <149b4ce8-af00-4a85-8cb9-124ad0d8c31b@redhat.com>
Date: Wed, 4 Feb 2026 09:21:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/16] python/mkvenv: add mechanism to install local
 package(s)
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Maksim Davydov <davydov-max@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
References: <20260203203512.672552-1-jsnow@redhat.com>
 <20260203203512.672552-5-jsnow@redhat.com>
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
In-Reply-To: <20260203203512.672552-5-jsnow@redhat.com>
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

On 03/02/2026 21.34, John Snow wrote:
> Currently, we "implicitly" install the local 'qemu' python package for
> 'make check-venv' with some logic inside tests/Makefile.include. I would
> like to make this installation explicit in pythondeps.toml instead.
> 
> This patch adds a path constraint that can be used in lieu of version
> constraints to specify that a package should be installed from the
> source tree instead of from PyPI or vendored packages. This is done to
> allow us to install the python packages hosted inside of the tree while
> also processing dependencies; i.e. so that our "qemu" package can
> specify that it needs "qemu.qmp", which soon will not be included in
> qemu.git.
> 
> This also has the benefit of being able to specify in a declarative
> configuration file that our pyvenv environment *will* have our local
> python packages installed and available without any PYTHONPATH hacks,
> which should simplify iotests, device-crash-test and functional tests
> without needing to manage local inclusion paths in environment
> variables.
> 
> On the downsides, installing packages through mkvenv/ensuregroup means
> that there are extra steps we need to take in order to install a local
> package *offline*; namely we must disable build isolation (so we have
> access to setuptools) and we must also include python3-wheel in QEMU's
> build dependencies in order for "make check" to run successfully when in
> an offline, isolated environment. These extra dependencies are handled
> in a forthcoming commit; for now, nothing is utilizing this new pathway.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   python/scripts/mkvenv.py | 37 +++++++++++++++++++++++++++++++------
>   1 file changed, 31 insertions(+), 6 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


