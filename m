Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD0DCA0EED
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 03:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqNrP-0005Wr-E9; Sun, 24 Aug 2025 23:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uqNrN-0005WY-CC
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 23:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uqNrL-0002tZ-Kd
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 23:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756092420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5cpW1j2rjv8lqaW3e/P2kluvb4Yx2zx5rIEhsVDme8A=;
 b=iYqfKzvqwJMrSfxF2v9+lzvVrAkS8YvU+ejApiPNwqFQZGESyFxMKrvsi2R8yPc2xbAcCn
 CyvAtlt4sh4+ERIrlkMGNAP4hv99WFj98GuXAk5qCOeNio1mDxoSiTB0ObiA2aOr3Ze469
 6cVlrfroZCf76rDHVVBUyhkczEqx0CM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-oR2tm3-bP-qYKEP5RO9THg-1; Sun, 24 Aug 2025 23:26:58 -0400
X-MC-Unique: oR2tm3-bP-qYKEP5RO9THg-1
X-Mimecast-MFC-AGG-ID: oR2tm3-bP-qYKEP5RO9THg_1756092417
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-61c37f38c7eso1802526a12.2
 for <qemu-devel@nongnu.org>; Sun, 24 Aug 2025 20:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756092417; x=1756697217;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5cpW1j2rjv8lqaW3e/P2kluvb4Yx2zx5rIEhsVDme8A=;
 b=Sgai02lNyNkFiKrgQkZf60Mz5zlllYnZhg21Xzr3C/StL/jzeT+GHwiSeB0ijGLD4O
 vXDi1vmE4HyPml1ZrZtZ5UXCrp2IkK76OfyGyW9OzrCiVMqFfUrhHzxBb2FSXEEuFWNm
 imYMC0b1pgjDTgMasLNhG2fzhUSO7P7BjxuScT9gTR1tfM+AnXFNO5r+hj2EB/ZbQac6
 cZF3nASqIm6MQiEEWeYBbwX5Sir8l9MG9bSOelwCjPd/AA6nx0rtZciEEeEuKo5mz2gr
 V9aY7Z0H1F4LAcoehPDsleFzpJH+m1GbHkWZ1NK2Mq6csDGrXiZkoM2uiRW42QXoUnl/
 MccA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwkKYKXXc1+CDR+Dso+CKy3+CJTdx7E0o8x2rX63SPNmTDgF6/BRmHy9Ai6lVY/kfUgLmmHPKbkUMq@nongnu.org
X-Gm-Message-State: AOJu0YwfnaSGQc+gCZvLJjE1Zily+/QndC2/maSlwWpstiEZMZDPUddD
 JAhRoiWUw4Ca1zIXzaMwqiE3Ui/kGdmCvaYlZ7MrWC3qDrB8BGPKIlSq3dcrehOgl6SQ6gdZ4EQ
 9g6bYdsfJxKNSoK+HQlpSiEcUfj72k8mJ5c0NXfmxU3LpQjm7V/gm1oTBIcnvNJ/56mzS6jF/eW
 k2ll0O+z0ZhBZQMiOOz7jNiY/+0qrVQCU=
X-Gm-Gg: ASbGncuB6N0wpteUkMEDcWUDP+6KCng7o2OgJyv51N+KUAschWAxPypcv0g0+kQdy+a
 +4lNhOEhJDYBwRXG8fOv9wR5sMqU8uziFaCYNdBAhzy7JFnH3+U5ST4fZxGGXHV5m8FrFx8+Omw
 4bIU/g4Tb3Jc8tPjxAny7QBg==
X-Received: by 2002:a05:6402:26ce:b0:615:aec5:b5bc with SMTP id
 4fb4d7f45d1cf-61c1b289a10mr8462468a12.0.1756092417236; 
 Sun, 24 Aug 2025 20:26:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEjCvK4cuGqR6Y/3xlKWidi/oZxZ3tu+ajpr1tqX9/fI8e/zput8f0DSq4uC8iXZ++VAXF6dySa7InjB+sk5k=
X-Received: by 2002:a05:6402:26ce:b0:615:aec5:b5bc with SMTP id
 4fb4d7f45d1cf-61c1b289a10mr8462466a12.0.1756092416834; Sun, 24 Aug 2025
 20:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250823160323.20811-1-vsementsov@yandex-team.ru>
