Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00605C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 19:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfN1h-0001UI-NA; Thu, 02 Jul 2026 15:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wfN1f-0001To-Az
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 15:24:43 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wfN1d-00024d-96
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 15:24:43 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-698a9f11776so2153639a12.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 12:24:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783020279; cv=none;
 d=google.com; s=arc-20260327;
 b=R+hqepdVvW31T8BdDCdWgaoMD5vV/RluNGHTz/iaiWIfI1MlKGzIKs/j3yRv602JLD
 G5/+hN0mt57RG3uXjtMz/VFN85Tz8X9BDAyUUWiymr5jpHDzgi1991fIaFPztc46OdJA
 oHA8/DwSTFc+wEqb+L9H7KtTJXygSM944QkTMGN/xVgUtyOPhOz5hFTgbr8kDxTiqWxn
 Z4t8BoRJ1hzlrfbIbqPQ1iYlz772EeuiJCyi1d2dfs1F45CF08HmtLqZexCaF6Jy7/0o
 VRsCgKxZSZw2bd9Duiwb2IvqLtFeKAWI5ZWDE8aVsVpP5DqnAJx+NjMMctWxKdVmUVVh
 QHYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=e3i6c5Fc4+qfuf/O64qSTfKG/F1RVPvZIloaoST6yTo=;
 fh=KoUrN/c6g34uaEOK7VoRZhhZ5ulmQ0Kem+6dZeePcbs=;
 b=JMS8Gv2peGflcNYHvGaNtM1HteNB3MMPEFh2EF7iqOm675LpIEyqa7iDCZi5x+2kQo
 STuPquLDAeuDM5kb239EWw0UzdrQuzf1Y0QLr8FQhaMi3jpZIrjJY9LZ5S775Fmv7PHn
 MvIDCCVWkKUinAIcWrFxcceEERIcNLjB+pLBptgrL/wzrNvzTNk39EnG0Nn7qxwb8NNv
 4mnRjBdnFajsgj3EU1aNLbPNx2JXzSk8oM5Q+DN2nb5r+NdWohEU5kmMnRwAvx2IjWMB
 ktCfB2usG3coG+3AUK+HOR3DFuMtP5zirho0WadoCPZD8pjTkmMSv9swVzk1rHPjAAuN
 bYww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783020279; x=1783625079; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e3i6c5Fc4+qfuf/O64qSTfKG/F1RVPvZIloaoST6yTo=;
 b=SkNs8MlgLqQLQuDo7KtDgm5OEXIeDsDIIhomo8ZxNJq2vB/u66DZLFmpknaANLQxwK
 TWwD4CJEJXtXkgULtno1We/G2MZzVHIvkSHJStYoCv+7B5s9hWicTDz1dZfB/wjmFKba
 ym5sgf1RUiO0bNG2olC4TtTecDN8SmPKdIwy/QuWbx/zfU9nNYZvlX7zWxo6NeQWXZ77
 WPNNo1aEJcruIozvTsAfYT1AopoWw9LUkfW518+jF8DD/mlK3CYqmuSIDV4WRKemld6i
 WMpJGOjMAxwAajpX/ZmrE4GFhlOlH6oPOfnez5N+n6bE59xOZn8XuhCtotbmqu/ikliu
 8HWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783020279; x=1783625079;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e3i6c5Fc4+qfuf/O64qSTfKG/F1RVPvZIloaoST6yTo=;
 b=TqwrG70Qtib67xrTFxPPDkJ7TTGUHydh6LgbO+shFtTKaPOWyYP9LL7uN1NKGJ5jec
 CjNjGxTo1SwAjmWQYDSnLZBpMc/zUaNbq3ZmShitUiYJM7ZAWRY6rTfAhl+TF/sUdeOc
 RRdTcGkFcnBHpCSxQVgPY8fD5V3+n+3vpkJy+dxWZg9x0wzFeG8z2GjG+AMB1NPv20RW
 oOcv/M3kquJq8j2uG3ALHaNReRTw7BJYQxh7ogFJLi92Qq5Zv9giMscZvhu5UWWV6C0K
 WYsAPnq2fX4uY+Pj9cO5dPb/ZWny6SuQJnYEnJrXk7DiShOiyP+wicOcMaX0qZsK0Hr1
 oVww==
X-Gm-Message-State: AOJu0YxYATfsHSmorAp9UiTBOpamzOEmLI0AShBI9z6Y0njyFtj9GEdu
 b/AXFrqjpC/UIAI6pQaoCXgKNgsFkwSc+lCA+y1d1eiYWlsV4ZdyCaIpDTi/kj4ws6G1dfASPt/
 MhdkKhUIi1JA/P+nyaK5wBkiOG3PQv44=
