Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A9EC54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 10:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI3Hh-0001Pr-RP; Thu, 22 May 2025 06:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1uI3Hg-0001OS-8c
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:36:20 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1uI3Hd-0007Hs-0q
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:36:19 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cca4:0:640:432b:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 50BA162104;
 Thu, 22 May 2025 13:36:09 +0300 (MSK)
Received: from [IPV6:2a02:6bf:803e:400:5ed1:ca1a:388:8e9e] (unknown
 [2a02:6bf:803e:400:5ed1:ca1a:388:8e9e])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 6aMdAo0FZKo0-uIr8e8gV; Thu, 22 May 2025 13:36:08 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1747910168;
 bh=4wjfaexxVWBo+0ALNAAUr/GcPGU8Bd+MmwKvZNQalCI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Ur125VhqUf0W3x/q2A5+QtGiJvXeM/ifMsB+rs5/brWJ9d2v9OLPIf9e8GgsNwqal
 CTCcZGEMeMr7AHyJ8tD3QT6/rMSL296ZWyPZe7ibqg/K6p5TFTlFrpq2blnvGcGr9/
 21cBMeshCn6mWYOxr7Ii4UGCj1zlJpfOGBBXNbl8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f73a0380-d594-4237-a547-4b8ec531224f@yandex-team.ru>
Date: Thu, 22 May 2025 15:36:06 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] tests/functional: add memlock tests
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250521135522.11180-1-dtalexundeer@yandex-team.ru>
 <20250521135522.11180-3-dtalexundeer@yandex-team.ru>
 <430eaa84-5695-4fc2-90d5-d488a204e999@redhat.com>
 <af6b28bd-44cf-4540-b5f8-49d8b2781e13@yandex-team.ru>
 <0e4a5fe1-186b-4c69-87d0-9b0743d795b7@redhat.com>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <0e4a5fe1-186b-4c69-87d0-9b0743d795b7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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


