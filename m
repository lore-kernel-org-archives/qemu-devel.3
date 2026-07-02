Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DD8C44500
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfDrh-0000sl-SJ; Thu, 02 Jul 2026 05:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfDrg-0000s5-8Z
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 05:37:48 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfDrd-0005Sx-RY
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 05:37:48 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-664db84f074so1802397d50.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 02:37:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782985065; cv=none;
 d=google.com; s=arc-20260327;
 b=Nhhx8j6jbKrYT153J0MPMZQDJ/cJZUJoZ13Y3j8yAH8ktluFua/40TogCYGBK6bNdf
 SfrwS9B1KdinHrxxsF2G6kbioNOCV1G4zXtL1VvjH/dY+cTpFKlV047YEcmW2jeKNSXJ
 vjUCnqT6QoHkdq6YGHj1/j/oWzDyoPycRhN3lH1/a1+UXwFa/YPdZc8w+tEMzcsQfp3Y
 a/ZzUUOd3o/Wcj0njH6aLQ3g4iDjiLQWHuPRvWb7amxcqY0FSCwCXRT87e2L9g8Cy1Ec
 mXU0F/C9aVQ0Hxhc3CdOfU25XspQq/Xr9dpqRFxI1YqdMJpBvTmUqnszF4VrQW5I84tN
 KSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AtrQ9mwL3IOXQm02TskZACPvLmDZdCUNgt7U5ll7UT4=;
 fh=sIwEjK6UX2Zan/1ca0R2i9RygwtIr/0mVK4gvIlBAHE=;
 b=ppWst49n9UAYtaoJDbu0Yt9lk14u+oPLjRqu24PMcIbLWCvH9VfcVcFsA1E3h6zj5i
 dOQGEuU4kkpHqrJ7vabQqGw8EPVkKq/IFzje9pyODTdCFTUI5pxOqsE4fUjdUA4JPM55
 +nhQJmjlyuy3kot7fNdTuNaSLTyxu4Lx8uqhAElMB9OeNx4gFg//do8SizYaf+gNOQlD
 YZQMRW6iF/at8ViYfUDWQiVRnT4DckQks623wWwywKOEESf5VqN6HFK6lWViOkd61nAt
 CYgYRwY/dVG8ewvbv2PrA/jKO2SpWvqzYI4YMjUmIxPo1LK3Jtywfc19VA820mdC0GFO
 6FIA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782985065; x=1783589865; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AtrQ9mwL3IOXQm02TskZACPvLmDZdCUNgt7U5ll7UT4=;
 b=LtOBOgy3PI8dMX1NxIHQmvrK3b4QXE+GGJaCKEPphnzAAwbT0LeU52lijyr//4Cuua
 tYdX9QH84x7TJHVWCpSrVol0beh55IJhurWZN15HbCQQz3RdEaVYlXNoluNe26Rc3eyl
 GI4q6b1bTAgSf8HV7U2UUEBiQLOCjDHVhJ68aU03AbCbxeeATgp6BFVo4Ol6AsIm3X3t
 p0FNN6JcK3A/tCcE7/P6HLkogAXcNYcSb1n4fUYdj1kMt0xwY/NwDevcuRSbDESHFcZH
 gcqtrCjbJVOqd/vdm7wG2xaoX/bMDbeZzQiKmx9g2RwOAh03v9cpxyo0abNNa+OqcxIE
 9Idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782985065; x=1783589865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AtrQ9mwL3IOXQm02TskZACPvLmDZdCUNgt7U5ll7UT4=;
 b=XFx8xN2KvCw9gNPWgk4gxXOlXnZeit0H4PD8IBSSTZa3PA3OndIjnjRkJjqxv7GV76
 sXNRzr6XwXgmciu8BDkBn/d4HJS9pl6q2aIVsi0E8m5boHeeLT78r1y94pjAzjSZTgOQ
 eDxXtZ8tsJhXgeD1J3tDk7PVfoRfTOir8d5UMQjiKJSIUsaQdzAbw+sr47Fr7q0cdWfB
 S22LiBcSLbJ93ZgimfGwR4eyxfsxttOvZ0iRWY4EBgOVED7al+OLxpn3iQs6x1fPGlmH
 YHVCg+sOh1NqVJK+NPK6CNT/IKrJoqWZgvcfhJXks3j3WHRO97tGJhIeF/fkxjK8FPW/
 FRFg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro2ubzxwSZiiCvAz5oEB2RXfalh5ETQKDgmEmdcW6UM0qgIe/IJQjczxqv2kMo6G9maKaR2q3eZgaj0@nongnu.org
