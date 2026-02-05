Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD23ECD991
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo2x6-0001iB-3a; Thu, 05 Feb 2026 12:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vo2x3-0001f8-S3
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:15:33 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vo2x1-0006vK-Bt
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:15:33 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-794fe16d032so10258297b3.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:15:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770311729; cv=none;
 d=google.com; s=arc-20240605;
 b=Nrk3RuoiKs6Vd2IP8RnDbtXzqmr5Lwi+OKe0arh+cMe/PTqMSGbDTeMuWO40AKhphf
 7ojfjdpTmmMjWVPB2k5SFTPoQYPR8jAobECvuprSJRvtSutBMifU6//Wx0nHoswD/Akd
 y2NStGjDqyQEKvXUAwi1UToOIag8ZhOC+FLklHpP8X2lSvmdeV4XXGOdPBJExW/GIb8I
 OXeMMH0hmTvbbla6TBu9U/H0VLzpn3rr0oxKWaaXVm0VrYSwHbIDG2d5648L3Scqjkz2
 XnxloOppDL/wSble6IFL6jnR+gcTg6VzElWesmrLu3uDEbgCIR/7MltP/IcfqSVTzFDZ
 28OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8CrqP1Cl24oKE7Od4ltNfgbmCGTYG00/dY14XKZiqf0=;
 fh=H5bEi8PWE9290/oJmDyTP8YR1ysyO7ES2ulFeqTxbpo=;
 b=lM/716AurZlzDZnWeeEo48K8Hldbc24CpluEFxS6ieZYZH4GidipTGrAJ1PXAMv2jo
 8tQhJO35qloJ0AIBlyZe2cFRR9iY5P0MEL9MkHqCi+gn+XGoxnRPbDXFh2V6lKfGi7vq
 thPm/H+7FuPNknzoSalHxQ9mu+favagHeRl9Jq1p39tQVFP5lSsTpiME2AFuUlz1Q8tS
 Qh7O3JvdV76hgsBbcoZhiHOMCFY3bzNWeNgAcoffASGfqsmrVlKE/ENmu2gk5AsE81C8
 lns5dmzjH0nuVUjrCHaaC52yNItQpB3IAQ2TmjCiSuw0QJow2Rga3+Yrje/8GeQV0Pf2
 QxAQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770311729; x=1770916529; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8CrqP1Cl24oKE7Od4ltNfgbmCGTYG00/dY14XKZiqf0=;
 b=ARLLANZS7HBl7JIM1+DueogUIIg0wG82oopOt6QRKeGuGLjJ3RKeklyGcxa+Eipj6/
 U7UifR0U1iE5WibctJPODrrYyMbfLLceB+nAxCIRjt9kP8egBJu+VRe80ry4B8NxhWp1
 7THPsCzQzyf433FSw2kcnJ8H/Dip3uy0sV0bhluxY9qJEwZaBUT8Gamwubuj+sMsyYbm
 Wl2pgGHAQofLcVoYP8Wf/s4DvuYQ6hcXt8W7rdrd7JnQb1ZUGmxhSjRkh2jDhCijUz7+
 7HgCtobVDbxpBYAjqDrHsd1qU6l4egfqIRhk3fEDgxHAu6Yqnul8VNeHbJ4iu0PF0boD
 BA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770311729; x=1770916529;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8CrqP1Cl24oKE7Od4ltNfgbmCGTYG00/dY14XKZiqf0=;
 b=a6Yg8iEawyL0fPphMTzUlAlIvkD2OgJ2A7ewiC8j43p9LiEFPN8TvN/6Deld2kjtme
 CnEFVeNELkeH4ru5EK05y5FyvQDmEoLEyZsveyNzl9xvWt0EJ0JFnP2JKM4SqSmSEV7H
 ZEOeKwSqd3WtmQPSsLtE4BoTIzr6UK0PJlvNijqOYDum9FEvLHsV23YySs58ljCN5FCe
 g9uIJMkyfB9lg1wiWNBE8RFmAyGIj/BVCQZQRD1y2kCOU+5XOiC4zBR4DYJ0UQPSaoTS
 /mXDStirvH+yhh4er4eSCPu/ptN9pJa9joctKTXhn9QZqtLZmpjlqnzu45gdbVWay31m
 wm1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR3WglajsQbRAnEDdYLX5dZwKT4jC3PAsWNGvbwQUi0UbBAq+ciZ0v8s0a8A1IMdVoweiJiV/m95Py@nongnu.org
X-Gm-Message-State: AOJu0YwDw4AUJldwVOefQYwDVXT6tfGkQPDgNYzaa/OljS/bx6LXiuP/
 xxv531rvTsqF+GujTO5tNbiOSG5cUzrm4tvaVozw6dAOV/BVq09JfZxV5FNSOB0vJi/saBo3qHd
 +FPt0fTt/NCpGbw0Vkuo1E+f9V3UeiOlF7lqTjt6IUA==
