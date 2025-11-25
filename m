Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02D8D0E6EC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 14:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNtw1-0007Zb-3j; Tue, 25 Nov 2025 09:22:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vNtuq-0007DR-Sj
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:21:23 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vNtun-0002Go-E2
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:21:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=gMGXypU8Nk0mBK6wTCs2cKN1n7L7ZbG+kaMs8D8iq6c=; b=Ycb2i+w4CwHD
 JLWj3yHnQ0OFUBDIQiGTo/pHIUAjc0ZnUZpVg3FeHrkTqF/PzHSFTWyQ0BqRblfckaRmtPakWN/s3
 gO/X5Lqz9xRj4qQsNmsYl9yKEc2KlMnwCo+17ghJGHPGPVaUKamC3SVVnJeUT09LMbkam7jwf6plj
 oeVel6sxRl3qeUMrpMlWwtT5+efjv0JzivxjcbfwrdaAaUNQ9a6QiHhxjsRsdNm0nso4YF6hd8a5d
 MJ2Nk3yTmzAawwurxunVrBNZb89jxlXWP4gitEgEwYwE9C8MIAPKq8QmHHeiRte1XzoEAXT7yxMgd
 9fOwTTfhM4YQqW9sUSpsaQ==;
Received: from [130.117.225.5] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1vNtsz-003IJo-05;
 Tue, 25 Nov 2025 15:20:56 +0100
From: andrey.drobyshev@virtuozzo.com
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peterx@redhat.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH 1/4] scripts/qemugdb: mtree: Fix OverflowError in mtree with
 128-bit addresses
Date: Tue, 25 Nov 2025 16:21:02 +0200
Message-ID: <20251125142105.448289-2-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251125142105.448289-1-andrey.drobyshev@virtuozzo.com>
References: <20251125142105.448289-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

The 'qemu mtree' command fails with "OverflowError: int too big to
convert" when memory regions have 128-bit addresses.

Fix by changing conversion base from 16 to 0 (automatic detection based
on string prefix).  This works more reliably in GDB's embedded
Python.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 scripts/qemugdb/mtree.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qemugdb/mtree.py b/scripts/qemugdb/mtree.py
index 8fe42c3c12..77603c04b1 100644
--- a/scripts/qemugdb/mtree.py
+++ b/scripts/qemugdb/mtree.py
@@ -25,7 +25,7 @@ def int128(p):
     if p.type.code == gdb.TYPE_CODE_STRUCT:
         return int(p['lo']) + (int(p['hi']) << 64)
     else:
-        return int(("%s" % p), 16)
+        return int(("%s" % p), 0)
 
 class MtreeCommand(gdb.Command):
     '''Display the memory tree hierarchy'''
-- 
2.43.5


