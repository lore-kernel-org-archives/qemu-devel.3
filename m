Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E26BAC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6XFA-0002xa-3N; Tue, 15 Sep 2026 13:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1x6XEz-0002x3-Cd
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:46:45 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1x6XEx-000202-Pi
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:46:45 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66e4aae314aso13231d50.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 10:46:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789494402; cv=none;
 d=google.com; s=arc-20260327;
 b=Nq4u5rvNbTAm6giLbjEJHdFIKbXDc/6JFhQiOvcFVC+V1CtyPx4HSocXivX+TzJzQW
 8iXzieER7CJm17EyZzrgkk3fSNujpVBNfZeFP0pYgm6Qw0zZDNiFHoeF1r3QW3vxr/oy
 SUKbuPXXJr8jKNn0eYfB2TVZrRL2Rf6np1pnIUrTDUYCT6nhXwMjEpv1KOLi/aMv+4T5
 448oFUGao/8+1kGKsu0YKT+Gm0U8pYcsN3UBCrsBE/lQa9r3VDGMitnA6IWuVIQSMQEv
 2pRvmrxbOzrqQZzeGU/RMqgbt28gf49fvgZ4bKyuU0xnjPFN30qsqzK+qjOikL84Yv8R
 PMCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JqnbvjRKaNs4t7UaOgr9WJqmBpRK5gzPC9BLZmCBw2s=;
 fh=jp+jdRHA2Nbu3KHyIigzCCPHDCHDJKtZ5yhVkhWOgJM=;
 b=BZfn42w344YVkYLJ0SDzud/aMxmyMRKXPFGwIKd3TQloVv7z7XUH6dRGS93dsm2tYF
 6YlXRL3aC7vOwd9swXrseKdSiRMK4XV+5ShjVDXUWHWXDJ5v9OhLt80onCbz/5KFbW8e
 whuHc/Lay/xhGdCLI8ix7RrkonVeouENmpJxWpp/w5imwVj5Nx9yjw2UvKjQRlFCyqNm
 M72/trkPHbgotg/yMTf4mG052Qk+NXP0yaKhh5KgGN2e1KjPSDnwX3WIEw0YHn7eFquL
 ej//VkxkO6Ldw3N2gi9Ku2E4lVtsJ4Yf6ep/jj0jmj4ATHwplkvQgIbgm3rMNhN/+EPW
 FrCw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789494402; x=1790099202; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JqnbvjRKaNs4t7UaOgr9WJqmBpRK5gzPC9BLZmCBw2s=;
 b=Fz8PZML47Fs2rClhvqPmte8B3Kl67FpwWyVWyL+9gOMvcAiyFOeEznFwQdqR44BhjK
 qDdD4Cse/69Ps+GT41bU/uraBJ4nWASTJfdA+ltG84xckPU2Sv9i43N6oMBkJG9Aveas
 NOAqK3kAeJcfTioJTd+RwPUGtlAkVlgDfyY92UnkuxOjRxjYUzvrSvRkGVqhTedSjUKg
 rB+OGO/tBUrrIDI2X2ZEhFbHZOK0+KvX6oDRL5O2vGp7KE8uyTKVLc+FBpSotjUH5iKm
 aEs8UxoszBliQECQ38Q1ZUlzkIuZ3WmprbG+e8QehTGT32S/v3vtSnUutxQxT95CwjL+
 FxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789494402; x=1790099202;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JqnbvjRKaNs4t7UaOgr9WJqmBpRK5gzPC9BLZmCBw2s=;
 b=M7UFuUAaJ3neD58v9DLZYg9XMRmZAcfGMy6g+GZwlYBekZuzJtrQjGF6s4y2WIQsNm
 y7IjH+ESR0itlfl3YdqCP3xSTyqYjjhl1zjEiUXTftvUwflzn7aJo1HthF/5x93bvAtk
 EjZbPOI4C/+US8vFPkOcRxEQXoT6z4mJhQl+uAQmHJev1+LkGlKZmLox9IoXRmgLNJdA
 GBEIK5skhhRk+z2PqtYIrZ5836vDmRHRHrpO0hj2eZ52WuZPraossqXK6OYzieBlK47r
 2EiCcqhMAvATkUnDwdcEO7uCPCSeW9WtmDsm1j2VL4GVHHYLE2nlORAmhJ90l/AOUGQ5
 RTfQ==
X-Gm-Message-State: AFuF++l2uv5fabLHjm6VAmvTr+g48jVhU7puvueDCh+Y6wVHR/lcjTFK
 MlV+O+MUbGk4xeXLHcart9agvxa/Bq7Z3kOYvQMNhuND8/mynKI4H5fX4xMdljJ7h96Jx6kr3k9
 XvbrEytJNanUMmCq0WoL5H2W+75Oi5LI=
X-Gm-Gg: AYBFou3lY67ogi9AHWAcWfiRY40nEMyZriEo3qWaZ5VIuQRSwS7FMaR8XthHufSh8Vm
 ZexD06cSK0A+Hb1OfUQTSxmn1G+RJcV1OQFP93O+p+MiFzb8K0M9pfIH62I3vHH0XgzAjEZMZ4X
 4fGYac2EB1ee8FKZ8Uh21Zw2+DJ4srClA3IDRBgJB0V2qoB+Ufez29NOJ3EP7avoaNvdaamSDEW
 TvMNMiJNDp+lW6dV8gd41gt59SPjKMjGJ+Xw62tMyHsEpwL76wWGBszO2ynRYAhNvQ0mtcJgK97
 9nyELKbOtBAOCm0gWdS1ALSJDSfFU+/scWBS7U1SYo6cVwyoTCyKjVyI
