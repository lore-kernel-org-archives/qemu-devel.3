Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C518EDF028
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 04:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqO0a-0001lC-6L; Wed, 11 Feb 2026 23:08:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1vqO0V-0001kg-Gp
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 23:08:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1vqO0S-0007Z5-61
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 23:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770869322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w/ZzJlsjguryhKKM4mp+inyBSpPIALEBuDRcop1xgSc=;
 b=bhscUCUf4CZsjChKOIMP76CmWhWCRYy7Zbs0egpFcQAr6/XIiB5ARupKU6U5pxXl6daVyx
 T9L1O2z9Ii1kllIow6NSlgXMVagh3zDq1Ycb0Do4rALFtChSmlljRTjlQlRdjjw83zjHXA
 NyQ4OKL1HY62v8odlX80/Dpj+zd/Hbo=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-yRkN6G7fM1-AwVCokBFDrg-1; Wed, 11 Feb 2026 23:08:40 -0500
X-MC-Unique: yRkN6G7fM1-AwVCokBFDrg-1
X-Mimecast-MFC-AGG-ID: yRkN6G7fM1-AwVCokBFDrg_1770869320
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-66304fd62ebso33445384eaf.3
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 20:08:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770869320; cv=none;
 d=google.com; s=arc-20240605;
 b=PBeqfEp64C+BNiVABOmP1xSZAfBogVN+t8TGUuz8nIuXLCYxT+mkvo64PasKi0vftv
 0k2YU40OLAp2oyaGZ+htHyXyYMnLZjC4eDucwqqaCte3ibFo1HVGmByiyPSc2fgrrlDz
 qPqTpjLkr6m5YRt+bsK+n7qXJMYcuUHF6oU5G3EehJqZ273kaV6KMqFaqwfXxdTXr1Eo
 pD/+CIDvJhsH/R5hCLpWXZghX0dtm/hxEMIOBrKihcHlAvrE/ufpq8+TGQ9Ugmv0AkS1
 qI/zGJ2souvuZLlGDVZ6x5FX90C6M0qNdOXAzRqZ0VXKanBkI/4cbQbh/ntZ38xelOaK
 9p3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=w/ZzJlsjguryhKKM4mp+inyBSpPIALEBuDRcop1xgSc=;
 fh=xy3N5ZLevwlPVuVdj9WIXAbZihg3w5Oou+Rxs6gKl9E=;
 b=ghyE2unpeQVRFG9Tjf9nQNV0alROW8FuekSsCPRSnZ/pEW+MLf4vurgEMJKW+P0UC8
 daX3PS7tKnDoVms7KMAHTTluMk4KifXR/NqwxuzzIHbrHUTuIyH0TrtKkvvTQTr9xNMG
 2hmRYFVIr5jRzS4uecM+UkATa3z5AW2xXE+CoVL8KnEWTp7YvKp5NaRuRoxBeorz/iq2
 spgC4tB1VRT/YA7FHG4unArPbHBxv2L+WFXdlIi+i9otNdtaPTOX4w5JUgasz87OboD3
 4axDoWIydZ1rS8o/kOsjo2VYP5UQg2kvfTB3U+hri1nYnL+hMVpWJ+pLUetwThbiMOCi
 SMNA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770869320; x=1771474120; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w/ZzJlsjguryhKKM4mp+inyBSpPIALEBuDRcop1xgSc=;
 b=RrHt40HxqvD/WRum/JT8vGEieZW097v2m1yFbxz8zAWA9Iza2a6ZMP/jBg/iSCCzpS
 BjgNeDZyDyNEcv7N3wdTypj9Hf9UrwyhA6R2UOKtgWQvVioCFzEPN3mgC3N+xXQgenMj
 K80oMQq4zJWl2GkqSQVSq1zsEZEeBeuCLw/893fFinh1bg4PDlVd0Gd+iyRU/eDlEQO6
 5d9OhXgw5j/G2yDbPnmWGC+Hr+Wqp8r03lJwTIJ0gIXf6OFVnySDvJzVsZRTaHwFayrU
 9u/chpxillh0Ngwwzy/yjRUR/2Gw0cp1+0gdSd2hxYgfSPC57krHpO3XYvewr7wi0P1G
 qSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770869320; x=1771474120;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w/ZzJlsjguryhKKM4mp+inyBSpPIALEBuDRcop1xgSc=;
 b=j1cDhx1/Mkqg8UijGQ2/NcY/v9xoVC4YPkVDEFvN8UsR85iapdOmOEaNK+I9yNKtyK
 Lsv4C2x3ILS1wZdmG0iXW97BbwiDJK0t3Wo8xiSjPV1NS4xt129U5Ejrc8BET8pCupXj
 Y50IYcHIeOB2g9Fsoa1WunQB2ENSB6GWGNQpp2m7nuB773uLKU2/oipKbQGwm0JaxnFe
 hEoBjIAVqjxMGsmaPf4VPyNtgswYWk4xOhgq8oZY4f+ANHjP3S9jIPaTj+rSs3bCZhOe
 xWvyaGo6RbAM2bwWkH1f5US+umAGU7SB+zX10b4KbOnUDrd1sCS1K2cbQle9vyr6C7gt
 kMIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLjfzThBsg9Ccs0Ji0gdaDoCO4lUs6wiwDo83oUZGNkNDZ37zJCyZf8i3+txg13QmjKRW53NSH9pFc@nongnu.org
