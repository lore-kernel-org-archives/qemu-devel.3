Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1058CCFA03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 06:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGtVy-0005j2-Eb; Thu, 06 Nov 2025 01:30:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vGtVu-0005im-7y
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 01:30:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vGtVq-0000hb-MF
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 01:30:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762410620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jIwfKICxB3hYZYC5IAyimFz9wwciky7qc8FRWjv9zaI=;
 b=TFfBb6E0+7JBbG0+uHDETKzUcgog+N3ZTFj2ch+z5wvmkkoKa9XPVUY0KgMjytitbEkB3N
 bTNOdnBF4SCtwP92dwIy2YOg6aQc+cr/fF3evyyW2UHbRzAauxdrNSUO5qdgAce5c2dKcM
 OUsEau7Ex39jk5J1UTXTzyi/qQo/FPQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-y-6JRpdeNxmOxuZFGyelAg-1; Thu, 06 Nov 2025 01:30:18 -0500
X-MC-Unique: y-6JRpdeNxmOxuZFGyelAg-1
X-Mimecast-MFC-AGG-ID: y-6JRpdeNxmOxuZFGyelAg_1762410617
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b7269620cc6so149721666b.1
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 22:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762410617; x=1763015417; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=jIwfKICxB3hYZYC5IAyimFz9wwciky7qc8FRWjv9zaI=;
 b=Dy8Thar512sVPe+/T/xn8jGoYgpOhqU1kZRMyQ1UnSREgA2tnOCDsovbuM4pw9/Du3
 +O7Xv2mco2X+62lP1e1ave+coow2uVNF5fRTqB9Udjj1wTcX+SIll5vutmXR/EVJxUd9
 N9GM7N45T5s2G4KqUkclQdqUv7qmKad7rLwXs6cTSM/Yh9cRCZECnkyaS5GiMU9N1k4n
 RgGBsx2+D7DasvxFQtP62re/EKok3p/ENOLEpyN1gUaWpfZZnYAQ6PuEKVmuCVjHUtZo
 fLihvO0NI/Pjn2cR6Uutl7mVsoyZKyCoqdTJjt+OsRxl9uLwTImHBMb3S4z+QfdXaGl2
 DZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762410617; x=1763015417;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jIwfKICxB3hYZYC5IAyimFz9wwciky7qc8FRWjv9zaI=;
 b=ZJ1iix3tNHuMOEj6JOYiudgORq0QwEzgxX6bAIyOlLYqZMwpdJH5lHbF7zlLhJ+xc3
 XYOWwozVwVWWuN0G85PW96j7c3fhRK6keuITJu3T40nVh3KQvdpeFUYfOmOWSdMSJdSv
 4DtVPDbx+nFQP9y/TUHr4lUZ0DgI7OW8MB/kisVTqvh6slwr/BMGizo4uMo2qaVmYqpX
 BZ0KgwjUB1oRDQ6fBCtIKY+slOXP3736pgziHzitEg75LpleadjKZCROQhV0Un/pG/jR
 pa7VsxBvgxS2da/OJZa2Dh7uHgJfGILfZBAkDwYvwiAAuZz1iHnj+R8HxmBb411YCV6U
 grAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO4PSzmJJFn9KBxKRDVJKVDbE6+6W7lzod5FmyHBIcIeTgkqtzhDelWuOaKXh10/sNnThobTA2f6Ro@nongnu.org
X-Gm-Message-State: AOJu0YxSp/4obbI87O8l3F7G6j1Hpwui3AVzrta8p9CJ9sRa05ww3AgW
 1t+LebKWoco0CTKkaBaUWqjPhn2eGXgzqEtUAY2tvsCoc6fk+rdnj9UqWllwPIBmcu078NvAjAk
 F2LDrak1B7TvC9mARvYZA4Y7JjSmcLM6zkrJw7df1VTQyEhtqCjfuqsb3