X-Gm-Message-State: AOJu0YxF1ClBvj7fh4sRjty9Dsvm8SOW+6lSNeT875XOp1P/Ittd/F54
 +oBunUVcpsfwf4t8ftzJasWISxajkfCeJGBcRDzl0HvqBPXch8JNcV+jmQwfLhh2ls/5B/3PGeH
 eCyFyosPMqhV7JEF+fvHe0kJagKUN/gL5nwxlk2yMmA==
X-Gm-Gg: AfdE7cmAN3t9cK6W4QhpfIJQTGwW2y4n9gQlZIJFGo/bdVg9lkQD661c12H6DDlxoim
 rQq4BaH1PipWsC6tm04HnpIvOuIKC8oZIsolBymUl818kbS5Xli8Mil3TpenQJd0ZOf+vtOuMeW
 fC83FuIlujkKLoycxPNF90JEKrlqXfzXt+AfPEH/382a7Cf7rvr2x6MOAJuUFL74xiXrYWa76nU
 KfdMOFGMsa7yz8ZYrnkMAJshcSClZLYBbAZHxdskN0MKwoRob3rsl42NUVepn7Hkvbssmdq33Ei
 M/YVi+ZrIC25GPXNrkxn+X17snTs0Z3zBUDB/bd/G+4bS0/bTY7c5DtY
X-Received: by 2002:a05:690e:1182:b0:664:e2f4:52b9 with SMTP id
 956f58d0204a3-66521ad0e00mr5620015d50.28.1782985063698; Thu, 02 Jul 2026
 02:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260701231224.106850-1-heinrich.schuchardt@canonical.com>
 <CAFEAcA9Y1Mfsdn=tQXA=QJqa14JbjhnexPhnem1oi9vyeDPVpQ@mail.gmail.com>
 <0111db84-e090-4ea5-8c15-0e9623c9c064@canonical.com>
In-Reply-To: <0111db84-e090-4ea5-8c15-0e9623c9c064@canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Jul 2026 10:37:31 +0100
X-Gm-Features: AVVi8CfcJO5ooGUfdjKWY3gfpJmm-KcQy9DcfC1dw25oEk1Ykyb0ZKR2ghTbMN4
Message-ID: <CAFEAcA_TVJ_kEutVXZAuOmv0TQz0jmZ++AqQMtrzb3=_FhoRTg@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/arm/virt: define initial aarch64 TCG CPU
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Thu, 2 Jul 2026 at 10:28, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 7/2/26 11:05, Peter Maydell wrote:
> > On Thu, 2 Jul 2026 at 00:12, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> Function virt_get_default_cpu_type() is meant to return the default CPU
> >> type. But for aarch64 TCG it returns cortex-a15 which is a 32-bit CPU.
> >> This results in failures to boot if no specific CPU is required by
> >> the command line.
> >>
> >> Return neoverse-v1 as default aarch64 TCG CPU. This is the aarch64 CPU
> >> with richest feature set.
> >
> > The default CPU type for the "virt" board is the way it is
> > for command line backwards compatibility: people may have
> > existing command lines that this change would break.
> >
> > I agree that for most people "cortex-a15" is not what they want;
> > the underlying principle we were trying to follow at the time was
> > "any command line that works with qemu-system-arm should work and
> > do the same thing under qemu-system-aarch64". So the virt board
> > has the same default CPU for both qemu-system-arm and qemu-system-aarch64.
> >
> > If we were going to change the default, I would probably suggest
> > using "max". Picking any particular fixed CPU model name is a bad
> > idea, because (a) it won't work with KVM and (b) in five years
> > time that particular CPU model will be an old and out of date one,
> > and we'll find we still need to tell people "you should specify
> > a CPU type because the default doesn't have XYZ features".

> Using 'max' as default for aarch64 would be fine me. This would work
> both for TCG and KVM.
>
> I last encountered the issue when running a VM via virt-managers. We
> cannot expect the default desktop user to know what CPU they have to
> choose to run an arm64.

Unfortunately the user rather does have to know this kind
of thing, in the same way that they need to know which
machine type to specify. The x86 architecture is a weird
special case where essentially everything looks like a PC
and defaults are workable. For other architectures
we've tended to find that isn't the case. More generally, if
you're executing QEMU directly there are a lot of command line
options that are not default but might be either necessary,
important for performance, or important for security hardening.

For a more "user-friendly" experience, users should run QEMU
via a management-layer app (e.g. virt-manager). That layer can
then pick what it considers to be reasonable defaults.

> If a user runs qemu-system-aarch64, that is typically not for running
> 32bit software but 64bit one. A user wanting cortex-a15 here is not a
> very likely use case to me.

I agree, but it's hard to tell what command lines users are
using out in the wild.

> Changing the default does not have an impact on existing users of 64bit
> software as they are used to specifying a CPU which will override the
> changed default.
>
> Please, indicate how to proceed.

I don't think we're going to change QEMU's behaviour here at this point:
it's been like this ever since we added aarch64 support to the virt
machine type.

-- PMM

