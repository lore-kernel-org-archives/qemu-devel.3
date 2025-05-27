Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEB3C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 06:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJnum-0006W0-HN; Tue, 27 May 2025 02:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1uJnuj-0006Ut-O2
 for qemu-devel@nongnu.org; Tue, 27 May 2025 02:35:53 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1uJnuf-000786-Hr
 for qemu-devel@nongnu.org; Tue, 27 May 2025 02:35:53 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:2b89:0:640:9815:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id BB24660E6F;
 Tue, 27 May 2025 09:35:34 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:6430::1:32] (unknown
 [2a02:6b8:b081:6430::1:32])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id XZNeEw1FaW20-ikBtDHh9; Tue, 27 May 2025 09:35:34 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1748327734;
 bh=3exKEZ1rSgLO7fW7uIUhdJF4CNdsZXOuvjcFyM6RQGk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=iT8WwP5BDKNNsxQAwgIWMc2QTG7LPu8lbYESkfpKXT1CbEWQRy0RkNiAYHQk4qxSc
 6vhT+7nGe8bCbPoZYje6A+BLd5wkqN7MYlwAdGlOFPxVHV/av64ffKFJMPWJzIxyJ6
 NBEVS+3NEc4UEOt8PQtWeO4/UTn7Pm+mcSJD5WVc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2b38f3f4-d6f5-4cb7-80d7-3f31a6419ada@yandex-team.ru>
Date: Tue, 27 May 2025 11:35:34 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] tests/functional: add memlock tests
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
References: <20250525070737.54267-1-dtalexundeer@yandex-team.ru>
 <20250525070737.54267-3-dtalexundeer@yandex-team.ru>
 <7d28ddbd-9d8b-4c3a-9c72-d6c54638d4d7@redhat.com>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <7d28ddbd-9d8b-4c3a-9c72-d6c54638d4d7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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


On 5/27/25 11:13, Thomas Huth wrote:
> On 25/05/2025 09.07, Alexandr Moshkov wrote:
>> Add new tests to check the correctness of the `-overcommit memlock`
>> option (possible values: off, on, on-fault) by using
>> `/proc/{qemu_pid}/status` file to check in VmSize, VmRSS and VmLck
>> values:
>>
>> * if `memlock=off`, then VmLck = 0;
>> * if `memlock=on`, then VmLck > 0 and almost all memory is resident;
>> * if `memlock=on-fault`, then VmLck > 0 and only few memory is resident.
>>
>> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
>> ---
>>   tests/functional/meson.build     |  1 +
>>   tests/functional/test_memlock.py | 79 ++++++++++++++++++++++++++++++++
>>   2 files changed, 80 insertions(+)
>>   create mode 100755 tests/functional/test_memlock.py
>>
>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>> index 52b4706cfe..13079f58b6 100644
>> --- a/tests/functional/meson.build
>> +++ b/tests/functional/meson.build
>> @@ -68,6 +68,7 @@ tests_generic_system = [
>>     'empty_cpu_model',
>>     'info_usernet',
>>     'version',
>> +  'memlock',
>>   ]
>>     tests_generic_linuxuser = [
>> diff --git a/tests/functional/test_memlock.py 
>> b/tests/functional/test_memlock.py
>> new file mode 100755
>> index 0000000000..83cb5394cd
>> --- /dev/null
>> +++ b/tests/functional/test_memlock.py
>> @@ -0,0 +1,79 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Functional test that check overcommit memlock options
>> +#
>> +# Copyright (c) Yandex Technologies LLC, 2025
>> +#
>> +# Author:
>> +#  Alexandr Moshkov <dtalexundeer@yandex-team.ru>
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +import re
>> +
>> +from typing import Dict
>> +
>> +from qemu_test import QemuSystemTest
>> +from qemu_test import skipLockedMemoryTest
>> +
>> +
>> +STATUS_VALUE_PATTERN = re.compile(r'^(\w+):\s+(\d+) kB', re.MULTILINE)
>> +
>> +
>> +@skipLockedMemoryTest(2_097_152)  # 2GB
>> +class MemlockTest(QemuSystemTest):
>> +    """
>> +    Boots a Linux system with memlock options.
>
> Nit: I'd maybe change this into "Runs a guest with..." since it does 
> not really boot a Linux here. I could change it while picking up the 
> patch if you like.
Yes, I don't mind. Thanks for review!

Best regards,

Alexandr


