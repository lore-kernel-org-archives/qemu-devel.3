Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE02C61DB6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wymXn-0005Uo-Dd; Tue, 25 Aug 2026 04:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wymXl-0005UC-Og
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 04:30:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wymXk-0006aq-4E
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 04:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787646602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n0zDmKuJ2ZyZg53wl0vaD0r+HCMcstzrixxBcJRFo0A=;
 b=X3tpc2fWRT0sjLKNYZvQQXvx0lDh/CpaEC/kT8WH3zZyAXUnZBNtKF5kcjxProh2OssEtb
 cvKHGb+4XXotPtrafI15u95M18BzbCMwpjZqtz8jEwXmWjWPIIu2LxPxtgjZksgnZ3b/hm
 GStUgxlvY0OD7PW8Rg1AA+8zirBANyE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-tH8dtYv3MICpF7XY7Xd3aw-1; Tue, 25 Aug 2026 04:30:00 -0400
X-MC-Unique: tH8dtYv3MICpF7XY7Xd3aw-1
X-Mimecast-MFC-AGG-ID: tH8dtYv3MICpF7XY7Xd3aw_1787646600
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8484ba00601so5141360b3a.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 01:30:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787646600; cv=none;
 d=google.com; s=arc-20260327;
 b=NUV94gSVDtGRkLwi2kVIOhc67MkWxwEnkXzdfXGF+obx1/Sku3rhzxteGjv9dB4dQr
 BgkCIZLYnZOHPL1TyWAww8ULk6mHtf1TF4a93h10P7TaFkdRb8Oo/K8WqOI8MK95LjUX
 X5UJp8z29j4pUjkjGcVlf4N2fwA4jkjE+nMS33xWSazTU8Do2hVnr8tXXNz4epW25u1b
 IFpJab/yC2C4Oh0cbnS0Ttwy0oWF6uL2PibwfiXkRAKR+Yd7D2ykD7hK4xFX8nsrC84x
 XXNJ1KEHD8gtivhBQ1ECibijo5slXJleFTJwW0hVNuIRg8kN4i6zC/UrBJFK5s9fnDau
 9Tsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=n0zDmKuJ2ZyZg53wl0vaD0r+HCMcstzrixxBcJRFo0A=;
 fh=yjTJynHG7nJU9z1fJdVzeIkzLWSCiz/u+PwpxN9HxNE=;
 b=N5zH35XZNehLnyLfYU5xfHKgG54w+TeetWd4eoWrl5wcFEYV7HtqiYcPjr80kBQigU
 rmn7gta8a+qmBpCv/NM5rXRQKOUzc40Ss/+QTnzN1LpqiH5jtbrObbqfujSAtq4fzGpX
 r8R9WcRywiHzk5bLilfipLVmghlZqILLYjkqNt4C+ezc4zRfKJBM0N7JQFKi1EbuK3iT
 st2Uli43siWlLGtBnbzmwFc29RS8y4E2hTv83y+lOv0SRWLcVGdbQ0KnFvtCXJ/+pjBT
 PXWrgB1OV+jZD3RhtE3Z0T3Gu/ok86q6ehcrqfWvTBWjeYBP8ts6eYmerA6av2P6cmR3
 H8Hg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787646600; x=1788251400; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n0zDmKuJ2ZyZg53wl0vaD0r+HCMcstzrixxBcJRFo0A=;
 b=kBAvm0GrkkN7Xs9aormdeIsAhRqiajEZ5rz2sPHorW6uTjRpsNHAocMIKasySoIjjj
 4r4i0Q+WODOky/wZopLx3ghy8MmQV3GMkXd4NlRp8f6L2ReR1Vf0EiXidz98TtwSlnxU
 CT+jg1qK3D72FWxMYbLVwXGOxs4OWgsT/DtdKAkm5ZbZHgmIc7SMU03HaRWHb65ULMYJ
 Jf+ND1VXjNdZ2/2vJCtBEcIiftzPfSzvNLJ1RX/bUbzuOcz3Z+LokHaEqk2cXGPIduFx
 6Kl+e6MIxLjMzi6w3eTUyYB2cIW8triqtXqc+2JZiwSmm4PH916MpHvAhU78BVQdWu+N
 uq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787646600; x=1788251400;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n0zDmKuJ2ZyZg53wl0vaD0r+HCMcstzrixxBcJRFo0A=;
 b=jH8Hh+5UPt0SLUJ5PqSuHGObMCuI2Psc3J+oJ4EJfXT5n0N6Gfxlo++fb8PWjs2u2M
 4FAFAoof+Q2OM766DUvjq/UgNDNcgzFU4QooORKbgHVlCdKYe+9EJVhg4dPnHE2rVZgA
 HrvxUpl2OpYUcQJB+2ulEhOBKNl7ExAxdLATsxTSj70QbNildei8P/MeDqSgT7VvQi2t
 rb3k+uW30Wzhi5FdA//K0YKvHl7iWCYGPQP8KHXCx0R/y4/9HTL6BQwfC6jc+oaKf7h5
 PPee6pDL59f8gXnl6kIMrt3oEi030JLoj/JLaMs7BgqunLC0dmO48aHicUhaFZCG9Tk5
 56ng==
