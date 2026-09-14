Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE53C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 18:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6AzJ-00009L-FN; Mon, 14 Sep 2026 14:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x6Ayx-000055-0t
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:00:43 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x6Ayu-0001tF-VO
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:00:42 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc4bdf8abdfso1709010a12.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 11:00:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789408839; cv=none;
 d=google.com; s=arc-20260327;
 b=HbJiRyEigmWSV2j2ne5y5mFq7A6KkQ8Xhk8BD87ZG0mmcIggcpGjw+7X78U8PqlFqW
 gZ+s75lZNuu18UrRPw5+sHhFLZ0O3RTP7kFF35iMHDLD5Fta+5sqYnB9MijzViAvjSmH
 379fP0TRJ8y4V52pQqjCdCKAUK3cM/kMDpBikQLq8qqS86pMR2zcUymFMooV3U6rrdZs
 ZVfjdAaAKjpJyBfIfXsGHk9gW7G36nj2OxSiMl37DnZUolJENsyez/lWSAQW1sjOoe9D
 +z1WCjARJDrE53LG2dP0uT968l+3uny6h7fq93tpVaiHSBh0E21zqqSQWOIclJXUPNKg
 Q6fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qLx6YTPY42OoDaH+XWYhYtLikQ9imOb4tE90XipzLMs=;
 fh=zBOZjaodd8HjBzksnz2doaL98Xv4I5fMfSyMIwHD0os=;
 b=GIYMRXI1IftY7TNtuAy1eGUJmqLi1wdgK8X/royb2jLPCGIQyFR6nejptWfF8O5Hk3
 u2yV1FxQjGgF0Td6TMVfbZ9s1PAaXbD75qavX5TxOsJdthOv9koH/OQ8rWhNcKILAhy/
 zopRV5xHKPZcAk0DL2es1plJ8o7nn+qMQKfhYJlNyuq/8B1ag7vbVnPIq4Xe/sUES/ut
 zRTwHPnq2sC/PlP9zdx6PMhkIVOb1I9EXLl2uRB9rUoS1yVwsVh+TKl5l0c2043Z1s9A
 yk5fSww8Cro/fRJi3Mfi0LGgUg6gXsYw/pK9kULcZ4IwYqDKcnBRSisL3OKbz3/5IXfR
 E2zg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789408839; x=1790013639; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qLx6YTPY42OoDaH+XWYhYtLikQ9imOb4tE90XipzLMs=;
 b=dNtWfFHCSW2l25tskOdUxItbN7PwnJzqtvaY/XxURvk8GT16ez59gY0P/3L0uii0ZX
 Hj5LD/AJBUfcUOJUPmPSa03dVI51/RqckF7VTrcrdnsBw6D8K/omJLttAZoTFN6nXnA6
 AOuVSbJ0PqZuJovqWHT5529GBRtZM4yRlF52peSLD9alKrLrc3fllWyA80biaedawAgD
 GazL3i8i/hbWL/lQQOtMH9h8bLg8AndswtPr9InR6t/AKi2m0RTcBO2BeKpNxoEGw4bY
 BW7DxplfhYWm6GcCYME4R24LIqsT8HtuMXKTXyEQnxBm2X2gwDZXJTDc9mI10PoT9yZx
 /zNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789408839; x=1790013639;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qLx6YTPY42OoDaH+XWYhYtLikQ9imOb4tE90XipzLMs=;
 b=btaMSJBhYE/kRkgAj6TehspKWrhD1YOajpaMGgd5W851j+Ad+2BPP/1zcNi7Q/xR/L
 Jb2s+cpVDbwLaHRs1mm3+jgodRn4DncVzNSZbyfO48r83OOaW4HziA7jgWWZdvEaI13U
 CtccWeq+xCl/+cL8kIVaD2tZT7Y3PD43ChxKpAGVK302UIO3kJFlqeA7p5gEO6uKDRhs
 jAH2aTzAlzJPmiO6tC+XYnQRTZ/TMNdFCZY7CP3Rr9Ammm4tB4+C0M/2wkzFFHEojHyM
 TGKDpmJFD6holvITnA6WL0071KRSPmTOzZkymOXymPPuBvMmtmKPY+pjuU9yt+W5r52x
 dYUQ==
