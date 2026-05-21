Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B8BCD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 15:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ5aK-00012W-HO; Thu, 21 May 2026 11:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ5aI-00011i-9c
 for qemu-devel@nongnu.org; Thu, 21 May 2026 11:45:18 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ5aG-000619-I1
 for qemu-devel@nongnu.org; Thu, 21 May 2026 11:45:18 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-65dd9b25829so5002662d50.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 08:45:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779378315; cv=none;
 d=google.com; s=arc-20240605;
 b=bCg7/26blKGkBqa5DqOkubylCktj3vADduqaRMXH1YwnOkpluNLgoX0dFB3THstimq
 +bSCwUaKpus/9y7cB9laG/GDkk/6ipgt1c2kVIkyEzXR49NXrIk+O2mu4Gtr6/A+Nn3h
 a5Amdj2QewwbfHZy2pnWPnLg67yyGXkgKqGE5rG/WTnBF//UDkQuSPSYRFx4XuIGjr/9
 eQdcLvUBodB33N4mdgi4hhGT/bhn5wGQqWBhPVSFjhlsFQSym7GPgdfZQQcwhGGBee7U
 BgUTEOxxgRUH+xoQJhkV3T9gG5+SuAmKQ8AAW+7OmB/HB8nAyS8JdVkZ4pfZQL7a7/xs
 i3Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=np6MfwVNRi1F2S5o/BMQc+ARaZat+BgxJcILbYuMVgU=;
 fh=X7muAGaOu/D3kxxfk8zru5fZ+TJ5IoJPIpSBhI+2RmU=;
 b=Gk8wlv/fi+WHdKK+wLTYFm2Uyz1VQC611q0pKhxWbGIjLbUymCkf9C6JqbBM5SpfDH
 PiZln8DIFzw638+OlD9wKx5cYfxIMMBlnGd2DohtzLzeYIkd6jHeuUdxCJ1TIDrpyD0C
 UKGTbMxElQbGQeIfZEIEstvtLH/KbLGd/0r4C85OLMXBtAiMOBB4Hv9nWMcyJVlCEeh4
 exeSnrGW8IGx9vN5wb9vDsY6fY/ncNxSoT3IEiFfP6mFBy3rmS0rV8i9fsz5mXy7WJfd
 6mUTUsjpgORpObiGrKf4WeM9r0yvCkO2Iq+13SqvPR6f51DnH/XQtIX8FMWLOvpDOLGn
 4q6g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779378315; x=1779983115; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=np6MfwVNRi1F2S5o/BMQc+ARaZat+BgxJcILbYuMVgU=;
 b=H+8mgGk8E0R22+ZyPihdzPSI4e2hRrXRjI/x4JGoRwgnYYR55Z10RFNorsntDJFFHP
 /7Tyr2LRNAHxdPTyxupfBnNxfDns8hFomMT4Jsie/sorMd5yo7BmcEdH/biBJ26eyQ+z
 NT1Y0cvbD/RWWsqLE/jGjiJ0QS0F8T1s6p4Jx3UiwPnibDM73yhdKo7Ifr5J1FSjMKgn
 v95zjuYTtwZlwyj6TvskgjvQTp9KOFlk06yMAyvR98wySeWsazKkG5gyLgc3/kluetOB
 xA/xWLNMtWi0ZSIOOgWl/6yBx1YkJTpZi0ZGWc3A18hhdlvFRUA9T3Qv/OVhhk6hmTxF
 l8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779378315; x=1779983115;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=np6MfwVNRi1F2S5o/BMQc+ARaZat+BgxJcILbYuMVgU=;
 b=f2d5tEHvIbnMz42WZOe3h7FClIdtvFP/XR5jrH77DwaRNqMQN4XiZaZZgW4ffuPK3g
 Bbfql0h6Ic3wtxFcEVwSo2hlaLWdjhTRVGg7zEaG7o+pz9kYGFGQXtfvjeEEwfyPL1RN
 br0H56+4HRZLPGSppSXnEwKS2mgIUPGdkU9g2YipDAL+fMrQ8jxq6Q4jEP0JDwsRbi6j
 u/BK9JTDVs1wIugWcM+MJXkPAf/Xz3aNaTkFmAf1xQnSCCRBP69p1F2BRZ6lKEe/iuyS
 F6BQDtjMe9uvaIKRuHTBYLWkoekcXE99xxUXYcv6cP25+1043lk8CD1MOlUeE3M7KZGD
 qGKA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/nBp5gTV3S/EWcR1Mm4kPs0KOzhbJ7sh1MjEC/jVkxd/yMrFOybdFLO0p4PI3Y4tL6BP0mcu31mqwR@nongnu.org
X-Gm-Message-State: AOJu0Yx8Rk7uOjIM6PQRZUhwkDShFcYIDBBdpX3QxY43hnchnrRZILzG
 HYDPZizyxuWMe95CemIMNL+R7RLa59FjW1fznubwc6cS05/fbb6p6lmcGx+5dbDofHlkstCtw3K
 Voxn7YmAE6hhjYbp7Oy6e4BssAPgRsyz70Nx3GsuyAw==
