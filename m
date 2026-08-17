Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7948C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 11:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvv6U-0001DN-OO; Mon, 17 Aug 2026 07:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wvv6R-0001Ct-Vm
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 07:02:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wvv6P-0007Oc-61
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 07:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786964519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=p3fKo06NzUUBJhpRc+0P5xMHEgMjJkbsJhtpK6DUMo8=;
 b=I/UKH9yjCJraOcTnyqZPns4ec2ZCs3L86iLEL5Gdcqg5WjHaY3/e3vIbYjYynb8+g/ElTN
 FhdAfPOCeJ0IWdGAjdCx+7ed/OUtAi94U8BbxtNcVKe2qd2xhG0n/WU6OONkMUHA9jBv1Z
 1gnOrfpRvntdUro47QS6Nk71b0H+vOA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-kvZgqk_dO82-i9Z369V8WQ-1; Mon, 17 Aug 2026 07:01:58 -0400
X-MC-Unique: kvZgqk_dO82-i9Z369V8WQ-1
X-Mimecast-MFC-AGG-ID: kvZgqk_dO82-i9Z369V8WQ_1786964517
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47d81cf0c4cso1925615f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 04:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786964517; x=1787569317; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=p3fKo06NzUUBJhpRc+0P5xMHEgMjJkbsJhtpK6DUMo8=;
 b=t4g0p7QBRAE189SJLOiei3Lfc4Ag1WBkXoojD33+JHrHw4svXeUvtgPk4NBjt6XeEh
 d7pMv7WJTFmBi4I04AnAFUt2kPJT7LBri+yOBaswxTo/loOEhEFQO6iuqOzTG6xRNFbA
 s+qnAuNH8nrgXZvvUvIqyX9VHScleG7SGNieGGj90zwjQPA/BcDYLYd9WES7WRoVIHt+
 qhAiDHS5/uILWSirJV0W4k8IgS6T2Lqdo5kqu7HuhfFWd7yQSX3R3REpEwFAICvGjiKg
 mERFeCjS79cKxzPPUmtsCA36PksAZDnIw1eEyZLA31TTza9jN1xgq/dW0079QSskUpAQ
 74dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786964517; x=1787569317;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p3fKo06NzUUBJhpRc+0P5xMHEgMjJkbsJhtpK6DUMo8=;
 b=QN2J+8H+pYV7OCjMw77gdA5cwcSENgXbaG95TrYNDEAkXPpRdF+Hy7r3SD8Jyn8wiB
 vbGJVLvxAOSPT9rC9YC3jTdDXJgEwnq/NYhWsUkGu8awg7C0yns36ejhge0UdPE+k6HL
 DxRe4K2dZFxP8SeO2/rL8+GWYB4GPC1E6mV7nvlRE7n3ODlWuZ9LHZvE4pxXRzBhVnt3
 mkyEjZqwoOJ9kYypyD343/OWZXP4iIxacdkkOvTsi5PN8GetO2qHraw1Uv8qIydNIxJR
 cQtaf580pyGEnlb8AWmcLutGpKXkIWPkj8/DwpVjLI4rwQCM+TcaQhNOFHqNwmMc/I/j
 2ihA==
X-Gm-Message-State: AOJu0YzfKAjCPYk3JsmUAUAdfHSnIObDJd1jfdQB9qowmaVpZ/leoWrv
 9wsRYtr/A1itiKa5gdpwyT9YeQHNvet37DkzkC80oaf9Sm8pKBQLIkwzEPjndosrMS/YCl29SMC
 Ov5Vcd/lvOUEFHn3fj+N/99NVUj5qcvrQu/VFa1rNaeldBhD1TZU1Zagb
X-Gm-Gg: AR+sD13pNsQq6VQi0rHYF9u7BZI/Een1kEKsyHMC7TiXK1ClzsyVwwo9b7mpdm/mo2+
 wPw0ajDCSeeQXtENbnh3FbMHcV9OLZVfi5b+5FUTxN+fdfHewHms380f9s2FGYW/8BHpmzzkDy0
 odAK62hkAvxem4YoWxbMMxL8VW41IHMUs4L8zzOi+mtkjWjJ4ae7kcT7LdV4iHbK3BScZbXaEJ8
 P2mHNugCYt9v7gu+kbZVwHdTq2rP1xSAJjiSoAsuUAtXqXRvND5m+VNVgxkvfAg4W1/OWWH37/3
 erAJCwz0hc64HlThmTfTxAJ6zNrImV5ai/KZtm+59OFFas2zFD/PUA/R436RNuFCYGBgfRk0
X-Received: by 2002:a05:6000:220d:b0:481:4fa4:f9e5 with SMTP id
 ffacd0b85a97d-48160771860mr35842379f8f.14.1786964517122; 
 Mon, 17 Aug 2026 04:01:57 -0700 (PDT)
