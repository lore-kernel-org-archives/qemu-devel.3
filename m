Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E951C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Pko-0008Vy-1d; Fri, 04 Sep 2026 04:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x2Pkl-0008VD-Oj
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 04:58:31 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x2Pkj-0008OD-7G
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 04:58:31 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6a63c610b8dso969491a12.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 01:58:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788512305; cv=none;
 d=google.com; s=arc-20260327;
 b=NpDQNGEmDh8fQEkp2C2GnnbEraylb/aCt5YMLYXQGyrbOqVszh54DZ348V9qgAwzo+
 rb3wMRdc9U7RyHA8FbGMQvHnqKnndEZpjY61/dUWgJnn7dwtquybWb5DNRflyrOac1JS
 i+5i6BV3HoyK+jKc+hj/jm34oeDQO0k7JddjdUpdtDQAeCEX1225bE9QYdht2hG1srj9
 s6sachbl/kZ+VJ++/qY3urPIzR/I+zPTyEpl8jrmR8/JT7sdIRIXTbeYpjXFiEfQQ9bP
 sVm/k+Xtl+064jLaKXLaOSt/GTcrHAJ8U3lFyWjKxqB/DvKrJaBskepsq/aOLEge4ZU6
 sNaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/mQ4TBILEBm+1/BDTfNZKmJDNy60LyKYU3/cnGXEC4Q=;
 fh=KQeID0BUn6n1ygPg6ngE8nRc2To90/qX2CkijSma9z8=;
 b=aq7cvtLT7wHZ/0Waysv2XeOed1ciBEX138EYhJkDJSTNVLr/9ss+jum8Sayk4LdlVG
 gF5JNS6wdKtc1lm9nE/MQjul4xjQvo1BVgIJlf9BOrsDcf9eg5Wi2mxZT/kZ8vH4spHL
 9QIVIM6OibG76HU8eNy55X9B7YzrY2dTyQWMUzVAhz231q4C0/qgaFAB/703zitmO9AX
 GI/tr9i+O23l3x9F+w/Pr+uCEvNvzPRknptRNV5vAMgI81SuWGNJWXzQRJH/nwcmeD17
 UBtNdQvtsNTfBPqcx26QxDtYRKPrTQsB35MCBuwomSvWwXi/OE8mKBi6whZNtkcYS+mK
 A0fw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788512305; x=1789117105; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/mQ4TBILEBm+1/BDTfNZKmJDNy60LyKYU3/cnGXEC4Q=;
 b=nAFfzqSN3XSgtG7fCMr8kKJaRHOqVhAq2LZavLQTmqa5Qp1vBHALLowPRPiFrYzxN4
 QeJauZT8VChY1PRJ8Rn0s3QIGJwJOULdUtyM2b9alDfrRTUI1wGNf21RLgchxKFwSGNR
 1HUTQOOOMjuQpW9CwEtlk9XCnAh4xKKYTklLX32PlxbKwkiyyrh/Mr9sK0u/3ZESVgVI
 hXO5NE4uRcubWFrUc/7Dvm9sCImf0CGUoe6rWEnHDsJ8XZPXnpcWBEUC+jCzkRF36DsD
 AVi+dqhimEsFKerI0kHiTNn1M67oO0VY4rV4rWO8bYltIJHrde2RHhVRZYfhvUBxNqwe
 0DqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788512305; x=1789117105;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/mQ4TBILEBm+1/BDTfNZKmJDNy60LyKYU3/cnGXEC4Q=;
 b=DRvbLBpgyXY782ggk7oHGOvNfbIkn2KazdTpSViclh4/6W3WRNiwWiANIcRIffQuuO
 GiYgU48Ca6Gg3CmlUSegkCMBuVEFvta0OuN6ayXQCiTxrCJbq+rieHycy7S6IzJc1Pvf
 UIHhL3Vrm/ojnOhnMydkuTVfuHZRrBZ2lZHJTyiJkXcteXpuvpx+vNqZ/aWzgkFpvpmp
 +Q3QD8NLRk71kFZNcGNNZpmfQx1gbOeGFQBtGF2qXEKaX7itiRlSv6EXnN+6Z8QTAlXd
 ttVrt6YN9DGGhiCZ2FHGU2LO+z6JZed+EPZ13ISrUuu1C3mjeDZq2MvUwOwDjEUAOaQh
 Fzpg==
