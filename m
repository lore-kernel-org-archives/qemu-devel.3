Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7155FF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 14:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHjRG-0002fg-4y; Tue, 28 Apr 2026 10:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wHjRE-0002dJ-9j
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 10:29:24 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wHjRC-0005gC-6r
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 10:29:23 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-65c0891f4e9so18916157a12.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 07:29:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777386560; cv=none;
 d=google.com; s=arc-20240605;
 b=g2xuKrDuLTOC/AH4W46wpyzKBiRpcTwOMTYM2GuX3G3bUoVRg9TKPwAk9UCai+1V1k
 zvvPYyZ3jzhA2v755EWrthnlALmNWV9HW/yZ4+KJ5LxyjtQn49TT0HCV9KD9iCbuRqKj
 dA8+kcWCjfdPsjQhUn4FdJnz7QrImeq2QwrCujyYgvJfIT6dF2pB0EgoIeiPzTWRmeFz
 1e4SK5RIcitmHFCYNlTwPx3jnLekHvGb5V5Y70BBVfSkZftOTHBMcpNZswvoaqdP4ptr
 Rp7Ow0QijyqVPj/DhOrA9ECIHGgq3hX97M1hCAMQbzNY/5iHxfoCMVTU870m+xjMsCxj
 fYZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YcyG/1F3nXUVyq31n88lbs9OsX49y2JqeErrMkFMYi8=;
 fh=inp2XsE/DZ7vK5DmmrRMrmm7e0WoAwpRuNF3uVrFuWk=;
 b=KtjK0phSDphc9uuqpPKS91rVqzV1bnjamxNxBITDA4mbSE4ZQoPgx1essC1g6UE2MT
 rnAKAghHjZVZif1LIl4u8j5QfnDVOibYvzj3iu2ngHtNvpbphJsU9jFNWczhl/XH89Gt
 NbGmkLgHDfIjyhO66DNwgZF0LvRGUTygqK6ZjpDzwFiab1KypLNV6T/H/YwQoOpJlVng
 syiwMKLLySIdA6Xt+FCuon56b/WVQrCnj1mLBbyp9uTMqUuudzZJcFSCE4FfgfEpZD53
 1zJdd0LiRcrYWf6w2QhRC2R8ZA9mKmfW0oE/8fyLIlSECQ1ETVqoSiLNiEcqrHdbv5pG
 IwhQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777386560; x=1777991360; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YcyG/1F3nXUVyq31n88lbs9OsX49y2JqeErrMkFMYi8=;
 b=NGrfE9IQEsf39ObF2S7YpX4yhuzOGdGpI64tFMdpxkAO5kqvU8RYYQp4r4zcIf54mJ
 YLzqW9r34QgnAE4CqkvEqHvb5u7NGbQvp31So9jV7LBanxkaTxxmX/+LAF5bWeMPdUfP
 OI7m/cE/9M44klC+j4JWXluSkcTGPwwqqEWIaq6H1tCLbrYHBzsORA3hzMdg3jV3vMUe
 GvRP26hkHvuHGQ5WuwnCvzd8mNbBQlpyQPDEIR8EhdG9sqzEhReqQqieCIHqDs+vH7Gf
 ire7b6pm2Vxba1O9n0QVlNWD6A4GMKP9bufYQI2rKdGRK4zKgTe1M7M0+qPNz0WlKDNQ
 hYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777386560; x=1777991360;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YcyG/1F3nXUVyq31n88lbs9OsX49y2JqeErrMkFMYi8=;
 b=KlotfZoCxkQuh+49A0v7I295qNrbhNaNsNNnz6B2T3ORudtpeQtgZVNx0RDcX7nLSS
 RHnp+oJpOIxDrtF83bsz+9sTD1qGNaxeryVRFDglxwrtubvPH26u3aFvvVQCL4G6QMGx
 IZ/LCZba+BJKWqwHIITQuUOxCz1OUFZQODp7CzOBnXDlbk45XQFC7gVolKJBqrEtnzGr
 GYl3jBOUPmvjIzM1Y01Hsgnw9QBgb6Z9KQ61S80NI0XG5SIDR8JFtzHt2ZAd+nfleZkM
 IWPXNmuVnJnyzvQ8hVstbugf8RsIII2sRnsVyQvinKhphdwtuo+wFD+FgiTiWfb6XcNM
 7V0Q==
