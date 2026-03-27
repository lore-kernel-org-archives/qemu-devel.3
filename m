Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B8F10ED640
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 10:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w647e-0003zo-4W; Fri, 27 Mar 2026 06:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1w647c-0003zI-7R
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 06:08:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1w647a-00076u-9u
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 06:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774606131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4sl/ucF0z92wYCfZMh5MMcZ9XqzhtmdFwlz4nBSYCgs=;
 b=eu+TJCGI3ix0S9x35W8CpGWcB5CxddlxgPj0ziuPsgNRC0MambWVv8sHh8KOetTSirEQAB
 IJO8ojsfEN/8Vj+fSHlmQ2sgpM3ZVf8xYT2ZSlq1ewoemXcin3CZ4WZ3qjxqU+N3kJ2/s/
 tfWH9bE73b+wKTypI1YSfyLLDYgd3Y8=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-Q6Ntjx6rNiGHjo6sAzsscA-1; Fri, 27 Mar 2026 06:08:49 -0400
X-MC-Unique: Q6Ntjx6rNiGHjo6sAzsscA-1
X-Mimecast-MFC-AGG-ID: Q6Ntjx6rNiGHjo6sAzsscA_1774606129
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-67e1381ac1dso3929882eaf.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 03:08:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774606129; cv=none;
 d=google.com; s=arc-20240605;
 b=lR0Ye4fRoGHWzOtmeWzYMCfaVC3o+SLWPy0yDQqE/2ysqWd6cF4fRbW3AaaQJNeM3q
 sIuuWyS9jkPCX1IkIyuMxtBMU32wXALYgu2+C/i7xBdKrfbGip/Wz4L9BTMtw8Ppt/0R
 Fiqgyjg8WlQ5EbsjLnN8vPnq8der7qrs9PXiFYTVGU3ybXixH453tOmPiT46DFdFr8fE
 5EhCYmen/9nkM6GnGz5q0kJijcxdjtDGAQ6+gQ36eUueyibsHgIKczd1w9PDHN8oFh3p
 CK1Sqj+oFv9kOOqb9+wbZ4zLKFOG8bSIwj9dgkGaghAyFCQXc10v4i7DgxpiYgCILfzr
 ifpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4sl/ucF0z92wYCfZMh5MMcZ9XqzhtmdFwlz4nBSYCgs=;
 fh=rCe9BsHHcPLNY69FTIr2naGJ+Ti8BUI37xepFiyO84I=;
 b=kOCf+WcVh4jTM2OqxdD3tx5aLuMD/bQr26ikXULjie8mFavdDf7291FlEMl951FxoQ
 blD4V1j0ZXprWKsi6E/9/+jqk2zgvJcd2vkgrLxYDJV/QjzGeRd9ntsb/gXzw5he5Z+m
 qF9kTxLMSds0Xp2kiykng+4p4Ac5znxPIvB1OlcA/lbNwJoV+Xserq7Uey0JNfF8JiNV
 KJPJ0ddVE8yvxzdGjYrNS0/tczwyh9+Bok/ZGy4x3tG/mjQOMg/ecxls83ZVd+bYQy1H
 OH6fwUt5EK27fDS3KOblh/QNeYurqGeiNSQv3135A6VPztST17zAVICGKsQk0+4ETc5M
 n4Uw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774606129; x=1775210929; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4sl/ucF0z92wYCfZMh5MMcZ9XqzhtmdFwlz4nBSYCgs=;
 b=WLQLo+y6zt/RjrwnKcMcO5CsPj+NwuoR2lUhT0PQQGxv2w0VAOvGOGs7iFWwApFGao
 TW9b/Lq4K++dXgvSmL/ZRC05A1BNYIjqqzhDn5ttOuYB+rf5p2a8v6l95Y8wVF+F/DEk
 1+a6mKiBsJC0gH9fYGlZ/LFXizJLrX6G5/xUCdnHesBv7pxGvWGdGs4yWYF6XvuxAbGh
 7e6hB92UohSIGqil5aJmAN8opsQrBFQCrlTfUIQyuGBR1qImNmycaT68/fAtx11PZAGE
 itSUX2dTaMIMI3atwiQ6io2xVG6ESsuXtp4fxTa76W2IVcBXqWed1gWNW6FkqLhBwAxz
 Oj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774606129; x=1775210929;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4sl/ucF0z92wYCfZMh5MMcZ9XqzhtmdFwlz4nBSYCgs=;
 b=ZdBfYnPMsFlaMkgIcGy6kzyn1jiKtl9cjSEGdU0kw5e/qRg8U9tyW8tygjesBy+xVu
 tgzGqdIaGNhkFDX2A5fN3xkelJPEyPJVGeqmLuWjWJ1iaP2QP0V343WQc7XU18GlIf4t
 G3aUPd7LCDCvHrwM8MLKAlogH6gpp5yl/ljmAEgVwOZqr0PKKeWfScLMbSc9+B+PTO5O
 Ld2gJmJgJdJs16j/2xHaTkoN8nxkYcxSMIz/jlPAGWb5IpszR4g+coRinYaiTvCOBWI5
 BBasVhwvGhJQsQcnIHnvKCGDHshHnw7tthiFVFgxxlzdnYV9CGc/iW+NRR+MTYLfY4jm
 UZbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX4gVuvgRUXDTKRgwSZk+DcMR/S2TGKYsQMMyxnbZuaiuMw2UPlHdNvDTw0n4VKLHGHIEL15JCilPe@nongnu.org
