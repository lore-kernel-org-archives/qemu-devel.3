Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508ABCA600D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 18:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEsvt-0003Kp-99; Thu, 08 Oct 2026 14:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEsvr-0003KU-BN
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 14:33:31 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEsvp-0003ys-Dv
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 14:33:31 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6a601ba6870so9476545a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 11:33:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791484408; cv=none;
 d=google.com; s=arc-20260327;
 b=NbsOpptpAAxrFhz90dPEV+ktuGxHPcbTKdb7G/Lufc0SE9Pa3u4vkTFuxrE2qb3Qh9
 wOtbf4EFQ4Whdi/c15qlP8b0SLqln/zaM7DVIuQIWMEEJZzok0/eNqcG/aSl/mKO2rwN
 +ayHo6pa3QNhiphUMpSLLWeE8cGqAWXRo5szF3PVl4tzpwwQvPG8OeUIW9gUXxHm8yiV
 U43B6MwlryX2lJgffNPtUUELzG1dNXCJF3XNcA1ojlsKXbu1USI3qtF4ydmZ69icWe+Y
 2hMfDPTUPaKYqMA3zuVQPmymMUW8jJHdnkIahUcpipzji4XxEMBjby1Msx08k8yLPGUK
 ba9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=rmkbxQa0rdh+Tjjr/LjUtUecl6uqExJEPQ0OgA0qH4k=;
 fh=OKXZV+cJWBRaR/2WjFOwM1WdVezyE16CZJkjEXXaX9I=;
 b=kwGN9Sug+/uYqSeUqJiP9sgheTPC3aXZRbKxaF2aGSPqsyZFHND52CYNogMDBWnLrE
 7iaTzvBy2prEmuyDDIgRL+GCTKdEdmnZ/n+WZzH2ewUY9dsdiqhKiGOuFCuT4w1H89cT
 rIycMxWwJLMBaGmtfZ/lr/CVHIK/CbJncg6I+5tc9e0+hE8YlkxKc1E+7mBpaakSjMgR
 ukAViiaQvxP3DCpKTZ+FM3ZaIecWvR69CYagHa8mqQV3xDQmhrm+oiVubLJ70saPyOrQ
 kVXVQPYz4wsBh4Z3dn+F2CZRdAnfKnm3VeMpve311pL1Q2dcDtMXXmyLJQO9D7SjvI07
 tHqA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791484408; x=1792089208; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rmkbxQa0rdh+Tjjr/LjUtUecl6uqExJEPQ0OgA0qH4k=;
 b=Gc+/WJ/25EaHCxHFL5dUQ5Slgk0LZRisycNbJBjBDXFyJQkCxFy+9U9FGpLhm/EWTl
 hPafJvN1zz6G+4BgJpeSawpUNXakrpZ3BqIjJ7X+OIgSw3QfLXuHsQYtA/tHvC3OMdOX
 BiaWJxA413pwph37ER6YfI1HN+BrQk+HvC7y+IIDSrXvRLs8GZeJuYbLaOHFntMYL1ZL
 GbpSHBrJOh2RLj168ezKs2gXG5Cjm9OGsVJE0eDWy6b+rDAaLYZxTeqfCNw0carAQkm5
 3Zea0rbEkt0Fnblxb0+E5V11iQGhEqr8hAZavuKRc3lWmuQtiNT27otUEAATvBqdccxT
 YTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791484408; x=1792089208;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rmkbxQa0rdh+Tjjr/LjUtUecl6uqExJEPQ0OgA0qH4k=;
 b=l+gGe9l4SUNnz0CMeCqjCrku+yylEaRBkGtEUxtlRIGY4tqiC44AxrH9ml9Z6+YYoC
 n6ojzBg/7k+a/6WghMyOG90dYXGn3AmP7ja5GVuz7hd7sCgG2qdKkheIIhawOwQe6gol
 OsurwzOpx5sYp3tIrPgIYjoVmhSphP+PBHu+xITkdvzh4Z3FEsBw0+DnnfYReBEysxiZ
 CwWgP+7ru1Wgra8aT/cfZCt8sDz0QaTMpaYfclwBA7NnQeEo/MGvSX2A+5D+U0ztOAtc
 AjlEwZAXzMA5vJ0pEHEJtgVGU6Y5AUOZeAq3/wI5LFQmH5q6f8+at+wU5p1+5qZHWk8N
 eSRA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrw5thRAMx7BPS7b41uNiHZkfnFx8Xz4buYv9hHy5lkGPzeKZMipGKnRvBzcKQFEg6JTnzEENrP/vo@nongnu.org