X-Gm-Gg: AZuq6aKw4UOfjyKI82/jzcM64lZn8oeJWEWkskeU3VrRmtDJxK7RsF4uz8R7qs4jPxF
 /+Klbo/Osu6URpqu7CUSfODestwDr9kETL1u81gef8JJS1M8rLD3oOIiFdtmlw+lhjKHl3kliCz
 khwfmmBI5Xi78vk8mkZnGE8CYQXnxpGMrSxQO9fXd6ZVTwzB4QO6cHIF83eO8Lb1VzK247qjHOu
 w3RL+f55AK+zjJUiSqjgQlUbxlnlQZ/S5w/9pzoUGkhNeXCKiMj0IWyDVKGkh/+7vJKFFANf9C7
 LlRx
X-Received: by 2002:a05:690c:97:b0:794:bbce:e4a0 with SMTP id
 00721157ae682-794fe70ff6amr70544567b3.24.1770311729086; Thu, 05 Feb 2026
 09:15:29 -0800 (PST)
MIME-Version: 1.0
References: <20251211102025.873506-1-me@linux.beauty>
 <CAFEAcA8FcW22-TnyBKHmFUUsR=xk2u-74uPz6KisJTeG=YWxmQ@mail.gmail.com>
 <20260205051236-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260205051236-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Feb 2026 17:15:17 +0000
X-Gm-Features: AZwV_Qghiw-LQMbU9sXqsmNvp_K457KiMnBiTAKvpnOxlu4A02bi2vOw_mwtr9w
Message-ID: <CAFEAcA-2QKtniTsLFA2ayjQ28dmQ=35r_zhkL6UBpiEOr=xGVg@mail.gmail.com>
Subject: Re: [PATCH v6] acpi/virt: suppress UART device & SPCR when guest has
 no serial hardware
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Li Chen <me@linux.beauty>, Shannon Zhao <shannon.zhaosl@gmail.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Sunil V L <sunilvl@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 qemu-arm <qemu-arm@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, 
 qemu-riscv <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Thu, 5 Feb 2026 at 10:13, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Feb 05, 2026 at 10:08:32AM +0000, Peter Maydell wrote:
> > On Thu, 11 Dec 2025 at 10:21, Li Chen <me@linux.beauty> wrote:
> > >
> > > From: Li Chen <chenl311@chinatelecom.cn>
> > >
> > > virt machines always instantiate a PL011/16550 UART at slot 0 and des=
cribe
> > > it in ACPI (DSDT and optional SPCR table). When the command line disa=
bles
> > > the serial backend (e.g. "-serial none"), the guest still sees the UA=
RT as
> > > a preferred console even though it is not usable.
> > >
> > > Teach the virt ACPI code to omit the UART device and SPCR when there =
is no
> > > serial backend attached. This matches the hardware that the guest can
> > > actually use and avoids confusing firmware or OS code that relies on =
SPCR.
> > >
> > > The bios-tables-test qtests rely on an ACPI UART node and SPCR entry =
for
> > > UEFI-based virt machines. To keep those tests working we create a UAR=
T
> > > with a "null" chardev backend instead. This preserves the ACPI tables
> > > while discarding the firmware's serial output so it does not corrupt =
the
> > > TAP stdout stream.
> > >
> > > Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > > Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> > > Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> >
> > Sorry, I must have missed this patch previously. I'm not sure that
> > this is a good idea, because it means:
> >  * the dtb version of virt and the ACPI handling diverge
> >  * we tangle up "what chardev do you want to connect serial output to"
> >    and "what UARTs does the guest see"
> >
> > If the user explicitly sends the first serial port output
> > to nowhere with "-serial none -serial stdio" they presumably
> > had a reason for that and won't be happy to find that we've
> > adjusted the ACPI tables to redirect that output to the
> > second serial port they were planning to use for something else.

> presumably, things would be different with -nodefaults?

-nodefaults doesn't generally do much on Arm boards, because
we don't have a lot of "pluggable thing that's plugged in by
default" that we would turn off -- that's more of an x86 thing.

On the virt board the UART situation is a bit complicated,
for command-line backwards compatibility reasons:

 * the first UART always exists
 * if you're emulating the security extensions, the second
   UART always exists (and is the secure-world UART)
 * otherwise, the second UART exists only if the user
   configured a second serial backend (i.e. provided
   "-serial foo -serial bar" or similar)

If I were designing it again from scratch without the
back-compat baggage, it would probably have three always-exists
UARTs, one for secure-world and two for normal-world.

thanks
-- PMM

