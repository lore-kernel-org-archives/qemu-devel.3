Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0D9C87FCA
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Jul 2025 06:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufYoA-0008Fd-Hu; Sat, 26 Jul 2025 02:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ufYo8-0008E5-Tq
 for qemu-devel@nongnu.org; Sat, 26 Jul 2025 02:55:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ufYo6-0005Su-Bi
 for qemu-devel@nongnu.org; Sat, 26 Jul 2025 02:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753512896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Xu2X4GTn+uUa0EVnOsJ0Jm6e8zSZD/s/KZ6bMArOaJA=;
 b=aoPP9x3Anp01l+HYiXz9J3vuJ/qBnHVzCaBDDEAImeXXJFR+kxyNNiJiTp1KqGHp4LEI8V
 9fXyo88KbdzMWvX7w6dlUK2N0RT2HubbWfi6bShc3rE6DuUDal5loDd1LnTCj8fyixH4a7
 rIunRTiH35FvXbzwlMpifBBbzW0kT5A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-rlCAkA94NUW8iPXJTlaCgg-1; Sat, 26 Jul 2025 02:54:54 -0400
X-MC-Unique: rlCAkA94NUW8iPXJTlaCgg-1
X-Mimecast-MFC-AGG-ID: rlCAkA94NUW8iPXJTlaCgg_1753512893
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-456175dba68so16299345e9.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 23:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753512893; x=1754117693;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xu2X4GTn+uUa0EVnOsJ0Jm6e8zSZD/s/KZ6bMArOaJA=;
 b=rFYwhaMd+4DbfkUVMDoYMMzo5XiuxNug1RCEQvgEj5urJ0qtXnY1h5uoLWHapa7zSQ
 X7Sc/xcayMXWdzr2TS84IDFnB/pqmN9bYfXYNz8K+WzhMi7rWueN5UaHdlwWY73vIWEr
 XpfkCqTH6os6WPUcqpGXKs8FWLq2fXU3MeXQF9QXXv/47EK5VS4dW/PzeQrsAFokbtTL
 Bd0u3NcO+SapB5AZANquvBHBwGm+VcBZNQjsDZt/O8EmzIy28jDs/EPkzCTfAygxlkO6
 1IC+NTv66h9QNO1MUobhY0iYv+85GMpmKBaQbOuRMe0dypeNwhnaq/P5Wb5FKN/4RybT
 MEIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOV6YgPUhlhiYl+mYJ2KvRy1X/8uafO73oBx0EfYRYbaUeufWIrqdAcyBPfnSo9Np7gclTPvPBy+4P@nongnu.org
X-Gm-Message-State: AOJu0Yx7GPEf9XsrPOD+P841dQswQA4Oa26I64eL4NaXu/dV48ZtryH9
 uOsoQOnJlXh2+0ZRacELcA7ibMNNsQqi38n/BtdIDerV9mxwHrcWvX0uHtmmQjEnpP0sgM2d/OY
 5rEqPDmzX7F6Uc2Q3e6lcu+p/Ch0TXAIap9MiSiRWV6wiQn3Bhk8AqnTi
X-Gm-Gg: ASbGncu8NioeuHESiwACUhPVNQCFo8wIS+CQNGAEkzJ1uqAGi9m6McLFtsNUWqA/ZaE
 Gfk+Km5zmmcPa0ifxgHUSoAkP72F3Y1zEa6eh3s1DMPO3xmIOrDCjPO+yjHhYTlsquxL/eG+GoC
 RvFcBXskdcJQqQBNzlVwsNVu30Jb6tpXJPAIf8TchgXds4Wae6kYg6ccdk911BGCLfxKzFT6vhZ
 6YGPpzyfRVAWi3nvhIYS4QQHGGWm4uyD67wGRQiSS9f/ri08V4dz1sr2lgalhbM/USqak91rJbm
 nIYqP42hh34j3EWX3NeCeGvhc+u636XeDAlpeEUxCxxz8M3upSIgnSZ934VO1wnNtQu1m2RwA6X
 szTWD