X-Gm-Message-State: AFq9FYKDSuAomj4hHHaSIMtbPDebT4dXY0IE4+A6WUHIvqkh2HVrwqy7
 /xHcDJIiSCGgrxvDOxVtOskUB+nBBEW2PHMYXhVbvpsQW/62dR+aqEvbNBo3bMF7Buh1o6u9RWY
 6JVlCexTQ9SXV7Zs7asYqGBP70YF7l3w=
X-Gm-Gg: AYBFou0pKjMmqXX8CI+wHQBx0dcwLqm1xOHL/D8t2HZ0fZTbhhHpzMc8z6bBMGemYIk
 WQHFjw7DffKkkwJXD6PeEEKUHwVG9ddINcMJs5vT0V5qxMaVqfEgkaSmlvdGsYwFIWbz5OGRAhb
 JF4stsXJ2oZeUNmrylNJNVT8hQ19LGW7zo7C51lEPKSLesmVv5WfP/U6ObIN6ZUQtIbDkEARO3Z
 OgOxQYNyWiXCDUm1s//efSZtx0Qn1mhyM5pIEB+P00jRRo7iXsKGySx39gFqZxnlAbwUaKjZs6P
 VYoN9+8sjQwBu2Q8TvLszYn/F2E+Xs84Q5JrIi3nS+uXJfVyCKUsAi8=
X-Received: by 2002:a05:6402:50c7:b0:6af:bc82:e126 with SMTP id
 4fb4d7f45d1cf-6aff47e145bmr5995886a12.44.1791484407522; Thu, 08 Oct 2026
 11:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <20261007115253.328-9-luoyonggang@gmail.com>
 <7fc0d377-a994-41f4-aa98-7ed56db11447@oss.qualcomm.com>
 <CAE2XoE8K+3e8h6H9NrPk1WWMmJfG807bN_Kh5qje-5pKWUUg5w@mail.gmail.com>
 <b2d89a92-0197-4873-b4ea-75bb21c0d0ae@oss.qualcomm.com>
 <asdkF80SJzF2W3sD@redhat.com>
 <CAE2XoE-Vc+CaE-3FerW3eXtTgspwxZJ6ZT0CZyg3ZYpoJ8xYXw@mail.gmail.com>
 <98644e74-9219-42f0-bcf7-8cd7f02353af@oss.qualcomm.com>
 <CAE2XoE8qSVczu5R1HTwOV+PhPo7_wWzB=KSqhJroqbgcP5GDRQ@mail.gmail.com>
 <8c3e6104-f59c-42d9-949a-1f0c7c8dd567@oss.qualcomm.com>