X-Gm-Message-State: AOJu0Yy2M6uTA538P1uda0+oV5bw4SHYezo2ncuVuzVmDrCN5qOj3Psj
 Re7OoutZ48Wvv8+6nv6UWiW6985pGaIep7hW1StHCltSH2kOVxXWKmNoxGdkbx0NavpRaChtVUz
 8chDjFIXJosxf0ug0dUv+aEH39Od2pq8=
X-Gm-Gg: AeBDievqdJaZUwP6w01Ax7KrJd0kQqQpqgE5njpZ/qxMJxWTJf9Ra4WItt+E2BxhcbC
 TuIHEOE/qMv5n27unmy+pB5zerixZRy1hMdIcVpzxJRU2ikBQFZLig/trvyUCZ/uINqJ5rpVI9/
 6bQMhDa0ZLxgLcqZTX9rnKQ2nhJUSCZFUxupb8Byzs+CBn/nV5gnVtxg3Is18X9NHfg/SXByTZY
 B2zJirHXOiwaGgX05VD0JWQxHWxK7kRlyWCcW1HTgPY/m6XNi0Kqt2xDqabpejVa7A7+6b3pOHX
 N/sdFa7Nv45wm3OLgakgmMUrn30M4hzcc4Y6cJgckXIuTxGa2CgY2JT5rR4=
X-Received: by 2002:a17:907:c783:b0:ba7:a94d:af83 with SMTP id
 a640c23a62f3a-bb803873d27mr206683366b.31.1777386560049; Tue, 28 Apr 2026
 07:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260428081303.990973-1-marcandre.lureau@redhat.com>
 <20260428081303.990973-9-marcandre.lureau@redhat.com>
 <CAJSP0QUjFupVz1uXuxgxbvTrmf_gqzV6tSg1tmuq_Lp7qGVyjw@mail.gmail.com>
In-Reply-To: <CAJSP0QUjFupVz1uXuxgxbvTrmf_gqzV6tSg1tmuq_Lp7qGVyjw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 28 Apr 2026 10:29:06 -0400
X-Gm-Features: AVHnY4JxfR5X49sh3f0xQOBGO5skCikVufW4qo03US3ycxLQlGj8SojUzT_-PqQ
Message-ID: <CAJSP0QUvg38ga-JeXVxRHxYFTyPjo7QZV2bOBAd7iosrqFJKYQ@mail.gmail.com>
Subject: Re: [PULL 08/15] ui/console: return completion status from gfx_update
 callback
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, 
 Jan Kiszka <jan.kiszka@web.de>, Phil Dennis-Jordan <phil@philjordan.eu>, 
 Richard Henderson <richard.henderson@linaro.org>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Samuel Tardieu <sam@rfc1149.net>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Laurent Vivier <laurent@vivier.eu>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, BALATON Zoltan <balaton@eik.bme.hu>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Alistair Francis <alistair@alistair23.me>, Alex Williamson <alex@shazbot.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 "open list:Musicpal" <qemu-arm@nongnu.org>,
 "open list:sam460ex" <qemu-ppc@nongnu.org>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Apr 28, 2026 at 10:28=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:
>
> Hi Marc-Andr=C3=A9,
> This patch changes the .gfx_update callback prototype and fails to
> compile due to the following recently-merged commit:
>
> commit 5ef60a3787e8e0dccf30dae3704d4f5249160e7d
> Author: Yucai Liu <1486344514@qq.com>
> Date:   Sun Apr 12 19:02:39 2026 +0800
>
>     hw/display: Add i.MX6UL LCDIF device model

For reference, here is the CI build failure:

../hw/display/imx6ul_lcdif.c:221:19: error: initialization of =E2=80=98_Boo=
l
(*)(void *)=E2=80=99 from incompatible pointer type =E2=80=98void (*)(void =
*)=E2=80=99
[-Wincompatible-pointer-types]
221 | .gfx_update =3D imx6ul_lcdif_update_display,
| ^~~~~~~~~~~~~~~~~~~~~~~~~~~
../hw/display/imx6ul_lcdif.c:221:19: note: (near initialization for
=E2=80=98imx6ul_lcdif_graphic_ops.gfx_update=E2=80=99)

https://gitlab.com/qemu-project/qemu/-/jobs/14124076225

Stefan

