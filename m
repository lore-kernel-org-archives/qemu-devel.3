Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B27CA1015
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 14:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuB4W-0003Iz-DZ; Thu, 04 Sep 2025 10:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uuB4S-0003FY-AO
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 10:36:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uuB4G-0007h1-JR
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 10:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756996560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=moUisWZWUUBf6YwwL0HMsWPgBN9IM6SMgClxgAoZCss=;
 b=hQhUXC9gl06UpzqZr0jyZuo1xiRyntN5IOk39vqQcw5GKcoKHhDnIukuOgpt3Sir3yjlVL
 s/LAUus5wb/YGT4S9vv5WuNHVHkY6Yh5Avu6y2kejSv3f0r73Er8RcuB/EURFLIRR1CPJN
 OjcKAfQZgGFYzZ1XL8AOoN/+bMZRnUk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-W7p2jIldMR6piI89PkAVQA-1; Thu, 04 Sep 2025 10:35:58 -0400
X-MC-Unique: W7p2jIldMR6piI89PkAVQA-1
X-Mimecast-MFC-AGG-ID: W7p2jIldMR6piI89PkAVQA_1756996558
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-61d2ab4bb96so1157305a12.1
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 07:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756996558; x=1757601358;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=moUisWZWUUBf6YwwL0HMsWPgBN9IM6SMgClxgAoZCss=;
 b=gBche/KQhRbXpKRXLAuEPP7S0pdsUe4MQYcirBFNdRmYNKRULtvxS7OIhkrvMCJ5e2
 Hq7a3GSf+HpgjxKW669A+7jWOzH0VEpQBd+KebC9ip26xHyxgqMvCGDHDr1VcsyQOJpG
 Yu0A3dk6WjZDm9YP6jQxxCRUlVdeGcbwihaSxyOaeDVkYybdjjaxwLaa2q9+UDmrwgY/
 cPxUZgOA+fAypHgGUY7aKCyZ1aE4yef4zEEytoo8j8tgI8GBikarck0wYo3ohXdFoskU
 5imRfRUUkzfY5I2gT9mQVShcUkIFNSlA+dM7BQaqXKhGe/Y5EpEszBstrzBIR+KtnGvJ
 GWkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgW92vidzzJ/EJJHMgYQc53hxNQF0fawsLVBZWCXg+1LAsQ/4Q7P+uSL8TYD5mj2S+4+X8rkL+LdAu@nongnu.org
X-Gm-Message-State: AOJu0YzvxxrylT5U64iK7ZdTaPrQDdK96DdMKEtVdK45J8OXK0snKUh7
 v/dzEfeKYQwS+E7fSuMCfXRLTJ9r8yOuQLiFyGHPViRo2eLERdVm7U2vFDeXCfX/AJx6u/Ux1ef
 NIqZ9WvGEA9hefr2z+gk5X9K0waRS46VDnZVg9gJzaxg/SySnzCQOHjvLTUVoYO3RTc0KPgLBqc
 pdgWaTflcZcqz3BLEnIu2tRuoYmJXH7a8=
X-Gm-Gg: ASbGncsbYPcUoUwvIz+IYfRxDRC567ImJe1g9zXDb+1IFX+cCiWcDZGaj2YyFGv6nL5
 94uMNceeQ+b8OIpKTA08KkQjrO+xptJnjD+kRz0dUh6CL6gMorGKNq8NKtC/qdpwTIl6Zro9eeI
 vjPE6Aea4RqQPiesvy5eSvFQ==
X-Received: by 2002:a05:6402:2714:b0:61d:feb:67fb with SMTP id
 4fb4d7f45d1cf-61d26d9c672mr15229048a12.34.1756996557674; 
 Thu, 04 Sep 2025 07:35:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6pv32c2YnCpF2P9MA2XEB9wA9IVo0SSt9lFl+O++4Vy0ykRu7b24484ztC+Qqxx3hJyERI7gkLPWLcLy7Duk=
X-Received: by 2002:a05:6402:2714:b0:61d:feb:67fb with SMTP id
 4fb4d7f45d1cf-61d26d9c672mr15229024a12.34.1756996557201; Thu, 04 Sep 2025
 07:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
