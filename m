Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CEDCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 08:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1KTV-0006Wl-7E; Wed, 24 Sep 2025 04:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1v1KTR-0006WS-Sp
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 04:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1v1KTK-0001Mv-43
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 04:03:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758701006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RotCsrQviWftklgMgnqUgrWigNBq5r/Ro6w0m1kJCzU=;
 b=B0uuJBSkh9JzPWHCQ7YW3+a0m5Wjm8C/Qx2jZ8vCeniO8qg9HGrBvAtqEq+5nS6NTLX/zJ
 J6cMGM3xhgLjRsqb4cArudEO8fjUhvSIWdRDTJLpblzfOBZgonlO9rEDxjdJE2LBRVjYAo
 Y792Xy6fVybp/tYiOLvDDg5jiawdhYc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-h4TjFgENMRa3Pms0qgiezA-1; Wed, 24 Sep 2025 04:03:24 -0400
X-MC-Unique: h4TjFgENMRa3Pms0qgiezA-1
X-Mimecast-MFC-AGG-ID: h4TjFgENMRa3Pms0qgiezA_1758701004
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-afe6216085aso575944266b.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 01:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758701003; x=1759305803;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RotCsrQviWftklgMgnqUgrWigNBq5r/Ro6w0m1kJCzU=;
 b=TLHmEpbA21/KgwJa+6RphkIRiFeK1A8E3y9nQQ12/nvtjylHE2OfXDaO11/pzTpWmD
 oCAFuS5Uhi4BwjunrXJA73LzZ39C6vGbNHZ42Nzhud+qXT62Go4pZ+3D3Z3pTLQqKhZ3
 /AYOOenXw5T7ooYHAenbgTK6TWaeeGKj2bg+GDPViT0hgih9BK9knaCl41VhmPd8a5EA
 3hsNhPnsrpCuO1MUEzjbySPpYZa3UP6zMEvAgemA1fH15RhIPZDi03HcL0IvzQBOgTcv
 7Af1VcrWIgr7ApXgPDrGjfIPFWy3Rk3Bdp3JIlfxQxpGBfoYhjONw4/5QtAXwDbL6enZ
 vIog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKZvvjDhTBh/aMGSsQ5ybVMj4mWIDxICjDh0y1xUjcdJeyQylAkr7JsgK6P8Z7mYFjLsPyCKqCWAfT@nongnu.org
X-Gm-Message-State: AOJu0YymfLQzMPcg7uDXdoEFONy/ENDQU3zcKQCZQadYLIaCWXiremf9
 0c4xAv8Aj6TGa0GakTU/jpaAKAk3FB9dGxg0vP8aJ/FgKv2+qqKGuUx0b3A6HWtThdw93NYnr+g
 eVlQ3SncamRL6HoV5lF8gFGJUVyj82P+XpFrD7Jd87yS9Se9kS9Bo5CNGuzFlDBCOcir7H46gGZ
 3S3CTlI4ez0ZU4UaKUqnRbJuQqKXwmAgM=
X-Gm-Gg: ASbGncscU7pxTchhJEohHtGgCv0M5tkJVyuUzU3c9A/Gs+NFPjJBuMLFypqjxI4/XcU
 MjBjt7XbCTj7VdiTrNozmmEhk9KwlPWB0Mc3+62DMyRYoFe2KgSn7K4svQI4zdJyEjeCGVb2T52
 b0swVnJaEBwKCPO7SRirnclQ==
X-Received: by 2002:a05:6402:324c:b0:628:6fc1:a3f with SMTP id
 4fb4d7f45d1cf-634677ed583mr3743349a12.17.1758701003394; 
 Wed, 24 Sep 2025 01:03:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFcd/mS5b2d8LIco92U1Y8ejgfaO6oVM0Igz68JgwsFffBpu+a4krIEFWocmBUsmhkNFr9JxMvuUHJUbLew5Q=
X-Received: by 2002:a05:6402:324c:b0:628:6fc1:a3f with SMTP id
 4fb4d7f45d1cf-634677ed583mr3743318a12.17.1758701002911; Wed, 24 Sep 2025
 01:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250923100110.70862-1-vsementsov@yandex-team.ru>
In-Reply-To: <20250923100110.70862-1-vsementsov@yandex-team.ru>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 24 Sep 2025 16:02:46 +0800
X-Gm-Features: AS18NWCHgPEn5f62bkcp8qWCVy0MUs0Fz0JXnoVk-P_Xypj2mtnV2uYZGpkCgpY
Message-ID: <CAPpAL=yb6dFi84YenopmjB3+o5pYFqvMEeAuL3O3RfesHi5B1g@mail.gmail.com>
Subject: Re: [PATCH v6 00/19] virtio-net: live-TAP local migration
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, qemu-devel@nongnu.org, philmd@linaro.org, thuth@redhat.com,
 eblake@redhat.com, michael.roth@amd.com, armbru@redhat.com, farosas@suse.de, 
 peterx@redhat.com, berrange@redhat.com, jasowang@redhat.com, 
 steven.sistare@oracle.com, davydov-max@yandex-team.ru, yc-core@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Sep 23, 2025 at 6:01=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Hi all!
>
> Here is a new migration parameter backend-transfer, which allows to
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
> v6:
> - rebase on master (to solve conflict with merged
>   "io: deal with blocking/non-blocking fds")
> - use name "backend-transfer" for the whole feature consistently
>   though the whole series. (live-backend is good, but actually,
>   we are already in "live-migration", so every its feature may
>   have "live-" prefix, and it seems redundant)
>
> 03-04: new, making changes in 05 correct
> 08-09: split "net/tap: rework tap_set_sndbuf()" into two commits
> 15: fix windows compilation
> 16: move has_ =3D true, to _params_init
> 18: use shorter name
>
> and some other cosmetic changes.
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
>   migration: add MIG_EVENT_PRE_INCOMING
>   net/tap: postpone tap setup to pre-incoming
>   qapi: add interface for backend-transfer virtio-net/tap migration
>   virtio-net: support backend-transfer migration for virtio-net/tap
>   tests/functional: add skipWithoutSudo() decorator
>   tests/functional: add test_x86_64_tap_migration
>
>  hw/net/virtio-net.c                           | 138 +++++-
>  include/migration/misc.h                      |   1 +
>  include/net/tap.h                             |   5 +
>  include/qapi/util.h                           |  17 +
>  migration/migration.c                         |   8 +-
>  migration/options.c                           |  27 +
>  migration/options.h                           |   2 +
>  net/tap-bsd.c                                 |   3 +-
>  net/tap-linux.c                               |  19 +-
>  net/tap-solaris.c                             |   3 +-
>  net/tap-stub.c                                |   3 +-
>  net/tap-win32.c                               |   5 +
>  net/tap.c                                     | 467 ++++++++++++++----
>  net/tap_int.h                                 |   4 +-
>  qapi/migration.json                           |  47 +-
>  tests/functional/qemu_test/decorators.py      |  16 +
>  tests/functional/test_x86_64_tap_migration.py | 344 +++++++++++++
>  17 files changed, 974 insertions(+), 135 deletions(-)
>  create mode 100644 tests/functional/test_x86_64_tap_migration.py
>
> --
> 2.48.1
>


