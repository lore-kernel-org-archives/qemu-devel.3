Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB297C44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 10:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkJCU-00041o-Oc; Thu, 16 Jul 2026 06:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wkJCT-00041e-Ks
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 06:20:17 -0400
Received: from [115.124.30.111] (helo=out30-111.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wkJCJ-00054e-11
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 06:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1784197194; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=BDQd/iBlbpofFm5nuJcZqJvHB5cXG0H9Mabhl90UX2w=;
 b=DGGRDA+dns4C6UivWi+QSKF7JbNPcuvLAOM+BDbv9dtlCLsgRIk6BmpHPvRqEw+bs4y0Uxx8DzTyOjq6nnMbfvy94ET81ZeoBt1y/9Boki+MlDya9RHMdrJW2Qj6WPsmFi1pxVagu1u6GW7odDyOGYLNIFduQZyFB3GRY6PAevA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R631e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0X7E4g4o_1784197193; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X7E4g4o_1784197193 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 16 Jul 2026 18:19:53 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de
Subject: [PATCH 0/3] migration: postcopy blocktime cleanups and assert fix
Date: Thu, 16 Jul 2026 18:19:49 +0800
Message-ID: <20260716101952.65329-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.111 (deferred)
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

This series fixes a couple of issues in the postcopy blocktime
fine-grained tracking feature:

  - Patch 1 fixes an ineffective overflow assert in vcpu_faults_current[].
  - Patch 2 fixes the const/gchar mismatch in format_time_str().
  - Patch 3 collects minor cleanups: remove a redundant memset() and
    fix the HMP label for non-vCPU latency.

Bin Guo (3):
  migration: fix ineffective overflow assert in postcopy blocktime
  migration: fix const mismatch in format_time_str()
  migration: clean up postcopy blocktime presentation

 migration/migration-hmp-cmds.c |  8 ++++----
 migration/postcopy-ram.c       | 10 ++++------
 2 files changed, 8 insertions(+), 10 deletions(-)

-- 
2.50.1 (Apple Git-155)


