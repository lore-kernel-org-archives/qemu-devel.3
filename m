Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F170E66891
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 22:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWibz-0005AU-BC; Fri, 19 Dec 2025 17:06:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cyril.leclerc@subnoto.com>)
 id 1vWibt-00059I-2P
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 17:06:06 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cyril.leclerc@subnoto.com>)
 id 1vWibn-0001H6-Ka
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 17:06:03 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b79ea617f55so312686066b.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 14:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=subnoto-com.20230601.gappssmtp.com; s=20230601; t=1766181956; x=1766786756;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qmm9LVjMCkEirScuI6zk2u5DfqYnIg/YZ1yIKF14J9g=;
 b=LroYP8QzXl6/Vf/6dzuTSyKHwoiqUK/8y9a5Kee6yolLElbg61+4DTKCreJV6cSuAo
 33oV8Mm83qoDfb9NM1BTdxvAMtrYG3Pu9/aX27lYRu9j2tA6fS6BWImO5Q+BXXsbmMo+
 O3Vzv7bH2PeQzFCeLzq+a75pqzEMafoPcn+jfjj/1fGK65Af7PnmEEcYgh8lm6O/w/4n
 lzBstaDEXo56oYy8xQ9l99OKu0mbeqc826MozyKvBLX3Pp9wAdBgPl46sI8i7SRWxt1h
 quk1r8SCl2K8FEpiFZI8pZpT/1T+8CGoE79HntxxSQksJRbKpBHQUox9/YHWslf/eoHY
 cAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766181956; x=1766786756;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qmm9LVjMCkEirScuI6zk2u5DfqYnIg/YZ1yIKF14J9g=;
 b=BWPPdCdkFnShoL4Qcml61IM09UcMa2dK8zszBJrPV96cG5YN70LBc4TPS5MEJtdoQQ
 mG9iXBPGctJYR2NKl1gen1kKLry8U1f9esOYhf3uUH1l4twJL8bb9kxCmc5qUpY9yeAn
 AV0ALYMrf7ya4WGgS75+4bG+mxnXF3A9cgAn/+8pc5wMKtBQeu/BOIhsGKlLhmD4RQ/H
 g4l38ihfJM9V7ok5MMTZ0Yqv681SWvgOUdMO280wjoBOeEqMjuHD9b9BujI3hkEfBu3p
 VgEzcZSF29Uo6b/rFPIxlRwRMTiCUTrtR863NQSQEzMt0GTgiinJnmd8+EvxO/Fm1wv9
 bpAQ==
X-Gm-Message-State: AOJu0Yw6G9ME5hexMBQDHxMYQbRiCRGxDcXiDITcGisPW+qW4QsHL6Zm
 RqGnDeBbGoVW+nG/HtUp/FDT6ye8Vx7+WxRTOjTf/g0ho9yE/xQGEVY32iTtKCBL0TernHsdy6j
 b4ZX1++w4GF4F9pJ+yU1MN2kjDL1PEYLLBqSEDb8dMg==
X-Gm-Gg: AY/fxX79LJXPHleeMkthqz+oO8XCawoA91JHnvT/ICjUFZzI/aaJwvSwe6GVJeF9Vkz
 74HW0qDSX7fuP1kngca2++RKih8AUFohA/MmBrWdZ52rcZJWEjJ2E12ZuLFKUIluOfz9uWnVjlT
 aDfCNj1OaNET9/9gN6jgNMfcUwnFwf5j51DN3LrhdpQ+/T68jAsDQkdVpLzmGj/6theMiWAfTdR
 AzzcgLzPxXgYeRxGSF3R4wuwflNsIQqYecSVGv7iQcxmcWxGY2v0ZMZJLG/6m5X3bXVvUKzeg1F
 F6KC9ufIG6oxBZBnz5F9SHJ82mHL
X-Google-Smtp-Source: AGHT+IEJ/zIpYWDpFpZ+ik0fAHd1qZh5ZN/B5BeDWakME2lAi0j1tQ21wjgESOpJiueKY5x52QzNNkQasmqmLdU1wQs=
X-Received: by 2002:a17:907:868e:b0:b7a:1be1:86e6 with SMTP id
 a640c23a62f3a-b8037224ea0mr445845866b.62.1766181955130; Fri, 19 Dec 2025
 14:05:55 -0800 (PST)
MIME-Version: 1.0
References: <20251216194953.1183260-1-cyril.leclerc@subnoto.com>
 <8c5ea2fb-79ef-42a5-bf27-3859499f25a7@linaro.org>
In-Reply-To: <8c5ea2fb-79ef-42a5-bf27-3859499f25a7@linaro.org>
Date: Fri, 19 Dec 2025 23:05:44 +0100
X-Gm-Features: AQt7F2osYYQe_VKBtNwWPJdFSPWFbNw9BdR_YDgaO4NWCx9zCAm_2ZwhksWZ9-Q
Message-ID: <CAOAHS4Mz-Q4Z8TyFAs8XYV9fuJoTLWGX30XKgzLCYNG6qMEbBA@mail.gmail.com>
Subject: Re: [PATCH] hw/i386/microvm: account for SEV c-bit in 64 bit PCI MMIO
 hole
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000000b6bd50646554895"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=cyril.leclerc@subnoto.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Cyril Leclerc <cyril.leclerc@subnoto.com>
From:  Cyril Leclerc via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000000b6bd50646554895
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Philippe,

I'd have thought that phys_bits was a bit count not a mask. we want to
remove the number of reduced phys bit from the total to get the usable
address width

Le ven. 19 d=C3=A9c. 2025 =C3=A0 15:42, Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org> a
=C3=A9crit :

