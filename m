Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD664D35154
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 20:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w82BP-0004Jd-BI; Wed, 01 Apr 2026 16:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w82BL-0004IE-79
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:28:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w82BI-00037c-Rq
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775075330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Wo6sI7bt0gtsqMIVJ/44z9YQrwtcWWm654KQpvTtXiE=;
 b=TM2GxuVikaGSwZM3OI1LKDNtbV5WQipq+jj0hfZvaTopRrQqK4FP9NcFcIisDWU8Hp/dhM
 UtKHoAV4/AxDJPaMUrBfV2l4Y0dwidFmy6CrNDODs+RJCR9eCslIBIqnXEMZaBYNnfUhv4
 9KnU5sC5Rm3vSgk8lnkUeIjHRiNkcic=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-RVeS-j-9Po6wukHwKI5T5w-1; Wed, 01 Apr 2026 16:28:48 -0400
X-MC-Unique: RVeS-j-9Po6wukHwKI5T5w-1
X-Mimecast-MFC-AGG-ID: RVeS-j-9Po6wukHwKI5T5w_1775075328
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cfc1634e43so24018385a.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 13:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775075327; x=1775680127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Wo6sI7bt0gtsqMIVJ/44z9YQrwtcWWm654KQpvTtXiE=;
 b=i++rrY7jKMt6nCxC6Rz5UqnnsaL3PH7KC0+FfgOCm1ioFFjGoD7oqtNENfzcoSpgn6
 mWuZmSjpm3plYklXbzOehHvtlFyl90QCkVbzAUt0JZAR6KHT55gGmcKQ/vdSaXcphj9i
 vvUUlp4x2RUEfEZSZ6s9vX0zpp0ZkoIYxkdc3rJ5A8OGegiphFpZc383fVV/TgYN/yev
 +ZcWGx/9mwpuwcY5fZaC0Bf6YZc2sORV9xHYx+u+spQO/9/nj72sgwlSSTzMj73uf5q7
 v2SMnK81V+j4QNoMavqxuygQoskxaUcX8Q57TMLuUJGx05+5VtjIidjOh6Bs5ADU9Jdr
 WWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775075327; x=1775680127;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wo6sI7bt0gtsqMIVJ/44z9YQrwtcWWm654KQpvTtXiE=;
 b=UIU0g7tPt7yct7nsxdJ+h2zZZMPhSMoUFh38jyZ4ANaXw3TA4k7Ub2/gsWSFTp43qo
 JJ+TJ0wAELYMbsD2/kK4U5ZomIOtre/pyz1MLm7nf6WP67j2FRI7YzQIrxowfc2uKign
 Cx9Qh5fE0EVMii+XtKhhS7PvozMo9i3a5hOvJw6SlSbUDbnRkvtYxhqv6/tdz2gZqKGS
 VU7RSQUyERfdX8gE9U/7tI9lR4BChXrqcdmVTdIhPAYaIy+V3pkFHdUCmDhSR+afSFWe
 Q3JfnL+gcif+xodP92DsmGPoYd6zM0jeWVofFeXqEHh7IPpLOFRtqm8uwuhrrMSeeGML
 Fk4g==
X-Gm-Message-State: AOJu0YzJIeBXu4ah7zrRi4eKMlwdMGNh3T8BmP0ZBuHfFa9G/pnXYqBZ
 kIFjcKC8SC83bA7v6HocDuNZWpT6loUJw3DTgZVb8k5cl7Ca7/J50W6QKdAwEp0g69jbwpSayBm
 Sz9ti3+E29LKsiIM3Zm1gUN0M0S4xmQOs6xObfr2uiYKOfqWumS8Hc5wwowImwNAcfm56s9j9Ya
 m5Uswwo917wYX6pQy2Cjs6RWXLPMTtkfxNiw9Pqg==
X-Gm-Gg: ATEYQzzWYFzIupz2uMvcGqjwoBrPNTClxHn6WzbfH2J9Tfq47lYvjaHpAvVwd3TFZhd
 NRGSWuHOBGoJEHTkzArdHOJLNXJUv7osOc0O8eKP4lOaHvtyzy3IsgeMRcL8/74La+eWAesJf07
 umVPsCYAz+F3JQaLt2HsTCLbGb4YE50n805lrlObymzKmeFuIYJcZl5rmQwbqxxWNg+H1fK8/f6
 gGhZSIKfTS5R1/P1k919qHWTgWdd6graicP0+QaEmpUy96W3dfYHhQNmw6EymLAZbv2Vzhz+mZ8
 xJbCK710MOHdauWAgo3t63AXFV68eQHBcFewoGDHUlkUeE0kUURULQ8Mz/dS0FhrlbXpZ/nyqJC
 E4ASrLpy94wEJalSPTO3j/z/JVJ/hHlkIiTS27fE0Y/c=
