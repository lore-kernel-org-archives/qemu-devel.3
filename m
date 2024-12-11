Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF182E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 06:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLGfs-0000go-96; Wed, 11 Dec 2024 01:58:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLGfm-0000fb-RS
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 01:58:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLGfh-0003Cz-IO
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 01:58:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733900287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Gy2n11iGTa9ZiqbyiHBxIp01HGftCyw+zIb9nN+g+e0=;
 b=NsNkmKxFVrsLTDTSYwXpOhVk1s0ePU1ExrugMJdYaA4QShmdD0PzlZUf9jhK2q32Q7fhAd
 kEzagl3T3eTiHq8E6DAgNOclxBYBBdqFewT0x7j76RtCeKvCrnAUs+lYTdMJoH//8UoRIj
 3w631WGqjtFthvuZkuTEdJjlhStdQMs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-9xROA06LMEeYn2LM35UnUg-1; Wed, 11 Dec 2024 01:58:06 -0500
X-MC-Unique: 9xROA06LMEeYn2LM35UnUg-1
X-Mimecast-MFC-AGG-ID: 9xROA06LMEeYn2LM35UnUg
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa68203d288so286778066b.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 22:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733900285; x=1734505085;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gy2n11iGTa9ZiqbyiHBxIp01HGftCyw+zIb9nN+g+e0=;
 b=cnq3lUpTVb4768DyNXzVWvlR/wcZVX451n6Jy4GGTJevVLHofVWBxyT/0bdXsSyFkX
 L9QEflbkl377nda5lMIGnM98e2gpf35cR2p0IRLcE0qcjWKdyZPFFxt7XNZZXVYKjdTC
 7verbR++dtfBvivppl2Qm4gG/13CZbT8rXZTntyldkX6NXMGildogKo9RgEoG2c98qpg
 +L+T1p0/+OGDSS4AGjjrr9U8FKdOuOISXE1sdhxRTfzcp9DCAD/q4Dun8orT0jSjsq+r
 90J1eqLSfk4YTq4W4fBV3oSNL+27PpYWvSxbaTaDG/CqYO4HInS3wGEJKo/fR4lO9kVI
 1zMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbrySSEhwd4kiaWgcw+kJigKzAsYUUuZOUtmIX9dPRIfh5IPOx6m2NC9TYwa4L/fod4ju3iJ/j5uoj@nongnu.org
X-Gm-Message-State: AOJu0YyRiq7b1KdBe7YeaTd8nSWkFt+yrGYYOEAt+kEZmig73V365+Ll
 wGqL/QdaKmouweC4yERFzXYn7ihorsCpjmidkfTo6FCvC1hd3PDI8JxZjFPpz1RJlgBwvGsZtMQ
 9YcHENKEQT/SykFc3LBmoUC1dkkvbkaoOczRmVFI6AefCWJLlci/c660iY5+5
X-Gm-Gg: ASbGnct1I/uSju+MCW/hlBpNtkCsCfQXovJiU27O3KiTZtZQSdJj2v0IWhMm1YPcGjq
 IVz/ucILNwXpDeKvs4/qOxWY+mZjUvmkFPOoCz0FjlxfXvDNzWKuBuJ8OhXRHOmK85fA4CGs6lZ
 n9Uw2iUjanqHK9y/lVdDPznxlqJc02LsvHep901sC90fbxus5LMrLzu3bbuyz7Wz2Y+hWXHYQel
 2VpZsa4bVvMnIZYwC0xALDufvQHOdrZ6thGguMfF4fNNRALPez961HGI+qcz1npVkDaxBl00iVl
 0oRjadA=
X-Received: by 2002:a17:906:328e:b0:aa6:7f3d:4f9b with SMTP id
 a640c23a62f3a-aa6b11a4696mr102432166b.24.1733900284714; 
 Tue, 10 Dec 2024 22:58:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJZ4QMul4Lj7dG40jtzocfHouPwWFqfZYWWa72KRde9Qyho4783jBmXKtvamxu8mX//eGr4A==
X-Received: by 2002:a17:906:328e:b0:aa6:7f3d:4f9b with SMTP id
 a640c23a62f3a-aa6b11a4696mr102427866b.24.1733900284238; 
 Tue, 10 Dec 2024 22:58:04 -0800 (PST)
