Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5462FF8868
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 09:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHf5m-0002YC-Pw; Tue, 28 Apr 2026 05:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wHf5j-0002Xh-4o
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 05:50:56 -0400
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wHf5d-0006R0-Ek
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 05:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1777369834; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=490pcYJYuDPXlIAQOp+E+5S2LUcUJ5QN+6D5lFAP5FU=;
 b=DepVXYpeFO+QRga4PHzth8na6kwpNt9LJiqPbcFAR/AgSzo3QFmb1n8iPocz94GB78l05/SeKEAZ6n86D2TNTNZIASKRw/wXi1lVjxA2PfzFDoJs48R0hdkvwS438kZkfpiVjVyl3aMqUjYbgv/I981xBqsu6tVGw1DwpUs+Utc=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0X1u667w_1777369817; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X1u667w_1777369817 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 28 Apr 2026 17:50:33 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, stefanha@redhat.com, fam@euphon.net,
 qemu-block@nongnu.org
Subject: [PATCH 0/2] util/aio-posix: fix and clean up poll_ready handling in
 aio_prepare()
Date: Tue, 28 Apr 2026 17:50:13 +0800
Message-ID: <20260428095015.76902-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.118;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-118.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

When aio_prepare() calls poll_set_started(..., false) to disable poll
mode before handing control to GLib's event loop, the final poll round
may mark handlers poll_ready=true and insert them into a local
ready_list.  That list is discarded when aio_prepare() returns, so
those handlers are silently lost until the next GLib iteration.

Patch 1 fixes the bug: aio_pending() is extended to scan
poll_aio_handlers for poll_ready nodes so GLib's check phase reports
pending work, and aio_dispatch() is taught to collect those nodes
before dispatching, ensuring they are executed in the same cycle.

Patch 2 is a follow-up clean-up: now that poll_ready nodes are handled
via aio_pending()/aio_dispatch(), the local ready_list in aio_prepare()
serves no purpose.  Pass NULL to poll_set_started() and teach it to set
poll_ready=true directly, eliminating the unnecessary list operations.

Bin Guo (2):
  util/aio-posix: fix poll_ready handlers dropped in aio_prepare()
  util/aio-posix: avoid allocating ready_list in aio_prepare()

 util/aio-posix.c | 47 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 7 deletions(-)

-- 
2.50.1 (Apple Git-155)


