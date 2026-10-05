Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E6CCA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 16:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDlaW-0003O8-3h; Mon, 05 Oct 2026 12:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDlaO-0003Mh-6g
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 12:30:48 -0400
Received: from mail-ed2-x0d.google.com ([2a00:1450:4864:33::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDlaL-0000O7-Ag
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 12:30:43 -0400
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6ac6fa788e6so2438079a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 09:30:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791217840; cv=none;
 d=google.com; s=arc-20260327;
 b=WNwXDSlx7napplCYYmdghG3dQQEoL05kHiNfKv4aKlqhTDjA5dBi3h9S2gXQzHFsg2
 l0/+9EtEjl56+8Rv4FVoxai7tVj1atq/c+IC9b7ft3YIvmGJS+lnmy3xmb52StcDbO9r
 f3/IP3kEe8jeAuVI/5QJDEPGqMV7luRfryCsYtQ/8Xn/FW9hOyRRoTiojRMaSThJ8XAT
 Znr59jz3s0TLb4Ss8yOcR+jXoi0PKQJJ65Zd3Brkdr40kIgjRNSHENfg08US/jXYnWR+
 nObk9I1zVgvtdzPzdM727BauOA7aQRpZM1Cht1PqGE0iDsTKBsZ6bhUTsRTb+Dg4MFvF
 3lrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=N0Yvw+vKz97lXpuFsNzZHoFpkiMzq8nyK4rRiioxKp8=;
 fh=IWV5i/bmsnDDiumGg7GH/qn1tjabzJqEv+mL/WiBNIs=;
 b=AJ3hHZYS/BM7F5l+TJXWnWuBusLNzUpoCp/szCwizrHTfst1menSjpBRggdoP2SEXe
 s8nHA6FeE6hZOv48VHEP4USRF4IovzGYpf5hYo5OZojEwwOqJIfF+aWxlJDMwjMHCLXj
 fqM3kI/LWypNVFqk+DB0j6Lj1B61p9URwBjWDcfY5FG3y8aAHnTLCLiBdjjSk3t5kYVZ
 pdbtYXF48laAiJmtxZ50LtnLyxzILznVQqZKfq2wv3f/Ui1LHfhEkV0ZO5g0rDoMJr13
 7+iJMWR7DakjNBDAe2lQyOovU/u72IJWKsEfjHKXxtk+8h73YlYNMxZEr4oo0QbiqF2h
 yQ2g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791217840; x=1791822640; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=N0Yvw+vKz97lXpuFsNzZHoFpkiMzq8nyK4rRiioxKp8=;
 b=Fgfkej1Au0XLMNunSRp7b7LY2IylJnsxUKqmIUWcTFIl4EComAX1BQ14sFb10BZC/t
 Naj6zFVrTYdonTXY+6p/BeZUxQy10Z/cuqiJxlmEt4VyMzaiptr6AO+pmO2ZDrxTcrl+
 zYu7jCdIgEn7DKU5Rv5XEqNZQAZlNE0AOMPuZBQsmiKx3c1jxBu/lifmaxPwIQ7YLjat
 uVkFPiA9iHDDqLcgDJIBrYebAjt9WpG8+5u7ggOpKXFd66QDR52+m8x0j+GivqGvpUNj
 aBEpTlOHRPf+fSgj53iZoF0PTBilyCD0ZCZ6jR4eC7m1kdT9I7zFJ4bLCA0N3U0/bj3o
 B0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791217840; x=1791822640;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N0Yvw+vKz97lXpuFsNzZHoFpkiMzq8nyK4rRiioxKp8=;
 b=FZ9h30AxASk/NwQVZXtcS+bNCGszZaYF8uW+k2XIav0VPtYiz6wYoeVSwqx5wwiZ6Q
 jJ0a8yw2AOaVkDaMAjtjqUpgYptcc8LPLTWKkdSqzt7MFk9QbtqfkxipBFCYiBTdffwi
 1IV+6E3Hs5FDTLKqDsidfhGhWcZhSWRA2hYZ6YC5Jt/b6FcjNKwEYJ6my0aLsCcrK/Bw
 KO0Nnrnr32QA0U0QwX0pgjec9nLEguaLPCD4HOhVxrglhhjBpjaYWxIt5njQXLRZbs3/
 /q+H+a71NgW4UeTotfmILngA+9uJq8GbapUE1EOfKizG0xwk9nrf/QoQs21hBeFHpQR7
 KgFA==
X-Gm-Message-State: AFq9FYLti6R6l0pe0DhDTBNOcqtCrkHa4cS1tX38YbByFN/N3EyV6UWg
 my2yeJcMjte2lpR0rgI/VLY+lKSu7u4lXmvAXp8X1z/08Y9XY7lGoo+O5JBJ/N2WpsVzGXEQVWX
 /mjrx+OImD07xwBhe6VVHM/0zXMjFgWS5cKFtXyM=
X-Gm-Gg: AYBFou3PxPa5TcvRfzNmNNQpxs+8Bfyriakhk1dz7UQ9mDWjkt91+YWshcbSzYFfCpM
 bOnmH80C/coShyrPs0zr744ijzakIaKkDBBCi360l9C71ZwG/igZOflPtyol8XxxtArNvWGUB4S
 6o/PYyjSQZua4T2E0W4j3CsGT1BTpSf3X2r33rV1Vl/8GsP1JbU10SSGYMJTogaLwp8fNDLw9ME
 a9bduksuWsWvGUuR9o0Ds9aWgmqqOaMjSocTogJwn3yT1NrBCoBsS7Uibrpasm4kTuQgMrBZIqJ
 f1JmLcwdCQ3oyBfhm0S+ydSz8BF2ChiDqENFX9fQpsNoKv6JdqqkedKr
X-Received: by 2002:a05:6402:1cc8:b0:6ac:8b71:fd91 with SMTP id
 4fb4d7f45d1cf-6af9e020ca8mr9287537a12.3.1791217839403; Mon, 05 Oct 2026
 09:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <20261004072927.1142-1-luoyonggang@gmail.com>
 <0b84bf4d-3b98-4f52-8847-9f89bef92c1e@oss.qualcomm.com>
 <CAE2XoE-joWZwrBy-jLe+=ZP7OGM9cyDrF_5hz7koVPODeys+JA@mail.gmail.com>
 <b2297f92-a685-4399-a755-bbe5a37b9b3f@oss.qualcomm.com>
 <CAE2XoE-4Pdp_n3RgpqJ5se_KTHniMAJAodTLmkfV+0jjou=M5w@mail.gmail.com>
 <c6bd8e8d-3160-46c2-ba4a-2f5a4b93cf38@oss.qualcomm.com>
In-Reply-To: <c6bd8e8d-3160-46c2-ba4a-2f5a4b93cf38@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 6 Oct 2026 00:30:26 +0800
X-Gm-Features: AclHuK8ycPyF_qSCchUP2IyaRHxjirUA1ERfV6IcK-5yNFkNEqPyHrCXaW6BzeI
Message-ID: <CAE2XoE9n9L=zALTpyjHcpCopT76bDtdqz2N5vQrCcMEGjdW_CA@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:33::d;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x0d.google.com
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

On Tue, Oct 6, 2026 at 12:25=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/5/2026 9:19 AM, Yonggang Luo wrote:
> > On Tue, Oct 6, 2026 at 12:12=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 10/5/2026 9:10 AM, Yonggang Luo wrote:
> >>> On Tue, Oct 6, 2026 at 12:03=E2=80=AFAM Pierrick Bouvier
> >>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>
> >>>> On 10/4/2026 12:29 AM, Yonggang Luo wrote:
> >>>>> `TARGET_ARCH` identifies a base architecture, not necessarily the f=
ull
> >>>>> system-emulation target. For example, `mipsel-softmmu` uses `TARGET=
_ARCH=3Dmips`,
> >>>>> which caused `query-target` to report `mips` instead of `mipsel`.
> >>>>>
> >>>>> Generate `TARGET_SYS_EMU` separately. Softmmu builds use the full t=
arget name,
> >>>>> as `SysEmuTarget` enumerates system targets. User-mode builds use
> >>>>> `TARGET_ARCH`: user target names such as `aarch64_be` and `mipsn32e=
l` do not
> >>>>> have corresponding `SysEmuTarget` values. This means `mipsel-linux-=
user` now
> >>>>> reports the base architecture `mips` rather than `mipsel`; its exec=
utable name
> >>>>> remains unchanged. Initialize `TargetInfo.target_arch` from this to=
ken and add
> >>>>> a qtest to check the `query-target` result against the target name =
of the
> >>>>> running QEMU binary.
> >>>>>
> >>>>> Yonggang Luo (4):
> >>>>>   Revert "target-info: Statically initialize target_arch"
> >>>>>   Revert "meson: Add TARGET_ARCH to config_target_data"
> >>>>>   tests/qtest: check query-target architecture
> >>>>>   target-info: preserve full softmmu target identity
> >>>>>
> >>>>>  meson.build            | 11 +++++++++--
> >>>>>  target-info-stub.c     |  2 +-
> >>>>>  tests/qtest/qmp-test.c | 13 +++++++++++++
> >>>>>  3 files changed, 23 insertions(+), 3 deletions(-)
> >>>>>
> >>>>
> >>>> Why should we do this for user binaries? Current work around
> >>>> single-binary only concerns system binaries, where all targets are
> >>>> correctly covered by what exists.
> >>>
> >>> From my personal point of view, keeping target_arch as
> >>> SYS_EMU_TARGET__MAX for user binaries
> >>> is a better option. I am doing this is for replica of commit
> >>>
> >>
> >> Ok, but I'm not sure it answers the why.
> >> Could you explain the benefits?
> >
> > Which part? keeping target_arch as SYS_EMU_TARGET__MAX for user-binary =
because
> > The following original code would return -1 for some user-binary
> > +    SysEmuTarget arch =3D target_info()->target_arch;
> > +
> > +    if (arch =3D=3D SYS_EMU_TARGET__MAX) {
> > +        arch =3D qapi_enum_parse(&SysEmuTarget_lookup, target_name(), =
-1,
> > +                               &error_abort);
> > +    }
> > +    return arch;
> > So basically assigning any value for the user binary is valid.
> > SYS_EMU_TARGET__MAX is more explicit as it's related to type SysEmuTarg=
et.
> > -1 is another option but easy to confuse.
> >
> >
> > For why commit e934c624f32f6f44f427d73a2e6a67e983a02ae6.
> > "target-info: Statically initialize target_arch"
> > doing that, I am not sure.
> >
>
> I guess there is a (good or bad) reason for which sub variants of
> targets are not reflected in SYS_EMU_TARGET enum. We should double check
> that before doing any change, as it might have other consequences.

Yeap, but this functional change caused me have to add endianness into
query-targets at
https://lore.kernel.org/qemu-devel/CAE2XoE_fxTRQJPzsDZHS44z65KR0e54cWjVpyZQ=
Gtr1sdLOinw@mail.gmail.com/

because in the current qemu tip, The $arch returned by query-target
not match the qemu-sytem-$arch anymore.

>
> >
> >>
> >>> "target-info: Statically initialize target_arch"
> >>>
> >>>>
> >>>> Regards,
> >>>> Pierrick
> >>>
> >>>
> >>>
> >>
> >
> > --
> >          =E6=AD=A4=E8=87=B4
> > =E7=A4=BC
> > =E7=BD=97=E5=8B=87=E5=88=9A
> > Yours
> >     sincerely,
> > Yonggang Luo
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

