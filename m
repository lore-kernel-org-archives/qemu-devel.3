Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1575C369A1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 10:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u26I6-0001eB-6P; Tue, 08 Apr 2025 06:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1u26I4-0001dt-Cb; Tue, 08 Apr 2025 06:34:48 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1u26I1-0007WZ-F4; Tue, 08 Apr 2025 06:34:47 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-abec8b750ebso907508166b.0; 
 Tue, 08 Apr 2025 03:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744108483; x=1744713283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QTbwRhe3DqMRjQbHAqyruavgTwGQghTB5+1ocfpnPJg=;
 b=iVI1P7hfRTM8OiZdeOmDFqTEDYmftwkWqjMruf8eHV9DQXuWCgXJXFnax5B9cW3BPt
 l5Ss4d+DCuoE3Ney1FgPRtXYWeTnxcWgu3rBvPF5p8K2enNdW8asXqPNCQ7Ni1Em6zB/
 tLvqreI3qkAXkc4shUgu14gPzJ5WYB0k8J6q7Vx+mhkgh5ba77B/VhUlUXsNjOijKw36
 J7E62qj4NLTb3ppv+3dZwybhDkzRAo0oV9Doj0JEhdk3/W+Mr2Kb/uJG4DEyVSZ84j6n
 YBYI0LZd/JfRPFMwnDqEgw2fZWrvPi8MDuNo70ERila0mj+NgycblC0EgGERfOV5Fxlu
 uUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744108483; x=1744713283;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QTbwRhe3DqMRjQbHAqyruavgTwGQghTB5+1ocfpnPJg=;
 b=haXy6X972IetSyxzWgPyitLoFS2Sw0o4ZxsNubesaAy2iAmj+D0Bj0fX7lU6Q35fkN
 av3kYZLv+eJofAqsYbixTsUBLFLn6sOwIobFSOxqskxas1io+YkW1pSGgY2ybrFMdvGL
 HYU/ZcOAyMxxhc4wlJ0i317mxPU1QLOuyXrrA45B7g3iCQ3pabZasSxtWFuRbN8Ls/bz
 cfXQbJ9zssv1YwOvXLyLTbLQrlLIYV1yGxdZ0GeRftBqNfwOIeD6vUNskdVcaYqlWf9t
 uSa9CoU3yJiFcRdbCdF12D3IpXHn3TgPcbd1DpASdg5BYq+ePQHBrkpIaoqJ874CNyUw
 4iqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9WieOcH+cjBxEC+OZ7weafJV6F3aK6NBSe7j42JP7KVZObltdnCVUKgdLpB41juotrS7Rd5mUWg==@nongnu.org,
 AJvYcCXGEPNi0Mt6EvwjAfYHqqyEG0fxEx4XXG4RTI80r+WQjPehl+sl2S0kY16lxmU5ftcxIyx7LHq+gl/wTA==@nongnu.org
X-Gm-Message-State: AOJu0YztVuSGg6lEMmJvj174ra/ByeKbKIsTbOt7YQVfQ6fafQOVWjam
 pBdn1bdsaRCBGk/KIwaOJWk3f2u6Gy+wf1yXzdo+KVOuz5HIRl1v/uGY2w==
X-Gm-Gg: ASbGncvROWsD3O5WcAcOfqSDQIcFv8MLIDKND036shgM0r1lCf0WkG3+8DHbUoZMiAL
 ZNLxEEuIoR2VzLYwLwyg8F4IemEgQw3QtoiVQBm9vr42PNAzQMVA0I9aEPzsScqQsqAbZZnpv3C
 nJcSkh95BJPmxRd1zfldFUVmZuNAFDSaOKDwd33ocvfhvV5/Uu0T2N/o5eUELoO+d/DHrdwiyT8
 1TVRC1vkk3tckgL2/w7PjguGrIbnG3fxDjWuzWZ/3nuCNoxXQhq97GXbp7Uu0qWsQ01KZIo23zU
 u0cN0a2GlJPbXo6+CyLVQGPWhySH3vOGR2ouuxx5