X-Gm-Message-State: AOJu0YxSvHVn5VZrgQZB9DyRA6fhU54zIp+Z1UWVaJqsDQicoGAm19hd
 HfFJx7XW4qbHLsTH/ZCMdHvcPKrQu3yIvId68oJW9ymsLnzURJx0jlFKys/2XjJcI4A8Y4haggO
 htlYkW/iUS7xndLYaLGb90gxg94dLsqY0LSDRZkoDOTO088Wxnh2ZmG0+eVbZ9g/QDCn5NTcXKr
 YHxZyKYDL69WDzAeyEeB4upj01eiQgvP0=
X-Gm-Gg: ATEYQzzwIao2/knsRpk/T1dScQ5afoeYYWxQemNEs0UUFD0EbmqZaqOyZFgR9gC0kq8
 MI+du2ZiglBhjRV2FOAV9Xsgd/B9AulEP8rioeR5jo2P0soKXGjX9z1UeG4JRbcVtmpgkAW5Mrc
 +5cSKiUSnwtPSOAtpxxNGnEfBLyCaXVwQWiELoYfhYBsxZkhQd74Qn5ByBxoipPVYKrrqU/scaU
 5Kp5kuHamUPjFN3ytlWSihTC6mzXGJxaB3K0rQ=
X-Received: by 2002:a05:6820:1b19:b0:67e:10a0:8267 with SMTP id
 006d021491bc7-67e1863c3e4mr994118eaf.22.1774606128849; 
 Fri, 27 Mar 2026 03:08:48 -0700 (PDT)
X-Received: by 2002:a05:6820:1b19:b0:67e:10a0:8267 with SMTP id
 006d021491bc7-67e1863c3e4mr994098eaf.22.1774606128430; Fri, 27 Mar 2026
 03:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260324-tpm-tis-sysbus-ppi-v1-0-e59175210954@redhat.com>
 <20260324-tpm-tis-sysbus-ppi-v1-1-e59175210954@redhat.com>
 <c6830a19-c275-4a83-bb17-4430680b3d54@linux.ibm.com>
 <A2BD2FA0-6D5F-47DC-BF2B-017ABE5F31AB@unpredictable.fr>
 <07ff064e-bea4-4beb-811a-f5f3485836d6@linux.ibm.com>
 <CAJg9Kky1q=5DFDPkh-i1hyxCKmpuEnR02hrHN-ncewY2VO0LQA@mail.gmail.com>
 <EAD6E043-B77B-478E-91D6-863B0E185CFC@unpredictable.fr>
In-Reply-To: <EAD6E043-B77B-478E-91D6-863B0E185CFC@unpredictable.fr>
From: Mohammadfaiz Bawa <mbawa@redhat.com>
Date: Fri, 27 Mar 2026 15:38:32 +0530
X-Gm-Features: AQROBzDrLMiyVVPf09jCChXIjpZB8bJHYGMQRB2k0QDCjS1ynthDpgeoOgxA6aE
Message-ID: <CAJg9KkwznOFSzcme_6A44Er7dd6Ae+szWF+Fwh4dw=Hyv3BWVg@mail.gmail.com>
Subject: Re: [PATCH 1/3] docs/specs/tpm: document PPI support on ARM64 virt
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Mar 26, 2026 at 4:59=E2=80=AFPM Mohamed Mediouni
<mohamed@unpredictable.fr> wrote:
>
>
> > On 26. Mar 2026, at 08:27, Mohammadfaiz Bawa <mbawa@redhat.com> wrote:
> >
> > On Thu, Mar 26, 2026 at 2:01=E2=80=AFAM Stefan Berger <stefanb@linux.ib=
m.com> wrote:
> >>
> >>
> >>
> >> On 3/25/26 4:22 PM, Mohamed Mediouni wrote:
> >>>
> >>>> On 25. Mar 2026, at 20:31, Stefan Berger <stefanb@linux.ibm.com> wro=
te:
> >>>>
> >>>>
> >>>> I remember having played around with TPM for QEMU on ARM64 (Raspberr=
y 5(?)) a while ago and had the impression that there was something related=
 to caching that prevented the MMIO interface from working correctly and Pe=
