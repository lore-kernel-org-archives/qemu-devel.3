Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28411C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 15:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTij8-0006jU-Iy; Mon, 23 Jun 2025 11:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uTij3-0006ic-Sw
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 11:04:50 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uTij2-0007wa-Ac
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 11:04:49 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a54690d369so3582430f8f.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 08:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750691086; x=1751295886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V8zMI2s6Y6MpClbneq9AHqx2k+dCWAsICo/Yr3AGJ9s=;
 b=pSNxvEetGL6lEfTagrzO41yybnHpwaqHL1zKaXYwiQ6FMmobzwhQkIANQTEiIGPvU7
 ot++u1QtRE2eB+IwsSjy3QH/CcLI+l5EElnoEEAV/g8+xMbWkcoNohpjnSUzBK5mo5Gs
 L5iHEe6scQpwas4g2+Iz4hhd8aNUPFgQgqWTIOtyKGJJFP20P2sPBLFvei4rsQwBP2s2
 PHsZz8dLz5FfaktQdkCrmogyQ3/TbFiPYW+jbbkPM2SsYHj0r0uQPX8ZTsQ0Qx8J9NdK
 cWLiUc+xLQBPgXm5fajWEFHr+M0Lm8hW5OqRvtqMBDsNWM9wFSmXzwZS8+J2CwF7SKA3
 AApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750691086; x=1751295886;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V8zMI2s6Y6MpClbneq9AHqx2k+dCWAsICo/Yr3AGJ9s=;
 b=iCszcfiEg1s6KH8zCnQx0t03FjSLDBcKzdMDZwVAWo/2pZOA+/lseX0wTSEBltCSXn
 JgOWqb7vUVbnCR07C3riK56n7kR2AhtDuX2e1WVJi0eMroSo06/kDPG3b9cZogN4He9n
 hUaVnjhAtG4SmwuB5Wx9bV6oTybnR4ee7NhPj7bMmgxNR5I4fqhPRsT+cCOrnu6NsyI/
 C4zm0sZxM29GMf1iJPPqQoa9Hp1u0vbN9iQLOvyGwNkojlkD9NOQZuzAuphCJhqb1hPq
 WKCeNoc5/N1jawiC5tNZTdp6KCjDmCRNPnKDYrxchoCvc/uOqKJPUkymZChnkECwlrIR
 Cdrw==
X-Gm-Message-State: AOJu0YyuQMqcp3HfxLIrImLN0Sc3v8h/tkwQywHmipiwSXXQoutNsBfc
 aMbK+YI7FzTRWjRmR9k9qAO47Lza3TXBPKviU4hRst59WZn6NOVDKushbs/KK1ZmGS8=
X-Gm-Gg: ASbGncth38ZJ9EZtz88P45G3veh+7XlFw6F8RNYcDPzQblUjeJKCMvVPR4ABD3GO4SU
 xN82PDS+HZIpF9J442ELL+RMsSUIAiYnH8GP4tbm6qkrrGdUaNozGiWXpTD6CdTJAUdKHDJiLtA
 8y/GoXNzsQ/mWmp8czAWTs1U9c7ksZ+jZwDeUHL27O7qtvyONV2gLtTMquGahhLVSFIdfCheRRX
 5/P02t46BLpjfwGrbvizWAw/NieRxgPZDAbt/13XoR8jHYITW0Q2RS37bVi17cYWEQChPZkCwbA
 mHHSIro1PU/9cLaOgINtwQMpSEHKnZ/hlfTtBjw+2sYdFZ8JU4og0nFaE/06uVg=
X-Google-Smtp-Source: AGHT+IF81vENs0EgcK259ls/C3BBEjJyA7ZVfvf/sID9WFrwkOQ+AYgC28uslSdud8D7fSIs4GtErw==
X-Received: by 2002:a05:6000:4906:b0:3a4:f661:c3e0 with SMTP id
 ffacd0b85a97d-3a6d12e6a3emr9777983f8f.45.1750691086171; 
 Mon, 23 Jun 2025 08:04:46 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1193792sm9790132f8f.97.2025.06.23.08.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 08:04:45 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0B6EA5F815;
 Mon, 23 Jun 2025 16:04:44 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 qemu-arm@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Roman
 Bolshakov <rbolshakov@ddn.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,  Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>,  Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Cameron Esfahani <dirty@apple.com>,  Cleber
 Rosa <crosa@redhat.com>,  Radoslaw Biernacki <rad@semihalf.com>,  Phil
 Dennis-Jordan <phil@philjordan.eu>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 26/26] tests/functional: Expand Aarch64 SMMU tests to
 run on HVF accelerator
In-Reply-To: <20250623121845.7214-27-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 23 Jun 2025 14:18:45
 +0200")
References: <20250623121845.7214-1-philmd@linaro.org>
 <20250623121845.7214-27-philmd@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Mon, 23 Jun 2025 16:04:43 +0100
Message-ID: <87sejq1otw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  tests/functional/test_aarch64_smmu.py | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/tests/functional/test_aarch64_smmu.py b/tests/functional/tes=
t_aarch64_smmu.py
> index c65d0f28178..e0f4a922176 100755
> --- a/tests/functional/test_aarch64_smmu.py
> +++ b/tests/functional/test_aarch64_smmu.py
> @@ -17,7 +17,7 @@
>=20=20
>  from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_=
pattern
>  from qemu_test import BUILD_DIR
> -from qemu.utils import kvm_available
> +from qemu.utils import kvm_available, hvf_available
>=20=20
>=20=20
>  class SMMU(LinuxKernelTest):
> @@ -45,11 +45,17 @@ def set_up_boot(self, path):
>          self.vm.add_args('-device', 'virtio-net,netdev=3Dn1' + self.IOMM=
U_ADDON)
>=20=20
>      def common_vm_setup(self, kernel, initrd, disk):
> -        self.require_accelerator("kvm")
> +        if hvf_available(self.qemu_bin):
> +            accel =3D "hvf"
> +        elif kvm_available(self.qemu_bin):
> +            accel =3D "kvm"
> +        else:
> +            self.skipTest("Neither HVF nor KVM accelerator is available")
> +        self.require_accelerator(accel)

I think this is fine so:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

However I wonder if something like:

        hwaccel =3D self.require_hw_accelerator()=20

Could fetch the appropriate platform accelerator for use in -accel bellow?

>          self.require_netdev('user')
>          self.set_machine("virt")
>          self.vm.add_args('-m', '1G')
> -        self.vm.add_args("-accel", "kvm")
> +        self.vm.add_args("-accel", accel)
>          self.vm.add_args("-cpu", "host")
>          self.vm.add_args("-machine", "iommu=3Dsmmuv3")
>          self.vm.add_args("-d", "guest_errors")

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

