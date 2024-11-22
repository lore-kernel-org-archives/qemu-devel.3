Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BEAE65D32
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 08:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEOv8-0006tT-8P; Fri, 22 Nov 2024 03:21:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tEOv6-0006tA-JG
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 03:21:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tEOv4-0008GH-Lm
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 03:21:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732263697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pdHXf7bdQWNwC0IHZFz5RGSWoCd2ZJXMrUIo60PbqTw=;
 b=XesYvffAjj5jZ8oeK9xCpbwmZcKtUxuChtvsTVr/4Prjr3CblOoMtmG45uI1Wkz8iYqk2R
 XnkPyujEwHyF5A2W8DkcCIOFJG0nNGd7z1hdIdL1HtRvmC7CrRoVc6XnkfE57DiyFHTd1B
 CxGmCi/W9GvoreXvKV/coVTAHdxP4uk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-3IKPJSeBMh6oPoGzICZXig-1; Fri, 22 Nov 2024 03:21:35 -0500
X-MC-Unique: 3IKPJSeBMh6oPoGzICZXig-1
X-Mimecast-MFC-AGG-ID: 3IKPJSeBMh6oPoGzICZXig
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4314f1e0f2bso13893465e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 00:21:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732263694; x=1732868494;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pdHXf7bdQWNwC0IHZFz5RGSWoCd2ZJXMrUIo60PbqTw=;
 b=eemI8PZZRn/ZOHhhCOPQq8i8neS5Ft/jV/pLAbUDhGxdncs9MzcDDG+ubOQdklOurj
 6MuXZHPdmkdZTphDBLDG7Qky0/ThWyqqKb1e1MXw6QpNYRmGJCTTmeK5W9vbeIG7r8HQ
 1EqqgvLnEJkFtxeVYHuFQYvNs2Qh4xwG0tqyg2SWj2e43TyLCPWFdkwDB8qp3TvvmJEn
 vDSw9XajMa2PjfW46zhCUFlBCpGxfz/mIg7WL5VqeqVgdRzt5gX1lLye4yFwUnOO4TG1
 K2qWJl28DBNzQsRzPPtyrtjAtAjBlbhBDa2M4gOmVk/CZpO2TQT/fcWSxNMW5YGrRmzn
 kuYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOO7F0rocjygx2PAPZGqDW0p1fZb1bN205K0jjMREOfrrnnc72df3mEFc/arAr9DchUc0BfbV6KJi+@nongnu.org
X-Gm-Message-State: AOJu0YxoRj5xN4kS1ahHoZ5IFRXE2hyRXKajQC2+9Iiojs612MguERlh
 HTk4ucj996T8ZXyzksItpji2NPeHANUnGxUfA3abbZVmwdTOjywxoQmMYVQkZ7L0q7SIlVg5gdJ
 NYWvBy62W2LWVxuvM5WSTCWOyDdrr8Q7YgxNEVGOnloyrLGJVefdG
X-Gm-Gg: ASbGncsWodS0p62Hoa1/qQcM/KkiOZ+pi9jvHRv8Yvlmjd3YCAaHfwq1Hkxt3kreaxm
 0Kdvzc5lHl/KG98Aq1bAw1Tbc8+lWwXqJecLQwstm08n5BeHZt3rGzK7VxGNBtwS4tbKbiBLlaC
 KWEb+0qRal+AOk4IIlRseNWtJu/NVTKw41B+07HwBjPacoTROQUqkdNMSOW5Ajp64mvLDE8gkkq
 +jP1OyisY3D1fCCr23aEsV8Hy7GKMT+ptS5uiKZGRg7HNi6ukETgfUALUKmlZdby+Aks8L3uB8=
X-Received: by 2002:a05:600c:a02:b0:431:4a5a:f09a with SMTP id
 5b1f17b1804b1-433ce4b2f62mr14332915e9.24.1732263693906; 
 Fri, 22 Nov 2024 00:21:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeyTnJ7F+FsKj8wYI/p3ISwyJ4MRU0LIPezpOucchCekh3L+OUdAlFza3AsMGqJ4zNEi/jHw==
X-Received: by 2002:a05:600c:a02:b0:431:4a5a:f09a with SMTP id
 5b1f17b1804b1-433ce4b2f62mr14332665e9.24.1732263693488; 
 Fri, 22 Nov 2024 00:21:33 -0800 (PST)
