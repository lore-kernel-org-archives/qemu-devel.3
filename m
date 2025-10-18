Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC18CCD193
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 15:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA91R-000353-0I; Sat, 18 Oct 2025 11:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1vA91P-000332-SQ
 for qemu-devel@nongnu.org; Sat, 18 Oct 2025 11:39:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1vA91O-0000qY-85
 for qemu-devel@nongnu.org; Sat, 18 Oct 2025 11:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760801943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5xZVa2LKgl4StM0l75AReodh3pfW5wXYqCzeV2v0XxI=;
 b=SOXQamOGtYftaO419KOKh/OnZU1u15ZH0h/JYp+dloFwWDkmAvZXTQXAC6qE5j6uP05ic3
 Ia2O85NX+6AfBAMkDmoI1guqmEdp00U2qtRtg0qc2S5FKEqfQy8XNuOl+VSfDOnWjpPbsr
 ShGsWy5G/AVx3sPM40PfxTup7CEaU+E=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-4_jw6fyQOoGZONP1vjw7ww-1; Sat, 18 Oct 2025 11:39:01 -0400
X-MC-Unique: 4_jw6fyQOoGZONP1vjw7ww-1
X-Mimecast-MFC-AGG-ID: 4_jw6fyQOoGZONP1vjw7ww_1760801941
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-63c4f67cd9bso1429125a12.2
 for <qemu-devel@nongnu.org>; Sat, 18 Oct 2025 08:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760801941; x=1761406741;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5xZVa2LKgl4StM0l75AReodh3pfW5wXYqCzeV2v0XxI=;
 b=NVfLheSTZoR5vfSs9+Tqyp4naVKoZZYwZgzqaJhmj7S1qEyymJzFTjdtcvdBTWbbGy
 ZhcCddQQCR9PyKYhJiO4xW63VwDmS1Ahzq8DBKOmQnLyKYLwF9IDRseqcc1mFPVsLa+h
 g5xX8u9rdLPCXGl5a8TwXb/kVLAC5+IvOgtGbpJdV5C63QPD0PhNoSZ91fA/2aBZ99pa
 Uvx8hjdwYxl8ZVcduOiGTZ/9CFlkwTNw1VqwlSHrY+iMXGiaY0+SJOtqFPOXbGCk+dkm
 lpHo4VQQcQE6ayBr3sCtjUXJnP0a6pIfLkNBX9oq4Qmf0L9ixAQxCbPPKBybMt4uUCnT
 I5mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDCjwarFLz2lvDzpUnYPuP5cp+dZmRGBi8d7lC0q9diTD40l18ygu1gBDeTg58aXejJPQpQtnROFn8@nongnu.org
X-Gm-Message-State: AOJu0Yz2G5lR77c9QP9iN2JDHbBZ/GxcLJjFpt4Ngi746PLlgLqxUq9P
 dbLqYAqMaCJ6mnmIWyo+2lCinvZDs/MByAtAIQglNMY3ZGhOwuuvN+ZRSnomB33eI9Pg80ELS//
 ecJ0SVhgqXrU6332oRFJDprZuGVoucAcVwYCkUtORpnOUpfsxl63ihUzkSNAp67FyGcRy2yTU4q
 JVBNX2FpPAP2fh3i8NONTLaR8biLz5HwQ=
X-Gm-Gg: ASbGncuQIp+rAghv3uRyJUCrcuJjKmbAZbd8PmOgRhJ+Q/YKEzu/TGibyqORqjSkhD7
 6dUJCD887lILee2EYWMvMq6MJ2zTsJfaUMz0lEssV09H/THZIYIxvxRGJE/kgfsBrnWSz7+WUin
 YZBNA8SEq8l1oYDVuIBvxASpFyh+6PKLc/ExPQxVXguG1nGkTN6ehW+VzP
X-Received: by 2002:a05:6402:3492:b0:633:7017:fcc1 with SMTP id
 4fb4d7f45d1cf-63c1f6458b6mr6820288a12.14.1760801940706; 
 Sat, 18 Oct 2025 08:39:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf8wxQ/DPLrsARkcET/HJ1Rl4GTc4nVMC/dc7tggcd26zgtVatfRrJIDLS7uKOQkflmnDaky+XeaS+YiOSj+Q=