X-Gm-Message-State: AFuF++lApi6mCF/7VxJKN0OVWrHf5lsXB5fwcu87bVvg3296J+CqZCmZ
 MKy29ehmzFSeWnqmO2saAM6zYsGctptoZ6AFoxtIWI26aLk/m2nhFOPUwtB9xPKti4qv1JC+CsD
 bCih9UYN7dQnbUqXSyRrTsooKAxn1Sjw=
X-Gm-Gg: AYBFou3f+ks58l46MyLWy8FtyjPZvNfHCQ2PrBjBPY2+9hAB/52LZzmwOOeD5eghh9p
 qcbK61NNdTO7Jc+3q4M0RWctDAR103fm29sthqeD3zJQVPau5wWO6nVzPyJWToBoeH0ucsQqFmy
 3uZqzMFflK6mBcfgSkT6anLHCOB0ks3D5n395sJwn5tnWtd8Yztg5aUL236EvpFAQxaUl+hE/bb
 eonsMm7R6iIn9+guslx/N3EK5Sp6H7avPJXqk5tSakkj8GJpSe2wt6bnViRkmAWpTizpcekE+ei
 l3EYk4LV40nowLT4UyR8JDrs2yuMAi3B3gAUlg1XJVKzcQG08Gfi2fjBFvoDb9c9NylscPe78x5
 jZiOp71NbJP8=
X-Received: by 2002:a05:6a21:9208:b0:3d2:2afa:d7d with SMTP id
 adf61e73a8af0-3db4061f380mr8944528637.18.1789408839054; Mon, 14 Sep 2026
 11:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260914165250.88382-1-yodel.eldar@yodel.dev>
In-Reply-To: <20260914165250.88382-1-yodel.eldar@yodel.dev>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 14 Sep 2026 22:00:27 +0400
X-Gm-Features: AcwNN1Wys-QOVOZ1xsRlf9k-B-n0xfx41idEdGDD7qKVaNNhpRBqJoeOk_BxXjA
Message-ID: <CAJ+F1C+QYW_kv53osMMrmaH7P0xcw_8GsfjkueLzY-QdQTe+-A@mail.gmail.com>
Subject: Re: [PATCH 0/2] vhost-user-bridge: Fix stdbuf and ASAN interaction
To: Yodel Eldar <yodel.eldar@yodel.dev>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pz2-x10.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Sep 14, 2026 at 8:55=E2=80=AFPM Yodel Eldar <yodel.eldar@yodel.dev>=
 wrote:
>
> From: Yodel Eldar <yodel.eldar@yodel.dev>
>
> Hi,
>
> As reported by Marc-Andr=C3=A9 in (1), the functional test of
> vhost-user-bridge (vubr) encounters a runtime error when
> vubr is built with ASAN, because the "ASan runtime does
> not come first in initial library list."
>
> Upon Michael's suggestion, this series converts the DPRINT
> debug output macro in vubr to use stderr instead of stdout
> for output. With that change, the functional test no longer
> needs to invoke stdbuf, so it is removed.
>
> Thanks,
> Yodel
>
> (1) https://lore.kernel.org/qemu-devel/20260906-nohmp-next-v1-2-2b21e6397=
4f3@redhat.com/
>
> Yodel Eldar (2):
>   contrib/vhost-user-bridge: Use stderr for debug output
>   tests/functional/x86_64/test_vhost_user_bridge: Eliminate stdbuf usage
>
>  contrib/vhost-user-bridge/vhost-user-bridge.c     | 2 +-
>  tests/functional/x86_64/test_vhost_user_bridge.py | 6 ------
>  2 files changed, 1 insertion(+), 7 deletions(-)
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

thanks

> --
> 2.55.0
>
>

