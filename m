Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F57CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 11:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCb3J-0001Td-MY; Fri, 02 Oct 2026 07:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xCb3H-0001TI-6H
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 07:03:43 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xCb3E-0008U4-SW
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 07:03:42 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b912d37b6so42492845e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 04:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790939018; x=1791543818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9BuguhxQX/x1xqxgHXqAIBndTeoMp4K63rug6/xJRtQ=;
 b=ETZoLgKDGqNb9YM+qXjfabkQ2rP5RX8JXS7vjG9azYJaouPAKVso5C+kKQdpxl/jSw
 CdY9ul4uG1v5kCC1zyEH1rfgm3bukhlnEi7+6MXMQKXKfuQ7gXNY4su3eJhA8n2HY8N1
 gaMuuyKCF5pT1woe6QFcoTvnzfRX1OSA5ETjQHsirsYCH9xLTuM91QQrZGq/YVe6kVfw
 ewjnFgUwcnXIbtAwDkuQS4BAyfb7SYzXkXL1IXT9r6K2L/PpSlP69PxdNxt4AHe1Kpf+
 0Ip0HuVzl4OwsPTHTsrLVi8Xlr6Ys/9utEotQfz/HUM48ps6d0lH9Iu/SRJZW6qvOMR9
 dPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790939018; x=1791543818;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9BuguhxQX/x1xqxgHXqAIBndTeoMp4K63rug6/xJRtQ=;
 b=M8c17DV1liYZmdmIi2gIyJVZnnZ5Zti4OW4BBZBuio/EMKEJWI4ejwM17qkJsK++zS
 sox0reM34NMjh1mfVQM1zbWqe7M8Q6+cyImUbzOu4P9eH0CQ9CtP4MjVPmmnd6SOo9A5
 wiPTOsf9loYhWSpje/LY6mv02wI0RKdLLDRd/H7w3X7SsPeMzezKAv6WDobeGYy+j+BB
 Z2b4unKVjEEwi2ThdFy5N3Fx/+3OLza/NKrweZbaMKKVWk4hy/p0YKOH6tPu+xRJ9LzM
 1NhuBFKUhST4hTrkYWfMwswFlTDAsoStlmY97Or11M4JPbffnaHMz07NIfsWm6i42b7o
 bePQ==
X-Gm-Message-State: AFuF++mq/HOkkR8PBat7ohwn/naX0IBS/7EqK8bSFcMCPGuAXWkYIFtH
 9JR6+Xyr+A5h5lu22uDA/LPg+FRZxf9vDBGTUigp9pDYBu0UGK9DXgVU+Q51qHUpCsiNDK+dqWg
 OJObp
X-Gm-Gg: AYBFou3xqvenCsAXia66ZnmuixUwi2lfuBalVfFCsnV2/X+Vp2iqY3bBmA/m86YfUiw
 vfCmdFz0Gtv4rKM7BwQ/KhH4EIYyHBD88KOmImG4JmpF4vFlYbcVEwdGzu/D5vwgCDesS6w43vY
 dJjr3/t89TXFsCfhJS1LXGDRWNFHgL7V6E/f+1FMpbhM4z04LIrTA+U1QOv6USzCkRbGj5GEHfI
 RwP6dhdz76rqoXVhA02uSK4Zemah9pbf9UeZW1GUPJLoaW7mfG3nErMIiDE16hA+DbR/WxQLiiD
 9+9KKMzBD/7PWMLdpuMSTuKmkdXBEqezwFAi7QZ1OVYU7sA0GXA5fX7t/nMi+nUAomzJsoEyCHk
 /iWZ77W9LQriGwEtT/gq5t/+RgoVCYSyh7mi889sUZ2yrTNqQ/xpF1u1eEsCWgkoRUpm0KbYmTU
 eQgbJ0nGsNlzCTC0WzqzHQucUnlX0Wjf4woHrgnPzWbXVjl0mgu6uannlWHYBlXCp3fdU=
X-Received: by 2002:a05:600c:3e1a:b0:4a0:1c69:f607 with SMTP id
 5b1f17b1804b1-4a0276b0ea6mr40209735e9.29.1790939018273; 
 Fri, 02 Oct 2026 04:03:38 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9f21:a362:21c8:d9a1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03ff3cab2sm24533785e9.2.2026.10.02.04.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 04:03:37 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 0/4] migration/postcopy: report destination states only after
 the run state change
Date: Fri,  2 Oct 2026 13:02:54 +0200
Message-ID: <20261002110258.1835979-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=den@openvz.org; helo=mail-wm2-x11.google.com
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

On the postcopy destination, the postcopy-active and completed states
can be reported while the VM is still in RUN_STATE_INMIGRATE. The run
state only changes in loadvm_postcopy_handle_run_bh(), but
loadvm_postcopy_handle_run() switches to postcopy-active before it
schedules the BH, and the listen thread can report completed before the
BH has run. Precopy does not have this problem: the run state changes
before completed is reported.

We hit this in production. A VM with a persistent dirty bitmap migrates
its bitmaps in postcopy, so libvirt runs the Finish phase as soon as the
source enters postcopy-active. Our libvirt reattaches disks on the
destination in Finish, and the blockdev-add calls land while the
destination is still in RUN_STATE_INMIGRATE. The new nodes are created
inactive, the device cannot be attached to them ("Block node is
read-only"), and the guest is lost on both hosts. A bitmap-only
postcopy makes the window wide, because the listen thread has almost
nothing to load.

The series orders both destination states after the run state change
and adds a qtest check that fails on master. The last patch gives the
source's postcopy-active the same meaning. It takes Peter's idea from
the review of Juraj's RFC [1]: record the package-loaded ping and send
the pong later [2]. Here the pong is sent from the run BH, after the run
state change, rather than from loadvm_postcopy_handle_run(). It keeps
the source in postcopy-device longer, so it can be dropped without
affecting the rest.

[1] https://lore.kernel.org/qemu-devel/20260423154525.10292-1-jmarcin@redhat.com/
[2] https://lore.kernel.org/qemu-devel/afJg6VzsaslzZQW1@x1.local/

Many thanks to Juraj for the postcopy-device state in 7b842fe354c. It is
what gives the source a point to wait at, and this series only moves
that point to where the destination has really left
RUN_STATE_INMIGRATE.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Juraj Marcin <jmarcin@redhat.com>

Denis V. Lunev (4):
  migration/postcopy: report COMPLETED only after the run BH has run
  migration/postcopy: set destination postcopy-active in the run BH
  tests/qtest/migration: check the destination run state in postcopy
    tests
  migration/postcopy: answer the package-loaded ping from the run BH

 migration/migration.c                  |  3 +++
 migration/migration.h                  |  4 ++++
 migration/postcopy-ram.c               |  4 ++++
 migration/savevm.c                     | 18 +++++++++++++-----
 tests/qtest/migration/framework.c      |  6 ++++--
 tests/qtest/migration/migration-qmp.c  | 10 ++++++++--
 tests/qtest/migration/migration-qmp.h  |  3 ++-
 tests/qtest/migration/migration-util.c |  8 ++++++++
 tests/qtest/migration/migration-util.h |  2 ++
 9 files changed, 48 insertions(+), 10 deletions(-)


base-commit: f7ada39edacaa5c26b30e98b94017b0b2ccbcf94
-- 
2.53.0


