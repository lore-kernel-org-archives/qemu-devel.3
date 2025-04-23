Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D75C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WXu-000144-Lp; Wed, 23 Apr 2025 05:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1u7WXq-00010P-Lu; Wed, 23 Apr 2025 05:37:30 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1u7WXn-0007sN-Gl; Wed, 23 Apr 2025 05:37:29 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5ed43460d6bso9317161a12.0; 
 Wed, 23 Apr 2025 02:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745401043; x=1746005843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4JHXDpgFWdXEshk7xxNDjGlaKn+42fcxiPViJzAV6RE=;
 b=KDzdhj3wRufWERPbYm9Q+BLKvH3MvyH8zMhzbYqkz4/XKA6LrMQjbFFah8eipxJHRV
 Ee7a0vbVafxEwd9CyFZ/VQK/eAFwVKxmrHsku/Cpm1louUXFUN2RYzmON1VtvvHgj20i
 b27HgtsEgvtfmhpwgvv8XuLhPVEteNmg7sBiTNCvj8tJkTpylm3ljdNgaNaterFXUKR/
 CmAYMkVRYQcIeZAvqR7QFyQH7BC2nzHUUFI57OItKqM+RX6+bMcrW70jU88QKHKsJZkf
 xwdMPgDdbRz2i5601ukE6U8VCLQBnY5kJFx3loeBdcgWvbOYM8/PsLR+PBAykIWC2AIV
 3D8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401043; x=1746005843;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4JHXDpgFWdXEshk7xxNDjGlaKn+42fcxiPViJzAV6RE=;
 b=tbI4zujd1Ojt3sol1JPIJw8ePN6t0kxoxrNMy9EadZhnErt5iPPNyJ+bMtX0WF8CSu
 KGIA3/1uaGnAflvXoiZb5USnacGdu8jhL/H1bxY6HK5UNut9TQLpPQk2ymJGbPyZESbO
 ZFvJpC9dlf/T3e3ZLtosuNjEeD+bgTxyOQzCg17h7fmyFO2pflxrOpYnBtxV43EHs+xn
 0tVdGiDa2n7CwKiSIwBg+VH6UaJeKGLOlWzFrZKsqFWzFUwsgRcUKALjjscxRyl+pRJf
 DJ/TB5y2KcQPx3RUKaeT1rMwqecFMCL8XdNl02T5P6nTuh/AEiGrtK/NL+ryiOaSRbJP
 nnNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSjTezs/Ste2EIsPTOw8UK7u69icN4PqKd3YdxyLI8j/nY0SJkrjOU/LOrdtZNdM3MCZ9GSISCzg==@nongnu.org,
 AJvYcCXxGCLo4tuSaFBddmBRNYKxLEL9jR8gbF4GWoAok9jbr3AFwPvPNOR3RPQ2A6Efu2jT8EpWEm138lN7kQ==@nongnu.org
X-Gm-Message-State: AOJu0YyvW5iZnf6gUoVbOMz3qubsOvNWYyk3ylqmKo5dHInEHp8zn5ai
 S3B4PQoTON7/vwz+mV4lriTreSENT5eSV4MigZwHKnl1SZJjzT/q
X-Gm-Gg: ASbGncteUOah0sEekI0FmeSb9zZQcNMgdEe4Vka0R33rhhczQkRoUfnloS6yTInilme
 N2zBaLBISNjlkgf6E8sAYYi1Y3xuqrQq43s5Rf43yiVBWwYzUECahxCJvwqKktbD9eLoiztBFLo
 rO1qNgQO475iH0NNZL/j/BNJJQ3L7nZZ/AfrvEp60IspgcRNuOmEigGnrOLNyPFiYtQPBHqcOxv
 uzbMCCPK3BqtnJ25XD/1r8V1sTEPhdxXWvmwzQUTG4vgjcOwKWRb2G9qxWHIQefr1MBpvxQ/2YK
 bgz9o4pn/ZX0n7K8ummDVr2Ciy1lGrqsmxY=
