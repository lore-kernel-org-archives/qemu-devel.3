Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EDF109C038
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 07:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5f8Z-0006ZH-Nw; Thu, 26 Mar 2026 03:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1w5f8X-0006YY-VM
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 03:28:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1w5f8W-0005CO-6v
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 03:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774510089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=skfkRrlJIzl/sVe+1N8j0cWXw5Ey1N8CqF/FoAstlRc=;
 b=OF5WV6UIXwVDb/9Ai3QD2CMCV0mXWl4kj/1rBU5mj39fUoE0JfQBgq6VLSzwKTYdOs17E/
 2eAvV21XN1bGK9wc08Xg/QxrrPOU/O/+IMHj/NNz6Cbj2MldWw3IebK5+M63urDpxP1Ff9
 oI/2DCL0psuuVdvqJ0YduwDBoD2bZeM=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-ep7UzN-rNfmNrwsh11Ac8g-1; Thu, 26 Mar 2026 03:28:06 -0400
X-MC-Unique: ep7UzN-rNfmNrwsh11Ac8g-1
X-Mimecast-MFC-AGG-ID: ep7UzN-rNfmNrwsh11Ac8g_1774510086
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7d7c848c866so661442a34.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 00:28:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774510086; cv=none;
 d=google.com; s=arc-20240605;
 b=eo+tolSNjdCysaR67wWDVn2CY7mZAqjuhjd9uAjC3BgCoPfwT6P+bjOK+V7roAimMl
 DvESvF36TWUQuQC7GftFApx84xb0MY9lWsX8+JtBmCxpQ+KDo2qV/iIApKMV74Zrw+xK
 3531C0Evjw+PGp7RIWDqjT9eUOIHSyT1ECrfsvC+ocruCfkXYRYJgsNi98lLk5tTZdtG
 rpOaWlw+Okguxmd4DGGNzRroLJ87ycsOGW/wCURt9bQLPJdp6cKh7AX+JWz+3dXZ6Wy6
 EpGCQ62lMcjCU7cnPVi6+PhejGG85ICzlKGxChApVYn7EmfSxS3F/84lPtSv+qjGdeei
 UAwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=skfkRrlJIzl/sVe+1N8j0cWXw5Ey1N8CqF/FoAstlRc=;
 fh=Wrhg5oovPyliHpCfXIErTO+5+PpLYkhASlAhWYPLwGg=;
 b=h5pNJYD7G8q97IZfXILaH7h9WlQrWDNx4bVvAPR6NYfMCRyH9vKrkVXg+2KVNW3pnt
 KTc0GbH1bUtLl9VwBEFoafh5nsCCu8KO1yqfzk44VkUsI+8+q6e0c3Sb+X38OYewIAh0
 RdFPgNGpLAAWhCsPBgvTQJyH/OOmztYCgD2Jku6zVmggt3EszfnTWUq20+w3u/RUu/TS
 vSv8G8/8Ww2SycMtftrpKnq2OytHRXeAIuEuFLox35Z/hvi/OCU2nRquM6WDOdSbdp9V
 ZlP0sIn3DoTppjY7NGrFwoTMFZaKj4TgpEu/DRdY50DuS6LMLPPRpls44eQByFmE9i3N
 0GbA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774510086; x=1775114886; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=skfkRrlJIzl/sVe+1N8j0cWXw5Ey1N8CqF/FoAstlRc=;
 b=HV610hh2cBTH9DrE5h7HqEPjaTqXj9jau+wYyDSqpNOPgRUP0k0AIYUWb499Y8OCyB
 NGPMRsgk8JFCZQKKIoq9vZ36Si4JyWYemx2Ne86Q+o+Otz9qmW+A1Wo3ZtyCpf51ZHFt
 2x0ebTD4am2cXKBTgBd8pWzpRa7X+hnIO7vLVdF685kCPiF/x9wQeGyx3boEokd9972w
 PrKY5NHgpDAJogKa1puSccYVBksNrdwtoGFjXtdKyiMTflPcEErv9hrSAwT5V99cR7kl
 s32bJ+/TBn1yYK2s8hR4+RLwXDcKVu9neKu4IJ7OzZeKaQ8XrbZszkrYPYVukW/mZIG2
 okEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774510086; x=1775114886;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=skfkRrlJIzl/sVe+1N8j0cWXw5Ey1N8CqF/FoAstlRc=;
 b=atFDB4nN70kFujCb1RSEBShrmwoUYl8rywTmFSYyon81mh1E+L0XEkwsERkkAMTS9Q
 AQp3hTQgUVZPHFGYFN9uMTeUG8rDX/bwRS2PoJhnNSjqN44DW+S2SewPC8cC1YePZe4Z
 yYrT0OSZ0+dsWQLBGZ4yrogF+6we57xe/hzLuDARus/o7fb+9K+86y1jFSYV3aqlDBxB
 YZ8qZxH+Ev0WFDRevJxlzJEyBIKvhR/EfN1VTRK3kIDK25iFBYbsYLD7Dfonjb0oJhhM
 C0OhRUhNzHwo4G1AUah/UdBjOIi1CtKTKiBsB2MgRkpE6bWZr0WgEx4EH4KI0qi7AWpN
 TcmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKPZZhAQFbMTSG1edQbGRbrmVzZR0WM2a5hqqNaApiRL22CZGnbZbkU2Z/Fwe6VPKZrx02eyyfg7xi@nongnu.org