X-Forwarded-Encrypted: i=1;
 AKwUvByP2DARHFHcxX7VAlYUs7GDB4H4XtxKzuK1dT/TS1uMdi1JPO1UYUZGh6MYzLtABrpzb+YYNYiDbnKY@nongnu.org
X-Gm-Message-State: AFuF++lgUtC8j6PGccMS9u9PvfUwO9KjuEaZtCWeTqjATnL3sOK0itH2
 Tai0rZVZZMgVLPiwmPCyY5K6Pq0Q4BaeN4Bwg339nWnOij3ghoaU3v6SBtcWfgD8WZ61grX2HI0
 Hmmo8yD4xrDvobVGzJ84R0VrFIheFTlg=
X-Gm-Gg: AYBFou0TuULufJiNE1Y6JrHajCvtI/kpUDIUDfpnwT+FOaOV/q7Nmww2veu5OoIWZ5y
 tVeMTIuWR3EijTygoam7nIeVxOkxAuE5XPfKppZ1FSa8r1FhlJDo1r/0grDDFHOFc6I2gEbBa8G
 vse7692pdeQAU3DdTlwYlE+gYpUw10+Upah4WZzZtFiFwveS0HVcn70Ht8szGyDfDmDxGz2Xz0z
 1t33fNM2HfWWf5f/HgD5ajvBsMQ+GfzQU+OC+qh1M8XXP3zYXfOuebBpPeqExFcp7UqrPoMy5gs
 2odRmZMDBZg8KhBo521bcPvMIXnNy95nLNWLXLzP3IpM
X-Received: by 2002:a05:6402:3554:b0:6a6:21d9:541f with SMTP id
 4fb4d7f45d1cf-6a7e8d4d131mr2421133a12.6.1788512303401; Fri, 04 Sep 2026
 01:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <4b4f77ee-21e9-405e-a1da-21506afa1c5b@oss.qualcomm.com>
 <app_CnHimOrOymMH@redhat.com>
In-Reply-To: <app_CnHimOrOymMH@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 4 Sep 2026 16:58:10 +0800
X-Gm-Features: AcwNN1W4rnU8cOQ9XvNLhXFC5D8T-REzsrPJaOcvdxJes1RqP-SWtJrixJo2Bgo
Message-ID: <CAE2XoE9A1WzOe43-qd1v9i6K9kSru4R2kEE1-2TrztoM=8NZJw@mail.gmail.com>
Subject: Re: [PATCH 00/47] single-binary: implement dynamic filtering for QOM
 types
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000855221065aa47809"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52c.google.com
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000855221065aa47809
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 4:19=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com>
wrote:
>
> On Fri, Aug 28, 2026 at 04:13:32PM -0700, Pierrick Bouvier wrote:
> > On 8/28/2026 3:58 PM, Pierrick Bouvier wrote:
> > > Now that we can link a single-binary with at least two targets (arm,
aarch64),
> > > we want to make sure that we expose the same set of machines (later
devices and
> > > cpus) than target binaries. For that, we implemented a static
filtering based on
> > > target interfaces that each machine will implement to declare which
targets have
> > > this machine.
> > >
> > > However, we discovered that this static filtering is not enough.
Indeed, some
> > > machines and devices do not depend only on target, and their presence
can depend
> > > on Kconfig or host/target combination. Thus, our static approach
can't work, and
> > > we need something more flexible.
> > >
> > > The goal of this series is to focus on the filtering mechanism, not
on the
> > > qemu-system binary itself, even though it's included here to give a
full picture
> > > of what we are building.
> > >
> > > v3
> > > --
> > >
> > > Suggested by Richard, we simply use a callback added to TypeInfo.
> > > Added full example with a single binary for arm+aarch64, and then
> > > arm+aarch64+microblaze.
> > > Also, added scripts/single-binary-compare-cmdline.sh, which compares
list of
> > > cpus, devices and machines between single-binary and original
binaries.
> > > This is what we can use in CI to ensure we correctly tagged all QOM
types.
> > >
> >
> > After applying this series, and running
> > scripts/single-binary-compare-cmdline.sh, you'll see than many devices
> > are visible for microblaze, and should not.
> >
> > microblaze+arm is a more interesting combination than riscv+arm because
> > riscv has a lot of devices in common with arm. On the opposite,
> > microblaze has a very reduced set (no virtio, no pci, etc).
> >
> > I would like to focus the conversation on how to filter the remaining
> > types. We could maybe generate something directly from Kconfig output,
> > so we don't need boilerplate for each CONFIG_X entry.
>
> I'm still not clear on why we need to filter the devices at all for
> a new "qemu-system" binary ?
>
> Looking at the device delta listed in your other mail, a large number
> of those are PCI based. The microblaze machine types don't expose a
> PCI controller, so those PCI devices are redundant / won't be used
> with microblaze machines, which is why existing qemu-system-microblaze
> doesn't link to those devices.
>
> The same is true of many of the arm machines too though. Only a subset
> of arm machines have PCI, but the qemu-system-arm binary still includes
> and lists all these PCI devices. Users simply can't create a PCI device
> for the arm machines that lack a PCI controller, or they'll receive an
> error.
>
> Why doesn't this approach extend into the future qemu-system binary ?
> List everything, and if the user tries to add a device that's not
> compatible with a machine, then it will simply result in an error.

