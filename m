Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E9CC4451A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 11:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viWTU-0004Fp-Db; Wed, 21 Jan 2026 06:34:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viWTS-0004Eb-Jb
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:34:10 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viWTQ-00019g-QY
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:34:10 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-78fc174ada4so49240487b3.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 03:34:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768995247; cv=none;
 d=google.com; s=arc-20240605;
 b=P9wgWblvlQ3rjMEUHHvZPUuMdM7XEjxvMOOyj5jqKoShBGfgXs8kxaZjZlCdzBmOqw
 M4xlfPwhGun04ViKIAY2/QpmgjXNtk3papRsX9R20TCCVJUoeFrQc+yDhEdIRwgFqrHu
 dctWWbz7pq2hsNLLrKPySykWcoZxKTGwxU9md02MVey6WFuoW01NjihekmIOsfEXlntk
 8Wen/8mxpdB8jCzuWGQusq3xC9MmpK/pyaZ2E4+xJ0LYhxUvn3P3mrk8knrJzjaNopWe
 Evv7sinWwB2V65RhUKVlAUGxO5NyOmzXfmZ97pNQ/JIZqGUV7oFScy4b+AXHlrrLNqKQ
 QOJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mLuZJvGCivU4rESBYg6drY90vTgnZPRoAgmHJHo2J6E=;
 fh=h5XwtwbFZRZ1FUOtZRgdKZteGKilXmRo+GqhpTRH7tM=;
 b=eUFNIivkpxLC5y8UEyBzCFVVLi/dUiOBgS+JYPqXtX3vhC609kJtJbfm6PCux57a22
 Z17KW2oG39mEsQHOMzAjumnoI/jAxe9T1VJSOnP5jIFgIH9o/YKUxuxsoMt0WXg+Qn/v
 QQy/4lQzgvOtdhgYOb/XQKOeEPlixpNJ7IAoFonPtwfNmCmILMhyx22tWaQSQ53cMnnw
 2oNw/NRLPqZYftBm63nffsRyR9yEEUpdRTXLDGx1ng5ACggaYQs9RPvH6wWfmmjEgdJO
 b4n25RoaLhigjEkGfrh4cJOe6YxXCa2GMlj94aiIJNcshEwhlVeE3fw0JjBqiLYoE0aW
 TZ1g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768995247; x=1769600047; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLuZJvGCivU4rESBYg6drY90vTgnZPRoAgmHJHo2J6E=;
 b=QhRT7jDXGLC+0eWangDWv4zeu6sZBiVIJwt05Vu5XhGyAWdlZadUvIawQrkpReUeLT
 5Uri7y+6RScxyN/oHmt5x5BmFzRyL6DHSo+3gAX5GTm4oDCZdyZMJgWx78BU//fOFsNI
 z4exmThIQdq6q8E9+9LNXK1XRnjDTVPsZZADI5AQoldqVbnes/VsFNlWC629wD4BYPmu
 ZF6zStLF8lUueTsPFT7a8ATv+AZCCUI+5GrEdKuXSYz43l1vK1pDelgJtL5oAZy+w1Ld
 Fi0/RT0l3+M+e3tYIpQkWhzccarYQLpVZj0f7X69FOaGQhkALdcgv35a7ucE28CA902e
 dGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768995247; x=1769600047;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mLuZJvGCivU4rESBYg6drY90vTgnZPRoAgmHJHo2J6E=;
 b=ko0/euhXOnKFw5zjC0ZowvGh22VWPXCBQNXpXHP4iB8fiGXDaC8QonWh24BZxErkkE
 BhxLw39MuBxWmu1j5tuaAqHNoL3vsu7grppZ+GB7Rj8sVzN6Gh3qV6IO2/5mw9x+RnSm
 LQwUG41kI+lbkr7QxbYm/gBnbbrRPSVqJzJpJ5udi2BZfsljBSMFF6LYLpViRKOiqk0Z
 D8e59KEHYhGiZZ0x+cg7qH7RMa2+3hYOtwTEMpYXLKJ4cZZUWKP6fLSZnHU9FEj58a/B
 V0geaScyg1ejrAAtoIxrWTf8ssGsU2nw3oKBu2MsLAGwViEERRlivtXsX6eA6+1txJv+
 lxLQ==
X-Gm-Message-State: AOJu0YwVehMsTTlFuGyJpt4YHo8qEHOCPdzfJAItnPkeTb3w3Qmb5SLR
 Tv8OiH05nGJXtQh/5ThtvoQR/W5q7Qg5fjYuIHRlOT34cEjgCnpOfzIJcFCf3zMPD/euQXUQmQH
 QtFB0lT9u4HcbbFCsjF6iMcMNzH67Snxv1RiXm9djdA==
X-Gm-Gg: AZuq6aL+M3mkCiUFp+sR5dNKUpkZgTFktY5CP3THaChlZwm5A8qtRDGnwoOOczpikJi
 pF7Vd8ohjXxs7lH5dw3dV6lkCHpVbOoIkb3O+U/UPBWmAKaWIAO4WTVJiClQxPI5NMflcDi8ZKa
 V/IxcSvVriq7ipAv4kLLI08Kx99vd1N8tgpY/v85RXnBvEPKjfiVyeDcyQlso2wEFhBTnyde22Y
 CPYAI9HxgwsL02oWhk8alMHPjSGCbuEygvHBD4ZkLioQ6ZIwy9efm5ot39RcyYm5r3lyQ==