X-Received: by 2002:a05:620a:4453:b0:8cd:b2ca:c2a9 with SMTP id
 af79cd13be357-8d1b5bded81mr731104485a.58.1775075326906; 
 Wed, 01 Apr 2026 13:28:46 -0700 (PDT)
X-Received: by 2002:a05:620a:4453:b0:8cd:b2ca:c2a9 with SMTP id
 af79cd13be357-8d1b5bded81mr731099685a.58.1775075326180; 
 Wed, 01 Apr 2026 13:28:46 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a548a4efsm68194085a.8.2026.04.01.13.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 13:28:45 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Subject: [PATCH 00/11] vmstate: Implement VMS_ARRAY_OF_POINTER_AUTO_ALLOC
Date: Wed,  1 Apr 2026 16:28:33 -0400
Message-ID: <20260401202844.673494-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

CI: https://gitlab.com/peterx/qemu/-/pipelines/2424266591
    (one checkpatch warning, not relevant to this series)

rfcv1: https://lore.kernel.org/r/20260317232332.15209-1-peterx@redhat.com
rfcv2: https://lore.kernel.org/r/20260326210532.379027-1-peterx@redhat.com

Changelog rfcv2->v1:

- Rebased to latest fabiano's migration-staging branch (bd698d7730)
- Collected new tags
- Patch 1
  - Add space between "_type*" [Phil]
- Patch 9
  - Slight refactoring on vmstate_load_next() [Fabiano]
  - I collected Alexander's tested-by even if strictly I shouldn't when the
    patch changed; if test fails, it's me to blame.

This is v1, I removed RFC as I we should have reached some form of
consensus in general.  It is based on Fabiano's migration-staging branch.
I've pushed this tree here for easier reference:

https://gitlab.com/peterx/qemu/-/tree/vmstate-array-null

This series implements a new vmstate flag that allows real dynamic array of
pointers to be migrated, so that QEMU vmstate core will be able to identify
NULL and non-NULL pointers pointing to any kind of VMSD (or base types),
then properly allocate memory for them on dest QEMU.

The first planned user of such is Alexander's NVMe migration series here:

https://lore.kernel.org/r/20260317102708.126725-1-alexander@mihalicyn.com

This is another alternative to solve this problem.

I tested analyze-migration.py with this version and it works with an idle
dump from the nvme series (after I rebase).

Thanks,

Alexander Mikhalitsyn (1):
  tests/unit/test-vmstate: add tests for VMS_ARRAY_OF_POINTER_AUTO_ALLOC

Fabiano Rosas (1):
  vmstate: Stop checking size for nullptr compression

Peter Xu (9):
  vmstate: Pass in struct itself for VMSTATE_ARRAY_OF_POINTER
  vmstate: Pass in struct itself for VMSTATE_VARRAY_OF_POINTER_UINT32
  vmstate: Do not set size for VMS_ARRAY_OF_POINTER
  vmstate: Update max_elems early and check field compressable once
  vmstate: Rename VMS_NULLPTR_MARKER to VMS_MARKER_PTR_NULL
  vmstate: Introduce vmstate_save_field_with_vmdesc()
  vmstate: Allow vmstate_info_nullptr to emit non-NULL markers
  vmstate: Implement load of ptr marker in vmstate core
  vmstate: Implement VMS_ARRAY_OF_POINTER_AUTO_ALLOC

 include/hw/intc/riscv_aclint.h |   6 +-
 include/migration/vmstate.h    |  88 ++++++++++--
 migration/savevm.c             |  28 ++++
 migration/vmstate-types.c      |  36 ++---
 migration/vmstate.c            | 247 ++++++++++++++++++++++++++-------
 tests/unit/test-vmstate.c      |  90 +++++++++++-
 roms/seabios-hppa              |   2 +-
 scripts/analyze-migration.py   |  22 +--
 8 files changed, 418 insertions(+), 101 deletions(-)

-- 
2.50.1