X-Gm-Gg: AfdE7cn6vUv59qeliWZWZfP0tshW92qyZGNDROG+o49rTjkhmMTCemv/QkD2UAeVKS2
 6OApj2qMU8AXLdc8Om0ihI00xIw6QNaXzKa/rN3TlyjNYyx87Ka5NIhVYyqASRmevX49RnPagSH
 WR1N2q2va/qwao7SQdFJii5BmLzjk6933jA1/Tekj1DCXsIo4TAlZtjy6Dw271YdaBEqOnJ/oCr
 Pef2ZBGVPngD1A9vfZBcwcBi8+rnx/inGHl0s3NQY0m+AJnekTipMgYQAgwWxWmTy7fRe0i9wbt
 1/bhpqUwVpiAUgZTWcz50mTLt/ftjHeR/lG95OjnLrqJsiALKzYy2H8xdw==
X-Received: by 2002:a05:6402:6cb:b0:698:5f47:1d3e with SMTP id
 4fb4d7f45d1cf-698a2c7fc95mr2122044a12.18.1783020278975; Thu, 02 Jul 2026
 12:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260630043107.1511076-1-clg@redhat.com>
In-Reply-To: <20260630043107.1511076-1-clg@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 2 Jul 2026 21:24:25 +0200
X-Gm-Features: AVVi8Cd-00X2lw5Whir9-hcBU9P8k1mCL8uyKFEDb6BlS3CTSVI0-xmY2lAkHIc
Message-ID: <CAJSP0QX-8L2CSX5q95Md5V6NTE_4p+K8Kr-QGbqKm2BBMtdh5Q@mail.gmail.com>
Subject: Re: [PULL 00/23] vfio queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jun 30, 2026 at 6:33=E2=80=AFAM C=C3=A9dric Le Goater <clg@redhat.c=
om> wrote:
>
> The following changes since commit 30e8a06b64aa58a3990ba39cb5d09531e7d265=
e0:
>
>   Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into s=
taging (2026-06-29 17:41:42 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/legoater/qemu/ tags/pull-vfio-20260630
>
> for you to fetch changes up to afe79bb7bf7fe16f418d6e10522946e13da04384:
>
>   vfio/listener: Fix translated_addr for non-identity-mapped RAM sections=
 (2026-06-30 05:35:56 +0200)

Hi Cedric,
This pull request breaks the migration test in the
ubuntu-24.04-s390x-all-system CI job:
https://gitlab.com/qemu-project/qemu/-/jobs/15157007316#L3078

>>> RUST_BACKTRACE=3D1 PYTHON=3D/home/gitlab-runner/builds/P3MFS4LUf/0/qemu=
-project/qemu/build/pyvenv/bin/python3 QTEST_QEMU_IMG=3D./qemu-img MESON_TE=
ST_ITERATION=3D1 UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print=
_summary=3D1:print_stacktrace=3D1 QTEST_QEMU_VNC_BINARY=3D./tools/qemu-vnc/=
qemu-vnc MALLOC_PERTURB_=3D226 MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_er=
ror=3D1:print_summary=3D1:print_stacktrace=3D1 G_TEST_DBUS_DAEMON=3D/home/g=
itlab-runner/builds/P3MFS4LUf/0/qemu-project/qemu/tests/dbus-daemon.sh QTES=
T_QEMU_BINARY=3D./qemu-system-s390x ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_=
on_error=3D1:print_summary=3D1 QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage=
-daemon/qemu-storage-daemon /home/gitlab-runner/builds/P3MFS4LUf/0/qemu-pro=
ject/qemu/build/tests/qtest/migration-test --tap -k --full
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80 =E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
stderr:
Memory content inconsistency at 48b7000 first_byte =3D b5 last_byte =3D b4
current =3D b5 hit_edge =3D 1
Memory content inconsistency at 48b8000 first_byte =3D b5 last_byte =3D b4
current =3D b5 hit_edge =3D 1
Memory content inconsistency at 48b9000 first_byte =3D b5 last_byte =3D b4
current =3D b5 hit_edge =3D 1
Memory content inconsistency at 48ba000 first_byte =3D b5 last_byte =3D b4
current =3D b5 hit_edge =3D 1
Memory content inconsistency at 48bb000 first_byte =3D b5 last_byte =3D b4
current =3D b5 hit_edge =3D 1
Memory content inconsistency at 48bc000 first_byte =3D b5 last_byte =3D b4
current =3D b5 hit_edge =3D 1
Memory content inconsistency at 48bd000 first_byte =3D b5 last_byte =3D b4
current =3D b5 hit_edge =3D 1
Memory content inconsistency at 48be000 first_byte =3D b5 last_byte =3D b4
current =3D b5 hit_edge =3D 1
Memory content inconsistency at 48bf000 first_byte =3D b5 last_byte =3D b4
current =3D b5 hit_edge =3D 1
Memory content inconsistency at 48c0000 first_byte =3D b5 last_byte =3D b4
current =3D b5 hit_edge =3D 1
and in another 6975 pages**
ERROR:../tests/qtest/migration/framework.c:190:check_guests_ram:
assertion failed: (bad =3D=3D 0)
(test program exited with status code -6)

Please take a look and resend the pull request with a fix.

Thanks,
Stefan

>
> ----------------------------------------------------------------
> vfio queue:
>
> * Fixes ROM read issues in vfio/pci: information leak, error
>   propagation, and uninitialized state
> * Validates VERSION replies in vfio-user and updates the spec
>   for DMA access mode bits
> * Merges .dma_map_file() into .dma_map() in the iommufd backend
> * Reworks switchover-ack to be re-usable and implements the
>   VFIO_PRECOPY_INFO_REINIT feature for additional pre-copy
>   iterations before switchover
> * Adds ATS support for passthrough devices via iommufd
> * Fixes translated_addr for non-identity-mapped RAM sections in
>   the VFIO listener
>
> ----------------------------------------------------------------
> Avihai Horon (14):
>       migration: Propagate errors in migration_completion_precopy()
>       migration/ram: Use migration_bitmap_sync_precopy() for postcopy dis=
card
>       migration: Run final save_query_pending at switchover
>       migration: Log the approver in qemu_loadvm_approve_switchover()
>       migration: Replace switchover_ack_needed SaveVMHandler
>       migration: Rename switchover-ack code to legacy
>       migration: Make switchover-ack re-usable
>       migration: Fail migration if switchover-ack is requested after swit=
chover decision
>       vfio/migration: Extract VFIO_MIG_FLAG_DEV_INIT_DATA_SENT sending to=
 helper
>       vfio/migration: Add Error ** parameter to vfio_migration_init()
>       vfio/migration: Add new switchover-ack mechanism
>       vfio/migration: Implement VFIO_PRECOPY_INFO_REINIT feature
>       vfio/migration: Check VFIO_PRECOPY_INFO_REINIT during switchover
>       migration: Enable new switchover-ack
>
> C=C3=A9dric Le Goater (3):
>       vfio/pci: Fix information leak in vfio_rom_read()
>       vfio/iommufd: Merge .dma_map_file() into .dma_map()
>       vfio/listener: Fix translated_addr for non-identity-mapped RAM sect=
ions
>
> GuoHan Zhao (1):
>       vfio-user: validate VERSION replies
>
> Mario Casquero (2):
>       vfio/pci: Initialize rom_read_failed in vfio_pci_load_rom()
>       vfio/pci: Propagate errors in vfio_pci_load_rom() using Error API
>
> Mattias Nissler (1):
>       docs: Update vfio-user spec to describe DMA access mode bits
>
> Nathan Chen (2):
>       iommufd: Introduce handler for device ATS support
>       vfio/pci: Add ats property
>
>  docs/devel/migration/vfio.rst      |  17 +++-
>  docs/interop/vfio-user.rst         |  82 +++++++++------
>  qapi/migration.json                |  14 ++-
>  hw/vfio/pci.h                      |   1 +
>  hw/vfio/vfio-migration-internal.h  |   2 +
>  include/hw/vfio/vfio-container.h   |  15 ---
>  include/migration/client-options.h |   1 +
>  include/migration/misc.h           |   2 +
>  include/migration/register.h       |  56 +++++-----
>  include/system/host_iommu_device.h |   9 ++
>  migration/migration.h              |  34 ++++++-
>  migration/savevm.h                 |   9 +-
>  backends/iommufd.c                 |   8 ++
>  hw/core/machine.c                  |   1 +
>  hw/s390x/s390-stattrib.c           |   2 +-
>  hw/vfio-user/proxy.c               |  21 ++--
>  hw/vfio/container.c                |  38 -------
>  hw/vfio/iommufd.c                  |  50 ++++++---
>  hw/vfio/listener.c                 |   5 +-
>  hw/vfio/migration.c                | 204 +++++++++++++++++++++++++++++--=
------
>  hw/vfio/pci.c                      | 129 +++++++++++++++++++----
>  migration/block-dirty-bitmap.c     |  11 +-
>  migration/migration.c              |  73 ++++++++++---
>  migration/options.c                |   9 ++
>  migration/ram.c                    |  40 ++++----
>  migration/savevm.c                 | 173 +++++++++++++++++++++----------
>  hw/vfio/trace-events               |   7 +-
>  migration/trace-events             |   9 +-
>  28 files changed, 709 insertions(+), 313 deletions(-)
>
>

