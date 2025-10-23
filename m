Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EA5CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 17:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBzVM-0007cb-0a; Thu, 23 Oct 2025 13:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vBzVJ-0007c2-PV
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 13:53:37 -0400
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vBzVE-0003Et-TT
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 13:53:35 -0400
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-430cd27de3eso5303545ab.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 10:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761242010; x=1761846810; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gLxuKcSubCR6viDDbMsAbQt9pP1J4RDabAVm7vVMkeg=;
 b=JsvNhQX11pnNU4aJb9eb9WE4jdfb6Mc3kyTh1Ol6KA5sI3DR+dP3fW16jdLQrV3nXO
 kGSm9gX+SknopwzECYmtwI8ESgMUOGh3qE8rKF/SEqDfHQ6SWYa6tE8jITFw0xxGO1zm
 Jj7cA3vW9feJ9EzruB6fVBRr3JUaddqYfW7lH0yOygxQrNrQWmyZAtpNpRs/wUymUXxV
 j06XvFYlt74vWxZgb98ieyqUaamM/4uHJ1U87ktUzlx9O2GBytgKhMwE2TRhZkDSG0x/
 jZZMyYYsmgO5MPBFQX3oyElcl5pp+FEoAAh3mC9EYX+YAmUiSMMQhNlsMeO7wiwuOUHY
 rQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761242010; x=1761846810;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gLxuKcSubCR6viDDbMsAbQt9pP1J4RDabAVm7vVMkeg=;
 b=ZIrvnoZudihOx2lpGdZijfXJlGZjfmC+Rd2DrXHQhidW4ebCQkwLhj0ubYwUefP37s
 Hd7jRjpAesPMWKggrUzd15lIQO9HdQL0e77AyCtB6RGpJXZePI6R2+V7uDUQU6X2TYdC
 BL/07VPRxjtaJI2eKKFMPXH9pDnqpT9gkKs9xbHQjLa9w61FONtvdVAZlnr/EUYT7z0I
 5oL2vTMfi2XU09kR1CMWBOi4mf9KjNlfCgl1w1oXsMONh9fJ3QyaNxUrZKPlZZo0G8Uc
 p1fR8GGPjYUrI6usECLwXbXZFZvxihFrr9mmp3A2t8khW+dVcTqJFjwjB8Yq+Sk5bU9o
 92/A==
X-Gm-Message-State: AOJu0YzgHYtLxGKBTTLmksc5IEGTAMaXegU8YIt92xFQUIA5LX+rRhqy
 0FFRPCG7LOmI/shVwJhxUGQsA+fq5mcmkaEEanWK3DQkXLsOKYn/DWXFdF9CNjofLdtLXqrAHZv
 BI2lXoumUpqQ+00SmicIoU6vjvg44erE=
X-Gm-Gg: ASbGncuyyBL/rbx7fW5Q0XuFLlxWqWMmqFWThpPlhZS0BfXxxHZwId3CErXsyKn0ToU
 MlFSGx2AGQi7IF2nBwDJFiJl/CQ3xwtON+9PZjgI+XDUy+uI+QeAExO5SRlcWoBY0HYMew2UgDF
 VZijpsSeCdWG8cylN0mDsYICpdCrLjDJA3X/GkNQjj3haCZwdg3NsuYNssBVfzbIs65qR5AtUXw
 66ahJe60IS397kiU63Q9sCKX0TqmLZH6Yr488UofO2ztghYiXNzJsEAtXZw
X-Google-Smtp-Source: AGHT+IGoD7YdMSCZo94Q/k2r/atpPo9Czh3sPNRkSu0OMjXaGTB/2QVX2hQULCwIBzlprMhogMDsCG5tVUIo3YF+Inc=
X-Received: by 2002:a05:6e02:216e:b0:430:ab21:8c4d with SMTP id
 e9e14a558f8ab-430c5232bd3mr346212725ab.11.1761242009968; Thu, 23 Oct 2025
 10:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20251020054413.2614932-1-dtalexundeer@yandex-team.ru>
 <CAFubqFsiEGHP1Py78VapGvPBi1rpGWZcRbb8Li-QvWhbRGYDiA@mail.gmail.com>
 <453ec8f4-fbda-4411-a02c-5d30429d7083@yandex-team.ru>
 <CAFubqFsFPoa5xuP1Pd=hhY1bo5vhLL4chhEpfVn3VxhR_SnZEQ@mail.gmail.com>
 <8c79d385-d7a9-4752-b610-9d7b8b3c7f5d@yandex-team.ru>