X-Received: by 2002:a05:690e:1246:b0:671:3bca:6afb with SMTP id
 956f58d0204a3-6715ee536a8mr376492d50.54.1789494401862; Tue, 15 Sep 2026
 10:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260913-allwinner-gpio-v3-0-a9affa474b3b@gmail.com>
 <20260913-allwinner-gpio-v3-1-a9affa474b3b@gmail.com>
 <CAFEAcA-TOjsMHDpThkBP_Mjbt+gA23SoXabOpAUVMdoFbRGjow@mail.gmail.com>
In-Reply-To: <CAFEAcA-TOjsMHDpThkBP_Mjbt+gA23SoXabOpAUVMdoFbRGjow@mail.gmail.com>
From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Date: Tue, 15 Sep 2026 19:46:30 +0200
X-Gm-Features: AcwNN1WMEfReOA_p7LXyaSv7o0a0puUzAm3Mc1MLADl6ECMXJ13i89FmSaZzwZQ
Message-ID: <CABtshVRxVrN7jgp6EwQAb8ss+SsS=DbQEaeqSjtOpZaFButYxg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] hw/gpio: Allwinner A10 GPIO emulation
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Jack wang <163wangjack@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000269119065b89228a"
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=strahinjapjankovic@gmail.com; helo=mail-yx2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_KAM_HTML_FONT_INVALID=0.01 autolearn=unavailable autolearn_force=no
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

--000000000000269119065b89228a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 5:24=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Sun, 13 Sept 2026 at 19:17, Strahinja Jankovic
> <strahinja.p.jankovic@gmail.com> wrote:
> >
> > This patch implements Allwinner A10 GPIO peripheral emulation.
> >
> > The emulation focuses on input/output and interrupt functionality,
> > whereas the drive and pull up/down functionality is not emulated.
> >
> > Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
>
> > +static inline void allwinner_gpio_update_all_output_lines(AWGPIOState
> *s)
> > +{
> > +    for (int port =3D 0; port < AW_GPIO_PORTS_NUM; port++) {
> > +        port_update_output_lines(s, port);
> > +    }
> > +}
>
> This doesn't compile on clang because this function has no callers:
>
> ../../hw/gpio/allwinner-gpio.c:257:20: error: unused function
> 'allwinner_gpio_update_all_output_lines' [-Werror,-Wunused-function]
>   257 | static inline void
> allwinner_gpio_update_all_output_lines(AWGPIOState *s)
>       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
>
> Should it be being called somewhere, or is it just a leftover
> from an earlier revision of the series?
>

Correct, it was used only in the reset function, but I removed the call
after your comment that
the reset function should not update outbound gpio lines.

I will remove this function in the next revision.

Best regards,
Strahinja


>
> thanks
> -- PMM
>

--000000000000269119065b89228a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 15, 2026=
 at 5:24=E2=80=AFPM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linar=
o.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On Sun, 13 Sept 2026 at 19=
:17, Strahinja Jankovic<br>
&lt;<a href=3D"mailto:strahinja.p.jankovic@gmail.com" target=3D"_blank">str=
ahinja.p.jankovic@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; This patch implements Allwinner A10 GPIO peripheral emulation.<br>
&gt;<br>
&gt; The emulation focuses on input/output and interrupt functionality,<br>
&gt; whereas the drive and pull up/down functionality is not emulated.<br>
&gt;<br>
&gt; Signed-off-by: Strahinja Jankovic &lt;<a href=3D"mailto:strahinja.p.ja=
nkovic@gmail.com" target=3D"_blank">strahinja.p.jankovic@gmail.com</a>&gt;<=
br>
<br>
&gt; +static inline void allwinner_gpio_update_all_output_lines(AWGPIOState=
 *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 for (int port =3D 0; port &lt; AW_GPIO_PORTS_NUM; port+=
+) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_update_output_lines(s, port);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
<br>
This doesn&#39;t compile on clang because this function has no callers:<br>
<br>
../../hw/gpio/allwinner-gpio.c:257:20: error: unused function<br>
&#39;allwinner_gpio_update_all_output_lines&#39; [-Werror,-Wunused-function=
]<br>
=C2=A0 257 | static inline void<br>
allwinner_gpio_update_all_output_lines(AWGPIOState *s)<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
1 error generated.<br>
<br>
Should it be being called somewhere, or is it just a leftover<br>
from an earlier revision of the series?<br></blockquote><div><br></div><div=
>Correct, it was used only in the reset function, but I removed the call af=
ter your comment that=C2=A0</div><div><span style=3D"background-color:trans=
parent">the reset function should not update outbound gpio lines.</span></d=
iv><div><span style=3D"background-color:transparent"><br></span></div><div>=
<span style=3D"background-color:transparent">I will remove this function in=
 the next revision.</span></div><div><span style=3D"background-color:transp=
arent"><br></span></div><div>Best regards,</div><div>Strahinja</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
</blockquote></div></div>
</div>

--000000000000269119065b89228a--

