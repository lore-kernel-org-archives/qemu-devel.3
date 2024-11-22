Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587B4E65D17
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 09:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEPXT-0004gQ-J3; Fri, 22 Nov 2024 04:01:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tEPXQ-0004g2-Be
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 04:01:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tEPXM-0007OG-Sv
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 04:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732266067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=N3JUW4qkV2apTacWCwXy2kz9aAW/LpMQScgoeVD3cR0=;
 b=Lb6dXbG6pk0cIV4/+OPR0a37P7LObKU/GM6MYoYRD3OjxLLRqsM9r4+nhjUn8fFATmCmQO
 AOWubExLjp/2Ri6k9pNx4l6lrfpWxuW4KHuWSLZKk6cN7er91L9EfjxOSOOSoDUDjrsdn6
 yF+IkakFCLIYUbBCx8E2Tg3rpFYbFpg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-t6cwAVRgN6-ORTCK7TLE_A-1; Fri, 22 Nov 2024 04:01:06 -0500
X-MC-Unique: t6cwAVRgN6-ORTCK7TLE_A-1
X-Mimecast-MFC-AGG-ID: t6cwAVRgN6-ORTCK7TLE_A
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d425d1f0dbso31844596d6.1
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 01:01:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732266065; x=1732870865;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N3JUW4qkV2apTacWCwXy2kz9aAW/LpMQScgoeVD3cR0=;
 b=omBTOoKMrQBVbTbnOTeBahDh6ExDOMbd4cAJsvftaQ9wsQMKCOYku3lUogn3Zm2+ye
 gCp/UvOooS3AizpAJx4NYMx2P2Xuna6YN5tz5tHI+7jJAz/0Qqq5uFhQvIHmdiHetsy5
 Uzpv1Hw1+LJ+p3btcS5dIe6t52RJD1SsdtSR0GdeG9HhPSTnjt70i8canGweHhlYFnlV
 U1HOQyhNlsEwUAXDLOV4XPb592JvftwWP54bQWl4oM1Rk6agNwPsUYGsrKvd3kONaL7A
 ZXScAfR/QKxJGeNr4DLndcEk2JLmzvOvwt2VJsCnV2iWOSLeZ40GkuHGOc2c2jj4LyGQ
 R3pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBEswajzpSFCk0VurmSiWDtawIivsH6MfnGTSO4jxW57Hz9R3N6P6xn5Gtl+5Hd51Kr/1XVS0DAwJr@nongnu.org
X-Gm-Message-State: AOJu0YxgmONT0R//ArN042kHs8BV0YS/NWXJmmU+JCPaKIxsE6OC3meU
 GKElkP1HTcFRG5Agl7r613y3BXxKUjRXo9vrXcqF3TxFntDwJqHybJncWRVPBT5NTiRS/ZCsZ86
 20yF3OgkaTWdK+qECOY5+xFttQniMTOcZDA/GunKYK8hX0t5VX3aU
X-Gm-Gg: ASbGncvZaOyZvoCrN/UNY2wivAXwAFmTNrHkRowKfDL8/mWEcB0tuiq5IAXmjK+Dquf
 mHTF2LEhyQv7EIqZ0YMLgL/Rb7brax+8KIwx/IMywn1096aN+9oauyIjDx5xarHMthiN6auHl4R
 ZapykM5hxtPrrpfu08cdUIoCDqECt5bbgRZV7sdCkEzvkNWDKR/h4MHbZyNql27jnZrEhPfNmVg
 RXuxpfchnTnoC6Tub5b1feomi4Il5vzHFoXq49h+JxTtBYFTPI5JalGRLyFHbQ/5D3WC3r4SaIP
 ffYivNP8UPeJ
X-Received: by 2002:a05:6214:2528:b0:6cb:c9cf:cd40 with SMTP id
 6a1803df08f44-6d442382f27mr112783156d6.8.1732266064887; 
 Fri, 22 Nov 2024 01:01:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhBLaX6CiaGDTc9qsXetO4DliKWLImYSWZ47+Xr+XBFeqm4bMtokSW8zpqWMqsFc/bdEDjyg==
X-Received: by 2002:a05:6214:2528:b0:6cb:c9cf:cd40 with SMTP id
 6a1803df08f44-6d442382f27mr112782726d6.8.1732266064565; 
 Fri, 22 Nov 2024 01:01:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451b23efdsm7338096d6.88.2024.11.22.01.01.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 01:01:04 -0800 (PST)
