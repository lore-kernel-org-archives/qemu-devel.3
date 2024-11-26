Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24934D59D94
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 10:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFtAu-0007oB-FG; Tue, 26 Nov 2024 05:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFtAr-0007nu-Sf
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 05:52:05 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFtAq-00046E-1g
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 05:52:05 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9ec267b879so805952666b.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 02:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732618321; x=1733223121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oSIug05EmKaT63EMr8wLMwChrL0lwRyeJwiVGr6eugM=;
 b=p5T7Cfz0OyUivBL+E5RzSRvNA+uzNPFRVs2igrppTVyqPf3whrHeZPybQp530O3H0T
 lfRSdsEXCAgyqreMbJiYuEwBaRnB/0BPkf2602emjpDq/1FVZ8SRLYtAcKFUfkuQKkeN
 4DIRDGK/urkSTsI0/4xCmu4FbctRt4H4qREFg1nrqYsVLKVgcg3luUjy9JSIZUEza7tE
 sP7uqEcZUaT6tKYrVl+52sVt6yLVRRnf/GBoeShgkhgUG67fMmvMsoYaHi2UDPbjq+a7
 0lcR7Eiv7gk25ls3gG98xeu4H6JqjLz0oGiiJCg4AyeocZ+UDRq0yY6C3CWXBrpkaSSA
 sSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732618321; x=1733223121;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oSIug05EmKaT63EMr8wLMwChrL0lwRyeJwiVGr6eugM=;
 b=C7NPkvrEDzRUd3urj5Yj9FR1A1pPDUopSni/I7SZFbh6+eDK9y4wfJ/aqFVGONbLWV
 LSXK/z9Jsqb9kQmlvTTZv58dcxXHo3MtOghkZC/oPQmU4ZmAkZMHAXDfoJDKGg6bDEIq
 TOPx3h7om+yukUOJnTy1OVe2Fe5dYlpX0MK4zxIPmrkCpbAD6/UZsDgZ85RiXoMoVO0C
 szqFhBzPlikY0CxKoXsJLStfYcswQS1PLlRlRreQxLKuCk+UZsQqwnO/k7RfmHFLM3fx
 fp8xrFGYTGUZUnFU7oLc6ENZM8RjIfpfwrKL7sA1CEVy4aNZ9Po+1nh2QyrBITOHONRn
 3ohQ==
X-Gm-Message-State: AOJu0YxpGwXXLjnHOFcbh94FAP5QE3LMjcpTN240nUcMnMWLASHUpnTs
 nvW2u4Bc58bQvLgWkOe2aBHJ85uf21Pf6fMrWcvSRd7xwc4dihJuMRwXxdwwlC0=
X-Gm-Gg: ASbGncs/1yER2dUxi3Irxhv5DMrDsaPaiNevq153rWD5WZwnfaJxukx9DkkXA5SWZH4
 ceTVnmninvfTx6sDC6lkBl5nXbEt/QBW4mWwWdsQo2U6fDhF5+5/GpSMS43yEJdNpftTEgcJh3+
 fgKjZmC+yBOzI9oQqU8D4TZ+at1J7tGaSNKVCWOTiTj7C+hjFrrOj14i1H8zkvC+SQk53SVV53X
 ASgsQuTDjyV3xcSiq+MBy16wkua+P8tF7AqAcAVbl83hc5C
X-Google-Smtp-Source: AGHT+IF/6FnsrqEZAR20/EoBlxEmtHh+BbVVTxgSEXLW1jqVyPqfn43izVuUUuVco5BcjzERqbrf1A==
X-Received: by 2002:a17:906:d511:b0:a9a:1437:3175 with SMTP id
 a640c23a62f3a-aa509d6c7cfmr1165633266b.51.1732618320696; 
 Tue, 26 Nov 2024 02:52:00 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b2efbf1sm579773166b.44.2024.11.26.02.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 02:52:00 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4E0805F713;
 Tue, 26 Nov 2024 10:51:59 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  mathieu.poirier@linaro.org,
 gustavo.romero@linaro.org,  jean-philippe@linaro.org,
 qemu-arm@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] tests/functional/aarch64_virt: add test for FEAT_RME