In-Reply-To: <8c79d385-d7a9-4752-b610-9d7b8b3c7f5d@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 23 Oct 2025 13:53:19 -0400
X-Gm-Features: AS18NWCNN46csafOKPwsJsjcXiOxv392LwYi2xrYiM4Srz-PkZklz85Pvce5mOU
Message-ID: <CAFubqFtTWDeDUUxq1jO=AFuwd2vmiTYa3ZbVZLXmxNUp01xVtw@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x133.google.com
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

On Thu, Oct 23, 2025 at 2:44=E2=80=AFAM Alexandr Moshkov
<dtalexundeer@yandex-team.ru> wrote:
>
>
> On 10/23/25 02:33, Raphael Norwitz wrote:
>
> On Wed, Oct 22, 2025 at 3:59=E2=80=AFAM Alexandr Moshkov
> <dtalexundeer@yandex-team.ru> wrote:
>
> Hi!
>
> On 10/21/25 23:54, Raphael Norwitz wrote:
>
> The logic looks ok from the vhost-user-blk side but some comments inline.
>
> On Mon, Oct 20, 2025 at 1:47=E2=80=AFAM Alexandr Moshkov
> <dtalexundeer@yandex-team.ru> wrote:
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
> Even if it's a more significant change I'd rather generalize as much
> logic as possible and expose it as a vhost-user protocol feature. IMO
> too much vhost-user device-agnositic code is being pushed into
> vhost-user-blk.
>
> As far as I understand (correct me if I'm wrong), but this feature must b=
e implemented in device itself (along with inflight field location) or in s=
ome base class for vhost-user devices. For now vhost-user-blk doesn't have =
one yet. The closest base class that i could find is vhost-user-base, but f=
or using it, it has to implement all device-agnostic code from vhost-user-b=
lk, and don't break all existing vhost-user-base derived devices. For examp=
le, to support inflight migration in base class, there first need to implem=
ent inflight field in it, along with the reconnect feature. Then, with a bi=
g refactor, somehow inherit vhost-user-blk from it, along with other device=
s such as vhost-user-fs.
>
> So, IMO it looks like a whole separate track that will need to be tackled=
.
>
> I get that inflight is inside of struct VhostUserBlk, not in struct
> vhost_user. Even if not all device types support inflight I think that
> could probably be changed? If we do keep things as you have it here
> patch 1 should probably bring the vhost_dev_load_inflight() and
> vhost_dev_save_inflight() into vhost_user.c rather than vhost.c since
> only vhost_user devices seem to use inflight.
>
> Firstly, I tried to implement inflight in the vhost_user structure, but t=
his structure is initialized on every vhost_user_blk_connect() and then des=
troyed on every vhost_user_blk_disconnect(). But, the inflight region must =
survive device disconnect.
>
> During active migration, the vhost_user struct will be destroyed before t=
he inflight saving.
>

In struct vhost we should probably add some data which persists
between reconnects. I take your point that we cannot generalize
inflight migration without doing that first.

> And you are right about the location of the functions in patch 1. I will =
move them to the vhost-user.c file, which will be more appropriate. Thanks!
>
> As Markus noted this also conflicts significantly with Vladimir's
> series so I'd suggest waiting until those are in, or possibly
> attempting to generalize on top of his changes.
>
> Yea, but i think, i just need to perform inflight migration only when som=
e non-local migration flag is set.
>
> I'm not sure about that. While it may be completely safe in your case
> to avoid GET_VRING_BASE/quiescing the backend, it could introduce
> corruption cases on other vhost-user-blk storage backends which work
> differently. I think this would require an "opt-in" migration
> parameter over and above checking that it's not a local migration.
>
> In patch 2 I introduce migration capability for that. Or you think that w=
e need something like per-device parameter?
>

My point here was that you will definitely need a parameter you have.
I'll leave it to others to say if we actually need a per-device
parameter.

> Ideally there would be some way to have the vhost-user backends expose
> support per device with a protocol feature and, if the source and
> destination both advertise support, we perform the inflight migration
> skipping GET_VRING_BASE. I don't know enough about the migration code
> to know how that would be done or if it is practical.
>
> Also (and I think this also applies to Vladimir's series), it should
> be possible to add multiple vhost-user-blk devices to the same Qemu
> instance but have the devices backed by very different backend
> implementations. What happens if some of those backend implementations
> support things like lightweight local migration and/or inflight
> migration but others don't? Ideally you would want the API to be able
> to select target vhost-user-blk devices for accelerated migration
> rather than assuming they will all want to use the same features. I
> don't know if anyone is doing that or if we care about such cases but
> I just want to throw the concern out there.
>
> Hmm, that looks like we need some per-device parameter in order to set th=
is feature on for them.
>
> I guess we need a opinion from migration maintainer about such cases

