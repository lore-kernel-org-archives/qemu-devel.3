Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F88E60A3802
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eHvItXeV;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=okyacly+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ6PX-0003Wn-CT; Tue, 20 Oct 2026 05:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1xJ6PU-0003QG-FX
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 05:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1xJ6PS-0007vO-4R
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 05:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792489527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=veWA9VkXhn+l/tzbS5PKI899AhcaBYfdbmMJqIztGtQ=;
 b=eHvItXeV0iCDr3PX4GbPcSmzD63KiBklBd66w7D7Q/phB3wf+6b2T/HYRiSBwjOUsB3huv
 fC5Gt5IoTwXHU2cZtJ4rUe+JLLCZEtGzuLXSftKxaI2dubCTPsHZiNWfisN0cpQ4opaH89
 3zQPuBTX+Zp3J2u12neslEf6QRv+Z5k=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-MrSr6dQ9M3uyR3FBMwEUrw-1; Tue, 20 Oct 2026 09:45:26 +0000
X-MC-Unique: MrSr6dQ9M3uyR3FBMwEUrw-1
X-Mimecast-MFC-AGG-ID: MrSr6dQ9M3uyR3FBMwEUrw_1792489525
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-8b09ee23de2so40192147b3.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 02:45:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792489525; cv=none;
 d=google.com; s=arc-20260327;
 b=LGHJ7ijO0crH0VlWfXB7NHkwpA7edllosn5hrZbob7woNbT2+htQfLq8HJv3jfXxFu
 +NTEGaqNMFdN4cZmXfcCzQqnQPnWKSggqSdBga3HSjEgb1DFQmnwl6ykQxXjhV5JtKVI
 7+2d5iZ3FcaWMprrV+g7Nx2NZGnnaHY4agJNiPxv/WildviWUWRkNdYJ0KGtPaARBTci
 Zx0d6c1dDSU4OZXpDRIFSv1K3YG0LvXTTYEbmM1HMLd6IycPZmSKqOmZDjDVKDqNixbT
 5zg6ufUfvNNyGTcpfoUY2g+KWfElnXr+1uHFFXAjxsGYkcWclJbqWS+QzUB1+V+lupu/
 ZG4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=veWA9VkXhn+l/tzbS5PKI899AhcaBYfdbmMJqIztGtQ=;
 fh=jY72J5Hg4aX43KASIe6sczDfUvq/oWwpe8SFXWkP4nc=;
 b=Y7HnEw/xgiwuEe6z92bneg2wq7jVHy7z0meZhc7GbNntQZk7oiKndSsw/OYwk6oWBJ
 48C4AVtqezE/RfsNDWsgGxWO+WiMoK6rEKID+0ZjP0kiyeLj+eZ0CkjJBXMXZ7jhVVNW
 VBXIbuRrfDd0wkvLbbsGdsyDsqul2BIhhvAvaErDsWJ3gUsf+CYWTDkwqv65NicGQZu1
 gC7huKFrEQOaR4feCMZ9UmAsQdluMwAczj4wUHEhr03QPko70/u6Q7CElfj1nkiQpZEI
 TBjGyY04J4gXN9ke9Zp3kvTo0goY+bSy1enQXQW7j2iWoK1gIkmYVoAT2G/VSdrK5y7e
 h+Rg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792489525; x=1793094325; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=veWA9VkXhn+l/tzbS5PKI899AhcaBYfdbmMJqIztGtQ=;
 b=okyacly+B7JYo9ujVip018oQ9XbXak+YHDEPG1oKgTotCKwsuiLl/cCRzKcj9Vu+Wq
 Ve+xOXN0nEsk4e+liqUjoqQGRDZTg1rL42pV6hPvdRB4lU/TMzbGd0CWs42qp4reIxEZ
 eNtCa754NQdVDBaJ52dLEtmtlfJTGtb8CdZLf2LCRMdBFsKzEFE56QkHrPQFF45nA1mu
 SyXw7vosDWXQJjC11lSpMmPy9b+xKS4LINfviuJhlwzYaw6bcjkdRmdhdjfI21ZqE3Tu
 hGXwK46zW//nCBGg8ApEd0a9IdVAi22CXZV8HmK1NIk3XKMT6dcSS7NuMIWsVRZxv/QS
 QayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792489525; x=1793094325;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=veWA9VkXhn+l/tzbS5PKI899AhcaBYfdbmMJqIztGtQ=;
 b=SYI9W2o0OEiGfMgQU4KoeW4CR3O+fZof4aYi2K/mPEdmaZhPIN56qU1892GRrXLLP1
 IoXT3pn5hdQkc9tvksB34oZQVCeVwoyJCSIe+6jy6DVtMwomR6qz0qeyWi9LcBadAq9Z
 1UuDLe4TP1CTVY3kl68jO238j0krfY87sXUkgfvSQhIAQMcnNbvzqsElu8zFFQ7f75Jr
 wJiEsLaZcqMhUMqLEBoA6KUsH2HgJNlYqQ825lehn1vWZILKExuX6McRhHtj1XZl3VDI
 mPYW3mdpm+0WsYNVbE893xMBRF/dUwkK22mPXQ15pcYI93paYNyMLDvfBP9ZcSUltc3A
 FLIQ==
