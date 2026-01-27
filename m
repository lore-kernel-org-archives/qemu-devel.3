Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80316D2F00D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 12:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkiac-00082f-5n; Tue, 27 Jan 2026 07:54:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkiaR-0007yg-2D
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 07:54:32 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkiaN-0000KS-Ki
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 07:54:25 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-79273a294edso54248097b3.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 04:54:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769518462; cv=none;
 d=google.com; s=arc-20240605;
 b=fCQVoiA3lNkjs8w+ji5JrLVKCultVD/R06IZ+ZNvr3ZhR3X0kcqlDFSxoa25Vcwr4r
 DLQ5OPluxeN/CnHLuu/iYPW7efZBcFg+d1EWoZ0jg8cmvmaXLHcjAonGC1zsmRkCD/7m
 PcvCG2ffpUG3aPAipFHtZ9quTJUo7IF731OxXpsuKeD2fb68ryugBK+Cze+D/nO6vWWi
 9Zn3RFMK4UwZ2BfkklSl0LnNhb2I9sk+0pyKyVlxEj4rav8W6k/mejw+UE7uoOh15/L6
 7JL57yovlqYo+7YEqHLRbT7DDpmdBFCMaRwrwJU2opi+gk/XAg3CYx6VTVmSa11TZe8x
 ymXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pjJvZM2bcvdfsylxzq22IaWA8tQ89V5rS1cP9PpxVLI=;
 fh=dXHoilmhhxY5vg21Ss6PZGFufhldebBfEzqm3qMG63M=;
 b=e9wbEqAZY/Tc87Qhx2wPMwlT2PbCSDNt4ULaPXRDpB1CtvoaHBNpnWwJQvkiUwagnI
 8NZOdmejZhEvAWH2H8Hs8V3mOW9xuLbsADkhujrcQT1tmB/elIxXqcFC7cRaURqB1Eon
 +NTF9uuXjhsGSV7l+pi/hsb6T0YDIFrLXH5ppJgODq5DEHJLbpw5h/nqNVQ2x1TI3OaL
 lRIVRWlvyPCvGgwm2Pz/KMZXwQ8aJ9QdNypcD+RCEtJnVi3fAkcLRdBLiDLOZraqsWTV
 KFVUh5qyXz/drY6oDO66V7nzs83MvkVGFuGHuY1704xrxy2K/al4b/sfCyxNosUPSAsA
 VqoQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769518462; x=1770123262; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pjJvZM2bcvdfsylxzq22IaWA8tQ89V5rS1cP9PpxVLI=;
 b=J0OFpP4Zot/zkitlSh8TBKOKJagazsgOR74CVJVhRgrQ8ncVcnKVgnPpe6+hDAEBWO
 KkuJcHqDPovKbwn8puIynpaMFcjroeeXoWy/pd4vQrw0iENc8J3OmdD1/0bZiwHJrKnl
 IPMJgy0EpizmrH4lqDUb9tlGJNSYlNgZtYeo7AlnEOb2eTbdoLw0Cp/wqP/tTDRjoXe2
 VU1WIq8NFWsppilabA/qXpMHAONFRBisz/jRULbMiEAuUVD2qgkDgGWjsx3ho+4u6X11
 76Jl9iab9vcpm7A8J1oy3oyW4j78RliEQ2FsFujxRN3+uqCcRWr8VOQKIxww9box0X+Q
 7F2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769518462; x=1770123262;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pjJvZM2bcvdfsylxzq22IaWA8tQ89V5rS1cP9PpxVLI=;
 b=IrG7q7z7FBTaa9QMSV5x1CuNBDD3ZOoW639vV3UmDDd/TuvqPwRFnRP5zeHIPc+66J
 Ae+poLgmRpal6o4/WABX3A1Yn7m35aIxiTuFN71Q3Y/LRY18uUS4J3YTf9nQpIRkjUlz
 MheTt4cDEO7umvfo/4p4+aE1MAQuXXUAnWg+6L6NspHBONd+MgXsOsLtB3f3J74qvjzv
 49V3ia3CR6ZJznBZ+kplNcBSHCXKmZfFcsiBUpyHu0TGg1v12DLF/KLlT2Hxvl8weGfE
 6xP2K9Xu05zl3EbmzMJ8hgjtGCICQVea1Kvtz9QHKbLgI4GXkr5LQLYz4u/yLUnc1pn4
 wIpg==
X-Gm-Message-State: AOJu0Yyfz6HIyn3ogvxnf+K37Oyy2EJkKDXwvMrAz5KFnhmdfvMRnCXs
 2sldC94psXrEmC8QYCqNo40zqBPYCFzhXkFK38M6vx5+IVlBflP8wS0mX4SqW2/RTv9XVRO3/tP
 Zoso1KwNWrJNUn93MLhZasA2S3Uoy4MRS0VtCMCOx5w==
