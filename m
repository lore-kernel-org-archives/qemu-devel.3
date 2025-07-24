Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A778EC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 13:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uew9w-0003L9-FS; Thu, 24 Jul 2025 09:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uew9h-00038a-Ml
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 09:38:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uew9d-0005U8-To
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 09:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753364315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sHSAUsscdEI9Bf2qgw2M/mq2BhACO5rZ0PRMVvf3yYY=;
 b=ZWI7C9fWXzVzUyZglA3PUNYbZWlUJpmoHehc06Z9AaCtn2nETfvovCavAaYUb2NFPEPPG/
 8mmJikpX9BoYLjLrClktTJqtImJaOQ1bz1/F21xqg2K2gnoHxn3MmyAEu2icXFBUKtCazr
 vwK4tBM3ctxJcD5vhr5sTCtAS4YPuG4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-CKun7UbKO8eFIy9Husc1ZA-1; Thu, 24 Jul 2025 09:38:33 -0400
X-MC-Unique: CKun7UbKO8eFIy9Husc1ZA-1
X-Mimecast-MFC-AGG-ID: CKun7UbKO8eFIy9Husc1ZA_1753364310
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a52bfda108so537743f8f.3
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 06:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753364310; x=1753969110;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sHSAUsscdEI9Bf2qgw2M/mq2BhACO5rZ0PRMVvf3yYY=;
 b=Ow6WHKohPSoP+/SP6c+jSRHC5BWaS0JH0AO0L51wS0JSEUH28isUSRcfwHDxMR92Tg
 irHmQ3r84b79tpEhiM2DqgIW1s0/QYyQ5lhyqrLDojCU4g4IGkUzpGYTRDxAxx1e1JsR
 PwwN+Lg4P4jAZmmZ8848gEeKi/epnagulGqyqPRMOkC1tSx3PEQMxtD8a5r3OMG+MLFq
 VVMAbCq1ky6GqSvgtmMIpHEtMN40mW4QwydcFYsxBady/f5XKxMF6s1PJljdmwV/BKFT
 7rtPBolVGOjTwGI7ssJxv8O7vcsIblVjtXouaGQgMdrTbuaXlhyfRasMMHcdU26E0qLK
 5SqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB/0bWt1oSwirgEz8PVqIQ5jIhA5zMQh7EaIPZNOhnkU2YTRX6TS5leJKShe3ttzD58JyCaBu8XTLu@nongnu.org
X-Gm-Message-State: AOJu0YymIGBEFL5XmO/YjRtI/FLemC1gU6aKpKNDsht24jCkYJXFuP5U
 rcs+fQsix7hfW8lEKn04Z20EmjVQfvCBMGnFdmc9Fx5kgHJwV1i87GuqsUOAKzMLTnuXWEj4Ok3
 9FOy5JMkhGWnWoCTNeuJM+d7O5EB3UQCQ0AdWId2mQJur+VySo44MSOAn
X-Gm-Gg: ASbGncu29pc8bPjIkpfnk5PjOpBfykG/PDiVQ5ePmzQsR4pcSR661dCM0Ka/omWxtFU
 rQq9+dzOrg+SBImVqi7/RHIurNw8h8mVfI6wvyAsFpxbX1u8Bth3mE0wuwBE7KeIx34kl7lVVyR
 NL0kvr17q4O0RX/KS+mqKh/on5dudsTndVD1BU74Rg+nincgxheutnHfYVXrE51MN5TfA8ty6sN
 0vK58v7aeaoealqA/RPl5kYjdxK0Un7deRi54dtJ7GtnIhudWzyQQqVfzm58ywLG1Mt+Rvo1Rk5
 Z4DzSTZTZlVJU8qT7bOr8dz2riTuQt2cQqS74jU3DCorhTEswdKTxKfAWoLLBICI3O5Sj8DzfGA
 icJU=
X-Received: by 2002:a05:6000:2512:b0:3b3:9c75:acc6 with SMTP id
 ffacd0b85a97d-3b768f165ecmr5485416f8f.59.1753364310258; 
 Thu, 24 Jul 2025 06:38:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq81+yPhdZhXVUhP6Elst6Vrm0E16Et5KdBP30mF+bfLj1ZOr1RY6Si4MhoJgQqgPVFVnlqg==
X-Received: by 2002:a05:6000:2512:b0:3b3:9c75:acc6 with SMTP id
 ffacd0b85a97d-3b768f165ecmr5485380f8f.59.1753364309657; 
 Thu, 24 Jul 2025 06:38:29 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-115-089.pools.arcor-ip.net.
 [47.64.115.89]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705c4dbdsm21801175e9.25.2025.07.24.06.38.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 06:38:29 -0700 (PDT)
Message-ID: <84c35808-1d3b-45d3-9370-d599cfd11c51@redhat.com>
Date: Thu, 24 Jul 2025 15:38:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 10.1 06/13] tests/functional: add hypervisor test for
 aarch64
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Mark Burton <mburton@qti.qualcomm.com>
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
 <20250724105939.2393230-7-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250724105939.2393230-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 24/07/2025 12.59, Alex Bennée wrote:
> This is a simple test case that runs an image with kvmtool and
> kvm-unit-tests which can validate virtualisation works. This is useful
> for exercising TCG but can also be applied to any nested virt setup
> which is why it doesn't specify an accelerator.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Mark Burton <mburton@qti.qualcomm.com>
> ---
>   tests/functional/meson.build         |  1 +
>   tests/functional/test_aarch64_kvm.py | 83 ++++++++++++++++++++++++++++
>   2 files changed, 84 insertions(+)
>   create mode 100755 tests/functional/test_aarch64_kvm.py
> 
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 8bebcd4d94e..ecf965adc6c 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -89,6 +89,7 @@ tests_aarch64_system_thorough = [
>     'aarch64_device_passthrough',
>     'aarch64_hotplug_pci',
>     'aarch64_imx8mp_evk',
> +  'aarch64_kvm',
>     'aarch64_raspi3',
>     'aarch64_raspi4',
>     'aarch64_replay',
> diff --git a/tests/functional/test_aarch64_kvm.py b/tests/functional/test_aarch64_kvm.py
> new file mode 100755
> index 00000000000..a42d82872af
> --- /dev/null
> +++ b/tests/functional/test_aarch64_kvm.py
> @@ -0,0 +1,83 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that runs subsets of kvm-unit-tests on Aarch64.
> +# These can run on TCG and any accelerator supporting nested
> +# virtualisation.
> +#
> +# Copyright (c) 2025 Linaro
> +#
> +# Author:
> +#  Alex Bennée <alex.bennee@linaro.org>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu.machine.machine import VMLaunchFailure
> +
> +from qemu_test import Asset
> +from qemu_test import exec_command_and_wait_for_pattern as ec_and_wait
> +from qemu_test.linuxkernel import LinuxKernelTest
> +
> +
> +class Aarch64VirtKVMTests(LinuxKernelTest):
> +
> +    ASSET_KVM_TEST_KERNEL = Asset(
> +        'https://fileserver.linaro.org/s/HmjaxXXYHYSqbes/'
> +        'download?path=%2F&files='
> +        'image-with-kvm-tool-and-unit-tests.gz',
> +        '34de4aaea90db5da42729e7d28b77f392c37a2f4da859f889a5234aaf0970696')
> +
> +    # make it easier to detect successful return to shell
> +    PS1 = 'RES=[$?] # '
> +    OK_CMD = 'RES=[0] # '
> +
> +    # base of tests
> +    KUT_BASE = "/usr/share/kvm-unit-tests/"
> +
> +    def _launch_guest(self, kvm_mode="nvhe"):
> +
> +        self.set_machine('virt')
> +        kernel_path = self.ASSET_KVM_TEST_KERNEL.fetch()
> +
> +        self.vm.set_console()
> +        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
> +                               f"console=ttyAMA0 kvm-arm.mode={kvm_mode}")
> +
> +        self.vm.add_args("-cpu", "cortex-a72")
> +        self.vm.add_args("-machine", "virt,gic-version=3,virtualization=on",
> +                         '-kernel', kernel_path,
> +                         '-append', kernel_command_line)
> +        self.vm.add_args("-smp", "2", "-m", "320")
> +
> +        try:
> +            self.vm.launch()
> +        except VMLaunchFailure as excp:
> +            self.log.info("unhandled launch failure: %s", excp.output)
> +            raise excp

Unless you want to intercept certain launch failures, I think it's easier to 
simply omit the "try:" and "except" here and call self.vm.launch() directly.
(you can also drop the "from qemu.machine.machine import VMLaunchFailure" in 
that case).

> +        self.wait_for_console_pattern('buildroot login:')
> +        ec_and_wait(self, 'root', '#')
> +        ec_and_wait(self, f"export PS1='{self.PS1}'", self.OK_CMD)
> +
> +

Cosmetical nit: We're normally only using one empty line between functions.

Apart from that, the test looks fine to me.

  Thomas

> +    def test_aarch64_nvhe_selftest(self):
> +
> +        self._launch_guest("nvhe")
> +
> +        ec_and_wait(self, f"{self.KUT_BASE}/selftest-setup", self.OK_CMD)
> +        ec_and_wait(self, f"{self.KUT_BASE}/selftest-smp", self.OK_CMD)
> +        ec_and_wait(self, f"{self.KUT_BASE}/selftest-vectors-kernel", self.OK_CMD)
> +        ec_and_wait(self, f"{self.KUT_BASE}/selftest-vectors-user", self.OK_CMD)
> +
> +
> +    def test_aarch64_vhe_selftest(self):
> +
> +        self._launch_guest("vhe")
> +
> +        ec_and_wait(self, f"{self.KUT_BASE}/selftest-setup", self.OK_CMD)
> +        ec_and_wait(self, f"{self.KUT_BASE}/selftest-smp", self.OK_CMD)
> +        ec_and_wait(self, f"{self.KUT_BASE}/selftest-vectors-kernel", self.OK_CMD)
> +        ec_and_wait(self, f"{self.KUT_BASE}/selftest-vectors-user", self.OK_CMD)
> +
> +
> +if __name__ == '__main__':
> +    LinuxKernelTest.main()


