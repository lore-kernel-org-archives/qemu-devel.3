Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57A7CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDnh0-00052H-Fr; Mon, 05 Oct 2026 14:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDngo-00051x-BG
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:45:30 -0400
Received: from mail-ed2-x10.google.com ([2a00:1450:4864:33::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDngm-0004oG-HA
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:45:30 -0400
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a6063d7dc4so2771410a12.3
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:45:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791225926; cv=none;
 d=google.com; s=arc-20260327;
 b=bozCNBsyPiiMsEbnWRo8qlK/BeYYMLN4JnyfsivOhImX9SDEIUF6QifWhx27RiAodM
 Y1eravty4OZewTQgdBVDE14Uh7TRCOvCP+RhbKMFBZWVkpO0Tc5Bsuq50Vf6eswhT/hp
 nGwOHirt5bzdSxn45hjQ/lgdlhk4TnsTOcG6xQkRIgB6Yun6tCsrCUUx160MYHL+vLpx
 lVR/Wyalgz+ABA0djRNONqW+roBiQWCa0mg1WoiAAJ+FXtrTcAg7eAKZ+U/8uEZKcUq5
 qtfc038VGoHLjsfZkHGLBVWcUa8Ko9Tc1uwHcraSLMsZMnsZYyVn2Z8b1lkYWmREGFGc
 eD5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=IWfUiCYd2+Z5XLYUj72WvwcI5uiXXAbrqDCUBe00fVc=;
 fh=IWV5i/bmsnDDiumGg7GH/qn1tjabzJqEv+mL/WiBNIs=;
 b=UswWKYa3xhMYe6GPfOLrKo25OGZDqcfS5ypu33TjcydL9WCAuYsPjwoeU9W7kIXIl6
 WAcexyHkjV4PnQjhSvM4jGBlRsiFkuWtB/2ZXAlS/Snn8kADzI4QRs21cYE+MzwceHO8
 f1/5bNgEwuk9tssAgwvCY9mgusCkz5bXRx1qNBvhdbvXNtJpDalEu6sN7QZ7HafZtSBw
 0ChplqNwyX5BRSCQ+o1C1o80qlJSFSndTw0Fl4SwXUSWEfFtf54gFEush5x13CFRvPkx
 JhdocO2CUVwDEiBMPCnkjLUWEr0sENTAGmotK3rOVoCeVgn0K+2j3TuSxrprrrbQgpIj
 nRcQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791225926; x=1791830726; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IWfUiCYd2+Z5XLYUj72WvwcI5uiXXAbrqDCUBe00fVc=;
 b=b+h0riTQc45vL7buWapiDmEgfU9Ok95ErAXOnk2C0kxuUh6wghAOvNBkGijKzRv6ma
 Hr58zHDjV0na0frASQ8YucBYmL1Izu5iiuyiHVgRFKHHUegRc779+Lp8h8DITMSmS3fA
 Ec2J6e0DlEcnacdS3ZI3hk5yhZLFja8oP2y47lxOBCvM/D+tO/xH61DfFM4QGdomvKMW
 NxJxQh7ycE08zWIyY4ZwkcwmwOmEUOKVZx1p9tjrjuZFYvwSgC1H3/H5ROx+JVg9FqZf
 cb7U/lE9IBXWVAWFx13y+tDXIOG4L808OkBTe0da0HRAvzXky5SSTkOPIlI5jwdsCunq
 vYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791225926; x=1791830726;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IWfUiCYd2+Z5XLYUj72WvwcI5uiXXAbrqDCUBe00fVc=;
 b=NfFBvFvifFqZro6Xa+BJ46RG+GZDrUc09lMnk60xOKsC9zHNdjyEDQIl2yoUFSpg0C
 rKSWyyQSfaTdgHvTZ0k0kWlPDt0Jf3BiVSebDyn++ADJjb6sbfbqOFen5F+NusLKYEjX
 1B/jwZsJ2gDuvMJjbPITg3igbWWHdnA6AjhW6wwWpOn4uOxPXr2zTscvE9qp3PSkCLwc
 Vpuby4YQDvyinYbUqvheC0DnLmYZS9fHRH58kqqj4aEjGsS9jyigN78pHwE4spbghUWo
 ZceOMxRV2XT2r7IJjJ+J46oybCfs8A9nCR116jUfJd/bO9XQmIzuyQIDthMV+HGj+sml
 r7nw==
X-Gm-Message-State: AFq9FYIFVTOcq0dkpmp4i3BAsV/tCmyRR/nYBnnRB9auN1EdakORVF7W
 rgeHb0+E2nTIlm8VpvvqVdS9qeCN+HOlmHsCn36JlryfU8AuNk4caYEcIcJZxqhPWiGBowBpe4y
 a0KpK42t8m2yW+R3kqmf0X44WC6gJ1WM=
X-Gm-Gg: AYBFou1Zq4kqd1bTIQgrAYRNlOWuy4Sk2ainpcvh0P+E7FT+Xm+KucUwe1crgcJovAM
 e0OigAKHAm/eWzedvKr0xKkFrUY2BoYMWXKSSTU4WqQfHgpA6/s27BFZPRDa8c1MzOCfb1naInB
 BfX9/VmiXqacUhzECc7OlnmIlXm5vNLpo6CTe5wj3o/2ZcYzxtc4HWEqPQsulA9jmFvvFaqsqyM
 f69jdjve7F4ZmhjgU5d8LFx1f7eXMEyfRPYaa1UOnfGNfuEpaeg+P9uKDxlbmssq35RGv1ZLwhe
 7j1HqPw+PV2KNDqqevmBUT3I7iqI30/dDjzAsn1D3lsUzM272SRICr3Qw3x65KEUeQ==
X-Received: by 2002:a05:6402:13cd:b0:6ab:6e:a8e4 with SMTP id
 4fb4d7f45d1cf-6af9e31de84mr8646099a12.44.1791225926027; Mon, 05 Oct 2026
 11:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <20261004072927.1142-1-luoyonggang@gmail.com>
 <0b84bf4d-3b98-4f52-8847-9f89bef92c1e@oss.qualcomm.com>
 <CAE2XoE-joWZwrBy-jLe+=ZP7OGM9cyDrF_5hz7koVPODeys+JA@mail.gmail.com>
 <b2297f92-a685-4399-a755-bbe5a37b9b3f@oss.qualcomm.com>
 <CAE2XoE-4Pdp_n3RgpqJ5se_KTHniMAJAodTLmkfV+0jjou=M5w@mail.gmail.com>
 <c6bd8e8d-3160-46c2-ba4a-2f5a4b93cf38@oss.qualcomm.com>
 <CAE2XoE9PKNgE1Zz_frOq_DrgqrPL4B8hcq0xO6ywCNTeUnFLvA@mail.gmail.com>
 <63d20cc8-8003-489c-9f08-28369a2f71e2@oss.qualcomm.com>
In-Reply-To: <63d20cc8-8003-489c-9f08-28369a2f71e2@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 6 Oct 2026 02:45:13 +0800
X-Gm-Features: AclHuK8TU8e4ytjUpz6PQHZVGEPpvwzTyanARfmGaZFrG4eU49L0-Mt4Jkd9cOI
Message-ID: <CAE2XoE9uqEcjMsqJXu6Cr+MrposPjq7O6Lnj5cj7uW2nF38uAg@mail.gmail.com>
Subject: Re: [PATCH 0/4] target-info: preserve full softmmu target identity
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Oct 6, 2026 at 2:06=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/5/2026 10:04 AM, Yonggang Luo wrote:
> > On Tue, Oct 6, 2026 at 12:25=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>
> >>>> Ok, but I'm not sure it answers the why.
> >>>> Could you explain the benefits?
> >>>
> >>> Which part? keeping target_arch as SYS_EMU_TARGET__MAX for user-binar=
y because
> >>> The following original code would return -1 for some user-binary
> >>> +    SysEmuTarget arch =3D target_info()->target_arch;
> >>> +
> >>> +    if (arch =3D=3D SYS_EMU_TARGET__MAX) {
> >>> +        arch =3D qapi_enum_parse(&SysEmuTarget_lookup, target_name()=
, -1,
> >>> +                               &error_abort);
> >>> +    }
> >>> +    return arch;
> >>> So basically assigning any value for the user binary is valid.
> >>> SYS_EMU_TARGET__MAX is more explicit as it's related to type SysEmuTa=
rget.
> >>> -1 is another option but easy to confuse.
> >>>
> >>>
> >>> For why commit e934c624f32f6f44f427d73a2e6a67e983a02ae6.
> >>> "target-info: Statically initialize target_arch"
> >>> doing that, I am not sure.
> >>>
> >>
> >> I guess there is a (good or bad) reason for which sub variants of
> >> targets are not reflected in SYS_EMU_TARGET enum. We should double che=
ck
> >> that before doing any change, as it might have other consequences.
> >
> >
> > You=E2=80=99re right to ask, and I need to correct my earlier suggestio=
n:
> > leaving user-mode target_arch
> >  as SYS_EMU_TARGET__MAX is not safe. target_aarch64() is used by ARM
> > code shared with user-mode builds,
> > including cpu-max-v8.c, where its result indexes a two-entry array.
> > For aarch64-linux-user, the sentinel could therefore cause an
> > out-of-bounds access during type registration.
> >
> > I checked the distinction: softmmu needs the full system-target
> > identity, including variants such as mipsel;
> > user-mode variants such as aarch64_be use their base TARGET_ARCH
> > (aarch64) for this enum. I=E2=80=99ll keep the full TARGET_SYS_EMU
> >  value for softmmu and use TARGET_ARCH for user-mode builds, rather
> > than leave the field at SYS_EMU_TARGET__MAX.
> >
>
> That's technical details, but not an answer to the initial question of
> why we need to change anything for user binaries, compared to what exists=
.

The first two patches revert the current static initialization so the
token can be replaced. They are not a user-mode behavior change.

Compared with current QEMU, user-mode still uses TARGET_ARCH.
qemu-mipsel already reports mips, and it still will. Names such as
aarch64_be are not SysEmuTarget values, so user-mode cannot use the
full target name for this field; keeping TARGET_ARCH preserves today's
value and avoids the runtime parse.

The only intended change is softmmu, where TARGET_NAME differs from
TARGET_ARCH. qemu-system-mipsel must report mipsel, not mips.

The cover-letter sentence about mipsel-linux-user compared against the
old target_name() parse, not against current QEMU.



>
> >>
> >>>
> >>>>
> >>>>> "target-info: Statically initialize target_arch"
> >>>>>
> >>>>>>
> >>>>>> Regards,
> >>>>>> Pierrick
> >>>>>
> >>>>>
> >>>>>
> >>>>
> >>>
> >>> --
> >>>          =E6=AD=A4=E8=87=B4
> >>> =E7=A4=BC
> >>> =E7=BD=97=E5=8B=87=E5=88=9A
> >>> Yours
> >>>     sincerely,
> >>> Yonggang Luo
> >>
> >
> >
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

