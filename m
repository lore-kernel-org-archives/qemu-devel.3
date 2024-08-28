Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF38C54755
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 09:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjEgt-0001tr-35; Wed, 28 Aug 2024 05:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1sjEgq-0001tJ-SB
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 05:10:08 -0400
Received: from imap5.colo.codethink.co.uk ([78.40.148.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1sjEgo-0005YS-QA
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 05:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p7u2uRITG+M6vwnJhPLEMQxr82PXj4I8DVtvucqxucY=; b=htoWf53SxyEF1UEnQnypjyhbJQ
 I/KhBsWysSselk1tjx50WbUKKl7RkG6vjlyx7KhSSFr63CQbJzm9q8wOipFfYzS5ilQe348z1KOVS
 UDPWF7ParqUQ3Zr3ulF6mvqipMXNWWATw593PyVRFAWVkJ3x+PXirKqGJ40ipi07Ho2/dyZEouqq9
 1/q6LcFolk2E5AxhyMXGA6CnlTvZgzw6L1xJvL94dG2fzVJyopeqqODzoS65UUJcYUjiWQ7Gfrlj8
 TZdyEO8vXnCow22XybiT1/o8UDdC46ln3K0GVQO97uKABH5btZK0D64fikqkrReYvTBGkxXO7ZSKR
 nI/6nItQ==;
Received: from [63.135.74.212] (helo=rainbowdash)
 by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1sjE8P-002sJG-VY; Wed, 28 Aug 2024 09:34:33 +0100
Received: from ben by rainbowdash with local (Exim 4.98)
 (envelope-from <ben@rainbowdash>) id 1sjE8P-000000006Aa-1SA6;
 Wed, 28 Aug 2024 09:34:33 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] qemu-timer: check for timerlist being initialised
Date: Wed, 28 Aug 2024 09:34:32 +0100
Message-Id: <20240828083432.23707-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=78.40.148.171;
 envelope-from=srv_ts003@codethink.com; helo=imap5.colo.codethink.co.uk
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

If you create a new timer before the timer lists have been
initialised then you will end up with an abort due to trying
to access an illegal timer list struct. Add an assert() for
the timer list being NON-null.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 util/qemu-timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 213114be68..5c0c6be56b 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -365,6 +365,7 @@ void timer_init_full(QEMUTimer *ts,
         timer_list_group = &main_loop_tlg;
     }
     ts->timer_list = timer_list_group->tl[type];
+    assert(ts->timer_list != NULL);
     ts->cb = cb;
     ts->opaque = opaque;
     ts->scale = scale;
-- 
2.37.2.352.g3c44437643


