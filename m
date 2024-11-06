Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0980FD59F60
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 18:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8l2U-0008KF-GD; Wed, 06 Nov 2024 13:45:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t8l2O-0008Jx-El
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:45:52 -0500
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t8l2I-0000r0-8Y
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:45:50 -0500
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-513de426863so40767e0c.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 10:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1730918742; x=1731523542;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DhjYVX8POhz5/YUFLba9O2I8bloVv2XLRSydjjL8zUM=;
 b=FGpke0GNkOaCFF9iABgX1fb6eTGH3sIesbmF7QslpH2gK+C513g+xo2IESug/l6qN/
 SdxolFhmRJq3sYX7Z0uMlTQ2KtGhZsjnE8GK8Wz6ZcTTx2zsv4bSzzbOx8rRQT6yMBXl
 BwDfDSGTVrlfW4FtnEloJHunzR26A0Af9Ctl7iiaarUOfuSMDq26Rf7VWw7bXiHMw4s6
 xjGNniMP2nLfdT75FhrUTYSZTUncIXhLIcMx7inOnGfKYg7B+7h+4w0wWPWX2s8tkkD2
 R0tstxR3OvIzWM5owyGquyg1bdaj/3C/CE/CasILvNvZ9O0H0xeICdAmSv1YjR2ZwRJk
 +p+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730918742; x=1731523542;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DhjYVX8POhz5/YUFLba9O2I8bloVv2XLRSydjjL8zUM=;
 b=a7Ld/1f+BTKq6BTC+lsy+U+ymOnel5qCIZLfjcjVYcGshkEE6s+YmBXp6w9S/1iFF/
 XL46ZsVtu64CZKGXc2i+yJ6Q2phKvUJGRbrWB3XrIgK/wQmMJYtq7lN1hZZngbWIHnHF
 7mOmaaRKDCQCtHdu2cP1RKVpe9lJ+dAgsFizIBKUBLQWuEWs7kfDqTPCDXyw/2IiOG3p
 ZA70/hpLcK0/xDDbPBxFPBtyrr5AgouNIXi3VTliOSVKoN1FJxM0xMGD3RBuIiBF6YJG
 /6f/3zRyhKCI67ypEFR+3OMsTSyX4R49qqc3Hfnbq5k8o97KthcSbbdPx+P8/blYcndR
 JpZA==
X-Gm-Message-State: AOJu0YwBTqSR4w0ggoKbufrgws0U91k0BGcQTwbizuYDmnqLC6joRH5o
 DN1guJ0NC3rr5Qovi907jLahR7Hk5sUFZxUWnNkPjEyNEKhGzFCdJIjpY3mz+Rl1LI2aPZEU/fC
 imcrKg0/wsAd3rI6OBFSG1fjKELDf4yCPRjV+
X-Google-Smtp-Source: AGHT+IE7aG3F9fYn7I+lqqtU7EyLu4uRiH+7pNw0qy8FxWszeBR19hNH3l2dkUpr7hXgIS6MxsATpaoMyOyN3EyBtrY=
X-Received: by 2002:a05:6102:dc6:b0:4a3:a0b1:b94 with SMTP id
 ada2fe7eead31-4a962de2d89mr20506117137.9.1730918742202; Wed, 06 Nov 2024
 10:45:42 -0800 (PST)
MIME-Version: 1.0
References: <20241105155800.5461-1-phil@philjordan.eu>
 <ZyuKq75sryZo8U7z@roolebo.dev>
In-Reply-To: <ZyuKq75sryZo8U7z@roolebo.dev>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 6 Nov 2024 19:45:31 +0100
Message-ID: <CAAibmn38C6pCiwaGLvF6+gaTPr4drs2RZjd31Kru1RWK-iy3ow@mail.gmail.com>
Subject: Re: [PATCH 0/5] i386/hvf: x2apic support and some small fixes
To: Roman Bolshakov <roman@roolebo.dev>
Cc: qemu-devel@nongnu.org, dirty@apple.com, rbolshakov@ddn.com, 
 pbonzini@redhat.com
Content-Type: multipart/alternative; boundary="000000000000c3ba18062642ec1c"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=phil@philjordan.eu; helo=mail-vk1-xa2e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000c3ba18062642ec1c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Roman,

Welcome back, and thanks for reviewing these patches!

On Wed, 6 Nov 2024 at 16:26, Roman Bolshakov <roman@roolebo.dev> wrote:

> On Tue, Nov 05, 2024 at 04:57:55PM +0100, Phil Dennis-Jordan wrote:
> > This is a loose collection of patches against the x86 hvf accel. They
> > can be applied/pulled independently from one another.
> >
> > Patch 1 is a repost of a patch I've submitted a bunch of times already.
> > It wires up and enables x2APIC mode in conjunction with HVF - the
> > software APIC implementation in QEMU gained the feature earlier this
> > year but hvf wasn't included.
> > The change typically improves performance with modern SMP guest OSes by
> > a 2-digit percentage. (Exact values depend on workload.)
> >
> > Patch 2 fixes cases of undefined behaviour recently introduced by commi=
t
> > 7cac7aa which made changes to HVF CPUID XSAVE functionality.
> >
> > Patch 3 fixes a minor one-off memory leak during hvf startup.
> >
> > Patch 4 ever so slightly improves APIC correctness under hvf: when
> > setting the APICBASE MSR, if the APIC deems the new value invalid,
> > we raise an exception (as per spec) rather than silently doing
> > nothing. This fixes a failing kvm-unit-tests test case.
> >
> > Patch 5 removes some unnecessary duplication and type-rechecking in
> > HVF's inner loop. (No need to cast the cpu state pointer to X86CPU
> > within, the hvf_vcp_exec function already does that once at the top.)
> >
> > Some of this work has been sponsored by Sauce Labs Inc.
> >
> > Phil Dennis-Jordan (5):
> >   i386/hvf: Integrates x2APIC support with hvf accel
> >   i386/hvf: Fix for UB in handling CPUID function 0xD
> >   i386/hvf: Fixes startup memory leak (vmcs caps)
> >   i386/hvf: Raise exception on error setting APICBASE
> >   i386/hvf: Removes duplicate/shadowed variables in hvf_vcpu_exec
> >
>
> To the series,
> Reviewed-by: Roman Bolshakov <rbolshakov@ddn.com>
> Tested-by: Roman Bolshakov <rbolshakov@ddn.com>
>
> I figured the issue with 24.04 guests, it was an issue on my side (too
> little memory provided to the guest).
>

I'm glad it was that simple - I'm not aware of any incompatibilities, and I
did test with a bunch of guest OSes including a few Linux versions,
FreeBSD, Win10, and macOS.

Regarding your question about kvm-unit-tests: Last time I checked, the
upstream version of its APIC tests crashed Qemu on hvf (and I think also
TCG,) with or without any of the patches in this patch set applied. The
reason is that one of the test cases assumes it's running on a hypervisor
supporting a KVM-specific hypercall, i.e. it assumes it's running on KVM. I
tried submitting a patch that tests for support of that hypercall at
runtime, but it didn't get merged at the time:
https://marc.info/?l=3Dkvm&m=3D169736751712535&w=3D2
I should update that to make sure it applies correctly to the latest
upstream and re-submit it, as those unit tests are actually extremely
useful for development & debugging.

If the patch no longer applies correctly, you can also just disable the
test_pv_ipi() test by whatever means you like.

Patch 1/5 obviously(?) allows the x2apic tests to run at all, while patch
4/5 fixes some of the failures in test_apicbase() and test_enable_x2apic().
There are still a significant number of test failures remaining, but these
equally apply to TCG and aren't specific to these hvf patches. (Of course
it would be nice to fix them, but I've been spending a lot of time and
energy on the PV Graphics and vmapple patch set=E2=80=A6 hopefully that wil=
l
eventually be merged and I might get a chance to get some of the other
small improvements I've got lying around into an upstreamable state.)

All the best,
Phil



> Paolo, please apply this if you have no objections.
>
> Regards,
> Roman
>

--000000000000c3ba18062642ec1c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Roman,<br></div><div><br></div><div>We=
lcome back, and thanks for reviewing these patches!<br></div><div><br></div=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 6=
 Nov 2024 at 16:26, Roman Bolshakov &lt;<a href=3D"mailto:roman@roolebo.dev=
