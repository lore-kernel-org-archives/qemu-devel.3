Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F77C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 19:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf1uV-0002nl-FC; Thu, 24 Jul 2025 15:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uf1uJ-0002df-P1
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 15:47:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uf1uH-00006L-KA
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 15:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753386427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0YMmAkQGhxwJlncwbWgMKYlbmdeaOkousRYuqZzl9vg=;
 b=e0Ne3Auik5Fk+LwOT5JoSIxsFIqWJI2mppzJhq3O7E4E5INS8aHncIQdQuOq8KqX+3HsqP
 WNN79iXqSqRGy6b099NgNzfrMX0yTKfCvP2Zp+NzWLfuC4IDQQDgJoCgadY2jgRJDHgwhy
 fkWCS4hP4c1jtAorMj6jytE2+bhAgiQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-RPjKPpjvNIS3uqH-JaN0-g-1; Thu, 24 Jul 2025 15:47:05 -0400
X-MC-Unique: RPjKPpjvNIS3uqH-JaN0-g-1
X-Mimecast-MFC-AGG-ID: RPjKPpjvNIS3uqH-JaN0-g_1753386424
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4561c67daebso5304485e9.1
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 12:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753386424; x=1753991224;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0YMmAkQGhxwJlncwbWgMKYlbmdeaOkousRYuqZzl9vg=;
 b=kVTuptqhvQR1YdzHplBnARjol0PkTxwGJ6u1cq/Gnt37Ff7+Jo2svmHac7XyP1pKsK
 Y6xtxwRPceKIs2qiVxAhH0C37pObgkjeNk/QdIKhfTnWPLS7KVjzLHeKc9ufEUovw2nw
 jxRkJUqygyEKkt/TJsWht6uB/zsIN8RrNEr+D5UDTAogdV/wuMX2wja8GBCOmEOCKFQ+
 EJ1pVWvLImW2FhoXltaLeX28g/2XIAXGM7VIJ00v6UZ8EUZXpQsLDPtY24J1/kMsyS+E
 /Emv6XMUHS9ZLetjP5az1pV8Lp3Cy8KNm4dJECxHDpHjxAQP6lVVUPyWBD82tjZw/wBB
 hsZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0zn/4/HTtzPLDzBCCuvse9HoMD9oyKgeYFb6Hx9Zqgo3Rv67/G6SYt1OosJKbvzxVOjVWl61quIuo@nongnu.org
X-Gm-Message-State: AOJu0YxdYRU3jJL7L1gexij7GQZo3TExUhDVI2L2lyF4JQuYwzlx1SBh
 7BQYhKW2OcqMX+JjWhyQqKDcOpr8AOTna6jOCBjcV1dYiAxd/7BFZk1jKUyT1znE58Pi+bVVWPm
 W8gxf2RLSuW5EjzqCfDb7D41nixUs9IfFs7GCBW2nhzrNMM7pHcfpahiX
X-Gm-Gg: ASbGnctAMNr5ZxUI637NVHn4OYF5AIDxjvq+oT36AnF6m7AECr65YnAfjiUd8tTobk1
 wDSqDfha7RQghAiXWIlFAKFMnES568s0OM4/dPHiXDpgDgsq9lEhO418NOyCfDiTKqkgepuLnw+
 aQujv5UOXO4V8fIEjMFndnMZL6iHHQ8g9CwZixfvY4TyXBtShrSMbHolpKcLiuFbjMUvDwODL/w
 WBvQ+cnqBx71KslMnLmsWCxSTUWhSTwRsz54V+xg4Se5NM1cTCr4s5Q6Ygdq7aeaCQDqu4tMDiC
 OEFGKL4V4W63nj0iCXz2faL9WaNctZn2nGBeCAaAuQv4q9Vk0uuFTpfHqfZtwL7+d6EqAOg3w74
 SuGk=
X-Received: by 2002:a05:600c:c11c:b0:456:15be:d113 with SMTP id
 5b1f17b1804b1-45870504402mr29234615e9.1.1753386424038; 
 Thu, 24 Jul 2025 12:47:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG33CfzwiKc8CxBzxNrAbxEiHiQa9ejv9Lj9r/KDNflNMNjZs9L59vOb5+VFAtO+DKtJ56+TQ==
X-Received: by 2002:a05:600c:c11c:b0:456:15be:d113 with SMTP id
 5b1f17b1804b1-45870504402mr29234525e9.1.1753386423620; 
 Thu, 24 Jul 2025 12:47:03 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-115-089.pools.arcor-ip.net.
 [47.64.115.89]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705ce775sm29780505e9.32.2025.07.24.12.47.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 12:47:03 -0700 (PDT)
Message-ID: <f208a06d-2dfe-4cce-a848-938b3e3b6a31@redhat.com>
Date: Thu, 24 Jul 2025 21:47:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: add --debug CLI arg
To: John Snow <jsnow@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250716-functional_tests_debug_arg-v1-1-6a9cd68318bb@linaro.org>
 <87ms93xl69.fsf@draig.linaro.org>
 <CAFn=p-YTFYr-cxz0B8jay=-HVpjyo9To72DZAg5o45SRBR0wnA@mail.gmail.com>
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
In-Reply-To: <CAFn=p-YTFYr-cxz0B8jay=-HVpjyo9To72DZAg5o45SRBR0wnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 21/07/2025 22.38, John Snow wrote:
> On Thu, Jul 17, 2025 at 4:44 AM Alex Bennée <alex.bennee@linaro.org> wrote:
...
>> Am I holding it wrong?
>>
>>    ➜  ./pyvenv/bin/python ../../tests/functional/test_aarch64_virt.py --help
>>    Traceback (most recent call last):
>>      File "/home/alex/lsrc/qemu.git/builds/all/../../tests/functional/test_aarch64_virt.py", line 16, in <module>
>>        from qemu_test import QemuSystemTest, Asset, exec_command_and_wait_for_pattern
>>      File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/__init__.py", line 14, in <module>
>>        from .testcase import QemuBaseTest, QemuUserTest, QemuSystemTest
>>      File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/testcase.py", line 26, in <module>
>>        from qemu.machine import QEMUMachine
>>    ModuleNotFoundError: No module named 'qemu'
>>
>> I thought the point of the venv is we had all the modules we need
>> automatically available to the PYTHONPATH?
> 
> As Thomas points out, "qemu" is special since it's already in the
> tree. There has been some dragging-of-feet by yours-truly because
> installing the "qemu" module by default when running configure
> introduces a considerable startup lag time, and the module is not
> actually needed for the simple configuration and building of QEMU -
> only testing.
> 
> It's something I want to fix, but must admit to being a bit stumped as
> to how I will bridge that gap long term. Currently, all of the modules
> we need are in the tree with no dependencies, so it can be fixed with
> a simple PYTHONPATH hack. However, if I actually remove the QMP
> library from the tree like I have wanted to, then we need pip to do a
> real install and process dependencies, and this creates some
> complications and extra startup lag.

Wouldn't it be possible to add the module as a wheel in python/wheels/ ? 
That's maybe the easiest solution, isn't it?

> Naively, I think adding a "just in time installation of testing
> dependencies" when you go to run a testing command from "make XXXX"
> might be sufficient for us, possibly in conjunction with a configure
> flag that lets you pre-load testing dependencies.

We could likely re-use "make check-venv" for the functional tests ... it's 
already installed in that case. However, you then still have to remember to 
call it first before you can run a test directly, without the Makefile wrappers.

  Thomas


