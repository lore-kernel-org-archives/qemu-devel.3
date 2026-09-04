Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBA8C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Qmr-0007Ea-FM; Fri, 04 Sep 2026 06:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x2Qmp-0007Dp-RH
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:04:43 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x2Qmn-0007dq-3n
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:04:43 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a601ba6870so1267858a12.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 03:04:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788516279; cv=none;
 d=google.com; s=arc-20260327;
 b=YmjXsiOYE1BNOaae8NW95+htPQPkTc0qWrfPvZjKKSlQ4wgboWyJwmBeGxjZkVXLUx
 /asR/Wk4lRcUNo4byoN2diNcaw7U62XF1llSp6dhk/P/oSREhJivOdY3opMH7qF/s4YX
 77/S9B2f4IenOmMjtYMzuIGYlcc0JxhVc6817gE1IXf5ZmnNLu1uFsX6vwTn68A8e/kG
 GquujjnAm2BI52ou6TN9ApjzTeCAy2iecbriJ7lQBFeZNuvJ60I6i/fYVc7S7HUauQxf
 FQI3c/fL3AvNUrAz2UPCgVFE6kkuTXzwz36Xqb2thVehlc6ne4E9dPM8rPEodxt4Fvzt
 g4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=g0s4yXTFvkCk9agr72tKS4vPuK57r38YTa11WuP5kWA=;
 fh=ZGopKE8gYQWoptIihIfi9QQ2EnPlxFvjn3R/Ju7Mgyo=;
 b=ExNFCf742e9IOmq6wrTpP12TMfHxLfGVQmGwG46BjxjKE3tuHBEiWyDIBo7LQqRBQB
 hOd2ZsE2/yLCYGveQBLJxNN2maCw3VZYaHnImROCxYjjY6SRTHM9ZYixIk88ROyElQlC
 bli24Ye5KMRgCzXJ4FjJIPAuaNr5cxegb+v/8w78P+yB/T7sZ43l+PxRHcNeYIKENFGB
 0V3Y82A0YG8mHgNKGVoB/EQetISUCi1JbXIJhT2GwUmMeaFj0JlDxF6jxA84DqfcbU8x
 j8V/W4yolQisD9R5t8jWWvb9k8i7WYsPlbgbntdWwMd50B6OfB4wtvMUtRzVfdK93nE/
 5ktw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788516279; x=1789121079; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g0s4yXTFvkCk9agr72tKS4vPuK57r38YTa11WuP5kWA=;
 b=X5yGPyywVkoLpTLwMLTW+uqKaQel76xao3X/olzwOOrayIvieCMmfm1ZYM+BsjsaYo
 xA+0Bt5biy1fQJlcXsTHJDn/YhOfJLoBNOkTH7gAeuxjASSFdmeHOG8iisHTa6VhkAIs
 84Da8MeMkDBLc/mT8nYMKySdm3EDMFwyTOFxnq8xaKzyUaEpiY3naDEh07RBlgtFOkqm
 ejcjvb8jG5qoOAK1DUKpXBI5MdZ0ehUu++kNGEQhuEVDeVqEcd4btYR/Q/jIvvn8Pw2f
 rMq3fyIIw9k/fq1NdxSa0nWO7qeODbdoDuEStMhFJdPyKHpfDxtn1HiGSenIe6X47utY
 +tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788516279; x=1789121079;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=g0s4yXTFvkCk9agr72tKS4vPuK57r38YTa11WuP5kWA=;
 b=Yn7z8p7Qw0XMAB2ndw0OYx/XsdrN04YbIkjegmCEYi/zcCZp/Z/0IxkukJPjYhitgG
 HugKhB2jj8GIl2eXE7e0wER4pmTX1NZ8VrWOIaOz0nfspyu1uZfLMQg9VhuzKgsTX6oc
 DzcD7oOEY8b5XFdNxkLUrTLd0Tq6h7Kos997p/lOXEwDqob40d+1el5RyFYnUA2HLmPn
 xBOxqIe70rG03CLc0YbtuPP/7oV+HAgdMOxjmvot94YNbyNsjYBsVuGRaPrNvpZG6kHq
 djacLLtosvhVDvUT4c9rDuehJ1i2UKeDe8czWGvqWldkPcJGhopc+q0ggfEOD6BASSu5
 bB9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBweK84XL92xP6ihYvPiYKPhSmLG2wENOg69Ga8t4QQ2Z+ByCdADeVShuag1RdkL/gsoto1auCAMQUmO@nongnu.org
