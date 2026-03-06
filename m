Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9124EFCB61C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXXz-0004u5-OB; Fri, 06 Mar 2026 10:57:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyXXw-0004tG-Vk
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:57:01 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyXXu-0003Ym-WB
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:57:00 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64ca6595c8aso9168852d50.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:56:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772812617; cv=none;
 d=google.com; s=arc-20240605;
 b=KM0QATUzCUV9G8Dj4GkSAML7HM7Q0p8DI9RhJfQjWbHQmcdOY7tWRcYfuZRx3B/nBX
 aMDiG6YaEmHIAU2IO9lApZUVLTVq/HdPhHm9WawZUYE+A39Cztl5ERYY4QJ8gygo4zra
 oW+IY2sEwlZzkuTMbH/UklQo105YIq78GiRKDNP4sUss+a5i8/0lJgS7S6aRCsS8hthp
 Abic+8o/pP255i9AbBsIwKEJxTBkVN31YSzZpDNtdJobA4csj7qXu1GeCSRGTsmE1f3Z
 tk6zAezFvsq2Hcy4z7HdRlrjsITU50m+8WLk0ekEyvrb0+hk8COtaZgYxomX7y79q+2A
 oipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TI86w47GcBsT+8qlk2zMPDGXUsmClK0NLen5N7Y5DTg=;
 fh=JUJTi+yVGqpXejgGPYn7Ex8vz6madWbEBO6gDq2eioQ=;
 b=CxvgUWohxnaAxsFqC4cBvp3TWOqZ2EJCvk/pjcwR0VmRgAoU98zvcEadsdNXnE/1Re
 bEiIWx5ULM/wmESxxmTyJB1emXKaM6E5i7pmQvQlAxroGLXF/uymZiOBuRVbIvSttmEe
 c6DIxXHsD+FLdtUve+UZXnLq9po1s9adBQkQYGg4QTIl8nAOSKd4qE8msyASl38Ce67M
 /nYjsdYdcHhBPgF3UJLz7DR0gk8ooQmomJUBlAaouNmRt0zQ+Z7g5UhNzHfH5Kc7Ryu/
 mJShroaanb74dYKy89xmwLFW9B74CUZlZOWOS5dwcdzR4/SRbifMaPPxWCTOC7bIjVQ8
 Qflg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772812617; x=1773417417; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TI86w47GcBsT+8qlk2zMPDGXUsmClK0NLen5N7Y5DTg=;
 b=UET4chjcDV8v91Sr8IhrNNRJ6D2J/oGjQus2Zk098SCpOPb0XsZjWCqA5VxjN5uct2
 4Cg+GWzu6HeBlJP8m/VQi6N6fv7lEJeyNI62njacbiOO2GuMqTZQDGdEfA23sv7Ox3S/
 16PmUCdv/YpBH3XVrR2IrjCOVQx0I8C+Gx1xIeZZRy0eMEIA/XjL24hdQ9YKoazTveYt
 mTbNZ9f4PfJJCefLoZyGhxWBij7+BqzIIbWyHqkMyG/JjJfYyDg1VLMxJYzH4vz9J+Oc
 e7PqOi4y2zQXZY7y6OwyFy5GtpK8ClQymEMja1aN0fUguCQYV9xpWAhvA0X5MiZ6E+vO
 bKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772812617; x=1773417417;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TI86w47GcBsT+8qlk2zMPDGXUsmClK0NLen5N7Y5DTg=;
 b=W9LCPHEhxnakMi0znWVpbAcPo9pxakuaO9y7SRxCjgT1rVk3Jvx1WkTzZTaBMCW4jr
 FGZvJ8/ZNkLfmKzPMXRniSRC7pk8zVO8V/G0rYuy9qytCsi8ASUGkcPF6+nymziVMaxy
 s0oa7LqUs6R6zc/UOLi/Iaqdkw3eH1oH0wKSR5XCpuPGUWF//5PArPiqRk4YNPiVl4KU
 JdFAsC9rlEujnibjH7sR+N7vRvsOyh4rl4Txr8kei2wSm7U01I27UyOK+hdoD7Gcdj2b
 dlSsAq9LGKTPxgbbbVCFMGH97vY9eUIbbEYAYlnCTB8GRqaOJ04sBF2Pyq4t7ia2i+yV
 UVEQ==
X-Gm-Message-State: AOJu0YxinZ4MvF+hrL5hcTDn0tMWJC7SPAdcpRGVPW/enXPbgJpRoYJT
 yqFXJuSKsFuXl4rpTbJqHz6XOl7CSIUm5XMIcT0WcylRbo7cnfJeJesDDB6Vl9XmPlU/mdjOOa9
 kw9aq6e1TEU6xFs0iEoSiAH1RrgUpWOTN8/kJqqpmpyJtjzrZVjp+vN8=