X-Gm-Message-State: AFq9FYLK3WND1fDVOCzepmWMY6K+fUCGnEihGS8Hs5URYby+Qjqj2lmJ
 lcPvm6xbPQZc2m0CDDCNXCHUQz7t01kYkVIsxnem2qyJd4kodUPC6kIZilyz3h8zkkXCNXvmnnw
 dJqUNJoBunVkIZFc0srLLT+5Ij7kLu3cX9AEs+MLrDVu3KI0JCGxlW4qqr+q1iy/otxPYqWHbKl
 SQSwL+KQlH/ZOUwAYL75kCZLIWX7fwpSw=
X-Gm-Gg: AYBFou1T7vtRhO5nYskUXFm07SfcMziRxL9ku6eRR7JGEWDf5PzsN7CIqcSi/aYmwA9
 vMfxvcsIDFZc/XVVXvbXTPNPiRDWqX0uoS1w9nLqnIkX1ZyyZYLHemAPnLCeE0bprjLoDzZ5nBk
 ILFGQ4HN+xLE43MT9hVeUVnwsq1A6WELrr0OjY6M1StWbNAFDPTDgPc7pLGKZSpmJ4NIzABVhur
 r1+vT4pLEuyggMpXxw5IfnVgTb4qk/eNNBY3ccXiFQ54Wb0kjYhyhrWmv8=
X-Received: by 2002:a05:690c:a610:b0:8b0:a28d:6444 with SMTP id
 00721157ae682-8b0f21b0445mr23395087b3.20.1792489525333; 
 Tue, 20 Oct 2026 02:45:25 -0700 (PDT)
X-Received: by 2002:a05:690c:a610:b0:8b0:a28d:6444 with SMTP id
 00721157ae682-8b0f21b0445mr23395017b3.20.1792489524865; Tue, 20 Oct 2026
 02:45:24 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260816043451.2547-1-narimansayed28@gmail.com>
 <20261007050718.926-1-narimansayed28@gmail.com>
In-Reply-To: <20261007050718.926-1-narimansayed28@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 20 Oct 2026 11:44:47 +0200
X-Gm-Features: AclHuK_duW66xKwM6qU1stBP3ZICTl2UuUvL0d9LoR_LU_7Pjfbe1qWpELfouDM
Message-ID: <CAJaqyWeWrFSw3ZBwgz3oKz41Ziz+uJfJxYuWTa2K_QMwCpChLw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] net/tap,
 virtio-net: auto-detect MTU from host tap device
To: Nariman Sayed <narimansayed28@gmail.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowangio@gmail.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 7, 2026 at 10:55=E2=80=AFAM Nariman Sayed <narimansayed28@gmail=
.com> wrote:
>
> This series adds automatic detection of the host tap device's MTU
> and exposes it to the guest via VIRTIO_NET_F_MTU, addressing
> gitlab.com/qemu-project/qemu/-/issues/3155.
>
> Currently, host_mtu=3D must be set manually on the virtio-net-pci
> device, duplicating the MTU already configured on the host's tap
> interface. This series adds a new mtu-from-tap boolean property
> (default off) that, when enabled, automatically reads the backend's
> MTU and uses it for the guest, avoiding the need to specify the
> value twice.
>
> v2:
>  - Addressed feedback from Eugenio Perez Martin: rather than
>    checking for NET_CLIENT_DRIVER_TAP and calling tap_get_mtu()
>    directly, added a generic get_mtu callback to NetClientInfo and
>    a qemu_get_mtu() wrapper, following the existing qemu_has_ufo()
>    pattern. virtio-net.c now calls qemu_get_mtu() without any
>    backend-type check, so other backends (e.g. vhost-user,
>    vhost-vdpa) can implement get_mtu in the future without
>    requiring any change to virtio-net.c. (patch 2 is new as a
>    result; patch 3 updated accordingly)
>
> The series is split into three patches:
>  - patch 1 adds a helper to query a tap fd's host MTU (Linux only,
>    with build-safe stubs for BSD/Solaris/stub backends)
>  - patch 2 adds a generic get_mtu NetClientInfo callback and wires
>    it up for the tap backend
>  - patch 3 adds the new virtio-net property and wires it up,
>    including a note on a config-space sizing timing issue
>    discovered during testing
>
> Tested manually with a tap device configured for MTU 9000 and an
> Alpine Linux guest, confirming the guest correctly negotiates
> VIRTIO_NET_F_MTU and reports the expected MTU. Also tested by
> Aniket Sahu on ppc64le/POWER10 with a SLES guest.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Nariman Sayed (3):
>   net/tap: add tap_fd_get_mtu() to query host tap MTU
>   net: add generic get_mtu NetClientInfo callback
>   virtio-net: add mtu-from-tap property for automatic MTU detection
>
>  hw/net/virtio-net.c            | 10 ++++++++++
>  include/hw/virtio/virtio-net.h |  1 +
>  include/net/net.h              |  3 +++
>  net/net.c                      |  9 +++++++++
>  net/tap-bsd.c                  |  5 +++++
>  net/tap-linux.c                | 30 ++++++++++++++++++++++++++++++
>  net/tap-solaris.c              |  5 +++++
>  net/tap-stub.c                 |  5 +++++
>  net/tap.c                      |  8 ++++++++
>  net/tap_int.h                  |  1 +
>  10 files changed, 77 insertions(+)
>
> --
> 2.34.1
>
>