X-Google-Smtp-Source: AGHT+IH3Bn2l5goOsVg+mrZScZWhp2Sx2g2qBCsiVR4yMX9QEXA9j03SBhdUij9qyZomIzrIKK5JIA==
X-Received: by 2002:a05:6402:27cf:b0:5e6:616f:42e4 with SMTP id
 4fb4d7f45d1cf-5f6285dccbbmr17091258a12.27.1745401042247; 
 Wed, 23 Apr 2025 02:37:22 -0700 (PDT)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f6255955a6sm7332000a12.43.2025.04.23.02.37.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 02:37:21 -0700 (PDT)
Date: Wed, 23 Apr 2025 09:31:38 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
CC: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH-for-10=2E0=3F_v2=5D_tests/functional=3A_Add?=
 =?US-ASCII?Q?_test_for_imx8mp-evk_board_with_USDHC_coverage?=
In-Reply-To: <aa47d49a-b81a-46cf-811a-2045e453f4bf@redhat.com>
References: <20250409202630.19667-1-shentey@gmail.com>
 <aa47d49a-b81a-46cf-811a-2045e453f4bf@redhat.com>
Message-ID: <6621A6A6-83F8-476C-973C-FE3D1918E061@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



Am 10=2E April 2025 06:05:35 UTC schrieb Thomas Huth <thuth@redhat=2Ecom>:
>On 09/04/2025 22=2E26, Bernhard Beschow wrote:
>> Introduce a functional test which boots Debian 12 on the imx8mp-evk boa=
rd=2E Since
>> the root filesystem resides on an SD card, the test also verifies the b=
asic
>> operation of the USDHC=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>=20
>> --
>> v2:
>> * Make test file executable (Thomas)
>> * Omit fetch() (Thomas)
>> * Omit "-accel tcg" (Thomas)
>> * Add "snapshot=3Don" to make potential future tests independent
>>=20
>> Supersedes: 20250405214900=2E7114-1-shentey@gmail=2Ecom
>> ---
>>   MAINTAINERS                                 |  1 +
>>   tests/functional/meson=2Ebuild                |  1 +
>>   tests/functional/test_aarch64_imx8mp_evk=2Epy | 66 ++++++++++++++++++=
+++
>>   3 files changed, 68 insertions(+)
>>   create mode 100755 tests/functional/test_aarch64_imx8mp_evk=2Epy
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
>> new file mode 100755
>> index 0000000000=2E=2E62fee74044
>> --- /dev/null
>> +++ b/tests/functional/test_aarch64_imx8mp_evk=2Epy
>> @@ -0,0 +1,66 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Functional test that boots a Linux kernel and checks the console
>> +#
>> +# SPDX-License-Identifier: GPL-2=2E0-or-later
>> +
>> +from qemu_test import LinuxKernelTest, Asset
>> +
>
>In case you respin (due to other reasons), please add a second empty line=
 before the "class" statement (that's the style that we use in the other te=
sts, too)=2E
>
>Anyway:
>Reviewed-by: Thomas Huth <thuth@redhat=2Ecom>

Ping (not for 10=2E0)

>
>
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
>> +
>> +        self=2Eimage_path =3D self=2Escratch_file("disk=2Eraw")
>> +        self=2Ekernel_path =3D self=2Escratch_file("linux")
>> +        self=2Einitrd_path =3D self=2Escratch_file("initrd=2Ezstd")
>> +        self=2Edtb_path =3D self=2Escratch_file("imx8mp-evk=2Edtb")
>> +
>> +        self=2Earchive_extract(self=2EASSET_IMAGE)
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
>> +                         '-kernel', self=2Ekernel_path,
>> +                         '-initrd', self=2Einitrd_path,
>> +                         '-dtb', self=2Edtb_path,
>> +                         '-append', 'root=3D/dev/mmcblk2p1',
>> +                         '-drive', f'file=3D{self=2Eimage_path},if=3Ds=
d,bus=3D2,'
>> +                                    'format=3Draw,id=3Dmmcblk2,snapsho=
t=3Don')
>> +
>> +        self=2Evm=2Elaunch()
>> +        self=2Ewait_for_console_pattern('Welcome to ')
>> +
>> +if __name__ =3D=3D '__main__':
>> +    LinuxKernelTest=2Emain()
>

