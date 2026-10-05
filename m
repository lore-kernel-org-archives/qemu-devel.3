Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FFACA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 19:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDo1k-0000Rh-NZ; Mon, 05 Oct 2026 15:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDo1i-0000RT-LI
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 15:07:06 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDo1g-0006rw-Od
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 15:07:06 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6acbdbc1725so2911424a12.3
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 12:07:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791227223; cv=none;
 d=google.com; s=arc-20260327;
 b=raSjkSYDyL90mI4SK0Sm9rDtrObfNqAdgUJZwEziVVHA5WEENs8TLQVsXzPHZIVJml
 OMY2zqlYoDSWcZuuUu/PfJt8amKEAVv2QDkc/y3WFfY4Ljd5VARixRyqtTAJvXre3o6Q
 gjGf4V6GHVCOpNtueB5UPEvPNQnmHzG8JmGtt994/2J2kChicKvISBcuawIl0MTv7ySa
 JVxHVMms4aKotzC+rGIYQBv/TzxFlwDcZxL6zbJBOUgqv/6QYrZuLP2pJ1m7TCx04sZ2
 u21IIboOEHlv4EpQJheXUqQ+Lq9TvBmJh193mS2f2zoY2qoDlN9XO0mhA5mCluB6dJli
 FVxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=W+CsBfQUUfwYQCfTJyMKFb2DhxxUZWftjxcQ6uPqVKQ=;
 fh=IWV5i/bmsnDDiumGg7GH/qn1tjabzJqEv+mL/WiBNIs=;
 b=e4PUKkE96rmX+NytFBCS3c6FSoJbT2xnTawacOg8M30qW7ujGApPf4a6z7WmGa3qyx
 9NxXsMe0AxM282sTtuEyWzn60dPdhcRmDgYpM6699Ffygs0YCR4XvFNO6FO1xvshrP4D
 upzTRapc7S9dVL9fRRJrMDM12kw45HHXqgiO8sbGweRjQXW3z3Nkpk5Ab9lwlPvHfGi6
 aKFAGezMkEap+2LdahGSUa/8OCLzhT5MxGaI4Qm8VKoiSqx8Izxe9pq5Gd7hUEJRhP3l
 kz1ZPcPzNCKOaIC3KkwGFvw7AAxnXdjb+m/6fmdUbO/S6xABUyqmglS3j95bgjB+wWCY
 RH/A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791227223; x=1791832023; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=W+CsBfQUUfwYQCfTJyMKFb2DhxxUZWftjxcQ6uPqVKQ=;
 b=YVpRj7rVd15/2HNIvKm303DsMNqTZ1dtrqBF0L3DQ6JCY1JesbKErMqrxpaFRhJ0ij
 3XgrAQcGxBQE8Dj8qloamOvWUaQ52rqj6JOcvY1hYlLd1+BV72AuBLRl20vKWLxMH+wz
 me5GC6blxYNbLVJiPDzt+WgLsx35v4UcU0ikulqXvdtjKG7XLTosmtbpubhcJ6lIDnJp
 Ar5xWqOlTqJ07sssOCMGvhzmADiLbI3AoAoRhHgcbneCuI1PLUAeQ1LmeEoeR8K8nFY2
 tHyIfTy51CESY4zDyTlUeTyuU91qDf/CMvqm31gekjqwfgPotZmb0sXopgWxcHoTYQzF
 PSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791227223; x=1791832023;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W+CsBfQUUfwYQCfTJyMKFb2DhxxUZWftjxcQ6uPqVKQ=;
 b=j1i65yjlA5+oq+AIdnETT8jBwb2jrhbTsJKvoz4DIksMd5rTE8hDEdov3hyOFXe9n8
 2YsHC+URvYQyktw3qdmv1MUgLuxDieNb6x5AMkn1wkouO/6Pvih7TaQ+O1pnIwloqJP1
 dyynJ8oRgmBd6gaHfbaHlaa9O+T81v7Ge9qaiaAy5q/DRexTkSJuhAkGVHdZXvu7JM1i
 DRlOwO+dSPliQ+3vdS6XQ9bDTSB1IMPI3wDl6qauNRsjBCwwu7JbzlXD6w3P0KAzjlyO
 TGd3t/snzWTmCjWOJgmq9mhNUcasTRib24YeKWJI0fNpd5naTmO5qCP3qa6UItWKat/M
 W0Ig==
X-Gm-Message-State: AFq9FYJZh111JtzXLG1lsIgKdv4SMEvjhlWDqzDfnoaSYurds1K28vaH
 nwyPuXCqqxzcEFwaKVTw5qMJdn2jdWzLrIyLGxU79aI0qRmPy/9GuQ81XcYS9N9NWVTb0x1rD02
 RTqMhWZ2si+EFRTxokdeRHjGLwstZo9s=
X-Gm-Gg: AYBFou0hNBHRdxwNwkImKR+NmG/ESY3FQQo4caovcod4t+tMlxjk0rqhrowUyPkq2+s
 ACXvC0mys4VvRtlqnQaQhPU3QwgWI8s9sTp+kSeVRJr/P54NSl/IKTgjr9NE7PT/udgTf9dsIns
 I4M0J3CM/WpgcOUMq9XTzno4P/Z0xACQCdeyIosfjJ5Ii2aZxRFF/5phpKkBLnwIqnfqdXEV8XA
 YmjaZybWx7h0Z5ilOzBb++EFqaXLNyIARz1wELQV9LShLt3fcc79DhX02ulx1zosnPI43V4zdrY
 1hmB2CDV0apJX347tMba860oO46OUg2qNhDRUfL3GPYkwK6/qTXtpydGC7WE0rwBHw==
X-Received: by 2002:a05:6402:3549:b0:6af:9c33:a6f with SMTP id
 4fb4d7f45d1cf-6afad8d13aamr6734753a12.18.1791227222428; Mon, 05 Oct 2026
 12:07:02 -0700 (PDT)
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
Date: Tue, 6 Oct 2026 03:06:49 +0800
X-Gm-Features: AclHuK_KsbUyHZLLiM-39GKgYxFw7vjQLzeQ02C_dR5SP7j8q0z7-v6flS8uiCA
Message-ID: <CAE2XoE-89zTC4wPnyi_ZUu_dcVuLmwr4uyp-txkxEYQ29Y8uvw@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52c.google.com
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

because for different SysEmuTarget, the machine list is different.
return a wrong SysEmuTarget would cause a mismatch between SysEmuTarget
and the machine list. for example:

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

static const char * const mips64el_machines[] =3D {
    "boston",
    "fuloong2e",
    "loongson3-virt",
    "magnum",
    "malta",
    "none",
    "pica61",
};

static const char * const mipsel_machines[] =3D {
    "malta",
    "none",
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

