Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302C2C3601A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 10:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzvCB-0003lO-F3; Wed, 02 Apr 2025 06:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mordan@ispras.ru>) id 1tzvBu-0003ai-Bc
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 06:19:30 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mordan@ispras.ru>) id 1tzvBs-0002Jw-IH
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 06:19:26 -0400
Received: from Neilbrown.intra.ispras.ru (unknown [10.10.2.179])
 by mail.ispras.ru (Postfix) with ESMTPSA id E47F3448787C;
 Wed,  2 Apr 2025 10:19:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru E47F3448787C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1743589162;
 bh=Nw9xEa85iBDslzq5m/m7ZP37z8VWg4I44HrxzPR52/0=;
 h=From:To:Cc:Subject:Date:From;
 b=a1MB1kpvgzn12RyIDlojvaP9d9KKLIUZZyL64N+d3cY+VJE4xLSX+OP+AUx2MWLAI
 iNJV9IbqwLsu4oq3rueJGsS4Mk59h1eFpPUuFYTIzryDBGOVDWWA5oKnzlOHZzzU1c
 AK/HaLnWQ6I7RMXRWd2C0u6o1zKNoC0o3yJPWOCE=
From: Vitalii Mordan <mordan@ispras.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Vitalii Mordan <mordan@ispras.ru>, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org,
 Vadim Mutilin <mutilin@ispras.ru>,
 Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] Fix data race with slh_first field in test-aio-multithread
Date: Wed,  2 Apr 2025 13:19:17 +0300
Message-Id: <20250402101917.3345464-1-mordan@ispras.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84; envelope-from=mordan@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch addresses potential data races involving access to the
slh_first field in the QSLIST_INSERT_HEAD_ATOMIC macro.

Fixes: c740ad92d0 ("QSLIST: add lock-free operations")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2902
Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
---
 include/qemu/queue.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/qemu/queue.h b/include/qemu/queue.h
index e029e7bf66..b0dbc3c6e2 100644
--- a/include/qemu/queue.h
+++ b/include/qemu/queue.h
@@ -217,7 +217,8 @@ struct {                                                                \
 #define QSLIST_INSERT_HEAD_ATOMIC(head, elm, field) do {                     \
         typeof(elm) save_sle_next;                                           \
         do {                                                                 \
-            save_sle_next = (elm)->field.sle_next = (head)->slh_first;       \
+            save_sle_next = qatomic_read(&(head)->slh_first);                \
+            (elm)->field.sle_next = save_sle_next;                           \
         } while (qatomic_cmpxchg(&(head)->slh_first, save_sle_next, (elm)) !=\
                  save_sle_next);                                             \
 } while (/*CONSTCOND*/0)
-- 
2.34.1