X-Gm-Message-State: AFuF++lx9W/Xybo3a5LVDbGg6ydv+FWD9qc0w1kQn59vOnsSi/YPLvSX
 RyfUHiNVog9QDmsAQvNAtfBegFDfeHxapsDnsXMJPRiIc6yhAE8GTnhh6bie8ng595T8VFHWZRq
 wRVp5QwLhIC3vJysrVuTQWqpYBV6CJqHSEup4B0A=
X-Gm-Gg: AYBFou0voPdrqQmBYixUaGaawU1Rv+1d4+aFYigLf15td4IkWlZl4m+9uQv29h4+zu+
 zFdns3Eo3QNNKjCHUYrPZBN4F2MAsE6MB7JosdAz9D8H6yzuxWeSwFjM/CyiMGm0LWzb3ifKUOs
 uKvk2+9uxacsHvtTjCVB7xq4cl9cwizct2zozYNeyPwNr+DToqwlakY55vyVUc9VdKjFNTrt1OY
 5CjN5nLF2tUPSQLr1nndDBWgPxZdDstMSAcpEYAA2RiL4ddgY+KIQNxXDrSKc30QXsvz/AAvtG4
 CYwFwdIPxU8JhNDIcsO4a3sqZhk3zcyLfaiQqmLWxQGE
X-Received: by 2002:a05:6402:360d:b0:6a6:32f6:f with SMTP id
 4fb4d7f45d1cf-6a7e8f995bamr2060610a12.21.1788516278849; Fri, 04 Sep 2026
 03:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <4b4f77ee-21e9-405e-a1da-21506afa1c5b@oss.qualcomm.com>
 <app_CnHimOrOymMH@redhat.com>
 <CAE2XoE9A1WzOe43-qd1v9i6K9kSru4R2kEE1-2TrztoM=8NZJw@mail.gmail.com>
 <CAFEAcA_4TZxYhFbHfJZCas7bvh_KZjNp2aKzx3LPaXTQFuoQYQ@mail.gmail.com>
 <apqVhJrtMDECUb7I@redhat.com>
In-Reply-To: <apqVhJrtMDECUb7I@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 4 Sep 2026 18:04:24 +0800
X-Gm-Features: AcwNN1UqKgMw5AvGabINm_AgFLf78JmqQx8QN3C9_vB4aG6Dwm91xjteH_I-bXs
Message-ID: <CAE2XoE-qNgNXi5fKzjt5qM4pk8hs+x90h4Bv_8OsJczYHW1_Rw@mail.gmail.com>
Subject: Re: [PATCH 00/47] single-binary: implement dynamic filtering for QOM
 types
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000079e347065aa565ef"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x531.google.com
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

