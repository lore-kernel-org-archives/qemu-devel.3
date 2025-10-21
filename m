Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26FDCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 18:54:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBHV4-0002rw-VB; Tue, 21 Oct 2025 14:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vBHV3-0002rZ-DI
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 14:54:25 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vBHV1-0005LQ-MA
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 14:54:25 -0400
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-42e2c336adcso26375305ab.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 11:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761072861; x=1761677661; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PR45CDQdstzvQTq2qCm/ccgP2xai+QRVxgU98d/bzVc=;
 b=L823GG7fN5IXOC9akG6mmL+kc+wvY46+6ozOUjO8gqyrfJxqv08z5r/BOqd+0Bw4MX
 hStiQAX7MH8+Bu3f5t9ZHIVB+tKcZIOWpHCmITUmGciG6/tjly59sMQki/lUvNBkFIJd
 HLR9ENGebshrnxwcZO58nshJWzE3R/pjKMTPxo02v3G6BlOUsg0jjwRA1eeVPN821fhX
 X/byPTFpy9w57BF80So7BF+X16njtRA3unjz+Nrwm6tOJQH7uoLgciz0JO04aiydgHTn
 +KGhhGZTgHFHOO5Ar9CKXjegRyNORO6uz53vVOdzzRE12iPxrlXjICkrjUMc3PZQ82w8
 aTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761072861; x=1761677661;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PR45CDQdstzvQTq2qCm/ccgP2xai+QRVxgU98d/bzVc=;
 b=TphcgcoenchAIgcgZAtCtI10S/GG7UhDlEUbTUdUMLhpBbsipSXF8EBLkIprJEDzJG
 BGoc+C3QWGYG8kwICHvP3lj9jdUOOf3+KY3yqpZ10Cjk2SgvzkGkofIc5R8BdBTx5Gh8
 a1g0WHOZQxncBvswhJpc5Mb28ZIAo0l+kTLLiBB2CLTv70hi6xQ/j+QfeoaNZE1j3U3F
 U5H6K7q4QLBiTbPULzR5H+9AtxvyxiN6lDpt72vn5x0QkxCl+pjOIOyrN7aOAcz2OtVp
 snLCeavSlymVzNlZGBG/uAluDhY9RP8VD4duYZ0IkWNRoeKQ1CjMXsKrumFV+LznHep7
 JGjQ==
X-Gm-Message-State: AOJu0YzNnV9pG4yWkvQhuMKztXreYpYQ8rJYotJAzQkSwp4ykNwXiUwe
 UR0miblw7yuiDhJGBjvF3QkEulXJiNl/3aJCCRmUyAOSULHHDweIjFq+VscXqsI4OfCrLlAz03E
 zuX57zFBKnG3FZqepvuSwjNRm8ho4THM=
X-Gm-Gg: ASbGncvZzZybELBFiJw1zw9S943UkNPV6sXApWW/Go5dX6RCv32lndXwjRmDz/1mkk8
 M9njmojhlbe0UNtPq9Ocly93K7Lt4UlJzzeuaZXfVhcAI2e++VAGcR0y3iyxRSvetpZYTPxw0Tf
 qv7WKkIFwOkk+vlpX5MtyTG4xZJQxOlSyadB4g1irtWNdLqnInlNSTP5B8Eit6/IwJQCbBRteb2
 RFH9+BwsxHAlHJZ74P96u+9KCUy/siPoUnMVNnTh8nIZ3AziVZOmHUfHnt8cHEpXL/t+SQ=
X-Google-Smtp-Source: AGHT+IE2kR6FDVtHlsM/i3an9chwcZQOJjR5rjn7ZNbMCBYkHbeVfljDhR+tf+hqjtq2P51I8a7VHOrr/25RTu8Ntwo=
X-Received: by 2002:a05:6e02:460e:b0:430:c542:3270 with SMTP id
 e9e14a558f8ab-430c5423515mr209066815ab.32.1761072861241; Tue, 21 Oct 2025
 11:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20251020054413.2614932-1-dtalexundeer@yandex-team.ru>
In-Reply-To: <20251020054413.2614932-1-dtalexundeer@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Tue, 21 Oct 2025 14:54:09 -0400
X-Gm-Features: AS18NWD93dgRFaO9atWrJOUCg25en34HOn4ziQUk6oUVbT90NDKvFww8VOMjUIQ
Message-ID: <CAFubqFsiEGHP1Py78VapGvPBi1rpGWZcRbb8Li-QvWhbRGYDiA@mail.gmail.com>
Subject: Re: [PATCH 0/2] vhost-user-blk: support inflight migration
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Raphael Norwitz <raphael@enfabrica.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x12f.google.com
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

The logic looks ok from the vhost-user-blk side but some comments inline.

On Mon, Oct 20, 2025 at 1:47=E2=80=AFAM Alexandr Moshkov
<dtalexundeer@yandex-team.ru> wrote:
>
> Hi!
>
> During inter-host migration, waiting for disk requests to be drained
> in the vhost-user backend can incur significant downtime.
>
> This can be avoided if QEMU migrates the inflight region in vhost-user-bl=
k.
> Thus, during the qemu migration, the vhost-user backend can cancel all in=
flight requests and
> then, after migration, they will be executed on another host.
>
> At first, I tried to implement migration for all vhost-user devices that =
support inflight at once,
> but this would require a lot of changes both in vhost-user-blk (to transf=
er it to the base class) and
> in the vhost-user-base base class (inflight implementation and remodeling=
 + a large refactor).
>

Even if it's a more significant change I'd rather generalize as much
logic as possible and expose it as a vhost-user protocol feature. IMO
too much vhost-user device-agnositic code is being pushed into
vhost-user-blk.

As Markus noted this also conflicts significantly with Vladimir's
series so I'd suggest waiting until those are in, or possibly
attempting to generalize on top of his changes.

> Therefore, for now I decided to leave this idea for later and
> implement the migration of the inflight region first for vhost-user-blk.
>
> Alexandr Moshkov (2):
>   vhost: support inflight save/load
>   vhost-user-blk: support inflight migration
>
>  hw/block/vhost-user-blk.c | 52 ++++++++++++++++++++++++++++++++++++
>  hw/virtio/vhost.c         | 56 +++++++++++++++++++++++++++++++++++++++
>  include/hw/virtio/vhost.h |  2 ++
>  migration/options.c       |  7 +++++
>  migration/options.h       |  1 +
>  qapi/migration.json       |  9 +++++--
>  6 files changed, 125 insertions(+), 2 deletions(-)
>
> --
> 2.34.1
>
>