Device filtering would be complicated, I guess, as there is so much
CONFIG_* for devices. Another approach is to just place devices under an
meson "enable_modules "  (in *.so/*.dll/*.dylib), so it won't be
listed(memory consumption will also be reduced when it's not needed).

But machine listings still need the filtering, considering virt is present
for many different arches(riscv/arm/i686). so machine listing is still a
thing.
The current is_avaible works fine for machines.
Pierrick is already pending the device filtering work, so I guess it's fine
now, we are just filtering the machines according to
https://lore.kernel.org/qemu-devel/20260901202043.26532-1-pierrick.bouvier@=
oss.qualcomm.com/
?

I also add patches based on this, so that we can list machines for
different  arches(riscv/arm/i686) properly for qemu-system, as I add a
TargetInfo parameter to is_available callback.
The patches is at
https://lore.kernel.org/qemu-devel/20260903205018.975-1-luoyonggang@gmail.c=
om/



>
> It seems like much less work overall to do no filtering at all, than
> trying to do per-target filtering which is the wrong granularity to
> begin with, since the device usability contraints come from the
> machine rather than the target.
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000855221065aa47809
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Fri, Sep 4, 2026 at 4:19=E2=80=AFPM Daniel P. B=
errang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com=
</a>&gt; wrote:<br>&gt;<br>&gt; On Fri, Aug 28, 2026 at 04:13:32PM -0700, P=
ierrick Bouvier wrote:<br>&gt; &gt; On 8/28/2026 3:58 PM, Pierrick Bouvier =
wrote:<br>&gt; &gt; &gt; Now that we can link a single-binary with at least=
 two targets (arm, aarch64),<br>&gt; &gt; &gt; we want to make sure that we=
 expose the same set of machines (later devices and<br>&gt; &gt; &gt; cpus)=
 than target binaries. For that, we implemented a static filtering based on=
<br>&gt; &gt; &gt; target interfaces that each machine will implement to de=
clare which targets have<br>&gt; &gt; &gt; this machine.<br>&gt; &gt; &gt;<=
br>&gt; &gt; &gt; However, we discovered that this static filtering is not =
enough. Indeed, some<br>&gt; &gt; &gt; machines and devices do not depend o=
nly on target, and their presence can depend<br>&gt; &gt; &gt; on Kconfig o=
r host/target combination. Thus, our static approach can&#39;t work, and<br=
>&gt; &gt; &gt; we need something more flexible.<br>&gt; &gt; &gt;<br>&gt; =
&gt; &gt; The goal of this series is to focus on the filtering mechanism, n=
ot on the<br>&gt; &gt; &gt; qemu-system binary itself, even though it&#39;s=
 included here to give a full picture<br>&gt; &gt; &gt; of what we are buil=
ding.<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; v3<br>&gt; &gt; &gt; --<br>&gt; &=
gt; &gt;<br>&gt; &gt; &gt; Suggested by Richard, we simply use a callback a=
dded to TypeInfo.<br>&gt; &gt; &gt; Added full example with a single binary=
 for arm+aarch64, and then<br>&gt; &gt; &gt; arm+aarch64+microblaze.<br>&gt=
; &gt; &gt; Also, added scripts/single-binary-compare-cmdline.sh, which com=
pares list of<br>&gt; &gt; &gt; cpus, devices and machines between single-b=
inary and original binaries.<br>&gt; &gt; &gt; This is what we can use in C=
I to ensure we correctly tagged all QOM types.<br>&gt; &gt; &gt;<br>&gt; &g=
t;<br>&gt; &gt; After applying this series, and running<br>&gt; &gt; script=
s/single-binary-compare-cmdline.sh, you&#39;ll see than many devices<br>&gt=
; &gt; are visible for microblaze, and should not.<br>&gt; &gt;<br>&gt; &gt=
; microblaze+arm is a more interesting combination than riscv+arm because<b=
r>&gt; &gt; riscv has a lot of devices in common with arm. On the opposite,=
<br>&gt; &gt; microblaze has a very reduced set (no virtio, no pci, etc).<b=
r>&gt; &gt;<br>&gt; &gt; I would like to focus the conversation on how to f=
ilter the remaining<br>&gt; &gt; types. We could maybe generate something d=
irectly from Kconfig output,<br>&gt; &gt; so we don&#39;t need boilerplate =
for each CONFIG_X entry.<br>&gt;<br>&gt; I&#39;m still not clear on why we =
need to filter the devices at all for<br>&gt; a new &quot;qemu-system&quot;=
 binary ?<br>&gt;<br>&gt; Looking at the device delta listed in your other =
mail, a large number<br>&gt; of those are PCI based. The microblaze machine=
 types don&#39;t expose a<br>&gt; PCI controller, so those PCI devices are =
redundant / won&#39;t be used<br>&gt; with microblaze machines, which is wh=
y existing qemu-system-microblaze<br>&gt; doesn&#39;t link to those devices=
.<br>&gt;<br>&gt; The same is true of many of the arm machines too though. =
Only a subset<br>&gt; of arm machines have PCI, but the qemu-system-arm bin=
ary still includes<br>&gt; and lists all these PCI devices. Users simply ca=
n&#39;t create a PCI device<br>&gt; for the arm machines that lack a PCI co=
ntroller, or they&#39;ll receive an<br>&gt; error.<br>&gt;<br>&gt; Why does=
n&#39;t this approach extend into the future qemu-system binary ?<br>&gt; L=
ist everything, and if the user tries to add a device that&#39;s not<br>&gt=
; compatible with a machine, then it will simply result in an error.<br><br=
>Device filtering would be complicated, I guess, as there is so much CONFIG=
_* for devices. Another approach is to just place devices under an meson &q=
uot;enable_modules &quot; =C2=A0(in *.so/*.dll/*.dylib), so it won&#39;t be=
 listed(memory consumption will also be reduced when it&#39;s not needed).<=
br><br>But machine listings still need the filtering, considering virt is p=
resent for many different arches(riscv/arm/i686). so machine listing is sti=
ll a thing.<br>The current is_avaible works fine for machines.<br>Pierrick =
is already pending the device filtering work, so I guess it&#39;s fine now,=
 we are just filtering the machines according=C2=A0to <a href=3D"https://lo=
re.kernel.org/qemu-devel/20260901202043.26532-1-pierrick.bouvier@oss.qualco=
mm.com/">https://lore.kernel.org/qemu-devel/20260901202043.26532-1-pierrick=
.bouvier@oss.qualcomm.com/</a> ?<br><br>I also add patches based on this, s=
o that we can list machines for different=C2=A0

arches(riscv/arm/i686) properly for qemu-system, as I add a TargetInfo para=
meter to is_available callback.<div>The patches is at=C2=A0<a href=3D"https=
://lore.kernel.org/qemu-devel/20260903205018.975-1-luoyonggang@gmail.com/">=
https://lore.kernel.org/qemu-devel/20260903205018.975-1-luoyonggang@gmail.c=
om/</a><br><br><br><br>&gt;<br>&gt; It seems like much less work overall to=
 do no filtering at all, than<br>&gt; trying to do per-target filtering whi=
ch is the wrong granularity to<br>&gt; begin with, since the device usabili=
ty contraints come from the<br>&gt; machine rather than the target.<br>&gt;=
<br>&gt; With regards,<br>&gt; Daniel<br>&gt; --<br>&gt; |: <a href=3D"http=
s://berrange.com">https://berrange.com</a> =C2=A0 =C2=A0 =C2=A0 ~~ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0<a href=3D"https://hachyderm.io/@berrange">https://hach=
yderm.io/@berrange</a> :|<br>&gt; |: <a href=3D"https://libvirt.org">https:=
//libvirt.org</a> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0<a href=3D"https://entangle-photo.org">https://entangle-photo=
.org</a> :|<br>&gt; |: <a href=3D"https://pixelfed.art/berrange">https://pi=
xelfed.art/berrange</a> =C2=A0 ~~ =C2=A0 =C2=A0<a href=3D"https://fstop138.=
berrange.com">https://fstop138.berrange.com</a> :|<br>&gt;<br><br><br>--<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=
=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang L=
uo</div></div>

--000000000000855221065aa47809--

