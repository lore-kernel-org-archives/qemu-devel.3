Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAC6E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 15:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJadm-0001v8-Le; Fri, 06 Dec 2024 10:53:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tJadj-0001rr-VX
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:53:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tJadg-0005GX-OJ
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:53:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733500387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UmtljETE3Lu/CsL5Ljz72p7WfbaBTGHbOnGNfqvQo5w=;
 b=JA2o2drtl7uNvH/LycvzaV31Jdb8lI9od5Zm094+i4/SQl7h4QxsLeVJxrWWTXHKtbOqwA
 J3xLJwfbmGps9h3C/ez00gUJ0Rb6pjdljfqibmzEv0CGwE8R7+bCEY9sdsEV+iQ/hA9721
 fTGSX1p3BLHbzyvx2kGzcAOXCoPzGRY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-8ZlyUGK7MhaFTdzMMcRPFQ-1; Fri, 06 Dec 2024 10:53:04 -0500
X-MC-Unique: 8ZlyUGK7MhaFTdzMMcRPFQ-1
X-Mimecast-MFC-AGG-ID: 8ZlyUGK7MhaFTdzMMcRPFQ
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3862a49fbdaso504045f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 07:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733500383; x=1734105183;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UmtljETE3Lu/CsL5Ljz72p7WfbaBTGHbOnGNfqvQo5w=;
 b=MFbyesISLrO24i2H0bj3W4zh0YwTfG8hXTEQl9pLrSCXo2iW9SbC4idwdxslFdIZaX
 NEstfrWS5F7iYzjJYDDitA4VObGQlf4biA+Ml8PCh14QF0pEVhXgjGhV9sjfxdBL69Oz
 oWE0e2m8e77FB9CpKHUKfQ8tekdSXIA+5xlIzMs+SHBmOLgtaqSkgDjY4spe49bd4D2y
 yi5CKbd6imhQviT3MnwaM+kwSkMGjdFNyew9iVMVMRigvvs5rLowD38mjyq+yH4+7Sz1
 J/Q4tAbUdHcoQJbuanlcunmN0eK0i9evu1VWqTghTbWk2ea8m4qGBm6BKg/L7rGYvjMF
 nAqA==
X-Gm-Message-State: AOJu0YwUPL+JvapcY9gUkj78POg4J6OCsjAdZIKSzlxOnT9IvEozSzN+
 0dtsukuSAy/PA6cGxxK/7TwGUI93ht53MzsqxB2TVyM58IEnwzDF/ljn3RdGKEqJAjGe1tMZKx8
 /mJ/AQanH5JVGLfjdEP24F6HZJDg0xyaxQXm6mem0QDM1vntO7WMx
X-Gm-Gg: ASbGnctJOLNeeWH1FtA5UZrg9ug85q3OO2MWJk+do/REpQfEf7cLRBC5PJ+nVHHI1EX
 U/zNagzHmJp3Jpzp6XnwX+KVhMPEbrNYDZuOieuPIzTVxW63rK/mnNKLbo9OZG0muiGeBJEDfmK
 qPK3C9asKurwxks+T+EssU8YwK5RwMhvJQ1pMF8k5hgWTF1d5b1NvUGuqjJnUVpExOsxPkZ5gCp
 vjrWC+Jb4el5+5UwQ2MUE/KRgd6ZrlKLreu8ZjgaCASHI5rvQUKLdC2+vMh30QcL4Unk46WkJn7
 d52hGA==
X-Received: by 2002:a05:6000:709:b0:386:1cd3:8a0e with SMTP id
 ffacd0b85a97d-3862b3e68bcmr2600146f8f.48.1733500383503; 
 Fri, 06 Dec 2024 07:53:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6HrEkr8pQbMNeVcHaamOosoZzjwDgbsGZzRqcxzLbd1TCogVQAiBaydNOQbgXFl3W6anU6A==
X-Received: by 2002:a05:6000:709:b0:386:1cd3:8a0e with SMTP id
 ffacd0b85a97d-3862b3e68bcmr2600128f8f.48.1733500383069; 
 Fri, 06 Dec 2024 07:53:03 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-244.web.vodafone.de.
 [109.42.48.244]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-386221a5eadsm4801059f8f.104.2024.12.06.07.53.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 07:53:02 -0800 (PST)
Message-ID: <cda5fa6d-6666-433b-a9ee-b1099b1bffd1@redhat.com>
Date: Fri, 6 Dec 2024 16:53:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] tests/functional: Extract the find_free_ports()
 function into a helper file
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20241204071911.664057-1-thuth@redhat.com>
 <20241204071911.664057-3-thuth@redhat.com> <Z1Axz2jQIX7kfn5C@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Z1Axz2jQIX7kfn5C@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 04/12/2024 11.41, Daniel P. Berrangé wrote:
> On Wed, Dec 04, 2024 at 08:19:08AM +0100, Thomas Huth wrote:
>> We'll need this functionality in other functional tests, too, so
>> let's extract it into the qemu_test module.
>> Also add  an __enter__ and __exit__ function that can be used for
>> using this functionality in a locked context, so that tests that
>> are running in parallel don't try to compete for the same ports
>> later.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/functional/qemu_test/ports.py | 53 +++++++++++++++++++++++++++++
>>   tests/functional/test_vnc.py        | 36 +++++---------------
>>   2 files changed, 61 insertions(+), 28 deletions(-)
>>   create mode 100644 tests/functional/qemu_test/ports.py
>>
>> diff --git a/tests/functional/qemu_test/ports.py b/tests/functional/qemu_test/ports.py
>> new file mode 100644
>> index 0000000000..d235d3432b
>> --- /dev/null
>> +++ b/tests/functional/qemu_test/ports.py
>> @@ -0,0 +1,53 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Simple functional tests for VNC functionality
>> +#
>> +# Copyright 2018, 2024 Red Hat, Inc.
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>> +# later.  See the COPYING file in the top-level directory.
>> +
>> +import fcntl
>> +import os
>> +import socket
>> +import sys
>> +import tempfile
>> +from typing import List
>> +
>> +class Ports():
>> +
>> +    PORTS_ADDR = '127.0.0.1'
>> +    PORTS_START = 32768
>> +    PORTS_END = PORTS_START + 1024
>> +
>> +    def __enter__(self):
>> +        lock_file = os.path.join(tempfile.gettempdir(), "qemu_port_lock")
>> +        self.lock_fh = os.open(lock_file, os.O_CREAT)
>> +        fcntl.flock(self.lock_fh, fcntl.LOCK_EX)
>> +        return self
>> +
>> +    def __exit__(self, exc_type, exc_value, traceback):
>> +        fcntl.flock(self.lock_fh, fcntl.LOCK_UN)
>> +        os.close(self.lock_fh)
>> +
>> +    def check_bind(self, port: int) -> bool:
>> +        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
>> +            try:
>> +                sock.bind((self.PORTS_ADDR, port))
>> +            except OSError:
>> +                return False
>> +
>> +        return True
>> +
>> +    def find_free_ports(self, count: int) -> List[int]:
>> +        result = []
>> +        for port in range(self.PORTS_START, self.PORTS_END):
>> +            if self.check_bind(port):
>> +                result.append(port)
>> +                if len(result) >= count:
>> +                    break
>> +        assert len(result) == count
>> +        return result
>> +
>> +    def find_free_port(self) -> int:
>> +        return self.find_free_ports(1)[0]
>> diff --git a/tests/functional/test_vnc.py b/tests/functional/test_vnc.py
>> index b769d3b268..32a81259e4 100755
>> --- a/tests/functional/test_vnc.py
>> +++ b/tests/functional/test_vnc.py
>> @@ -14,22 +14,9 @@
>>   from typing import List
>>   
>>   from qemu_test import QemuSystemTest
>> -
>> +from qemu_test.ports import Ports
>>   
>>   VNC_ADDR = '127.0.0.1'
>> -VNC_PORT_START = 32768
>> -VNC_PORT_END = VNC_PORT_START + 1024
>> -
>> -
>> -def check_bind(port: int) -> bool:
>> -    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
>> -        try:
>> -            sock.bind((VNC_ADDR, port))
>> -        except OSError:
>> -            return False
>> -
>> -    return True
>> -
>>   
>>   def check_connect(port: int) -> bool:
>>       with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
>> @@ -40,18 +27,6 @@ def check_connect(port: int) -> bool:
>>   
>>       return True
>>   
>> -
>> -def find_free_ports(count: int) -> List[int]:
>> -    result = []
>> -    for port in range(VNC_PORT_START, VNC_PORT_END):
>> -        if check_bind(port):
>> -            result.append(port)
>> -            if len(result) >= count:
>> -                break
>> -    assert len(result) == count
>> -    return result
>> -
>> -
>>   class Vnc(QemuSystemTest):
>>   
>>       def test_no_vnc(self):
>> @@ -90,8 +65,7 @@ def test_change_password(self):
>>           self.vm.cmd('change-vnc-password',
>>                       password='new_password')
>>   
>> -    def test_change_listen(self):
>> -        a, b, c = find_free_ports(3)
>> +    def do_test_change_listen(self, a, b, c):
>>           self.assertFalse(check_connect(a))
>>           self.assertFalse(check_connect(b))
>>           self.assertFalse(check_connect(c))
>> @@ -113,5 +87,11 @@ def test_change_listen(self):
>>           self.assertTrue(check_connect(b))
>>           self.assertTrue(check_connect(c))
>>   
>> +    def test_change_listen(self):
>> +        with Ports() as ports:
>> +            a, b, c = ports.find_free_ports(3)
>> +            self.do_test_change_listen(a, b, c)
> 
> I think it would be possible to implement a decorator using "Ports"
> such that we don't need to manually wrap the methods, and just receive
> the list of port numbers as arguments.
> 
> eg to make this pattern with:
> 
>      @findFreePorts(3)
>      def test_change_listen(self, ports):
>           ....use 'ports' list ....
> 
> Fully untested, but I think something approximately like this would
> work:
> 
>     def findFreePorts(num)
>       def findFreePortsDeco(func):
>         def wrapper(*args, **kwargs):
>           with Ports() as ports:
> 	   freeports = ports.find_free_ports(num)
> 	   func(freeports, *args, **kwargs)
>         return wrapper
>       return findFreePortsDeco

Being mainly a C coder, I think I'd rather avoid getting into too much 
Python magic like such a decorator in the functional tests, to avoid scaring 
the Python ignorants (like I have been in the past) too much ;-)

  Thomas


