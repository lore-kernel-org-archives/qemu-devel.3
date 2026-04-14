Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCC8ED7B8F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 09:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCa7a-000565-Oj; Tue, 14 Apr 2026 05:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wCa7W-000559-G8
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 05:31:48 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wCa7S-0005oB-FS
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 05:31:45 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5a402b2d102so1287110e87.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 02:31:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776159099; cv=none;
 d=google.com; s=arc-20240605;
 b=k5SasWyM6NaPxi7c6CbJE0eojmGXr5wVUJ0RrvtsymfMyy3JN4VKt+vg95dy7uurFT
 vdlxMBlL4RNRia9L7M8ENx98qZhlMa+vD/phvLZyt3rDUgmOuYbIYTosp1OihipNA418
 cf9KZX1SBeMGYojF3cx3kt1whwi7jlZeMbK7eH2/Y9uGlyjpV13mXu2NeoZCu3wldjXn
 38uFDrtGx1BQfbJ5fuZYgP7HnAvCkNwoxbHilEPsxspVFFzdV/qZPZRALAahiSdfIr/U
 HaDx5I3oLRJRJ7I/AnYW0dzRfm15pE93XqcatjkVUCZu2+hGl6gWWz18pHePpA/4lpwg
 EFhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5LWltPRP3tl7m6IZ7WA5D08XHty2E2szy3QsM+rdBbI=;
 fh=D9TiOsAcOSpRlHrkA38ELZyIVSvZmg48LLzTtJLYv+0=;
 b=UIhYx3zAS/geq+H0/zjxX/bItGZqOqm1pg+pZPwS2h7qtF+4ZGXzRqrMyS/BOi9lSb
 e4NxZGTXxK+/PxBBnGsaTW6J2yxSIb6wv+EkoYd7lXR+SQCVBTLrChJkFJ/yVlx6EaI3
 s3idimBkqve1rKv8kh4kyV9OtcTCCmn0n0jh6B1lVQslNZgZS9NK2Af0+KIkhOZ63Zwp
 05A2QLpXKJyqmM/cLOrWtilYC/+NOI4YEX4amY57qcKTxrQivCIy7z+XX8cEAGh6dL/P
 2znkGg9mr63LAmyaraMgXS5P5y7PeoBTc5673cBlDRFMLimKAu7qwNUE+Tuglf0kiavA
 Gdng==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1776159099; x=1776763899; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5LWltPRP3tl7m6IZ7WA5D08XHty2E2szy3QsM+rdBbI=;
 b=WFn4wLnPdsufbZDvZT6T7usS/YgxfImn/Layuz9UKpDUiXjGPl2ivZUBzvWPctux4B
 T7SWJZHMAiIw2zcqNifdnastljVMvxIBgmgeTdQSg52tjUj3O3ag/69zXiSdwrvzZJyU
 /JiZjEoZxTm1zKHjB+xpxesIfFi8n65oTMw6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776159099; x=1776763899;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5LWltPRP3tl7m6IZ7WA5D08XHty2E2szy3QsM+rdBbI=;
 b=LUGcvlk8tI9pAUyLhZ3x86N3YdEgz6NwV7r/Xu2B60L8faQQzsu3Zy6bdGoaiRJcsH
 g1dGhkLGCWVHiGEGSyIiDg0ZOUkhF8foU2HJ1e5S56FraoYsWh+l6LSN4anJeUjnFP/D
 OMV4sLsC5k+XPOhL+SqFUVaQRlpJq2fgHcXA1cpHM9BT0sRtylIR0TabmnH2jvHtuX6T
 NsyiFYnv8wJFMn8STFuJ2BCbyYjXXkDo0vJc6ADbaT22SRwvTm1w2YEk+eqNGG86p/O6
 cHb03YiR3nCsarKj2GA2qH7lUuQi/Stx3vqX9Gi4kWY2hkTM1dS8OPtZ+lUUmgGa/4pt
 nwNg==
X-Gm-Message-State: AOJu0YyLnEjK5hcLnIivmuXikoPoVqNbDlb1xd0sam4DW5K8IqImRJ6g
 VUN9nc8MtU5v2Y3QIeBe/3v9YhknejWmthEIlub6Vk950hF3vqlDs+6+kcuq8q+rIy0j8tLctNU
 puyb6puFssKLR0cOTFDW/zc9PW72Ho+TsOAEfOu1gLg==
X-Gm-Gg: AeBDietsaQu9XWilEvihcvc/IE912N/zix6QIRsMLEQOC1saZmcxwgrNb+/I18G7FcT
 IWUFfKZRrqYsA2LrNquu05ZDp9A61sG8jDXwsUvcvFaqa1dM6u3O4ZrcRQfUZfU8p+aV2tG7uBZ
 1I4VM8tY9Ul/ZMm39Xkl8E8tcbkQeo2VUVDvoCZ2lU3hEmvCK98sYEuW9Sq2vAgpJxdGO8VLFXD
 TDIL0mp/d3Lj07i39sUal0IcYB1HANI1Fr9wgYvr/mTwnn0r5P2/y/W5QCApZdMWgPB0R3Ll5Al
 nAIplKElG17eCitEDO18FswnJduzi43Xw6zMjmc=
