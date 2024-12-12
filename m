Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D683E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLjpX-0007tr-Iv; Thu, 12 Dec 2024 09:06:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1tLhdw-0006nb-BK
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:46:09 -0500
Received: from air.basealt.ru ([193.43.8.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1tLhdt-00076R-52
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:46:07 -0500
Received: from boringlust.malta.altlinux.ru (obninsk.basealt.ru
 [217.15.195.17])
 by air.basealt.ru (Postfix) with ESMTPSA id DD0F72337E;
 Thu, 12 Dec 2024 14:45:59 +0300 (MSK)
From: gerben@altlinux.org
To: fred.konrad@greensocs.com,
	qemu-devel@nongnu.org
Cc: sdl.qemu@linuxtesting.org, Denis Rastyogin <gerben@altlinux.org>,
 David Meliksetyan <d.meliksetyan@fobos-nt.ru>
Subject: [PATCH] hw/display: refine upper limit for offset value in assert
 check
Date: Thu, 12 Dec 2024 14:45:39 +0300
Message-ID: <20241212114554.517379-1-gerben@altlinux.org>
X-Mailer: git-send-email 2.42.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.43.8.18; envelope-from=gerben@altlinux.org;
 helo=air.basealt.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 12 Dec 2024 09:05:35 -0500
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

From: Denis Rastyogin <gerben@altlinux.org>

Accessing an element of the s->core_registers array
with a size of 236 (0x3AC) may lead to a buffer overflow,
as the index 'offset' can exceed the valid range and reach values
up to 5139 (0x504C >> 2). This change addresses
a potential vulnerability when writing data.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Reported-by: David Meliksetyan <d.meliksetyan@fobos-nt.ru>
Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
---
 hw/display/xlnx_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 6ab2335499..69ccc7ccc2 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -743,6 +743,7 @@ static void xlnx_dp_write(void *opaque, hwaddr offset, uint64_t value,
     DPRINTF("core write @%" PRIx64 " = 0x%8.8" PRIX64 "\n", offset, value);
 
     offset = offset >> 2;
+    assert(offset <= (0x3AC >> 2));
 
     switch (offset) {
     /*
@@ -896,7 +897,6 @@ static void xlnx_dp_write(void *opaque, hwaddr offset, uint64_t value,
         xlnx_dp_update_irq(s);
         break;
     default:
-        assert(offset <= (0x504C >> 2));
         s->core_registers[offset] = value;
         break;
     }
-- 
2.42.2


