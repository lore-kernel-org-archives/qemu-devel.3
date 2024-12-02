Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118AFD10DDD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 09:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI3AY-0007uh-Ik; Mon, 02 Dec 2024 04:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI3AX-0007uU-3o
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 04:56:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI3AU-00020C-2P
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 04:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733133396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yIDU5orxGRJASAwIaO0yldrm+4RS2aiFJQQCxOh4YoI=;
 b=IQqHT+CzopblamMzRgaNk5hUxORMiheqHAZorgRlJgxUK28vIFvbSmeMGxclVf10Eptk0w
 7KPoiZzCb8UDxTdX4ffX5JMe1h0Jt4SjkXgzKO3sDuFglyTt9STYobcgnbYE0KcmX4HuSe
 ZqRqPQj7obhYu8hCusCZBufxa/3HtTc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-g6YlhO2UOn60a_7UGDnTPQ-1; Mon, 02 Dec 2024 04:56:34 -0500
X-MC-Unique: g6YlhO2UOn60a_7UGDnTPQ-1
X-Mimecast-MFC-AGG-ID: g6YlhO2UOn60a_7UGDnTPQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-434a6483514so29319015e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 01:56:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733133393; x=1733738193;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yIDU5orxGRJASAwIaO0yldrm+4RS2aiFJQQCxOh4YoI=;
 b=uectSdQUujeAkUKCEDvJw82ygB3IMVzTcfoWus8NRHPfulpqiADxjwU9jTn0pRBcTL
 v7h4FMUCB2wlOAJ9XCLXDC+3nF0mriCJKCidOpG5KmozAEWFGdHIFDbjPhV3wr9KDxtG
 MVY9Ya89XkOkF8GbGqGx/7Df4C0WBM2wgBN3i5gK6h4akKtjUCSWFqYLqqFqAh1PHpmb
 2f/MiEoBD2n4ZJ8GnutTjmpEJa7OtA+lPbZ+pwFHxyrVNvXth1gCO2wUENT94Y/ODlp0
 CmtK2DxBMjsF18WTtSKOMZw5BhbzRfsq003liEjUVQv0Mde+U75aQPEsORn+EesIz1GF
 8e2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWq3U2h9g20SDjkO8QquQcmmeZuuMXBXNr8Y/suxBlFiJtKv9QPee7Wg+QHaXUiItcn0UZkltfasWi@nongnu.org
X-Gm-Message-State: AOJu0YwmIXsVSdlCzU1aWawbo9y6QqUv0lQb496CoBGlL/IDB2pTf5jm
 2VXtno+UKa3cA7Jd9K7xJcbz7YPIuG6bQMAHHveVPxQnRBvXuIW+uSAa3Maj8b7AMk6MKuByzI6
 S5KIpAp93LBcboBamxmhUFA2/Fj04Ub9ZgTegW/wz9/7Iy1m8LgPm
X-Gm-Gg: ASbGncvqATcYKEXZ1o2LMFtHCRi4m65QX3qNQBzL5MnCth8pVZr87kE2rl9/XtODfqs
 IPTVL9Z94KkKRQUU/l/2z5g0+jt165UWHSRkQJinnM7NopoUpA+2WRVkjauPAI1M8u3D0D0MOEl
 uEnt/9+OeC/RngSf01duXxG49UElEca4hvhzEA67TO4Wj/PYxwhxyBSRpfnpbFp3Z2CLuR3er3c
 2+UmE0Wz4YzRb8/HGwxhNtiuGwtZbgDa7+/ySS3pjNShQ+M9wpUNTlCzjsIiGESlYbpd2n3F+k=
X-Received: by 2002:a05:600c:1e88:b0:431:40ca:ce5d with SMTP id
 5b1f17b1804b1-434a9de4576mr172442865e9.23.1733133393681; 
 Mon, 02 Dec 2024 01:56:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxih5c2Ub3wi+vJk+mxJ94XjbA5zgvoMZGW4myH7N+MQEcUpz4BaQvUp3/Bep+rAI4YqaSPg==
X-Received: by 2002:a05:600c:1e88:b0:431:40ca:ce5d with SMTP id
 5b1f17b1804b1-434a9de4576mr172442635e9.23.1733133393243; 
 Mon, 02 Dec 2024 01:56:33 -0800 (PST)