ter may have confirmed this back then on IRC .. I am not sure what exactly =
it was that didn't work correctly when run natively on ARM hardware. It wor=
ked well when run in CPU emulation on x86_64 for example. So I am wondering=
 whether there is a minimum requirement for an ARM CPU or ARM CPU features =
related to caching that someone needs to know about to be able to use TPM T=
IS successfully? If so, it would probably be good to mention it here as wel=
l. If you know.
> >>>>
> >>>> Otherwise this looks good to me.
> >>>
> >>> Hi,
> >>>
> >>> There are two things here:
> >>>
> >>> - For Windows guests it=E2=80=99s a bit complicated
> >>>
> >>> Windows guests LDP accesses on the TPM register range which doesn=E2=
=80=99t match ISV=3D1
> >>
> >> oh, yes, right ldp instruction.
> >>
> >>> syndrome requirements and needs a workaround in current QEMU.
> >>>
> >>> I _think_ the QEMU-side workaround described below went in, which is:
> >>>
> >>> If we map the TPM register range as read directly, trap on write to w=
orkaround
> >>> usage of LDP then we hit...
> >>>
> >>> - FEAT_S2FWB
> >>>
> >>> This is part of Armv8.4 onwards officially* and allows KVM to force a=
 device
> >>> memory type read to be promoted to write-back.
> >>>> That allows the (easiest) workaround for (1) to work.
> >>>
> >>> However that=E2=80=99s not the _only_ workaround, you can remove it a=
nd include
> >>> https://patchew.org/QEMU/20260317174740.31674-1-lucaaamaral@gmail.com=
/ instead.
> >>>
> >>> That works fine and removes reliance on FEAT_S2FWB.
> >>>
> >>> * some older Arm chips implement equivalent semantics without signall=
ing it, but
> >>> that might depend on SoC-level integration.
> >>
> >>
> >> It would be good to mention in the docs what the user needs to know
> >> about CPU requirements, if anything, so that it can actually work. If
> >> these recent modifications/patches make the TIS work on any processor,
> >> then there's nothing to mention...
> >>
> >>>
> >>> Thanks,
> >>> -Mohamed
> >>>
> >
> > Thanks Stefan, Mohamed
> >
> > I wasn't aware of the LDP / S2FWB angle, appreciate the context.
> >
> Hello,
>
> > Looking into it, the FEAT_S2FWB requirement is for TPM TIS MMIO access
> > in general on ARM64 and predates this series.
>
> Yes, it was added as a workaround for baseline Windows support.
>
> > The PPI region we're
> > adding is RAM-backed (memory_region_init_ram_device_ptr), so it
> > shouldn't be affected by that issue.
>
> FEAT_S2FWB is for the case where the guest tries to access as MMIO
> while the memory region is RAM-backed.
>
> From a quick look at the Linux kernel driver it does a
> devm_ioremap_resource which assumes MMIO in drivers/char/tpm/tpm_tis.c
>
> Hence relying (further) on FEAT_S2FWB.
>

that makes sense I was thinking about it from the host side.

> > and for our testing we used an Ampere Altra Max M128-30 (Neoverse N1
> > r3p1, MIDR 0x413fd0c1).
>
> Neoverse N1 systems with the Arm CMN fabric aren=E2=80=99t exactly the ri=
ght
> system to test this. They don=E2=80=99t advertise FEAT_S2FWB but technica=
lly
> have equivalent semantics.
>
> Once the ISV =3D 0 syndrome support patches get in, there=E2=80=99ll be a=
 nicer
> way than relying on undocumented support for those semantics or relying
> on FEAT_S2FWB without querying it, by switching those away from RAM-backe=
d
> to an MMIO trap.
>
> Thanks,
> -Mohamed
>
>

For v2, I see a few options for the docs and wanted to get your take:

-Add a note in the PPI section mentioning the FEAT_S2FWB requirement
for TPM TIS on ARM64
-Add it as a separate general "TPM TIS on ARM64" note since the
requirement predates PPI and applies to the TIS MMIO region as a whole
-Hold off until the ISV=3D0 syndrome support patches land, since they'd
remove the FEAT_S2FWB dependency and make any note we add now outdated

I'm also testing on additional hardware - Marvell ThunderX2 (Armv8.1,
no FEAT_S2FWB) and Nvidia Grace (Neoverse V2, Armv9, has FEAT_S2FWB)
-- to get proper coverage across the spectrum. Happy to report
results.


