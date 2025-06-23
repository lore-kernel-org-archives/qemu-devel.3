Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB60C7115D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 08:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTc9M-0003gr-9e; Mon, 23 Jun 2025 04:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uTc9G-0003g1-Lj
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 04:03:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uTc9B-0005Q4-PH
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 04:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750665799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u/PmyucJp9P7popspE2Lo2P5zRnH2DSKng9ScHWksjY=;
 b=Mh2fqKRLzrNa+zl7eeo1eeAebhFjPJrIfC7gaNwMZ6WjcyKZHZ7qBouLJamYuGnGbqM1G0
 Zb4Xzv4mqwwfaPvJSLW2gwO+EdVTo39Xvx8TlsN+N6wNFLr/MfIZLNfc3wLjdDLNwlqw1Q
 bpREGTqfeKwY8tri7Wab/WAOVSfT4ng=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-atP_GTwdOaqupnCOc1xl9w-1; Mon, 23 Jun 2025 04:03:18 -0400
X-MC-Unique: atP_GTwdOaqupnCOc1xl9w-1
X-Mimecast-MFC-AGG-ID: atP_GTwdOaqupnCOc1xl9w_1750665797
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3138f5e8ff5so3801192a91.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 01:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750665797; x=1751270597;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u/PmyucJp9P7popspE2Lo2P5zRnH2DSKng9ScHWksjY=;
 b=jWPV5lm7SRQjr79SWGSezmw4c8vnJCXyT4Wl2jfH47UgeeEiIgqlCwE29Br0ZXVlUq
 Myv6bTiuR6DJBXeLHl9eL/0nwLab8+VPZE2AxLxl4QmM2JPaQuv2lyfYGrHycHoq33hK
 abCG/V/lzk0bQOEEfuuZ0umIDzDl2+M4zkNOFlb5+vDk1hb18s+tqov8WuiG2/EJiUTh
 6F+sdk3vc8Zw94o49nyXP5YBLWcNeu2vl+WmqCHwxmtupdN9MZyTku7f7iMfbr+6EizV
 /zJUKl8vsQn/L3sBmZkkUqVlNXEZZXIYG6Ou5MVlmfV9pP40yIm/F3yFJkYEBAUQZ9Zb
 VQNA==
X-Gm-Message-State: AOJu0Yw2CqVXuQE+Qs6WPLpnjAAQ7SKJUS6lpdJeD7Q5JNfFWxA5vdBh
 pfkf8CYANZYEddICLk+eW027kW3DDD/7TPpA0zFYkkJCrqtpabO3w3YLm7QtrUgyulsw9kkgWBX
 Xoaaa3EZLCBnyuVkYS3yuD6EK9P6CBdGYsBOuZeoCqxVNuYQzMjiJi7ts3HcDs+N0aOObF+whjc
 msplAUNnbl2UMRQodN7huFXFhiRKC8U/I=
X-Gm-Gg: ASbGncuJp+pXpqdNsDIjQq87FFhDarp2jnJQuMNoSjLZw2CeQNU2R7YCZ4WvL+KL6a+
 t3QXGvdXUr2dd0OaQR5Ug/f1L8KIYfB1P37l5ROozXOjqdXDG41TTqP+xOKMjgScAyCQGWFtRv1
 FlxxIj
X-Received: by 2002:a17:90b:2ec3:b0:312:1cd7:b337 with SMTP id
 98e67ed59e1d1-3159d62c276mr16629341a91.5.1750665796876; 
 Mon, 23 Jun 2025 01:03:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEII34uYBJds0rbuA8ZmjiqSdmNeMox+r6j88d0Fm+iJGzdeJEfEh9I/3+MU4YytcJlm+lrEO/5NAqE8/nQGT4=
X-Received: by 2002:a17:90b:2ec3:b0:312:1cd7:b337 with SMTP id
 98e67ed59e1d1-3159d62c276mr16629288a91.5.1750665796465; Mon, 23 Jun 2025
 01:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250618083930.451313-1-lvivier@redhat.com>
In-Reply-To: <20250618083930.451313-1-lvivier@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 23 Jun 2025 16:03:05 +0800
X-Gm-Features: AX0GCFtuw5OliS_ULi8jTN7wNavOOVNV4Fx45hynJz11IN8MARpXubgqHOTo7Wg
Message-ID: <CACGkMEv1r+-MUpoPZ2Va-b-dkjB2prHYhtZEtUB7-s1CZCBFdA@mail.gmail.com>
Subject: Re: [PATCH 0/8] net: Add passt netdev backend
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Wed, Jun 18, 2025 at 4:39=E2=80=AFPM Laurent Vivier <lvivier@redhat.com>=
 wrote:
>
> This series introduces support for passt as a new network backend for
> QEMU.
>
> passt is a modern, unprivileged, user-mode networking solution that
> provides guest connectivity by launching an external helper process. This
> series adds the core backend and integrates it with vhost-user for
> high-performance, accelerated networking.
>
> The series is structured to first improve the general networking code
> before adding the new feature. The first patch extracts from the stream
> backend the functions that will be reused in the passt backend. The
> following patches are a preparatory refactoring to decouple the generic
> vhost layer from specific backend implementations (tap, vhost-user, etc.)=
.
> This is achieved by replacing hardcoded type checks with a callback-based
> system in NetClientInfo, making the vhost infrastructure more modular and
> extensible.
>
> With the refactoring in place, subsequent patches introduce the passt
> backend itself, reusing the generic stream handling logic. The final
> patch adds vhost-user support to passt, which plugs cleanly into the
> newly refactored vhost layer.
>
> Some benchmarks:
>
>  Reference '-net user':
>
>   -net user,hostfwd=3Dtcp::10001-:10001
>
>     iperf3 -c localhost -p 10001  -t 60 -4
>
>     [ ID] Interval           Transfer     Bitrate         Retr
>     [  5]   0.00-60.00  sec  14.2 GBytes  2.03 Gbits/sec    1            =
sender
>     [  5]   0.00-60.00  sec  14.2 GBytes  2.03 Gbits/sec                 =
 receiver
>
>  New backend '-netdev passt'
>
>   -netdev passt,vhost-user=3Doff,tcp-ports=3D10001
>
>     iperf3 -c localhost -p 10001  -t 60 -4
>
>     [ ID] Interval           Transfer     Bitrate         Retr
>     [  5]   0.00-60.00  sec  27.1 GBytes  3.88 Gbits/sec    0            =
sender
>     [  5]   0.00-60.03  sec  27.1 GBytes  3.88 Gbits/sec                 =
 receiver
>
>   -netdev passt,vhost-user=3Don,tcp-ports=3D10001
>
>     iperf3 -c localhost -p 10001  -t 60 -4
>
>     [ ID] Interval           Transfer     Bitrate         Retr
>     [  5]   0.00-60.00  sec   224 GBytes  32.1 Gbits/sec    4            =
sender
>     [  5]   0.00-60.05  sec   224 GBytes  32.0 Gbits/sec                 =
 receiver

Do we have latency numbers of even PPS?

Thanks

>
> Thanks,
> Laurent
>
> Laurent Vivier (8):
>   net: Refactor stream logic for reuse in '-net passt'
>   net: Define net_client_set_link()
>   net: Introduce helper to identify vhost-user clients
>   net: Add get_vhost_net callback to NetClientInfo
>   net: Add get_acked_features callback to NetClientInfo
>   net: Add save_acked_features callback to NetClientInfo
>   net: Add passt network backend
>   net/passt: Implement vhost-user backend support
>
>  hmp-commands.hx          |   3 +
>  hw/net/vhost_net-stub.c  |   1 -
>  hw/net/vhost_net.c       |  89 ++---
>  hw/net/virtio-net.c      |  18 +-
>  include/net/net.h        |  12 +
>  include/net/tap.h        |   3 -
>  include/net/vhost-user.h |  19 --
>  include/net/vhost-vdpa.h |   2 -
>  meson.build              |   6 +
>  meson_options.txt        |   2 +
>  net/clients.h            |   4 +
>  net/hub.c                |   3 +
>  net/meson.build          |   6 +-
>  net/net.c                |  55 ++-
>  net/passt.c              | 718 +++++++++++++++++++++++++++++++++++++++
>  net/stream.c             | 282 ++++-----------
>  net/stream_data.c        | 193 +++++++++++
>  net/stream_data.h        |  31 ++
>  net/tap-win32.c          |   5 -
>  net/tap.c                |  20 +-
>  net/vhost-user-stub.c    |   1 -
>  net/vhost-user.c         |  22 +-
>  net/vhost-vdpa.c         |   4 +-
>  qapi/net.json            | 121 +++++++
>  qemu-options.hx          |  18 +
>  25 files changed, 1293 insertions(+), 345 deletions(-)
>  delete mode 100644 include/net/vhost-user.h
>  create mode 100644 net/passt.c
>  create mode 100644 net/stream_data.c
>  create mode 100644 net/stream_data.h
>
> --
> 2.49.0
>
>