X-Gm-Message-State: AOJu0YzqfofJ6sHP8dSc6QLhLcXnUjLATAwU7OGLGait6PN/Tbmuvftl
 55o+srn+JyRRO3Q76h5bop5xSX/FkfTa4ByYy01XT60xZTiylOrG9hcwoN7GaGlNRCgpyxBLNJC
 7Y4RHzOdry2lw4W2HrXQvleWxbvVP/RdQGCDkd+n/68qUqshYjBvzPqs/fu/8UUa/K/jTaAGE0x
 13JhOWtpV/tAR78irrFaow48YMOmXEgIM=
X-Gm-Gg: AZuq6aLms2q65PrWPaqheIfaBEhSKoZhr8avkNHsWn/k2cbjKhWauYQwENTGCCuA+/d
 ZJLc1mpG6Jjdvju9s+y5D0ArsoPFhXSk+xdHO9Apj1MQXbdU10a57Hc2Q+m5b56+nB7r5ZeO7HV
 N2vrRFY0HcmM+7BGkFfwPBgNg1RNbtQp5GZGp/aPA9g7G4YMs3BZD5EjJ1ij1AYIookFUxRlZaf
 3Kh2X/SQVGL4gQ7htkypE6Hj/3pKxXmcb5L
X-Received: by 2002:a05:6820:1519:b0:663:8c6:9783 with SMTP id
 006d021491bc7-6759bc9cf91mr808098eaf.69.1770869320038; 
 Wed, 11 Feb 2026 20:08:40 -0800 (PST)
X-Received: by 2002:a05:6820:1519:b0:663:8c6:9783 with SMTP id
 006d021491bc7-6759bc9cf91mr808080eaf.69.1770869319590; Wed, 11 Feb 2026
 20:08:39 -0800 (PST)
MIME-Version: 1.0
References: <20260211122759.125094-1-mbawa@redhat.com>
 <BE3C6640-85CB-437D-A038-81762FA5AD33@unpredictable.fr>
 <CAFEAcA8qtxXP0Uawc+UdSYmpuC8wmpSVkjnYQ_jDQe6zTuNWpA@mail.gmail.com>
 <D5033059-0647-441A-BB8E-91CB6E9DBD3B@unpredictable.fr>
In-Reply-To: <D5033059-0647-441A-BB8E-91CB6E9DBD3B@unpredictable.fr>
From: Mohammadfaiz Bawa <mbawa@redhat.com>
Date: Thu, 12 Feb 2026 09:38:23 +0530
X-Gm-Features: AZwV_QjaUHdMQ9V5YeRas4mzhvLXM4x3yTLVKwjubsVlUF2a7gbh_e5tajeyjCc
Message-ID: <CAJg9Kkyphr--n+Ooo9a+Hr0Yb8EG3G-yPes5T5VXvf62qe2MwQ@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt: Add virtio-transports property
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 alex.bennee@linaro.org, philmd@linaro.org, cohuck@redhat.com, 
 eric.auger@redhat.com, sebott@redhat.com, 
 Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000bd0993064a98a4db"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000bd0993064a98a4db
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ Yan


On Thu, Feb 12, 2026 at 4:45=E2=80=AFAM Mohamed Mediouni <mohamed@unpredict=
able.fr>
wrote:
>
>
>
> > On 11. Feb 2026, at 16:08, Peter Maydell <peter.maydell@linaro.org>
wrote:
> >
> > On Wed, 11 Feb 2026 at 12:50, Mohamed Mediouni <mohamed@unpredictable.f=
r>
wrote:
> >>
> >>
> >>
> >>> On 11. Feb 2026, at 13:27, Mohammadfaiz Bawa <mbawa@redhat.com> wrote=
:
> >>>
> >>> Windows ARM64 guests detect virtio-mmio devices declared in ACPI
> >>> tables even when no backend is attached. This causes "Unknown
> >>> devices" (ACPI\LNRO0005) to appear in Device Manager.
> >
> > Is that a problem? There's a device there, and Windows doesn't
> > support it, so it reports that there's a device there that
> > it doesn't support, which seems reasonable enough.
> >
>
> Hello,
>
> For customers, some security software gets quite unhappy if it sees
> that there are devices with no drivers installed.

