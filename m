Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6852C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 18:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfjou-00084y-0p; Wed, 05 Feb 2025 13:08:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfjos-00084W-Ky
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 13:08:14 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfjor-0006H9-1u
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 13:08:14 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so669595e9.1
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 10:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738778890; x=1739383690; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mWJQmQRcwc8WnmUyWA8MbmjMCgK5S+qqP4CD7PcxmEk=;
 b=kEfWDwrMVXVImXDwSoRM4xCPTmIncuQKYNZPQM/JA9SbqRbkAHYEpwFdPcjcUr9LPP
 nuZHoNlrUogcR3i7HHt7advYfsNtql5wwQOfiZyCSOwlzrBaBloM/W88+ktqJbPt5B/J
 fIuDrrHOGQoSRFle4nyGHsEuGbCgTzKGwu9Gat7tkzXBWvL++TQXXlGPgejXUo3f02n0
 QM/xAedvCV78PDLdY4QSq/n56IU/KIRb1Fphtr+7ieb8v9RN7DdZ38FDEDHOlBEUOOTN
 1STnx3jboX8unvfHIy0kXFAxX7pL/vexSmXnyWaDlsidMdE2T6OCFBz0Vr7GlSo/poip
 dVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738778890; x=1739383690;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mWJQmQRcwc8WnmUyWA8MbmjMCgK5S+qqP4CD7PcxmEk=;
 b=g6RhD3IT8wFi5eDPjmBcyzjDFEwGlSN3KPVXegralffgxGH++x2Q3wq1q4a4bBKgOK
 T0+k0i9ZU7hXdMFAQr3/yekEaF2a0UQCU/Z/D9894RHFBV/siGpT0m31c8/2A/oomIwH
 aBMCkss2n6INb1wcY0M0wGbDm+c+A3zacQ/hxPCsqUngqBPtla4aZExNLtoJb7golw0I
 2iTiz8X98kh9of1qqZuS1uWs19K/KaYezy3YstrcmRgWXX12jAtn+NDrda2miibH+CDv
 otZrltNNAH1QZywnGF9cQ5aT3g6Q9st5YslIBNMDf4FbDZE8JaweXN0y0dDv1XP8Vpu+
 rv6g==
X-Gm-Message-State: AOJu0YwM7BhQsdu8svWjvUx7GFkoDMHHj2yZ6gJ6hqd6BZpYLsgUrMpa
 oW60dnPtPQoHoVo4cuQyGfZTpZZWDYcQYqNPTToR2WWwjtDce7MHtX4DI7+SrVzvgR45x1ilixy
 +Ac8=
X-Gm-Gg: ASbGncvnZrnbD+hvAYWkA9OZNXoy0/UhLtavhEXUPcy8ppnhzuukkWwXFYQh+RYufIb
 z9HPPaWhO4oT+00OUMWWYEgPZUddjaRTyMEvyABWNKFS96ZA8OnjtWC93no/cxEIQT3QOiHm7xt
 u/G3ir6GATtu2EjiaeZWtQrUvMud6VTSLv+9FFPjnoxJ5WLULEQa8vYrgYaG8XFFZfoTinoXaja
 krpccky79GnCgRBSFWDTOlFiCWwmOhjXNixqgjomogi/L0QXZtb7qOxCKHqUQ5il0ulB7OA2f/A
 ff1kZKAqRDdXpkORX1XlXCfWLZqrFTUs3V2Xks1QDpF6enfAeGC2zBE9Dbk=
X-Google-Smtp-Source: AGHT+IExPEHTQqTiZ3zozb5otO7ZlIGHGmbH2Cp93VQ8MjbmBcQ+zn5Iaff0zmRhH3F09Td/wB6Oug==
X-Received: by 2002:a05:600c:1c1e:b0:436:6ddf:7a27 with SMTP id
 5b1f17b1804b1-4390d56980emr31130065e9.23.1738778890623; 
 Wed, 05 Feb 2025 10:08:10 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390da89207sm28176145e9.32.2025.02.05.10.08.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 10:08:10 -0800 (PST)
Message-ID: <7819efab-9a19-434c-a48f-82f32a3ada0a@linaro.org>
Date: Wed, 5 Feb 2025 19:08:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] tests/functional: skip mem addr test on 32-bit hosts
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth <thuth@redhat.com>
References: <20250205155946.2811296-1-berrange@redhat.com>
 <20250205155946.2811296-6-berrange@redhat.com>
 <9edd3138-3411-4459-96c3-d48c30e197e0@linaro.org>
 <Z6OXlPu0fw_S9iy6@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z6OXlPu0fw_S9iy6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/2/25 17:53, Daniel P. Berrangé wrote:
> On Wed, Feb 05, 2025 at 05:40:48PM +0100, Philippe Mathieu-Daudé wrote:
>> On 5/2/25 16:59, Daniel P. Berrangé wrote:
>>> The test_mem_addr_space is validating handling of QEMU with various
>>> memory address settings. All of the test cases are setting 'maxmem'
>>> to a value that exceeds the 32-bit address space, so these must all
>>> be skipped on 32-bit hosts.
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>    tests/functional/qemu_test/__init__.py   |  2 +-
>>>    tests/functional/qemu_test/decorators.py | 12 ++++++++++++
>>>    tests/functional/test_mem_addr_space.py  | 17 ++++++++++++++++-
>>>    3 files changed, 29 insertions(+), 2 deletions(-)
>>
>>
>>> diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
>>> index 1651eb739a..d3a8cf0483 100644
>>> --- a/tests/functional/qemu_test/decorators.py
>>> +++ b/tests/functional/qemu_test/decorators.py
>>> @@ -5,6 +5,7 @@
>>>    import importlib
>>>    import os
>>>    import platform
>>> +import sys
>>>    from unittest import skipUnless
>>>    from .cmd import which
>>> @@ -118,3 +119,14 @@ def skipIfMissingImports(*args):
>>>        return skipUnless(has_imports, 'required import(s) "%s" not installed' %
>>>                                       ", ".join(args))
>>> +
>>> +'''
>>> +Decorator to skip execution of a test on 32-bit targets

"hosts"

>>> +Example:
>>> +
>>> +  @skipIf32BitTarget()
>>> +'''
>>> +def skipIf32BitTarget():
>>> +    enoughBits = sys.maxsize > 2**32
>>> +    return skipUnless(enoughBits,
>>> +                      'Test requires a host with 64-bit address space')
>>
>> skipIf32BitHost?
> 
> I don't mind either way.

Preferably using skipIf32BitHost to match the error message:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


