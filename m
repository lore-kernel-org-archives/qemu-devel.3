Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D01C5CFEE
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 22:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtZ4P-0007Ti-RW; Fri, 20 Feb 2026 17:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vtZ4O-0007T2-7S
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 17:33:56 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vtZ4M-0003aw-4e
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 17:33:55 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-5033b64256dso153171cf.0
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 14:33:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771626832; cv=none;
 d=google.com; s=arc-20240605;
 b=gl+Enu+zOn1wwM+OvR5T8zG5eRJmwuLt4NY8Icjt3JO8LGvm/yyuF+HpJOZyv+eBwI
 nOAFJFe7oL1Dut/GKg1ZwlX4o8nHY0spc5xJcrXZp2ql1tSsNBcQJ+D8gp+9fuamn+mF
 B7xmas6f9IdWyYFpizh6Od7l8OwThJlwImAMKirAUH3vUsmjdOQLq8yoYWrPPmh7/rAZ
 dG+SlVAbg8PAcP6fQPHBObv1+xk2gc7ZyftkQOhQ3hfbU+YyzUHH6xTfAz+3LAMYEJa9
 7sfrpu/DcTEWAGsQS8HYQxHgyApq1klBengjkW1g4WtA+ALlx0CZIU3XxLL1efl4LeYM
 ENSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NpMwIVhd5+vz4L/0est76hwcSKw/W12tvNn/DkHqdSY=;
 fh=Hn3gmtPzzQHQCzxmVzeEyEjwrfe9EsZTGRcdadGMzeY=;
 b=IptZwaAZchW6kLTw9U4aQa57IgfRuNLZ3Yyb9uMq6Z1QBO6vbKQ11gHeXrmb0+zo1t
 iBJAwVJAMZDw0e+g9ggbibPCUVSgPB+Chg8Z0H7Fft6YFN+r2xpIUmQX4LNV8oNGCQAW
 1sDb5YR208uTKmeO7p+uu90gAvaO0J2dAvPFpZcFXG11l2KQYswGAJw/ddGHTGRC2ofj
 l/sJx/Q2tMQUeBaTG4nZmKkKgCgvBlQlnbZmAaICmLJ9FgIiW//7ptlbDK1+R4/6iRpN
 TdTsGLUqquDeLTvkZkBdTxyQT3aQHJcSTxH3gglgSkN1uPbhDX2s0QOEjprPbFL9woQZ
 UIww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1771626832; x=1772231632; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NpMwIVhd5+vz4L/0est76hwcSKw/W12tvNn/DkHqdSY=;
 b=IAoSyTGdNBFuUPdGBrnOxjLvJGBaJu2PiAAVw2wc1GoGWhvY0/IDoIZ1DT6P8lBsN9
 ob0n6DSl/TqwKqXTnVpuZKTcfd0VrqFCcYb7qQ2lWoidEh+yPjM94x2ITBGb1s3HbDz4
 wDijdrQj/o4ZSZjeL0AuLffh6YQajmkuCxx2zxxFF98Pno5ijTY7jNwaHDirQtS7qiK+
 9AaHzVDdIiRrdm6AK7ujqXKou/PchEpcSHlPkiy71rMdFG/8CRITZO6Q6EuZqAQZ7Hkc
 caM1Tsm/345TEd/Y0cP1zRdUVy7PWipKHUSNfGgUg85NRLJ/U16Hutz0adQEYK8nkenR
 pdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771626832; x=1772231632;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NpMwIVhd5+vz4L/0est76hwcSKw/W12tvNn/DkHqdSY=;
 b=XlszxKrUVI+DmZdzOzKBLO47xSEMOjnC6aafopc2DbfsTrQaI0hoqP4BI6tAnKBS+9
 xhPj78LKbqaq28aQbH7z8Xn9jHfxTZ9S1LK6D2VW7F8fe/LiexD6moqtYy4cfG1jD07P
 +dvY0XJCfTfPAPz3YklOLdk8zqWYtoZ31HaFr8XzFQ5jPq/Gu43ImX4/1RDsgzLTJTBQ
 4y06tyHSlopsksMeI3bIvELpP0/Ud+R23FmqvUa+Ne+dmg4G9tTw00Skhoww6zXFUO/l
 RpEr+lHG0SB3DzGphcW6DMLNlMcphWezSyWwizkaPdHtQH889iPiDsmYz5nCT0JmmzNc
 V2GQ==