X-Gm-Message-State: AFuF++mn7f1lMLqmCsxnIRMdYVPxisL6ii98hoQi+L5v/xGq+FZf7nKS
 TxZflb4Kt0N+PuTt0MdFmbfqQdKuznU71f8Cxyqiz17nuL1hc43uJkXB1zQTvZ84tTGpRSO4gLA
 Wb4VpGrOPv0+h/FoAcoLwwJlWOAQabEbdNy1f9m5a4hQfghIyrotlqtIatzxbCzhEqw3U9ulyWA
 FMG69RsdipCBdd7QCIkXe2HkLVUtREUic=
X-Gm-Gg: AR+sD12hJDgLdI22CjiODjIMSy95Bau+R65FebWnplwqo4qEMsMwnC/8suX3NKvHtJs
 dH6n7P388w9LDGYw/6oAknuwRDzw1/ad2P34FFs0voJQmIo57uY1PUGAjT/bPOhpNCkhYXDYyfB
 M0/hfhBqPEeY4avMBOOJY0NxVlr5XdVfs1Qgzf9wBaUDGlzgrsGyoBNKUcd58Mza2xSUOHMV0fw
 E68+zDu0SV6cnMd+MrZXMwTKShRoEU9DzMgs4gV8K3c/YnBaEaLVDEGhEq0M7Nkv0hga54Hv6R2
 cA==
X-Received: by 2002:a05:6a21:320b:b0:3be:b0b3:3962 with SMTP id
 adf61e73a8af0-3cd9125ad6dmr10326640637.9.1787646599723; 
 Tue, 25 Aug 2026 01:29:59 -0700 (PDT)
X-Received: by 2002:a05:6a21:320b:b0:3be:b0b3:3962 with SMTP id
 adf61e73a8af0-3cd9125ad6dmr10326536637.9.1787646599233; Tue, 25 Aug 2026
 01:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260825075127.34876-1-christian@quante.one>
 <20260825075127.34876-3-christian@quante.one>
In-Reply-To: <20260825075127.34876-3-christian@quante.one>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 12:29:47 +0400
X-Gm-Features: AcwNN1X5cVg_ZobNwHAeCqqUaSutFZS5yMddh9u91THnFSyEUg3viFD97avSjWQ
Message-ID: <CAMxuvaxBhXsPb0KDv9RsgBc8FC5hhP2z5fKDSqG=U+oexoM-1w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw/input/ps2: say why unknown keyboard commands
 draw a resend
To: Christian Quante <christian@quante.one>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Aug 25, 2026 at 11:52=E2=80=AFAM Christian Quante <christian@quante=
.one> wrote:
>
> The keyboard path has answered unknown commands with KBD_REPLY_RESEND
> since commit 06b3611fc2a3 ("ps2: reject unknown commands, instead of
> blindly accepting them"), but never said why. Give it the comment the
> mouse path just gained, so the reasoning is written down in both
> places.
>
> Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Christian Quante <christian@quante.one>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/input/ps2.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/input/ps2.c b/hw/input/ps2.c
> index e8300d2d83..01af4350b3 100644
> --- a/hw/input/ps2.c
> +++ b/hw/input/ps2.c
> @@ -647,6 +647,10 @@ void ps2_write_keyboard(PS2KbdState *s, int val)
>              ps2_cqueue_1(ps2, KBD_REPLY_ACK);
>              break;
>          default:
> +            /*
> +             * A PS/2 device answers every command it is given; an unkno=
wn
> +             * one draws a resend.
> +             */
>              ps2_cqueue_1(ps2, KBD_REPLY_RESEND);
>              break;
>          }
> --
> 2.53.0
>