Received: from [10.33.192.206] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa7e5285sm177723525e9.40.2024.12.02.01.56.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 01:56:32 -0800 (PST)
Message-ID: <575eb674-7b07-40c0-a537-da34549edcd2@redhat.com>
Date: Mon, 2 Dec 2024 10:56:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/22] tests/functional: switch over to using
 self.scratch_file()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-13-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241129173120.761728-13-berrange@redhat.com>
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

On 29/11/2024 18.31, Daniel P. Berrangé wrote:
> Replace any instances of
> 
>    os.path.join(self.workdir, ".../...")
>    self.workdir + "/.../..."
> 
> with
> 
>    self.scratch_file("...", "...")
> 
> which is more compact and portable
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
...
> diff --git a/tests/functional/qemu_test/linuxkernel.py b/tests/functional/qemu_test/linuxkernel.py
> index 2b5b9a5fda..a6525f9dd6 100644
> --- a/tests/functional/qemu_test/linuxkernel.py
> +++ b/tests/functional/qemu_test/linuxkernel.py
> @@ -46,8 +46,7 @@ def extract_from_deb(self, deb_path, path):
>           os.chdir(cwd)
>           # Return complete path to extracted file.  Because callers to
>           # extract_from_deb() specify 'path' with a leading slash, it is
> -        # necessary to use os.path.relpath() as otherwise os.path.join()
> -        # interprets it as an absolute path and drops the self.workdir part.
> -        return os.path.normpath(os.path.join(self.workdir,
> -                                             os.path.relpath(path, '/')))
> +        # necessary to use 'relative_to()' to turn it into a relative

Here you mention "relative_to()" ....

> +        # path for joining to the scratch dir
> +        return os.path.normpath(self.scratch_file(os.path.relpath(path, '/')))

... but the code still uses relpath() instead?

> diff --git a/tests/functional/test_aarch64_aspeed.py b/tests/functional/test_aarch64_aspeed.py
> index 59916efd71..c6c6b74acc 100644
> --- a/tests/functional/test_aarch64_aspeed.py
> +++ b/tests/functional/test_aarch64_aspeed.py
> @@ -39,26 +39,28 @@ def test_aarch64_ast2700_evb_sdk_v09_02(self):
>           archive_extract(image_path, self.workdir)
>   
>           num_cpu = 4
> -        image_dir = self.workdir + '/ast2700-default/'

I'd maybe just change image_dir and keep the code below as it is, so you can 
avoid specifying 'ast2700-default' again and again.

> -        uboot_size = os.path.getsize(image_dir + 'u-boot-nodtb.bin')
> +        uboot_size = os.path.getsize(self.scratch_file('ast2700-default',
> +                                                       'u-boot-nodtb.bin'))
>           uboot_dtb_load_addr = hex(0x400000000 + uboot_size)
>   
>           load_images_list = [
>               {
>                   'addr': '0x400000000',
> -                'file': image_dir + 'u-boot-nodtb.bin'
> +                'file': self.scratch_file('ast2700-default',
> +                                          'u-boot-nodtb.bin')
>               },
>               {
>                   'addr': str(uboot_dtb_load_addr),
> -                'file': image_dir + 'u-boot.dtb'
> +                'file': self.scratch_file('ast2700-default', 'u-boot.dtb')
>               },
>               {
>                   'addr': '0x430000000',
> -                'file': image_dir + 'bl31.bin'
> +                'file': self.scratch_file('ast2700-default', 'bl31.bin')
>               },
>               {
>                   'addr': '0x430080000',
> -                'file': image_dir + 'optee/tee-raw.bin'
> +                'file': self.scratch_file('ast2700-default', 'optee',
> +                                          'tee-raw.bin')
>               }
>           ]
>   
> @@ -75,7 +77,8 @@ def test_aarch64_ast2700_evb_sdk_v09_02(self):
>           self.vm.add_args('-smp', str(num_cpu))
>           self.vm.add_args('-device',
>                            'tmp105,bus=aspeed.i2c.bus.1,address=0x4d,id=tmp-test')
> -        self.do_test_aarch64_aspeed_sdk_start(image_dir + 'image-bmc')
> +        self.do_test_aarch64_aspeed_sdk_start(
> +            self.scratch_file('ast2700-default', 'image-bmc'))
>   
>           wait_for_console_pattern(self, 'ast2700-default login:')
>   
> diff --git a/tests/functional/test_aarch64_raspi3.py b/tests/functional/test_aarch64_raspi3.py
> index 369f95a3d9..98ed6f9d56 100755
> --- a/tests/functional/test_aarch64_raspi3.py
> +++ b/tests/functional/test_aarch64_raspi3.py
> @@ -7,7 +7,6 @@
>   #
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   
> -import os
>   from zipfile import ZipFile
>   
>   from qemu_test import LinuxKernelTest, Asset
> @@ -26,7 +25,7 @@ def test_aarch64_raspi3_atf(self):
>   
>           with ZipFile(zip_path, 'r') as zf:
>                        zf.extract(efi_name, path=self.workdir)

