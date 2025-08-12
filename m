Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EBECA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 13:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulp3k-0005OY-KD; Tue, 12 Aug 2025 09:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulp3j-0005ON-Of
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 09:28:59 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulp3V-00015l-Pw
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 09:28:59 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-459d4d7c745so49957785e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 06:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755005321; x=1755610121; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9/hzcU+ZtuPzfrVepFsWSd7nGBb2dO+zRh6r8pCwa/I=;
 b=FRNcNB0qSYCz1RYoGfDE6n8qXcWAmxOpt2So4KOhVP3oTw2XTkIPikJ02bGNEJLyM1
 QO7NM7Y89ijJR4WuTNjPeAGWTDkqMKSMChHOA9VeXLKc+cBc8WNbWWY/ikkHjJje+hN1
 /Ao46Yi3+LzHgeixjtnIdoK1wkA5HiHb12rBw1lP4nmGmEwHfP7sfxqllRBQd7C58Crn
 O0NH89tDTBvtaK7zSL3JVxA2mepD/P8Z3y0JnDyE1tzHge6oYg0gVxXz0O1hnrkgokU/
 9WgGwiixMtA1zBFZ7ToD4xC8ZLdTpAQ3sA10u5birrp5u+dg/HLJr0qIZ/djIGbkg7qy
 Hktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755005321; x=1755610121;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9/hzcU+ZtuPzfrVepFsWSd7nGBb2dO+zRh6r8pCwa/I=;
 b=Vn1n75hXMqKWMzHqJGy7W6/LgOeMk6yXzT52M8BgAUfhIlP676ISa1E/2Tc9z8Hy/C
 RrTSU2Rzub07wS8F1ZayTpOOZUvH+trzdMYKTqccETgods7xMqOsrZc1pMjn3vSX9oPa
 MXeaR7clOpJ5e046J2PjIfzcmlY69CJfuA3fyidPhG369t2aBQGlCMGuDG4a3IugejiI
 wtF61ExARcHuAaD2FqrhZVnphx4yM6DrHeW8PNC/8DboYh8Ls/CKw/6eZqREe+ta56UC
 UhL3VmO+y+EsZR4SnJ1jnc2SBHnCplCympLUyrDnLL7DCOS4Z/q1y4WFCJGUnnaM3LsU
 aitg==
X-Gm-Message-State: AOJu0YxPCpf0hf6BdNQuki1++FykbgDidBYKMAcBiN4ETaXUbF3zXvIY
 0RDVeHWzcpGrAO22UB/zwUD5c4e5Db4a3fV00hcANJZOMDlTOG70PEijdBiMIdidyLQ=
X-Gm-Gg: ASbGncvoZ2a69tLSgr+ERF6b6sTmmmELzGOSFD43xW7UtWONWFnujfyug4KqeL+eU+X
 cA/kxOEjN6sSSw7SvoKkzzjK24Rc0PwtM7r34FkPc+AqZJg6l0CBglI74E1fMl6D314M4vJ98pn
 IFWlj676jpM7dhszUGFB9q5xPQwy4sbGoq1WhBQIGka6o4P8scm2nCtK+YCMN0LxMTunkzBb7S+
 Byil6lnW8k3cajJBGUETPSFapTYMiVbF80rCWAqtYpvZ1FOXMwyK2hu2e/dOHDPowMeorJpp3tD
 2/P4ahe19FWeA92MlO8JWlRpz+YOjUAo2HwTTYz4MyptTp4j8lNTXGjnaJacGOPnXUgYvu4/YrC
 IRuOgO+aapROG20o3n46thSMGp72iw6yYPvFY/ZBdpUBmge6COm9Ft4ycMKhZakxvGw==