Received: from [192.168.0.6] (ip-109-42-51-17.web.vodafone.de. [109.42.51.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa667925953sm597991566b.9.2024.12.10.22.58.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 22:58:03 -0800 (PST)
Message-ID: <d2a73820-58fa-41d0-8f38-68b0ad53fa7d@redhat.com>
Date: Wed, 11 Dec 2024 07:58:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/20] tests/functional: extend test_aarch64_virt with
 vulkan test
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Cleber Rosa <crosa@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Eric Farman
 <farman@linux.ibm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20241210204349.723590-1-alex.bennee@linaro.org>
 <20241210204349.723590-21-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241210204349.723590-21-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/12/2024 21.43, Alex Bennée wrote:
> Now we have virtio-gpu Vulkan support lets add a test for it.
> Currently this is using images build by buildroot:
> 
>    https://lists.buildroot.org/pipermail/buildroot/2024-December/768196.html
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/functional/test_aarch64_virt.py | 83 ++++++++++++++++++++++++++-
>   1 file changed, 80 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/test_aarch64_virt.py
> index 801300607c..25d11e2626 100755
> --- a/tests/functional/test_aarch64_virt.py
> +++ b/tests/functional/test_aarch64_virt.py
> @@ -14,11 +14,12 @@
>   import os
>   import logging
>   
> +from qemu.machine.machine import VMLaunchFailure
> +
>   from qemu_test import BUILD_DIR
>   from qemu_test import QemuSystemTest, Asset
> -from qemu_test import exec_command, wait_for_console_pattern
> -from qemu_test import get_qemu_img, run_cmd
> -
> +from qemu_test import exec_command, wait_for_console_pattern, exec_command_and_wait_for_pattern
> +from qemu_test import has_cmd, get_qemu_img, run_cmd
>   
>   class Aarch64VirtMachine(QemuSystemTest):
>       KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
> @@ -125,5 +126,81 @@ def test_aarch64_virt_gicv2(self):
>           self.common_aarch64_virt("virt,gic-version=2")
>   
>   
> +    ASSET_VIRT_GPU_KERNEL = Asset(
> +        ('https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
> +         'download?path=%2F&files='
> +         'Image'),
> +        '89e5099d26166204cc5ca4bb6d1a11b92c217e1f82ec67e3ba363d09157462f6')
> +
> +    ASSET_VIRT_GPU_ROOTFS = Asset(
> +        ('https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
> +         'download?path=%2F&files='
> +         'rootfs.ext4.zstd'),
> +        '792da7573f5dc2913ddb7c638151d4a6b2d028a4cb2afb38add513c1924bdad4')
> +
> +    def test_aarch64_virt_with_gpu(self):
> +        # This tests boots with a buildroot test image that contains
> +        # vkmark and other GPU exercising tools. We run a headless
> +        # weston that nevertheless still exercises the virtio-gpu
> +        # backend.
> +
> +        (has_zstd, msg) = has_cmd('zstd')
> +        if has_zstd is False:
> +            self.skipTest(msg)

I'd recommend to use a decorator instead:

@skipUnless(*has_cmd('zstd'))

or if Daniel's patch series lands first, switch to @skipIfMissingCommands:

https://lore.kernel.org/qemu-devel/20241129173120.761728-7-berrange@redhat.com/

> +        self.zstd = 'zstd'

You only use self.zstd once, so the detour through a variable seems 
unnecessary here?

> +        image_path_zst = self.ASSET_VIRT_GPU_ROOTFS.fetch()
> +        kernel_path = self.ASSET_VIRT_GPU_KERNEL.fetch()
> +
> +        image_path = self.workdir + "/rootfs.ext4"
> +
> +        run_cmd([self.zstd, "-f", "-d", image_path_zst,
> +                 "-o", image_path])
> +
> +        self.set_machine('virt')

Please move set_machine to the top of the function. Reasoning: It can cancel 
the test if the 'virt' machine has not been compiled into the binary. In 
that case you'd extracted the rootfs image in vain.

> +        self.vm.set_console()
> +        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'console=ttyAMA0 root=/dev/vda')
> +        self.require_accelerator("tcg")

Same, please move to the beginning since it can skip the test.

> +        self.vm.add_args("-accel", "tcg")
> +        self.vm.add_args("-cpu", "neoverse-v1,pauth-impdef=on")
> +        self.vm.add_args("-machine",
> +                         "virt,virtualization=on,"
> +                         "gic-version=max",
> +                         '-kernel', kernel_path,
> +                         '-append', kernel_command_line)
> +        self.vm.add_args("-smp", "2", "-m", "2048")
> +        self.vm.add_args("-device", "virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on")
> +        self.vm.add_args("-display", "egl-headless")
> +        self.vm.add_args("-display", "dbus,gl=on")
> +        self.vm.add_args("-device", "virtio-blk-device,drive=hd0")
> +        self.vm.add_args("-blockdev",
> +                         "driver=raw,file.driver=file,node-name=hd0,read-only=on,"
> +                         f"file.filename={image_path}")
> +        self.vm.add_args("--snapshot")

Any reason for using double dashes just here and not for the other commands?

> +        try:
> +            self.vm.launch()
> +        except VMLaunchFailure as e:
> +            if "old virglrenderer, blob resources unsupported" in e.output:
> +                self.skipTest("No blob support for virtio-gpu")
> +            elif "old virglrenderer, venus unsupported" in e.output:
> +                self.skipTest("No venus support for virtio-gpu")
> +            else:
> +                self.log.info(f"un-handled launch failure: {e.output}")

s/un-handled/unhandled/ ?

  Thomas


