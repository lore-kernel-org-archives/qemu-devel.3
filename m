Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC90C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 17:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seHkM-00023x-Lj; Wed, 14 Aug 2024 13:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1seHkI-000209-Ge
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 13:25:14 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1seHkF-0000tV-T0
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 13:25:14 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52ef95ec938so78508e87.3
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 10:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723656310; x=1724261110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WRv4/bvXg/uUcweJFTCmSDA+F14BHqZU/asbmDBehjk=;
 b=KRL/5tJ2njIDUX+5WOlEVUQ2reBp3uRvzFUlTgWOcnDC4uYT0s3Q9J2pr9c7eYdRJK
 giXTRPh9kgmPOyYExEBlxfL6JIeO6h3Fw//TIUWk+uvkAjBlbfidQhd4LNkNXsq4l8ei
 PgpYUA7a4Lu9icLV7A+hMMuuzdH0VIj2a/zro70SeVaUgbPGX+yv1EM4yx/wds6GklYb
 L/9hNY6guphxHU5NCaOuteFVeldCx97YCo8vSGf5F8KvWO2Z0X0hIwi9R9NwqluJ8/v5
 HU1LQPoCehAtn5MXj6kABUiPwjVAn185pUx+hTv2nnwFBsrGf69Nh0TFMCOgYRoJiwOc
 fdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723656310; x=1724261110;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WRv4/bvXg/uUcweJFTCmSDA+F14BHqZU/asbmDBehjk=;
 b=EhGd4AIcYAYrrZLZMEmBxmY/yZJk/5dE9HNdtKDYWSmp4JNGm6zU4MwQbgi4i7Rzp3
 9x5SZjlsY7WgaxVzT+lxF/iE9/vtPKG4FCea9HYzI9ZuQayRbxt41Ey6URuQbeKiyi8M
 Jor2r+TE/ryydUj/JcKs0LwJLzqMHoj1XTRYDRE2s85VwDJs++y0m5rJS6W3veSYi21Z
 a7YLzVm7m37J0MXOip8k0hD9QCeBpH2MVJrUkBuNK2cOQMD2YyGDadY8j0xmyM9xhl9t
 P4OXz3qPNXkGaS8BpIbZC9e5qHgMkhFl9i0CBs6PDXBUhkHpty/GQQHKxXnhN51XlPzA
 5r2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSOfM/braMelLyAeayTXHspJk/jbCfdxuWkXFr+9THlLD/6MbM11HKv7LuC4dwxkhbjbLrWVBdDhb0549f1Nid9CNv2w8=
X-Gm-Message-State: AOJu0YyE+1ku2EYt3M0sV1FsCoaHZQnHWa3uiMd7EgvuJKVdp+M2/zWC
 H5XEeKqqn4qvx9cHBkNJMN46WK62YZdz0P+dZ9LKamekWi9zgq8798Gup4lrKOM=
X-Google-Smtp-Source: AGHT+IEj0mmiVvN9fu1I35Csl4RBPtplgh+zN7Gs31yEqFJ+oem08PSs/R/kS+7CSPtEjInXYmR4Lg==
X-Received: by 2002:a05:6512:23a1:b0:52e:7ef1:7c6e with SMTP id
 2adb3069b0e04-532edbb4973mr2489142e87.51.1723656308868; 
 Wed, 14 Aug 2024 10:25:08 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f3fb155asm194746566b.81.2024.08.14.10.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 10:25:08 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 186F95F713;
 Wed, 14 Aug 2024 18:25:07 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,  qemu-devel@nongnu.org,  Alistair
 Francis <alistair.francis@wdc.com>,  Michael Roth <michael.roth@amd.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,  Weiwei Li
 <liwei1518@gmail.com>,  Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>,  David Hildenbrand <david@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>,  Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,  Eric
 Auger <eric.auger@redhat.com>,  Song Gao <gaosong@loongson.cn>,
 qemu-arm@nongnu.org,  Peter Xu <peterx@redhat.com>,  Jiri Pirko
 <jiri@resnulli.us>,  Eric Blake <eblake@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  qemu-s390x@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  John Snow <jsnow@redhat.com>,  Alexandre
 Iooss <erdnaxe@crans.org>,  Konstantin Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Cleber Rosa
 <crosa@redhat.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-riscv@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>,  Bin Meng <bmeng.cn@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Wainer dos
 Santos Moschetta
 <wainersm@redhat.com>,  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: Re: [PATCH v2 16/21] virtio-net: Use replay_schedule_bh_event for
 bhs that affect machine state