X-Google-Smtp-Source: AGHT+IGQQfkVD2U+/XLN08OwdWSpGeKYqaNrwJ3iMilmAV1Tzgme/QPjeAFL949EiNudFGGMHSTzIw==
X-Received: by 2002:a17:906:c144:b0:ac3:2d47:f6af with SMTP id
 a640c23a62f3a-ac7e71b44femr999117966b.20.1744108482633; 
 Tue, 08 Apr 2025 03:34:42 -0700 (PDT)
Received: from [127.0.0.1] ([90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfeed008sm886206666b.85.2025.04.08.03.34.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 03:34:42 -0700 (PDT)
Date: Tue, 08 Apr 2025 10:15:32 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
CC: =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org, 
 Guenter Roeck <linux@roeck-us.net>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH-for-10=2E0_1/3=5D_tests/functional=3A_Add?=
 =?US-ASCII?Q?_test_for_imx8mp-evk_board_with_USDHC_coverage?=
In-Reply-To: <122aaf9e-cb4c-4117-90ae-2803f4810700@redhat.com>
References: <20250405214900.7114-1-shentey@gmail.com>
 <20250405214900.7114-2-shentey@gmail.com>
 <122aaf9e-cb4c-4117-90ae-2803f4810700@redhat.com>
Message-ID: <79FE9C71-1792-44F0-A4D0-364636B21F09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 7=2E April 2025 05:38:28 UTC schrieb Thomas Huth <thuth@redhat=2Ecom>:
> Hi!
>
>On 05/04/2025 23=2E48, Bernhard Beschow wrote:
>> Introduce a functional test which boots Debian 12 on the imx8mp-evk boa=
rd=2E Since
>> the root filesystem resides on an SD card, the test also verifies the b=
asic
>> operation of the USDHC=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>   MAINTAINERS                                 |  1 +
>>   tests/functional/meson=2Ebuild                |  1 +
>>   tests/functional/test_aarch64_imx8mp_evk=2Epy | 69 ++++++++++++++++++=
+++
>>   3 files changed, 71 insertions(+)
>>   create mode 100644 tests/functional/test_aarch64_imx8mp_evk=2Epy
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d54b5578f8=2E=2E4ceffa89dc 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -833,6 +833,7 @@ F: include/hw/arm/fsl-imx8mp=2Eh
>>   F: include/hw/misc/imx8mp_*=2Eh
>>   F: include/hw/pci-host/fsl_imx8m_phy=2Eh
>>   F: docs/system/arm/imx8mp-evk=2Erst
>> +F: tests/functional/test_aarch64_imx8mp_evk=2Epy
>>   F: tests/qtest/rs5c372-test=2Ec
>>     MPS2 / MPS3
>> diff --git a/tests/functional/meson=2Ebuild b/tests/functional/meson=2E=
build
>> index 0f8be30fe2=2E=2Eaaaf3472f1 100644
>> --- a/tests/functional/meson=2Ebuild
>> +++ b/tests/functional/meson=2Ebuild
>> @@ -75,6 +75,7 @@ tests_aarch64_system_quick =3D [
>>     tests_aarch64_system_thorough =3D [
>>     'aarch64_aspeed',
>> +  'aarch64_imx8mp_evk',
>>     'aarch64_raspi3',
>>     'aarch64_raspi4',
>>     'aarch64_replay',
>> diff --git a/tests/functional/test_aarch64_imx8mp_evk=2Epy b/tests/func=
tional/test_aarch64_imx8mp_evk=2Epy
>> new file mode 100644
>
>The test files should be executable so you can run them directly (after s=
etting PYTHONPATH and QEMU_TEST_QEMU_BINARY)

Ack=2E Will fix=2E

>
>> index 0000000000=2E=2E5419d3c525
>> --- /dev/null
>> +++ b/tests/functional/test_aarch64_imx8mp_evk=2Epy
>> @@ -0,0 +1,69 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Functional test that boots a Linux kernel and checks the console
>> +#
>> +# SPDX-License-Identifier: GPL-2=2E0-or-later
>> +
>> +from qemu_test import LinuxKernelTest, Asset
>> +
>> +class Imx8mpEvkMachine(LinuxKernelTest):
>> +
>> +    ASSET_IMAGE =3D Asset(
>> +        ('https://cloud=2Edebian=2Eorg/images/cloud/bookworm/20231210-=
1590/'
>> +         'debian-12-generic-arm64-20231210-1590=2Etar=2Exz'),
>> +        '7ebf1577b32d5af6204df74b54ca2e4675de9b5a9fa14f3ff70b88eeb7b3b=
359')
>> +
>> +    KERNEL_OFFSET =3D 0x51000000
>> +    KERNEL_SIZE =3D 32622528
>> +    INITRD_OFFSET =3D 0x76000000
>> +    INITRD_SIZE =3D 30987766
>> +    DTB_OFFSET =3D 0x64F51000
>> +    DTB_SIZE =3D 45 * 1024
>> +
>> +    def extract(self, in_path, out_path, offset, size):
>> +        try:
>> +            with open(in_path, "rb") as source:
>> +                source=2Eseek(offset)
>> +                data =3D source=2Eread(size)
>> +            with open(out_path, "wb") as target:
>> +                target=2Ewrite(data)
>> +        except (IOError, ValueError) as e:
>> +            self=2Elog=2Eerror(f"Failed to extract {out_path}: {e}")
>> +            raise
>> +
>> +    def setUp(self):
>> +        super()=2EsetUp()
>
>Is there any special reason for overriding the setUp function here? =2E=
=2E=2E otherwise, I think this could also simply be done from the test_aarc=
h64_imx8mp_evk_usdhc function instead?

The idea is that it prepares the test data once which could be used by mul=
tiple test cases in the future=2E One could add tests booting via USB and P=
CIe=2E Not done yet due to concerns about CI resources=2E

>
>> +        self=2EASSET_IMAGE=2Efetch()
>
>I think you can omit the fetch() here, it should be handled by archive_ex=
tract() already=2E At least that's what we're doing in the other spots that=
 use archive_extract()=2E

Sounds excellent, I'll try that=2E

>
>> +        self=2Earchive_extract(self=2EASSET_IMAGE)
>> +
>> +        self=2Eimage_path =3D self=2Escratch_file("disk=2Eraw")
>> +        self=2Ekernel_path =3D self=2Escratch_file("linux")
>> +        self=2Einitrd_path =3D self=2Escratch_file("initrd=2Ezstd")
>> +        self=2Edtb_path =3D self=2Escratch_file("imx8mp-evk=2Edtb")
>> +
>> +        self=2Eextract(self=2Eimage_path, self=2Ekernel_path,
>> +                     self=2EKERNEL_OFFSET, self=2EKERNEL_SIZE)
>> +        self=2Eextract(self=2Eimage_path, self=2Einitrd_path,
>> +                     self=2EINITRD_OFFSET, self=2EINITRD_SIZE)
>> +        self=2Eextract(self=2Eimage_path, self=2Edtb_path,
>> +                     self=2EDTB_OFFSET, self=2EDTB_SIZE)
>> +
>> +    def test_aarch64_imx8mp_evk_usdhc(self):
>> +        self=2Eset_machine('imx8mp-evk')
>> +        self=2Evm=2Eset_console(console_index=3D1)
>> +        self=2Evm=2Eadd_args('-m', '2G',
>> +                         '-smp', '4',
>> +                         '-accel', 'tcg',
>
>The imx8mp-evk board has a "depends on TCG" in its Kconfig file, so I thi=
nk you could omit "-accel tcg" here (but it also does not hurt to be explic=
it, I guess)=2E

I've seen it elsewhere, and I plan to add KVM support=2E That's why I adde=
d it=2E If it can be omitted I'm happy to remove it=2E

Best regards,
Bernhard

>
> Thomas
>
>
>> +                         '-kernel', self=2Ekernel_path,
>> +                         '-initrd', self=2Einitrd_path,
>> +                         '-dtb', self=2Edtb_path,
>> +                         '-append', 'root=3D/dev/mmcblk2p1',
>> +                         '-drive', f'file=3D{self=2Eimage_path},if=3Ds=
d,bus=3D2,'
>> +                                    'format=3Draw,id=3Dmmcblk2')
>> +
>> +        self=2Evm=2Elaunch()
>> +        self=2Ewait_for_console_pattern('Welcome to ')
>> +
>> +if __name__ =3D=3D '__main__':
>> +    LinuxKernelTest=2Emain()
>