X-Received: by 2002:a05:6000:1ac6:b0:3b7:7617:f732 with SMTP id
 ffacd0b85a97d-3b7767657e2mr3788748f8f.39.1753512893384; 
 Fri, 25 Jul 2025 23:54:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwZ8SWk2SpYLYTTZDNMGCVp7iAxEG94308eb86IGnDLZGbf70sGj9dYTx1QzDORpmT04LIAg==
X-Received: by 2002:a05:6000:1ac6:b0:3b7:7617:f732 with SMTP id
 ffacd0b85a97d-3b7767657e2mr3788735f8f.39.1753512892979; 
 Fri, 25 Jul 2025 23:54:52 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-114-230.pools.arcor-ip.net.
 [47.64.114.230]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587ac76b92sm19234565e9.32.2025.07.25.23.54.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 23:54:52 -0700 (PDT)
Message-ID: <50ef6de5-bef5-4da8-a417-b666b7968f6c@redhat.com>
Date: Sat, 26 Jul 2025 08:54:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] tests/functional: add -k TEST_NAME_PATTERN CLI arg
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250725-functional_tests_debug_arg-v3-0-b89921baf810@linaro.org>
 <20250725-functional_tests_debug_arg-v3-4-b89921baf810@linaro.org>
 <aIOF2gPa8nbec2qp@redhat.com> <aIOZQfMHt-jJUTSH@redhat.com>
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
In-Reply-To: <aIOZQfMHt-jJUTSH@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 25/07/2025 16.48, Daniel P. Berrangé wrote:
> On Fri, Jul 25, 2025 at 02:25:46PM +0100, Daniel P. Berrangé wrote:
>> On Fri, Jul 25, 2025 at 12:41:25PM +0300, Manos Pitsidianakis wrote:
>>> Add a CLI argument that takes fnmatch(3)-style patterns as value and can
>>> be specified many times. Only tests that match the pattern will be
>>> executed. This argument is passed to unittest.main which takes the same
>>> argument.
>>>
>>> Acked-by: Thomas Huth <thuth@redhat.com>
>>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>> ---
>>>   tests/functional/qemu_test/testcase.py | 23 +++++++++++++++++++++--
>>>   1 file changed, 21 insertions(+), 2 deletions(-)
> 
> 
> 
>> One of the goals with the new functional test system was that we stop trying
>> to (re-)invent a custom test runner harness, as was the case with Avocado,
>> in favour of relying on the pre-existing python infrastructure to the
>> greatest extent possible.
>>
>> Seeing this, and all the other CLI arg handling added in this series, makes
>> me fairly uncomfortable, as it is effectively inventing a custom test runner
>> once again which is exactly what we wanted to get away from.
>>
>> At the same time, there are some pieces in this series that do things that
>> unittest.main() can't do on its own.
> 
> So considering the broader picture, we already have a load of tunables
> on the test execution that we control exclusively via envirnoment
> variables, as that gives us independance of the test runner, which
> owns sys.argv processing.
> 
> So in terms of this series, IMHO, we should just add support for
> QEMU_TEST_DEBUG=1 and QEMU_TEST_KEEP_SCRATCH=1 as two new tunables,
> and not touch sys.argv at all.

I basically agree, but I wonder if we could maybe also have both? First 
parse the sys.argv for our parameters, then pass the unknown ones to 
unittest.main() ?

> With that, the only thing we're missing is a way to enumerate the
> test cases, but IMHO that's the job of the test runner and thus
> out of scope for QEMU to solve.

With the patch applied that passes the argv to unittest.main(), there also 
seems to be a "discover" mode:

  ~/devel/qemu/tests/functional/test_vnc.py -h | grep usage:
usage: test_vnc.py [-h] [-v] [-q] [--locals] [--durations N] [-f] [-c] [-b]
usage: test_vnc.py discover [-h] [-v] [-q] [--locals] [--durations N] [-f]

... however, when I try to run it, it does not work as expected (I get a 
"ModuleNotFoundError: No module named 'discover'" error).

  Thomas


