Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE3DD6B084
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUcJ-0008OU-Gh; Thu, 29 Jan 2026 11:11:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vlUcH-00086X-VO
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:11:33 -0500
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vlUcF-0007e4-P3
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:11:33 -0500
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-1248d27f2b9so1588895c88.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:11:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769703089; cv=none;
 d=google.com; s=arc-20240605;
 b=aT2wkyIzfrY0USuv3OmfTKul2zMjl6gaJ33w4lfDOAgYjjOKlyOOuv+CVE54JwXw7J
 Z+j7PFng9sJ+X7cbP+rQmYOW+F8Af6yGqS0E8FylmqTqlWfR675RuPUa3F0fo12wRHok
 YAcjT59Bin94LoPO6Yp8JPVJq+3QaB1vCvo7HuK9ztqSImhmS3W9VDnUXL+o4+MMnLEF
 6Y8Wj7SWcoAbU9L0dMUIw7XKuTK6HktQIG4ct7SqBVVPsgirNLm6dmcU5Vb84lHE5/Y2
 QM97Tz/cGWYfY40f1DUc+3qdKQIe7/Ug6cHsJSiZEjER8io2NgrOZ9AM+Mg3+FV9cADa
 k76w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xi6t+aW4Hag+eyczycHOvScRaHbt6BUPslNeKXuOCMs=;
 fh=SnrVrskfk3zOHbfGyiNC+erIIryl/Ti5fgEvwmCUCm0=;
 b=ZA5X+uiCoZtwE6skukyrzNlbjSKuWPj1LfvLyROSvVERs97DG+O/WSHBF76LBWxcM4
 7fgUzkCGOp6uSNLhtZCQ4CQUXPUkwdIHktxE5H46nyY4oAh9LBPJJqX6bj75UcR7DkZj
 NOnRf/fFZzwNlQ2kNBfdzWLzDc6B1mnfTnhl/dtcBW5gJvCLAdV2QejwJYedWLFg48NR
 q4imkPVnLMQwsWZDNzhLr+Wyy3bzn8wS/Y21B4Q8U3Tf3yrNqq9IeDEBtGest9l6QWtI
 C4Nn3Fu9apVDwdtTJf0HI6hdAkCgUU2SSEwcsRkoJMRjvfHF/9UyyEm9ZXcE33VKDZHW
 y0Ww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769703089; x=1770307889; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xi6t+aW4Hag+eyczycHOvScRaHbt6BUPslNeKXuOCMs=;
 b=c6vC/BxCwmbU/PVHZYu8BkS5o8waijTTBOC2KOlwl8g2hFKt4cZlWlRgyFLtv3guQv
 ThLSk/1Ek4WKLIVPWODo6IAnTxwGumA4PAgHSHbjBKSFIGaF+3SwwHNj8kz6MwQeRYxF
 61cP4m4U+o0xDFIc8K41WaGBzANZj9Zmk1FM4YhDPX/+LeHqLO2tVx6VSd7sHnHE/ipr
 zdyMAF2U23tOnMup/lMiFtEkUx3CzT9L8JShvt6YMopC8yP7VS+k17D+1JKbZ2qf7Uw3
 HQNEpvIM5j/99RhkAM5xQoi/+ogz0mXTvQ9tzFri+Xc/GyzlUPFChue1Lu6v+Xg4rs5Z
 dlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769703089; x=1770307889;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xi6t+aW4Hag+eyczycHOvScRaHbt6BUPslNeKXuOCMs=;
 b=YSLhIgU0OuBieTPnGIiZPw8f/zzy/xayOnEgcEdP9/KxcrK4U79GFI8O4UGw+s7kVs
 cetlxKmNfT8v1mPcnZv6OuDDt62vvIuAMT0demidmRKOckOMlJGqbVbsgpdxtJhBx4z7
 5jgwf1GTJURAJoioLcuYMdj4nGskmyKI/Q76G4+U1q4k9E2ur0kwp92HodIg998Xkx2I
 Xhcd8AqGqZrmRjWXlFrwYINrMfqfletf7ODuj7/cAw8Ntb4SZ6HRYHYn3orJcpex8ugm
 TnIVOa258AWtVVRVi+JOjoBN7KeGFVPp47KGD1048Xaojmh+LL5HUrbkH+lkQ4DG4MTL
 3NRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpGJRaqkgmQoyFVieo/cZutgKV+CUjr5eim6X+UjQr29zkzH0aBBxaNUCCu+6MGE1VA2xoKDZHhUGr@nongnu.org