X-Gm-Gg: Acq92OE8TBg1Tf46+FgwodBM+9vkNZbKUloeqzCaOeVp6cOYaBt3dSuFu4T+2Yry0GS
 dIJQm+ydmySKf8ohFJdxOtm6axqt4sTghOCOE5wRWyAsVEEKVXko37t9KuPUv503F593BWNpnA0
 Q2L6UC8t0t/BIC5UckDyfn/jzkHy9UKYMphs07pBDWJWPGwIY+dxAcz4FIFN17Br3UAVu2Bg1jB
 /cFRKX/oVt2tomlP6YfAQmdzqeIOiXMIyi5HNF9e5akslewiw1ePzCm7fiBt8+avTzhVrVb7Gq2
 gAIpPpof1jOu+E04Y/jmwVRfnbPIps0Q7dvlbCE93kkyPON2guEOFEVxlsXuQmaUIEA=
X-Received: by 2002:a53:d048:0:20b0:650:1aa5:8594 with SMTP id
 956f58d0204a3-65eae1525bfmr2400890d50.49.1779378314809; Thu, 21 May 2026
 08:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-2-richard.henderson@linaro.org>
 <874ik0okia.fsf@draig.linaro.org>
In-Reply-To: <874ik0okia.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 16:45:03 +0100
X-Gm-Features: AVHnY4LhWPxynQ0F9w0MW-e15CvJd7aKM3WKX2KWR9l4HgVjox8ZxDcd3ZSqVT0
Message-ID: <CAFEAcA_tJm2FmpYsMM0ThooPk82PORNNavPzUt-1DgUS=KC=ow@mail.gmail.com>
Subject: Re: [PATCH v6 01/64] target/arm: Implement ID_AA64ISAR3
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 21 May 2026 at 16:33, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Richard Henderson <richard.henderson@linaro.org> writes:
>
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  target/arm/cpu-features.h    | 9 +++++++++
> >  target/arm/helper.c          | 8 ++++++--
> >  target/arm/cpu-sysregs.h.inc | 1 +
> >  3 files changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> > index 4e44245a8b..50776347a5 100644
> > --- a/target/arm/cpu-features.h
> > +++ b/target/arm/cpu-features.h
> > @@ -244,6 +244,15 @@ FIELD(ID_AA64ISAR2, CSSC, 52, 4)
> >  FIELD(ID_AA64ISAR2, LUT, 56, 4)
> >  FIELD(ID_AA64ISAR2, ATS1A, 60, 4)
> >
> > +FIELD(ID_AA64ISAR3, CPA, 0, 4)
> > +FIELD(ID_AA64ISAR3, FAMINMAX, 4, 4)
> > +FIELD(ID_AA64ISAR3, TLBIW, 8, 4)
> > +FIELD(ID_AA64ISAR3, PACM, 12, 4)
> > +FIELD(ID_AA64ISAR3, LSFE, 16, 4)
> > +FIELD(ID_AA64ISAR3, OCCMO, 20, 4)
> > +FIELD(ID_AA64ISAR3, LSUI, 24, 4)
> > +FIELD(ID_AA64ISAR3, FPRCVT, 28, 4)
> > +
> >  FIELD(ID_AA64PFR0, EL0, 0, 4)
> >  FIELD(ID_AA64PFR0, EL1, 4, 4)
> >  FIELD(ID_AA64PFR0, EL2, 8, 4)
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index 8240f1b384..6ad01b345f 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -6519,11 +6519,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
> >                .access =3D PL1_R, .type =3D ARM_CP_CONST,
> >                .accessfn =3D access_tid3,
> >                .resetvalue =3D GET_IDREG(isar, ID_AA64ISAR2)},
> > -            { .name =3D "ID_AA64ISAR3_EL1_RESERVED", .state =3D ARM_CP=
_STATE_AA64,
> > +            { .name =3D "ID_AA64ISAR3_EL1", .state =3D ARM_CP_STATE_AA=
64,
> >                .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 6, .opc2 =
=3D 3,
> >                .access =3D PL1_R, .type =3D ARM_CP_CONST,
> >                .accessfn =3D access_tid3,
> > -              .resetvalue =3D 0 },
> > +              .resetvalue =3D GET_IDREG(isar, ID_AA64ISAR3) },
> >              { .name =3D "ID_AA64ISAR4_EL1_RESERVED", .state =3D ARM_CP=
_STATE_AA64,
> >                .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 6, .opc2 =
=3D 4,
> >                .access =3D PL1_R, .type =3D ARM_CP_CONST,
> > @@ -6752,6 +6752,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
> >                                 R_ID_AA64ISAR2_BC_MASK |
> >                                 R_ID_AA64ISAR2_RPRFM_MASK |
> >                                 R_ID_AA64ISAR2_CSSC_MASK },
> > +            { .name =3D "ID_AA64ISAR3_EL1",
> > +              .exported_bits =3D R_ID_AA64ISAR3_FAMINMAX_MASK |
> > +                               R_ID_AA64ISAR3_LSFE_MASK |
> > +                               R_ID_AA64ISAR3_FPRCVT_MASK },
>
> With this definition should we also add it to arm_clear_aarch64_idregs()
> which clears the other ISARs with aarch64=3Doff?

Yes. I wonder if there's some way to get the new cpu-sysregs.h.inc
machinery to automatically produce code to zero any
ARMISARegisters::idregs[] element whose index is for
a register whose encoding is an AA64 idreg (which I think
means "CRm >=3D 4")...

-- PMM