">roman@roolebo.dev</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On Tue, Nov 05, 2024 at 04:57:55PM +0100, Phil Dennis-Jo=
rdan wrote:<br>
&gt; This is a loose collection of patches against the x86 hvf accel. They<=
br>
&gt; can be applied/pulled independently from one another.<br>
&gt; <br>
&gt; Patch 1 is a repost of a patch I&#39;ve submitted a bunch of times alr=
eady.<br>
&gt; It wires up and enables x2APIC mode in conjunction with HVF - the<br>
&gt; software APIC implementation in QEMU gained the feature earlier this<b=
r>
&gt; year but hvf wasn&#39;t included.<br>
&gt; The change typically improves performance with modern SMP guest OSes b=
y<br>
&gt; a 2-digit percentage. (Exact values depend on workload.)<br>
&gt; <br>
&gt; Patch 2 fixes cases of undefined behaviour recently introduced by comm=
it<br>
&gt; 7cac7aa which made changes to HVF CPUID XSAVE functionality.<br>
&gt; <br>
&gt; Patch 3 fixes a minor one-off memory leak during hvf startup.<br>
&gt; <br>
&gt; Patch 4 ever so slightly improves APIC correctness under hvf: when<br>
&gt; setting the APICBASE MSR, if the APIC deems the new value invalid,<br>
&gt; we raise an exception (as per spec) rather than silently doing<br>
&gt; nothing. This fixes a failing kvm-unit-tests test case.<br>
&gt; <br>
&gt; Patch 5 removes some unnecessary duplication and type-rechecking in<br=
>
&gt; HVF&#39;s inner loop. (No need to cast the cpu state pointer to X86CPU=
<br>
&gt; within, the hvf_vcp_exec function already does that once at the top.)<=
br>
&gt; <br>
&gt; Some of this work has been sponsored by Sauce Labs Inc.<br>
&gt; <br>
&gt; Phil Dennis-Jordan (5):<br>
&gt;=C2=A0 =C2=A0i386/hvf: Integrates x2APIC support with hvf accel<br>
&gt;=C2=A0 =C2=A0i386/hvf: Fix for UB in handling CPUID function 0xD<br>
&gt;=C2=A0 =C2=A0i386/hvf: Fixes startup memory leak (vmcs caps)<br>
&gt;=C2=A0 =C2=A0i386/hvf: Raise exception on error setting APICBASE<br>
&gt;=C2=A0 =C2=A0i386/hvf: Removes duplicate/shadowed variables in hvf_vcpu=
_exec<br>
&gt; <br>
<br>
To the series,<br>
Reviewed-by: Roman Bolshakov &lt;<a href=3D"mailto:rbolshakov@ddn.com" targ=
et=3D"_blank">rbolshakov@ddn.com</a>&gt;<br>
Tested-by: Roman Bolshakov &lt;<a href=3D"mailto:rbolshakov@ddn.com" target=
=3D"_blank">rbolshakov@ddn.com</a>&gt;<br>
<br>
I figured the issue with 24.04 guests, it was an issue on my side (too<br>
little memory provided to the guest).<br></blockquote><div><br></div><div>I=
&#39;m glad it was that simple - I&#39;m not aware of any incompatibilities=
, and I did test with a bunch of guest OSes including a few Linux versions,=
 FreeBSD, Win10, and macOS.</div><div><br></div><div>Regarding your questio=
n about kvm-unit-tests: Last time I checked, the upstream version of its AP=
IC tests  crashed Qemu on hvf (and I think also TCG,) with or without any o=
f the patches in this patch set applied. The reason is that one of the test=
 cases assumes it&#39;s running on a hypervisor supporting a KVM-specific h=
ypercall, i.e. it assumes it&#39;s running on KVM. I tried submitting a pat=
ch that tests for support of that hypercall at runtime, but it didn&#39;t g=
et merged at the time:<br></div><div><a href=3D"https://marc.info/?l=3Dkvm&=
amp;m=3D169736751712535&amp;w=3D2">https://marc.info/?l=3Dkvm&amp;m=3D16973=
6751712535&amp;w=3D2</a></div><div>I should update that to make sure it app=
lies correctly to the latest upstream and re-submit it, as those unit tests=
 are actually extremely useful for development &amp; debugging.</div><div><=
br></div><div>If the patch no longer applies correctly, you can also just d=
isable the test_pv_ipi() test by whatever means you like.</div><div><br></d=
iv><div>Patch 1/5 obviously(?) allows the x2apic tests to run at all, while=
 patch 4/5 fixes some of the failures in test_apicbase() and test_enable_x2=
apic(). There are still a significant number of test failures remaining, bu=
t these equally apply to TCG and aren&#39;t specific to these hvf patches. =
(Of course it would be nice to fix them, but I&#39;ve been spending a lot o=
f time and energy on the PV Graphics and vmapple patch set=E2=80=A6 hopeful=
ly that will eventually be merged and I might get a chance to get some of t=
he other small improvements I&#39;ve got lying around into an upstreamable =
state.)<br></div><div><br></div><div>All the best,</div><div>Phil</div><div=
><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
Paolo, please apply this if you have no objections.<br>
<br>
Regards,<br>
Roman<br>
</blockquote></div></div>

--000000000000c3ba18062642ec1c--