X-Gm-Message-State: AOJu0YxX+a+a1MATjM/PZkpDrPXNRPPDs59ERUnhugb71qDPTMtfkOiK
 gSGdEK41zDPUTnbCOIc43e97A7koE1sT7pBO05cvEQltU25z2pTdqjRyJ42KEsr7gp9YIp64iu0
 NwBgwJaveOICHb5wL+uWo9L6upTc4tKI=
X-Gm-Gg: AZuq6aL093dP9Xlj8lhYFuw0+Xu1lxT3UkLa1u6c0gBEusa6reXj7xXJ8kANLqykmFv
 hGtYDTgsThFGe6Jtfcsztt0k+nn8iW51HWvfG3ajOxwuGEnB7rbHtI/ZJMCC4ctEzFMhBgmgEFS
 58qHyizfkhwcRMOBDk8SoqV1zkkHcFXQj/p6x31xpiOH07YCume7HG1qreHk739/28txYyvCthp
 l5KZRG8hlX4dBks29VpKoFwFQLm35d2C0Q/k3awDF9BByRLrEGGkRecIbS5gZn85W/W3nKovw==
X-Received: by 2002:a05:7022:a98:b0:122:8d:3680 with SMTP id
 a92af1059eb24-124a00d5c0dmr4827088c88.40.1769703089409; Thu, 29 Jan 2026
 08:11:29 -0800 (PST)
MIME-Version: 1.0
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
 <CAFEAcA9NEjaUBX19sdw9TRCKcKn8CQfvoVNZ+VaXOcNZ8kf24g@mail.gmail.com>
 <CAN-aV1EjYwSRfV87YQdtfqU5CH8Bsssr3EvStPWL2_VFOs4N4w@mail.gmail.com>
 <87ecn9aas7.fsf@draig.linaro.org>
In-Reply-To: <87ecn9aas7.fsf@draig.linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 29 Jan 2026 17:11:16 +0100
X-Gm-Features: AZwV_QjKbz0UQNo9ba8Swu37xasHiajLSk_86kIHMNaAJiCPkvYAYWWqRAcgzdo
Message-ID: <CAJy5ezogj36BfEV6m4d4YT3gwXPuMzXddJsO73sJouTtVo9Zgg@mail.gmail.com>
Subject: Re: [PATCH 00/27] hw/arm: Add generic FDT-based machine and
 infrastructure
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Ruslan Ruslichenko <ruslichenko.r@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, artem_mygaiev@epam.com, 
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com, 
 Ruslan_Ruslichenko@epam.com
Content-Type: multipart/alternative; boundary="0000000000000091460649891cee"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1232;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-dl1-x1232.google.com
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

--0000000000000091460649891cee
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 11:48=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@lina=
ro.org> wrote:

> Ruslan Ruslichenko <ruslichenko.r@gmail.com> writes:
>
> > On Tue, Jan 27, 2026 at 11:03=E2=80=AFAM Peter Maydell <peter.maydell@l=
inaro.org>
> wrote:
> >>
> >> On Mon, 26 Jan 2026 at 17:43, Ruslan Ruslichenko
> >> <ruslichenko.r@gmail.com> wrote:
> >> >
> >> > From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> >> >
> >> > This patch series introduces new ARM machine model, arm-generic-fdt,
> and the underlying infrastructure required to instantiate a QEMU machine
> from a Device Tree.
> >>
> >> I'm afraid this has been a feature that has been suggested from
> >> time to time, but which I don't think is workable in general.
> >>
> >> Device tree files are designed to provide enough information to
> >> the guest kernel to allow it to find non-probeable hardware. They
> >> are not designed to provide enough information to QEMU to allow
> >> it to create and wire up all the hardware present on the system.
> >>
> >> There are specific niches where it can be made to work -- I think
> >> Xilinx have or had a setup where they were generating an FPGA
> >> model and a device tree and a guest kernel all from the same
> >> single data source, so they could put everything necessary into
> >> the dtb, for example -- but I don't think it works in the
> >> general case. As one simple example, the DTB doesn't generally
> >> have any information about how the Secure world works in an Arm
> >> system, because Linux doesn't care about the Secure world. It
> >> also doesn't usually have information that the guest OS can
> >> probe for itself at runtime.
> >>
> >> There has been periodic discussion of more flexible user-driven
> >> board creation, but that has generally been with the idea of using
> >> the QMP monitor to orchestrate creation and connection of device
> >> models.
> >>
> > I agree that a guest Device Tree is insufficient for describing a
> > complete QEMU machine model.
> > However, we separate the guest configuration from the machine
> > definition. The -hw-dtb option allows the user to provide a
> > QEMU-specific system description.
> > Those hw-dtb would not be passed to Linux Guest VM.
> >
> > The fact that this workflow has been successfully used in production
> > by AMD/Xilinx demonstrates that FDT is a feasible format.
>
> Where are the extensions to the FDT used for hw-dtb documented? How does
> it deal with PCI devices and the Secure world?
>
>

Hi,

When we first started using this, we tried using the kernel bindings but as
people have already noted on this thread those are not a good fit. So we
changed the approach to something more like a 1:1 mapping between FDT and
QOM. FDT compatible properties match on QOM device names, properties are
set more or less 1:1 with some exceptions.

Interconnects and TZ are modelled by instantiating memory regions, mapping
the selected set of "target" devices and connecting bus masters (CPUs or
DMA) "memory" links.
In addition to that, memory transaction attributes can be used for devices
that differentiate things on a per transaction basis.
This is all the same as you would do in C code with QOM/Qdev.

PCI is modelled the same way as with QOM/qdev.

Cheers,
Edgar


> > In contrast, QMP usage may end up even more complex and less
> > maintainable for the task of full system modeling.
> > To my understanding, this would need to generate too long configs,
> > which may eventually require some intermediate format by itself.
> >
> > I am proposing to use FDT as a serialization format to describe a
> > machine configuration. Theoretically we can use other formats, like
> > XML, but in my opinion FDT perfectly matches the requirements.
>
> The QMP interface is self-documenting and introspectable and used for
> the management of QEMU including things like hotplug. It is also QOM
> aware so a natural fit for dealing with the underlying QOM machinery.
>
> Previous discussions have entertained the idea of making the parsing of
> hw-dtb an external script which would then translate into QMP commands
> to build up the machine.
>
> >
> > BR,
> > Ruslan Ruslichenko
> >
> >
> >> thanks
> >> -- PMM
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--0000000000000091460649891cee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 28,=
 2026 at 11:48=E2=80=AFAM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.benne=