Message-ID: <ed195e1a-1ecc-4575-baed-f0777ee9379c@redhat.com>
Date: Fri, 22 Nov 2024 10:01:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] tests/functional: Convert Aspeed arm SDK tests
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241122073309.1897944-1-clg@redhat.com>
 <20241122073309.1897944-3-clg@redhat.com>
 <fa39d761-91c5-4cb6-93b3-c077ce51a989@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <fa39d761-91c5-4cb6-93b3-c077ce51a989@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 11/22/24 09:21, Thomas Huth wrote:
> On 22/11/2024 08.33, Cédric Le Goater wrote:
>> Drop the SSH connection which was introduced in the avocado tests to
>> workaround read issues when interacting with console.
>>
>> EXTRA_BOOTARGS was introduced to reduce the console output at Linux
>> boot time. This didn't have the desired effect as we still had issues
>> when trying to match patterns on the console and we had to use the ssh
>> connection as a workaround.
>>
>> While at it, remove the U-Boot EXTRA_BOOTARGS variable which has
>> become useless.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
> ...
>> -    def do_test_arm_aspeed_sdk_start(self, image):
>> -        self.require_netdev('user')
> 
> The require_netdev('user') is gone in the new code, but it still uses "-net user" ... so I'd like to suggest to add it in the new code, too?

do_test_aarch64_aspeed_sdk_start needs it too. In v4 !

> With that nit fixed:
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks,

C.

