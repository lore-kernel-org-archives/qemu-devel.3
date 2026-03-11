Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252DE104BEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Mpl-0008KL-WD; Wed, 11 Mar 2026 12:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w0Mpf-00089D-0E
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:54:52 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w0Mpc-0006VL-RH
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:54:50 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439b73f4ab4so118387f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 09:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773248087; x=1773852887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=10RNGrR8iEfzyE1fmXbnQu9JHK+LihvFUZbHgFYT244=;
 b=rkYohkPjKojHmPbizIf0QQ/DaCIHJ3bwhkTdLT0bjGzsqyjEW8VmEF1C/zyAOPiWl2
 EhLERdtyND7/l1iTVy+dErFHDoqOaP5/lR80uQPltDxhDXVBzXrIKHTn2XK9ShbcVn+a
 kkREkuf2OX0KP0I7TCf5lrzCVKJGLpj9YaWJnQFfsTTtp1RyDaAiRP4aC/ycywQBDUX0
 ZHgeKDdxm71ISdLjqE/W64L6Fh5dloZsz5JSbEbkGcGv7SFWPUlcL6ZJSIFoyDQ1N6hw
 zapgQDpc1Hc0AENsZHNt8l2/sp77HWNVfBCNsfG6Zf1PuAWbP4vPqaqOqDucAC7B0WFE
 UzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773248087; x=1773852887;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=10RNGrR8iEfzyE1fmXbnQu9JHK+LihvFUZbHgFYT244=;
 b=UYxo+6ZxtGwTKWu4doqHdkXJ8aJHKa4QPMBvGaSc5lTs3Dup6WYby9ESnG3g0tzZKO
 tuJ80W8nliZjOmdBivZNMciS9VA1caN3FiNNJE8dX2ns3LLcP1jwlowbwq8aHPvSwYjb
 OnsqumLTBDekZN8tCtPk+RCilQbNCmYxhge8PXpnexui41IVFzcnCLnjSB2x/w03vNTd
 EJJ2FGzfd2uBNyfeKGfZYZBJg4nYo1y/OAg3zk8M1NUs9/Sdu8YdJBklAc49wep+/7A6
 FKBlE9upxju7rml3nsB162zxWWi+ymNCFMJPlAc8P145LBkFbnEt9SaQ2vFvBL2GtfNn
 H1MA==
X-Gm-Message-State: AOJu0Yw/gyGKKgyDv5/Yx5fAbf6w6ZHmA2Spl+OIa/FnsvoAz8mgoKVd
 YvYlgPuqE40sbayyUiTM2sbKpU/mcz9ErPiSgp/GKxU5/pAMHbY6BNo9BK36h4XvbV4=
X-Gm-Gg: ATEYQzxLNW3mWsOxlQ2O/OD2V7zyiFMo4C4VzRxJo3ui4PkNwdNaLzA1rTfgRIteZLO
 EzI+acIPhUihGHDMbGLSIykXSxABkTokGfkSA5q9Pr7i4NtWj5vY+FUTIj78YsugUSZahJZjH25
 dR2z1bhl2g9eu5Vs8GWFz6XkVZhhLGWGMjGD3Pb8rAlqy6VVhdptDB47Ses30WVZ6FYdVbBrS0a
 qkrxb5wE77U4RfIht3Cpt3HbJhMb/pCDkmZDZTDhMbQsHtxQATTgWubeUHDRg5XyhsnpxAUl2wX
 RMTc/ad8edIhRxFUxEnp+mXntsbmuTl9WmCNQvVST4qzehWzYapDObW0VIVx5j6cp46YX8qzeVG
 wyGM5TQDB4ou2W1wzijteURS5RQOlbWJA4RVbqxSNgiIIpIQRI5uN/jGRpb/1z1/7+BU1Kf92RN
 LzqkcjLjg47RQSwkywdfEw80MH82D1lPNGaQ==
X-Received: by 2002:a05:6000:2f85:b0:430:f40f:61ba with SMTP id
 ffacd0b85a97d-439f821f535mr6551553f8f.41.1773248086579; 
 Wed, 11 Mar 2026 09:54:46 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20bd9csm439759f8f.21.2026.03.11.09.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 09:54:46 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 342995F811;
 Wed, 11 Mar 2026 16:54:45 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>
Cc: qemu-devel@nongnu.org,  Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Daniel
 P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter
 Maydell <peter.maydell@linaro.org>,  Aastha Rawat
 <aastharawat@linux.microsoft.com>,  qemu-arm@nongnu.org