X-Gm-Message-State: AOJu0YzHuDTe6V+gVjCZ7fvZfdbWLHkpQJf4GSv9hhXSFYZ6Vgnp85nz
 OMx6E9zY8RilYTBcZNcdWFDLfag2D66zSjPkWr9HxLwrsP99gYmJyjReJzyw4W0NnaaK9Q3aNaQ
 x6SZFM19/t7qOvqFuXJnm9PWq5jJZVRpWyBhFamoRZnHH0WYIVv5y0oEmfZdE+JCJaBIb1nuvUb
 92nsPLjh5068wf3UEYIyNlyp4l7tqqmNE=
X-Gm-Gg: ATEYQzySzHCmTFDmdPge9oUX99UpftLKmcSX3a7y4qxRXIRhzW3Y81xB5Y3YkUAXIYy
 bf+9fRtikLCkvd+v7+o1pKn+WYKgwYzsd6whXMb3r8oIL6XMqBd6QTjzY8IBC+CzLzHocYQketo
 a11CynZtvKWn6irsZnvukNSR3h52lT5lXktNvQGsQqVRd+IXxn24vbYO1tttyiTnfRg6nTTz/IM
 39m8Pv61TH7Xonq3rPJbN4rZpJMaHX/CCTiIu8=
X-Received: by 2002:a05:6820:16a4:b0:67d:2cb:207a with SMTP id
 006d021491bc7-67dff5701c6mr3252391eaf.55.1774510085676; 
 Thu, 26 Mar 2026 00:28:05 -0700 (PDT)
X-Received: by 2002:a05:6820:16a4:b0:67d:2cb:207a with SMTP id
 006d021491bc7-67dff5701c6mr3252380eaf.55.1774510085219; Thu, 26 Mar 2026
 00:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260324-tpm-tis-sysbus-ppi-v1-0-e59175210954@redhat.com>
 <20260324-tpm-tis-sysbus-ppi-v1-1-e59175210954@redhat.com>
 <c6830a19-c275-4a83-bb17-4430680b3d54@linux.ibm.com>
 <A2BD2FA0-6D5F-47DC-BF2B-017ABE5F31AB@unpredictable.fr>
 <07ff064e-bea4-4beb-811a-f5f3485836d6@linux.ibm.com>
In-Reply-To: <07ff064e-bea4-4beb-811a-f5f3485836d6@linux.ibm.com>
From: Mohammadfaiz Bawa <mbawa@redhat.com>
Date: Thu, 26 Mar 2026 12:57:48 +0530
X-Gm-Features: AQROBzByYSjBQi1uP80mfH_YCddiU-SfdoGBt0CPDqgyTHCes9HpLFg4hc9MXuk
Message-ID: <CAJg9Kky1q=5DFDPkh-i1hyxCKmpuEnR02hrHN-ncewY2VO0LQA@mail.gmail.com>
Subject: Re: [PATCH 1/3] docs/specs/tpm: document PPI support on ARM64 virt
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Mar 26, 2026 at 2:01=E2=80=AFAM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
>
>
> On 3/25/26 4:22 PM, Mohamed Mediouni wrote:
> >
> >> On 25. Mar 2026, at 20:31, Stefan Berger <stefanb@linux.ibm.com> wrote=
:
> >>
> >>
> >> I remember having played around with TPM for QEMU on ARM64 (Raspberry =
5(?)) a while ago and had the impression that there was something related t=
o caching that prevented the MMIO interface from working correctly and Pete=
r may have confirmed this back then on IRC .. I am not sure what exactly it=
 was that didn't work correctly when run natively on ARM hardware. It worke=
d well when run in CPU emulation on x86_64 for example. So I am wondering w=
hether there is a minimum requirement for an ARM CPU or ARM CPU features re=
lated to caching that someone needs to know about to be able to use TPM TIS=
 successfully? If so, it would probably be good to mention it here as well.=
 If you know.
> >>
> >> Otherwise this looks good to me.
> >
> > Hi,
> >
> > There are two things here:
> >
> > - For Windows guests it=E2=80=99s a bit complicated
> >
> > Windows guests LDP accesses on the TPM register range which doesn=E2=80=
=99t match ISV=3D1
>
> oh, yes, right ldp instruction.
>
> > syndrome requirements and needs a workaround in current QEMU.
> >
> > I _think_ the QEMU-side workaround described below went in, which is:
> >
> > If we map the TPM register range as read directly, trap on write to wor=
karound
> > usage of LDP then we hit...
> >
> > - FEAT_S2FWB
> >
> > This is part of Armv8.4 onwards officially* and allows KVM to force a d=
evice
> > memory type read to be promoted to write-back.
>  > > That allows the (easiest) workaround for (1) to work.
> >
> > However that=E2=80=99s not the _only_ workaround, you can remove it and=
 include
> > https://patchew.org/QEMU/20260317174740.31674-1-lucaaamaral@gmail.com/ =
instead.
> >
> > That works fine and removes reliance on FEAT_S2FWB.
> >
> > * some older Arm chips implement equivalent semantics without signallin=
g it, but
> > that might depend on SoC-level integration.
>
>
> It would be good to mention in the docs what the user needs to know
> about CPU requirements, if anything, so that it can actually work. If
> these recent modifications/patches make the TIS work on any processor,
> then there's nothing to mention...
>
> >
> > Thanks,
> > -Mohamed
> >

Thanks Stefan, Mohamed

I wasn't aware of the LDP / S2FWB angle, appreciate the context.

Looking into it, the FEAT_S2FWB requirement is for TPM TIS MMIO access
in general on ARM64 and predates this series. The PPI region we're
adding is RAM-backed (memory_region_init_ram_device_ptr), so it
shouldn't be affected by that issue.
and for our testing we used an Ampere Altra Max M128-30 (Neoverse N1
r3p1, MIDR 0x413fd0c1). TPM TIS works correctly with Windows 11 ARM64
guests with this fix.

Regards,
Faiz


