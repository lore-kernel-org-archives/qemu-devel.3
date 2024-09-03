Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37E1CD343E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 14:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slUJC-00057M-4H; Tue, 03 Sep 2024 10:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slUJ9-0004zk-UU
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:15:00 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slUJ6-0000nd-Qr
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:14:59 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42bbd16fcf2so37196605e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 07:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725372895; x=1725977695; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ICqKvs+VaoNNZ4rmNaZLPPb3oqph3mMZod2yLficrk4=;
 b=PBYFf1y4j8GrMCIR7KgcxsHT1Wv7+REpMP3k1G9N50WZtQ8li0vq/fd2nydNFnMHV3
 Tz84r1hEjXAtK/Ekyk48odS0VPgOOES6djBTxdvAe2RPgQq3PRbciNRYKymWSAOrxxA8
 Km3KKCRZzSRBXnH2zh/wtpRrhSNDPd4cReCzpjPwMatfINKPCw4AFZBDf80XHIuknBXe
 xUsnivBdGo/Z44ZAW824hyFkfiFaPMeJUfUeIA+PLKA2IZ7ITpqjWn2OepjR154A4xUy
 1kyGitqbZ3cMUCBSkG+JRBujVxfCWuR0FoF0Uo2OL5mi2jLZFVhNCYjLw4cgg3I5gGem
 uN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725372895; x=1725977695;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ICqKvs+VaoNNZ4rmNaZLPPb3oqph3mMZod2yLficrk4=;
 b=YxdbmbaWETZ0HgbUsSh2J2bO1+2yxegyuLT1qI53AaJ3ePnBsKa1Csx6EtUbqTplA5
 LcAxgGPwBPv6n4fscfCO3h7By22bnEORMx+Mj4+RezPAOfRDm5MVnxhBOEKjuKUPWPtc
 4GGYgadr36L4XZU9qKRphl2Ng3MmmOGnRbCg4fIkJ477F+a6lOFNVx+mIOCIKK0RRS81
 cF5mVnYKHDKIEQ82wDOZ9ibqzntfbntmXFSPRIyh2vwjM9/tWt/ZyJBlqE3kKIcTwAVf
 W/dAMkGb9+VXctQBuzwRMo+OcqvZTmvRyQpqAUuPFZedYyKGXlFr5OnrlELYHXxX0tyH
 6tLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpLPna4yqvo6+m9bYRNR4jpHxwhHLLwtWwidlMJ3UUzbjxxwi/AY7x2njKU0kocjNvDUvGto7V1XDE@nongnu.org
X-Gm-Message-State: AOJu0Yw2cC0B1946/eR07e5xydrdTEYIIYNl8GxZAKUbexZt9EjTaNkI
 3cjuFEcMDlxGhP4IAEEnGH+v3J3CayzJq6U8QxVqwvV0368A9LPWlsQydfqkk4U=
X-Google-Smtp-Source: AGHT+IE9TkMMbifu1of1vOTn0lRQmANRKYo0/EwToSp8RzVVwq0h3fmUFpSgRejgCfIDSscnnzC6hw==
X-Received: by 2002:a05:600c:4455:b0:425:5ec3:570b with SMTP id
 5b1f17b1804b1-42bb01fcfb6mr122508085e9.35.1725372894932; 
 Tue, 03 Sep 2024 07:14:54 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374c29aa150sm8681832f8f.101.2024.09.03.07.14.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 07:14:54 -0700 (PDT)
Message-ID: <61555865-3bfb-4586-9f67-23110839f4ea@linaro.org>
Date: Tue, 3 Sep 2024 16:14:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 32/44] tests/functional: Convert the vnc test
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240830133841.142644-1-thuth@redhat.com>
 <20240830133841.142644-33-thuth@redhat.com>
 <a11813f6-6a11-4467-8f4f-1435f5284f28@linaro.org>
 <d72b302a-ec99-4eed-bd7b-cb79ec714a49@redhat.com>
 <c16b29e3-0d4b-4e3c-af58-240d29d13d8f@linaro.org>