X-Gm-Gg: ASbGnctiNfYoxSI+7/sfL/RUYCGnBQ69bk/c3xuLkkXLlpwN06JDz5VABJdpw6CmNwI
 RH3Y4XIc16oXIUU7IGyMY1G3UAHaEQTO0QtHxenXpWrCQ7ORplxRrURv2UumF5o85NLj1BnWx8u
 SroSRae1rHugc4kgsCsplnJMtr/EoASyamSb3GpOoAUTWtxoWsLEPYxkDopoxPIyW3vsxB1N2qp
 blpzUHQKXwIttCqhCvnnFgzWVnvcx22pJxxJ5NcBwSIBRT/no9llfASorXOEVZwaeuBYw/1u/SI
 AX6uaMZOA0TwIZJsnRCUlvLxIUjwM8JHXV31WIQJvshCUgSsaptEdQhU0t3Iz72cR5JEnjAY6nQ
 b7ygaIheQih/Pi7QA52rBvj4j53Ai0Glsb61lc/Hhx3doT7Qlv7oh8xP2k4ayZd+xi7ep/TQ+IO
 LDpvPY1A7jxYHMr5Y8yd2ECGS7d9yb
X-Received: by 2002:a17:907:ea7:b0:b72:190d:b645 with SMTP id
 a640c23a62f3a-b72656bf60cmr651128166b.57.1762410616998; 
 Wed, 05 Nov 2025 22:30:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFBlUGFo5jpa6ng+yjAI9O435Jeuk2TJohOUAFNccNtEn7OCBQA3+XLIcZ0LzB+a+lyd5ukw==
X-Received: by 2002:a17:907:ea7:b0:b72:190d:b645 with SMTP id
 a640c23a62f3a-b72656bf60cmr651124466b.57.1762410616531; 
 Wed, 05 Nov 2025 22:30:16 -0800 (PST)
Received: from ?IPV6:2003:c1:b731:ac01:f439:afb3:7d4f:72d9?
 (p200300c1b731ac01f439afb37d4f72d9.dip0.t-ipconnect.de.
 [2003:c1:b731:ac01:f439:afb3:7d4f:72d9])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6411f86e12fsm1057652a12.34.2025.11.05.22.30.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 22:30:16 -0800 (PST)
Message-ID: <dbc361e6-382f-4a0b-ae18-c93c3e9629bd@redhat.com>
Date: Thu, 6 Nov 2025 07:30:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/x86_64/test_virtio_gpu: Fix various
 issues reported by pylint
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20251105120951.15815-1-thuth@redhat.com>
 <7e87716a-45e6-47c0-8d74-8fc87b2e61ee@rsg.ci.i.u-tokyo.ac.jp>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <7e87716a-45e6-47c0-8d74-8fc87b2e61ee@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 06/11/2025 03.34, Akihiko Odaki wrote:
> On 2025/11/05 21:09, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> Use the recommended order for import statements, specify the kind of
>> exceptions that we try to catch, use f-strings where it makes sense,
>> rewrite the vug_log_file part with a proper "with" statement and
>> fix some FIXMEs by checking for the availability of the devices, etc.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/functional/x86_64/test_virtio_gpu.py | 46 +++++++++++-----------
>>   1 file changed, 23 insertions(+), 23 deletions(-)
>>
>> diff --git a/tests/functional/x86_64/test_virtio_gpu.py b/tests/ 
>> functional/x86_64/test_virtio_gpu.py
>> index be96de24da2..a25f15cdb00 100755
>> --- a/tests/functional/x86_64/test_virtio_gpu.py
>> +++ b/tests/functional/x86_64/test_virtio_gpu.py
>> @@ -5,22 +5,23 @@
>>   # This work is licensed under the terms of the GNU GPL, version 2 or
>>   # later.  See the COPYING file in the top-level directory.
>> +import os
>> +import socket
>> +import subprocess
>>   from qemu_test import QemuSystemTest, Asset
>>   from qemu_test import wait_for_console_pattern
>>   from qemu_test import exec_command_and_wait_for_pattern
>>   from qemu_test import is_readable_executable_file
>> -
>> -import os
>> -import socket
>> -import subprocess
>> +from qemu.machine.machine import VMLaunchFailure
>>   def pick_default_vug_bin(test):
>>       bld_dir_path = test.build_file("contrib", "vhost-user-gpu", "vhost- 
>> user-gpu")
>>       if is_readable_executable_file(bld_dir_path):
>>           return bld_dir_path
>> +    return None
>>   class VirtioGPUx86(QemuSystemTest):
>> @@ -46,8 +47,8 @@ def wait_for_console_pattern(self, success_message, 
>> vm=None):
>>           )
>>       def test_virtio_vga_virgl(self):
>> -        # FIXME: should check presence of virtio, virgl etc
>>           self.require_accelerator('kvm')
>> +        self.require_device('virtio-vga-gl')
>>           kernel_path = self.ASSET_KERNEL.fetch()
>>           initrd_path = self.ASSET_INITRD.fetch()
>> @@ -68,7 +69,7 @@ def test_virtio_vga_virgl(self):
>>           )
>>           try:
>>               self.vm.launch()
>> -        except:
>> +        except VMLaunchFailure:
>>               # TODO: probably fails because we are missing the VirGL 
>> features
>>               self.skipTest("VirGL not enabled?")
>> @@ -78,8 +79,8 @@ def test_virtio_vga_virgl(self):
>>           )
>>       def test_vhost_user_vga_virgl(self):
>> -        # FIXME: should check presence of vhost-user-gpu, virgl, memfd etc
>>           self.require_accelerator('kvm')
>> +        self.require_device('vhost-user-vga')
>>           vug = pick_default_vug_bin(self)
>>           if not vug:
>> @@ -95,27 +96,26 @@ def test_vhost_user_vga_virgl(self):
>>           os.set_inheritable(qemu_sock.fileno(), True)
>>           os.set_inheritable(vug_sock.fileno(), True)
>> -        self._vug_log_path = self.log_file("vhost-user-gpu.log")
>> -        self._vug_log_file = open(self._vug_log_path, "wb")
>> -        self.log.info('Complete vhost-user-gpu.log file can be '
>> -                      'found at %s', self._vug_log_path)
>> -
>> -        vugp = subprocess.Popen(
>> -            [vug, "--virgl", "--fd=%d" % vug_sock.fileno()],
>> -            stdin=subprocess.DEVNULL,
>> -            stdout=self._vug_log_file,
>> -            stderr=subprocess.STDOUT,
>> -            shell=False,
>> -            close_fds=False,
>> -        )
>> -        self._vug_log_file.close()
>> +        vug_log_path = self.log_file("vhost-user-gpu.log")
>> +        self.log.info('Complete vhost-user-gpu.log file can be found at %s',
>> +                      vug_log_path)
>> +        with open(vug_log_path, "wb") as vug_log_file:
>> +            # pylint: disable=consider-using-with
>> +            vugp = subprocess.Popen(
>> +                [vug, "--virgl", f"--fd={vug_sock.fileno()}"],
>> +                stdin=subprocess.DEVNULL,
>> +                stdout=vug_log_file,
>> +                stderr=subprocess.STDOUT,
>> +                shell=False,
>> +                close_fds=False,
>> +            )
> 
> Let's use with for subproces.Popen() too.
> 
> You may leave vug_log_file.close() after subprocess.Popen(); if 
> subprocess.Popen() raises an exception, the with statement for vug_log_file 
> will close the file. Otherwise, the vug_log_file.close() after 
> subprocess.Popen() will close it and the with statement for vug_log_file 
> will be no-op; the documentation says it is allowed to call IOBase.call() 
> twice:
> https://docs.python.org/3.14/library/io.html#io.IOBase.close

Not quite sure whether I got your point, but the "vugp" variable is still 
used later in the function to terminate the subprocess manually. So if we 
really want to use a "when" here, I guess I have to move the whole remaining 
part of this function into the "when" block, don't I? Is that what you are 
suggesting?

  Thomas


>>           self.vm.set_console()
>>           self.vm.add_args("-cpu", "host")
>>           self.vm.add_args("-m", "2G")
>>           self.vm.add_args("-object", "memory-backend-memfd,id=mem,size=2G")
>>           self.vm.add_args("-machine", "pc,memory-backend=mem,accel=kvm")
>> -        self.vm.add_args("-chardev", "socket,id=vug,fd=%d" % 
>> qemu_sock.fileno())
>> +        self.vm.add_args("-chardev", 
>> f"socket,id=vug,fd={qemu_sock.fileno()}")
>>           self.vm.add_args("-device", "vhost-user-vga,chardev=vug")
>>           self.vm.add_args("-display", "egl-headless")
>>           self.vm.add_args(
>> @@ -128,7 +128,7 @@ def test_vhost_user_vga_virgl(self):
>>           )
>>           try:
>>               self.vm.launch()
>> -        except:
>> +        except VMLaunchFailure:
>>               # TODO: probably fails because we are missing the VirGL 
>> features
>>               self.skipTest("VirGL not enabled?")
>>           self.wait_for_console_pattern("as init process")
> 


