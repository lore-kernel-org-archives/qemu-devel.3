Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8C4CA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 19:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDo7R-0001KI-UA; Mon, 05 Oct 2026 15:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDo7P-0001K4-W4
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 15:13:00 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDo7N-0007LT-Er
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 15:12:59 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so22789166b.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 12:12:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791227575; cv=none;
 d=google.com; s=arc-20260327;
 b=Y5CAWdIWQXUaTQoiPLlJjf00oZTSpd09QBzTbMz0uW+UuY29Ujuj/cu1sQY6u+MLmr
 o3d5IaL8koo+aOnm0XcPX6MA8LlrjesQ14AtDyx3ERDR7erPdCiQdh7+C8ORoQqiQINm
 /Z/XZizdoqwwiUHGtW2WzXtFhhxvW03wYktb4APQZ15VUDtPaCQqoG6QMQRiS67cm8nw
 cuHAV4nA81EeoFx4FnnK/ixUPYYhQTH9zGKyZgQ3fg/Zs/tMv/xyjcCbUzAcqz57Z8i0
 V4Rz/ZMXiI1aXPEVZrj/xRvtxKX006MIE3Uu5JdZzO+EMf7whPiNxC5yCa3LSSJZk1v1
 KYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=so9X74c/k8ur915gA2+HGFAKIbInrLrXAx0o3xeYd4I=;
 fh=IWV5i/bmsnDDiumGg7GH/qn1tjabzJqEv+mL/WiBNIs=;
 b=GU5s1AsuvGRmJ0T66HENegsWQcx5Zac0mXXvXJBncFJleTB4x+NVWmR46GGTPqRHrF
 kofsAGB4o3YXcDCyXl5HtX+D+ttkIceQtDfirs/3Ab73bKuIX43g0f1CyaFxO5udGdnf
 +vXHUIDNndHVMpkRVKHDoxBszNHE86gSm/UPjOMFbgCnjr0G42Fw02lmZWV3TQo491OY
 opXS9N9OIx8h//WFiiCKQ2dBfutsOsY622dngvqKY4uXn8gEZ5Mtp0h7vBUxCkVCX1ra
 NVM4SnnaF544gL2p8fnJQ2WkV85fGRjl7DbPnZMFzKpX6MF00ulAFRKzf/mCLM1Wm6QF
 7jMQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791227575; x=1791832375; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=so9X74c/k8ur915gA2+HGFAKIbInrLrXAx0o3xeYd4I=;
 b=gAmj8OrGxy5L7DDUYXtr2/TkSEEoEVnN7viRvYUY174Dp/B9jKEFlCK8UDG1uhyGtk
 nvPHcFrydgxZSerbiNOPjoPQssaxqqZdeO+BbBvnFiq3S7uUsH9wawzkpzRkhCW8czxM
 0DFK+3iQ7OtRUxu03eeogLXT6tvsoguk/EX0808Mv0kCdK67gTU0OnDTEAC5GYUCqpBb
 suMsH43mqjYumHCrl/Ac9O/4ga/ijv43lsQRuZS+wkhpdXP5MucVCw4C6Xqhy/c9JNsT
 wpUX/pw0RanoI+CbJUhx5y4fkcG/edqRJWBvqhkb07fKjcXPtJDNypRPH9L8evxIA1y/
 ZZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791227575; x=1791832375;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=so9X74c/k8ur915gA2+HGFAKIbInrLrXAx0o3xeYd4I=;
 b=qL8nRNeKHMowUs7130s5805zsnfPELyj0YZ6CpEcAZSul2ESsmI+YrhHMdOJJBQLF9
 Kj13uNS2o3XgjJrjThAZNgBdnGvsTBpwLUUFivspFP2qQti1uaf3fzdhGRGskzYUaDvW
 pYxVu00unnwqS92+VwEAnGkBBdZ8UXSuTgmwJEr8q1K7HgM2eGJiSwybzGC5zsVmQDLL
 l5hl5Wo5NUl0TVWlWvuVPiGWP7BMfiwjkCOOcUh6JxLbGVwRzI4TvzwGnHI5ATDWBbmX
 k2v9ng9gZHw04VE/j1kC2cThVSW05luIOP4Foh7+u9ykCMgigr/t0k5ekUR6RQr1j36K
 wD6Q==
