Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D29C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 13:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkk5L-0001VN-3e; Wed, 19 Feb 2025 08:25:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkk5E-0001TS-IH
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 08:25:48 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkk5A-0000wL-N1
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 08:25:48 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38a8b17d7a7so3705543f8f.2
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 05:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739971542; x=1740576342; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DtuF+rz3778eIKLYUWSSALvsbBodG1m8cm177EWmjXM=;
 b=OBXmFU24e23zokvt2UFPDRznmgzwDP+6rYQe+tZ4KrS6iwbrztDIX5+GZ0QbsCyDzs
 r1O+opx+hgkn3U1zdSsmnqr9k9bBwrnhJRVbtF+HL+VJ8pwpi2WyJ38+xj2iwq3/dWV7
 vRJbIBx7TfSG/7laqkT7KOlQxTevGru4phcuQaesBQ1idT3C0JhIZZ6HS9P9P4FmaOwp
 po//9t0sDZHQIVfax+ucCgeElC7EFEsE7QqAfy7fOzFVK083mSMwDSclyUgYAbmrbu5N
 MSszWRT8KIRMhZ+ssEkbt9gW75RB39l2NeeUOkbJiQs3H1+u/jqR7yX1M+2ZrNEUUc3l
 WLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739971542; x=1740576342;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DtuF+rz3778eIKLYUWSSALvsbBodG1m8cm177EWmjXM=;
 b=nfrtkai4cU/bODk/jGGLsRXEqA/c7Oi65BSAyi27duXmlXNKeuc3ehSK53Db1g4Nw4
 4Yi/zdH9IH9yWVkbq8wkIuAzD4ai4XEHhY2ZyK2U1u+7pOKNc/yl6I0baXRNkMNBsnvF
 8C50OROZxWniMDSA3WmgXkvsbPsOf8i7u5ejintAuZ0sn7tLYFFQBG7mPkM3GvkAfh9z
 9YQSugB14jOOHbaNyJidljkvTgSkoXfbfodcwqCRhjggP5cXht0T1oFLy0RMfLcai67Y
 7RszqM5S/LfIp66EorR/CnjRCqCDKXGQcYx/CRMTL9CrrTk3+giRzXg7qhcQrdQcfwK7
 yDmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUIIFefTh1U97aFXl6cHAFiYpw79uWO7EOavS5WpQVzq+/PhkRfZ/Xq77RoitXpKE/aEn2x/1EaYv/@nongnu.org
X-Gm-Message-State: AOJu0YzHeJDzZ1zBgFI5g/AlrRpd3IQJJo1QhysHCC+W/uFJCSch/x/i
 AmWr7ebbga385cSfZBbkWk1DHwDOSWwTHIiGcP4KDC6PNlqV48SxRjeT/xkll1g=
X-Gm-Gg: ASbGncuHBKcSqSfbx6p5NWJXdN7pKauG7z3txuxeddUOP5CKvRQbumclK4Zj+pgilQw
 vPL5bbDqOrCnRBVP0H4U82tGuVAcoi9EqP2rI+94eI9LxeklRGVWu5K6bw42R2mRcywmfkOs/IL
 eZqO6WuGBkYHbYmifQheiHxmgHx/qFzw/JxKVbULkfvhwDFO8KR+LL35ugG/DIy4JvMNcBVnanC
 9ljWGfpET72PC0eJto3yCqSDAR8f7OcmgALuIfLVkUtA9RuVoZ5iTJHuBE3+JeOcWiaDeju8qgg
 l3ukbu7L65/ZrEHX2Q5glm0maJF6fhHpUQF2LQR6uz+ikNqsjbOQHFOT6+s=
X-Google-Smtp-Source: AGHT+IGQi91u7eT7pJaTa/M46yJFoAWIp0cbTppUiL2Wr7Z9PasuLWGkNly1NAnHG8rmGiO8vNDf6Q==
X-Received: by 2002:a5d:588f:0:b0:38f:3791:c1d3 with SMTP id
 ffacd0b85a97d-38f587f4141mr2809496f8f.54.1739971541858; 
 Wed, 19 Feb 2025 05:25:41 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258ddba7sm18113033f8f.38.2025.02.19.05.25.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2025 05:25:41 -0800 (PST)
Message-ID: <91a78caf-2200-42b7-8da6-e857af38bad7@linaro.org>
Date: Wed, 19 Feb 2025 14:25:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 23/32] tests/functional: extend test_aarch64_virt with
 vulkan test
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 "open list:Virt" <qemu-arm@nongnu.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
 <20250110131754.2769814-24-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250110131754.2769814-24-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

(+Markus for CLI)