X-Google-Smtp-Source: AGHT+IEOtvnCP47zR2T7hlfGqvGwD3Xox5T7DTFI4sO+/1BM4D6d4mitGVGqm6V0yovVOt8pCQt5iw==
X-Received: by 2002:adf:c744:0:b0:3b9:12d5:168f with SMTP id
 ffacd0b85a97d-3b912d51cd7mr1326168f8f.30.1755005320852; 
 Tue, 12 Aug 2025 06:28:40 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b916394937sm218003f8f.6.2025.08.12.06.28.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 06:28:40 -0700 (PDT)
Message-ID: <25f71d42-86e0-41c0-84a8-71edc9211ee5@linaro.org>
Date: Tue, 12 Aug 2025 15:28:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 2/2] tests/functional: Test SPI-SD adapter
 without SD card connected
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-block@nongnu.org
References: <20250808135115.77310-1-philmd@linaro.org>
 <20250808135115.77310-3-philmd@linaro.org> <87ikisad0u.fsf@draig.linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87ikisad0u.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/8/25 15:24, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> SPI-SD adapter should be usable, even without any SD card
>> wired. Refactor test_riscv64_sifive_u_mmc_spi() to make it
>> more generic and add another test, inspired by this report:
>> https://lore.kernel.org/qemu-devel/5b2dc427-f0db-4332-a997-fe0c82415acd@roeck-us.net/
>>
>> Inspired-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/functional/test_riscv64_sifive_u.py | 22 +++++++++++++++++-----
>>   1 file changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/tests/functional/test_riscv64_sifive_u.py b/tests/functional/test_riscv64_sifive_u.py
>> index dc4cb8a4a96..f7ab1abfd56 100755
>> --- a/tests/functional/test_riscv64_sifive_u.py
>> +++ b/tests/functional/test_riscv64_sifive_u.py
>> @@ -27,25 +27,37 @@ class SifiveU(LinuxKernelTest):
>>            'rootfs.ext2.gz'),
>>           'b6ed95610310b7956f9bf20c4c9c0c05fea647900df441da9dfe767d24e8b28b')
>>   
>> -    def test_riscv64_sifive_u_mmc_spi(self):
>> +    def do_test_riscv64_sifive_u_mmc_spi(self, connect_card):
>>           self.set_machine('sifive_u')
>>           kernel_path = self.ASSET_KERNEL.fetch()
>>           rootfs_path = self.uncompress(self.ASSET_ROOTFS)
>>   
>>           self.vm.set_console()
>>           kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
>> -                               'root=/dev/mmcblk0 rootwait '
>>                                  'earlycon=sbi console=ttySIF0 '
>> -                               'panic=-1 noreboot')
>> +                               'root=/dev/mmcblk0 ')
>>           self.vm.add_args('-kernel', kernel_path,
>> -                         '-drive', f'file={rootfs_path},if=sd,format=raw',
>>                            '-append', kernel_command_line,
>>                            '-no-reboot')
>> +        if connect_card:
>> +            self.vm.add_args('-drive', f'file={rootfs_path},if=sd,format=raw')
>> +            kernel_command_line += 'panic=-1 noreboot rootwait '
>> +            pattern = 'Boot successful.'
>> +        else:
>> +            kernel_command_line += 'panic=0 noreboot '
>> +            pattern = 'Cannot open root device "mmcblk0" or unknown-block(0,0)'
>> +
>>           self.vm.launch()
>> -        self.wait_for_console_pattern('Boot successful.')
>> +        self.wait_for_console_pattern(pattern)
>>   
>>           os.remove(rootfs_path)
>>   
>> +    def _test_riscv64_sifive_u_nommc_spi(self):
>> +        self.do_test_riscv64_sifive_u_mmc_spi(False)
> 
> This test won't run because of the leading _

Oops, I was carefully testing one case after each other and missed
to remove this leading char!

> 
>> +
>> +    def test_riscv64_sifive_u_mmc_spi(self):
>> +        self.do_test_riscv64_sifive_u_mmc_spi(True)
>> +
>>   
>>   if __name__ == '__main__':
>>       LinuxKernelTest.main()
> 