> Hi Cyril,
>
> On 16/12/25 20:49, Cyril Leclerc via wrote:
> > microvm places the 64-bit PCI MMIO hole at the top of the physical
> > address space. With SEV, the c-bit reduces the usable address space,
> > so the MMIO hole ends up at addresses the guest cannot reach (the
> > guest always strips the c-bit on MMIO accesses).
> >
> > Fix by placing the MMIO hole within the sev guest addressable range.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3245
> >
> > Tested-by: Cyril Leclerc <cyril.leclerc@subnoto.com>
> > Signed-off-by: Cyril Leclerc <cyril.leclerc@subnoto.com>
> > ---
> >   hw/i386/microvm.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> > index 94d22a232a..cb43a399ff 100644
> > --- a/hw/i386/microvm.c
> > +++ b/hw/i386/microvm.c
> > @@ -36,6 +36,7 @@
> >   #include "hw/i386/microvm.h"
> >   #include "hw/i386/x86.h"
> >   #include "target/i386/cpu.h"
> > +#include "target/i386/sev.h"
> >   #include "hw/intc/i8259.h"
> >   #include "hw/timer/i8254.h"
> >   #include "hw/rtc/mc146818rtc.h"
> > @@ -230,7 +231,11 @@ static void
> microvm_devices_init(MicrovmMachineState *mms)
> >
> >       if (x86_machine_is_acpi_enabled(x86ms) && mms->pcie =3D=3D
> ON_OFF_AUTO_ON) {
> >           /* use topmost 25% of the address space available */
> > -        hwaddr phys_size =3D (hwaddr)1 << X86_CPU(first_cpu)->phys_bit=
s;
> > +        int phys_bits =3D X86_CPU(first_cpu)->phys_bits;
> > +        if (sev_enabled()) {
> > +            phys_bits -=3D sev_get_reduced_phys_bits();
>
> No clue whether this is right or not, but please use logical operation
> to remove a bit from a mask:
>
>                  phys_bits &=3D ~sev_get_reduced_phys_bits();
>
> > +        }
> > +        hwaddr phys_size =3D (hwaddr)1 << phys_bits;
> >           if (phys_size > 0x1000000ll) {
> >               mms->gpex.mmio64.size =3D phys_size / 4;
> >               mms->gpex.mmio64.base =3D phys_size - mms->gpex.mmio64.si=
ze;
>
>

--0000000000000b6bd50646554895
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Philippe,=C2=A0</div><div><br></div><div>I&#39;=
d have thought that phys_bits was a bit count not a mask. we want to remove=
 the number of reduced phys bit from the total to get the usable address wi=
dth</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gma=
il_attr">Le=C2=A0ven. 19 d=C3=A9c. 2025 =C3=A0=C2=A015:42, Philippe Mathieu=
-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank">phil=
md@linaro.org</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">Hi Cyril,<br>
<br>
On 16/12/25 20:49, Cyril Leclerc via wrote:<br>
&gt; microvm places the 64-bit PCI MMIO hole at the top of the physical<br>
&gt; address space. With SEV, the c-bit reduces the usable address space,<b=
r>
&gt; so the MMIO hole ends up at addresses the guest cannot reach (the<br>
&gt; guest always strips the c-bit on MMIO accesses).<br>
&gt; <br>
&gt; Fix by placing the MMIO hole within the sev guest addressable range.<b=
r>
&gt; <br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/324=
5" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qem=
u/-/issues/3245</a><br>
&gt; <br>
&gt; Tested-by: Cyril Leclerc &lt;<a href=3D"mailto:cyril.leclerc@subnoto.c=
om" target=3D"_blank">cyril.leclerc@subnoto.com</a>&gt;<br>
&gt; Signed-off-by: Cyril Leclerc &lt;<a href=3D"mailto:cyril.leclerc@subno=
to.com" target=3D"_blank">cyril.leclerc@subnoto.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/i386/microvm.c | 7 ++++++-<br>
&gt;=C2=A0 =C2=A01 file changed, 6 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c<br>
&gt; index 94d22a232a..cb43a399ff 100644<br>
&gt; --- a/hw/i386/microvm.c<br>
&gt; +++ b/hw/i386/microvm.c<br>
&gt; @@ -36,6 +36,7 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/i386/microvm.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/i386/x86.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;target/i386/cpu.h&quot;<br>
&gt; +#include &quot;target/i386/sev.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/intc/i8259.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/timer/i8254.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/rtc/mc146818rtc.h&quot;<br>
&gt; @@ -230,7 +231,11 @@ static void microvm_devices_init(MicrovmMachineSt=
ate *mms)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (x86_machine_is_acpi_enabled(x86ms) &amp;=
&amp; mms-&gt;pcie =3D=3D ON_OFF_AUTO_ON) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* use topmost 25% of the addr=
ess space available */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 hwaddr phys_size =3D (hwaddr)1 &lt;&lt; X=
86_CPU(first_cpu)-&gt;phys_bits;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int phys_bits =3D X86_CPU(first_cpu)-&gt;=
phys_bits;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sev_enabled()) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 phys_bits -=3D sev_get_redu=
ced_phys_bits();<br>
<br>
No clue whether this is right or not, but please use logical operation<br>
to remove a bit from a mask:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys_bits &am=
p;=3D ~sev_get_reduced_phys_bits();<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hwaddr phys_size =3D (hwaddr)1 &lt;&lt; p=
hys_bits;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (phys_size &gt; 0x1000000ll=
) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mms-&gt;gpex.mmi=
o64.size =3D phys_size / 4;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mms-&gt;gpex.mmi=
o64.base =3D phys_size - mms-&gt;gpex.mmio64.size;<br>
<br>
</blockquote></div>

--0000000000000b6bd50646554895--

