Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F009ECE8349
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 14:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svH2p-0006TH-O9; Mon, 30 Sep 2024 10:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svH2o-0006Pi-6e
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 10:06:34 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svH2m-0005jd-AW
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 10:06:33 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c8844f0ccaso3889417a12.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 07:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727705190; x=1728309990; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pxxUIsBHLE7oynpVymU+n9qMCquRJ8sQDxemGTRkvJY=;
 b=AibAqaGOdqKE+n8WJKH38J0f6Toz/YB/D3CAUfaslX9ov/ZzUkWzoVbUAQamRwZOv/
 PrB4L8kBJLgZvpsllEqInXc2MexQuMG+MMwnRe2N0iGS8vJ0V+aDYJApKc2reA3MGHGs
 Df7/rKqkPsJGsGQUT+DNYyPPhP/762RkvoHNDI2Wqxsp6f9VgVvWNWf25TCDs7qGcTtP
 zEDEfu6iLws6wUuDNfsfMzP0MfvvuvaHINreIeEVCUAdCXB4T0SvXHx9ziUToi9IAmAo
 KcMBQtHXZkRva3DMwgOLqfOt3nvIZJXT0mK9bbXaczOG81cqWHTDUSINCu4iB+1ZDmie
 gWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727705190; x=1728309990;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pxxUIsBHLE7oynpVymU+n9qMCquRJ8sQDxemGTRkvJY=;
 b=KJCf0FM5TQM17ALTFylmskllRVRNOx3ZwjWicKsJNRAsTVpk/p7/lP8M0Ij1jBT4Pk
 eJtwpd9mNHbXT+GewUyAr6CO58dv/zhFBHix+xCIFIRYiKjBrltxO52t4kiVppEIG99a
 LwRT8AmW8q5R3yYxE0gBb4nVrdhBr4aIhexenQkt7Ze8Nr726uz7AVM5pX2VxoOO3jl0
 +zuKeCm3ZKtBsqAgv+1zDJQbqWNddyiv206yh/lSYu/t4UJmUYnwy5pnsrZli3Gtqw/k
 eTKvhK3BVUD2SNSiRFm9wQThMwnalAGHvD92ZkkVcz3jeUwo8X1xSL7JsOhrEvVFE/Te
 lNNA==
X-Gm-Message-State: AOJu0YzgB0Gr6PiOwU5kRaYaju6PWcf6KbPuPrxt26IeuJ+L7wrZYDd/
 IYffP26mMwQC/vvThm1UPHhWo1HWkb6rDSzvXXclm54E3RsClvoXPXDYjTC0mwtuZIzpqeJgXgv
 U4AmLb/PGBw1XvIjwPqiJtoWKvGmSW4NQiJSkpb+02XvgQeNn
X-Google-Smtp-Source: AGHT+IG7p5E5SdGjSvWuTTeTraepgldiGwmLY4M9paYNZOg+zpjMcgP55F7XRyFcr3wvWVc9AZaql6qIdhbo0n8DQrA=
X-Received: by 2002:a05:6402:27cb:b0:5c8:83f1:2531 with SMTP id
 4fb4d7f45d1cf-5c883f12765mr10695448a12.28.1727705190241; Mon, 30 Sep 2024
 07:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240929081724.2139556-1-gaosong@loongson.cn>
In-Reply-To: <20240929081724.2139556-1-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Sep 2024 15:06:17 +0100
Message-ID: <CAFEAcA-zgk0rJPqBhHQQwV-pQ-eR8+Mo5F+U3=F31NRk9Vy9tw@mail.gmail.com>
Subject: Re: [PULL 0/7] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Sun, 29 Sept 2024 at 09:35, Song Gao <gaosong@loongson.cn> wrote:
>
> The following changes since commit 3b14a767eaca3df5534a162851f04787b36367=
0e:
>
>   Merge tag 'qemu-openbios-20240924' of https://github.com/mcayland/qemu =
into staging (2024-09-28 12:34:44 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240929
>
> for you to fetch changes up to f7c8ef7bad7495d8c84b262a8b243efe39e56b13:
>
>   hw/loongarch/fw_cfg: Build in common_ss[] (2024-09-29 16:22:56 +0800)
>
> ----------------------------------------------------------------
> pull-loongarch-20240929
>
> ----------------------------------------------------------------

Hi; this fails to build on 32-bit hosts:


https://gitlab.com/qemu-project/qemu/-/jobs/7953018819
https://gitlab.com/qemu-project/qemu/-/jobs/7953018846

../hw/loongarch/boot.c: In function =E2=80=98init_systab_32=E2=80=99:
../hw/loongarch/boot.c:187:10: error: cast to pointer from integer of
different size [-Werror=3Dint-to-pointer-cast]
187 |           ((typeof(p))((uintptr_t)(s) + \
    |            ^
../hw/loongarch/boot.c:201:9: note: in expansion of macro =E2=80=98BOOTP_AL=
IGN_PTR_UP=E2=80=99
201 |      p =3D BOOTP_ALIGN_PTR_UP(p, start, EFI_TABLE_ALIGN); \
    |          ^~~~~~~~~~~~~~~~~~
../hw/loongarch/boot.c:243:1: note: in expansion of macro =E2=80=98EFI_INIT=
_SYSTAB_GEN=E2=80=99
243 | EFI_INIT_SYSTAB_GEN(32)
    | ^~~~~~~~~~~~~~~~~~~
../hw/loongarch/boot.c:187:10: error: cast to pointer from integer of
different size [-Werror=3Dint-to-pointer-cast]
187 |          ((typeof(p))((uintptr_t)(s) + \
    |           ^

etc.

This happens because if the argument 'n' to BOOTP_ALIGN_PTR_UP()
is a 64-bit type (as EFI_TABLE_ALIGN happens to be) then the
expression ends up being calculated as 64-bits, which is bigger
than the type of a pointer on these hosts.

-- PMM

