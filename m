Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3245CC71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 15:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPjPr-0001e4-82; Thu, 12 Jun 2025 11:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uPjPi-0001cs-7j
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:00:23 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uPjPg-0003b8-K2
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:00:21 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6077dea37easo2070864a12.3
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 08:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749740418; x=1750345218; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CP5Uuh3yt7akKnN+XqV7fg3bgP1hU5xiOm/Fjl0Pz50=;
 b=kX2njudNfwzRF96129T1U4j42Io9bZFEUdhOGeS12xm0QR7PG+QHZL2cx7EmaZUmFc
 cwNoV5gQRl9hN+6LERvN25XZK+Vzc77XO8eObopeGLWhWTByvhl3VK1NGJz4Fdym2KtD
 emJKdnH+N+dPTaW12PHm64fxwkmsYYV1oXgN5SBcqs0SY/tDTY5chpUYzSzD+/nYIpNZ
 NtqV6tw+AX5DJHxqXrLWyKVVbf39vMMGTCkl9n9zj/HMjfUNYBrtCZbGQUHcXfCojPmH
 CnFGImJeHzH/38G+qLh4RbgpCh4Z+wWPCMSehrrQ9CGpTWUw/NBKuFM+XrfqA8PDHJKW
 Hg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749740418; x=1750345218;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CP5Uuh3yt7akKnN+XqV7fg3bgP1hU5xiOm/Fjl0Pz50=;
 b=C3TQwxmwHLBjcrp+FfbEpzH5IRzSlU5jlwSnoFWH5uFM3051TvYAaCFZM+kIakXxz1
 oAgxnB5835lTGEjzZ9AOV8sm3NgPjq7vpKAyVic0nMwDsKGoKz61cdj6BOQ0i92vzbZ8
 VOQECuw1IhBXiZeHmzUqhU3YXC2ERYl/KO5SmUh3PSAxrbzArWFZNZFtSb8I3Wx5r2Ph
 PpiyqYDInZPNvH1tzv65monPceg9tyVJRqc+934jVvV4pzBiJ5+j0nKHV162IVcGf54n
 x9YuDUAaTpRtszSjr01V1RaHCK4kkosytHG3O7+WncH8ivgF2iL88G4jsoFnVry+B4Mr
 oZfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4XnmJIr1Y1cKZzPjXr2zsLEKGbgrGZ3PvaKV32rmBhl2ACoEj2mM8FZlksjn+aggkLOyx5E3b3rB0@nongnu.org
X-Gm-Message-State: AOJu0YwMyGWR3mqKdnMZgF6Bda0Xp7blrfa6Z3UVCsS566/pyWx+oEuX
 dmFbSnPUelMNy3G+2DjFDOGfxh5rHYhNlIvIz9DQyORDw4IyyLD/c5XPhPzSKWVSUGHYIbOUIgY
 aeYGevp9urZ1RbidEsBeviCfD4GPVCqw=
X-Gm-Gg: ASbGncuaK8HhygH+3uhD/S3Vq15lVYniMXuE+6h3ZHoMdi4ErF/zq9w8P44xGJYcQ7j
 fmthbiLAYEy+/DGRpRPf7S6QIkDZMPNnBislYxMimsnfKHS+UATPckOBsGte1tpRoSWJl1rvwJM
 ScNXoi9Tin+HX16dUw+idskSmzxMZZTwpNH5o/85A8nQ==
X-Google-Smtp-Source: AGHT+IGBSQ6I7OkLxkAYVpt94gau9oZCmInqMOKVBI46pBpwA8O/1r/uMAJS4gvFlcNfHgBzTlbQMjeUfnAQS0Dx5Y0=
X-Received: by 2002:a05:6402:51cb:b0:602:3e3:dada with SMTP id
 4fb4d7f45d1cf-608af7330fcmr66446a12.25.1749740418310; Thu, 12 Jun 2025
 08:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250611075037.659610-1-kraxel@redhat.com>
 <3bc239aa-a2ab-400c-84b5-d7de3e5193ea@redhat.com>
 <CAJSP0QU++wDCXvYe2sUyHCZHrHVVY2ehdeAswjDE_5V2J-qE9w@mail.gmail.com>
 <4dd4bee5-7098-4f24-a81b-3935c58a6d9c@redhat.com>
 <CAJSP0QWyjzLLGnvrzMDtRubHuzAPWNtejb_wLz33PVWJ+QJLmw@mail.gmail.com>
 <4ftyylwfpk2d6xioduftadbbwq3cydjmzeaqivksseem4a2h5d@xg7u6y6qaaak>
 <CAJSP0QU-msg=bTwODkB5VPoiwMcDC_ozN=7MuG5tFDNiNDNOKg@mail.gmail.com>
 <aErm6omt7VSljvwJ@redhat.com>
 <suqgvgrk6kgcl3zgfn7u4nuuqat6e6h5dft5n7tji77ivfkloj@4zs2y2l6rpol>
In-Reply-To: <suqgvgrk6kgcl3zgfn7u4nuuqat6e6h5dft5n7tji77ivfkloj@4zs2y2l6rpol>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 12 Jun 2025 11:00:04 -0400
X-Gm-Features: AX0GCFvzbfvM6Y2SgsI4VPZQhFwjtzg6yNm1gZIyOiUzjo21_GxS7YMqPSf8jPs
Message-ID: <CAJSP0QWUCqY06WP+YT7qJxYr2CQYDn08ifJP=Em38LMN5YRA_g@mail.gmail.com>
Subject: Re: [PULL 0/2] Seabios 1.17.0 20250611 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52e.google.com
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

On Thu, Jun 12, 2025 at 10:53=E2=80=AFAM Gerd Hoffmann <kraxel@redhat.com> =
wrote:
>
>   Hi,
>
> > > I'm asking because if QEMU drops the commit I mentioned above, then I
> > > guess EDK2 CSM AHCI detection will break. That would be a regression.
>
> It was broken before too, so we are "only" missing a fix,
> for a rather esoteric use case.
>
> And it could very well be that this fix is not needed any more
> given that seabios got a ahci controller reset so possibly things
> are working now even without a ahci port reset.
>
> > AFAICT it wouldn't be a regression from QEMU's POV.
>
> Also not when looking at seabios release tags.

Okay, thanks Gerd and Daniel. The SeaBIOS update has been merged and
will not be reverted.

Stefan

