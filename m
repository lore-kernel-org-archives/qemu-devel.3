Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A7BD2F036
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 14:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkjm1-0002n3-Ah; Tue, 27 Jan 2026 09:10:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkjlv-0002lW-M7
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:10:23 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkjlt-0007tz-Qe
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:10:23 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-78fc174ada4so45580137b3.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 06:10:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769523020; cv=none;
 d=google.com; s=arc-20240605;
 b=ICTMCEf1fjU7T/M4rOdrP0MF7JOPI6Bwn3fMhagZoK2DPzVXsXX7MY9LiNKfeYATMX
 GL5p5yDKXM4yfSB9uxVPd+UJUuWNe+OyWCuJ4MoP+wQoVey4KEfhKb6OnbaRkkjWMelj
 f1YVSX/KI9FAgqszZUKUT8Ldlw0jePP142S9qfZiqL+iOVf9yFLz7ucL7DprnHCYeirK
 s4dd5l/u2LZBpAKy1w4/UqpT3I1Jii9VekX/BlBThjd7teesqJ2S2E5y7K0QdynEYRd6
 FTLnD57ZW5xMB7V3A6TBXM2NPbpIgK6+91vy11b48K/S2gPxUCRvhwk5UXkwrc1sL+da
 8eGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rM8MuC1J7uOkpxHdH5HbN6VRKpCSDyEJgSbG700eyqk=;
 fh=dXHoilmhhxY5vg21Ss6PZGFufhldebBfEzqm3qMG63M=;
 b=RrAedb4sJVsgyYRrswBvL7HD1zMQlLAfWrSoYYRqVYfaIediqH3q2+yfyn1OZdxsu1
 AvrVeK85RhMUzvbMm1OfJzx/MX7gvnDCmEM6b3dO/d9I/qJQ36qNKaknohmW/VEgYhYV
 okkkeDugOS6vlFyMLmrpxvIR3tf6TtH9XoYcy1q72Gi9VH0tsHKMINz+s17XlBKe9MQe
 P2KZRQNnwRapKI0Al7XkH//+E/JBIquLEfExuKh2uCxf83XOfTjTRnq8DOVn/WObwDp5
 mchWlt2/pbuc7/x2OvRUb8U0+PJp85sgU2eocHK56mQdR8xQ+fQ8tm3AsS3z9LzwbLZ3
 EVzA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769523020; x=1770127820; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rM8MuC1J7uOkpxHdH5HbN6VRKpCSDyEJgSbG700eyqk=;
 b=q+v0/24HAJToWlINyF7/PalKzbMWA9lr2ofXF8PGPTkskgCbCfc8bfa0SsWZme10TJ
 60aFYG1/w9abY5QwUD2gHcWF2E0BRkRIRwLghpMqeI9ZMJr2Gd5Qv2pm29PNrraBNpNW
 U4ihSpKYEazhR774xwDF8/9acDS7q414kT1XuKP1IOTu26wwQKdNVXWP/U4SnHVwkKoN
 L1bfumm5bVYjwsBaFH6PYqUZmlaZQguB/Eq/gGwftew11oJwjSRNlKAvVjo3c90fSzRF
 4iNSP1sXgFy+DynUEv59T/ZD22J4d95XGCDY5sSG7f7hQppIVNuWwYlA08bde4LwLQ96
 x42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769523020; x=1770127820;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rM8MuC1J7uOkpxHdH5HbN6VRKpCSDyEJgSbG700eyqk=;
 b=MFoUqLKTql1CSsRhFrmllHNGgfIOfrDkiwE5UQMopOFbaweDyiL3nMu05ZrxvtjFM6
 xVkjDCljbddWaMXBz4Dj4S8i/Q27OSLhmC2LErEVLgTPy+6xCRYaW5UHo79Qih4XFrks
 NcOX2pfcvHTGQyRMCEkki+rXP92mKrpyZDVgjsvSo8MEGvLK9CI8BJ1nA6DcOvWYLvRs
 mtWDaphYatjUKHa3vLBIkzBnl3WpLyeTjh8+3VC1HalmJr2IAR/cML4i10NqfmpzHpdR
 smvTZi1GNJAwFeA+8vl6IVigy5+T5DpMiW9cGQRvmh6Le+eYQuWZ/cuu3e1H3cKZd+bF
 qfqA==
X-Gm-Message-State: AOJu0Yz5Oq9W+aFAKI7iHmhlq8/SHQh3TTM5GIKK27YpUfgAW1ZvkF/k
 BMP0ZOh7oEHCKFRxagWtLuvTp0EtVLyBmZOzcCnLj+I11JXKmN9j2XPGyy80gmJb3ohFsH0Rr0M
 rKwiE8BzahP3SKTbIkt4TA/aAhlNL2edR6a1/xna4/Q==