Received: from [10.33.192.206] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433cde05898sm19459475e9.9.2024.11.22.00.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 00:21:33 -0800 (PST)
Message-ID: <fa39d761-91c5-4cb6-93b3-c077ce51a989@redhat.com>
Date: Fri, 22 Nov 2024 09:21:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] tests/functional: Convert Aspeed arm SDK tests
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241122073309.1897944-1-clg@redhat.com>
 <20241122073309.1897944-3-clg@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241122073309.1897944-3-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 22/11/2024 08.33, Cédric Le Goater wrote:
> Drop the SSH connection which was introduced in the avocado tests to
> workaround read issues when interacting with console.
> 
> EXTRA_BOOTARGS was introduced to reduce the console output at Linux
> boot time. This didn't have the desired effect as we still had issues
> when trying to match patterns on the console and we had to use the ssh
> connection as a workaround.
> 
> While at it, remove the U-Boot EXTRA_BOOTARGS variable which has
> become useless.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
...
> -    def do_test_arm_aspeed_sdk_start(self, image):
> -        self.require_netdev('user')

The require_netdev('user') is gone in the new code, but it still uses "-net 
user" ... so I'd like to suggest to add it in the new code, too?

With that nit fixed:
Reviewed-by: Thomas Huth <thuth@redhat.com>


