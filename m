Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2510C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 15:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBcIa-0007X4-Sr; Mon, 27 May 2024 11:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1sBcIY-0007Us-GJ
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:30:06 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1sBcIT-00029A-IO
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:30:04 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a6302bdb54aso116703066b.0
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716823799; x=1717428599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IvP47fXFVFCIJr1ONx3qVxSHn2Bs2PSThuPwpCdDm+Y=;
 b=Tmwg03P8lpWGiVfe3lbZFWHQAyKz+X/xV8bPl6pw002xBfjqqLko5YOXk1UzW1IHrg
 02/2fjPasptG6U+ZTXP4+1y1/xu3X3tbZmLyPlMXc0aaRisaaZUGllbuL5b6HM+GcMzt
 +cm+BLK8qoeQiOpaMqQ6IhnVMfXwM4ysBV/XoWUz/KK+cTgdfxLa6GApU8mWlXqKJXLz
 EXz6KCCDSxp5CFNcFsStImBCfHmzpkJ4HVXLs/02lIvQjWwPFwGpsgrkQVjQEemgNzXY
 0jdZcUxP4P9qhszs/CbRQU6Lpo20js5CBYf35HsUak9fl5403Yfd4m4L4gkRYe91i/Lt
 vl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716823799; x=1717428599;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IvP47fXFVFCIJr1ONx3qVxSHn2Bs2PSThuPwpCdDm+Y=;
 b=XhkQbCmDnga+2j4y0aQ9+yqAiuNNeiohvsEJJcNmzDAOoAgxXQC1mYrQoJbl1OFgyP
 8AFudIKcScgDPByUVokr9lnMO/z6vsfGolsdKiJzGc++He95nvkDKoEycV5+O7aXMNuX
 7WT6r0htrEilSFCN5SPlcEZnTdoveFW0aCrs4MIE62oLd2BVP5JBCGT/SA2Q4bFLaVHb
 BJcIXMNhF02JOxBuxOlnVd/XzUGL+aVZcpzl3FbZ35qYblwOTmPnXkKvyvCoCdJ/AZ4g
 UcanV2in0+MxrOFNo+3U/sawcIPK+n8+IKekeMOFY+ZfkdtwCunm6jbL+tT2NqtuFt9E
 TvMw==
X-Gm-Message-State: AOJu0Yx4q+A1Lo+dIyWJIP3w/BUJphMghD2deHqJOH9oFOzFKqFVyeol
 bdTtw5Io/nKPY5R73TXZfvXMTsxUtUU7f5jhCzMNScG1tNe4PUJPrJ20WA==
X-Google-Smtp-Source: AGHT+IFrdGseC7f6tt5p/BRA9q2qbgRLeBP1gQ2emr027fMeAwtgIqLYWJjJrjULBlxT6vl7KKOYvA==
X-Received: by 2002:a17:906:7c98:b0:a59:beb2:62cc with SMTP id
 a640c23a62f3a-a62651469a3mr638557766b.61.1716823798967; 
 Mon, 27 May 2024 08:29:58 -0700 (PDT)
