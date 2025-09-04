Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354E4CA1013
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 08:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu5Ke-00060R-Su; Thu, 04 Sep 2025 04:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1uu5Ka-0005y7-Ln
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:28:32 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1uu5KX-0002k5-BH
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:28:32 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-61d3d622a2bso2420694a12.0
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 01:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756974500; x=1757579300; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WhnWyfs8YQKivkjEPCJWjC00mHB5PyHjOo9mWUimrLs=;
 b=VBK78DgUIFsUvURzeQX28mhIlTPQqmg4w+BsU7zaxxoeVoh845Lx8oWBP/jl+2c1g1
 34YzuLngdrfJh9pH7duEiYMQxIqc1YFmifDYfKlkQV9RjtF5k4D1eV3aaDrvNMgHw5sR
 xkQkmKgBXT0iDWGbEN0JvRRmQeqwapAk4t7pnlLIRAtlYKm2v4zVydNw/oxVpArCBfBX
 xJT1hkJO+LPR3DJJ5MS2tu42SluPDDAQX/9MTm3CJCGdzw27DXyZoemXODfAHYwVbw3p
 /7hBK3g0EOSChdH4LPOu/XCyjdmPRFA3vVkxnivwFYD7LESkQK1Wxh1RKz/3v0pBN0nr
 5I5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756974500; x=1757579300;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WhnWyfs8YQKivkjEPCJWjC00mHB5PyHjOo9mWUimrLs=;
 b=e9iSvyBkpxDEqmaRAHiIztqqMvLEEO2rGxTmsHtAsUGYcjyTuuwZVZy+ecroQaYHDK
 uiXOCMmtNDvDJbXvKZ1x89t8PMEJAOljSkz/JdPgFTvy+oVYPKI4nUbVZhs1EWpkNTmG
 olILFJ5YzKNLbXnfV+afqOqFeBn/Xa3Eo51issHhh9W9+ou/8vOVW+rxsWVO3aOSbA3D
 rA+c0RN4htHAEwYubhuTuGvKVGwbB0XaAxqvhZk75aX3u1bAPPe1qqw13osqLZbleuJe
 N+maRfunvy4sk6JyG4IJQpZo8iA5jBcrvdW+m5z59b64BH4+SJ2klHIo6BPJSgUlmksJ
 QHnw==
X-Gm-Message-State: AOJu0YxcApNT5W/1xDs3QfyQjH6BM4NLuaTcMHfdALF/9aWz+5PWC6FQ
 ycPRhWgpJ6IxMHu5ffmyxV5c9dqQS80iNJbPpVm4Cb5ahiqDmNMJIxHr3OLMcC4cm6HY7egIrzH
 vZ8kECDh+WZt/GOgb/tZM/ClJokem5qc=
X-Gm-Gg: ASbGnctwWOuZJZ8ua4LTgugeMKfaJ3l3F8Tt5WzNoKUpXHkM3S3U68n0dUZ4G5jhBzu
 C1VvaKvutd3Mp3hJ5A70qQOJq4bveR8ACxj9rwmjP2fiTEZHQ5hL/51dhQ1zPsHqjPJEjIVjhfO
 f2Rh92yciKFU8THsB2FW6bvayqOSE8/KZO+ZsRVhMnejGE6pF91/2D25C24dHyk8hFUuS4Wk8Fk
 Y2nmJz3acXdKt9r2wY=
X-Google-Smtp-Source: AGHT+IHJAGZCReM/Q7M4tXpMlIg2E8yZ91ha/AEvXBjfgKrqCvZA5yabG/pshkYqcBGWi4Sfl1fvBwsBWH0HLS3Thd0=
X-Received: by 2002:a17:907:7e82:b0:afe:6648:a243 with SMTP id
 a640c23a62f3a-b00f67e0eb3mr2076761266b.3.1756974499932; Thu, 04 Sep 2025
 01:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250827205949.364606-1-peterx@redhat.com>
In-Reply-To: <20250827205949.364606-1-peterx@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 4 Sep 2025 16:27:39 +0800
X-Gm-Features: Ac12FXzMEA9Fkcja9O3MB6rcW8SlP9wlY1kfNqGL57esD_mgDpOiU0s404nSn0M
Message-ID: <CAK3tnvKa=C-9qkOuyB+sZB8+o6YU0V+qaYheK-h9KBEumpyfBw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/9] migration: Threadify loadvm process
To: Peter Xu <peterx@redhat.com>, Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Yury Kotov <yury-kotov@yandex-team.ru>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Prasad Pandit <ppandit@redhat.com>, 
 Li Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x531.google.com
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