> -        self.vm.set_console()
> -        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
> -                         '-net', 'nic', '-net', 'user,hostfwd=:127.0.0.1:0-:22')
> -        self.vm.launch()
> -
> -        self.wait_for_console_pattern('U-Boot 2019.04')
> -        interrupt_interactive_console_until_pattern(
> -            self, 'Hit any key to stop autoboot:', 'ast#')
> -        exec_command_and_wait_for_pattern(
> -            self, 'setenv bootargs ${bootargs} ' + self.EXTRA_BOOTARGS, 'ast#')
> -        exec_command_and_wait_for_pattern(
> -            self, 'boot', '## Loading kernel from FIT Image')
> -        self.wait_for_console_pattern('Starting kernel ...')
> -
> -    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
> -    def test_arm_ast2500_evb_sdk(self):
> -        """
> -        :avocado: tags=arch:arm
> -        :avocado: tags=machine:ast2500-evb
> -        :avocado: tags=flaky
> -        """
> -
> -        image_url = ('https://github.com/AspeedTech-BMC/openbmc/releases/'
> -                     'download/v08.06/ast2500-default-obmc.tar.gz')
> -        image_hash = ('e1755f3cadff69190438c688d52dd0f0d399b70a1e14b1d3d5540fc4851d38ca')
> -        image_path = self.fetch_asset(image_url, asset_hash=image_hash,
> -                                      algorithm='sha256')
> -        archive.extract(image_path, self.workdir)
> -
> -        self.do_test_arm_aspeed_sdk_start(
> -            self.workdir + '/ast2500-default/image-bmc')
> -        self.wait_for_console_pattern('nodistro.0 ast2500-default ttyS4')
> -
> -    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
> -    def test_arm_ast2600_evb_sdk(self):
> -        """
> -        :avocado: tags=arch:arm
> -        :avocado: tags=machine:ast2600-evb
> -        :avocado: tags=flaky
> -        """
> -
> -        image_url = ('https://github.com/AspeedTech-BMC/openbmc/releases/'
> -                     'download/v08.06/ast2600-a2-obmc.tar.gz')
> -        image_hash = ('9083506135f622d5e7351fcf7d4e1c7125cee5ba16141220c0ba88931f3681a4')
> -        image_path = self.fetch_asset(image_url, asset_hash=image_hash,
> -                                      algorithm='sha256')
> -        archive.extract(image_path, self.workdir)
> -
> -        self.vm.add_args('-device',
> -                         'tmp105,bus=aspeed.i2c.bus.5,address=0x4d,id=tmp-test');
> -        self.vm.add_args('-device',
> -                         'ds1338,bus=aspeed.i2c.bus.5,address=0x32');
> -        self.do_test_arm_aspeed_sdk_start(
> -            self.workdir + '/ast2600-a2/image-bmc')
> -        self.wait_for_console_pattern('nodistro.0 ast2600-a2 ttyS4')
> -
> -        self.ssh_connect('root', '0penBmc', False)
> -        self.ssh_command('dmesg -c > /dev/null')
> -
> -        self.ssh_command_output_contains(
> -             'echo lm75 0x4d > /sys/class/i2c-dev/i2c-5/device/new_device ; '
> -             'dmesg -c',
> -             'i2c i2c-5: new_device: Instantiated device lm75 at 0x4d');
> -        self.ssh_command_output_contains(
> -                             'cat /sys/class/hwmon/hwmon19/temp1_input', '0')
> -        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
> -                    property='temperature', value=18000);
> -        self.ssh_command_output_contains(
> -                             'cat /sys/class/hwmon/hwmon19/temp1_input', '18000')
> -
> -        self.ssh_command_output_contains(
> -             'echo ds1307 0x32 > /sys/class/i2c-dev/i2c-5/device/new_device ; '
> -             'dmesg -c',
> -             'i2c i2c-5: new_device: Instantiated device ds1307 at 0x32');
> -        year = time.strftime("%Y")
> -        self.ssh_command_output_contains('/sbin/hwclock -f /dev/rtc1', year);
> -
> diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed.py
> index 5fb1adf46439..7644ecbae750 100755
> --- a/tests/functional/test_arm_aspeed.py
> +++ b/tests/functional/test_arm_aspeed.py
> @@ -252,6 +252,73 @@ def test_arm_ast2600_evb_buildroot_tpm(self):
>   
>           self.do_test_arm_aspeed_buildroot_poweroff()
>   
> +    def do_test_arm_aspeed_sdk_start(self, image):
> +        self.vm.set_console()
> +        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
> +                         '-net', 'nic', '-net', 'user', '-snapshot')
> +        self.vm.launch()
> +
> +        self.wait_for_console_pattern('U-Boot 2019.04')
> +        self.wait_for_console_pattern('## Loading kernel from FIT Image')
> +        self.wait_for_console_pattern('Starting kernel ...')
> +
> +    ASSET_SDK_V806_AST2500 = Asset(
> +        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v08.06/ast2500-default-obmc.tar.gz',
> +        'e1755f3cadff69190438c688d52dd0f0d399b70a1e14b1d3d5540fc4851d38ca')
> +
> +    def test_arm_ast2500_evb_sdk(self):
> +        self.set_machine('ast2500-evb')
> +
> +        image_path = self.ASSET_SDK_V806_AST2500.fetch()
> +
> +        archive_extract(image_path, self.workdir)
> +
> +        self.do_test_arm_aspeed_sdk_start(
> +            self.workdir + '/ast2500-default/image-bmc')
> +
> +        self.wait_for_console_pattern('ast2500-default login:')
> +
> +    ASSET_SDK_V806_AST2600_A2 = Asset(
> +        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v08.06/ast2600-a2-obmc.tar.gz',
> +        '9083506135f622d5e7351fcf7d4e1c7125cee5ba16141220c0ba88931f3681a4')
> +
> +    def test_arm_ast2600_evb_sdk(self):
> +        self.set_machine('ast2600-evb')
> +
> +        image_path = self.ASSET_SDK_V806_AST2600_A2.fetch()
> +
> +        archive_extract(image_path, self.workdir)
> +
> +        self.vm.add_args('-device',
> +            'tmp105,bus=aspeed.i2c.bus.5,address=0x4d,id=tmp-test');
> +        self.vm.add_args('-device',
> +            'ds1338,bus=aspeed.i2c.bus.5,address=0x32');
> +        self.do_test_arm_aspeed_sdk_start(
> +            self.workdir + '/ast2600-a2/image-bmc')
> +
> +        self.wait_for_console_pattern('ast2600-a2 login:')
> +
> +        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
> +        exec_command_and_wait_for_pattern(self, '0penBmc', 'root@ast2600-a2:~#')
> +
> +        exec_command_and_wait_for_pattern(self,
> +            'echo lm75 0x4d > /sys/class/i2c-dev/i2c-5/device/new_device',
> +            'i2c i2c-5: new_device: Instantiated device lm75 at 0x4d');
> +        exec_command_and_wait_for_pattern(self,
> +             'cat /sys/class/hwmon/hwmon19/temp1_input', '0')
> +        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
> +                    property='temperature', value=18000);
> +        exec_command_and_wait_for_pattern(self,
> +             'cat /sys/class/hwmon/hwmon19/temp1_input', '18000')
> +
> +        exec_command_and_wait_for_pattern(self,
> +             'echo ds1307 0x32 > /sys/class/i2c-dev/i2c-5/device/new_device',
> +             'i2c i2c-5: new_device: Instantiated device ds1307 at 0x32');
> +        year = time.strftime("%Y")
> +        exec_command_and_wait_for_pattern(self,
> +             '/sbin/hwclock -f /dev/rtc1', year);
> +
> +
>   class AST2x00MachineMMC(LinuxKernelTest):
>   
>       ASSET_RAINIER_EMMC = Asset(


