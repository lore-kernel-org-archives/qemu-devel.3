Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BDECD343D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 14:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slUJt-00089p-4l; Tue, 03 Sep 2024 10:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slUJr-00081s-QF
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:15:43 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slUJp-00013S-2Y
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:15:43 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42bac9469e8so44458285e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 07:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725372939; x=1725977739; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3sE49CX3Ia22xbpTNXwA/nIQ0+NOwZ73kDBYhYhSInA=;
 b=RVUN70u9W3vylc9uEtFtY5rxlEAFy2i9bKXQqhSYTQ3O5NZL+hYv45XSwUOfPRDTkl
 WodXvPD93CXIZ083mLAQSpS3T0ajfxFik1yg2zrrAq+z1joq0iWzH/lNu3Ybq05fRkUv
 ohJzRu2y8P8yesdOkTRBKLBUY6rIjHaowxhW1VZ9ugUhMaw2TNOfNMMIMttmELEjvc3F
 iFtGFS4axS629Q9eHps2NfAlxbZnjfjrSiRQWo1oCdUze/pOxKy1OkV8U5ed9HMGkcO4
 gCSExA4+eMLJ8JuCT0/vPm4+/GslKbGUGhODt0AHzKDlkuKE4PiOCYTqb4jhgM6G+Psr
 BrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725372939; x=1725977739;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3sE49CX3Ia22xbpTNXwA/nIQ0+NOwZ73kDBYhYhSInA=;
 b=K9XsZDRgac6GTXjwi3LuLASVjgQzFxG0n7Lohr4aRIicBOacVMlJ7e7cXAb3r67a8L
 HG2eFAt75Xy77z9XocGok2KtKnIwYArfNKibBZ5LCmhxB9CYrUU55GZLhpNPLLsn7r29
 GcnRyOF1Q8BDMtPgrUCPKJRMvG9FVBKn7qQrpnYoP3o00s7JxluGY1Uw7/RuCNTAWS6X
 QeVOFFA+5eFxw/p1cxNMymWqWkr7s9RxRPaLs/rJCP56n95scU7dWxDjnINWUVjc/MzV
 h7FdaRW+HoJcwzk23GDWOYMob+aVCK5+cpfvghMwwp2uR5TYdo2x/zwHoW8C0tsCKVDA
 vMaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkDGuKG/eamg7A1qFD4hjdamvxTyLM6VrKJp5YID/+yqOYIwbLcWNWVyuWK4Qaj0leiEwbbjvQ4mzr@nongnu.org
X-Gm-Message-State: AOJu0YyB9UoRqYLHPcXCJ5gjEu5BpRqFe/1G2dVYe3o+n7ryWkXLZoWt
 bpUXlXnrCnj3EySNNKuFXCn13b/zopNJBO1pEbxXhjLCNjJF6KgHNP5zBqdbW++TTloAmxmd4fj
 R
X-Google-Smtp-Source: AGHT+IFECFyz3ddJyEpC4epqmSydLdklmPQgk3MPgzehrhNQ6swcmK3K+Nn0YVphfsRcjKsBGIhCiQ==
X-Received: by 2002:a05:600c:4fcf:b0:426:5269:9838 with SMTP id
 5b1f17b1804b1-42c82f47db9mr58389635e9.4.1725371117332; 
 Tue, 03 Sep 2024 06:45:17 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6deb1ebsm172108855e9.3.2024.09.03.06.45.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 06:45:16 -0700 (PDT)
Message-ID: <c16b29e3-0d4b-4e3c-af58-240d29d13d8f@linaro.org>
Date: Tue, 3 Sep 2024 15:45:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 32/44] tests/functional: Convert the vnc test
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
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d72b302a-ec99-4eed-bd7b-cb79ec714a49@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 2/9/24 12:23, Thomas Huth wrote:
> On 02/09/2024 11.48, Philippe Mathieu-Daudé wrote:
>> On 30/8/24 15:38, Thomas Huth wrote:
>>> Nothing thrilling in here, it's just a straight forward conversion.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   tests/functional/meson.build                     |  1 +
>>>   tests/{avocado/vnc.py => functional/test_vnc.py} | 12 +++++++-----
>>>   2 files changed, 8 insertions(+), 5 deletions(-)
>>>   rename tests/{avocado/vnc.py => functional/test_vnc.py} (97%)
>>>   mode change 100644 => 100755
>>>
>>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>>> index 34a9b277f8..58f6bcf95d 100644
>>> --- a/tests/functional/meson.build
>>> +++ b/tests/functional/meson.build
>>> @@ -107,6 +107,7 @@ tests_x86_64_system_quick = [
>>>     'pc_cpu_hotplug_props',
>>>     'virtio_version',
>>>     'x86_cpu_model_versions',
>>> +  'vnc',
>>>   ]
>>>   tests_x86_64_system_thorough = [
>>> diff --git a/tests/avocado/vnc.py b/tests/functional/test_vnc.py
>>> old mode 100644
>>> new mode 100755
>>> similarity index 97%
>>> rename from tests/avocado/vnc.py
>>> rename to tests/functional/test_vnc.py
>>> index 862c8996a8..b769d3b268
>>> --- a/tests/avocado/vnc.py
>>> +++ b/tests/functional/test_vnc.py
>>> @@ -1,3 +1,5 @@
>>> +#!/usr/bin/env python3
>>> +#
>>>   # Simple functional tests for VNC functionality
>>>   #
>>>   # Copyright (c) 2018 Red Hat, Inc.
>>> @@ -11,7 +13,7 @@
>>>   import socket
>>>   from typing import List
>>> -from avocado_qemu import QemuSystemTest
>>> +from qemu_test import QemuSystemTest
>>>   VNC_ADDR = '127.0.0.1'
>>> @@ -51,10 +53,7 @@ def find_free_ports(count: int) -> List[int]:
>>>   class Vnc(QemuSystemTest):
>>> -    """
>>> -    :avocado: tags=vnc,quick
>>> -    :avocado: tags=machine:none
>>> -    """
>>> +
>>>       def test_no_vnc(self):
>>>           self.vm.add_args('-nodefaults', '-S')
>>>           self.vm.launch()
>>> @@ -113,3 +112,6 @@ def test_change_listen(self):
>>>           self.assertFalse(check_connect(a))
>>>           self.assertTrue(check_connect(b))
>>>           self.assertTrue(check_connect(c))
>>> +
>>> +if __name__ == '__main__':
>>> +    QemuSystemTest.main()
>>
>> For a faithful conversion we need to squash:
>>
>> -- >8 --
>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>> index 6b00d240dd..a590646adc 100644
>> --- a/tests/functional/meson.build
>> +++ b/tests/functional/meson.build
>> @@ -26,6 +26,7 @@ tests_generic_system = [
>>     'empty_cpu_model',
>>     'info_usernet',
>>     'version',
>> +  'vnc',
>>   ]
>>
>>   tests_generic_linuxuser = [
>> @@ -123,7 +124,6 @@ tests_x86_64_system_quick = [
>>     'pc_cpu_hotplug_props',
>>     'virtio_version',
>>     'x86_cpu_model_versions',
>> -  'vnc',
>>   ]
>>
>> ---
>>
>> (each test is <1s so I'd keep it generic).
> 
> Unfortunately that doesn't really work - the test cannot be really be 
> run in parallel since the find_free_ports() stuff here is racy.

Oh right, I ran check-functional-{arm,mips,...} with at most 3 targets
but never tried the full 'check-functional'.

> 
>   Thomas
> 
> 