Received: from [127.0.0.1] (business-90-187-110-129.pool2.vodafone-ip.de.
 [90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c817981sm504006166b.31.2024.05.27.08.29.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 08:29:58 -0700 (PDT)
Date: Mon, 27 May 2024 15:29:53 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
CC: qemu-devel@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPULL_17/20=5D_target/arm=3A_Do_memory_typ?=
 =?US-ASCII?Q?e_alignment_check_when_translation_disabled?=
In-Reply-To: <CAFEAcA-BD1TmaBB_5ephnRoNsOCWsS4w3C_oj0P_182+fOLPUQ@mail.gmail.com>
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
 <20240305135237.3111642-18-peter.maydell@linaro.org>
 <C875173E-4B5B-4F71-8CF4-4325F7AB7629@gmail.com>
 <72ED7A80-9EA7-4FF6-BE29-9583587985C7@gmail.com>
 <f6976b40-e3d5-4157-8597-ce7db6ceb068@linaro.org>
 <CAFEAcA-BD1TmaBB_5ephnRoNsOCWsS4w3C_oj0P_182+fOLPUQ@mail.gmail.com>
Message-ID: <C27AC9E0-AB61-483E-BF07-B435AABE3D13@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



Am 27=2E Mai 2024 10:58:54 UTC schrieb Peter Maydell <peter=2Emaydell@lina=
ro=2Eorg>:
>On Mon, 27 May 2024 at 03:36, Richard Henderson
><richard=2Ehenderson@linaro=2Eorg> wrote:
>>
>> On 5/25/24 13:50, Bernhard Beschow wrote:
>> >
>> >
>> > Am 25=2E Mai 2024 13:41:54 UTC schrieb Bernhard Beschow <shentey@gmai=
l=2Ecom>:
>> >>
>> >>
>> >> Am 5=2E M=C3=A4rz 2024 13:52:34 UTC schrieb Peter Maydell <peter=2Em=
aydell@linaro=2Eorg>:
>> >>> From: Richard Henderson <richard=2Ehenderson@linaro=2Eorg>
>> >>>
>> >>> If translation is disabled, the default memory type is Device, whic=
h
>> >>> requires alignment checking=2E  This is more optimally done early v=
ia
>> >>> the MemOp given to the TCG memory operation=2E
>> >>>
>> >>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>> >>> Reported-by: Idan Horowitz <idan=2Ehorowitz@gmail=2Ecom>
>> >>> Signed-off-by: Richard Henderson <richard=2Ehenderson@linaro=2Eorg>
>> >>> Message-id: 20240301204110=2E656742-6-richard=2Ehenderson@linaro=2E=
org
>> >>> Resolves: https://gitlab=2Ecom/qemu-project/qemu/-/issues/1204
>> >>> Signed-off-by: Richard Henderson <richard=2Ehenderson@linaro=2Eorg>
>> >>> Signed-off-by: Peter Maydell <peter=2Emaydell@linaro=2Eorg>
>> >>
>> >> Hi,
>> >>
>> >> This change causes an old 4=2E14=2E40 Linux kernel to panic on boot =
using the sabrelite machine:
>> >>
>> >> [snip]
>> >> Alignment trap: init (1) PC=3D0x76f1e3d4 Instr=3D0x14913004 Address=
=3D0x76f34f3e FSR 0x001
>> >> Alignment trap: init (1) PC=3D0x76f1e3d8 Instr=3D0x148c3004 Address=
=3D0x7e8492bd FSR 0x801
>> >> Alignment trap: init (1) PC=3D0x76f0dab0 Instr=3D0x6823 Address=3D0x=
7e849fbb FSR 0x001
>> >> Alignment trap: init (1) PC=3D0x76f0dab2 Instr=3D0x6864 Address=3D0x=
7e849fbf FSR 0x001
>> >> scsi 0:0:0:0: Direct-Access     QEMU     QEMU HARDDISK    2=2E5+ PQ:=
 0 ANSI: 5
>> >> fsl-asoc-card sound: ASoC: CODEC DAI sgtl5000 not registered
>> >> imx-sgtl5000 sound: ASoC: CODEC DAI sgtl5000 not registered
>> >> imx-sgtl5000 sound: snd_soc_register_card failed (-517)
>> >> Alignment trap: init (1) PC=3D0x76eac95a Instr=3D0xf8dd5015 Address=
=3D0x7e849b05 FSR 0x001
>> >> Alignment trap: not handling instruction f8dd5015 at [<76eac95a>]
>> >> Unhandled fault: alignment exception (0x001) at 0x7e849b05
>> >> pgd =3D 9c59c000
>> >> [7e849b05] *pgd=3D2c552831, *pte=3D109eb34f, *ppte=3D109eb83f
>> >> Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x000=
00007
>> >>
>> >> ---[ end Kernel panic - not syncing: Attempted to kill init! exitcod=
e=3D0x00000007
>> >>
>> >> As you can see, some alignment exceptions are handled by the kernel,=
 the last one isn't=2E I added some additional printk()'s and traced it dow=
n to this location in the kernel: <https://github=2Ecom/torvalds/linux/blob=
/v4=2E14/arch/arm/mm/alignment=2Ec#L762> which claims that ARMv6++ CPUs can=
 handle up to word-sized unaligned accesses, thus no fixup is needed=2E
>> >>
>> >> I hope that this will be sufficient for a fix=2E Let me know if you =
need any additional information=2E
>> >
>> > I'm performing a direct kernel boot=2E On real hardware, a bootloader=
 is involved which probably enables unaligned access=2E This may explain wh=
y it works there but not in QEMU any longer=2E
>> >
>> > To fix direct kernel boot, it seems as if the "built-in bootloader" w=
ould need to be adapted/extended [1]=2E Any ideas?
>>
>> I strongly suspect a kernel bug=2E  Either mmu disabled or attempting u=
naligned access on
>> pages mapped as Device instead of Normal=2E
>
>The MMU surely must be enabled by this point in guest boot=2E
>This change doesn't affect whether we do alignment checks based
>on SCTLR=2EA being set, so it's not a simple "the bootloader was
>supposed to clear that and it didn't" (besides, A=3D0 means no
>checks, so that's the default anyway)=2E So the failure is kind
>of weird=2E

I think the kernel's output indicates that the MMU is active:

  [7e849b05] *pgd=3D2c552831, *pte=3D109eb34f, *ppte=3D109eb83f

AFAIU, the value in brackets is a virtual address while the pte's are phys=
ical ones=2E Furthermore, the `info mtree` QMP command tells that the physi=
cal addresses are RAM addresses:

  0000000010000000-000000002fffffff (prio 0, ram): sabrelite=2Eram

So I think we can conclude this to be "normal memory" to speak in ARM term=
s=2E

Regarding the Linux kernel, it seems to me that it expects the unaligned a=
ccesses (up to word size) to be resolved by the hardware=2E On ARMv7 it can=
 assume this, because the SCTLR=2EU bit is always set to 1 [1]=2E It then s=
eems to only deal with cases which the hardware can't handle=2E In the case=
 above, the unhandled instruction is (output from execlog plugin):

  0, 0x76ecc95a, 0x5015f8dd, "ldr=2Ew r5, [sp, #0x15]"

Note that the correct order of the machine code is=20
0xf8dd5015=2E This is not a pattern handled by the kernel, presumably beca=
use it expects it to be handled in hardware, hence the "not handling instru=
ction xy" output=2E=20

I have the impression that real hardware only traps when the hardware can'=
t handle the unaligned access, and only when the SCTLR=2EA bit is set=2E

I'm not an ARM expert, so take this with a grain of salt=2E

Best regards,
Bernhard

[1] https://developer=2Earm=2Ecom/documentation/ddi0406/cb/Appendixes/ARMv=
6-Differences/Application-level-memory-support/Alignment


>
>-- PMM

