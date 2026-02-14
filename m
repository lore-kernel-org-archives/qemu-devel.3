Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F52DEDF15A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 13:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrFe3-0000GI-05; Sat, 14 Feb 2026 08:25:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vrFe1-0000G5-Gt
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 08:25:09 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vrFdz-0001po-M8
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 08:25:09 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso20873745e9.0
 for <qemu-devel@nongnu.org>; Sat, 14 Feb 2026 05:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771075506; x=1771680306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VR8EYLRtXJG10FhI+X/AcfpSpQbr9esd5UAwqmf3k2U=;
 b=CCeYoD0pspunWY4MxDdCgmxxn6YOMKc17UjMzBrMyO16omui26EE3Wy9/tdr9PYEtx
 32LWK50kSSGK+lfkg8CUPbpjVHODKQaGNmUl362rp/hIRVtGh3bq1WAEIq1ZKioNYERu
 ItPuO0sn+twBOBZDaCQAPW7e933aeUBzIo4WoUqpfeG9niw7PSe6d70yte8r0cXKQyW3
 lGq49Un4C3SogNL5zM5l5uMVWED+PaZyyXBu/wi3gIZUzvhwKqAzgsvaEyqZUrzZpRMk
 02F6w5OHBFY0YYlE33+2n7j6suebVL/u+gl9Hd2XmV9D7wOFTm0KRbB6ff0oyZNqZdes
 KjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771075506; x=1771680306;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VR8EYLRtXJG10FhI+X/AcfpSpQbr9esd5UAwqmf3k2U=;
 b=kYdFEa0SB6sdcfing5ZQ5edy5Qfqx9qY/fX2/bEWuk1Xs//Rst2HiV+XEX++fIPBeV
 720AhPLu9hfBd92I2/jFaIcR/fsSCOSk+ohfDAuDc2ryTE2tskGrmIXK6+rGgX/fSK6q
 nyFp2fI2bI+NKV+4UxfgyAmw2g8XWWJN96luxWP2RV7n7k33L7UWGaksYLCW8vlgktlR
 hCvwcq4xiqU/rmHNdVykwxSlsseZke0Z+pUzDGXboaRnojiTep4C7rxSLBJHHaoafjbi
 WH0hycpVdLFmHrkcso7+A86HHGrd5307O18gpBbpKmVlfJdlviztkX6sn2M4p+8ceXOt
 xPPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEKY9RpFPfOxkRpciewPp+YPnrJ0FFdoH60e3HwWuc9twES18eswAtuLUsU8CDbIQpZFWpnCVtebhW@nongnu.org
X-Gm-Message-State: AOJu0YwGKO4okT4DXEm4+ABuAU0TncBqnJWgFoJKUzBmv8TkgXbuliJP
 l4F53K6siwaJVB+lTuQU//gLowKG3l00GkjkZ1VeIh09ihz481230Sic
X-Gm-Gg: AZuq6aJpmGTLbSY0KboMKBefg6Eo6vuBpMKfL4Djt+Qn5GVP1ZKyT7zSbM8aqszJeR2
 lHxXsFYmJuvPXMLDSyCP2p4buZQpiZhlzT8jwnXZhFb20VsTs2C5d17Qj9Wi1jUYgWesImOQACI
 HjtSEtqFAhbdP6izuCJ4JCaPHcPXAVmVhMRar6/PweRg7OOVRAR7rJwRSSx7BHeDbsQd/3otpIL
 81UvbqBu+vOe8zkUdnSb0uP0Q/NzSN6xId2eddEaeVV/TC70WH6nAgJVxq9bcSHjp4Q0rNKg6U6
 bRXRdgVgI9lgaLRWGYhoHzUp+7+bR3QDamjnq+1incqLBClIwgXobCCM2mYe6CdBXlXSlN5y4IH
 EBLhl8A3RWqTHq/a2wnbN+E99P8clICWxHSrsqObFFD8s8y7HbK20OAKKjMsuvjLbYybfATse1l
 DwxNDmPPCmIxdNcQaoCxexOU67Y7xl7ghA/XiRN4tT9IR9ggfAIPdNvSXQcCOK/k+n8j1iDKQ/R
 1Mg7DtrzxSKeg3sDikB1AxALLs9ax0tmiB8PVwznpSWR4k=