In-Reply-To: <20240814030308-mutt-send-email-mst@kernel.org> (Michael S.
 Tsirkin's message of "Wed, 14 Aug 2024 03:06:54 -0400")
References: <20240813202329.1237572-1-alex.bennee@linaro.org>
 <20240813202329.1237572-17-alex.bennee@linaro.org>
 <20240813164631-mutt-send-email-mst@kernel.org>
 <D3FEPPLH78YW.3BYA9B4HYGN1U@gmail.com>
 <20240814030308-mutt-send-email-mst@kernel.org>
Date: Wed, 14 Aug 2024 18:25:07 +0100
Message-ID: <87y14z81ak.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Wed, Aug 14, 2024 at 04:05:34PM +1000, Nicholas Piggin wrote:
>> On Wed Aug 14, 2024 at 6:48 AM AEST, Michael S. Tsirkin wrote:
>> > On Tue, Aug 13, 2024 at 09:23:24PM +0100, Alex Benn=C3=A9e wrote:
>> > > From: Nicholas Piggin <npiggin@gmail.com>
>> > >=20
>> > > The regular qemu_bh_schedule() calls result in non-deterministic
>> > > execution of the bh in record-replay mode, which causes replay failu=
re.
>> > >=20
>> > > Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> > > Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
>> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> > > Message-Id: <20240813050638.446172-9-npiggin@gmail.com>
>> > > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> > > ---
>> > >  hw/net/virtio-net.c | 11 ++++++-----
>> > >  1 file changed, 6 insertions(+), 5 deletions(-)
>> > >=20
>> > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> > > index 08aa0b65e3..10ebaae5e2 100644
>> > > --- a/hw/net/virtio-net.c
>> > > +++ b/hw/net/virtio-net.c
>> > > @@ -40,6 +40,7 @@
>> > >  #include "migration/misc.h"
>> > >  #include "standard-headers/linux/ethtool.h"
>> > >  #include "sysemu/sysemu.h"
>> > > +#include "sysemu/replay.h"
>> > >  #include "trace.h"
>> > >  #include "monitor/qdev.h"
>> > >  #include "monitor/monitor.h"
>> > > @@ -417,7 +418,7 @@ static void virtio_net_set_status(struct VirtIOD=
evice *vdev, uint8_t status)
>> > >                  timer_mod(q->tx_timer,
>> > >                                 qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL=
) + n->tx_timeout);
>> > >              } else {
>> > > -                qemu_bh_schedule(q->tx_bh);
>> > > +                replay_bh_schedule_event(q->tx_bh);
>> > >              }
>> > >          } else {
>> > >              if (q->tx_timer) {
>> > > @@ -2672,7 +2673,7 @@ static void virtio_net_tx_complete(NetClientSt=
ate *nc, ssize_t len)
>> > >           */
>> > >          virtio_queue_set_notification(q->tx_vq, 0);
>> > >          if (q->tx_bh) {
>> > > -            qemu_bh_schedule(q->tx_bh);
>> > > +            replay_bh_schedule_event(q->tx_bh);
>> > >          } else {
>> > >              timer_mod(q->tx_timer,
>> > >                        qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx=
_timeout);
>> > > @@ -2838,7 +2839,7 @@ static void virtio_net_handle_tx_bh(VirtIODevi=
ce *vdev, VirtQueue *vq)
>> > >          return;
>> > >      }
>> > >      virtio_queue_set_notification(vq, 0);
>> > > -    qemu_bh_schedule(q->tx_bh);
>> > > +    replay_bh_schedule_event(q->tx_bh);
>> > >  }
>> > >=20=20
>> > >  static void virtio_net_tx_timer(void *opaque)
>> > > @@ -2921,7 +2922,7 @@ static void virtio_net_tx_bh(void *opaque)
>> > >      /* If we flush a full burst of packets, assume there are
>> > >       * more coming and immediately reschedule */
>> > >      if (ret >=3D n->tx_burst) {
>> > > -        qemu_bh_schedule(q->tx_bh);
>> > > +        replay_bh_schedule_event(q->tx_bh);
>> > >          q->tx_waiting =3D 1;
>> > >          return;
>> > >      }
>> > > @@ -2935,7 +2936,7 @@ static void virtio_net_tx_bh(void *opaque)
>> > >          return;
>> > >      } else if (ret > 0) {
>> > >          virtio_queue_set_notification(q->tx_vq, 0);
>> > > -        qemu_bh_schedule(q->tx_bh);
>> > > +        replay_bh_schedule_event(q->tx_bh);
>> > >          q->tx_waiting =3D 1;
>> > >      }
>> > >  }
>> > > --=20
>> > > 2.39.2
>> >
>> >
>> > Is this really the only way to fix this? I do not think
>> > virtio has any business knowing about replay.
>> > What does this API do, even? BH but not broken with replay?
>> > Do we ever want replay broken? Why not fix qemu_bh_schedule?
>> > And when we add another feature which we do not want to break
>> > will we do foo_bar_replay_bh_schedule_event or what?
>>=20
>> I agree with you. We need to do this (a couple of other hw
>> subsystems already do and likely some are still broken vs
>> replay and would need to be converted), but I think it's
>> mostly a case of bad naming. You're right the caller should
>> not know about replay at all, what it should be is whether
>> the event is for the target machine or the host harness,
>> same as timers are VIRTUAL / HOST.
>> So I think we just need to make a qemu_bh_schedule_<type>,
>> or qemu_bh_scheudle_event(... QEMU_EVENT_VIRTUAL/HOST/etc).
>
> Or just pass QEMUClockType?

Is this wider re-factoring something that can wait for the next
developer cycle?

>> I had started on a conversion once but not completed it.
>> I could resurrect if there is agreement on the API?

I would certainly welcome it being cleaned up. The supported replay
devices are very piecemeal at the moment.

>>=20
>> Thanks,
>> Nick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

