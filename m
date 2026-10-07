Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D897ECA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xERsP-0004at-7u; Wed, 07 Oct 2026 09:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xERsN-0004aE-Tn
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:40:07 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xERsL-0003FE-Uk
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:40:07 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c2e6df2742cso252046666b.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 06:40:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791380404; cv=none;
 d=google.com; s=arc-20260327;
 b=azBqH4bAO8htDpVFzZKMENPmPmoyuJ5xqfdUv3VHdS3qxUvjCpodLdyJLftiWAC5AW
 teorpGxhH28bNxtgrostcM+z2LlbfFjOsNviPxQrH9b2B+xKFbp3UKn04YlKJFNrHsM3
 KT6QyBJHScyXMzaHOgm/0dhx4kInUVlANWFY8iIBZdBYYAYQjHXWmYQVbkFUsutG+ywR
 +pvfNn+ORNnjFTS+BrmcX/n9rU/8gHwb04vogbb7w+/vo/svbNSjmyBMrMfsKQVqQRCz
 oRS3RhHr80KuzLSkWuR6zRc88FiQsbiz/hzWk9+H1LPwMiBa/zmb3HfMXDXiPohLxQ5x
 yXEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=kijGPFj8mxU0eUyLnYHgGpuj3XE89WWVKq4eeg14sqE=;
 fh=iYti4CcJ93nNzsiReDBFEg6yh3G3Qu7LLcikZd0Bn5I=;
 b=L9yo1WJwnwS6WEidbIYhKnsdBVBCvyOfnq09oddzH8US/yY54TWWMO7VS2qjEJyLGB
 zV6bfQmXtHaAiAhaUec3owAqMg7dzQ/AW4XFV+yOccqndz1cDXUdUw8JZ4iv+BIiEZi2
 IrCrD72Ecm51gkd8gvwpIUF94binHdCbOr8V1ucTHJXoh0n6cfB4WHGSHbAV+9ctXFx6
 AZAEbMgGH7Voq8wWtRbIYU/tXhninEAHYD73cjyOr4FQjfRbdzrf7lJNbsvEcdcuPogd
 OBJSX6+jNkyqRqWCXifcTkr6aBrlmr2opQwyMfX2ff0fb+LAonEVYd10x5XkW7VJN0du
 Mfwg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791380404; x=1791985204; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kijGPFj8mxU0eUyLnYHgGpuj3XE89WWVKq4eeg14sqE=;
 b=jYAVK7C+Jfi1duK3M1Ldc01kpNT1FKJfEws0KhME0WBY3raSbLCg5/tBeXgEB4pFzD
 809KReJZmo0AH+IFOYnA31dkoLLoIQ1aLK7Gg/f/I1RwQI9EzfCwL29opSkMYYwo1ndR
 cE7mVf8BeiWjP/6XAO1JAO/Dn8Zr0Z4D7780lgM/YoKoj1MxBTnKXcMqevIM+r6v8nCn
 o6UN4BPe0A50fVlEdoIZtsaifZocsKfVkrhd08sDM948V4PU1r4LYVK9LiunOuPV2zBi
 /ZaBxI91P5sMRg0cKCaWpu12SPrBpzhy0cHPMADTHw6/Ti8g2H9EYIxsF75uvqVJGy68
 0+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791380404; x=1791985204;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kijGPFj8mxU0eUyLnYHgGpuj3XE89WWVKq4eeg14sqE=;
 b=XdNXfDIw2Brt5a1J1h6n5TlQ6BaEGH88x50h6jgcWHp4hmYb85AMVq79chM/gOZ5y7
 x0eLDL8D3P6SsvCMx0buP7DbWFOrHi1fUczvT3DvaYCZsqrCBF5qp9FBB1/mV4dIQ8YF
 qFSwWWaNT+/icMCQswaPzF4TJ4J210a1JcLxICTMSm+Y45f2KWCsR+VYH5B+mtTE1dBG
 YR7Ze9m7t3pNQ5QFFfkDlvdjNhVtaNWlAorMyqKWTNH+31ALdyYWcARfIEsbj49Yc93b
 ghUkFxwy7dSMuRqLVgXGtRWiWO70chAu7tj8iP2q6cTmZzySrr2toPsrxl/p7oepCWR3
 M4NA==
X-Forwarded-Encrypted: i=1;
 AKwUvByYIFoE2j49v7DkQMURkGpwXYW5xdHT3hjUAOhBAjRjwdOHv7I2vpaMPGxK3iENs2L/5NW63GeWUTgh@nongnu.org
X-Gm-Message-State: AFq9FYJLvNRofOnyA7NgDg1EWtr2vR1tjuhBFz9H0KhOnmKOXJZi9MXT
 zYbtMTKoZUSeo7xg9Hn+vaukMOs5zffTr9DAA3QsEhg+lG+HIgyRfWxwdSsySMX0u+xYjuNPKho
 94Eq5Ya9rVmH1Y7tayP0pRJMRCi5u7Jg=
