Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9267DC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 15:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulr1N-00054K-Ue; Tue, 12 Aug 2025 11:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1ulr1D-00053m-7h
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 11:34:33 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1ulr14-00044J-7Y
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 11:34:30 -0400
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2430c3684d1so53185ad.0
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 08:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755012855; x=1755617655; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dpdxy2ZTSYgoW5/IzqwEyu/cYYWBjWQnFzB0uOBTZUY=;
 b=wq7F2TT5wZKu4T+7mqXwJrTVhuFnevayitv2EfI4WzQMxgazSib7K5YEbzdH3vFIu4
 UimEBEOSdl0fGtco0MwH3M/UJ1lbLOio66EIbPAZ7ZJZ5YYMTs8iZp4wukKGV9YQ67JJ
 6dQEGN8bqPxl3IvZyiyrK8zdYxjr2y9JgpRKSfydU/VUnJtMtaNWqMfWGhc57x7sV9uZ
 7KHH3FTQgT+IGFvyGdRe5u+UqsY+zpBW23ClsWd/LgvqfFRrI0pKZWKTY1vwBoNCyTwh
 9Jbi+VTaY7H7rrZZgZz+BMHA6hI7yDLzLVobVdECo/0EfnO+3gkNHaklF9brU9jUnbYh
 fyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755012855; x=1755617655;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dpdxy2ZTSYgoW5/IzqwEyu/cYYWBjWQnFzB0uOBTZUY=;
 b=ccLik8tQM4g4+QsdIBjimEHmNXt3ZbbMCBsI0YkD2CjWi0q/TBLRJ+rGyXzIFcCwdG
 dYF84jtH6urHjgeFvX9zbmJKVUXnWChx6zrpvusZ+sRLLXhI6l/XWQDyfJkzHcMSJNj8
 vjLZQ7QfqdxXpMEvXayzgbT8LPzSQwqcPFjtdbiFT81hIy2k+2YmKERxHXbAc32EipaW
 XgkV+tFoihw1OZ1CevRef6sL/Z8dZ9AtEmuCnEZ0ddZgLaT8b5EEvHm4SANtzwXJpO25
 3BPXd6NtoHIrOI4hoe+AIgwc3qvckxQ2ziXocbSmqSPvC58VQlBK9NbH7CP9tW9Prd2o
 M50w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3G8dgfCpTwqSunkE8gdAtknZfQoqulZxy9j0twM4QLwb8HQfvHbz36Z901OT00Os2h8kZK9nZ3WYd@nongnu.org
X-Gm-Message-State: AOJu0Yz88kB3LLPwx9bt5TRryiM2DMqi8a2P9VPi1Fzid50huFVqtF+V
 lHyYqwLK7pddrDu4iwP41nlrjm7N2y7tuJZuW8V70FkMC1C0d4xg673g4yXqgB89ltAMbRvRppj
 /45I91PE8PA==
X-Gm-Gg: ASbGncuqiH87OiQ79x87KJ8AAwU4AlPisYoH7n2FX1qz/++9x7h7bLrnwrU3fNI8jY5
 1yq+ciXhEsm+dTl5x2Z7kqQQh+DeT5WhmqDTMRwOge7KpO84merpadHCp3eFel9UiGSLSo7g1Td
 Be4VptUnuYQ2GSU3TGD9liEA9xtjyEV0SAM6/lc5o0EnBzA1jUOKlH7mQwA1dyHOGU0a6cubljy
 7iyXlqLn/aVpz6PJcY9w1pYm+m7r2cSPcHFJgELg2oR1MpsbZzH17AVJ1t0c7E8iHFIiizRyu6x
 nvXl3dYfr31Dd55YpLFJixZn4GftP6FYVp5Z9mO9Hr2UMS5wx57Ok9eI5yz0W5yepakKscTQkfD
 9LXXL8x3DqsaEGziQzyNwjcN6P7rS5l7yVDk=
