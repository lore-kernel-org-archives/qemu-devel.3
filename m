Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE9FCD98CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 14:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXgjQ-00018j-Tg; Thu, 11 Jun 2026 10:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wXgjO-00015T-OU
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 10:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wXgjN-0000sd-1l
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 10:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781189403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DzWiAI6vwGF0FhOWqrIFcAOlxkwI+atKC+Yy2K5mWOk=;
 b=ijd5986R3nKruaPl3ilhHTZXJNyunV8WvkxpqqjpNSwXzYY5whGBwOL6I9LWCK9G2lHudg
 r5D9DqnmEY4mXsOszyD3TklBHfQXgdJIf28pxA02dIG5SI224XnLLEt/kGCb6NTOlM5zQE
 yvqgQnCmJF2PLdvWUXvz8rF6MAYNhkc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-WbDfOlP1Ot6CdttHeFN-dw-1; Thu, 11 Jun 2026 10:50:01 -0400
X-MC-Unique: WbDfOlP1Ot6CdttHeFN-dw-1
X-Mimecast-MFC-AGG-ID: WbDfOlP1Ot6CdttHeFN-dw_1781189400
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45ef6ad76bfso3845584f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 07:50:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781189400; cv=none;
 d=google.com; s=arc-20240605;
 b=kwa0iUy6sRIODWeSU9HyaIZ2SNrQDeuHpAVhSP5OL6tob2ds3bpIJiik+R6ZGsPkQM
 U1ae/qt7j7flXQgXcxp1g84E8o2swWK1U5fTHpZsjh3Mfifqdwr1SPCHVkbOyv+PkK1K
 bszCfz7IuB0Z59neYrkDJRwGkd0hkJUUzfZynCqPVXJp1mBEY5Fcgq6d/YYhTWn+wnfB
 8X9jlWHkHGNRZUKysRCZpxTpRPCAwwtaRl8tXhl5IltnKgD93Vgv83q89CW+oVRflGEm
 IkpLvLASPlVwFj9ZQoBidT9rA0ru46kMwItMbfG0OxWu8xGj6bL5ljtHsx0ogSIVyiOr
 qpKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DzWiAI6vwGF0FhOWqrIFcAOlxkwI+atKC+Yy2K5mWOk=;
 fh=Vrhyqbizptv6JJaBq3Sj8aseb7Pj30y8bfLZTJDjx4w=;
 b=NXKaV+fBVSuJI/li9Y5VRPcnP8/fMCr7tsf0W9flm0IgGxY//CDFhv0uzwYheYvp8B
 QQ612yqkuafd+7ympswP6SjKetLd4ottFMVXzQGyO+aW2P3mIlTkYSaxdMqnR3NzKRGh
 vbaIKPYubrbIvUQ7MDv7han8rlG9DzDW3uKsnGCuCcAu/Cvek6u8+hP2tLR+oXTXlJlK
 wdY8llHD25KNWJ3bDirhlqQ3Jrfw92Xoi0UaR2OfqQVIypqbnpm2dUazJWBED9O+wOgW
 InAKdoVklTOOxtjOVmTMg22bfzYGRTjkjJtvIZ3l62FuY+j/8ipKQVltNlf6tjvUNtEZ
 aoAA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781189400; x=1781794200; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DzWiAI6vwGF0FhOWqrIFcAOlxkwI+atKC+Yy2K5mWOk=;
 b=r8ps3LxU3cpafTCoD49eMZWTfVN7qSELbr1Rmzt+4Z/tq1jIVwducuaid0m24sSrkI
 U6AC0AjFneOywkAacoTL3vYWaooegGTHNpQcohVT+PtUE4JD4tdqzZhf7X/CobRfs/ZU
 cnTJN5FZyJUzn4gIn4914DmYlN5oREXyJnrzq9lSEg38DNgkiJbL0Lf5mCncK4Jm8lnJ
 Q6d3E6GfAc1nC/QUa9aFrVJDwE4Ia/ZQLgD2m4+P3sXWHzr8W/SidgKmQktK0VLOF6cg
 Zujq0WDp7TxyWYW7nLKqxS9aKp+OMbG+GRkIPS43d8uouu3ZgEDTt+PNt+4IEZW9KQfz
 WFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781189400; x=1781794200;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DzWiAI6vwGF0FhOWqrIFcAOlxkwI+atKC+Yy2K5mWOk=;
 b=Cm4LcPI2pBezCpSaIQ87yfcISVpHHeRPqBfAGjlqrKHZzzQLovZtF52OQvsgVvRx5X
 l/8vzmql+Y7XO1JBQydAVPVlGM/zMdEUMOsgEyit98/TXIIY5U+5ZZHrrK56fpmmbTgS
 qZT3GPbcjv9ZsTspvBV3z5N03QUxo1KzqJMz8AcZujLiQ/Ze509NZB/z5eVS7DgOjkmP
 sRb0EAZBn+Jl6cWt1HojEni/bij9haZkHTVnJvRVOjJ7IuC0SgaawMr5O/Zx71H76VVD
 jZNtrUDjvZ7jHCLZdJH3b5USXS4KU7/tbB/Gnm2R+ii4UDaqs+Eup5AZlti4czYvUPvK
 IaXg==