X-Gm-Gg: AYBFou1gm84mU7zWKPMVqC11HMlLqYF5H7Lm4olWnX0drm4s6dPvIR7bGL7YWW8mfr0
 Tt60ceRI/Y8UArHw5cSwtLkPCjf48vnSJR1tRProDynYeaEqEeiLF44fTyYXPr9KHizWF4PS22z
 RZYafXnY4TZ0UJ54K/9nbF7FBjrt8Id0zO4eoIfMSHYTqvRC831dJ5fpwyfxaidEjNecJSjauhB
 MAKMf28epzZWMjzgrKPOnazAOZka7HBzfUOjnLhqi5u3Hpj7PDEk8uVOVw89zILekxYtVruIOoo
 aOt3ANtm56hQPs08z+2fWG4IPHcGAmsMF+NFhjWhmbtWSieHNEx0sd8=
X-Received: by 2002:a17:907:6090:b0:c29:f5d5:5a97 with SMTP id
 a640c23a62f3a-c317be5efa6mr220749466b.33.1791380404008; Wed, 07 Oct 2026
 06:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
 <20261007-rv-dedup-v2-14-8a2f0f296a7f@rev.ng>
 <17cb7c7c-5f22-4a03-8855-4d1ec91d347a@oss.qualcomm.com>
 <CAE2XoE9eXXKQGZZ0kvmex88+tjch1-+H_-MgB6JEu+4bdPZq8g@mail.gmail.com>
 <9bf8945c-6472-462e-a275-f0b74912d3ed@oss.qualcomm.com>
In-Reply-To: <9bf8945c-6472-462e-a275-f0b74912d3ed@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Wed, 7 Oct 2026 21:39:49 +0800
X-Gm-Features: AclHuK9eXu9v8s72KRA0zeVlJz0HvpGEORAabRshStrlJLOlK_G9Ts7ICmO9lA0
Message-ID: <CAE2XoE9QzGda8J9QCQysRL8OoxBrR86Ft426Rf4TXJxnPm+Vsg@mail.gmail.com>
Subject: Re: [PATCH v2 14/18] target/riscv: Compile pmp.c once
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 daniel.barboza@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej1-x630.google.com
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

It's here https://lore.kernel.org/qemu-devel/ar9WZip2Q2G0qvQI@hive.localdom=
ain/

From: Anton Johansson via qemu development <qemu-devel@nongnu.org>


I wouldn't be surprised if that's the case, although I'm personally a
bit scared of riscv_cpu_mxl_bits() since it returns 128 for MXL_128, so
if it's not used carefully or on clear MXL_[32|64] paths you could easily
get UB.


On Wed, Oct 7, 2026 at 9:26=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 7/10/26 13:51, Yonggang Luo wrote:
> > On Wed, Oct 7, 2026 at 6:25=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> > <philmd@oss.qualcomm.com> wrote:
> >>
> >> On 7/10/26 10:43, Anton Johansson wrote:
> >>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> >>> Signed-off-by: Anton Johansson <anjo@rev.ng>
> >>> ---
> >>>    target/riscv/tcg/pmp.c       | 5 +++--
> >>>    target/riscv/tcg/meson.build | 2 +-
> >>>    2 files changed, 4 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/target/riscv/tcg/pmp.c b/target/riscv/tcg/pmp.c
> >>> index 99345d63dc..2d7194de10 100644
> >>> --- a/target/riscv/tcg/pmp.c
> >>> +++ b/target/riscv/tcg/pmp.c
> >>> @@ -638,19 +638,20 @@ uint64_t pmpaddr_csr_read(CPURISCVState *env, u=
int32_t addr_index)
> >>>        if (addr_index < pmp_regions) {
> >>>            val =3D env->pmp_state.pmp[addr_index].addr_reg;
> >>>            int g =3D pmp_get_granularity_g(env);
> >>> +        const unsigned long_bits =3D target_long_bits();
> >>
> >> We need to fetch this information from @env. Maybe riscv_cpu_mxl_bits(=
)?
> >
> > discussed before, there is possible be 128bits
>
> Please point me to the discussion (directly, saving us a ping / pong),
> as:
>
>    '''
>    This was already discussed on v42:
>
>    https://lore.kernel.org/qemu-devel/some-message-id-v42-20128438/
>    '''
>
> Having the discussion decision resumed in the patch description will
> prevent further reviewers to ask again the same.
>
> What do you mean by "possible be 128bits"? If we want to cap the
> value we can use MIN(64, riscv_cpu_mxl_bits(env)).
>
> >
> >>>            switch (pmp_get_a_field(env->pmp_state.pmp[addr_index].cfg=
_reg)) {
> >>>            case PMP_AMATCH_OFF:
> >>>                /* fallthrough */
> >>>            case PMP_AMATCH_TOR:
> >>>                /* Bit [g-1:0] read all zero */
> >>> -            if (g >=3D 1 && g < TARGET_LONG_BITS) {
> >>> +            if (g >=3D 1 && g < long_bits) {
> >>>                    uint64_t granule =3D 1ULL << g;
> >>>                    val =3D ROUND_DOWN(val, granule);
> >>>                }
> >>>                break;
> >>>            case PMP_AMATCH_NAPOT:
> >>>                /* Bit [g-2:0] read all one */
> >>> -            if (g >=3D 2 && g < TARGET_LONG_BITS) {
> >>> +            if (g >=3D 2 && g < long_bits) {
> >>>                    val =3D deposit64(val, 0, g - 1, -1ULL);
> >>>                }
> >>>                break;
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

