Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1C0E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 14:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJZjB-0007BM-7m; Fri, 06 Dec 2024 09:54:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJZj8-0007B4-Or
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:54:43 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJZj7-0000ZG-5C
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:54:42 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d0bd12374cso2638121a12.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 06:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733496879; x=1734101679; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZFek+YniF/eooSIS2s1LRF0j4eflNfnz/gYhNSu2RmY=;
 b=mOtQpeG0NB21nwAyePWkdaqzZc1+dJ4GgosIKgOAicAc1QKjXq3NRgB7RYHNZNhrjm
 UyOmFh9OvT/eQ1YbGvZLC53qn7VytHc8gX6TgL0SkTfTe/55IGyHYjlb3tKtL6AJ7Fgb
 QaeX6aWnUQcVdnufnWXbzXawsLv3zveOgFWy71SMJpdYX+c6hDN9Ikcy4PIAohDij3DN
 GmOgzHUScUhF9yECE+TFebc1132c9u/Xd2QB0SerVr0Sn2USg2FE5w8xuCiOK41Y3Fpf
 m3giZVtGA6tOyx5BSS9r0PTIL3dceA+b1T+D41lp8TqeLyRglHzO583fV+HZAwPpkV11
 O+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733496879; x=1734101679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZFek+YniF/eooSIS2s1LRF0j4eflNfnz/gYhNSu2RmY=;
 b=QKHYuBINOZvEOQY5x+zuEtAaMP/hHy9r/+8LSinM7nL7FUA1w3m7DwyfKNe8juzOLD
 pnTaK8WO/jL4ogNheOuChVuA5SpI+cbF/A4sHAxnB999d8E3ck7JWy0IqH9PKIH7fwVP
 XY0xOMaKR9vNI2/74NJwEqXi6BGOqfSbeLNaOSfmDji/ojq1t3cCeazeCelYMVMmKEvc
 grQxfT2BBb5/7kCqfp3ufVdN7Afg596lVz0BPWxoTUP1nNnZQrbvjfKsboLqsXYMeiMG
 jFq6uKcvNFjsl0nhP7uUMhhpDjRGxx5aElZ0D44CQjPEZyl0CArWxn+IVSMDSdiFKbQt
 Un7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGApYYqwyJTqy87vUKel8C6/cexVrnF9NQLzNX2Bmv4W6DxTTjxAw8DRQeDUN7iIh1GQQ6ZB3r2raC@nongnu.org
X-Gm-Message-State: AOJu0YwdyjbpTZQWwe1J9M5vFRxte3mMsZJMZTelfdM6UjT+sPgP08kV
 20C5ExG/xBaq3TrH8nZCB1N/l9J6bRSEf+lSOiApBpVKYKJxShpIWHDI6Dpi/yETdbp8/aHsI14
 niCa8gR/rRyhBk3kT6r0KCbo3dxltoe0PRJr7zA==
X-Gm-Gg: ASbGncuK7BzhfyT1aqtGfWpvkOqCDTwCIkPH7Esph8gotWLQeiYDAw+d2CsMNFFiV+p
 BpT9dy51wKphOE8RVqnbppYF/hASgrduO
X-Google-Smtp-Source: AGHT+IH4JfqTkSrjRE/qe+LL6LbbHwCHUJCLyTjtfm0pt2Ne6nb/tMn6wG4ryAusBZgxwbMWpKjy2mEx8YHCZ3YNrR0=
X-Received: by 2002:a05:6402:458a:b0:5d0:fb1a:afe2 with SMTP id
 4fb4d7f45d1cf-5d3be680097mr8405218a12.10.1733496879315; Fri, 06 Dec 2024
 06:54:39 -0800 (PST)
MIME-Version: 1.0
References: <20241205232437.85235-1-philmd@linaro.org>
 <20241205232437.85235-3-philmd@linaro.org>
 <CAMo8BfKMhNd0C2HwL2aGAjPUZS8B7u8ncyW5PicswPns28SAmA@mail.gmail.com>
 <30502a2f-3d33-4583-8e78-4da50ce1e247@linaro.org>