> 
> 
>> -        self.vm.set_console()
>> -        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
>> -                         '-net', 'nic', '-net', 'user,hostfwd=:127.0.0.1:0-:22')
>> -        self.vm.launch()
>> -
>> -        self.wait_for_console_pattern('U-Boot 2019.04')
>> -        interrupt_interactive_console_until_pattern(
>> -            self, 'Hit any key to stop autoboot:', 'ast#')
>> -        exec_command_and_wait_for_pattern(
>> -            self, 'setenv bootargs ${bootargs} ' + self.EXTRA_BOOTARGS, 'ast#')
>> -        exec_command_and_wait_for_pattern(
>> -            self, 'boot', '## Loading kernel from FIT Image')
>> -        self.wait_for_console_pattern('Starting kernel ...')
>> -
>> -    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
>> -    def test_arm_ast2500_evb_sdk(self):
>> -        """
>> -        :avocado: tags=arch:arm
>> -        :avocado: tags=machine:ast2500-evb
>> -        :avocado: tags=flaky
>> -        """
>> -
>> -        image_url = ('https://github.com/AspeedTech-BMC/openbmc/releases/'
>> -                     'download/v08.06/ast2500-default-obmc.tar.gz')
>> -        image_hash = ('e1755f3cadff69190438c688d52dd0f0d399b70a1e14b1d3d5540fc4851d38ca')
>> -        image_path = self.fetch_asset(image_url, asset_hash=image_hash,
>> -                                      algorithm='sha256')
>> -        archive.extract(image_path, self.workdir)
>> -
>> -        self.do_test_arm_aspeed_sdk_start(
>> -            self.workdir + '/ast2500-default/image-bmc')
>> -        self.wait_for_console_pattern('nodistro.0 ast2500-default ttyS4')
>> -
>> -    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
>> -    def test_arm_ast2600_evb_sdk(self):
>> -        """
>> -        :avocado: tags=arch:arm
>> -        :avocado: tags=machine:ast2600-evb
>> -        :avocado: tags=flaky
>> -        """
>> -
>> -        image_url = ('https://github.com/AspeedTech-BMC/openbmc/releases/'
>> -                     'download/v08.06/ast2600-a2-obmc.tar.gz')
>> -        image_hash = ('9083506135f622d5e7351fcf7d4e1c7125cee5ba16141220c0ba88931f3681a4')
>> -        image_path = self.fetch_asset(image_url, asset_hash=image_hash,
>> -                                      algorithm='sha256')
>> -        archive.extract(image_path, self.workdir)
>> -
>> -        self.vm.add_args('-device',
>> -                         'tmp105,bus=aspeed.i2c.bus.5,address=0x4d,id=tmp-test');
>> -        self.vm.add_args('-device',
>> -                         'ds1338,bus=aspeed.i2c.bus.5,address=0x32');
>> -        self.do_test_arm_aspeed_sdk_start(
>> -            self.workdir + '/ast2600-a2/image-bmc')
>> -        self.wait_for_console_pattern('nodistro.0 ast2600-a2 ttyS4')
>> -
>> -        self.ssh_connect('root', '0penBmc', False)
>> -        self.ssh_command('dmesg -c > /dev/null')
>> -
>> -        self.ssh_command_output_contains(
>> -             'echo lm75 0x4d > /sys/class/i2c-dev/i2c-5/device/new_device ; '
>> -             'dmesg -c',
>> -             'i2c i2c-5: new_device: Instantiated device lm75 at 0x4d');
>> -        self.ssh_command_output_contains(
>> -                             'cat /sys/class/hwmon/hwmon19/temp1_input', '0')
>> -        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
>> -                    property='temperature', value=18000);
>> -        self.ssh_command_output_contains(
>> -                             'cat /sys/class/hwmon/hwmon19/temp1_input', '18000')
>> -
>> -        self.ssh_command_output_contains(
>> -             'echo ds1307 0x32 > /sys/class/i2c-dev/i2c-5/device/new_device ; '
>> -             'dmesg -c',
>> -             'i2c i2c-5: new_device: Instantiated device ds1307 at 0x32');
>> -        year = time.strftime("%Y")
>> -        self.ssh_command_output_contains('/sbin/hwclock -f /dev/rtc1', year);
>> -
>> diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed.py
>> index 5fb1adf46439..7644ecbae750 100755
>> --- a/tests/functional/test_arm_aspeed.py
>> +++ b/tests/functional/test_arm_aspeed.py
>> @@ -252,6 +252,73 @@ def test_arm_ast2600_evb_buildroot_tpm(self):
>>           self.do_test_arm_aspeed_buildroot_poweroff()
>> +    def do_test_arm_aspeed_sdk_start(self, image):
>> +        self.vm.set_console()
>> +        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
>> +                         '-net', 'nic', '-net', 'user', '-snapshot')
>> +        self.vm.launch()
>> +
>> +        self.wait_for_console_pattern('U-Boot 2019.04')
>> +        self.wait_for_console_pattern('## Loading kernel from FIT Image')
>> +        self.wait_for_console_pattern('Starting kernel ...')
>> +
>> +    ASSET_SDK_V806_AST2500 = Asset(
>> +        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v08.06/ast2500-default-obmc.tar.gz',
>> +        'e1755f3cadff69190438c688d52dd0f0d399b70a1e14b1d3d5540fc4851d38ca')
>> +
>> +    def test_arm_ast2500_evb_sdk(self):
>> +        self.set_machine('ast2500-evb')
>> +
>> +        image_path = self.ASSET_SDK_V806_AST2500.fetch()
>> +
>> +        archive_extract(image_path, self.workdir)
>> +
>> +        self.do_test_arm_aspeed_sdk_start(
>> +            self.workdir + '/ast2500-default/image-bmc')
>> +
>> +        self.wait_for_console_pattern('ast2500-default login:')
>> +
>> +    ASSET_SDK_V806_AST2600_A2 = Asset(
>> +        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v08.06/ast2600-a2-obmc.tar.gz',
>> +        '9083506135f622d5e7351fcf7d4e1c7125cee5ba16141220c0ba88931f3681a4')
>> +
>> +    def test_arm_ast2600_evb_sdk(self):
>> +        self.set_machine('ast2600-evb')
>> +
>> +        image_path = self.ASSET_SDK_V806_AST2600_A2.fetch()
>> +
>> +        archive_extract(image_path, self.workdir)
>> +
>> +        self.vm.add_args('-device',
>> +            'tmp105,bus=aspeed.i2c.bus.5,address=0x4d,id=tmp-test');
>> +        self.vm.add_args('-device',
>> +            'ds1338,bus=aspeed.i2c.bus.5,address=0x32');
>> +        self.do_test_arm_aspeed_sdk_start(
>> +            self.workdir + '/ast2600-a2/image-bmc')
>> +
>> +        self.wait_for_console_pattern('ast2600-a2 login:')
>> +
>> +        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
>> +        exec_command_and_wait_for_pattern(self, '0penBmc', 'root@ast2600-a2:~#')
>> +
>> +        exec_command_and_wait_for_pattern(self,
>> +            'echo lm75 0x4d > /sys/class/i2c-dev/i2c-5/device/new_device',
>> +            'i2c i2c-5: new_device: Instantiated device lm75 at 0x4d');
>> +        exec_command_and_wait_for_pattern(self,
>> +             'cat /sys/class/hwmon/hwmon19/temp1_input', '0')
>> +        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
>> +                    property='temperature', value=18000);
>> +        exec_command_and_wait_for_pattern(self,
>> +             'cat /sys/class/hwmon/hwmon19/temp1_input', '18000')
>> +
>> +        exec_command_and_wait_for_pattern(self,
>> +             'echo ds1307 0x32 > /sys/class/i2c-dev/i2c-5/device/new_device',
>> +             'i2c i2c-5: new_device: Instantiated device ds1307 at 0x32');
>> +        year = time.strftime("%Y")
>> +        exec_command_and_wait_for_pattern(self,
>> +             '/sbin/hwclock -f /dev/rtc1', year);
>> +
>> +
>>   class AST2x00MachineMMC(LinuxKernelTest):
>>       ASSET_RAINIER_EMMC = Asset(
> 


