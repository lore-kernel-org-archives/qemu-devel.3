Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20098CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 11:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEQBK-0007v7-O2; Wed, 07 Oct 2026 07:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEQBI-0007ug-TJ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 07:51:32 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEQBH-0007p9-83
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 07:51:32 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6afafc89b48so2666378a12.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 04:51:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791373890; cv=none;
 d=google.com; s=arc-20260327;
 b=FHI7Dz5A9bKdJUCMHaafiKQDvca9HFeUawXXWbU2JloVspzZ7zf5oDCSZ4+LAoEVaq
 zm89uhuICWp3GEgb2Amodv7hmvkMaRzo7WB124l3fJWzOFhKZ5JxHZO7sBe39PAO4VYj
 I/B4uvGFo6wXT3Nv4HqZlgSqMJUxH3per12tSmVRW/NhFEIdN2N2XCFfJrwCmFlTWibe
 xP6TdAOOeWSBkXNYJVHtChmA0pUvTC1pa/UXA0Gn8w/oGniF/KlI6WNZqhSF4Z6xCLEk
 oW30O0TZPCV/bkMoigodv/5dQYxiD8Zr8+a04RAaZp4/R7pS2DKpa11z1sRJcNItqC7c
 p/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=oXR07ZM9OgEvwdfpKcUZs8ZfL7H2QkPzD6gX3qOBON4=;
 fh=W+fztNbfl1gm4xHToYKdu6znPiA0jCM0QYNj86OwHI4=;
 b=NkiH6EXXBjXKOstG0z1/iXBgBbd4iOIEjg31ZUpA6zmOSvBqWqsTsdW2544M9kfbSv
 riWsQFLUbvU4BEXiaK+y9hf2WBZYBoYnD0ghjo/CvYcKWSzlEfMsyZGO+yFVCKmKCOY6
 k2bHBZBRcc3luxDGOKXXhM/1SWQJPSpar5uLryTTDVODyynBRpk0tgQx7JPRCEe40hXT
 89SQqK8zkGsXxEgvSsyBmtZ3uEO6VejLlUvozyQUz3OV5OAU+aLpnJQixmzF+pDBe0At
 FSSs7BV07ucwm3qT75jMWQusJRmLpNH3F8g73Tci3jGbZtZRbLbI5xpqxlPC6DdsT7KR
 yTQQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791373890; x=1791978690; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oXR07ZM9OgEvwdfpKcUZs8ZfL7H2QkPzD6gX3qOBON4=;
 b=J0G61YZwUz1JYaJhTGPW2Ap33uZtOsW0CXF3MPWeRC5zHV9I3VzZntrXBKmFzBTw/D
 hg1d4tKCKuKk0AYiF9CHHJ7lyXmrnhd5j7fLXf/qVkC/WyGRavv81c6+dPOb6RCEm4Uc
 p5/XSVMKIOfjM9uLOA4Or4mN0La+c8vvUMXpuPd13TQpibZ182PBoLLOnmUN2LvB0Ych
 xh/KHUbVj69chsuP/WyDRfOHArYd8O7KaLe4BAfVpe0v3BdFlYGp9LVVigKOR9NcvKE8
 XK/lcRvKcKRE/zoTUlO4MRy1w8yVn4fQaQXhjvd+FSYIf63m4l9VZo2THOye2Jrl0Chb
 txQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791373890; x=1791978690;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oXR07ZM9OgEvwdfpKcUZs8ZfL7H2QkPzD6gX3qOBON4=;
 b=YU9Vky5KBgDmBcF6Ta+FzTzWfVPfy1J/mgBtNSFWy7lSlXPocVExl3O32rMaJYBTht
 qG9i1HcvEllKuag7ryDSTrbQqBpqA8JPbBwTmEAL3YnsVU3TWeBOJYGU3HbLYiOiT6Ug
 iXMYGPI3yAiizXLVZ3QFFzFllUtN/pXc8O6RUADTs7hKVNS9DScULOOyDW1xz6cHynqL
 M99HaQqwmjdbrXm/gKN0S1/koS1h2uD7yrxdvlXqa34ywoUB0Tbc1ogSbj6Zxk4MOYRe
 DEyrestoszLCHkXCC5AItIiJrErQha01pcg3wcaRPgWVSb7HRS0hUaTsOgpHOAq6vtSd
 zlog==
X-Forwarded-Encrypted: i=1;
 AKwUvByHFJEsaaW/s74Ap79PX1vxa9buky74NW6chnWLu3bruhF7/RE1Pzl+flFiKbgPAFUbmOSURnYaPlnq@nongnu.org
