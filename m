Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89E1CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGFoD-0007Sv-Ck; Mon, 12 Oct 2026 09:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1xGFoB-0007SP-Ot
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 09:11:15 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1xGFoA-0006ZJ-0e
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 09:11:15 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8aca54b75d4so26614657b3.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 06:11:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791810672; cv=none;
 d=google.com; s=arc-20260327;
 b=LlXuvAGAP1torDVzg6yEcdAfx6JGoEhGqaRW4nneIG0VImYeCfizhtzxXoE2J4APm2
 KCLVgkqipr0GWCQqhlCBoOT6f/YpuutJKWSoYJ7f+KIs4focenTQvF0CUfKij0vPQ3p/
 /kKHox47xItAEdVLZFQNt/9XRohO0W9DrI4dRW1Tslpl5LzpJkxxtsyW5huCrENpHlg8
 mFyssniJxP5Hgun8xgqynHgMG1LS/sy7Js6eDwlWzB15ILYfcop3CmH0CcybpH5f51JG
 vs6v9bd1Ddj6r0kAqbYe75YBol7jubRc2itP6BI9aNqo51UCqr/cJHoPCWNEB1g9xOny
 0LTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nmVFAm4wCjcnkBpWwyxQ/vyvNCASp8S+SH9ifUzW9Rs=;
 fh=lhQ8GNq7x3L8f98X7+/2lrvB2B0YxqWuGGTdxGP9vzw=;
 b=sZPTYpNoLzi3XEUfkpaQf55f/jVAC7fnGQRp8R2ANVcmtM8wT+fT+3K80EebYAFl/4
 Hx1ps4IbmF3cb+cc8KfU/AnGq/B/aXQW+3ZbKdi4mWl0aQBYY7GiaoxBvbNawrnHnJ+A
 Mm0rQ75EfYyQC+VZ6vXEawe2GMNy1IetoGOXH9ET9+Z9z3BnbMH6kBFwn+E3zalPI0+i
 jZyzhllBpzWbt1PqIuGbEnaPla0QjuZiaVu1fnmjzeaFTp/zAN4LQqabn/SjifYeaUeH
 9rbh0QpLPwYhtuffprcMp4M6Y+MXCyVYb6+Kda+sDArtQYHfTmDheJQOkhAEatpgipwT
 TBcA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791810672; x=1792415472; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nmVFAm4wCjcnkBpWwyxQ/vyvNCASp8S+SH9ifUzW9Rs=;
 b=qF1ndjVN8xG5IJ0nOi7/Q+y8YEzBMwpkcy/mtlGpt6kmJlPXWRMbv8hhuy2NGjCS1z
 n2uaTsJg57bRlNCCWpneDD02EVU9Pe4j94XY03Aux+iX8KFEZfMIL6/figx8cBwdXi+r
 FxJ8TqLhDbQE1dYfG6WHUU9znKo0MrpRdw1i3s1Jva9H9635EH19ykLglwFthF1Xc8cu
 x7ZHGAgBJZOJ1XeAIzNd6KhpyiRLhAui7kdR+SCAq6TOVl4SrMdMAH+kTXXgGRfEbLOV
 Ym1KZLeKMlkpTgLw5JAQKRlJHXUDEZ5nJn9R19Ul/qvxK/nxOvRGGNJHnX85aTaL1Qqg
 zqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791810672; x=1792415472;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nmVFAm4wCjcnkBpWwyxQ/vyvNCASp8S+SH9ifUzW9Rs=;
 b=NzkHy6DWqGO2oqpp70sG5mqHxS7m3xTZy90nFyBSvrNjxjcQkDCjzi0pXpXzTQieFW
 vw7D09oRjgN8u0fZIxKWRBew158i5ohG+1iCr6nLRER8CE1oaNYaHrVS7OFWbrXNLBUT
 YJcDjC55ItlXotbMeYEu3r47498cAllSh3mJ4tExMr46uV4uEVQRNCxTTvNDuV17EJWx
 FRm3pC9v4CgAMhnLEmGpPUaECGaKqLeylPzhJ4I2qwPoCOvNPUO1IMVhCiKzvZ7pQpkJ
 dGdZ69LXE6Y1tuovsmop7fQ053boAk3vkEV2MjgPFLFDCx06Zj/uPtznJ5hiv0hD193Z
 +AiQ==