X-Received: by 2002:a05:6512:1083:b0:5a2:b219:3ecb with SMTP id
 2adb3069b0e04-5a3efd9253amr6368692e87.42.1776159098272; Tue, 14 Apr 2026
 02:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260401202844.673494-1-peterx@redhat.com>
In-Reply-To: <20260401202844.673494-1-peterx@redhat.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 14 Apr 2026 11:31:26 +0200
X-Gm-Features: AQROBzCYM24TjlIBYf2rsKMdHFuXiSBVZDh1MGeZAOCa_IG-WmmSDMXrRgBYi5s
Message-ID: <CAJqdLrr9yyxr29U53NpFhghn7Nycd5LkA8U7eLSb9tjz3Huppw@mail.gmail.com>
Subject: Re: [PATCH 00/11] vmstate: Implement VMS_ARRAY_OF_POINTER_AUTO_ALLOC
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=alexander@mihalicyn.com; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Dear friends,

when I can expect this to be landed in master? I would like to prepare
and send next version of my
NVMe live migration patchset, that's why I'm asking.

Kind regards,
Alex

Am Mi., 1. Apr. 2026 um 22:28 Uhr schrieb Peter Xu <peterx@redhat.com>:
>
> CI: https://gitlab.com/peterx/qemu/-/pipelines/2424266591
>     (one checkpatch warning, not relevant to this series)
>
> rfcv1: https://lore.kernel.org/r/20260317232332.15209-1-peterx@redhat.com
> rfcv2: https://lore.kernel.org/r/20260326210532.379027-1-peterx@redhat.com
>
> Changelog rfcv2->v1:
>
> - Rebased to latest fabiano's migration-staging branch (bd698d7730)
> - Collected new tags
> - Patch 1
>   - Add space between "_type*" [Phil]
> - Patch 9
>   - Slight refactoring on vmstate_load_next() [Fabiano]
>   - I collected Alexander's tested-by even if strictly I shouldn't when the
>     patch changed; if test fails, it's me to blame.
>
> This is v1, I removed RFC as I we should have reached some form of
> consensus in general.  It is based on Fabiano's migration-staging branch.
> I've pushed this tree here for easier reference:
>
> https://gitlab.com/peterx/qemu/-/tree/vmstate-array-null
>
> This series implements a new vmstate flag that allows real dynamic array of
> pointers to be migrated, so that QEMU vmstate core will be able to identify
> NULL and non-NULL pointers pointing to any kind of VMSD (or base types),
> then properly allocate memory for them on dest QEMU.
>
> The first planned user of such is Alexander's NVMe migration series here:
>
> https://lore.kernel.org/r/20260317102708.126725-1-alexander@mihalicyn.com
>
> This is another alternative to solve this problem.
>
> I tested analyze-migration.py with this version and it works with an idle
> dump from the nvme series (after I rebase).
>
> Thanks,
>
> Alexander Mikhalitsyn (1):
>   tests/unit/test-vmstate: add tests for VMS_ARRAY_OF_POINTER_AUTO_ALLOC
>
> Fabiano Rosas (1):
>   vmstate: Stop checking size for nullptr compression
>
> Peter Xu (9):
>   vmstate: Pass in struct itself for VMSTATE_ARRAY_OF_POINTER
>   vmstate: Pass in struct itself for VMSTATE_VARRAY_OF_POINTER_UINT32
>   vmstate: Do not set size for VMS_ARRAY_OF_POINTER
>   vmstate: Update max_elems early and check field compressable once
>   vmstate: Rename VMS_NULLPTR_MARKER to VMS_MARKER_PTR_NULL
>   vmstate: Introduce vmstate_save_field_with_vmdesc()
>   vmstate: Allow vmstate_info_nullptr to emit non-NULL markers
>   vmstate: Implement load of ptr marker in vmstate core
>   vmstate: Implement VMS_ARRAY_OF_POINTER_AUTO_ALLOC
>
>  include/hw/intc/riscv_aclint.h |   6 +-
>  include/migration/vmstate.h    |  88 ++++++++++--
>  migration/savevm.c             |  28 ++++
>  migration/vmstate-types.c      |  36 ++---
>  migration/vmstate.c            | 247 ++++++++++++++++++++++++++-------
>  tests/unit/test-vmstate.c      |  90 +++++++++++-
>  roms/seabios-hppa              |   2 +-
>  scripts/analyze-migration.py   |  22 +--
>  8 files changed, 418 insertions(+), 101 deletions(-)
>
> --
> 2.50.1
>