X-Gm-Message-State: AOJu0YxDmPRCw7l1RL2o7Fj95Vo0LWEPItpOGYuFpg2WV5xRCioG8RDG
 pkn37D9uLyGLt4pXJA6SxrdOGNheE8w2BQgJ1Difdxzn40dGO1oXeMqovoKdN0QRyaQr+XWeb8U
 JV7R8o87NBS1bt4agVZs04Vct2qzO0YupFXC/1g2DFCLxBSw8NqC0dc1V6qDEx2kJrmZyn9HaL1
 ZiYbbMVbtINAyArUQ928dbKehlHluOZJ4=
X-Gm-Gg: Acq92OHN5sTTZOZKqh2o0F1rc4iL4ElJGawcTQ8cLC5fn5ioDl0QPWFXxdiAnQ1gVAh
 4PZKXai7zDkpN2Lhu48lj7RRxQpWgl8jURHoz6SpL2DeGKnJUwT1yDqPf1gEApU1AolbrfSEACI
 PTuoJpUSnm2lSgzZcUbseW3U4Z3zOfca77oxc7ZTJurITDBdKUkUCT0CSbiNVmrmVre0NazfBF5
 CAfXnrSqX/0HKynFj5ssLuNtH6DBvjFIKTMBs/3ZlobckmFn1IuVKr9KrvYkmj7A/rdlEc2/1gI
 gP/NKJFI93P4Zm8hNQ==
X-Received: by 2002:a05:6000:2508:b0:452:6aaf:76cb with SMTP id
 ffacd0b85a97d-460674772admr4746094f8f.1.1781189400394; 
 Thu, 11 Jun 2026 07:50:00 -0700 (PDT)
X-Received: by 2002:a05:6000:2508:b0:452:6aaf:76cb with SMTP id
 ffacd0b85a97d-460674772admr4746055f8f.1.1781189399997; Thu, 11 Jun 2026
 07:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <0a0a1116-a5f3-45f2-b079-f66e6b17f672@redhat.com>
 <c5945f76-ae18-4a8c-ae58-d22be7a7f6bd@oss.qualcomm.com>
In-Reply-To: <c5945f76-ae18-4a8c-ae58-d22be7a7f6bd@oss.qualcomm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 11 Jun 2026 16:49:47 +0200
X-Gm-Features: AVVi8CeojY-tAKMw1s-WmlI88t-Bn90WvGpOngGGwoGMBsULwsrOZDc8A6bqj8c
Message-ID: <CABgObfYy48HzQmJTJ4r_dswGjmgMkeuy=1OiY_VbEupC1UX6ww@mail.gmail.com>
Subject: Re: [PATCH 00/27] tests/tcg: run tests with meson
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jun 10, 2026 at 7:01=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
> Your idea is to have one project per target, and use meson cross compile
> support for this?

Yes, that was the idea.

> `make check-tcg-aarch64-softmu` is supported out of the box with this
> series, without having to write a single line of Makefile. You can still
> do what you like: see cover letter usage, to run a suite or a single test=
.
> I don't see rewriting the cc_feat part in meson directly as a problem to
> be honest. Not all architectures needs to check specific feat (only
> aarch64, arm, i386, ppc64 and s390x).
>
> Also, calling:
>   supported =3D run_command[cc, check_cflags, flags].returncode() =3D=3D =
0
> vs
>   cc.get_supported_arguments(flags)
> is not really much more complex IMHO, and not a huge reinvention.
>
> Also, the custom target is hidden inside tcg/tests/meson.build and not
> exposed to arch files. Even if we had multiple projects, I would stick
> to not exposing test() and executable() in arch files.

Fair enough.

> I would expect this file to disappear completely, and to rely on make
> check-tcg-arch-* targets at top level instead. Would that work for you?

Yeah, you're right that at this point TCG tests are the last
stragglers in that file. That tilts the balance for me, it does make
sense to do this with custom_target() until Meson grows support for
something like multi-machine projects. Just please add an alias_target
'build-tcg-tests-...' for compatibility with tests/Makefile.include.

Paolo


