Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D22CCCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 08:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v62cY-00037c-Ga; Tue, 07 Oct 2025 04:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v62cR-000370-5x
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:00:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v62cO-00009J-Nz
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759824019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0Aw4Yxr5bNBHUYzLICQqISGkNXwth4UsjX6OWwgPzlM=;
 b=K0ROC78jGS5bU2GmnB9zNxEQkdExHiEVVvVE9Klpcwmbp5ZML8tCqOe5RkYj3zqx+YDr1z
 eifLbf/hxEIJzF6tTaNw0jUXxXmdhl+Q3KCh11c5rBiLkaHnwzz/9tvjx7awgZTB8a9Tx2
 Hb6iwQ7wIJNyPYps0H+6/KR2HeMz98s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-akcnpkMbMyq6M3o6nsC87Q-1; Tue, 07 Oct 2025 04:00:17 -0400
X-MC-Unique: akcnpkMbMyq6M3o6nsC87Q-1
X-Mimecast-MFC-AGG-ID: akcnpkMbMyq6M3o6nsC87Q_1759824016
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e45899798so21382115e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 01:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759824016; x=1760428816;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Aw4Yxr5bNBHUYzLICQqISGkNXwth4UsjX6OWwgPzlM=;
 b=oxCxenEmwcX78krft6L98OGsHwq6310sy+hZfe2A8dO/uMQIRdan45VRJuFlDq10qa
 Bv9E3en2lZHHsbtY6fqF/AlXyLAmrNjPJCZSxbAwd5EhY8IfhnOjnwovo1XiVejneAh8
 pfcGsma/aSPbOW1643PDppTYs1VIcLrYrBOefaHklh7gCJQlguUZyqIzXQ9BvsM3Un7i
 +Uws3xBpsWJXVv1WdSzlqAX1wVQDJqoe2Ta9qLllg7LH7fBr89g24gRuNsnC6FjDaLGH
 bKfnFP/Gy7xi0vTov31GzdSYB52BbK/EaSuyzWRG2VeYvNXxoMhXoaLENtEW7bAQt+Qw
 P0mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB2YO9D1HUkJ7A3Fh2Rj1Y9fNmLzO2N9qdX6mS4NeZz5RDTaSQT+G21l6hQrkQ/EBr0OMJ6KLLvv/9@nongnu.org
X-Gm-Message-State: AOJu0Yz1yWUlXeiqKjTantn0J3Qx6WM/x4GOre72yrNSfFfUOEFN1R2Q
 nWQ9jltISseFgw4TAhdv/3/seIhI9W6VJ92W/yyFKSBUPA5vL/IHBrCfnldyx3jUpU/OBLsoigH
 Ffe2U8zEQtWIyc4ZcniQrcT01CmgUbhLkyWmAW3vo42eIH7+PnyUr/NAl
X-Gm-Gg: ASbGncsajNVzRog1lLU9TxU4Q7/fY/8PJRCX/IGMt/X4IT0XB50WTbVcAooeqjJccBT
 sSZIY2y68Lm91qSNVgeVdF62noaExz5J1LxNSZVYBGsE6vlJRCa8HLqdu+N9I75WOtfsYymCrbh
 N491ZK2+zkAvd2OPFGi6klKPemIeyvjUbvZyUMx4NEGLGWox2dwjsy/CNtuT+6BDmNqRSSqg74z
 7aDXnSiBH4Ya/5YceuKbvxWn66VdyHH0fpsqKy63luBsAHDger4QmDY9THyvq3xDc0dai9KLp8i
 vbSasmfOguG/zDdTIDe74VfQe13hmk+U2Oc2kCHVD1tlpgXcKy15Z9cLVkS6ANC9Iijy3CAEbDW
 5eSgJDxhN
X-Received: by 2002:a05:600c:1986:b0:46e:4287:a85e with SMTP id
 5b1f17b1804b1-46e71109f78mr88328515e9.13.1759824016000; 
 Tue, 07 Oct 2025 01:00:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiWO09JumnoqB73NzimnoZCyfgWFdSx+valr48VD2uyoCmoHLmtUCksMYV3DaehBgtTxRyfw==