On Thu, Aug 28, 2025 at 4:59=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> [this is an early RFC, not for merge, but to collect initial feedbacks]
>
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Nowadays, live migration heavily depends on threads. For example, most of
> the major features that will be used nowadays in live migration (multifd,
> postcopy, mapped-ram, vfio, etc.) all work with threads internally.
>
> But still, from time to time, we'll see some coroutines floating around t=
he
> migration context.  The major one is precopy's loadvm, which is internall=
y
> a coroutine.  It is still a critical path that any live migration depends=
 on.
>
> A mixture of using both coroutines and threads is prone to issues.  Some
> examples can refer to commit e65cec5e5d ("migration/ram: Yield periodical=
ly
> to the main loop") or commit 7afbdada7e ("migration/postcopy: ensure
> preempt channel is ready before loading states").
>
> Overview
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> This series tries to move migration further into the thread-based model, =
by
> allowing the loadvm process to happen in a thread rather than in the main
> thread with a coroutine.
>
> Luckily, since the qio channel code is always ready for both cases, IO
> paths should all be fine.
>
> Note that loadvm for postcopy already happens in a ram load thread which =
is
> separate.  However, RAM is just the simple case here, even it has its own
> challenges (on atomically update of the pgtables), its complexity lies in
> the kernel.
>
> For precopy, loadvm has quite a few operations that will need BQL.  The
> question is we can't take BQL for the whole process of loadvm, because
> that'll block the main thread from executions (e.g. QMP hangs).  Here, th=
e
> finer granule we can push BQL the better.  This series so far chose
> somewhere in the middle, by taking BQL on majorly these two places:
>
>   - CPU synchronizations
>   - Device START/FULL sections
>
> After this series applied, most of the rest loadvm path will run without
> BQL anymore.  There is a more detailed discussion / todo in the commit
> message of patch "migration: Thread-ify precopy vmstate load process"
> explaning how to further split the BQL critical sections.
>
> I was trying to split the patches into smaller ones if possible, but it's
> still quite challenging so there's one major patch that does the work.
>
> After the series applied, the only leftover pieces in migration/ that wou=
ld
> use a coroutine is snapshot save/load/delete jobs.
>
> Tests
> =3D=3D=3D=3D=3D
>
> Default CI passes.
>
> RDMA unit tests pass as usual. I also tried out cancellation / failure
> tests over RDMA channels, making sure nothing is stuck.
>
> I also roughly measured how long it takes to run the whole 80+ migration
> qtest suite, and see no measurable difference before / after this series.
>
> Risks
> =3D=3D=3D=3D=3D
>
> This series has the risk of breaking things.  I would be surprised if it
> didn't..
>
> I confess I didn't test anything on COLO but only from code observations
> and analysis.  COLO maintainers: could you add some unit tests to QEMU's
> qtests?

For the COLO part, I think remove the coroutines related code is OK for me.
Because the original coroutine still need to call the
"colo_process_incoming_thread".

Hi Hailiang, any comments for this part?

Thanks
Chen

>
> The current way of taking BQL during FULL section load may cause issues, =
it
> means when the IOs are unstable we could be waiting for IO (in the new
> migration incoming thread) with BQL held.  This is low possibility, thoug=
h,
> only happens when the network halts during flushing the device states.
> However still possible.  One solution is to further breakdown the BQL
> critical sections to smaller sections, as mentioned in TODO.
>
> Anything more than welcomed: suggestions, questions, objections, tests..
>
> Todo
> =3D=3D=3D=3D
>
> - Test COLO?
> - Finer grained BQL breakdown
> - More..
>
> Thanks,
>
> Peter Xu (9):
>   migration/vfio: Remove BQL implication in
>     vfio_multifd_switchover_start()
>   migration/rdma: Fix wrong context in qio_channel_rdma_shutdown()
>   migration/rdma: Allow qemu_rdma_wait_comp_channel work with thread
>   migration/rdma: Change io_create_watch() to return immediately
>   migration: Thread-ify precopy vmstate load process
>   migration/rdma: Remove coroutine path in qemu_rdma_wait_comp_channel
>   migration/postcopy: Remove workaround on wait preempt channel
>   migration/ram: Remove workaround on ram yield during load
>   migration/rdma: Remove rdma_cm_poll_handler
>
>  include/migration/colo.h    |   6 +-
>  migration/migration.h       |  52 +++++++--
>  migration/savevm.h          |   5 +-
>  hw/vfio/migration-multifd.c |   9 +-
>  migration/channel.c         |   7 +-
>  migration/colo-stubs.c      |   2 +-
>  migration/colo.c            |  23 +---
>  migration/migration.c       |  62 ++++++++---
>  migration/ram.c             |  13 +--
>  migration/rdma.c            | 206 ++++++++----------------------------
>  migration/savevm.c          |  85 +++++++--------
>  migration/trace-events      |   4 +-
>  12 files changed, 196 insertions(+), 278 deletions(-)
>
> --
> 2.50.1
>