X-Gm-Message-State: AOJu0YyOj/aqgeecypy/QrinZlcfnZK5lNGoAc1yTPEVBRXxhrCF26Kv
 rcr0JSNlDUdn60+1+OffnyEpYw1rPC9zEHc80ded09vkW9CZnOTqGC3OfCrLFfHF4jx5HLGFyeP
 KQ1yP6HUHwibyiNmtf+qQ+rzOEwFbdSOtnhp4ahln
X-Gm-Gg: AZuq6aIwr+wbgucW//X04v5kl8RkeM3DegVPZ9WURIaZRKW4xhZbe5CVosbeTX2AY53
 zj/HWPr4QAjNKj+JTULfWp1ODTA4r/R7NXKrBm2AG1upg0lMqx2HyD5V5ebtwy0/s8GjE2i0B1k
 kVr1YNLx8qZ5KrhMxJW872m1QHkTCvQBWVX8b0MrsSmzGBz69CVWbGD5g5M1PYeOn1EzMQsX6CQ
 9oIf62dClzthGZhB8LKoo2i2Lg83j2TapqJbjST3GqGXInDpXY86SUWbbR0cRgWKbuHD3wx+9ef
 QOGQ/TnDuoWuVqiKFv38A7ijHQib/MRVchJfeUHKYrMREGT0xQXo135VH4YDJeQ9KP7UnntDoty
 +TLnwbfTL6efmprqEZmJS8ZueMTf02lMyNwQ8
X-Received: by 2002:a05:622a:3cd:b0:506:9852:75ec with SMTP id
 d75a77b69052e-5070e894abemr1205331cf.9.1771626831783; Fri, 20 Feb 2026
 14:33:51 -0800 (PST)
MIME-Version: 1.0
References: <177159976712.8279.7732381632410882915-0@git.sr.ht>
In-Reply-To: <177159976712.8279.7732381632410882915-0@git.sr.ht>
From: Nabih Estefan <nabihestefan@google.com>
Date: Fri, 20 Feb 2026 14:33:40 -0800
X-Gm-Features: AaiRm53Z0_-0kztteF_H5IU6_oL5wcazMiaH6OQTYuZCeF0SCxtNXELbTnaBqUw
Message-ID: <CA+QoejUzhhmzZDJQfAL=-K++je2R-sxUOkO1KBRCzr+YVkm3UA@mail.gmail.com>
Subject: Re: [PATCH qemu 00/11] Introduce ot-earlgrey machine, and one
 peripheral for it (alert handler)
To: "~lexbaileylowrisc" <lex.bailey@lowrisc.org>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 lowRISC <qemu-maintainers@lowrisc.org>,
 Amit Kumar-Hermosillo <amitkh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x832.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hey Lex!

