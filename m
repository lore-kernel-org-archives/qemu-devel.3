Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1032CA1002
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 14:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuB73-0006OO-AP; Thu, 04 Sep 2025 10:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uuB6z-0006H0-Ic
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 10:38:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uuB6q-0000hS-U9
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 10:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756996713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VMo4xE6hWWWNBmr/ZvpjR2KNC034GlAUtLNDz6XtR7Y=;
 b=Ts3GwkBh5N7ZFXIhriEgkEJxzW22469bImWMTBFZCUfLjAZTp5FJL/q9ewxcLBRx/ltI8n
 ziTF7CXH9O40ilbncTahIt7yTg4d9VSz3Swa+bzH0iGUN25VIOryWWnJCEV3EuohMuKYI5
 4Fp6F35NoH7xLQmLWWOmx9CQMMv/vKY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-JBSKTua_Nby_oIyNwYnT_A-1; Thu, 04 Sep 2025 10:38:32 -0400
X-MC-Unique: JBSKTua_Nby_oIyNwYnT_A-1
X-Mimecast-MFC-AGG-ID: JBSKTua_Nby_oIyNwYnT_A_1756996711
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-61cd0c61472so1014536a12.3
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 07:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756996711; x=1757601511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VMo4xE6hWWWNBmr/ZvpjR2KNC034GlAUtLNDz6XtR7Y=;
 b=XCy2mhWcl1hvA92eY2uXSDCyYdmRu05z4F34nHVzgTa71oXDPHpgswJLtKzZ/OGMRw
 CEVsGxwLl9lEzTfgw53TpbI2zz5hOxlqGHOe/QWFRASTX4icMBQLJucPpkDGNfoq75SQ
 rlTyaP4Rn/z0IQW84KG4uKSYuMoAq7ABrb7PbtIFQ2pTHjRsp+qgC795aOPpDQ1RM5Ko
 flgX5LHXWZ4v87tQs4QXdxyScXKIZQe+gGXs7D5phW9k0TeJqMX9OBklKJdVEf4G9EkI
 BiyfnbQGL/CeoDbLgUD20S/G9hMh4x7rDQAgcGjM4pLc+E1huGLILW3TCoAzpYRwwmuQ
 zjTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwurdn3xBBLP2qaODTSo32O3Tra5Xxs+nc8rED2rrDXav6XB+9NL/OWcaNO5Q2D6h/MaJ2nttKDGdV@nongnu.org
X-Gm-Message-State: AOJu0YyPpv/qpPk3EOFZ40MxThQeMRSnmW57wctdzlyMq59JlMd6M8Iw
 rmRdl6mhqVd9Mt1Mf0G5zfE4CvMZv11V2PZMIRQsEnxftZxRZ9ilzPgyLBJ+5m5JnkHyzL81hFQ
 ek/Xm40vbwC+b1IHv/IhZ03t4kzYcSnJ7CbWewpla/EM85jO1H6qjPQNRTOZL6P8VdTYUwycNwM
 GeG2ey8AmQJOskgEkl0o0f7ARTXt3L0Bs=
X-Gm-Gg: ASbGncujNxBqeNZPrK81edVjFWKCgqf5zptj1KV9X5f0F+tkfb1jZAGRYv5cSyw9cse
 4uDc3uO6C6VpzOFTZj7vSIKNsY4O2mrG8RjyboCke++TahrQO8ZkJuT1I0uGxcI8QgjPZdzrw1k
 Gkq2h7Fg8VpH6LpbHc4+zChQ==
X-Received: by 2002:a05:6402:1e90:b0:61e:c5d4:1435 with SMTP id
 4fb4d7f45d1cf-61ec5d41547mr9006408a12.19.1756996710766; 
 Thu, 04 Sep 2025 07:38:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAbiwwqaX2QjXtnvNZ2n6P+14TM6gmEnzxxHBudtyci0l3Mv3DGH1VAb7LeBwJcFJsYaw0d/LuJ5+WjII1qpk=
X-Received: by 2002:a05:6402:1e90:b0:61e:c5d4:1435 with SMTP id
 4fb4d7f45d1cf-61ec5d41547mr9006378a12.19.1756996710322; Thu, 04 Sep 2025
 07:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250903124934.1169899-1-vsementsov@yandex-team.ru>
In-Reply-To: <20250903124934.1169899-1-vsementsov@yandex-team.ru>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 4 Sep 2025 22:37:52 +0800
X-Gm-Features: Ac12FXy_ubbNO86pIu7J8pU8tGZqpn84vg44x9kglOfaYYdze_rBpRZZZ9g5xy8
Message-ID: <CAPpAL=zt7VQWE=H4YKSsy0HZGb4bx5dqe0m-3V_Z-h_4dZLFUQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] TAP initialization refactoring
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, steven.sistare@oracle.com, 
 yc-core@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Tested the current series of patches, mixed with patches from series
[1] and [2], and the virtio-net regression tests passed. I also tested
local VM migration under multiple NIC queues enabled and disabled, it
also passed.

[1] https://patchwork.ozlabs.org/project/qemu-devel/cover/20250903094411.10=
29449-1-vsementsov@yandex-team.ru/
[2] https://patchwork.ozlabs.org/project/qemu-devel/cover/20250903133706.11=
77633-1-vsementsov@yandex-team.ru/

Tested-by: Lei Yang <leiyang@redhat.com>

On Wed, Sep 3, 2025 at 8:49=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Hi all!
>
> Here is a refactoring of initialization code, to improve its
> readability and get rid of duplication.
>
> v3:
> - rebase on top of [PATCH 00/10] io: deal with blocking/non-blocking fds
> - improve some commit messages
> - add t-b marks by Lei Yang (hope, they still counts after rebasing :)
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
> Vladimir Sementsov-Ogievskiy (19):
>   net/tap: net_init_tap_one(): add return value
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
>  net/tap.c       | 553 ++++++++++++++++++++++--------------------------
>  net/tap_int.h   |   2 +-
>  3 files changed, 263 insertions(+), 297 deletions(-)
>
> --
> 2.48.1
>