X-Gm-Message-State: AFuF++kBlLdYn/PscIvxNw9LPVr5jDy5k91mSPjRGri0U1556qVA82yE
 z50MwI8o5FXjXmvmfo+Lv396MGtMv6hwgECf7vXRrO4+beeL6kknyoV/Oo7A5i6y8Pzp8lF8Bj4
 NOTqS8m9Tj/96RmBChzNwzjweBsBW/gs=
X-Gm-Gg: AYBFou1OKuoHXeHTOLmLF1qPzdQs6c6upvUPO+KK4xrqrEjMq/mE1O4i8XfbSBtDYNm
 1CgFSpivXL03HFm1db2wnn987pff+t3o4b9oa/U2xJ9sDVq5DKOD5dQGVA8OP9I2il5S7FzCLR3
 kox605kpk4/NCxmR064qzM88cDlklCBTwPXItStb9RbuCK8VufU+NcvVMQ/5f7cIaPa+0UGOHE3
 q1KvaBaQyTmpb+Shgd58nWjdzNWuN2Hl/MJhBP4rIqc51NnHGR7MPrVnxdCxntwv8SFgnZvpZ6V
 3PWxA1BaPfXh4C/EMCNCzsZkvdnLQ+LrtNWEIxGsy0yTIgBaNf+PkOI=
X-Received: by 2002:a17:907:9727:b0:c25:f7dc:2dc with SMTP id
 a640c23a62f3a-c316155f671mr51007266b.29.1791227574993; Mon, 05 Oct 2026
 12:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20261004072927.1142-1-luoyonggang@gmail.com>
 <0b84bf4d-3b98-4f52-8847-9f89bef92c1e@oss.qualcomm.com>
 <CAE2XoE-joWZwrBy-jLe+=ZP7OGM9cyDrF_5hz7koVPODeys+JA@mail.gmail.com>
 <b2297f92-a685-4399-a755-bbe5a37b9b3f@oss.qualcomm.com>
 <CAE2XoE-4Pdp_n3RgpqJ5se_KTHniMAJAodTLmkfV+0jjou=M5w@mail.gmail.com>
 <c6bd8e8d-3160-46c2-ba4a-2f5a4b93cf38@oss.qualcomm.com>
 <CAE2XoE9PKNgE1Zz_frOq_DrgqrPL4B8hcq0xO6ywCNTeUnFLvA@mail.gmail.com>
 <63d20cc8-8003-489c-9f08-28369a2f71e2@oss.qualcomm.com>
 <CAE2XoE9uqEcjMsqJXu6Cr+MrposPjq7O6Lnj5cj7uW2nF38uAg@mail.gmail.com>
 <15e9a768-95bf-45aa-8175-1dbd73d5ee04@oss.qualcomm.com>
In-Reply-To: <15e9a768-95bf-45aa-8175-1dbd73d5ee04@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 6 Oct 2026 03:12:41 +0800
X-Gm-Features: AclHuK8Cmq3gkxG_a6RfDXEmEomR51s31qoTLlpvSkB1_reQ3hwpT8UrgGqYLl8
Message-ID: <CAE2XoE-Dyh+aFnOGUYQnjkuWkmXbxGatc2Vn9V9t8aNLp18Qfg@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej1-x62a.google.com
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