X-Received: by 2002:a05:690c:310:b0:784:952f:922b with SMTP id
 00721157ae682-7940a376c27mr43328177b3.63.1768995246835; Wed, 21 Jan 2026
 03:34:06 -0800 (PST)
MIME-Version: 1.0
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
 <20260116135235.38092-5-mohamed@unpredictable.fr>
 <CAFEAcA-3P6i_w3b7SaFTn4Zmwnot5vpDs89y+zpjcJ=-mEnP5w@mail.gmail.com>
 <8158CEFE-8EA2-40A4-970E-01B30BACC019@unpredictable.fr>
 <CAFEAcA9JC1HRboZ=722dsT7a4nDQNF_ECjLK+z84T5MJisfppg@mail.gmail.com>
 <2FD2C3C6-8FBA-4833-B890-5E81637BE7EE@unpredictable.fr>
In-Reply-To: <2FD2C3C6-8FBA-4833-B890-5E81637BE7EE@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Jan 2026 11:33:55 +0000
X-Gm-Features: AZwV_QgqMRQrWXZHWGXER70p5bRiQr55Gyh70nqhj9c4jX-SyrNj2yBjFIEPr2k
Message-ID: <CAFEAcA-MAsQpaaUx0dJHRHjUJ6bEWwnf58VZN965Npmi7_kHXQ@mail.gmail.com>
Subject: Re: [PATCH v16 04/26] hw/arm: virt: add GICv2m for the case when ITS
 is not available
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Pedro Barbuda <pbarbuda@microsoft.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

On Wed, 21 Jan 2026 at 10:19, Mohamed Mediouni <mohamed@unpredictable.fr> w=
rote:
>
>
>
> > On 21. Jan 2026, at 10:27, Peter Maydell <peter.maydell@linaro.org> wro=
te:
> >
> > On Tue, 20 Jan 2026 at 18:44, Mohamed Mediouni <mohamed@unpredictable.f=
r> wrote:
> >>
> >>
> >>
> >>> On 20. Jan 2026, at 19:02, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> >>
> >>
> >>> The MSI controller selection logic is already pretty confusing,
> >>> and this is making it more complicated. I don't think we should
> >>> need this machine back compatibility, because currently there
> >>> is no setup where you can have a GICv3 that doesn't also have
> >>> either an ITS or no MSI controller.
> >>>
> >> Hello,
> >>
> >> This was to replicate the =E2=80=9Cno_tcg_its=E2=80=9D where this was =
done when introducing TCG.
> >> And for the purpose of VM save/restore on HVF with the older machine t=
ype continuing to work as expected.
> >
> > no_tcg_its is there for backwards compatibility: on older
> > QEMU versions before we added the TCG ITS, if you said
> > "-machine virt,gic-version=3D3 -accel tcg" you didn't get an
> > ITS; we wanted to change the default in new machine versions,
> > so we needed the back compat switch.
> >
> > What is the command line that works today and where we
> > want to go from "default to GICv3 without ITS or v2m"
> > to "default to GICv3 with v2m" ? I might have missed it
> > but back last year when I was looking at the current
> > configs I didn't think we had one.
> Hello,
>
> None, was thinking about what its=3Doff should mean but perhaps
> the right behaviour to do there is to have it mean no MSI-X controller.

Yeah, this is a bit tricky. I think that at the moment
we allow "gic-version=3D2,its=3Doff" and you still get a gicv2m.
So we need to retain that behaviour (though I doubt anybody
is deliberately using it), which I think means we do need
the its option to be an on/off/auto one. On the other
hand that means that the finalize_msi_controller() logic
(see https://patchew.org/QEMU/20260120180339.1416328-1-peter.maydell@linaro=
.org/
that I posted yesterday) can look relatively neat:

   if (vms->its !=3D auto) {
       /*
        * User set the legacy "its" option, which traditionally
        * meant "ignored if GICv2 (always provide GICv2m), enable
        * or disable ITS for GICv3".
        * Translate into its "msi" option equivalent:
        *  - "its=3Dno" means "msi=3Dgicv2m" for a GICv2, "msi=3Dnone"
        *    for GICv3 and up.
        *  - "its=3Dyes" means "msi=3Dauto"
        */
       if (vms->msi_controller !=3D VIRT_MSI_CTRL_NOSEL) {
           error("msi and its options cannot be used together");
           exit(1);
       }
       if (vms->its =3D=3D off) {
           if (vms->gic_version =3D=3D VIRT_GIC_VERSION_2) {
               vms->msi_controller =3D VIRT_MSI_CTRL_GICV2M;
           } else {
               vms->msi_controller =3D VIRT_MSI_CTRL_NONE;
           }
       }
       /* for vms->its =3D=3D on we leave msi_controller at NOSEL */
   }

   if (vms->msi_controller !=3D VIRT_MSI_CTRL_NOSEL) {
       /*
         * User specified an "msi" option: check what they
         * specified, and use it.
         */
        if (vms->msi_controller =3D=3D VIRT_MSI_CTRL_ITS &&
            vms->gic_version =3D=3D VIRT_GIC_VERSION_2) {
            error_report("A GICv2 cannot use an ITS");
            exit(1);
        }
        /* other error checks here as needed */
        return;
    }

    /* logic to pick the best msi_controller goes here */

This puts all the option handling code in one function that
has three parts:
 * deal with the legacy its=3D option by converting it to
   the equivalent msi=3D option
 * error check any explicitly set msi option
 * pick an msi for the user if they didn't specify

Then the rest of the code in virt.c doesn't need to care
about the option flags or back-compat stuff directly, it
can look at just the final resulting msi_controller setting.

thanks
-- PMM