X-Received: by 2002:a05:6402:3492:b0:633:7017:fcc1 with SMTP id
 4fb4d7f45d1cf-63c1f6458b6mr6820262a12.14.1760801940287; Sat, 18 Oct 2025
 08:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
In-Reply-To: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
From: Lei Yang <leiyang@redhat.com>
Date: Sat, 18 Oct 2025 23:38:23 +0800
X-Gm-Features: AS18NWCAN2o1CP--z8UPc4aUZHY1-jPkkQN6q22p79IQ7VFvgwECG1_PytzUpMI
Message-ID: <CAPpAL=yxPBAMMN+peO4vs6JyP4pcamuJLoOj9aSO37HZUP61-w@mail.gmail.com>
Subject: Re: [PATCH v8 00/19] virtio-net: live-TAP local migration
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, farosas@suse.de, 
 sw@weilnetz.de, eblake@redhat.com, armbru@redhat.com, thuth@redhat.com, 
 philmd@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org, 
 michael.roth@amd.com, steven.sistare@oracle.com, davydov-max@yandex-team.ru, 
 yc-core@yandex-team.ru, raphael.s.norwitz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Wed, Oct 15, 2025 at 9:21=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Hi all!
>
> Here is a new migration parameter backend-transfer, which, being
> assisted by new device property backend-transfer, allows to
> enable local migration of TAP virtio-net backend, including its
> properties and open fds.
>
> With this new option, management software doesn't need to
> initialize new TAP and do a switch to it. Nothing should be
> done around virtio-net in local migration: it just migrates
> and continues to use same TAP device. So we avoid extra logic
> in management software, extra allocations in kernel (for new TAP),
> and corresponding extra delay in migration downtime.
>
> v8:
> 14: add a-b by Peter
> 16: rework to one boolean parameter
> 17: rework to use per-device property
> 19: update to use new API
>
> Vladimir Sementsov-Ogievskiy (19):
>   net/tap: net_init_tap_one(): drop extra error propagation
>   net/tap: net_init_tap_one(): move parameter checking earlier
>   net/tap: rework net_tap_init()
>   net/tap: pass NULL to net_init_tap_one() in cases when scripts are
>     NULL
>   net/tap: rework scripts handling
>   net/tap: setup exit notifier only when needed
>   net/tap: split net_tap_fd_init()
>   net/tap: tap_set_sndbuf(): add return value
>   net/tap: rework tap_set_sndbuf()
>   net/tap: rework sndbuf handling
>   net/tap: introduce net_tap_setup()
>   net/tap: move vhost fd initialization to net_tap_new()
>   net/tap: finalize net_tap_set_fd() logic
>   migration: introduce .pre_incoming() vmsd handler
>   net/tap: postpone tap setup to pre-incoming
>   qapi: introduce backend-transfer migration parameter
>   virtio-net: support backend-transfer migration for virtio-net/tap
>   tests/functional: add skipWithoutSudo() decorator
>   tests/functional: add test_x86_64_tap_migration
>
>  hw/core/machine.c                             |   1 +
>  hw/net/virtio-net.c                           | 151 ++++++-
>  include/hw/virtio/virtio-net.h                |   1 +
>  include/migration/vmstate.h                   |   1 +
>  include/net/tap.h                             |   5 +
>  migration/migration.c                         |   4 +
>  migration/options.c                           |  18 +
>  migration/options.h                           |   2 +
>  migration/savevm.c                            |  15 +
>  migration/savevm.h                            |   1 +
>  net/tap-bsd.c                                 |   3 +-
>  net/tap-linux.c                               |  19 +-
>  net/tap-solaris.c                             |   3 +-
>  net/tap-stub.c                                |   3 +-
>  net/tap-win32.c                               |  11 +
>  net/tap.c                                     | 425 +++++++++++++-----
>  net/tap_int.h                                 |   3 +-
>  qapi/migration.json                           |  38 +-
>  tests/functional/qemu_test/decorators.py      |  16 +
>  tests/functional/test_x86_64_tap_migration.py | 395 ++++++++++++++++
>  20 files changed, 984 insertions(+), 131 deletions(-)
>  create mode 100644 tests/functional/test_x86_64_tap_migration.py
>
> --
> 2.48.1
>