Subject: Re: [PATCH 00/14] Add ARM64 support for MSHV accelerator
In-Reply-To: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
 (Anirudh Rayabharam's message of "Wed, 11 Mar 2026 15:15:27 +0000")
References: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Wed, 11 Mar 2026 16:54:45 +0000
Message-ID: <877brii9wq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

"Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com> writes:

> This series adds ARM64 guest support to the MSHV (Microsoft Hypervisor)
> accelerator, enabling QEMU to run aarch64 VMs on Microsoft's hypervisor
> using the mshv Linux kernel module.

Does GitLab (or anything we plug into it) support runners on Arm64 with
HyperV and a Linux Dom0?

I looks like we would need a dedicated runner to defend the
functionality on CI.

>
> The first few patches refactor the existing x86 MSHV code to separate
> arch-specific pieces from common infrastructure: moving MSR handling to
> target/i386, extracting shared register hypercall helpers, provisioning
> host CPU features, and introducing arch-specific init hooks.
>
> The remaining patches add the ARM64 backend:
>  - vCPU state get/set using hypervisor register hypercalls
>  - -cpu host support by querying ID registers from the hypervisor
>  - vCPU run loop with MMIO emulation via ESR_EL2 syndrome decoding
>  - In-kernel vGICv3 backed by HVCALL_ASSERT_VIRTUAL_INTERRUPT
>  - Interrupt control structure adjustments for arm64
>
> With this series, a standard aarch64 virt machine can be launched with:
>   qemu-system-aarch64 -accel mshv -cpu host -M virt ...
>
> Caveats:
> - Currently only direct kernel is supported. We're still debugging edk2
>   firmware boot.=20
> - Live migration is not yet supported.
>
> ---
> Aastha Rawat (7):
>       accel/mshv: move msr.c to target/i386
>       accel/mshv: extract common CPU register helpers
>       meson, target/arm/mshv: Enable arm64 build & add initial MSHV suppo=
rt
>       target/arm/mshv: implement vcpu state operations for ARM64
>       target/arm/mshv: implement -cpu host for MSHV
>       accel/mshv: Add access_vp_regs synthetic proc features
>       target/arm: cpu: Mark MSHV supporting PSCI 1.3
>
> Anirudh Rayabharam (Microsoft) (6):
>       accel/mshv: provision guests with the same features as host
>       accel/mshv: add arch-specific accelerator init hook
>       target/arm/mshv: add vCPU run loop
>       include/hw/hyperv: adjust hv_interrupt_control structure for arm64
>       hw/intc,target/arm/mshv: add MSHV vGICv3 implementation
>       MAINTAINERS: updates for MSHV arm64 code
>
> Magnus Kulke (1):
>       accel/mshv: implement cpu_thread_is_idle() hook
>
>  MAINTAINERS                        |   8 +
>  accel/mshv/irq.c                   |   2 +
>  accel/mshv/meson.build             |   4 +-
>  accel/mshv/mshv-all.c              |  73 +++-
>  accel/mshv/mshv-cpu-common.c       | 151 +++++++++
>  hw/arm/virt.c                      |  11 +-
>  hw/intc/arm_gicv3_common.c         |   3 +
>  hw/intc/arm_gicv3_mshv.c           | 180 ++++++++++
>  hw/intc/meson.build                |   1 +
>  include/hw/hyperv/hvgdk_mini.h     | 130 ++++++++
>  include/hw/hyperv/hvhdk.h          |  97 +++++-
>  include/hw/hyperv/hvhdk_mini.h     |   6 +
>  include/hw/intc/arm_gicv3_common.h |   1 +
>  include/system/hw_accel.h          |   3 +-
>  include/system/mshv.h              |   2 +
>  include/system/mshv_int.h          |   5 +
>  meson.build                        |   7 +-
>  target/arm/cpu.c                   |   7 +-
>  target/arm/cpu64.c                 |  24 +-
>  target/arm/meson.build             |   1 +
>  target/arm/mshv/meson.build        |   7 +
>  target/arm/mshv/mshv-all.c         | 665 +++++++++++++++++++++++++++++++=
++++++
>  target/arm/mshv_arm.h              |  18 +
>  target/i386/mshv/meson.build       |   2 +
>  target/i386/mshv/mshv-all.c        |  85 +++++
>  target/i386/mshv/mshv-cpu.c        | 170 +---------
>  {accel =3D> target/i386}/mshv/msr.c  |   0
>  27 files changed, 1465 insertions(+), 198 deletions(-)
> ---
> base-commit: 1fd5ff9d76d23ab23a68419cbc76d5ee33e8b455
> change-id: 20260311-mshv_accel_arm64_supp-e86b0082aee4
>
> Best regards,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