X-Gm-Message-State: AFq9FYIo7BhhcqH/ZlYV6UIlDSMdsq1tZY/D+XLC9X5SeUj7bIAtSt1p
 Jq08K9aF8aMhV6H14VnJHjNwjmtT0EKMLyZyh8NQQgJe6LuzvPQx0QZVxSLUkxikxlfkpUxSBHE
 DJdACYWtDXnQxoSLB9sOdwMHHuEABGnc=
X-Gm-Gg: AYBFou2aoRtyPGM63cDyD88dj/XjB+uzwIW3D0CQ/grasYOKJN7MS3yaPrwPnOt7k7L
 x6T0mM30sr+Ocwzh7WqdElCqEksdPiVFW3xGownOHYnKR+OzTQHjmHLCgL+3gVmC3xroBw2vAr2
 5/iuu+T/WGzoD4lUsdmC4YGOfKjQ5nLk2ZDhm6XU06KnkZJByJdmVvxU85zuRdrriUk56eAsAju
 iDdywlo2d91O94UMV8EaYae4mbJuXliKODTUxEZpvod46mmuQ3bazB9y2j+RGrFB9die6F0bJ7H
 2j1sgSIun3INwbl4/03TpaS4aeVuVIZaru5xTiNWmU0V1g8JEfB80I/UOtLMyUSknuCehGJ0HEI
 =
X-Received: by 2002:a05:690c:6e81:b0:8ad:7131:9178 with SMTP id
 00721157ae682-8b07d3bee19mr29079907b3.12.1791810672447; Mon, 12 Oct 2026
 06:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20261009-allwinner-gpio-eint-v1-0-c55d2958ae0b@gmail.com>
 <CAFEAcA9PfDvtOgXnUeWkB+h8bGTRzZLbsUeoLeORf-o1gF6jkQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9PfDvtOgXnUeWkB+h8bGTRzZLbsUeoLeORf-o1gF6jkQ@mail.gmail.com>
From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Date: Mon, 12 Oct 2026 15:11:02 +0200
X-Gm-Features: AclHuK9RwxDuwqrOc8rAuF7wuuz8nP_t7ebqu0Bh5As2G-H1RVpvQcR67Sq1R0o
Message-ID: <CABtshVQvYh_Kt0+hkXnQxEQgvEnTFUBxw0dLjbUR_VhuicHbrg@mail.gmail.com>
Subject: Re: [PATCH 0/2] fix: Allwinner GPIO interrupt handling
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a2d6ca065da46e29"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=strahinjapjankovic@gmail.com; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000a2d6ca065da46e29
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

Thanks for checking this and for detailed explanation. I will send new
patches with the fixes.

Best regards,
Strahinja

On Mon, Oct 12, 2026, 3:03=E2=80=AFPM Peter Maydell <peter.maydell@linaro.o=
rg>
wrote:

> On Fri, 9 Oct 2026 at 17:26, Strahinja Jankovic
> <strahinja.p.jankovic@gmail.com> wrote:
> >
> > The original patches assumed that pin had to be configured as input in
> > order to be able to receive interrupt. However, after additional testin=
g
> > with libgpiod and gpiomon, the pin is actually supposed to be configure=
d
> > as EINT (0x06). In the following example with PH1
> >
> > root@cubieboard-ng:~# gpioget -c 0 224
> > allwinner_gpio_read [PH:CFG0] -> 0x1061061
> > allwinner_gpio_write [PH:CFG0] <- 0x1061060
> > allwinner_gpio_read [PH:DAT] -> 0x49
> > "224"=3Dactive
> > root@cubieboard-ng:~# gpiomon -c 0 224
> > allwinner_gpio_read [PH:CFG0] -> 0x1061060
> > allwinner_gpio_write [PH:CFG0] <- 0x1061066
> > ...
> >
> > The CFG0 value on the lowest nibble changes from 0 to 6.
> >
> > This patch set fixes that behavior to expect that pin is configured as
> > EINT in order to allow interrupt-related functionality.
> >
> > Tests are also updated to reflect this change, and a new test for pins
> > configured as input is added.
> >
> > Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
> > ---
> > Strahinja Jankovic (2):
> >       hw/gpio: Add EINT CFG to Allwinner GPIO, fix interrupt handling
> >       tests/qtest: Update Allwinner GPIO test
>
> This series fails "make check" when patch 1 is applied but not 2.
> We need to retain "builds and passes tests" at every point in a
> multiple-commit series, so that "git bisect" works.
>
> I would suggest moving the minimal changes to update the test
> to match the new behaviour into patch 1, and adding the new
> get_input_pins patch in patch 2.
>
> thanks
> -- PMM
>

--000000000000a2d6ca065da46e29
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Peter,<div dir=3D"auto"><br></div><div dir=3D"auto">Th=
anks for checking this and for detailed explanation. I will send new patche=
s with the fixes.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Best r=
egards,</div><div dir=3D"auto">Strahinja=C2=A0</div></div><br><div class=3D=
"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Mon, Oct 12, 2026, 3:03=E2=80=AFPM Peter Maydell &lt;<a href=3D"mailto:pe=
ter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">On Fri, 9 Oct 2026 at 17:26, Strahinja Jankovi=
c<br>
&lt;<a href=3D"mailto:strahinja.p.jankovic@gmail.com" target=3D"_blank" rel=
=3D"noreferrer">strahinja.p.jankovic@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; The original patches assumed that pin had to be configured as input in=
<br>
&gt; order to be able to receive interrupt. However, after additional testi=
ng<br>
&gt; with libgpiod and gpiomon, the pin is actually supposed to be configur=
ed<br>
&gt; as EINT (0x06). In the following example with PH1<br>
&gt;<br>
&gt; root@cubieboard-ng:~# gpioget -c 0 224<br>
&gt; allwinner_gpio_read [PH:CFG0] -&gt; 0x1061061<br>
&gt; allwinner_gpio_write [PH:CFG0] &lt;- 0x1061060<br>
&gt; allwinner_gpio_read [PH:DAT] -&gt; 0x49<br>
&gt; &quot;224&quot;=3Dactive<br>
&gt; root@cubieboard-ng:~# gpiomon -c 0 224<br>
&gt; allwinner_gpio_read [PH:CFG0] -&gt; 0x1061060<br>
&gt; allwinner_gpio_write [PH:CFG0] &lt;- 0x1061066<br>
&gt; ...<br>
&gt;<br>
&gt; The CFG0 value on the lowest nibble changes from 0 to 6.<br>
&gt;<br>
&gt; This patch set fixes that behavior to expect that pin is configured as=
<br>
&gt; EINT in order to allow interrupt-related functionality.<br>
&gt;<br>
&gt; Tests are also updated to reflect this change, and a new test for pins=
<br>
&gt; configured as input is added.<br>
&gt;<br>
&gt; Signed-off-by: Strahinja Jankovic &lt;<a href=3D"mailto:strahinja.p.ja=
nkovic@gmail.com" target=3D"_blank" rel=3D"noreferrer">strahinja.p.jankovic=
@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; Strahinja Jankovic (2):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/gpio: Add EINT CFG to Allwinner GPIO, fix=
 interrupt handling<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tests/qtest: Update Allwinner GPIO test<br>
<br>
This series fails &quot;make check&quot; when patch 1 is applied but not 2.=
<br>
We need to retain &quot;builds and passes tests&quot; at every point in a<b=
r>
multiple-commit series, so that &quot;git bisect&quot; works.<br>
<br>
I would suggest moving the minimal changes to update the test<br>
to match the new behaviour into patch 1, and adding the new<br>
get_input_pins patch in patch 2.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--000000000000a2d6ca065da46e29--