In-Reply-To: <20250823160323.20811-1-vsementsov@yandex-team.ru>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 25 Aug 2025 11:26:20 +0800
X-Gm-Features: Ac12FXzQPRjX3Ftcq0dX00rOsXClAlmj-fQt3tjm2Sksg5R8vHIimkmaCaSAjKI
Message-ID: <CAPpAL=zM-SG62X8OUv4szDGKgHVnXdhs18fhz5zOnfmG0mv2SQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] TAP initialization refactoring
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Tested this series of patches with virtio-net regression
tests,everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Sun, Aug 24, 2025 at 12:03=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Hi all!
>
> Here is a refactoring of initialization code, to improve its
> readability and get rid of duplication.
>
> v2:
> 01,03: improve commit msg
> 14: fix return value for new net_tap_init_one()
> 15: add return statements to other cases, to not break them
> 20: new
>
> Below are the initialization flow diagrams showing the changes.
>
> BEFORE REFACTORING:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> ```
> net_init_tap()
>     |
>     +-- if (tap->fd)
>     |   +-- duplicated logic*
>     |   +-- net_init_tap_one()
>     |
>     +-- else if (tap->fds)
>     |   +-- for each fd:
>     |       +-- duplicated logic*
>     |       +-- net_init_tap_one()
>     |
>     +-- else if (tap->helper)
>     |   +-- duplicated logic*
>     |   +-- net_init_bridge()
>     |
>     +-- else (normal case)
>         +-- for each queue:
>             +-- net_tap_init()
>             +-- net_init_tap_one()
>
> net_init_bridge()
>     |
>     +-- duplicated logic*
>     +-- net_tap_fd_init()
>
> net_init_tap_one()
>     |
>     +-- net_tap_fd_init()
>
> net_tap_init()
>     |
>     +-- tap_open()
>
> net_tap_fd_init()
>     |
>     +-- qemu_new_net_client()
>     +-- Initialize TAPState
>
> * duplicated logic: set fd nonblocking + probe vnet_hdr
> ```
>
> AFTER REFACTORING:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> ```
> net_init_tap()
>     |
>     +-- if (tap->fd)
>     |   +-- net_tap_from_monitor_fd()
>     |
>     +-- else if (tap->fds)
>     |   +-- for each fd:
>     |       +-- net_tap_from_monitor_fd()
>     |
>     +-- else if (tap->helper)
>     |   +-- net_init_bridge()
>     |
>     +-- else (normal case)
>         +-- net_tap_open()
>
> net_tap_open()
>     |
>     +-- for each queue:
>         +-- net_tap_open_one()
>
> net_tap_open_one()
>     |
>     +-- tap_open()
>     +-- net_tap_fd_init_common()
>
> net_tap_from_monitor_fd()
>     |
>     +-- net_tap_fd_init_external()
>
> net_tap_fd_init_external()
>     |
>     +-- net_tap_fd_init_common()
>
> net_init_bridge()
>     |
>     +-- net_tap_fd_init_external()
>
> net_tap_fd_init_common()
>     |
>     +-- qemu_new_net_client()
>     +-- Initialize TAPState
> ```
>
> Solved problems:
>
> - duplicated logic to handle external
>   file descriptors (set nonblocking, probe vnet_hdr)
>
> - duplication between tap/helper case in
>   net_init_tap() and net_init_bridge()
>
> - confusing naming and functionality spread between functions (we had
>   net_init_tap(), together with net_tap_init(); also main central
>   function was net_init_tap_one(), and part of its logic (not clear
>   why) moved to separate net_tap_fd_init()),
>
> - net_init_tap() was just too big
>
> Vladimir Sementsov-Ogievskiy (20):
>   net/tap: net_init_tap_one(): add return value
>   net/tap: add set_fd_nonblocking() helper
>   net/tap: tap_set_sndbuf(): add return value
>   net/tap: net_init_tap_one(): drop extra error propagation
>   net/tap: net_init_tap_one(): move parameter checking earlier
>   net/tap: net_init_tap(): refactor parameter checking
>   net/tap: net_init_tap(): drop extra variable vhostfdname
>   net/tap: move local variables related to the latter case to else
>     branch
>   net/tap: use glib strings vector and g_strsplit for fds case
>   net/tap: drop extra tap_fd_get_ifname() call
>   net/tap: net_init_tap_one(): refactor to use netdev as first arg
>   net/tap: net_init_tap_one(): support bridge
>   net/tap: net_init_bridge(): support tap
>   net/tap: refactor net_tap_init() into net_tap_open_one()
>   net/tap: introduce net_tap_open()
>   net/tap: introduce net_tap_fd_init_external()
>   net/tap: introduce net_tap_from_monitor_fd() helper
>   net/tap: split net_tap_setup_vhost() separate function
>   net/tap: drop net_tap_fd_init()
>   net/tap: introduce net_init_tap_fds()
>
>  net/tap-linux.c |   5 +-
>  net/tap.c       | 578 +++++++++++++++++++++++-------------------------
>  net/tap_int.h   |   2 +-
>  3 files changed, 277 insertions(+), 308 deletions(-)
>
> --
> 2.48.1
>


