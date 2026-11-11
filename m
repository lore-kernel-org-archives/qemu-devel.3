Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36089606A336
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 13:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR8RT-0005lH-VV; Wed, 11 Nov 2026 08:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhuwei@sangfor.com.cn>)
 id 1xR7X7-0001Rk-OZ
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:34:33 -0500
Received: from mail-m1602365312.xmail.ntesmail.com ([160.236.53.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhuwei@sangfor.com.cn>)
 id 1xR7X3-0006hB-Rx
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:34:33 -0500
Received: from ubuntu.. (unknown [43.247.70.81])
 by smtp.qiye.163.com (Hmail) with ESMTP id 5450e6ad4;
 Wed, 11 Nov 2026 20:27:11 +0800 (GMT+08:00)
From: Zhu Wei <zhuwei@sangfor.com.cn>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, zhuwei <zhuwei@sangfor.com.cn>,
 "zachwade . k" <zachwade.k@gmail.com.cn>
Subject: [PATCH 0/1] migration: free migration blocker error in
 migrate_del_blocker() stub
Date: Wed, 11 Nov 2026 20:27:10 +0800
Message-ID: <20261111122711.3167511-1-zhuwei@sangfor.com.cn>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1ca93938103a9kunm82bedf086c518e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGR5PVkIaQhpIS0tNSR1DQlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlPSFVJT0xVTEtVQ0pZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
Received-SPF: pass client-ip=160.236.53.12; envelope-from=zhuwei@sangfor.com.cn;
 helo=mail-m1602365312.xmail.ntesmail.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 11 Nov 2026 08:32:32 -0500
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: zhuwei <zhuwei@sangfor.com.cn>

Hi,
The migrate_del_blocker() implementation in stubs/migr-blocker.c was an
empty no-op, while the real one in migration/migration.c takes ownership
of the Error from the migration blocker, frees it and then clears the
pointer:
    void migrate_del_blocker(Error **reasonp)
    {
        if (*reasonp) {
            ...
            error_free(*reasonp);
            *reasonp = NULL;
        }
    }
Command-line tools such as qemu-img link against the stub API.  Block
drivers like vmdk allocate a migration blocker Error during open() (see
error_setg() in vmdk_open(), "does not support live migration") and pass
it to migrate_add_blocker_normal().  Because the stub
migrate_add_blocker*() is a no-op it does not take ownership of the
Error, so on close the stub migrate_del_blocker() has to free it itself;
leaving the body empty leaks the error message.
This becomes visible when running under ASan: "qemu-img info foo.vmdk"
leaks the migration-blocker error and hangs / fails to exit when the
image is closed.
This patch frees the Error in the stub migrate_del_blocker() and sets
the pointer to NULL to match the semantics of the real implementation.
This also covers every other driver that uses a migration blocker
through the stub.

Thanks,
zhuwei
---
 stubs/migr-blocker.c | 7 +++++++
 1 file changed, 7 insertions(+)

