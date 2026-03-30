Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C7CFB3CF7
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 10:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w79bf-0004Oz-JB; Mon, 30 Mar 2026 06:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w79bd-0004OV-BX
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 06:12:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w79bb-0003DZ-Cx
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 06:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774865542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rm5EBi0QvU5O/5KF4KGu/4cRwbyc3toJvcD0uoNRW88=;
 b=KFu8ZFfJ885xDPeAB16SM6lv2eocFf2ghFFF2+yXGjDpHpZNVqwLB1evPW/WEQAtlwvrgk
 4Z2Efk9AdwO5RWzK1r+0BAxqP1T/OU/8WRENZzjdfBcBX6w5NboKOVtXzS1bz4j19QG6xE
 8ZyBnxYR4dHp2b6YCGNzHaMhJ9sIA9c=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-evseYAe6Oy6xKi4Ug2UHMw-1; Mon, 30 Mar 2026 06:12:20 -0400
X-MC-Unique: evseYAe6Oy6xKi4Ug2UHMw-1
X-Mimecast-MFC-AGG-ID: evseYAe6Oy6xKi4Ug2UHMw_1774865539
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35d9f68d00fso4657615a91.2
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 03:12:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774865539; cv=none;
 d=google.com; s=arc-20240605;
 b=DMMPrIltWbfRE3kSDrStADY2wX+FmignxfF5Z57j5NAvRYwB4tPclyYs0PP9X8OTbB
 WtvvG/AW2iIQP5JexI3AizmbNWYvFf3GPnDW3QpgtgK7vqbRIFWKYp5X2SuhMxsykSx0
 B8U4A1+Isx+Hv3zZSkBG4HduMdOrstTOVwIWGVYQbPA5fcDHWylYZqU3M8ZPdvodCcW7
 F9ClXSSRgh7mmKJcWmJS/R498JmA8vyEUH04jHtUSCqqDoOGpLvCgIZYKJ7ARNwqe4FX
 EoEabYonjKYZuI9Qy/061fvL97/HfJt9ZL+Xpq4LpSHVWhKTSnCW1b4AMTTkmSJk4SZ8
 7vJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rm5EBi0QvU5O/5KF4KGu/4cRwbyc3toJvcD0uoNRW88=;
 fh=EOstN047P43BMWYiYfNjXAFqxVDAuquNnj26iYRON0Q=;
 b=Cv9+1t044Z015JIchQlpgnt5GEp6E/C5j8LuW/6YlBI+H8kFKPQm5uey5RDyI+t3pB
 cAhxT2z09Blbdgk/k4EdlUeVKd5rIy/1S9p1ac/pQZAXuKtwIOAD841LgMhv9Ih/HYzM
 tehwvoDn/6J3bP1BAg613GTqfLClLeIctWrKJWWMaf1J1+Yj3+slpQHeTz34oKTeB8LF
 5hvdgeEymYMeG5mrxiLA0Wi5z7MoolYDy2v0NRqmd//vepqVYdP904LOuBWWOxkNl2te
 z2PTbx1aD+Uoj52qOsWEYcx/k6D6KVHs0sYT6jh6/XGtnCO4Nkax6PuFQQTcI3AosdS4
 KjAA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774865539; x=1775470339; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rm5EBi0QvU5O/5KF4KGu/4cRwbyc3toJvcD0uoNRW88=;
 b=OroaeUewcC7/SrMrn4AEaahIgfYjl5rcOeheeCLijkbMX2VHMJJejOqYTOr+HvFA6U
 wvbjB8k5A/XUnJjLuyOzPD1CE9wx/Dg8bfyLOblC3eesYZzueBhehuC27dIRgde5x6rz
 pLL1vpmcJt4AEL7wy3Twa7BgwXw5cnJFNjeZe8GgtRFyLLVMHfub8ErqJXR+KVP5JvGV
 5hfgugTboCBqE+s/3adfXTUo1+Ksjtp2GZaN9SKqYRUw+vL3MaxvduMRMrIKMxI8vpCv
 JdgsSW9Swq+CgDp4vPN+ruupulFk+tvCJCUdt+RY69imCHdGGKfX3FfuHeGfpsumnm/g
 Vh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774865539; x=1775470339;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rm5EBi0QvU5O/5KF4KGu/4cRwbyc3toJvcD0uoNRW88=;
 b=AbRUFNEE0/YHbc411JEcEhyE5T/461Txgw2zGq69CRllSdi7Eb/QpNjlPbT8+K+A8v
 d4/VKGDHk/Nh7vY603ErOCjyMiUDv0oLQKJtSMvDZwfaZnUF35tL3hXAkjzcIdRpOfHO
 f3TWHBcNe7KO19lnyEhat2wTpqiY85bkvOQWVLADycH6Ln7srN8m0ZHndkF4kRqt8JOm
 I2O3wW26U0hCho1nEaFSvtD6g7W+3MkaPHc25333kE07jMlQTjqc8LVsywxHaA0HcP2v
 KAyXyc7tRXAG4pNM3LVSyLV7Gh0FMgN9uljxZaO6xn5NIhVI704317TGTWIln+2lTHbo
 VR0g==