X-Received: by 2002:a05:6000:220d:b0:481:4fa4:f9e5 with SMTP id
 ffacd0b85a97d-48160771860mr35842318f8f.14.1786964516619; 
 Mon, 17 Aug 2026 04:01:56 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.27]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a31396sm3101373f8f.2.2026.08.17.04.01.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 04:01:55 -0700 (PDT)
Message-ID: <d6fa2176-7cf2-4955-8dc8-a79ca34ef568@redhat.com>
Date: Mon, 17 Aug 2026 13:01:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: fix pylint false positives for cv2
 module
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260815072421.4117291-1-marcandre.lureau@redhat.com>
 <54495516-9f01-4077-860a-a4c9cc612a73@redhat.com>
 <CAMxuvaz3yrNkTnYOHtDcqGgKjW=9B-v82dGHpvSYUjzgrBYmDg@mail.gmail.com>
 <225b9367-f343-4690-ac37-d2bbd57680a7@redhat.com>
 <CAJ+F1CL7VVXBa5jJKxaKQ-ZV4Yf=uoz3SSLPCcxmRH6duvnYMQ@mail.gmail.com>
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
In-Reply-To: <CAJ+F1CL7VVXBa5jJKxaKQ-ZV4Yf=uoz3SSLPCcxmRH6duvnYMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 17/08/2026 12.54, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Aug 17, 2026 at 12:39 PM Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 17/08/2026 09.57, Marc-André Lureau wrote:
>>> Hi
>>>
>>> On Mon, Aug 17, 2026 at 11:19 AM Thomas Huth <thuth@redhat.com> wrote:
>>>>
>>>> On 15/08/2026 09.24, marcandre.lureau@redhat.com wrote:
>>>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>>
>>>>> Add generated-members=cv2.* to pylintrc so pylint skips member
>>>>> checking on the cv2 C extension module, whose members are not
>>>>> visible to static analysis.
>>>>>
>>>>> Silence:
>>>>> 2026-08-15 10:42:08,710 - INFO: qemu-test.test_pylint Checking files in /home/elmarco/src/qemu.qom-qapi/tests/functional/arm with pylint
>>>>> 2026-08-15 10:42:10,941 - ERROR: qemu-test.test_pylint "/home/elmarco/src/qemu.qom-qapi/tests/functional/arm/test_integratorcp.py:83: E1101: Module 'cv2' has no 'imread' member (no-member)"
>>>>
>>>> Alex recently already sent a patch for that error here:
>>>>
>>>>     https://gitlab.com/qemu-project/qemu/-/commit/dd14a21b9dc1
>>>>
>>>> Didn't that help to silence the message in your case, too?
>>>
>>> Ah I missed that, but it doesn't help:
>>>
>>> pylint --rcfile ../tests/functional/pylintrc ../tests/functional/arm/
>>> ************* Module test_integratorcp
>>> /home/elmarco/src/qemu.nohmp/tests/functional/arm/test_integratorcp.py:83:25:
>>> E1101: Module 'cv2' has no 'imread' member (no-member)
>>> /home/elmarco/src/qemu.nohmp/tests/functional/arm/test_integratorcp.py:84:26:
>>> E1101: Module 'cv2' has no 'cvtColor' member (no-member)
>>> /home/elmarco/src/qemu.nohmp/tests/functional/arm/test_integratorcp.py:84:55:
>>> E1101: Module 'cv2' has no 'COLOR_BGR2GRAY' member (no-member)
>>> /home/elmarco/src/qemu.nohmp/tests/functional/arm/test_integratorcp.py:85:17:
>>> E1101: Module 'cv2' has no 'matchTemplate' member (no-member)
>>> /home/elmarco/src/qemu.nohmp/tests/functional/arm/test_integratorcp.py:85:52:
>>> E1101: Module 'cv2' has no 'imread' member (no-member)
>>> /home/elmarco/src/qemu.nohmp/tests/functional/arm/test_integratorcp.py:86:35:
>>> E1101: Module 'cv2' has no 'TM_CCOEFF_NORMED' member (no-member)
>>>
>>> My understanding:
>>>
>>> I1101 (c-extension-no-member) - disable: silence if pylint can't
>>> introspect the module
>>>
>>> E1101 (no-member) - but we need to tell pylint to trust any member
>>> access on cv2 if it can
>> Ok, but could you then add it to the "disable=..." list instead, so that we
>> disable this for all other modules, too? ... otherwise we'll be busy adding
>> an entry for all other modules where this pops up in the course of time.
>>
> 
> I see your point, but disabling "no-member" globally means pylint
> won't catch typos like self.naem or obj.nonexistent_method() anywhere.
Ok, then let's go with your patch here.

Reviewed-by: Thomas Huth <thuth@redhat.com>


