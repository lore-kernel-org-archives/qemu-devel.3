Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E0AC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 21:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYBpm-0005fW-JX; Thu, 08 Feb 2024 16:21:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rYBpd-0005f6-SQ; Thu, 08 Feb 2024 16:21:18 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rYBpc-0006FW-CL; Thu, 08 Feb 2024 16:21:17 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2d0d100336cso4065281fa.2; 
 Thu, 08 Feb 2024 13:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707427274; x=1708032074; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uZymY1Qjp5Lp12gcMuovrao293iSuz7ISh3C4KkHEhE=;
 b=ODREEcS/MN2yuRXO6dcJF2XBVOgd7IM98jeWHH6C4uBlPit3B2SUX5wYvaGWdq9mIA
 +kEma1wtuUr4JrHdiOARw+rL5qjisVyBusAIV1QnbJnQF0XA0ru/d0o6SbBqQkU7hgRx
 GoVCR+4aka4/34r6RAtsojoCBNSv5KU+B8LO/fjVjmUOFf0ZipunTQW3pnkuHKbAG2Vv
 K8NVp3dKswDkK0a6GHji+u6wSIVBv5mFNjDDk8ZIsp+RD/EcQgIQu+5ea07eo1lyPXdG
 nWtTrLT6QO90QWfv7wbhKwo91Qs1E+sIa2h1y3TJ036afkKU5+Vs0/Y6NQ9h2e0rRxLB
 kEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707427274; x=1708032074;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uZymY1Qjp5Lp12gcMuovrao293iSuz7ISh3C4KkHEhE=;
 b=QkRPF9YG2yHdehM0CIHSori4wtHQ6G7x5X2lAG6kO3TP0OD4cOJEyqxvNwDOchaXYq
 WD2DjJIh754SZvE7gqeTT5CLHFR3e3+N5efjnjD5m7SCghTuPTVJq3NdvF1WfWkiLGod
 UbYjz061geOP1kkxf+joG+ULivV6ymgQwH7I0gKvEvqfd+Ck8xZ1VTcRjZmyz7s0GPKP
 24A83ckwinjFeSEcygDU6hzCewFjIx+vaWCX16/qAua/ggZQNrAv9T+k/Mmpw1zGr7eZ
 oBhdAHHCqOeFjxKa0CE6cC3ShPmGotUEmlnHz8MpfT7oCee2V2s5VqEiNKuAuYhrxkHv
 ozJA==
X-Gm-Message-State: AOJu0YyzMhj9YmDwEfSAfbwS1Dwsn4UiI4KKQacUTjmpgwGrDjK+9KNw
 hMP44jAK0mv6x+9h8Qre11A3hWzgVXm3Vvtdhz4euPS9bX19A8Q/TB/AwSwg2cg4a2ICSp2el3l
 j7N2UTmuZgt16k622TxzPWQtF/ko=
X-Google-Smtp-Source: AGHT+IGy1dZGeB0fTE+glKvEih/tpc6LeV0+WUZCG6AHYcFDfQOLxBfVBD1BLSRUjDxflRUI0wtmnxTZl6xRUgLnUj4=
X-Received: by 2002:a2e:911a:0:b0:2d0:99e5:84b with SMTP id
 m26-20020a2e911a000000b002d099e5084bmr411971ljg.9.1707427273906; Thu, 08 Feb
 2024 13:21:13 -0800 (PST)
MIME-Version: 1.0
References: <20240130002712.257815-1-stefanha@redhat.com>
 <08d8afac-d807-4fe1-9ef4-b7a338c145b2@tls.msk.ru>
In-Reply-To: <08d8afac-d807-4fe1-9ef4-b7a338c145b2@tls.msk.ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 8 Feb 2024 16:21:00 -0500
Message-ID: <CAJSP0QUsq1hOQW-Fr1rXsF2XDQvXjUSn1bNfKBB+Gyv6vT5amA@mail.gmail.com>
Subject: Re: [PATCH] pflash: fix sectors vs bytes confusion in
 blk_pread_nonzeroes()
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, Xiang Zheng <zhengxiang9@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=stefanha@gmail.com; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 1 Feb 2024 at 06:37, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 30.01.2024 03:27, Stefan Hajnoczi wrote:
> > The following expression is incorrect because blk_pread_nonzeroes()
> > deals in units of bytes, not sectors:
> >
> >    bytes = MIN(size - offset, BDRV_REQUEST_MAX_SECTORS)
> >                                                ^^^^^^^
> >
> > BDRV_REQUEST_MAX_BYTES is the appropriate constant.
> >
> > Fixes: a4b15a8b9ef2 ("pflash: Only read non-zero parts of backend image")
> > Cc: Xiang Zheng <zhengxiang9@huawei.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >   hw/block/block.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/block/block.c b/hw/block/block.c
> > index 9f52ee6e72..ff503002aa 100644
> > --- a/hw/block/block.c
> > +++ b/hw/block/block.c
> > @@ -30,7 +30,7 @@ static int blk_pread_nonzeroes(BlockBackend *blk, hwaddr size, void *buf)
> >       BlockDriverState *bs = blk_bs(blk);
> >
> >       for (;;) {
> > -        bytes = MIN(size - offset, BDRV_REQUEST_MAX_SECTORS);
> > +        bytes = MIN(size - offset, BDRV_REQUEST_MAX_BYTES);
>
> Hmm.  This smells like a -stable material, but you know better not
> to Cc: qemu-stable@ for unrelated stuff...  Is it not for stable?

This is not a user-visible bug. The code still works with the smaller
MAX_SECTORS value thanks to the loop.

It doesn't hurt to include it in -stable but I also think it doesn't
help :-). It's just an inconsistency in the code.

Stefan