X-Gm-Message-State: AFq9FYJ1CaelZlJZ6cEuExjc8Yl6aN8mB8QPSguzTAAIpCyvDL+6vt3M
 mDDB+oPkQkefaeIbWrHlR8DebOY0S5U27agUAQqdHxrcqQOyHnwOxWx3luLUS4E9kOhXsMDpWsK
 N5SI/va81V5jYwodsb2UU6UqFW5nvRV0=
X-Gm-Gg: AYBFou2U9v0O8B10GqNMvEujh/VsOj5wWzPIuBTgipoldvJ5WDeSToEnoiwyZjTqmnA
 dcmKFb9VbVhF0MDV/4eY4uPw2yzQP4wG9rZUPR0ELHbmCPKkhHagTe4OXD7NrP7MPsQy+XnTCmU
 RxNDJbU8A89fmIo1VQqk1nYW2UbXNCR+K8Nae3HLnYAlWIpQbRm7ILsGEzleW30PjO9Q89Oam47
 MvACWxCE3vqxEh6dCVf52nlmWDez8RxWYLaDQ7nC8WlVrHoij4ikhR9vyx0u0iYucC++sTigu3E
 +EkZvXu1eGWODsMAtlZKlBL6PplAyRElfyg05+OJdmdLDXpBO2JFi3U=
X-Received: by 2002:a05:6402:a255:20b0:6aa:f1d2:ddb5 with SMTP id
 4fb4d7f45d1cf-6aff442c2abmr1530347a12.31.1791373888306; Wed, 07 Oct 2026
 04:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
 <20261007-rv-dedup-v2-14-8a2f0f296a7f@rev.ng>
 <17cb7c7c-5f22-4a03-8855-4d1ec91d347a@oss.qualcomm.com>
In-Reply-To: <17cb7c7c-5f22-4a03-8855-4d1ec91d347a@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Wed, 7 Oct 2026 19:51:13 +0800
X-Gm-Features: AclHuK-Ah-giB4sLe0vH8O3RGeeOC7vhSqJMmJDFAl454lDn7GVLWvg40Qa5H1k
Message-ID: <CAE2XoE9eXXKQGZZ0kvmex88+tjch1-+H_-MgB6JEu+4bdPZq8g@mail.gmail.com>
Subject: Re: [PATCH v2 14/18] target/riscv: Compile pmp.c once
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 daniel.barboza@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x532.google.com
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

On Wed, Oct 7, 2026 at 6:25=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 7/10/26 10:43, Anton Johansson wrote:
> > Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >   target/riscv/tcg/pmp.c       | 5 +++--
> >   target/riscv/tcg/meson.build | 2 +-
> >   2 files changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/target/riscv/tcg/pmp.c b/target/riscv/tcg/pmp.c
> > index 99345d63dc..2d7194de10 100644
> > --- a/target/riscv/tcg/pmp.c
> > +++ b/target/riscv/tcg/pmp.c
> > @@ -638,19 +638,20 @@ uint64_t pmpaddr_csr_read(CPURISCVState *env, uin=
t32_t addr_index)
> >       if (addr_index < pmp_regions) {
> >           val =3D env->pmp_state.pmp[addr_index].addr_reg;
> >           int g =3D pmp_get_granularity_g(env);
> > +        const unsigned long_bits =3D target_long_bits();
>
> We need to fetch this information from @env. Maybe riscv_cpu_mxl_bits()?

discussed before, there is possible be 128bits

> >           switch (pmp_get_a_field(env->pmp_state.pmp[addr_index].cfg_re=
g)) {
> >           case PMP_AMATCH_OFF:
> >               /* fallthrough */
> >           case PMP_AMATCH_TOR:
> >               /* Bit [g-1:0] read all zero */
> > -            if (g >=3D 1 && g < TARGET_LONG_BITS) {
> > +            if (g >=3D 1 && g < long_bits) {
> >                   uint64_t granule =3D 1ULL << g;
> >                   val =3D ROUND_DOWN(val, granule);
> >               }
> >               break;
> >           case PMP_AMATCH_NAPOT:
> >               /* Bit [g-2:0] read all one */
> > -            if (g >=3D 2 && g < TARGET_LONG_BITS) {
> > +            if (g >=3D 2 && g < long_bits) {
> >                   val =3D deposit64(val, 0, g - 1, -1ULL);
> >               }
> >               break;
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