X-Gm-Message-State: AOJu0YyFhJL1yQcAR0jhfs5bzsSwLdllifPdDttuqh/GdRLttdUFAPK+
 FYpnkkLi7PrBmAg63oo8Pp2hwys94uYDcboTxYAWJsJ1tx+hNuM4Q/YID8wp0CXa9kmCrLZTpLV
 j0wUzQeBUK9IKVo9fLwbFB3JEwDouQcjjfk95VB1Ee3gfpBSeU1C/9EsKztEVtfjWyMfdeyvucF
 pRCH2OOT5FrSPjAAdF2g3jbJqVDnTiVtc=
X-Gm-Gg: ATEYQzzJJ2afL9N2Wdyya9Ju//BlpE/Uw5CST5Q9j+b5GQKWHGoPXtkWk/55sclLRoF
 BbB/sQ1DOhSW1g7cpJFu+nj95KMndUXsQUA4u8NU6wSsSUIBiu4LT0rRB+tVkgOoDLmiQC9l7QC
 VwGxhJaCQmOb07y+xrBlbQOqlo8cWvQBbM61kIbG5/lX+zHw0gvuLwLITS1ZAf3hdL1HAmiJXzd
 y9vBCHChUVZ5C3lhhhgbBQebArk55As5C7GKVCDKpAaR29DjoiIvvyavNzELi+rF8Uhvoe4sVhE
 NwG6bhnf2SJakr671glFiFc=
X-Received: by 2002:a05:6a20:7285:b0:398:9d5f:e093 with SMTP id
 adf61e73a8af0-39c8788a374mr13045414637.19.1774865539402; 
 Mon, 30 Mar 2026 03:12:19 -0700 (PDT)
X-Received: by 2002:a05:6a20:7285:b0:398:9d5f:e093 with SMTP id
 adf61e73a8af0-39c8788a374mr13045391637.19.1774865538944; Mon, 30 Mar 2026
 03:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <DB8P190MB07142E1BA8DEEA8B2E41D5B2DB57A@DB8P190MB0714.EURP190.PROD.OUTLOOK.COM>
In-Reply-To: <DB8P190MB07142E1BA8DEEA8B2E41D5B2DB57A@DB8P190MB0714.EURP190.PROD.OUTLOOK.COM>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 30 Mar 2026 14:12:07 +0400
X-Gm-Features: AQROBzBXJkvKDMHiADe5VeZkCpUaNY9ZH-P0I1A8FdeimEm8s7jGuIQ_d1t18vk
Message-ID: <CAMxuvaygbUf3eS+r-6=dxiZfHp5KrD7_QLhhnTf7KHfxU+CjPw@mail.gmail.com>
Subject: Re: [PATCH] tests: don't build audio tests when no audio drivers are
 enabled
To: Anton Kuchin <antonkuchin@nebius.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, NB-Core Team <NB-CoreTeam@nebius.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Fri, Mar 27, 2026 at 8:46=E2=80=AFPM Anton Kuchin <antonkuchin@nebius.co=
m> wrote:
>
> When there are no audio drivers configure fails with "ERROR: Command
> cannot have '@INPUT@', since no input files were specified".
>

thanks for the report

> Fixes: 3220b38a8d ("tests: start manual audio backend test")
> Signed-off-by: Anton Kuchin <antonkuchin@nebius.com>
> ---
>  tests/audio/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/audio/meson.build b/tests/audio/meson.build
> index 84754bde22..322755b880 100644
> --- a/tests/audio/meson.build
> +++ b/tests/audio/meson.build
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
>
> -if not have_system
> +if not have_system or audio_modinfo_files.length() =3D=3D 0

audio_modinfo_files is only populated and used when modules are
enabled though, so this should only be checked in this case

thanks