In-Reply-To: <01d49b94-c341-4311-88fe-f7962c117336@linaro.org> (Pierrick
 Bouvier's message of "Mon, 25 Nov 2024 14:43:03 -0800")
References: <20241125065950.1179068-1-pierrick.bouvier@linaro.org>
 <8734jfchxe.fsf@draig.linaro.org>
 <01d49b94-c341-4311-88fe-f7962c117336@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 26 Nov 2024 10:51:59 +0000
Message-ID: <87r06yb73k.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 11/25/24 10:00, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>=20
>>> This boot an OP-TEE environment, and launch a nested guest VM inside it
>>> using the Realms feature.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>   tests/functional/test_aarch64_virt.py | 62 +++++++++++++++++++++++++++
>>>   1 file changed, 62 insertions(+)
>>>
>>> diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/t=
est_aarch64_virt.py
>>> index 30bab5a677c..3e8f9372132 100755
>>> --- a/tests/functional/test_aarch64_virt.py
>>> +++ b/tests/functional/test_aarch64_virt.py
>>> @@ -18,6 +18,7 @@
>>>   from qemu_test import QemuSystemTest, Asset
>>>   from qemu_test import exec_command, wait_for_console_pattern
>>>   from qemu_test import get_qemu_img, run_cmd
>>> +from qemu_test.utils import archive_extract
>>>       class Aarch64VirtMachine(QemuSystemTest):
>>> @@ -129,6 +130,67 @@ def test_aarch64_virt_gicv2(self):
>>>           return
>>>           self.common_aarch64_virt("virt,gic-version=3D2")
>>>   +    # Stack is built with OP-TEE build environment from those
>>> instructions:
>>> +    # https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/
>>> +    # https://github.com/pbo-linaro/qemu-rme-stack
>>> +    ASSET_RME_STACK =3D Asset(
>>> +        ('https://fileserver.linaro.org/s/JX7oNgfDeGXSxcY/'
>>> +         'download/rme-stack-op-tee-4.2.0.tar.gz'),
>>> +         '1f240f55e8a7a66489c2b7db5d40391e5dcfdd54c82600bd0d4b2145b9a0=
fbfb')
>>> +
>>> +    # This tests the FEAT_RME cpu implementation, by booting a VM supp=
orting it,
>>> +    # and launching a nested VM using it.
>>> +    def test_aarch64_virt_rme(self):
>>> +        stack_path_tar_gz =3D self.ASSET_RME_STACK.fetch()
>>> +        archive_extract(stack_path_tar_gz, self.workdir)
>>> +
>>> +        self.set_machine('virt')
>>> +        self.vm.set_console()
>>> +        self.require_accelerator('tcg')
>>> +
>>> +        rme_stack =3D os.path.join(self.workdir, 'rme-stack')
>>> +        kernel =3D os.path.join(rme_stack, 'out', 'bin', 'Image')
>>> +        bios =3D os.path.join(rme_stack, 'out', 'bin', 'flash.bin')
>>> +        drive =3D os.path.join(rme_stack, 'out-br', 'images', 'rootfs.=
ext4')
>>> +
>>> +        self.vm.add_args('-accel', 'tcg')
>>> +        self.vm.add_args('-cpu', 'max,x-rme=3Don')
>>> +        self.vm.add_args('-m', '2048')
>>> +        self.vm.add_args('-M', 'virt,acpi=3Doff,'
>>> +                         'virtualization=3Don,'
>>> +                         'secure=3Don,'
>>> +                         'gic-version=3D3')
>>> +        self.vm.add_args('-bios', bios)
>>> +        self.vm.add_args('-kernel', kernel)
>>> +        self.vm.add_args('-drive', f'format=3Draw,if=3Dnone,file=3D{dr=
ive},id=3Dhd0')
>>> +        self.vm.add_args('-device', 'virtio-blk-pci,drive=3Dhd0')
>>> +        self.vm.add_args('-device', 'virtio-9p-device,fsdev=3Dshr0,mou=
nt_tag=3Dshr0')
>>> +        self.vm.add_args('-fsdev', f'local,security_model=3Dnone,path=
=3D{rme_stack},id=3Dshr0')
>>> +        self.vm.add_args('-device', 'virtio-net-pci,netdev=3Dnet0')
>>> +        self.vm.add_args('-netdev', 'user,id=3Dnet0')
>>> +        self.vm.add_args('-append', 'root=3D/dev/vda')
>>> +
>>> +        self.vm.launch()
>>> +        self.wait_for_console_pattern('Welcome to Buildroot')
>>> +        time.sleep(0.1)
>>> +        exec_command(self, 'root')
>>> +        time.sleep(0.1)
>>> +
>>> +        # We now boot the (nested) guest VM
>>> +        exec_command(self,
>>> +                     'qemu-system-aarch64 -M virt,gic-version=3D3 '
>>> +                     '-cpu host -enable-kvm -m 512M '
>>> +                     '-M confidential-guest-support=3Drme0 '
>>> +                     '-object rme-guest,id=3Drme0,measurement-algo=3Ds=
ha512 '
>>> +                     '-device virtio-net-pci,netdev=3Dnet0,romfile=3D '
>>> +                     '-netdev user,id=3Dnet0 '
>>> +                     '-kernel /mnt/out/bin/Image '
>>> +                     '-initrd /mnt/out-br/images/rootfs.cpio '
>>> +                     '-serial stdio')
>>> +        # Detect Realm activation during boot.
>>> +        self.wait_for_console_pattern('SMC_RMI_REALM_ACTIVATE')
>>> +        # Wait for boot to complete.
>>> +        self.wait_for_console_pattern('Welcome to Buildroot')
>> This is the same as above? Or the console of the guest?
>>=20
>
> It's the guest yes, as the comment try to explain.
> I chose to implement it this way, instead of going with a separate
> socket, because it would make the test code much more complicated with
> no real benefit.

Can you interact with that console? I'm wondering if we can stimulate
the realm to do something a bit more than to get to the login prompt.

I agree sinking multiple serial ports would make the test more complex
and we shouldn't do it if we can prove everything works via the guests
interaction.

>> Could we also check the output of the other serial posts?
>>=20
>
> Host does not print anything.
> We already check guest.
> Message 'SMC_RMI_REALM_ACTIVATE' comes from the firmware.
> Secure terminal is completely silent.
>
> Were you thinking to something else?
>
> Feel free to try [1], you can build and launch the vm in two commands
> without having to install anything on your machine.
>
> [1] https://github.com/pbo-linaro/qemu-rme-stack

Nice ;-)

>
>>>     if __name__ =3D=3D '__main__':
>>>       QemuSystemTest.main()
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