Content-Language: en-US
In-Reply-To: <c16b29e3-0d4b-4e3c-af58-240d29d13d8f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/9/24 15:45, Philippe Mathieu-Daudé wrote:
> On 2/9/24 12:23, Thomas Huth wrote:
>> On 02/09/2024 11.48, Philippe Mathieu-Daudé wrote:
>>> On 30/8/24 15:38, Thomas Huth wrote:
>>>> Nothing thrilling in here, it's just a straight forward conversion.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>   tests/functional/meson.build                     |  1 +
>>>>   tests/{avocado/vnc.py => functional/test_vnc.py} | 12 +++++++-----
>>>>   2 files changed, 8 insertions(+), 5 deletions(-)
>>>>   rename tests/{avocado/vnc.py => functional/test_vnc.py} (97%)
>>>>   mode change 100644 => 100755
>>>>
>>>> diff --git a/tests/functional/meson.build 
>>>> b/tests/functional/meson.build
>>>> index 34a9b277f8..58f6bcf95d 100644
>>>> --- a/tests/functional/meson.build
>>>> +++ b/tests/functional/meson.build
>>>> @@ -107,6 +107,7 @@ tests_x86_64_system_quick = [
>>>>     'pc_cpu_hotplug_props',
>>>>     'virtio_version',
>>>>     'x86_cpu_model_versions',
>>>> +  'vnc',
>>>>   ]
>>>>   tests_x86_64_system_thorough = [
>>>> diff --git a/tests/avocado/vnc.py b/tests/functional/test_vnc.py
>>>> old mode 100644
>>>> new mode 100755
>>>> similarity index 97%
>>>> rename from tests/avocado/vnc.py
>>>> rename to tests/functional/test_vnc.py
>>>> index 862c8996a8..b769d3b268
>>>> --- a/tests/avocado/vnc.py
>>>> +++ b/tests/functional/test_vnc.py
>>>> @@ -1,3 +1,5 @@
>>>> +#!/usr/bin/env python3
>>>> +#
>>>>   # Simple functional tests for VNC functionality
>>>>   #
>>>>   # Copyright (c) 2018 Red Hat, Inc.
>>>> @@ -11,7 +13,7 @@
>>>>   import socket
>>>>   from typing import List
>>>> -from avocado_qemu import QemuSystemTest
>>>> +from qemu_test import QemuSystemTest
>>>>   VNC_ADDR = '127.0.0.1'
>>>> @@ -51,10 +53,7 @@ def find_free_ports(count: int) -> List[int]:
>>>>   class Vnc(QemuSystemTest):
>>>> -    """
>>>> -    :avocado: tags=vnc,quick
>>>> -    :avocado: tags=machine:none
>>>> -    """
>>>> +
>>>>       def test_no_vnc(self):
>>>>           self.vm.add_args('-nodefaults', '-S')
>>>>           self.vm.launch()
>>>> @@ -113,3 +112,6 @@ def test_change_listen(self):
>>>>           self.assertFalse(check_connect(a))
>>>>           self.assertTrue(check_connect(b))
>>>>           self.assertTrue(check_connect(c))
>>>> +
>>>> +if __name__ == '__main__':
>>>> +    QemuSystemTest.main()
>>>
>>> For a faithful conversion we need to squash:
>>>
>>> -- >8 --
>>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>>> index 6b00d240dd..a590646adc 100644
>>> --- a/tests/functional/meson.build
>>> +++ b/tests/functional/meson.build
>>> @@ -26,6 +26,7 @@ tests_generic_system = [
>>>     'empty_cpu_model',
>>>     'info_usernet',
>>>     'version',
>>> +  'vnc',
>>>   ]
>>>
>>>   tests_generic_linuxuser = [
>>> @@ -123,7 +124,6 @@ tests_x86_64_system_quick = [
>>>     'pc_cpu_hotplug_props',
>>>     'virtio_version',
>>>     'x86_cpu_model_versions',
>>> -  'vnc',
>>>   ]
>>>
>>> ---
>>>
>>> (each test is <1s so I'd keep it generic).
>>
>> Unfortunately that doesn't really work - the test cannot be really be 
>> run in parallel since the find_free_ports() stuff here is racy.
> 
> Oh right, I ran check-functional-{arm,mips,...} with at most 3 targets
> but never tried the full 'check-functional'.

Also I just noticed this test doesn't explicit machine, so when
a target don't have a default we get:

  Exit code: 1
  Command: qemu-system-arm -display none -vga none -chardev 
socket,id=mon,fd=14 -mon chardev=mon,mode=control -nodefaults -S
  Output: qemu-system-arm: No machine specified, and there is no default

