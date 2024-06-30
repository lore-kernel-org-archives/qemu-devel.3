Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD444C3064D
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 14:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNvgf-0000w2-WE; Sun, 30 Jun 2024 10:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1sNvga-0000vO-4a; Sun, 30 Jun 2024 10:37:48 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1sNvgX-0003Nk-Ab; Sun, 30 Jun 2024 10:37:47 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id BF74DCE097C;
 Sun, 30 Jun 2024 14:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09BDC32786;
 Sun, 30 Jun 2024 14:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1719758251;
 bh=RUlD5V3GMh260Zrkcqd8C6QU9LyipyBCh0FBuRULMeM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=XkH8vdzheYXAwQD28fEPGy4zHhIRWjhxj2FVwTDNKojmRmbfSgbCXw0MTnQO4LKbT
 wpfooHCjA73qdVJU13FWzddhBHYbLDbvamqJfqIK3/Ff9Y7Sn3c2UNA8oeMv1wp06I
 82oU3GkJBmddeRKEt6i6PZxA3yYv0zvKx8Xzyo8MCfo+faMPqXBIVeWqal8iG9Kjxz
 qB11guanRnvvijaXZltu7DAiEtEhEKuDcdn488+oNsMMZoTe6igCZGo8wowi7bYyLp
 1k5ZOt/7d6RdR7B9iwjY0Y5MKsK7h3azfzi19/0U3Vz2XBlnfVAxJ//iY/p6UFDzzd
 uOh4RjH/WJDdw==
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-2ee4ab4076bso27843281fa.0; 
 Sun, 30 Jun 2024 07:37:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVL++31JYEFcGxouQOXY9bVwjE3L0YGc8RpS1MpMoVKpliU71xVWpz/JAPCcbRRlaTQZhNqewc9AI9gacgBtHAelgZr
X-Gm-Message-State: AOJu0YwSTyitk7Ex9GgjsBg2S2W2kxZIfxtMIAi5B4trJXIRsUlYS318
 B/lrBvckkj7eUrE/WsKZAFo0laFor6/mWrue0p+eZMnR3PpUdd/gKetDy7pg331vtC41dynsOGU
 hWXq4QZm2D+ta5/1/hJXA8novmAk=
X-Google-Smtp-Source: AGHT+IFpT01RfKl888dAnfjvbNa+5oaoqyd6bhqQ+9T/n5hVG0x30fa2NMQs3HswGp6hPBLEmCZE8FPOfSdbuGqFE24=
X-Received: by 2002:a05:6512:39d3:b0:52c:dba9:55ff with SMTP id
 2adb3069b0e04-52e7b9113b3mr2461039e87.25.1719758250136; Sun, 30 Jun 2024
 07:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240620-b4-new-firmware-v3-0-29a3a2f1be1e@linaro.org>
 <20240620-b4-new-firmware-v3-1-29a3a2f1be1e@linaro.org>
In-Reply-To: <20240620-b4-new-firmware-v3-1-29a3a2f1be1e@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 30 Jun 2024 16:37:18 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGb9xVQ5E3oK_QX+3hKkMfCoA9jF5jkEeG6Eq9+zbHPHA@mail.gmail.com>
Message-ID: <CAMj1kXGb9xVQ5E3oK_QX+3hKkMfCoA9jF5jkEeG6Eq9+zbHPHA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] tests/avocado: update firmware for sbsa-ref
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, 
 Ard Biesheuvel <ardb+tianocore@kernel.org>, Rebecca Cran <rebecca@bsdio.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=145.40.73.55; envelope-from=ardb@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Thu, 20 Jun 2024 at 12:20, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> Update firmware to have graphics card memory fix from EDK2 commit
> c1d1910be6e04a8b1a73090cf2881fb698947a6e:
>
>     OvmfPkg/QemuVideoDxe: add feature PCD to remap framebuffer W/C
>
>     Some platforms (such as SBSA-QEMU on recent builds of the emulator) only
>     tolerate misaligned accesses to normal memory, and raise alignment
>     faults on such accesses to device memory, which is the default for PCIe
>     MMIO BARs.
>
>     When emulating a PCIe graphics controller, the framebuffer is typically
>     exposed via a MMIO BAR, while the disposition of the region is closer to
>     memory (no side effects on reads or writes, except for the changing
>     picture on the screen; direct random access to any pixel in the image).
>
>     In order to permit the use of such controllers on platforms that only
>     tolerate these types of accesses for normal memory, it is necessary to
>     remap the memory. Use the DXE services to set the desired capabilities
>     and attributes.
>
>     Hide this behavior under a feature PCD so only platforms that really
>     need it can enable it. (OVMF on x86 has no need for this)
>
> With this fix enabled we can boot sbsa-ref with more than one cpu core.
>

This requires an explanation: what does the number of CPU cores have
to do with the memory attributes used for the framebuffer?


> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>  tests/avocado/machine_aarch64_sbsaref.py | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
> index 6bb82f2a03..e854ec6a1a 100644
> --- a/tests/avocado/machine_aarch64_sbsaref.py
> +++ b/tests/avocado/machine_aarch64_sbsaref.py
> @@ -37,18 +37,18 @@ def fetch_firmware(self):
>
>          Used components:
>
> -        - Trusted Firmware 2.11.0
> -        - Tianocore EDK2 stable202405
> -        - Tianocore EDK2-platforms commit 4bbd0ed
> +        - Trusted Firmware         v2.11.0
> +        - Tianocore EDK2           4d4f569924
> +        - Tianocore EDK2-platforms 3f08401
>
>          """
>
>          # Secure BootRom (TF-A code)
>          fs0_xz_url = (
>              "https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/"
> -            "20240528-140808/edk2/SBSA_FLASH0.fd.xz"
> +            "20240619-148232/edk2/SBSA_FLASH0.fd.xz"
>          )
> -        fs0_xz_hash = "fa6004900b67172914c908b78557fec4d36a5f784f4c3dd08f49adb75e1892a9"
> +        fs0_xz_hash = "0c954842a590988f526984de22e21ae0ab9cb351a0c99a8a58e928f0c7359cf7"
>          tar_xz_path = self.fetch_asset(fs0_xz_url, asset_hash=fs0_xz_hash,
>                                        algorithm='sha256')
>          archive.extract(tar_xz_path, self.workdir)
> @@ -57,9 +57,9 @@ def fetch_firmware(self):
>          # Non-secure rom (UEFI and EFI variables)
>          fs1_xz_url = (
>              "https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/"
> -            "20240528-140808/edk2/SBSA_FLASH1.fd.xz"
> +            "20240619-148232/edk2/SBSA_FLASH1.fd.xz"
>          )
> -        fs1_xz_hash = "5f3747d4000bc416d9641e33ff4ac60c3cc8cb74ca51b6e932e58531c62eb6f7"
> +        fs1_xz_hash = "c6ec39374c4d79bb9e9cdeeb6db44732d90bb4a334cec92002b3f4b9cac4b5ee"
>          tar_xz_path = self.fetch_asset(fs1_xz_url, asset_hash=fs1_xz_hash,
>                                        algorithm='sha256')
>          archive.extract(tar_xz_path, self.workdir)
>
> --
> 2.45.1
>