Agreed. The main issue is production environments where unknown devices
can cause problems with security compliance and Microsoft certification.

> For development it indeed doesn=E2=80=99t matter.
> >>>
> >>> Until Windows fixes that by supporting, adding a new machine
> >>> property 'virtio-transports' to control the number of
> >>> virtio-mmio transports instantiated. The default remains
> >>> NUM_VIRTIO_TRANSPORTS (32) for backward compatibility.
> >>> Setting it to 0 allows users to disable virtio-mmio entirely.
> >>>
> >>> Usage: -machine virt,virtio-transports=3D0
> >>
> >> Hello,
> >>
> >> With keeping in mind that this was documented in this (closed=E2=80=A6=
) issue
> >> https://github.com/virtio-win/kvm-guest-drivers-windows/issues/595
> >>
> >> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> >
> >>> +    if (transports > NUM_VIRTIO_TRANSPORTS) {
> >>> +        error_setg(errp, "virtio-transports must not exceed %d",
> >>> +                   NUM_VIRTIO_TRANSPORTS);
> >> Any particular reason to (keep) capping the maximum to 16?
> >>
> >> From a cursory look, base_memmap seems to have room for plenty more.
> >
> > My first question to anybody wanting more than 32 here would be
> > "why are you not using virtio-pci" ? The whole virtio-mmio infra
> > in the virt board is only here because at the time we had no PCI
> > support.
> >
> Could it make sense to have it disabled by default for new machine model
versions then?

I think that makes sense. This patch adds the property with the current
default i.e. 32. A follow-up patch could set the default to 0 for the
latest machine version.

> Thank you,
> -Mohamed
> > The advantage of this series to me is that it means we have
> > a way for users to say "I'm not using this functionality,
> > just turn it off completely" which lets them reduce the
> > security surface a little.
> >
> > The other thing worth checking is whether we're correctly
> > following the ACPI spec in exposing virtio-transports with
> > nothing plugged into them, or if we're supposed to be
> > suppressing them.

While researching this issue, I did check x86 microvm, it only adds
devices to ACPI when a backend is detected (checks QTAILQ_EMPTY before
calling virtio_acpi_dsdt_add). ARM virt currently adds all 32 regardless.
So we could also follow similar dynamic suppression but the property
approach
gives users explicit control over the number of transports.

> > thanks
> > -- PMM

--000000000000bd0993064a98a4db
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">+ Yan<br><br><br>On Thu, Feb 12, 2026 at 4:45=E2=80=AFAM M=
ohamed Mediouni &lt;<a href=3D"mailto:mohamed@unpredictable.fr">mohamed@unp=
redictable.fr</a>&gt; wrote:<br>&gt;<br>&gt;<br>&gt;<br>&gt; &gt; On 11. Fe=
b 2026, at 16:08, Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.=
org">peter.maydell@linaro.org</a>&gt; wrote:<br>&gt; &gt;<br>&gt; &gt; On W=
ed, 11 Feb 2026 at 12:50, Mohamed Mediouni &lt;<a href=3D"mailto:mohamed@un=
predictable.fr">mohamed@unpredictable.fr</a>&gt; wrote:<br>&gt; &gt;&gt;<br=
>&gt; &gt;&gt;<br>&gt; &gt;&gt;<br>&gt; &gt;&gt;&gt; On 11. Feb 2026, at 13=
:27, Mohammadfaiz Bawa &lt;<a href=3D"mailto:mbawa@redhat.com">mbawa@redhat=
.com</a>&gt; wrote:<br>&gt; &gt;&gt;&gt;<br>&gt; &gt;&gt;&gt; Windows ARM64=
 guests detect virtio-mmio devices declared in ACPI<br>&gt; &gt;&gt;&gt; ta=
bles even when no backend is attached. This causes &quot;Unknown<br>&gt; &g=
t;&gt;&gt; devices&quot; (ACPI\LNRO0005) to appear in Device Manager.<br>&g=
t; &gt;<br>&gt; &gt; Is that a problem? There&#39;s a device there, and Win=
dows doesn&#39;t<br>&gt; &gt; support it, so it reports that there&#39;s a =
device there that<br>&gt; &gt; it doesn&#39;t support, which seems reasonab=
le enough.<br>&gt; &gt;<br>&gt;<br>&gt; Hello,<br>&gt;<br>&gt; For customer=
s, some security software gets quite unhappy if it sees<br>&gt; that there =
are devices with no drivers installed.<br><br>Agreed. The main issue is pro=
duction environments where unknown devices<br>can cause problems with secur=
ity compliance and Microsoft certification.<br><br>&gt; For development it =
indeed doesn=E2=80=99t matter.<br>&gt; &gt;&gt;&gt;<br>&gt; &gt;&gt;&gt; Un=
til Windows fixes that by supporting, adding a new machine<br>&gt; &gt;&gt;=
&gt; property &#39;virtio-transports&#39; to control the number of<br>&gt; =
&gt;&gt;&gt; virtio-mmio transports instantiated. The default remains<br>&g=
t; &gt;&gt;&gt; NUM_VIRTIO_TRANSPORTS (32) for backward compatibility.<br>&=
gt; &gt;&gt;&gt; Setting it to 0 allows users to disable virtio-mmio entire=
ly.<br>&gt; &gt;&gt;&gt;<br>&gt; &gt;&gt;&gt; Usage: -machine virt,virtio-t=
ransports=3D0<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; Hello,<br>&gt; &gt;&gt;<br>=
&gt; &gt;&gt; With keeping in mind that this was documented in this (closed=
=E2=80=A6) issue<br>&gt; &gt;&gt; <a href=3D"https://github.com/virtio-win/=
kvm-guest-drivers-windows/issues/595">https://github.com/virtio-win/kvm-gue=
st-drivers-windows/issues/595</a><br>&gt; &gt;&gt;<br>&gt; &gt;&gt; Reviewe=
d-by: Mohamed Mediouni &lt;<a href=3D"mailto:mohamed@unpredictable.fr">moha=
med@unpredictable.fr</a>&gt;<br>&gt; &gt;<br>&gt; &gt;&gt;&gt; + =C2=A0 =C2=
=A0if (transports &gt; NUM_VIRTIO_TRANSPORTS) {<br>&gt; &gt;&gt;&gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;virtio-transports must not e=
xceed %d&quot;,<br>&gt; &gt;&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 NUM_VIRTIO_TRANSPORTS);<br>&gt; &gt;&gt; Any pa=
rticular reason to (keep) capping the maximum to 16?<br>&gt; &gt;&gt;<br>&g=
t; &gt;&gt; From a cursory look, base_memmap seems to have room for plenty =
more.<br>&gt; &gt;<br>&gt; &gt; My first question to anybody wanting more t=
han 32 here would be<br>&gt; &gt; &quot;why are you not using virtio-pci&qu=
ot; ? The whole virtio-mmio infra<br>&gt; &gt; in the virt board is only he=
re because at the time we had no PCI<br>&gt; &gt; support.<br>&gt; &gt;<br>=
&gt; Could it make sense to have it disabled by default for new machine mod=
el versions then?<br><br>I think that makes sense. This patch adds the prop=
erty with the current<br>default i.e. 32. A follow-up patch could set the d=
efault to 0 for the latest machine version.<br><br>&gt; Thank you,<br>&gt; =
-Mohamed<br>&gt; &gt; The advantage of this series to me is that it means w=
e have<br>&gt; &gt; a way for users to say &quot;I&#39;m not using this fun=
ctionality,<br>&gt; &gt; just turn it off completely&quot; which lets them =
reduce the<br>&gt; &gt; security surface a little.<br>&gt; &gt;<br>&gt; &gt=
; The other thing worth checking is whether we&#39;re correctly<br>&gt; &gt=
; following the ACPI spec in exposing virtio-transports with<br>&gt; &gt; n=
othing plugged into them, or if we&#39;re supposed to be<br>&gt; &gt; suppr=
essing them.<br><br>While researching this issue, I did check x86 microvm, =
it only adds<br>devices to ACPI when a backend is detected (checks QTAILQ_E=
MPTY before<br>calling virtio_acpi_dsdt_add). ARM virt currently adds all 3=
2 regardless.<br>So we could also follow similar dynamic suppression but th=
e property approach=C2=A0<div>gives users explicit control over the number =
of transports.</div><div><br>&gt; &gt; thanks<br>&gt; &gt; -- PMM<br></div>=
</div>

--000000000000bd0993064a98a4db--