Should that self.workdir above get replaced with self.scratch_file(), too?

> -        efi_fd = os.path.join(self.workdir, efi_name)
> +        efi_fd = self.scratch_file(efi_name)
>   
>           self.set_machine('raspi3b')
>           self.vm.set_console(console_index=1)
...
> diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed.py
> index db872ff05e..c4869011db 100755
> --- a/tests/functional/test_arm_aspeed.py
> +++ b/tests/functional/test_arm_aspeed.py
> @@ -35,7 +35,7 @@ def test_ast1030_zephyros_1_04(self):
>           kernel_name = "ast1030-evb-demo/zephyr.elf"
>           with ZipFile(zip_file, 'r') as zf:
>                        zf.extract(kernel_name, path=self.workdir)
> -        kernel_file = os.path.join(self.workdir, kernel_name)
> +        kernel_file = self.scratch_file(kernel_name)
>   
>           self.vm.set_console()
>           self.vm.add_args('-kernel', kernel_file, '-nographic')
> @@ -57,7 +57,7 @@ def test_ast1030_zephyros_1_07(self):
>           kernel_name = "ast1030-evb-demo/zephyr.bin"
>           with ZipFile(zip_file, 'r') as zf:
>                        zf.extract(kernel_name, path=self.workdir)
> -        kernel_file = os.path.join(self.workdir, kernel_name)
> +        kernel_file = self.scratch_file(kernel_name)
>   
>           self.vm.set_console()
>           self.vm.add_args('-kernel', kernel_file, '-nographic')
> @@ -226,14 +226,16 @@ def test_arm_ast2600_evb_buildroot_tpm(self):
>   
>           image_path = self.ASSET_BR2_202302_AST2600_TPM_FLASH.fetch()
>   
> -        tpmstate_dir = tempfile.TemporaryDirectory(prefix="qemu_")
> +        tpmstate_dir = self.scratch_file('swtpmstate')
> +        os.mkdir(tpmstate_dir)
> +        socket_dir = tempfile.TemporaryDirectory(prefix="qemu_")

You don't seem to use socket_dir in any of your changes below?

Also, shouldn't this rather be using self.socket_dir() now?
(maybe rather something for a separate patch?)

>           socket = os.path.join(tpmstate_dir.name, 'swtpm-socket')
>   
>           # We must put the TPM state dir in /tmp/, not the build dir,
>           # because some distros use AppArmor to lock down swtpm and
>           # restrict the set of locations it can access files in.
>           subprocess.run(['swtpm', 'socket', '-d', '--tpm2',
> -                        '--tpmstate', f'dir={tpmstate_dir.name}',
> +                        '--tpmstate', f'dir={tpmstate_dir}',
>                           '--ctrl', f'type=unixio,path={socket}'])
>   
>           self.vm.add_args('-chardev', f'socket,id=chrtpm,path={socket}')
> @@ -274,7 +276,7 @@ def test_arm_ast2500_evb_sdk(self):
>           archive_extract(image_path, self.workdir)
>   
>           self.do_test_arm_aspeed_sdk_start(
> -            self.workdir + '/ast2500-default/image-bmc')
> +            self.scratch_file('ast2500-default', 'image-bmc'))
>   
>           self.wait_for_console_pattern('ast2500-default login:')
>   
> @@ -294,7 +296,7 @@ def test_arm_ast2600_evb_sdk(self):
>           self.vm.add_args('-device',
>               'ds1338,bus=aspeed.i2c.bus.5,address=0x32');
>           self.do_test_arm_aspeed_sdk_start(
> -            self.workdir + '/ast2600-a2/image-bmc')
> +            self.scratch_file('ast2600-a2', 'image-bmc'))
>   
>           self.wait_for_console_pattern('ast2600-a2 login:')
>   
...

  Thomas