e@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Ruslan Ruslichenko &lt;<a href=3D"mailt=
o:ruslichenko.r@gmail.com" target=3D"_blank">ruslichenko.r@gmail.com</a>&gt=
; writes:<br>
<br>
&gt; On Tue, Jan 27, 2026 at 11:03=E2=80=AFAM Peter Maydell &lt;<a href=3D"=
mailto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro.org=
</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Mon, 26 Jan 2026 at 17:43, Ruslan Ruslichenko<br>
&gt;&gt; &lt;<a href=3D"mailto:ruslichenko.r@gmail.com" target=3D"_blank">r=
uslichenko.r@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; From: Ruslan Ruslichenko &lt;<a href=3D"mailto:Ruslan_Ruslich=
enko@epam.com" target=3D"_blank">Ruslan_Ruslichenko@epam.com</a>&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; This patch series introduces new ARM machine model, arm-gener=
ic-fdt, and the underlying infrastructure required to instantiate a QEMU ma=
chine from a Device Tree.<br>
&gt;&gt;<br>
&gt;&gt; I&#39;m afraid this has been a feature that has been suggested fro=
m<br>
&gt;&gt; time to time, but which I don&#39;t think is workable in general.<=
br>
&gt;&gt;<br>
&gt;&gt; Device tree files are designed to provide enough information to<br=
>
&gt;&gt; the guest kernel to allow it to find non-probeable hardware. They<=
br>
&gt;&gt; are not designed to provide enough information to QEMU to allow<br=
>
&gt;&gt; it to create and wire up all the hardware present on the system.<b=
r>
&gt;&gt;<br>
&gt;&gt; There are specific niches where it can be made to work -- I think<=
br>
&gt;&gt; Xilinx have or had a setup where they were generating an FPGA<br>
&gt;&gt; model and a device tree and a guest kernel all from the same<br>
&gt;&gt; single data source, so they could put everything necessary into<br=
>
&gt;&gt; the dtb, for example -- but I don&#39;t think it works in the<br>
&gt;&gt; general case. As one simple example, the DTB doesn&#39;t generally=
<br>
&gt;&gt; have any information about how the Secure world works in an Arm<br=
>
&gt;&gt; system, because Linux doesn&#39;t care about the Secure world. It<=
br>
&gt;&gt; also doesn&#39;t usually have information that the guest OS can<br=
>
&gt;&gt; probe for itself at runtime.<br>
&gt;&gt;<br>
&gt;&gt; There has been periodic discussion of more flexible user-driven<br=
>
&gt;&gt; board creation, but that has generally been with the idea of using=
<br>
&gt;&gt; the QMP monitor to orchestrate creation and connection of device<b=
r>
&gt;&gt; models.<br>
&gt;&gt;<br>
&gt; I agree that a guest Device Tree is insufficient for describing a<br>
&gt; complete QEMU machine model.<br>
&gt; However, we separate the guest configuration from the machine<br>
&gt; definition. The -hw-dtb option allows the user to provide a<br>
&gt; QEMU-specific system description.<br>
&gt; Those hw-dtb would not be passed to Linux Guest VM.<br>
&gt;<br>
&gt; The fact that this workflow has been successfully used in production<b=
r>
&gt; by AMD/Xilinx demonstrates that FDT is a feasible format.<br>
<br>
Where are the extensions to the FDT used for hw-dtb documented? How does<br=
>
it deal with PCI devices and the Secure world?<br>
<br></blockquote><div><br></div><div><br></div><div>Hi,</div><div><br></div=
><div>When we first started using this, we tried using the kernel bindings =
but as people have already noted on this thread those are not a good fit. S=
o we changed the approach to something more like a 1:1 mapping between FDT =
and QOM. FDT compatible properties match on QOM device names, properties ar=
e set more or less 1:1 with some exceptions.</div><div><br></div><div>Inter=
connects and TZ are modelled by instantiating memory regions, mapping the s=
elected set of &quot;target&quot; devices and connecting bus masters (CPUs =
or DMA) &quot;memory&quot; links.</div><div>In addition to that, memory tra=
nsaction attributes can be used for devices that differentiate things on a =
per transaction basis.</div><div>This is all the same as you would do in C =
code with QOM/Qdev.</div><div><br></div><div>PCI is modelled the same way a=
s with QOM/qdev.</div><div><br></div><div>Cheers,</div><div>Edgar</div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; In contrast, QMP usage may end up even more complex and less<br>
&gt; maintainable for the task of full system modeling.<br>
&gt; To my understanding, this would need to generate too long configs,<br>
&gt; which may eventually require some intermediate format by itself.<br>
&gt;<br>
&gt; I am proposing to use FDT as a serialization format to describe a<br>
&gt; machine configuration. Theoretically we can use other formats, like<br=
>
&gt; XML, but in my opinion FDT perfectly matches the requirements.<br>
<br>
The QMP interface is self-documenting and introspectable and used for<br>
the management of QEMU including things like hotplug. It is also QOM<br>
aware so a natural fit for dealing with the underlying QOM machinery.<br>
<br>
Previous discussions have entertained the idea of making the parsing of<br>
hw-dtb an external script which would then translate into QMP commands<br>
to build up the machine.<br>
<br>
&gt;<br>
&gt; BR,<br>
&gt; Ruslan Ruslichenko<br>
&gt;<br>
&gt;<br>
&gt;&gt; thanks<br>
&gt;&gt; -- PMM<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div></div>

--0000000000000091460649891cee--

