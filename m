Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF61C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 10:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgiJj-0004c7-VN; Wed, 21 Aug 2024 06:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sgiJh-0004a0-2P
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 06:11:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sgiJc-00031t-0j
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 06:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724235097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=g4zuBwEnQHacGOKj3vkL/v5sFNYM8owBFiXAofGwoCM=;
 b=IXlSdFCmeS1DL4v7saFw3Q9WyBD+YPMGe1F2GOQmPsbZiN+aYhoAj31CkKt6aFDs5ZO6HE
 EpVNmSktLPZyIRy0gzE+dgIjPAVOW9eWYArmDuN64SfaGYIDL40OvtdWQHdHgSkw3epfQj
 9lnae1Iq+78sTRov7afdGL/tzerUJPE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-AIig7r_sP8iqldvfWMPMAw-1; Wed, 21 Aug 2024 06:11:36 -0400
X-MC-Unique: AIig7r_sP8iqldvfWMPMAw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7a1dab8a2eeso798976985a.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 03:11:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724235095; x=1724839895;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g4zuBwEnQHacGOKj3vkL/v5sFNYM8owBFiXAofGwoCM=;
 b=KDwQhgKNS+gn9xMPc+DG/MUfAzFS9Fn0juy5gtAl2Eijii1Pe7+KIpznCIyAZzDoYz
 i8cIP+mH+aln7RyAKUEA6httN4SXd/mPGQqKpxDkinVd3jyxszFtLRDrN1mR1vjHEotH
 ji4niTj8XrLPdg7dWE+zEuvpLzt7dgvR5ykf9mlnojdMR59ryzuemKGEqbx1X2Y1jb4N
 BOV7ksMRrva7FszUuwzV49+nCghxI2sY8DNXBJU4Xp1SnlF96rPX54HXm6f1vVmgHCtd
 SXnFHnQgbRcD9ygzxKBnYnQ8AbJBoSB8mcMkl3mTAbezfsasqi8hrzV4D2zRzOBxuIQD
 51kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmq9GukRqCMTwLxx/Yxq0tV9GImTa0YvMsuq4OGosBvkA38LImh1mZWzCdFL8z+57laYQj4H241TqS@nongnu.org
X-Gm-Message-State: AOJu0Ywv+9RsOe4UsYUZh5+5empmvw6YO17wW2fpJT0vOmkW04+afrlR
 84m3kHfjMwrVA59nayBonDgzgSIX29Giqv0xVBIaGT4o0THo6afMjeGOa5FYCPVhLwPeWlso7Ir
 U0epX+WyjUVKqb2yV7DLtjX9g8tWYndh5LXmGSyxeF+/4i9K7nt1n
X-Received: by 2002:a05:620a:bca:b0:7a1:e93c:ccf0 with SMTP id
 af79cd13be357-7a674003aa3mr250975485a.13.1724235095445; 
 Wed, 21 Aug 2024 03:11:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEPZ9qBHSN9x8hJijNYvhyMpegzXpcB9qwIufV6IOwX17DgAT/O1tYUpq+hOGQUv/7jAiCEg==
X-Received: by 2002:a05:620a:bca:b0:7a1:e93c:ccf0 with SMTP id
 af79cd13be357-7a674003aa3mr250973185a.13.1724235095110; 
 Wed, 21 Aug 2024 03:11:35 -0700 (PDT)
Received: from [10.33.192.191] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a4ff02c8a7sm607200685a.16.2024.08.21.03.11.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 03:11:34 -0700 (PDT)
Message-ID: <c3b28181-f9d4-4c79-bd0b-0c9c576992dc@redhat.com>
Date: Wed, 21 Aug 2024 12:11:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 26/35] tests/functional: Convert the ppc_hv avocado
 test into a standalone test
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
References: <20240821082748.65853-1-thuth@redhat.com>
 <20240821082748.65853-27-thuth@redhat.com>
 <a0f16778-5ff5-48a3-96ed-8294886274c6@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <a0f16778-5ff5-48a3-96ed-8294886274c6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 21/08/2024 11.43, Philippe Mathieu-Daudé wrote:
> On 21/8/24 10:27, Thomas Huth wrote:
>> A straight forward conversion, we just also have to remove the decorator
>> @skipUnless(os.getenv('SPEED')) since all non-trivial functional tests
>> are running in SPEED=thorough mode now. Also make sure that the extracted
>> assets are writable, so that the test does not fail if it gets re-run
>> and there are stale read-only files already around.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   MAINTAINERS                                   |  2 +-
>>   tests/functional/meson.build                  |  2 +
>>   .../test_ppc64_hv.py}                         | 53 ++++++++-----------
>>   3 files changed, 25 insertions(+), 32 deletions(-)
>>   rename tests/{avocado/ppc_hv_tests.py => functional/test_ppc64_hv.py} (85%)
>>   mode change 100644 => 100755
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index f01e865025..cca48683ce 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1532,7 +1532,7 @@ F: tests/qtest/libqos/*spapr*
>>   F: tests/qtest/rtas*
>>   F: tests/qtest/libqos/rtas*
>>   F: tests/functional/test_ppc64_pseries.py
>> -F: tests/avocado/ppc_hv_tests.py
>> +F: tests/functional/test_ppc64_hv.py
>>   PowerNV (Non-Virtualized)
>>   M: Cédric Le Goater <clg@kaod.org>
>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>> index fba3891e16..f90fb08d6a 100644
>> --- a/tests/functional/meson.build
>> +++ b/tests/functional/meson.build
>> @@ -13,6 +13,7 @@ endif
>>   test_timeouts = {
>>     'netdev_ethtool' : 180,
>>     'ppc_40p' : 240,
>> +  'ppc64_hv' : 1000,
>>     'ppc64_powernv' : 120,
>>     'ppc64_pseries' : 120,
>>     's390x_ccw_virtio' : 180,
>> @@ -63,6 +64,7 @@ tests_ppc_thorough = [
>>   ]
>>   tests_ppc64_thorough = [
>> +  'ppc64_hv',
>>     'ppc64_powernv',
>>     'ppc64_pseries',
>>   ]
>> diff --git a/tests/avocado/ppc_hv_tests.py 
>> b/tests/functional/test_ppc64_hv.py
>> old mode 100644
>> new mode 100755
>> similarity index 85%
>> rename from tests/avocado/ppc_hv_tests.py
>> rename to tests/functional/test_ppc64_hv.py
>> index 0e83bbac71..df59667e07
>> --- a/tests/avocado/ppc_hv_tests.py
>> +++ b/tests/functional/test_ppc64_hv.py
>> @@ -1,3 +1,5 @@
>> +#!/usr/bin/env python3
>> +#
>>   # Tests that specifically try to exercise hypervisor features of the
>>   # target machines. powernv supports the Power hypervisor ISA, and
>>   # pseries supports the nested-HV hypervisor spec.
>> @@ -7,10 +9,10 @@
>>   # This work is licensed under the terms of the GNU GPL, version 2 or
>>   # later.  See the COPYING file in the top-level directory.
>> -from avocado import skipIf, skipUnless
>> -from avocado.utils import archive
>> -from avocado_qemu import QemuSystemTest
>> -from avocado_qemu import wait_for_console_pattern, exec_command
>> +from unittest import skipIf, skipUnless
>> +from qemu_test.utils import archive_extract
>> +from qemu_test import QemuSystemTest, Asset
>> +from qemu_test import wait_for_console_pattern, exec_command
>>   import os
>>   import time
>>   import subprocess
>> @@ -45,8 +47,7 @@ def missing_deps():
>>   # QEMU already installed and use that.
>>   # XXX: The order of these tests seems to matter, see git blame.
>>   @skipIf(missing_deps(), 'dependencies (%s) not installed' % ','.join(deps))
>> -@skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
>> -@skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
>> +@skipUnless(os.getenv('QEMU_TEST_ALLOW_LARGE_STORAGE'), 'storage limited')
>>   class HypervisorTest(QemuSystemTest):
>>       timeout = 1000
>> @@ -54,6 +55,11 @@ class HypervisorTest(QemuSystemTest):
>>       panic_message = 'Kernel panic - not syncing'
>>       good_message = 'VFS: Cannot open root device'
>> +    ASSET_ISO = Asset(
>> +        ('https://dl-cdn.alpinelinux.org/alpine/v3.18/'
>> +         'releases/ppc64le/alpine-standard-3.18.4-ppc64le.iso'),
>> +        'c26b8d3e17c2f3f0fed02b4b1296589c2390e6d5548610099af75300edd7b3ff')
>> +
>>       def extract_from_iso(self, iso, path):
>>           """
>>           Extracts a file from an iso file into the test workdir
>> @@ -72,6 +78,7 @@ def extract_from_iso(self, iso, path):
>>               subprocess.run(cmd.split(),
>>                              stdout=subprocess.DEVNULL, 
>> stderr=subprocess.DEVNULL)
>> +        os.chmod(filename, 0o600)
>>           os.chdir(cwd)
>>           # Return complete path to extracted file.  Because callers to
>> @@ -83,16 +90,9 @@ def extract_from_iso(self, iso, path):
>>       def setUp(self):
>>           super().setUp()
>> -        iso_url = 
>> ('https://dl-cdn.alpinelinux.org/alpine/v3.18/releases/ppc64le/alpine-standard-3.18.4-ppc64le.iso')
>> -
>> -        # Alpine use sha256 so I recalculated this myself
>> -        iso_sha256 = 
>> 'c26b8d3e17c2f3f0fed02b4b1296589c2390e6d5548610099af75300edd7b3ff'
>> -        iso_path = self.fetch_asset(iso_url, asset_hash=iso_sha256,
>> -                                    algorithm = "sha256")
>> -
>> -        self.iso_path = iso_path
>> -        self.vmlinuz = self.extract_from_iso(iso_path, '/boot/vmlinuz-lts')
>> -        self.initramfs = self.extract_from_iso(iso_path, 
>> '/boot/initramfs-lts')
>> +        self.iso_path = self.ASSET_ISO.fetch()
>> +        self.vmlinuz = self.extract_from_iso(self.iso_path, 
>> '/boot/vmlinuz-lts')
>> +        self.initramfs = self.extract_from_iso(self.iso_path, 
>> '/boot/initramfs-lts')
>>       def do_start_alpine(self):
>>           self.vm.set_console()
> 
> Expanding context:
> 
>             kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
>             self.vm.add_args("-kernel", self.vmlinuz)
>             self.vm.add_args("-initrd", self.initramfs)
>             self.vm.add_args("-smp", "4", "-m", "2g")
>             self.vm.add_args("-drive", 
> f"file={self.iso_path},format=raw,if=none,id=drive0")
> 
> Should we use ,media=cdrom here too?

I guess that's rather a question for Nicholas (now on CC:)...

Anyway, it should be a separate patch, I think.

  Thomas