X-Gm-Gg: ATEYQzzahpVarIAHkpDlT9vFgf4Dopvf+/phIv+sZhQJNrzt6wnrZ2ZqbHj4cQqt6nV
 GzQMyaeTy2ChJd6RUmOBHX5fY3dlA5bicRxAq/2KhA/9LaJ9+IPdGQyFQheyfPSGn4faZFvibRL
 64eGGz86muivBMjZ81SGC2MYQIAIP1uhJOyyBjzF3lyhlEzruqQXnO6s9GZlNY9tGOI2C6z4fQX
 KJDeBsp2W1EdeVElYJxBSNJOR7+Y1KPFLEzn6XHLYfuGuf9AKdYiHWBhvl4fkBHcB4pyU6/mcwc
 /Kmoe8rq0N4H9zxP2W7eEjvt2BANiXEODmuyuiFR+pgGbWQlDjIYkvniM1nSP5BuHPw=
X-Received: by 2002:a05:690e:1286:b0:64c:a0c6:da93 with SMTP id
 956f58d0204a3-64d1414c6damr2365243d50.28.1772812616732; Fri, 06 Mar 2026
 07:56:56 -0800 (PST)
MIME-Version: 1.0
References: <20260306130107.35359-1-mohamed@unpredictable.fr>
 <CAFEAcA-e4GZB_TRG7Jm3O-RNJneUtk_WufiXNn6=UDHsgG4kdw@mail.gmail.com>
 <CAFEAcA8gB-36c1TvJSwJ0MkVMy5z_dqKpVY7KTJ-cMV5rAX1_w@mail.gmail.com>
 <83E62271-E3F8-432E-8499-D1D8D065B162@unpredictable.fr>
In-Reply-To: <83E62271-E3F8-432E-8499-D1D8D065B162@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 15:56:45 +0000
X-Gm-Features: AaiRm51OemnN3-qba6GW8zVSKnnWuHGbSNPKbvIidLvDoxuza-4HX1dCCJ5KLUM
Message-ID: <CAFEAcA-uxtCoawErLdM0HVuy_h-uxxcmFjJsZf1rTgNiov-JWw@mail.gmail.com>
Subject: Re: [PATCH v15 00/17] HVF: Add support for platform vGIC and nested
 virtualisation
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>, 
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Fri, 6 Mar 2026 at 15:53, Mohamed Mediouni <mohamed@unpredictable.fr> wr=
ote:
>
>
>
> On 6. Mar 2026, at 16:44, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 6 Mar 2026 at 14:58, Peter Maydell <peter.maydell@linaro.org> wro=
te:
>
>
> On Fri, 6 Mar 2026 at 13:01, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>
>
> Link to branch: https://github.com/mediouni-m/qemu hvf-irqchip-and-nested
> (tag for this submission: hvf-irqchip-and-nested-v15)
>
> This series adds supports for nested virtualisation when using HVF on arm=
64 Macs.
>
> Reviews would be very welcome :-) It's maybe a bit unlikely that this wil=
l make
> it to QEMU 11.0 I might as well try.
>
> The first two patches are from the SME enablement series and are present =
for the
> series to be buildable on its own.
>
>
>
>
> Applied to target-arm.next, thanks.
>
>
> I'm afraid this failed to build in our gitlab CI job for macos:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/13388426185
>
> In file included from ../target/arm/hvf/hvf.c:489:
> ../target/arm/hvf/sysreg.c.inc:174:21: error: 'HV_SYS_REG_CNTHCTL_EL2'
> is only available on macOS 15.0 or newer
> [-Werror,-Wunguarded-availability-new]
> 174 | DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTHCTL_EL2, 3, 4, 14, 1, 0)
> | ^
> /Applications/Xcode_16.1.app/Contents/Developer/Platforms/MacOSX.platform=
/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks/Hypervisor.framework/H=
eaders/hv_vcpu_types.h:312:5:
> note: 'HV_SYS_REG_CNTHCTL_EL2' has been marked as being introduced in
> macOS 15.0 here, but the deployment target is macOS 14.0.0
> 312 | HV_SYS_REG_CNTHCTL_EL2 API_AVAILABLE(macos(15.0))
> API_UNAVAILABLE(ios, tvos) =3D 0xe708,
> | ^
>
> and similarly for other registers.
>
> I'm going to drop the last 4 patches from the series, which I hope will
> fix the CI problems.
>
> =E2=80=94 PMM
>
> Hello,
>
> Will submit a new rev of the last 4 patches with a workaround for this th=
en=E2=80=A6
>
> (Ugh @ compiler pragmas but there aren=E2=80=99t better choices unfortuna=
tely)

Unfortunately the problems aren't in just the nested-virt part:

https://gitlab.com/qemu-project/qemu/-/jobs/13389185563

still complains, including about hv_gic_config_create().

I'm going to drop everything except the first 2 patches.

thanks
-- PMM