On 10/1/25 14:17, Alex Bennée wrote:
> Now that we have virtio-gpu Vulkan support, let's add a test for it.
> Currently this is using images build by buildroot:
> 
>    https://lists.buildroot.org/pipermail/buildroot/2024-December/768196.html
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20250108121054.1126164-24-alex.bennee@linaro.org>
> 
> diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/test_aarch64_virt.py
> index 201c5ed023..6b2336a28d 100755
> --- a/tests/functional/test_aarch64_virt.py
> +++ b/tests/functional/test_aarch64_virt.py
> @@ -13,10 +13,12 @@
>   import logging
>   from subprocess import check_call, DEVNULL
>   
> +from qemu.machine.machine import VMLaunchFailure
> +
>   from qemu_test import QemuSystemTest, Asset
> -from qemu_test import exec_command_and_wait_for_pattern
> +from qemu_test import exec_command, exec_command_and_wait_for_pattern
>   from qemu_test import wait_for_console_pattern
> -from qemu_test import get_qemu_img
> +from qemu_test import skipIfMissingCommands, get_qemu_img
>   
>   
>   class Aarch64VirtMachine(QemuSystemTest):
> @@ -132,5 +134,73 @@ def test_aarch64_virt_gicv2(self):
>           self.common_aarch64_virt("virt,gic-version=2")
>   
>   
> +    ASSET_VIRT_GPU_KERNEL = Asset(
> +        'https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
> +        'download?path=%2F&files='
> +        'Image',
> +        '89e5099d26166204cc5ca4bb6d1a11b92c217e1f82ec67e3ba363d09157462f6')
> +
> +    ASSET_VIRT_GPU_ROOTFS = Asset(
> +        'https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
> +        'download?path=%2F&files='
> +        'rootfs.ext4.zstd',
> +        '792da7573f5dc2913ddb7c638151d4a6b2d028a4cb2afb38add513c1924bdad4')
> +
> +    @skipIfMissingCommands('zstd')
> +    def test_aarch64_virt_with_gpu(self):
> +        # This tests boots with a buildroot test image that contains
> +        # vkmark and other GPU exercising tools. We run a headless
> +        # weston that nevertheless still exercises the virtio-gpu
> +        # backend.
> +
> +        self.set_machine('virt')
> +        self.require_accelerator("tcg")
> +
> +        kernel_path = self.ASSET_VIRT_GPU_KERNEL.fetch()
> +        image_path = self.uncompress(self.ASSET_VIRT_GPU_ROOTFS, format="zstd")
> +
> +        self.vm.set_console()
> +        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'console=ttyAMA0 root=/dev/vda')
> +
> +        self.vm.add_args("-accel", "tcg")
> +        self.vm.add_args("-cpu", "neoverse-v1,pauth-impdef=on")
> +        self.vm.add_args("-machine", "virt,gic-version=max",
> +                         '-kernel', kernel_path,
> +                         '-append', kernel_command_line)
> +        self.vm.add_args("-smp", "2", "-m", "2048")
> +        self.vm.add_args("-device",
> +                         "virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on")
> +        self.vm.add_args("-display", "egl-headless")
> +        self.vm.add_args("-display", "dbus,gl=on")

[*]

> +        self.vm.add_args("-device", "virtio-blk-device,drive=hd0")
> +        self.vm.add_args("-blockdev",
> +                         "driver=raw,file.driver=file,"
> +                         "node-name=hd0,read-only=on,"
> +                         f"file.filename={image_path}")
> +        self.vm.add_args("-snapshot")
> +
> +        try:
> +            self.vm.launch()
> +        except VMLaunchFailure as excp:
> +            if "old virglrenderer, blob resources unsupported" in excp.output:
> +                self.skipTest("No blob support for virtio-gpu")
> +            elif "old virglrenderer, venus unsupported" in excp.output:
> +                self.skipTest("No venus support for virtio-gpu")

This seems dependent on the order of the CLI arguments, as I got:

qemu-system-aarch64: -device 
virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on: 'virtio-gpu-gl-pci' is 
not a valid device model name

I understand it is too complex to check this device availability with
meson, in order to avoid running the test.

Can we use device introspection instead, like we do in QTest with
qtest_qom_has_concrete_type() for accelerators? Maybe in the lines of:

   @skipIfMissingQOMType('virtio-gpu-gl-pci')

Or having a skipIfMissingDevice -> skipIfMissingQOMType alias:

   @skipIfMissingDevice('virtio-gpu-gl-pci')

tests/functional/test_virtio_version.py already uses some of it:

  def devtype_implements(vm, devtype, implements):
      return devtype in [d['name'] for d in
                         vm.cmd('qom-list-types', implements=implements)]

> +            else:
> +                self.log.info("unhandled launch failure: {excp.output}")
> +                raise excp
> +
> +        self.wait_for_console_pattern('buildroot login:')
> +        exec_command(self, 'root')
> +        exec_command(self, 'export XDG_RUNTIME_DIR=/tmp')
> +        exec_command_and_wait_for_pattern(self,
> +                                          "weston -B headless "
> +                                          "--renderer gl "
> +                                          "--shell kiosk "
> +                                          "-- vkmark -b:duration=1.0",
> +                                          "vkmark Score")
> +
> +
>   if __name__ == '__main__':
>       QemuSystemTest.main()