In-Reply-To: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 4 Sep 2025 22:35:20 +0800
X-Gm-Features: Ac12FXxYPcT-vMylpmxGOdo6K3OwVB1Xq61jLbRhPB9Pj-r6FLP_yb-xbH_mFxA
Message-ID: <CAPpAL=wG_LptUhVGDSnwfkCizKk8t55Z3EKFqeTOcNYgM5EjhA@mail.gmail.com>
Subject: Re: [PATCH 00/10] io: deal with blocking/non-blocking fds
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 peterx@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Tested the current series of patches, mixed with patches from series
[1] and [2], and the virtio-net regression tests passed. I also tested
local VM migration under multiple NIC queues enabled and disabled, it
also passed.

[1] https://patchwork.ozlabs.org/project/qemu-devel/cover/20250903124934.11=
69899-1-vsementsov@yandex-team.ru/
[2] https://patchwork.ozlabs.org/project/qemu-devel/cover/20250903133706.11=
77633-1-vsementsov@yandex-team.ru/

Tested-by: Lei Yang <leiyang@redhat.com>

On Wed, Sep 3, 2025 at 5:46=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Hi all!
>
> The series brings two things:
>
> 1. unify code which sets fds blocking/non-blocking through the whole
> source
>
> 2. for fds, which comes from qio_channel_readv_full(), stop making
> them blocking in generic code, and move this logic to the callers,
> all except coming from migration qemu-file (see last patch)
>
> Vladimir Sementsov-Ogievskiy (10):
>   io/channel: document how qio_channel_readv_full() handles fds
>   char-socket: rework tcp_chr_recv()
>   util: add qemu_set_blocking() function
>   util: drop qemu_socket_set_nonblock()
>   util: drop qemu_socket_try_set_nonblock()
>   util: drop qemu_socket_set_block()
>   use qemu_set_blocking instead of g_unix_set_fd_nonblocking
>   oslib-posix: add qemu_fds_set_blocking() helper
>   qio_channel_readv_full(): move setting fd blocking to callers
>   migration/qemu-file: don't make incoming fds blocking again
>
>  chardev/char-fd.c                       |  4 +--
>  chardev/char-pty.c                      |  3 +-
>  chardev/char-serial.c                   |  3 +-
>  chardev/char-socket.c                   | 45 ++++++++++++-------------
>  chardev/char-stdio.c                    |  3 +-
>  contrib/ivshmem-server/ivshmem-server.c |  5 ++-
>  hw/hyperv/syndbg.c                      |  4 ++-
>  hw/input/virtio-input-host.c            |  3 +-
>  hw/misc/ivshmem-flat.c                  |  4 ++-
>  hw/misc/ivshmem-pci.c                   |  8 ++++-
>  hw/remote/mpqemu-link.c                 |  3 ++
>  hw/vfio-user/proxy.c                    |  4 +++
>  hw/virtio/vhost-user.c                  | 10 +++++-
>  hw/virtio/vhost-vsock.c                 |  8 ++---
>  include/io/channel.h                    | 12 +++++++
>  include/qemu/osdep.h                    |  8 +++++
>  include/qemu/sockets.h                  |  3 --
>  io/channel-command.c                    |  9 +++--
>  io/channel-file.c                       |  3 +-
>  io/channel-socket.c                     | 26 +++++++-------
>  net/dgram.c                             | 28 ++++++++-------
>  net/l2tpv3.c                            |  5 +--
>  net/socket.c                            | 27 ++++++++++-----
>  net/stream.c                            |  9 ++---
>  net/stream_data.c                       | 10 +++---
>  net/tap-bsd.c                           | 12 +++++--
>  net/tap-linux.c                         |  8 ++++-
>  net/tap-solaris.c                       |  7 +++-
>  net/tap.c                               | 21 ++++--------
>  qga/channel-posix.c                     |  7 +++-
>  qga/commands-posix.c                    |  3 +-
>  scsi/qemu-pr-helper.c                   |  4 +++
>  tests/qtest/fuzz/virtio_net_fuzz.c      |  2 +-
>  tests/qtest/tpm-emu.c                   |  1 +
>  tests/qtest/vhost-user-test.c           |  3 +-
>  tests/unit/socket-helpers.c             |  5 ++-
>  tests/unit/test-crypto-tlssession.c     |  8 ++---
>  tests/unit/test-io-channel-socket.c     |  1 +
>  tests/unit/test-iov.c                   |  5 +--
>  ui/input-linux.c                        |  3 +-
>  util/event_notifier-posix.c             |  5 +--
>  util/main-loop.c                        |  6 +++-
>  util/oslib-posix.c                      | 27 +++++++++------
>  util/oslib-win32.c                      | 25 ++++++--------
>  util/vhost-user-server.c                |  9 +++--
>  45 files changed, 244 insertions(+), 165 deletions(-)
>
> --
> 2.48.1
>
>