On Tue, Oct 6, 2026 at 2:52=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/5/2026 11:45 AM, Yonggang Luo wrote:
> > On Tue, Oct 6, 2026 at 2:06=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 10/5/2026 10:04 AM, Yonggang Luo wrote:
> >>> On Tue, Oct 6, 2026 at 12:25=E2=80=AFAM Pierrick Bouvier
> >>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>>>
> >>>>>> Ok, but I'm not sure it answers the why.
> >>>>>> Could you explain the benefits?
> >>>>>
> >>>>> Which part? keeping target_arch as SYS_EMU_TARGET__MAX for user-bin=
ary because
> >>>>> The following original code would return -1 for some user-binary
> >>>>> +    SysEmuTarget arch =3D target_info()->target_arch;
> >>>>> +
> >>>>> +    if (arch =3D=3D SYS_EMU_TARGET__MAX) {
> >>>>> +        arch =3D qapi_enum_parse(&SysEmuTarget_lookup, target_name=
(), -1,
> >>>>> +                               &error_abort);
> >>>>> +    }
> >>>>> +    return arch;
> >>>>> So basically assigning any value for the user binary is valid.
> >>>>> SYS_EMU_TARGET__MAX is more explicit as it's related to type SysEmu=
Target.
> >>>>> -1 is another option but easy to confuse.
> >>>>>
> >>>>>
> >>>>> For why commit e934c624f32f6f44f427d73a2e6a67e983a02ae6.
> >>>>> "target-info: Statically initialize target_arch"
> >>>>> doing that, I am not sure.
> >>>>>
> >>>>
> >>>> I guess there is a (good or bad) reason for which sub variants of
> >>>> targets are not reflected in SYS_EMU_TARGET enum. We should double c=
heck
> >>>> that before doing any change, as it might have other consequences.
> >>>
> >>>
> >>> You=E2=80=99re right to ask, and I need to correct my earlier suggest=
ion:
> >>> leaving user-mode target_arch
> >>>  as SYS_EMU_TARGET__MAX is not safe. target_aarch64() is used by ARM
> >>> code shared with user-mode builds,
> >>> including cpu-max-v8.c, where its result indexes a two-entry array.
> >>> For aarch64-linux-user, the sentinel could therefore cause an
> >>> out-of-bounds access during type registration.
> >>>
> >>> I checked the distinction: softmmu needs the full system-target
> >>> identity, including variants such as mipsel;
> >>> user-mode variants such as aarch64_be use their base TARGET_ARCH
> >>> (aarch64) for this enum. I=E2=80=99ll keep the full TARGET_SYS_EMU
> >>>  value for softmmu and use TARGET_ARCH for user-mode builds, rather
> >>> than leave the field at SYS_EMU_TARGET__MAX.
> >>>
> >>
> >> That's technical details, but not an answer to the initial question of
> >> why we need to change anything for user binaries, compared to what exi=
sts.
> >
> > The first two patches revert the current static initialization so the
> > token can be replaced. They are not a user-mode behavior change.
> >
> > Compared with current QEMU, user-mode still uses TARGET_ARCH.
> > qemu-mipsel already reports mips, and it still will. Names such as
> > aarch64_be are not SysEmuTarget values, so user-mode cannot use the
> > full target name for this field; keeping TARGET_ARCH preserves today's
> > value and avoids the runtime parse.
> >
>
> Why should we need to expose this precise information?
> So far, if those targets were not exposed (and aliased to 32/64 bit
> variant), it's probably we didn't need it.

Another thing for a combined-binary qemu-system. The qmp's
query-machines' targets
can not return the exact target list of SysEmuTarget.
malta belongs to both mips, mips64 mips64el mipsel
qemu-system -target none -M malta will not able to print the full list that
 mips, mips64 mips64el mipsel are the proper target
but give us misleading
mips mips64

static const char * const mips_machines[] =3D {
    "malta",
    "none",
};

static const char * const mips64_machines[] =3D {
    "magnum",
    "malta",
    "none",
    "pica61",
};

>
> In case there is a real need to expose it, maybe the simplest solution
> is to add such target configs.
>
> > The only intended change is softmmu, where TARGET_NAME differs from
> > TARGET_ARCH. qemu-system-mipsel must report mipsel, not mips.
> >
> > The cover-letter sentence about mipsel-linux-user compared against the
> > old target_name() parse, not against current QEMU.
> >
> >
> >
> >>
> >>>>
> >>>>>
> >>>>>>
> >>>>>>> "target-info: Statically initialize target_arch"
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Regards,
> >>>>>>>> Pierrick
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>
> >>>>>
> >>>>> --
> >>>>>          =E6=AD=A4=E8=87=B4
> >>>>> =E7=A4=BC
> >>>>> =E7=BD=97=E5=8B=87=E5=88=9A
> >>>>> Yours
> >>>>>     sincerely,
> >>>>> Yonggang Luo
> >>>>
> >>>
> >>>
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