On 5/22/25 14:16, Thomas Huth wrote:
> On 22/05/2025 10.51, Alexandr Moshkov wrote:
>>
>> On 5/22/25 12:49, Thomas Huth wrote:
>>> On 21/05/2025 15.55, Alexandr Moshkov wrote:
>>>> Add new tests to check the correctness of the `-overcommit memlock`
>>>> option (possible values: off, on, on-fault) by using
>>>> `/proc/{qemu_pid}/smaps` file to check in Size, Rss and Locked 
>>>> fields of
>>>> anonymous segments:
>>>>
>>>> * if `memlock=off`, then Locked = 0 on every anonymous smaps;
>>>> * if `memlock=on`, then Size, Rss and Locked values must be equal for
>>>> every anon smaps where Rss is not 0;
>>>> * if `memlock=on-fault`, then Rss and Locked must be equal on every 
>>>> anon
>>>> smaps and anonymous segment with Rss < Size must exists.
>>>>
>>>> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
>>>> ---
>>> ...
>>>> diff --git a/tests/functional/test_memlock.py b/tests/functional/ 
>>>> test_memlock.py
>>>> new file mode 100755
>>>> index 0000000000..a090e7f9ad
>>>> --- /dev/null
>>>> +++ b/tests/functional/test_memlock.py
>>>> @@ -0,0 +1,107 @@
>>>> +#!/usr/bin/env python3
>>>> +#
>>>> +# Functional test that check overcommit memlock options
>>>> +#
>>>> +# Copyright (c) Yandex Technologies LLC, 2025
>>>> +#
>>>> +# Author:
>>>> +#  Alexandr Moshkov <dtalexundeer@yandex-team.ru>
>>>> +#
>>>> +#
>>>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>>>> +# later.  See the COPYING file in the top-level directory.
>>>
>>> I just noticed: New file need a SPDX identifier nowadays to keep 
>>> scripts/ check_patch.pl happy.
>>
>> Hello, thanks for reply, i fix that in a moment!
>>
>>>
>>> Anyway, I now also tested the patch, but for me, it's not working: 
>>> After setting ulimit -l to 2G and running the test, I get:
>>>
>>> $ ~/devel/qemu/tests/functional/test_memlock.py
>>> TAP version 13
>>> ok 1 test_memlock.MemlockTest.test_memlock_off
>>> Traceback (most recent call last):
>>>   File "~/devel/qemu/tests/functional/test_memlock.py", line 60, in 
>>> test_memlock_on
>>>     self.assertTrue(smap['Size'] == smap['Rss'] == smap['Locked'])
>>> ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>> AssertionError: False is not true
>>>
>>> not ok 2 test_memlock.MemlockTest.test_memlock_on
>>> Traceback (most recent call last):
>>>   File "~/devel/qemu/tests/functional/test_memlock.py", line 70, in 
>>> test_memlock_onfault
>>>     self.assertTrue(smap['Rss'] == smap['Locked'])
>>>     ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>> AssertionError: False is not true
>>>
>>> not ok 3 test_memlock.MemlockTest.test_memlock_onfault
>>>
>>> I added two print statements right in front of the asserts to see 
>>> the values, and for the first one it shows (after many successfully 
>>> comparisons):
>>>
>>> line 60: 4 == 4 == 0
>>>
>>> And similar for the second one:
>>>
>>> line 70: 4 == 0
>>>
>>> FWIW, this is on Fedora 41.
>>>
>>> Looking at the smaps file, it seems like this comes from a shared 
>>> library:
>>>
>>> 7ff16c7c9000-7ff16c7ca000 r--p 00000000 00:2a 29149631 
>>> /usr/lib64/spa-0.2/ support/libspa-support.so
>>> Size:                  4 kB
>>> KernelPageSize:        4 kB
>>> MMUPageSize:           4 kB
>>> Rss:                   4 kB
>>> Pss:                   0 kB
>>> Pss_Dirty:             0 kB
>>> Shared_Clean:          4 kB
>>> Shared_Dirty:          0 kB
>>> Private_Clean:         0 kB
>>> Private_Dirty:         0 kB
>>> Referenced:            4 kB
>>> Anonymous:             0 kB
>>> KSM:                   0 kB
>>> LazyFree:              0 kB
>>> AnonHugePages:         0 kB
>>> ShmemPmdMapped:        0 kB
>>> FilePmdMapped:         0 kB
>>> Shared_Hugetlb:        0 kB
>>> Private_Hugetlb:       0 kB
>>> Swap:                  0 kB
>>> SwapPss:               0 kB
>>> Locked:                0 kB
>>> THPeligible:           0
>>> ProtectionKey:         0
>>>
>>> So maybe you've got to ignore the mappings of .so files in your test?
>>
>> Oh, this segments are already ignored in _parse_anonymous_smaps(), so 
>> this segment should not have returned from it.
>>
>> Maybe it comes from another segment? Or i have bug in anon segments 
>> parsing.. I'll take a closer look, thanks.
>
> Yes, it seems to be another segment. After looking through the smaps a 
> little bit longer, I also spotted this one here:
>
> 7f8fcc6a1000-7f8fcc6a2000 rw-p 00000000 00:00 0
> Size:                  4 kB
> KernelPageSize:        4 kB
> MMUPageSize:           4 kB
> Rss:                   4 kB
> Pss:                   4 kB
> Pss_Dirty:             4 kB
> Shared_Clean:          0 kB
> Shared_Dirty:          0 kB
> Private_Clean:         0 kB
> Private_Dirty:         4 kB
> Referenced:            4 kB
> Anonymous:             4 kB
> KSM:                   0 kB
> LazyFree:              0 kB
> AnonHugePages:         0 kB
> ShmemPmdMapped:        0 kB
> FilePmdMapped:         0 kB
> Shared_Hugetlb:        0 kB
> Private_Hugetlb:       0 kB
> Swap:                  0 kB
> SwapPss:               0 kB
> Locked:                0 kB
> THPeligible:           0
> ProtectionKey:         0
>
>  HTH,
>   Thomas


Can you, please, also provide QEMU package version or how you configure 
and build it?

Or maybe attach full smaps file, I think it would help me a lot. Thanks!


Best regards,

Alexandr