For some reason it looks like your patches are all dated to 2023,
probably the original date of the change made. Besides that, it looks
like its not on top of the master branch so they don't apply cleanly
when I try to pull them down (the two quick culprits I saw are the
hw/core/* files that got moved to be just under hw/*, and a
mips_csr_list[] in patchset 4 that doesn't seem to exist upstream. Can
you rebase these onto HEAD and send the patchset again? The date on
the patches also means that tools pile patchwork have immediately
marked them as archived since they are over two years old from its PoV
(https://patchwork.kernel.org/project/qemu-devel/list/?series=3D1055948&sta=
te=3D%2A&archive=3Dboth)

You'll also want to add your own Signed-off-by tag to the patches,
some seem to be missing it.

Thanks!
Nabih

Nabih Estefan (he/him) |  Software Engineer |   nabihestefan@google.com



On Fri, Feb 20, 2026 at 7:02=E2=80=AFAM ~lexbaileylowrisc
<lexbaileylowrisc@git.sr.ht> wrote:
>
> This is the start of efforts to contribute code from the lowRISC fork of
> QEMU to bring the QEMU support for OpenTitan machines in line with Earl
> Grey
> 1.0 by adding a new machine called ot-earlgrey. This work was done by
> Emmanuel Blot and Lo=C3=AFc Lefort from Rivos, and various people at lowR=
ISC.
> This patch set in particular adds the basic machine definition, Ibex-
> related changes, and one of the peripherals required for it: the alert
> handler device.
>
> I previously emailed asking for advice on how to test our changes in a
> way that is acceptable upstream, and how best to submit such a large set
> of changes,
> if anyone has more thoughts on that, please do reply to that email.
> (https://lists.nongnu.org/archive/html/qemu-riscv/2026-02/msg00139.html)
> There's lots more commits to come, I don't want to dump too much on the
> mailing list all at once. For now this is a small first step.
>
> This patch set should give a flavour of the style of what's to come, and
> I'm expecting there will be some changes required. We'd just like to
> understand what will be needed to make this acceptable as soon as we can
> before we try to upstream lots more of these changes.
>
> In particular, most of our new peripheral blocks are currently in the
> directory called hw/opentitan. In our fork we have about 60 blocks in
> this directory, we have put them there to keep them organised as
> opentitan-specific blocks. Is this a suitable place for them? would you
> prefer a different structure?
>
> Thanks!
>
> Emmanuel Blot (10):
>   [ot] target/riscv: rename ibex hart as lowrisc-ibex
>   [ot] hw/char, hw/timer, hw/ssi: fix device definitions
>   [ot] hw/riscv: add helper for Ibex platforms
>   [ot] target/riscv: implement custom LowRisc Ibex CSRs
>   [ot] target/riscv: add custom mtvec CSR management
>   [ot] target/riscv, hw/riscv: add basic OpenTitan EarlGrey machine
>   [ot] target/riscv: add support for impl-defined initial PMP config
>   [ot] hw/riscv: ot_earlgrey: add HW PMP configuration
>   [ot] hw/riscv: add an IRQ wrapper
>   [ot] hw/riscv, hw/opentitan: add Opentitan Alert handler device
>
> Lo=C3=AFc Lefort (1):
>   [ot] hw/opentitan: add OpenTitan shadow register helpers
>
>  MAINTAINERS                       |  21 +-
>  hmp-commands-info.hx              |  12 +
>  hw/Kconfig                        |   3 +
>  hw/char/Kconfig                   |   3 +
>  hw/char/meson.build               |   2 +-
>  hw/meson.build                    |   1 +
>  hw/opentitan/Kconfig              |   4 +
>  hw/opentitan/meson.build          |   3 +
>  hw/opentitan/ot_alert.c           | 668 +++++++++++++++++++++++
>  hw/opentitan/trace-events         |   6 +
>  hw/opentitan/trace.h              |   2 +
>  hw/riscv/Kconfig                  |  14 +
>  hw/riscv/ibex_common.c            | 316 +++++++++++
>  hw/riscv/meson.build              |   2 +
>  hw/riscv/opentitan.c              |  30 +-
>  hw/riscv/ot_earlgrey.c            | 851 ++++++++++++++++++++++++++++++
>  hw/ssi/Kconfig                    |   4 +
>  hw/ssi/meson.build                |   2 +-
>  hw/timer/Kconfig                  |   3 +
>  hw/timer/ibex_timer.c             |   2 +-
>  hw/timer/meson.build              |   2 +-
>  include/hw/opentitan/ot_alert.h   |  23 +
>  include/hw/opentitan/ot_common.h  |  93 ++++
>  include/hw/riscv/ibex_common.h    | 322 +++++++++++
>  include/hw/riscv/ibex_irq.h       |  69 +++
>  include/hw/riscv/opentitan.h      |   4 +-
>  include/hw/riscv/ot_earlgrey.h    |  27 +
>  meson.build                       |   1 +
>  target/riscv/cpu-qom.h            |   4 +-
>  target/riscv/cpu.c                |  40 +-
>  target/riscv/cpu.h                |   7 +
>  target/riscv/cpu_cfg_fields.h.inc |   7 +
>  target/riscv/ibex_csr.c           | 115 ++++
>  target/riscv/meson.build          |   1 +
>  34 files changed, 2641 insertions(+), 23 deletions(-)
>  create mode 100644 hw/opentitan/Kconfig
>  create mode 100644 hw/opentitan/meson.build
>  create mode 100644 hw/opentitan/ot_alert.c
>  create mode 100644 hw/opentitan/trace-events
>  create mode 100644 hw/opentitan/trace.h
>  create mode 100644 hw/riscv/ibex_common.c
>  create mode 100644 hw/riscv/ot_earlgrey.c
>  create mode 100644 include/hw/opentitan/ot_alert.h
>  create mode 100644 include/hw/opentitan/ot_common.h
>  create mode 100644 include/hw/riscv/ibex_common.h
>  create mode 100644 include/hw/riscv/ibex_irq.h
>  create mode 100644 include/hw/riscv/ot_earlgrey.h
>  create mode 100644 target/riscv/ibex_csr.c
>
> --
> 2.49.1