In-Reply-To: <8c3e6104-f59c-42d9-949a-1f0c7c8dd567@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 9 Oct 2026 02:33:14 +0800
X-Gm-Features: AclHuK_G8Ryd0GxxqOeqsNJclc40M0YyQ3v710iK7vUlSdasODBiP_K5QC0eH-8
Message-ID: <CAE2XoE9b3BW4+m_7o=C9wxk76wTE+aF0eJf91R5oQxhTMNiJ6A@mail.gmail.com>
Subject: Re: [PATCH 8/8] qom: pass TargetInfo to is_available for later use
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Stafford Horne <shorne@gmail.com>,
 qemu-arm@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Steven Lee <steven_lee@aspeedtech.com>, Alexander Bulekov <alxndr@bu.edu>, 
 Darren Kenny <darren.kenny@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x535.google.com
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 9, 2026 at 2:27=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/8/2026 10:04 AM, Yonggang Luo wrote:
> > On Fri, Oct 9, 2026 at 12:01=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 10/8/2026 2:56 AM, Yonggang Luo wrote:
> >>>>> How about letting machines (and machines only first), have a new fi=
eld
> >>>>> 'targets', being a uint32_t mask with an array of EMU_TARGET?
> >>>>> machine->targets =3D EMU_TARGET_X | EMU_TARGET_Y;
> >>>
> >>> To be explicit state what, I give you a pseudo code to compute
> >>> machine->targets from TypeInfo::is_available(TargetInfo*)
> >>> let targets=3D0
> >>> foreach ti of TargetInfo list:
> >>>    if (machine::TypeImpl::is_avaible(ti))
> >>>          targets |=3D 1 << ti->target_arch
> >>>    fi
> >>> endif
> >>> So they basically have equivalent effect, and is_available will handl=
e
> >>> other code-needed condition properly such as
> >>> CPU/AccelClass. not restrict to targets, we can also attach the
> >>> KConfig into TargetInfo, so is_available(TargetInfo*)
> >>> also works for Kconfig. that's why I insist this way, it's solved all
> >>> the issues around.
> >>>
> >>> so  machine->targets =3D EMU_TARGET_X | EMU_TARGET_Y; is a good idea,
> >>> and it can be implemented with TypeInfo::is_available(TargetInfo*)
> >>> without much burden. and targets can be saved into a (machine or
> >>> TypeImpl) for fast access when needed, we can compute it
> >>> when the program starts.
> >>>
> >>
> >> In what we described, there is no need to keep any kind of callback,
> >> targets field is sufficient to filter any type declaratively.
> >>
> >> For the KConfig related types, I would really be keen to leave that
> >> available for now, and add a proper error message later.
> >
> > Thanks, much clearer now, I was working for full KConfig related types =
support
> > because I am trying to keep qemu-system-$arch to be a symlink to qemu-s=
ystem
> > which will still work without breaking anything. If we do not keep this=
 then
> > I machine::targets or TypeInfo::targets would be the best solution, I t=
hink
> > TypeInfo::targets is better, and copy it into TypeImpl::targets. and gi=
ve a API
> > to retrieve it, for example:
> > uint64_t *object_class_get_targets(ObjectClass *klass);
> >
>
> We can exclude the goal to replace existing binaries with a symlink for n=
ow.
>
> Please do not add this to TypeInfo, but to MachineClass instead, as
> explained in previous email.

I didn't see any simple way to do this, and don't know how, I am sorry.
MachineClass init procedure is scattered, how would that be? I am
afraid I am not
able to get this done. If you can give some prepare work would be appreciat=
ed

> If you want to reduce upcoming frustration, I would really recommend you
> stick to this, and to a single machine to start. So we can validate the
> series, review it, and then you can iterate.
>  > Add "targets" struct members as TypeInfo::targets and
> TypeImpl::targets, and
> > copy from TypeInfo into TypeImpl for later access with
> > object_class_get_targets
> > Then we can use it for filtering machines and cpus without burden.
> >
> > How to dealt with
> > https://lore.kernel.org/qemu-devel/20261007-rv-dedup-v2-6-8a2f0f296a7f@=
rev.ng/
> >
> > It's using is_available.
> >
>
> .targets field can be conditioned by ifdef for config vs user, since
> what we have everything needed in build system allows to duplicate
> objects between user and system.
>
> #ifdef CONFIG_USER_ONLY
>  .targets =3D ...
> #else
>  .targets =3D ...
> #endif
>
> If that's not enough, it means the type has to be duplicated in some
> ways to resolve ambiguity (especially for 32 vs 64 bits variants).
>
> > Maybe all using the way like
> > Subject: [PATCH v2 07/18] target/riscv: Runtime register MAX and BARE C=
PUs
> > https://lore.kernel.org/qemu-devel/20261007-rv-dedup-v2-7-8a2f0f296a7f@=
rev.ng/
>
> I would invite you to focus on a *single* machine first. See how to
> declare it, and how to query which target it supports. Then we can see
> what works/doesn't work, and (in a future series) we can do the same
> thing for cpus.
>
> You'll see that this iterative approach works much better than sending
> huge series. You have my word I'll be reactive and present to help
> continue this effort.
>
> Regards,
> Pierrick



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