In-Reply-To: <30502a2f-3d33-4583-8e78-4da50ce1e247@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 14:54:28 +0000
Message-ID: <CAFEAcA-s-H4yGFustKRSrtozgHZiLxnpuf6UJiATgiuDLd9jEQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/xtensa: Remove tswap() calls in semihosting
 simcall() helper
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 6 Dec 2024 at 14:35, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> On 6/12/24 13:41, Max Filippov wrote:
> > On Thu, Dec 5, 2024 at 3:24=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <phi=
lmd@linaro.org> wrote:
> >>
> >> In preparation of heterogeneous emulation where cores with
> >> different endianness can run concurrently, we need to remove
> >> the tswap() calls -- which use a fixed per-binary endianness.
> >>
> >> Get the endianness of the CPU accessed using the libisa
> >> xtensa_isa_is_big_endian() call and replace the tswap() calls
> >> by bswap() ones when necessary.
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >> ---
> >>   target/xtensa/xtensa-semi.c | 16 ++++++++++++++--
> >>   1 file changed, 14 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
> >> index fa21b7e11fc..21d23e39de5 100644
> >> --- a/target/xtensa/xtensa-semi.c
> >> +++ b/target/xtensa/xtensa-semi.c
> >> @@ -328,10 +328,17 @@ void HELPER(simcall)(CPUXtensaState *env)
> >>               struct timeval tv =3D {0};
> >>
> >>               if (target_tv) {
> >> +                bool cpu_big_endian =3D xtensa_isa_is_big_endian(env-=
>config->isa);
> >> +                bool swap_needed =3D HOST_BIG_ENDIAN !=3D cpu_big_end=
ian;
> >> +
> >>                   cpu_memory_rw_debug(cs, target_tv,
> >>                           (uint8_t *)target_tvv, sizeof(target_tvv), 0=
);
> >> -                tv.tv_sec =3D (int32_t)tswap32(target_tvv[0]);
> >> -                tv.tv_usec =3D (int32_t)tswap32(target_tvv[1]);
> >> +                if (swap_needed) {
> >> +                    bswap32s(&target_tvv[0]);
> >> +                    bswap32s(&target_tvv[1]);
> >> +                }
> >> +                tv.tv_sec =3D (int32_t)target_tvv[0];
> >> +                tv.tv_usec =3D (int32_t)target_tvv[1];
> >
> > This conversion looks a bit heavy. Maybe it would be better to
> > give tswap*() an additional env argument and give the target
> > a way to deal with it?
>
> Yeah, something like that. TBH I'm not really happy with these
> changes, and am having hard time figuring out a simple and
> meaningful API.

You could punt the issue here by having xtensa include
semihosting/uaccess.h, and then replace the direct
cpu_memory_rw_debug / tswap calls with

    get_user_u32(tv.tv_sec, target_tv);
    get_user_u32(tv.tv_sec, target_tv + 4);

These are still doing cpu_memory_rw_debug + tswap under
the hood, but it makes this code in xtensa-semi.c simpler :-)
and you'll need to figure out the plan for get/put_user_*
at some point for Arm and other common-semihosting targets.

> >
> >>               }
> >>               if (fd < 3 && sim_console) {
> >>                   if ((fd =3D=3D 1 || fd =3D=3D 2) && rq =3D=3D SELECT=
_ONE_WRITE) {
> >> @@ -381,6 +388,8 @@ void HELPER(simcall)(CPUXtensaState *env)
> >>               int argc =3D semihosting_get_argc();
> >>               int str_offset =3D (argc + 1) * sizeof(uint32_t);
> >>               int i;
> >> +            bool cpu_big_endian =3D xtensa_isa_is_big_endian(env->con=
fig->isa);
> >> +            bool swap_needed =3D HOST_BIG_ENDIAN !=3D cpu_big_endian;
> >>               uint32_t argptr;
> >>
> >>               for (i =3D 0; i < argc; ++i) {
> >> @@ -388,6 +397,9 @@ void HELPER(simcall)(CPUXtensaState *env)
> >>                   int str_size =3D strlen(str) + 1;
> >>
> >>                   argptr =3D tswap32(regs[3] + str_offset);
> >
> > The tswap() is still here.
>
> Oops!

Similarly here
    put_user_u32(regs[3] + str_offset, regs[3] + i * sizeof(uint32_t));

-- PMM

