Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DC3C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 17:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk5B1-0003gL-Q6; Mon, 17 Feb 2025 12:45:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tk5Ay-0003fB-S3
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 12:45:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tk5Aw-0002JP-Ie
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 12:45:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739814297;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jlkmcJXNJRvJqOWRHdosUhgNr6JY3gF+XMAN4UhX3OE=;
 b=b6wYolHBLA+PkgHPOEprelo9DR7/KmC3fjl3J2cvTtS9Cnen2ldEsw+7wnLEYrmBN0xCQC
 qWdAdSXNwMMW8V5SYt7rlD3MdS3pdskpSbGvrZqHu2a7jGjkxgVpyHjd3BjCETYxHdfRxF
 pf/+I4H9h5z1OFjr6ongy2iPO8y+/dc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-7le8cMyWNwiEkX93DSfCxg-1; Mon, 17 Feb 2025 12:44:56 -0500
X-MC-Unique: 7le8cMyWNwiEkX93DSfCxg-1
X-Mimecast-MFC-AGG-ID: 7le8cMyWNwiEkX93DSfCxg_1739814295
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4393b6763a3so24816505e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 09:44:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739814294; x=1740419094;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jlkmcJXNJRvJqOWRHdosUhgNr6JY3gF+XMAN4UhX3OE=;
 b=n6/lMSShHPEqOhG7Ce+zwEhKPE1l7l15O3QuhKZISJDHLclMZQYcKNdA5JWSG9jnB8
 jsgW2EBXHFl00BiXMOXCPw21mVFTt7D6P1Q4oQYFMMulXOXwNSkczMzmbY5744et5vVD
 GoGcXeksWhq9sI3SauDKxaUQEgba3RTSMMYomMX38JZLDucysNh/fAnXzW4lV4etXEvP
 D8Gzum3CsU2N4p01mg2qLA6cLwgTySuqsZr6hZARKqKJLHXWIEghjJd5WwJyfNZjMO8I
 R1xKQsY+VK7sVYSrz5khvjai2zabgUM4ZRlKtZ+UMxQlaNgAUfyY9B2q/5UBxhaLwe1d
 YjdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsRjAC39DClyzNJBJ/651KmhnvxJVcUyVbDty51v4lDYehp6VYTkGmNx5n7yLIDC0VwJTLXS0KzJrx@nongnu.org
X-Gm-Message-State: AOJu0YyTqZif72J1zUdDqgnTWpEhnPRWr2tCqGvWZnVHB2G+uI0xcmf0
 njdKO5HZPrgKQxJOsUfcnRMGoxQ5GjNXsu49XuPjPQfAtX3UvhRDmmIHflT0CbNbiJM/Cj05VUo
 mILJCgAHIlbHQPBk0tWT2QpMXZmQr9iybGJUcLTiFmFl/mTvrEmTnOpgKuSn+
X-Gm-Gg: ASbGncuLkyIfhWBCE9MB0GuMUrRHqa+fNEr9R1JsyC6WRDfdPcDcYvZEgiorDyl6Bg2
 rEXymPmH0eaIhloJG3bLU1ffwaNH/zPEPjggMhQmEV6tkZHuu/HLXirjVKahN2zkjipnEESoZKF
 exc3tK1g4HyuctnTYdl3XHYljYNLvSqaXQeiLA5Br59Y/errom/0jDaBegRWOWcYmtbVOTi9jfH
 1wbChPOgs5nZl7iuMZisRrSS1jWpgkuVl00aIw6e5lAuRJK8aKk70iVjSy2NL7jJblxq/kVyOVZ
 XebXstFUC8sbs26iHFjfaVgvQmUq08TeZxA5FLNxgTaQlbEO2FIF
X-Received: by 2002:a05:600c:468d:b0:439:91dd:cfa3 with SMTP id
 5b1f17b1804b1-43991ddd1f7mr6997635e9.29.1739814294363; 
 Mon, 17 Feb 2025 09:44:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExMxA/3Tc/jMLQRzn4VEjfVyQypGFbps9qD3H5t6khxQjncTxPLbXU46tOgp4Xhr+kPE/gMw==
