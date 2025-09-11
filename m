Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47597CAC58D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 09:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwdX7-0007Z7-AR; Thu, 11 Sep 2025 05:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwdW6-0006nE-TE; Thu, 11 Sep 2025 05:23:02 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwdW0-0000SV-3s; Thu, 11 Sep 2025 05:22:57 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 8299580879;
 Thu, 11 Sep 2025 12:22:45 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b3c::1:2f] (unknown
 [2a02:6bf:8080:b3c::1:2f])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id iMHIvF0FfKo0-AzbJjcWI; Thu, 11 Sep 2025 12:22:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757582565;
 bh=bQnd+tqYiTVeLER5x/SqaYq1iSVZoZQBvhkLk8HddcE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=J6F7KQeGIw0lfvnYmrDhBj3kZFcw8Skx0dwPl9c4mGA+D39/v/60sN3pnqI6x3iHu
 axgd8xRz5dqD5VNfs7JZrzwfDP0pCLXNvoBXpeKDhun1p9OqC5+8NthRjlRmMYb/HP
 /AHqBH2CYBI9m8OgfobM1eI/oXEaXMNpFZE2D7To=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <bd5f5895-751e-420a-a132-cd3a4ed44b40@yandex-team.ru>
Date: Thu, 11 Sep 2025 12:22:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] io: deal with blocking/non-blocking fds
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 leiyang@redhat.com, marcandre.lureau@redhat.com
References: <20250911092007.1370002-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250911092007.1370002-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11.09.25 12:19, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> The series aims to unify code which sets fds blocking/non-blocking
> through the whole source.
> 
> 01: reworked, only drop the for-loop
> 02: new
> 03: - improve commit-message, add a lot of motivation REREAD
>      - convert GError to Error in a new function
> 04: - add notes about caller conversion in commit message REREAD

REREAD - was notes for myself :)

>      - add r-b by Peter
>      - save IVSHMEM_SERVER_DEBUG()
>      - finally decided to keep g_warning() for now: conversion
>        g_warning() -> g_printerr() should better be another series
>        and cover the whole code-base (actually not too much, and
>        mostly in qga)
> 05: add r-b by Peter
> 06: new
> 07: functional part moved to separate commit
> 08: - fix commit message
>      - drop redundant qemu/sockets.h includes
> 
> v2 is also based on
> [PATCH v4 0/2] save qemu-file incoming non-blocking fds
> Based-on: <20250910193112.1220763-1-vsementsov@yandex-team.ru>
> 
> Vladimir Sementsov-Ogievskiy (8):
>    char-socket: tcp_chr_recv(): drop extra _set_(block,cloexec)
>    char-socket: tcp_chr_recv(): add comment
>    util: add qemu_set_blocking() function
>    util: drop qemu_socket_set_nonblock()
>    util: drop qemu_socket_try_set_nonblock()
>    io/channel-socket: rework qio_channel_socket_copy_fds()
>    util: drop qemu_socket_set_block()
>    use qemu_set_blocking instead of g_unix_set_fd_nonblocking
> 
>   chardev/char-fd.c                       |  4 +-
>   chardev/char-pty.c                      |  3 +-
>   chardev/char-serial.c                   |  3 +-
>   chardev/char-socket.c                   | 21 ++-----
>   chardev/char-stdio.c                    |  3 +-
>   contrib/ivshmem-server/ivshmem-server.c |  6 +-
>   hw/hyperv/syndbg.c                      |  4 +-
>   hw/input/virtio-input-host.c            |  3 +-
>   hw/misc/ivshmem-flat.c                  |  3 +-
>   hw/misc/ivshmem-pci.c                   |  7 ++-
>   hw/virtio/vhost-user.c                  |  5 +-
>   hw/virtio/vhost-vsock.c                 |  8 +--
>   include/qemu/osdep.h                    |  1 +
>   include/qemu/sockets.h                  |  3 -
>   io/channel-command.c                    |  9 ++-
>   io/channel-file.c                       |  3 +-
>   io/channel-socket.c                     | 80 ++++++++++++++++++-------
>   net/dgram.c                             | 28 +++++----
>   net/l2tpv3.c                            |  5 +-
>   net/socket.c                            | 27 ++++++---
>   net/stream.c                            |  9 +--
>   net/stream_data.c                       | 10 ++--
>   net/tap-bsd.c                           | 12 +++-
>   net/tap-linux.c                         |  7 ++-
>   net/tap-solaris.c                       |  7 ++-
>   net/tap.c                               | 21 ++-----
>   qga/channel-posix.c                     |  7 ++-
>   qga/commands-posix.c                    |  3 +-
>   tests/qtest/fuzz/virtio_net_fuzz.c      |  2 +-
>   tests/qtest/vhost-user-test.c           |  3 +-
>   tests/unit/socket-helpers.c             |  5 +-
>   tests/unit/test-crypto-tlssession.c     |  8 +--
>   tests/unit/test-iov.c                   |  5 +-
>   ui/input-linux.c                        |  3 +-
>   util/event_notifier-posix.c             |  4 +-
>   util/main-loop.c                        |  5 +-
>   util/oslib-posix.c                      | 22 ++++---
>   util/oslib-win32.c                      | 25 ++++----
>   util/vhost-user-server.c                |  4 +-
>   39 files changed, 224 insertions(+), 164 deletions(-)
> 


-- 
Best regards,
Vladimir