X-Gm-Gg: AZuq6aILgpw4XQBK038q8gWJwMSfKGYwPAmHFGdLSHLPrTEkAiQfbQXtaQ/pPbqbRqm
 D4YhJEgm3oMY2WLD/fa4HmQG94CU3eqN6Oo4MYrsZD76mkIu1yIS57Oh1ATYe4nY3516xLlXycd
 eZWMqOFBVJfflW5VhaAOWa7XCmfJtAnV63wX8amL1zSyVLMDJu05pBz5mfBMyd084DiTS6lFoVz
 U23W3VClUyImjC9JexRn7tZV+IdUCSiu7y4xSs2DchXlbQxX0FNaHkm4rPNbSmm865FMA==
X-Received: by 2002:a05:690c:680d:b0:786:5851:2b4 with SMTP id
 00721157ae682-7947ab2ef90mr11718287b3.27.1769523020186; Tue, 27 Jan 2026
 06:10:20 -0800 (PST)
MIME-Version: 1.0
References: <20260121134114.9781-1-mohamed@unpredictable.fr>
 <20260121134114.9781-4-mohamed@unpredictable.fr>
 <CAFEAcA-GL9UG5MN5tKDzLwQ04cBGa99cSau4=2BLTs0+GGSdJw@mail.gmail.com>
 <51E78FA9-2C66-4E8E-947F-F009A8AEEDFD@unpredictable.fr>
 <CAFEAcA_7o-dNFUgMo=UdYD_cf=dwbMCy6b+_2SRSxVbDmmAUmw@mail.gmail.com>
 <9ECB5E0B-3BD3-47D3-9E6B-204A354CEA84@unpredictable.fr>
In-Reply-To: <9ECB5E0B-3BD3-47D3-9E6B-204A354CEA84@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jan 2026 14:10:08 +0000
X-Gm-Features: AZwV_Qh3uo6Gn-snLu6oxPFdGxKgQIhWXFNzo6S8v8uVCPgQF2I3zoklomP2uEs
Message-ID: <CAFEAcA_g3VfRectVpUG-OnLh_AtsqpLt7YYrYXDSfiesS5EuKw@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Tue, 27 Jan 2026 at 13:40, Mohamed Mediouni <mohamed@unpredictable.fr> w=
rote:
>
>
>
> > On 27. Jan 2026, at 13:54, Peter Maydell <peter.maydell@linaro.org> wro=
te:
> >
> > On Tue, 27 Jan 2026 at 12:46, Mohamed Mediouni <mohamed@unpredictable.f=
r> wrote:
> >>> On 27. Jan 2026, at 11:54, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> >>>
> >>> On Wed, 21 Jan 2026 at 13:41, Mohamed Mediouni <mohamed@unpredictable=
.fr> wrote:
> >>>> +/*
> >>>> + * In the prior Qemu ACPI table handling, GICv2 configurations
> >>>> + * had vms->its=3D1... That's broken.
> >>>> + *
> >>>> + * Match that assumption to match the existing ACPI tables that
> >>>> + * have been shipping for quite a while.
> >>>> + */
> >>>> +static int is_gicv2_acpi_workaround_needed(VirtMachineState *vms) {
> >>>> +    return vms->gic_version =3D=3D 2;
> >>>> +}
> >>>
> >>> We don't need to keep identical bug-for-bug ACPI tables like that.
> >>> If we were incorrectly reporting an ITS in a GICv2-only ACPI table,
> >>> that was a bug and we can fix it. (This might need adjusting of the
> >>> golden reference ACPI data in some of the bios-tables-tests if we
> >>> were testing that, so it ought to go in its own patch.)
> >>>
> >> Hello,
> >>
> >> I=E2=80=99m a bit concerned about breaking hibernation in this case=E2=
=80=A6
> >>
> >> My intent was keeping this behavior for now and then add a machine mod=
el version dependent toggle in a follow-up patch.
> >
> > I'm not an ACPI table expert but my understanding is that it's
> > OK to change the ACPI table contents without having to make
> > those changes machine-version dependent. See e.g. commit d6afe18b7242,
> > which changed the ACPI tables for the its=3Doff case and did not
> > make those changes machine-version specific.

> That commit didn=E2=80=99t affect the default/regular config so it wouldn=
't have been too problematic in practice.
>
> Have had countless issues with how brittle hibernation is* - and more or =
less subtle ACPI table changes
> tend to break it.

I don't want to add back-compat handling for this to the virt
board unless one of our ACPI table experts says that yes we
do need to keep the ACPI table contents identical for older
versioned machine types.

thanks
-- PMM