X-Received: by 2002:a05:600c:468d:b0:439:91dd:cfa3 with SMTP id
 5b1f17b1804b1-43991ddd1f7mr6997405e9.29.1739814293815; 
 Mon, 17 Feb 2025 09:44:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1b824dsm158071415e9.34.2025.02.17.09.44.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 09:44:53 -0800 (PST)
Message-ID: <279a277d-428c-4769-ac6a-25968b40c6a7@redhat.com>
Date: Mon, 17 Feb 2025 18:44:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] docs: Fix "Arm" capitalization
Content-Language: en-US
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: Ninad Palsule <ninad@linux.ibm.com>, sebott@redhat.com, maz@kernel.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Yi Liu <yi.l.liu@intel.com>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>
References: <20250217163732.3718617-1-kchamart@redhat.com>
 <20250217163732.3718617-4-kchamart@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250217163732.3718617-4-kchamart@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Hi,

On 2/17/25 5:37 PM, Kashyap Chamarthy wrote:
> This is based on Peter's suggestion here[1].
>
> I simply addrressed the occurrences that I found with `git grep "ARM "`
adressed
> in the docs/ directory.  I didn't touch stuff like these "StrongARM",
> ARM926EJ-S, ARM1176JZS, etc.  Related commit[2].
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2025-01/msg05137.html
>     - docs/cpu-features: Update "PAuth" (Pointer Authentication) details
>
> [2] 6fe6d6c9a9 (docs: Be consistent about capitalization of 'Arm',
>     2020-03-09)
>
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  docs/devel/testing/qgraph.rst        |  8 ++++----
>  docs/devel/vfio-iommufd.rst          |  2 +-
>  docs/specs/fsi.rst                   |  2 +-
>  docs/system/arm/aspeed.rst           |  6 +++---
>  docs/system/arm/b-l475e-iot01a.rst   |  2 +-
>  docs/system/arm/nrf.rst              |  4 ++--
>  docs/system/arm/nuvoton.rst          |  4 ++--
>  docs/system/arm/stm32.rst            | 12 ++++++------
>  docs/system/arm/xlnx-versal-virt.rst | 12 ++++++------
>  docs/system/arm/xlnx-zynq.rst        |  2 +-
>  docs/system/guest-loader.rst         |  2 +-
>  11 files changed, 28 insertions(+), 28 deletions(-)
>
> diff --git a/docs/devel/testing/qgraph.rst b/docs/devel/testing/qgraph.rst
> index 43342d9d65..30ff055fae 100644
> --- a/docs/devel/testing/qgraph.rst
> +++ b/docs/devel/testing/qgraph.rst
> @@ -8,7 +8,7 @@ take care of booting QEMU with the right machine and devices.
>  This makes each test "hardcoded" for a specific configuration, reducing
>  the possible coverage that it can reach.
>  
> -For example, the sdhci device is supported on both x86_64 and ARM boards,
> +For example, the sdhci device is supported on both x86_64 and Arm boards,
>  therefore a generic sdhci test should test all machines and drivers that
>  support that device.
>  Using only libqos APIs, the test has to manually take care of
> @@ -195,7 +195,7 @@ there.
>  The ``arm/raspi2b`` machine node is listed as "UNAVAILABLE". Although it is
>  reachable from the root via '' -> 'arm/raspi2b' the node is unavailable because
>  the QEMU binary did not list it when queried by the framework. This is expected
> -because we used the ``qemu-system-x86_64`` binary which does not support ARM
> +because we used the ``qemu-system-x86_64`` binary which does not support Arm
>  machine types.
>  
>  If a test is unexpectedly listed as "UNAVAILABLE", first check that the "ALL
> @@ -214,9 +214,9 @@ Here we continue the ``sdhci`` use case, with the following scenario:
>  
>  - ``sdhci-test`` aims to test the ``read[q,w], writeq`` functions
>    offered by the ``sdhci`` drivers.
> -- The current ``sdhci`` device is supported by both ``x86_64/pc`` and ``ARM``
> +- The current ``sdhci`` device is supported by both ``x86_64/pc`` and ``Arm``
>    (in this example we focus on the ``arm-raspi2b``) machines.
> -- QEMU offers 2 types of drivers: ``QSDHCI_MemoryMapped`` for ``ARM`` and
> +- QEMU offers 2 types of drivers: ``QSDHCI_MemoryMapped`` for ``Arm`` and
>    ``QSDHCI_PCI`` for ``x86_64/pc``. Both implement the
>    ``read[q,w], writeq`` functions.
>  
> diff --git a/docs/devel/vfio-iommufd.rst b/docs/devel/vfio-iommufd.rst
> index 3d1c11f175..fe8a7365e3 100644
> --- a/docs/devel/vfio-iommufd.rst
> +++ b/docs/devel/vfio-iommufd.rst
> @@ -122,7 +122,7 @@ container:
>  Supported platform
>  ==================
>  
> -Supports x86, ARM and s390x currently.
> +Supports x86, Arm, and s390x currently.
>  
>  Caveats
>  =======
> diff --git a/docs/specs/fsi.rst b/docs/specs/fsi.rst
> index af87822531..f7d86d3e37 100644
> --- a/docs/specs/fsi.rst
> +++ b/docs/specs/fsi.rst
> @@ -40,7 +40,7 @@ for the implementation are: (see the `FSI specification`_ for more details)
>     MMIO-mapping of the CFAM address straight onto a sub-region of the OPB
>     address space.
>  
> -5. An APB-to-OPB bridge enabling access to the OPB from the ARM core in the
> +5. An APB-to-OPB bridge enabling access to the OPB from the Arm core in the
>     AST2600. Hardware limitations prevent the OPB from being directly mapped
>     into APB, so all accesses are indirect through the bridge.
>  
> diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
> index fa4aa28eef..42096fb941 100644
> --- a/docs/system/arm/aspeed.rst
> +++ b/docs/system/arm/aspeed.rst
> @@ -5,8 +5,8 @@ The QEMU Aspeed machines model BMCs of various OpenPOWER systems and
>  Aspeed evaluation boards. They are based on different releases of the
>  Aspeed SoC : the AST2400 integrating an ARM926EJ-S CPU (400MHz), the
>  AST2500 with an ARM1176JZS CPU (800MHz), the AST2600
> -with dual cores ARM Cortex-A7 CPUs (1.2GHz) and more recently the AST2700
> -with quad cores ARM Cortex-A35 64 bits CPUs (1.6GHz)
> +with dual cores Arm Cortex-A7 CPUs (1.2GHz) and more recently the AST2700
> +with quad cores Arm Cortex-A35 64 bits CPUs (1.6GHz)
>  
>  The SoC comes with RAM, Gigabit ethernet, USB, SD/MMC, USB, SPI, I2C,
>  etc.
> @@ -275,7 +275,7 @@ Aspeed minibmc family boards (``ast1030-evb``)
>  
>  The QEMU Aspeed machines model mini BMCs of various Aspeed evaluation
>  boards. They are based on different releases of the
> -Aspeed SoC : the AST1030 integrating an ARM Cortex M4F CPU (200MHz).
> +Aspeed SoC : the AST1030 integrating an Arm Cortex M4F CPU (200MHz).
>  
>  The SoC comes with SRAM, SPI, I2C, etc.
>  
> diff --git a/docs/system/arm/b-l475e-iot01a.rst b/docs/system/arm/b-l475e-iot01a.rst
> index 2adcc4b4c1..7f891719d5 100644
> --- a/docs/system/arm/b-l475e-iot01a.rst
> +++ b/docs/system/arm/b-l475e-iot01a.rst
> @@ -2,7 +2,7 @@ B-L475E-IOT01A IoT Node (``b-l475e-iot01a``)
>  ============================================
>  
>  The B-L475E-IOT01A IoT Node uses the STM32L475VG SoC which is based on
> -ARM Cortex-M4F core. It is part of STMicroelectronics
> +Arm Cortex-M4F core. It is part of STMicroelectronics
>  :doc:`STM32 boards </system/arm/stm32>` and more specifically the STM32L4
>  ultra-low power series. The STM32L4x5 chip runs at up to 80 MHz and
>  integrates 128 KiB of SRAM and up to 1MiB of Flash. The B-L475E-IOT01A board
> diff --git a/docs/system/arm/nrf.rst b/docs/system/arm/nrf.rst
> index eda87bd760..e0ea6a8b7e 100644
> --- a/docs/system/arm/nrf.rst
> +++ b/docs/system/arm/nrf.rst
> @@ -1,7 +1,7 @@
>  Nordic nRF boards (``microbit``)
>  ================================
>  
> -The `Nordic nRF`_ chips are a family of ARM-based System-on-Chip that
> +The `Nordic nRF`_ chips are a family of Arm-based System-on-Chip that
>  are designed to be used for low-power and short-range wireless solutions.
>  
>  .. _Nordic nRF: https://www.nordicsemi.com/Products
> @@ -18,7 +18,7 @@ supported by QEMU.
>  Supported devices
>  -----------------
>  
> - * ARM Cortex-M0 (ARMv6-M)
> + * Arm Cortex-M0 (ARMv6-M)
>   * Serial ports (UART)
>   * Clock controller
>   * Timers
> diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
> index 05059378e5..e0da2297ff 100644
> --- a/docs/system/arm/nuvoton.rst
> +++ b/docs/system/arm/nuvoton.rst
> @@ -1,9 +1,9 @@
>  Nuvoton iBMC boards (``kudo-bmc``, ``mori-bmc``, ``npcm750-evb``, ``quanta-gbs-bmc``, ``quanta-gsj``)
>  =====================================================================================================
>  
> -The `Nuvoton iBMC`_ chips (NPCM7xx) are a family of ARM-based SoCs that are
> +The `Nuvoton iBMC`_ chips (NPCM7xx) are a family of Arm-based SoCs that are
>  designed to be used as Baseboard Management Controllers (BMCs) in various
> -servers. They all feature one or two ARM Cortex-A9 CPU cores, as well as an
> +servers. They all feature one or two Arm Cortex-A9 CPU cores, as well as an
>  assortment of peripherals targeted for either Enterprise or Data Center /
>  Hyperscale applications. The former is a superset of the latter, so NPCM750 has
>  all the peripherals of NPCM730 and more.
> diff --git a/docs/system/arm/stm32.rst b/docs/system/arm/stm32.rst
> index 511e3eb9ac..381d2c4386 100644
> --- a/docs/system/arm/stm32.rst
> +++ b/docs/system/arm/stm32.rst
> @@ -1,24 +1,24 @@
>  STMicroelectronics STM32 boards (``netduino2``, ``netduinoplus2``, ``olimex-stm32-h405``, ``stm32vldiscovery``)
>  ===============================================================================================================
>  
> -The `STM32`_ chips are a family of 32-bit ARM-based microcontroller by
> +The `STM32`_ chips are a family of 32-bit Arm-based microcontroller by
>  STMicroelectronics.
>  
>  .. _STM32: https://www.st.com/en/microcontrollers-microprocessors/stm32-32-bit-arm-cortex-mcus.html
>  
> -The STM32F1 series is based on ARM Cortex-M3 core. The following machines are
> +The STM32F1 series is based on Arm Cortex-M3 core. The following machines are
>  based on this chip :
>  
>  - ``stm32vldiscovery``  STM32VLDISCOVERY board with STM32F100RBT6 microcontroller
>  
> -The STM32F2 series is based on ARM Cortex-M3 core. The following machines are
> +The STM32F2 series is based on Arm Cortex-M3 core. The following machines are
>  based on this chip :
>  
>  - ``netduino2``         Netduino 2 board with STM32F205RFT6 microcontroller
>  
> -The STM32F4 series is based on ARM Cortex-M4F core, as well as the STM32L4
> +The STM32F4 series is based on Arm Cortex-M4F core, as well as the STM32L4
>  ultra-low-power series. The STM32F4 series is pin-to-pin compatible with STM32F2 series.
> -The following machines are based on this ARM Cortex-M4F chip :
> +The following machines are based on this Arm Cortex-M4F chip :
>  
>  - ``netduinoplus2``     Netduino Plus 2 board with STM32F405RGT6 microcontroller
>  - ``olimex-stm32-h405`` Olimex STM32 H405 board with STM32F405RGT6 microcontroller
> @@ -29,7 +29,7 @@ There are many other STM32 series that are currently not supported by QEMU.
>  Supported devices
>  -----------------
>  
> - * ARM Cortex-M3, Cortex M4F
> + * Arm Cortex-M3, Cortex M4F
>   * Analog to Digital Converter (ADC)
>   * EXTI interrupt
>   * Serial ports (USART)
> diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
> index c5f35f28e4..1b3a0ad6a5 100644
> --- a/docs/system/arm/xlnx-versal-virt.rst
> +++ b/docs/system/arm/xlnx-versal-virt.rst
> @@ -19,12 +19,12 @@ limitations. Currently, we support the following cores and devices:
>  
>  Implemented CPU cores:
>  
> -- 2 ACPUs (ARM Cortex-A72)
> +- 2 ACPUs (Arm Cortex-A72)
>  
>  Implemented devices:
>  
> -- Interrupt controller (ARM GICv3)
> -- 2 UARTs (ARM PL011)
> +- Interrupt controller (Arm GICv3)
> +- 2 UARTs (Arm PL011)
>  - An RTC (Versal built-in)
>  - 2 GEMs (Cadence MACB Ethernet MACs)
>  - 8 ADMA (Xilinx zDMA) channels
> @@ -70,7 +70,7 @@ provides EL3 firmware to handle PSCI.
>  
>  A few examples:
>  
> -Direct Linux boot of a generic ARM64 upstream Linux kernel:
> +Direct Linux boot of a generic Arm64 upstream Linux kernel:
>  
>  .. code-block:: bash
>  
> @@ -95,7 +95,7 @@ Direct Linux boot of PetaLinux 2019.2:
>        -device virtio-rng-device,bus=virtio-mmio-bus.0,rng=rng0 \
>        -object rng-random,filename=/dev/urandom,id=rng0
>  
> -Boot PetaLinux 2019.2 via ARM Trusted Firmware (2018.3 because the 2019.2
> +Boot PetaLinux 2019.2 via Arm Trusted Firmware (2018.3 because the 2019.2
>  version of ATF tries to configure the CCI which we don't model) and U-boot:
>  
>  .. code-block:: bash
> @@ -149,7 +149,7 @@ Run the following at the U-Boot prompt:
>    fdt set /chosen/dom0 reg <0x00000000 0x40000000 0x0 0x03100000>
>    booti 30000000 - 20000000
>  
> -Boot Linux as Dom0 on Xen via ARM Trusted Firmware and U-Boot:
> +Boot Linux as Dom0 on Xen via Arm Trusted Firmware and U-Boot:
>  
>  .. code-block:: bash
>  
> diff --git a/docs/system/arm/xlnx-zynq.rst b/docs/system/arm/xlnx-zynq.rst
> index ade18a3fe1..94eedf0e81 100644
> --- a/docs/system/arm/xlnx-zynq.rst
> +++ b/docs/system/arm/xlnx-zynq.rst
> @@ -29,7 +29,7 @@ QEMU xilinx-zynq-a9 board supports following devices:
>  
>  Running
>  """""""
> -Direct Linux boot of a generic ARM upstream Linux kernel:
> +Direct Linux boot of a generic Arm upstream Linux kernel:
>  
>  .. code-block:: bash
>  
> diff --git a/docs/system/guest-loader.rst b/docs/system/guest-loader.rst
> index 304ee5d531..12436cc791 100644
> --- a/docs/system/guest-loader.rst
> +++ b/docs/system/guest-loader.rst
> @@ -32,7 +32,7 @@ size. Additional information can be passed with by using additional
>  arguments.
>  
>  Currently the only supported machines which use FDT data to boot are
> -the ARM and RiscV ``virt`` machines.
> +the Arm and RiscV ``virt`` machines.
>  
>  Arguments
>  ^^^^^^^^^