--00000000000079e347065aa565ef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 5:55=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com>
wrote:
>
> On Fri, Sep 04, 2026 at 10:13:04AM +0100, Peter Maydell wrote:
> > On Fri, 4 Sept 2026 at 09:58, Yonggang Luo <luoyonggang@gmail.com>
wrote:
> > > On Fri, Sep 4, 2026 at 4:19=E2=80=AFPM Daniel P. Berrang=C3=A9 <berra=
nge@redhat.com>
wrote:
> > > > I'm still not clear on why we need to filter the devices at all for
> > > > a new "qemu-system" binary ?
> > > >
> > > > Looking at the device delta listed in your other mail, a large
number
> > > > of those are PCI based. The microblaze machine types don't expose a
> > > > PCI controller, so those PCI devices are redundant / won't be used
> > > > with microblaze machines, which is why existing
qemu-system-microblaze
> > > > doesn't link to those devices.
> > > >
> > > > The same is true of many of the arm machines too though. Only a
subset
> > > > of arm machines have PCI, but the qemu-system-arm binary still
includes
> > > > and lists all these PCI devices. Users simply can't create a PCI
device
> > > > for the arm machines that lack a PCI controller, or they'll receive
an
> > > > error.
> > > >
> > > > Why doesn't this approach extend into the future qemu-system binary
?
> > > > List everything, and if the user tries to add a device that's not
> > > > compatible with a machine, then it will simply result in an error.
> > >
> > > Device filtering would be complicated, I guess, as there is so much
CONFIG_* for devices. Another approach is to just place devices under an
meson "enable_modules "  (in *.so/*.dll/*.dylib), so it won't be
listed(memory consumption will also be reduced when it's not needed).
> > >
> > > But machine listings still need the filtering, considering virt is
present for many different arches(riscv/arm/i686). so machine listing is
still a thing.
> >
> > I was wondering if maybe one way to approach that is some
> > "disambiguation" syntax on the machine name; so one could write
> > "-machine aarch64:virt" vs "-machine riscv64:virt" (or whatever) to
> > disambiguate when just "-machine virt" would be ambiguous; but if
> > there's only one machine of that name then just "-machine foo" would
> > work.
>
> Currently the QOM type name is directly derived from the machine
> type name, just with a "-machine" suffix attached. So if the
> machine name is not unique, then neither is the QOM type name.
>
> At the very least we need the QOM type name to be unique. We
> could de-couple the two to make this work though, which does
> not seem too hard.

I have did that, for example:
 hw/riscv/virt.c         | 3 ++-
 include/hw/riscv/virt.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index dd396410178..5e57f9443c2 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1739,6 +1739,7 @@ static void virt_machine_class_init(ObjectClass *oc,
const void *data)
     HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);

     mc->desc =3D "RISC-V VirtIO board";
+    machine_class_set_name(mc, "virt");
     mc->init =3D virt_machine_init;
     mc->max_cpus =3D VIRT_CPUS_MAX;
     mc->default_cpu_type =3D TYPE_RISCV_CPU_BASE;
@@ -1802,7 +1803,7 @@ static void virt_machine_class_init(ObjectClass *oc,
const void *data)
 }

 static const TypeInfo virt_machine_typeinfo =3D {
-    .name       =3D MACHINE_TYPE_NAME("virt"),
+    .name       =3D TYPE_RISCV_VIRT_MACHINE,
     .parent     =3D TYPE_MACHINE,
     .class_init =3D virt_machine_class_init,
     .instance_init =3D virt_machine_instance_init,
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 7c862b0da25..9f96dd98c6a 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -30,7 +30,7 @@
 #define VIRT_SOCKETS_MAX_BITS          2
 #define VIRT_SOCKETS_MAX               (1 << VIRT_SOCKETS_MAX_BITS)

-#define TYPE_RISCV_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
+#define TYPE_RISCV_VIRT_MACHINE MACHINE_TYPE_NAME("riscv-virt")
 typedef struct RISCVVirtState RISCVVirtState;
 DECLARE_INSTANCE_CHECKER(RISCVVirtState, RISCV_VIRT_MACHINE,
                          TYPE_RISCV_VIRT_MACHINE)


Maybe we have a better way for it?

For device conflict, that needs to be detected after the qemu-system is
present.


>
> >       That extends nicely to truly heterogenous machine names:
> > "-machine my-mixed-machine" wouldn't need the user to explicitly
> > give it a -target option or otherwise say that it includes aarch64
> > and microblaze CPUs. (We'd probably need to put something in to
> > prevent future machine name clashes across targets, so that the
> > only clashes are our existing legacy ones.)
>
> We don't have many examples of clashing machine names. Is there
> any beyond just the 'virt' boards ? Now that we know we want
> globally unique names, this feels easy enough to spot during
> review.
>
> > This rests on the assumption that the only thing we need to
> > disambiguate is machine names, i.e. there aren't multiple
> > targets with user-facing (i.e. not easily renameable) device
> > names that are shared.
>
> IMHO it is best if our goal is to ensure type names are unique
> throughout the codebase, so hopefully we don't have clashing
> device names.
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

--00000000000079e347065aa565ef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br><br>On Fri, Sep 4, 2=
026 at 5:55=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berran=
ge@redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt; wrote:<br>&gt;=
<br>&gt; On Fri, Sep 04, 2026 at 10:13:04AM +0100, Peter Maydell wrote:<br>=
&gt; &gt; On Fri, 4 Sept 2026 at 09:58, Yonggang Luo &lt;<a href=3D"mailto:=
luoyonggang@gmail.com" target=3D"_blank">luoyonggang@gmail.com</a>&gt; wrot=
e:<br>&gt; &gt; &gt; On Fri, Sep 4, 2026 at 4:19=E2=80=AFPM Daniel P. Berra=
ng=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com" target=3D"_blank">berra=
nge@redhat.com</a>&gt; wrote:<br>&gt; &gt; &gt; &gt; I&#39;m still not clea=
r on why we need to filter the devices at all for<br>&gt; &gt; &gt; &gt; a =
new &quot;qemu-system&quot; binary ?<br>&gt; &gt; &gt; &gt;<br>&gt; &gt; &g=
t; &gt; Looking at the device delta listed in your other mail, a large numb=
er<br>&gt; &gt; &gt; &gt; of those are PCI based. The microblaze machine ty=
pes don&#39;t expose a<br>&gt; &gt; &gt; &gt; PCI controller, so those PCI =
devices are redundant / won&#39;t be used<br>&gt; &gt; &gt; &gt; with micro=
blaze machines, which is why existing qemu-system-microblaze<br>&gt; &gt; &=
gt; &gt; doesn&#39;t link to those devices.<br>&gt; &gt; &gt; &gt;<br>&gt; =
&gt; &gt; &gt; The same is true of many of the arm machines too though. Onl=
y a subset<br>&gt; &gt; &gt; &gt; of arm machines have PCI, but the qemu-sy=
stem-arm binary still includes<br>&gt; &gt; &gt; &gt; and lists all these P=
CI devices. Users simply can&#39;t create a PCI device<br>&gt; &gt; &gt; &g=
t; for the arm machines that lack a PCI controller, or they&#39;ll receive =
an<br>&gt; &gt; &gt; &gt; error.<br>&gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &=
gt; Why doesn&#39;t this approach extend into the future qemu-system binary=
 ?<br>&gt; &gt; &gt; &gt; List everything, and if the user tries to add a d=
evice that&#39;s not<br>&gt; &gt; &gt; &gt; compatible with a machine, then=
 it will simply result in an error.<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; Dev=
ice filtering would be complicated, I guess, as there is so much CONFIG_* f=
or devices. Another approach is to just place devices under an meson &quot;=
enable_modules &quot; =C2=A0(in *.so/*.dll/*.dylib), so it won&#39;t be lis=
ted(memory consumption will also be reduced when it&#39;s not needed).<br>&=
gt; &gt; &gt;<br>&gt; &gt; &gt; But machine listings still need the filteri=
ng, considering virt is present for many different arches(riscv/arm/i686). =
so machine listing is still a thing.<br>&gt; &gt;<br>&gt; &gt; I was wonder=
ing if maybe one way to approach that is some<br>&gt; &gt; &quot;disambigua=
tion&quot; syntax on the machine name; so one could write<br>&gt; &gt; &quo=
t;-machine aarch64:virt&quot; vs &quot;-machine riscv64:virt&quot; (or what=
ever) to<br>&gt; &gt; disambiguate when just &quot;-machine virt&quot; woul=
d be ambiguous; but if<br>&gt; &gt; there&#39;s only one machine of that na=
me then just &quot;-machine foo&quot; would<br>&gt; &gt; work.<br>&gt;<br>&=
gt; Currently the QOM type name is directly derived from the machine<br>&gt=
; type name, just with a &quot;-machine&quot; suffix attached. So if the<br=
>&gt; machine name is not unique, then neither is the QOM type name.<br>&gt=
;<br>&gt; At the very least we need the QOM type name to be unique. We<br>&=
gt; could de-couple the two to make this work though, which does<br>&gt; no=
t seem too hard.<div><br></div><div>I have did that, for example:</div><div=
>=C2=A0hw/riscv/virt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 3 ++-<br>=C2=A0include=
/hw/riscv/virt.h | 2 +-<br>=C2=A02 files changed, 3 insertions(+), 2 deleti=
ons(-)<br><br>diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c<br>index dd396=
410178..5e57f9443c2 100644<br>--- a/hw/riscv/virt.c<br>+++ b/hw/riscv/virt.=
c<br>@@ -1739,6 +1739,7 @@ static void virt_machine_class_init(ObjectClass =
*oc, const void *data)<br>=C2=A0 =C2=A0 =C2=A0HotplugHandlerClass *hc =3D H=
OTPLUG_HANDLER_CLASS(oc);<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0mc-&gt;desc =3D =
&quot;RISC-V VirtIO board&quot;;<br>+ =C2=A0 =C2=A0machine_class_set_name(m=
c, &quot;virt&quot;);<br>=C2=A0 =C2=A0 =C2=A0mc-&gt;init =3D virt_machine_i=
nit;<br>=C2=A0 =C2=A0 =C2=A0mc-&gt;max_cpus =3D VIRT_CPUS_MAX;<br>=C2=A0 =
=C2=A0 =C2=A0mc-&gt;default_cpu_type =3D TYPE_RISCV_CPU_BASE;<br>@@ -1802,7=
 +1803,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void=
 *data)<br>=C2=A0}<br>=C2=A0<br>=C2=A0static const TypeInfo virt_machine_ty=
peinfo =3D {<br>- =C2=A0 =C2=A0.name =C2=A0 =C2=A0 =C2=A0 =3D MACHINE_TYPE_=
NAME(&quot;virt&quot;),<br>+ =C2=A0 =C2=A0.name =C2=A0 =C2=A0 =C2=A0 =3D TY=
PE_RISCV_VIRT_MACHINE,<br>=C2=A0 =C2=A0 =C2=A0.parent =C2=A0 =C2=A0 =3D TYP=
E_MACHINE,<br>=C2=A0 =C2=A0 =C2=A0.class_init =3D virt_machine_class_init,<=
br>=C2=A0 =C2=A0 =C2=A0.instance_init =3D virt_machine_instance_init,<br>di=
ff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h<br>index 7c862=
b0da25..9f96dd98c6a 100644<br>--- a/include/hw/riscv/virt.h<br>+++ b/includ=
e/hw/riscv/virt.h<br>@@ -30,7 +30,7 @@<br>=C2=A0#define VIRT_SOCKETS_MAX_BI=
TS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02<br>=C2=A0#define VIRT_SOCKETS_MAX =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; VIRT_SOCKETS_M=
AX_BITS)<br>=C2=A0<br>-#define TYPE_RISCV_VIRT_MACHINE MACHINE_TYPE_NAME(&q=
uot;virt&quot;)<br>+#define TYPE_RISCV_VIRT_MACHINE MACHINE_TYPE_NAME(&quot=
;riscv-virt&quot;)<br>=C2=A0typedef struct RISCVVirtState RISCVVirtState;<b=
r>=C2=A0DECLARE_INSTANCE_CHECKER(RISCVVirtState, RISCV_VIRT_MACHINE,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 TYPE_RISCV_VIRT_MACHINE)<br></div><div><br></div><div><br></d=
iv><div>Maybe we have a better way for it?</div><div><br></div><div>For dev=
ice conflict, that needs to be detected after the qemu-system is present.</=
div><div><br></div><div><br>&gt;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 That ext=
ends nicely to truly heterogenous machine names:<br>&gt; &gt; &quot;-machin=
e my-mixed-machine&quot; wouldn&#39;t need the user to explicitly<br>&gt; &=
gt; give it a -target option or otherwise say that it includes aarch64<br>&=
gt; &gt; and microblaze CPUs. (We&#39;d probably need to put something in t=
o<br>&gt; &gt; prevent future machine name clashes across targets, so that =
the<br>&gt; &gt; only clashes are our existing legacy ones.)<br>&gt;<br>&gt=
; We don&#39;t have many examples of clashing machine names. Is there<br>&g=
t; any beyond just the &#39;virt&#39; boards ? Now that we know we want<br>=
&gt; globally unique names, this feels easy enough to spot during<br>&gt; r=
eview.<br>&gt;<br>&gt; &gt; This rests on the assumption that the only thin=
g we need to<br>&gt; &gt; disambiguate is machine names, i.e. there aren&#3=
9;t multiple<br>&gt; &gt; targets with user-facing (i.e. not easily renamea=
ble) device<br>&gt; &gt; names that are shared.<br>&gt;<br>&gt; IMHO it is =
best if our goal is to ensure type names are unique<br>&gt; throughout the =
codebase, so hopefully we don&#39;t have clashing<br>&gt; device names.<br>=
&gt;<br>&gt; With regards,<br>&gt; Daniel<br>&gt; --<br>&gt; |: <a href=3D"=
https://berrange.com" target=3D"_blank">https://berrange.com</a> =C2=A0 =C2=
=A0 =C2=A0 ~~ =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://hachyderm.io/@b=
errange" target=3D"_blank">https://hachyderm.io/@berrange</a> :|<br>&gt; |:=
 <a href=3D"https://libvirt.org" target=3D"_blank">https://libvirt.org</a> =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a h=
ref=3D"https://entangle-photo.org" target=3D"_blank">https://entangle-photo=
.org</a> :|<br>&gt; |: <a href=3D"https://pixelfed.art/berrange" target=3D"=
_blank">https://pixelfed.art/berrange</a> =C2=A0 ~~ =C2=A0 =C2=A0<a href=3D=
"https://fstop138.berrange.com" target=3D"_blank">https://fstop138.berrange=
.com</a> :|<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=
=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=
=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div></div></div>

--00000000000079e347065aa565ef--