X-Received: by 2002:a05:600c:1986:b0:46e:4287:a85e with SMTP id
 5b1f17b1804b1-46e71109f78mr88328045e9.13.1759824015188; 
 Tue, 07 Oct 2025 01:00:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a18b76sm298652055e9.18.2025.10.07.01.00.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 01:00:14 -0700 (PDT)
Message-ID: <c9e6fb47-aa51-4c52-9140-2ef699cd5d1f@redhat.com>
Date: Tue, 7 Oct 2025 10:00:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test/functional/arm: Split the ast2600 tests in two files
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
References: <20251006173451.528310-1-clg@redhat.com>
 <7908cb21-785f-48ba-899d-d02fb8bb73b6@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <7908cb21-785f-48ba-899d-d02fb8bb73b6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
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

On 10/7/25 09:56, Thomas Huth wrote:
> On 06/10/2025 19.34, Cédric Le Goater wrote:
>> The ast2600 test file currently includes tests for both the Buildroot
>> and SDK images. Since the SDK image tests can take long to run, split
>> them into a separate file to clearly distinguish the two sets of
>> tests, improve parallelism and allow for different CI timeouts.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   tests/functional/arm/meson.build              |  6 +-
>>   ...00.py => test_aspeed_ast2600_buildroot.py} | 74 --------------
>>   .../functional/arm/test_aspeed_ast2600_sdk.py | 96 +++++++++++++++++++
>>   3 files changed, 100 insertions(+), 76 deletions(-)
>>   rename tests/functional/arm/{test_aspeed_ast2600.py => test_aspeed_ast2600_buildroot.py} (57%)
>>   create mode 100755 tests/functional/arm/test_aspeed_ast2600_sdk.py
>>
>> diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
>> index e4e7dba8d087..d1ed076a6aa8 100644
>> --- a/tests/functional/arm/meson.build
>> +++ b/tests/functional/arm/meson.build
>> @@ -5,7 +5,8 @@ test_arm_timeouts = {
>>     'aspeed_romulus' : 120,
>>     'aspeed_witherspoon' : 120,
>>     'aspeed_ast2500' : 720,
>> -  'aspeed_ast2600' : 1200,
>> +  'aspeed_ast2600_buildroot' : 720,
>> +  'aspeed_ast2600_sdk' : 1200,
>>     'aspeed_bletchley' : 480,
>>     'aspeed_catalina' : 480,
>>     'aspeed_gb200nvl_bmc' : 480,
>> @@ -31,7 +32,8 @@ tests_arm_system_thorough = [
>>     'aspeed_romulus',
>>     'aspeed_witherspoon',
>>     'aspeed_ast2500',
>> -  'aspeed_ast2600',
>> +  'aspeed_ast2600_buildroot',
>> +  'aspeed_ast2600_sdk',
>>     'aspeed_bletchley',
>>     'aspeed_catalina',
>>     'aspeed_gb200nvl_bmc',
>> diff --git a/tests/functional/arm/test_aspeed_ast2600.py b/tests/functional/arm/test_aspeed_ast2600_buildroot.py
>> similarity index 57%
>> rename from tests/functional/arm/test_aspeed_ast2600.py
>> rename to tests/functional/arm/test_aspeed_ast2600_buildroot.py
>> index 0127913cfb65..51f2676c9061 100755
>> --- a/tests/functional/arm/test_aspeed_ast2600.py
>> +++ b/tests/functional/arm/test_aspeed_ast2600_buildroot.py
>> @@ -97,80 +97,6 @@ def test_arm_ast2600_evb_buildroot_tpm(self):
>>           self.do_test_arm_aspeed_buildroot_poweroff()
>> -    ASSET_SDK_V908_AST2600 = Asset(
>> -        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.08/ast2600-default-obmc.tar.gz',
>> -        'a0414f14ad696550efe083c2156dbeda855c08cc9ae7f40fe1b41bf292295f82')
>> -
>> -    def do_ast2600_pcie_test(self):
>> -        exec_command_and_wait_for_pattern(self,
>> -            'lspci -s 80:00.0',
>> -            '80:00.0 Host bridge: '
>> -            'ASPEED Technology, Inc. Device 2600')
>> -        exec_command_and_wait_for_pattern(self,
>> -            'lspci -s 80:08.0',
>> -            '80:08.0 PCI bridge: '
>> -            'ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge')
>> -        exec_command_and_wait_for_pattern(self,
>> -            'lspci -s 81:00.0',
>> -            '81:00.0 Ethernet controller: '
>> -            'Intel Corporation 82574L Gigabit Network Connection')
>> -        exec_command_and_wait_for_pattern(self,
>> -            'ip addr show dev eth4',
>> -            'inet 10.0.2.15/24')
>> -
>> -    def test_arm_ast2600_evb_sdk(self):
>> -        self.set_machine('ast2600-evb')
>> -        self.require_netdev('user')
>> -
>> -        self.archive_extract(self.ASSET_SDK_V908_AST2600)
>> -
>> -        self.vm.add_args('-device',
>> -            'tmp105,bus=aspeed.i2c.bus.5,address=0x4d,id=tmp-test')
>> -        self.vm.add_args('-device',
>> -            'ds1338,bus=aspeed.i2c.bus.5,address=0x32')
>> -        self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.0')
>> -        self.vm.add_args('-netdev', 'user,id=net1')
>> -        self.do_test_arm_aspeed_sdk_start(
>> -            self.scratch_file("ast2600-default", "image-bmc"))
>> -
>> -        self.wait_for_console_pattern('ast2600-default login:')
>> -
>> -        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
>> -        exec_command_and_wait_for_pattern(self, '0penBmc',
>> -                                          'root@ast2600-default:~#')
>> -
>> -        exec_command_and_wait_for_pattern(self,
>> -            'echo lm75 0x4d > /sys/class/i2c-dev/i2c-5/device/new_device',
>> -            'i2c i2c-5: new_device: Instantiated device lm75 at 0x4d')
>> -        exec_command_and_wait_for_pattern(self,
>> -             'cat /sys/class/hwmon/hwmon19/temp1_input', '0')
>> -        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
>> -                    property='temperature', value=18000)
>> -        exec_command_and_wait_for_pattern(self,
>> -             'cat /sys/class/hwmon/hwmon19/temp1_input', '18000')
>> -
>> -        exec_command_and_wait_for_pattern(self,
>> -             'echo ds1307 0x32 > /sys/class/i2c-dev/i2c-5/device/new_device',
>> -             'i2c i2c-5: new_device: Instantiated device ds1307 at 0x32')
>> -        year = time.strftime("%Y")
>> -        exec_command_and_wait_for_pattern(self,
>> -             '/sbin/hwclock -f /dev/rtc1', year)
>> -        self.do_ast2600_pcie_test()
>> -
>> -    def test_arm_ast2600_otp_blockdev_device(self):
>> -        self.vm.set_machine("ast2600-evb")
>> -
>> -        image_path = self.archive_extract(self.ASSET_SDK_V908_AST2600)
>> -        otp_img = self.generate_otpmem_image()
>> -
>> -        self.vm.set_console()
>> -        self.vm.add_args(
>> -            "-blockdev", f"driver=file,filename={otp_img},node-name=otp",
>> -            "-global", "aspeed-otp.drive=otp",
>> -        )
>> -        self.do_test_arm_aspeed_sdk_start(
>> -            self.scratch_file("ast2600-default", "image-bmc"))
>> -        self.wait_for_console_pattern("ast2600-default login:")
>>   if __name__ == '__main__':
>>       AspeedTest.main()
>> diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk.py b/tests/functional/arm/test_aspeed_ast2600_sdk.py
>> new file mode 100755
>> index 000000000000..735a20b8df0e
>> --- /dev/null
>> +++ b/tests/functional/arm/test_aspeed_ast2600_sdk.py
>> @@ -0,0 +1,96 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Functional test that boots the ASPEED machines
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +import os
>> +import time
>> +import tempfile
>> +import subprocess
>> +
>> +from qemu_test import Asset
>> +from aspeed import AspeedTest
>> +from qemu_test import exec_command_and_wait_for_pattern, skipIfMissingCommands
> 
> Nit: Please drop the import of tempfile, subprocess, skipIfMissingCommands and os in the new sdk file.

Indeed. I forgot some cleanup in test_aspeed_ast2600_sdk.py.

Thanks,

C.