X-Gm-Gg: AZuq6aJ/xR7agNnUz1GmZ0kInDy28EuRV23b1G+W11OLiJQgSpi9tlugc0O8HOD1J2E
 fWJvHg5sDEaWOG5bodDkP3Hl6e+zMM3bTEVQ7imhynOQ/CtC14Ie175KSGHtb9P/c9y+d02zFFX
 XsVajQWsO+RWroB8o74BbgAdmVSgAUqtgGb3cC8RFfwa1OD0P7A5/BwJXpws6WVoA/3F/VPeQ05
 TPAKLJcAW9ZKl13eVWT+ibI5egdlgfNvyI4deLTAc0jn2RnTiqAl5PiPTVV0fZF/TtRIw==
X-Received: by 2002:a05:690c:c512:b0:784:8994:297c with SMTP id
 00721157ae682-7947ab2ec4bmr13413167b3.24.1769518462292; Tue, 27 Jan 2026
 04:54:22 -0800 (PST)
MIME-Version: 1.0
References: <20260121134114.9781-1-mohamed@unpredictable.fr>
 <20260121134114.9781-4-mohamed@unpredictable.fr>
 <CAFEAcA-GL9UG5MN5tKDzLwQ04cBGa99cSau4=2BLTs0+GGSdJw@mail.gmail.com>
 <51E78FA9-2C66-4E8E-947F-F009A8AEEDFD@unpredictable.fr>
In-Reply-To: <51E78FA9-2C66-4E8E-947F-F009A8AEEDFD@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jan 2026 12:54:10 +0000
X-Gm-Features: AZwV_QgNC0HlA1MPr4utPBxXleUEBZNKe6e8nSRgWVIeaaKtSNPDbRFTZ7FKyS8
Message-ID: <CAFEAcA_7o-dNFUgMo=UdYD_cf=dwbMCy6b+_2SRSxVbDmmAUmw@mail.gmail.com>
Subject: Re: [PATCH v17 03/21] hw: arm: virt: rework MSI-X configuration
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>, 
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Ani Sinha <anisinha@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, 27 Jan 2026 at 12:46, Mohamed Mediouni <mohamed@unpredictable.fr> w=
rote:
> > On 27. Jan 2026, at 11:54, Peter Maydell <peter.maydell@linaro.org> wro=
te:
> >
> > On Wed, 21 Jan 2026 at 13:41, Mohamed Mediouni <mohamed@unpredictable.f=
r> wrote:
> >> +/*
> >> + * In the prior Qemu ACPI table handling, GICv2 configurations
> >> + * had vms->its=3D1... That's broken.
> >> + *
> >> + * Match that assumption to match the existing ACPI tables that
> >> + * have been shipping for quite a while.
> >> + */
> >> +static int is_gicv2_acpi_workaround_needed(VirtMachineState *vms) {
> >> +    return vms->gic_version =3D=3D 2;
> >> +}
> >
> > We don't need to keep identical bug-for-bug ACPI tables like that.
> > If we were incorrectly reporting an ITS in a GICv2-only ACPI table,
> > that was a bug and we can fix it. (This might need adjusting of the
> > golden reference ACPI data in some of the bios-tables-tests if we
> > were testing that, so it ought to go in its own patch.)
> >
> Hello,
>
> I=E2=80=99m a bit concerned about breaking hibernation in this case=E2=80=
=A6
>
> My intent was keeping this behavior for now and then add a machine model =
version dependent toggle in a follow-up patch.

I'm not an ACPI table expert but my understanding is that it's
OK to change the ACPI table contents without having to make
those changes machine-version dependent. See e.g. commit d6afe18b7242,
which changed the ACPI tables for the its=3Doff case and did not
make those changes machine-version specific.

> >> +bool virt_is_its_enabled(VirtMachineState *vms)

> > Why do we need these? The idea of finalize_msi_controller()
> > is that it fixes vms->msi_controller so that you can just
> > directly say vms->msi_controller =3D=3D VIRT_MSI_CTRL_ITS or
> > vms->msi_controller =3D=3D VIRT_MSI_CTRL_GICV2M rather than
> > having to have more complicated logic.
> >
> It=E2=80=99s because of object_class_property_add_str(oc, "msi", virt_get=
_msi, virt_set_msi) (and the same applies for the its property), is it safe=
 to assume that virt_get_msi/virt_get_its will never be called from that pr=
ior to finalize?

The get and set property functions need to handle the
msi_controller field not having been finalized, but
they are only getting and setting it.

thanks
-- PMM