X-Google-Smtp-Source: AGHT+IH9jdsY+JAwXvfpp7egiTeIclVxD+gi6agb07w9LJLCAUCfn2pSsUavE8Iyz8A0LgPDF5Nysg==
X-Received: by 2002:a17:902:ce92:b0:237:f757:9ad8 with SMTP id
 d9443c01a7336-242fc2a526emr63624615ad.1.1755012855255; 
 Tue, 12 Aug 2025 08:34:15 -0700 (PDT)
Received: from [192.168.0.102] ([152.250.234.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899a917sm305400515ad.116.2025.08.12.08.34.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 08:34:14 -0700 (PDT)
Message-ID: <5740a0e1-0c2f-433a-ba40-acf43adbaa37@linaro.org>
Date: Tue, 12 Aug 2025 12:35:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 RESEND RESEND v2 2/3] tests/functional: Test
 SPI-SD adapter without SD card connected
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>
References: <20250812140415.70153-1-philmd@linaro.org>
 <20250812140415.70153-3-philmd@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250812140415.70153-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x644.google.com
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

Hi Phil,

On 8/12/25 11:04, Philippe Mathieu-Daudé wrote:
> SPI-SD adapter should be usable, even without any SD card
> wired. Refactor test_riscv64_sifive_u_mmc_spi() to make it
> more generic and add another test, inspired by this report:
> https://lore.kernel.org/qemu-devel/5b2dc427-f0db-4332-a997-fe0c82415acd@roeck-us.net/
> 
> Inspired-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/functional/test_riscv64_sifive_u.py | 22 +++++++++++++++++-----
>   1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/functional/test_riscv64_sifive_u.py b/tests/functional/test_riscv64_sifive_u.py
> index dc4cb8a4a96..ca4c3ba6e12 100755
> --- a/tests/functional/test_riscv64_sifive_u.py
> +++ b/tests/functional/test_riscv64_sifive_u.py
> @@ -27,25 +27,37 @@ class SifiveU(LinuxKernelTest):
>            'rootfs.ext2.gz'),
>           'b6ed95610310b7956f9bf20c4c9c0c05fea647900df441da9dfe767d24e8b28b')
>   
> -    def test_riscv64_sifive_u_mmc_spi(self):
> +    def do_test_riscv64_sifive_u_mmc_spi(self, connect_card):
>           self.set_machine('sifive_u')
>           kernel_path = self.ASSET_KERNEL.fetch()
>           rootfs_path = self.uncompress(self.ASSET_ROOTFS)
>   
>           self.vm.set_console()
>           kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
> -                               'root=/dev/mmcblk0 rootwait '
>                                  'earlycon=sbi console=ttySIF0 '
> -                               'panic=-1 noreboot')
> +                               'root=/dev/mmcblk0 ')
>           self.vm.add_args('-kernel', kernel_path,
> -                         '-drive', f'file={rootfs_path},if=sd,format=raw',
>                            '-append', kernel_command_line,
>                            '-no-reboot')
> +        if connect_card:
> +            self.vm.add_args('-drive', f'file={rootfs_path},if=sd,format=raw')
> +            kernel_command_line += 'panic=-1 noreboot rootwait '

I would put kernel_command_line before add_args just to follow the order above,
but really it's a nit and for sure not worth a v3, but mentioning it just in
case there will be a v3 and you want to change it.


> +            pattern = 'Boot successful.'
> +        else:
> +            kernel_command_line += 'panic=0 noreboot '
> +            pattern = 'Cannot open root device "mmcblk0" or unknown-block(0,0)'
> +
>           self.vm.launch()
> -        self.wait_for_console_pattern('Boot successful.')
> +        self.wait_for_console_pattern(pattern)
>   
>           os.remove(rootfs_path)
>   
> +    def test_riscv64_sifive_u_nommc_spi(self):
> +        self.do_test_riscv64_sifive_u_mmc_spi(False)
> +
> +    def test_riscv64_sifive_u_mmc_spi(self):
> +        self.do_test_riscv64_sifive_u_mmc_spi(True)
> +
>   
>   if __name__ == '__main__':
>       LinuxKernelTest.main()

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