X-Received: by 2002:a05:600c:5308:b0:47e:e946:3a72 with SMTP id
 5b1f17b1804b1-48379bf78f1mr39385855e9.27.1771075505643; 
 Sat, 14 Feb 2026 05:25:05 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-25de-7d00-f009-a6c9-39e7-d8fe.310.pool.telefonica.de.
 [2a02:3100:25de:7d00:f009:a6c9:39e7:d8fe])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d82a4afsm587046505e9.11.2026.02.14.05.25.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Feb 2026 05:25:05 -0800 (PST)
Date: Sat, 14 Feb 2026 13:24:41 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
CC: =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 00/10] whpx: x86 updates (2026-02)
In-Reply-To: <20260213034556.13471-1-mohamed@unpredictable.fr>
References: <20260213034556.13471-1-mohamed@unpredictable.fr>
Message-ID: <91C3539C-D85A-4AA3-83A2-86A285EA6544@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x335.google.com
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



Am 13=2E Februar 2026 03:45:43 UTC schrieb Mohamed Mediouni <mohamed@unpre=
dictable=2Efr>:
>x86_64 WHPX updates:
>
>- move HVF x86_mmu code to common code
>- fixing debug support, which was broken since around: "gdbstub: move gue=
st debug support check to ops"
>a48e7d9e52f8fe8b47f4c74f3e99d9d677b87fe5
>- switch over from winhvemulation to common x86 VM exit emulation code
>- remove some log lines
>- Remove WHPX CPUID traps as they're currently quite broken
>
>Changes added since v1:
>- move HVF x86_mmu code to common code
>- Use x86_mmu in WHPX MMIO exits
>- Remove WHPX CPUID traps as they're currently quite broken

>- Optimise MMIO vmexits by not restoring the full state

Yes, that did the trick for me, so:

Tested-by: Bernhard Beschow shentey@gmail=2Ecom

I had to fix some compilation issues which I have submitted here: https://=
lore=2Ekernel=2Eorg/qemu-devel/20260214131659=2E31378-1-shentey@gmail=2Ecom=
/ =2E Feel free to include in your next iteration, if any=2E

Best regards,
Bernhard

>
>Mohamed Mediouni (10):
>  target/i386: emulate, hvf: move x86_mmu to common code
>  whpx: re-enable guest debug support on x86
>  whpx: preparatory changes before switching over from winhvemulation
>  whpx: refactor whpx_destroy_vcpu to arch-specific function
>  whpx: move whpx_get_reg/whpx_set_reg to generic code
>  whpx: x86: switch over from winhvemulation to target/i386/emulate
>  whpx: remove remaining winhvemulation support code
>  whpx: x86: remove messages
>  whpx: i386: remove CPUID trapping
>  whpx: x86: optimise MMIO vmexit by only restoring needed registers
>
> accel/whpx/whpx-accel-ops=2Ec            |   8 +
> accel/whpx/whpx-common=2Ec               |  62 ++--
> include/system/whpx-accel-ops=2Eh        |   8 +-
> include/system/whpx-all=2Eh              |   5 +
> include/system/whpx-common=2Eh           |   6 +-
> include/system/whpx-internal=2Eh         |  16 --
> meson=2Ebuild                            |   3 +-
> target/arm/whpx/whpx-all=2Ec             |  33 +--
> target/i386/cpu=2Eh                      |   2 +-
> target/i386/emulate/meson=2Ebuild        |   2 +
> target/i386/{hvf =3D> emulate}/x86_mmu=2Ec |  14 +-
> target/i386/{hvf =3D> emulate}/x86_mmu=2Eh |   0
> target/i386/hvf/hvf=2Ec                  |   6 +-
> target/i386/hvf/meson=2Ebuild            |   1 -
> target/i386/hvf/x86=2Ec                  |   2 +-
> target/i386/hvf/x86_task=2Ec             |   2 +-
> target/i386/mshv/meson=2Ebuild           |   4 +
> target/i386/whpx/whpx-all=2Ec            | 373 +++++++++----------------
> 18 files changed, 217 insertions(+), 330 deletions(-)
> rename target/i386/{hvf =3D> emulate}/x86_mmu=2Ec (95%)
> rename target/i386/{hvf =3D> emulate}/x86_mmu=2Eh (100%)
>

