Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4390E66886
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 14:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXKgk-0008Uk-58; Sun, 21 Dec 2025 09:45:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@ziyao.cc>) id 1vXIVb-000678-Pp
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 07:25:59 -0500
Received: from mail90.out.titan.email ([209.209.25.243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@ziyao.cc>) id 1vXIVV-0002eI-3a
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 07:25:54 -0500
Received: from localhost (localhost [127.0.0.1])
 by smtp-out.flockmail.com (Postfix) with ESMTP id 4dZ0qL14Rfz9rw1;
 Sun, 21 Dec 2025 12:25:50 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=iTN5dMOrifzbia4Ch2o7mKlW8qudrJgZQ0ZwkJO7TV0=; 
 c=relaxed/relaxed; d=ziyao.cc;
 h=from:subject:message-id:date:mime-version:to:cc:from:to:cc:subject:date:message-id:in-reply-to:reply-to:references;
 q=dns/txt; s=titan1; t=1766319950; v=1;
 b=H++cY+pjIkNJnP7F2a+Z+fvvXLen5YNHmn6KEvMz78hI9rD99FhB1G01xP360HAT8WlATC2F
 8IoddGWGMxlx3gAWrSSYDQHQnv4XcJHJ2w7HIiIsAfmthHSqOe9Ovqmt2x4eDmStYSz8FDP7Zwk
 kCd6ItLM5jxN5KdVOIV4v/2Q=
Received: from ketchup (unknown [117.171.66.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtp-out.flockmail.com (Postfix) with ESMTPSA id 4dZ0qJ1r6Tz9rvR;
 Sun, 21 Dec 2025 12:25:48 +0000 (UTC)
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: qemu-devel@nongnu.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH] hw/loongarch/virt: Don't abort on access to unimplemented
 IOCSR
Date: Sun, 21 Dec 2025 12:25:12 +0000
Message-ID: <20251221122511.56544-2-me@ziyao.cc>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1766319950000112861.21635.7776584213408663727@prod-use1-smtp-out1003.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=a8/K9VSF c=1 sm=1 tr=0 ts=6947e74e
 a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=CEWIc4RMnpUA:10
 a=x6NrL3YJSzhxXpqj1ScA:9 a=3z85VNIBY5UIEeAh_hcH:22
 a=NWVoK91CQySWRX1oVYDe:22
Received-SPF: pass client-ip=209.209.25.243; envelope-from=me@ziyao.cc;
 helo=mail90.out.titan.email
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 21 Dec 2025 09:45:02 -0500
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

Reading/writing unimplemented IOCSR on real LoongArch hardware doesn't
trigger any exceptions, instead, reading always results in zero and
writing is simply ignored.

Real-world applications, like memtest86plus, depend on the behavior to
run. However, since commit f2e61edb2946 ("hw/loongarch/virt: Use
MemTxAttrs interface for misc ops") which adds a call to
g_assert_not_reached() in the path of handling unimplemented IOCSRs,
QEMU would abort in the case.

Replace the assertion with qemu_log_mask(LOG_UNIMP, ...), so these
applications could run. It's still possible to examine unimplemented
IOCSR access through "-d unimp" command line arguments.

Fixes: f2e61edb2946 ("hw/loongarch/virt: Use MemTxAttrs interface for misc ops")
Signed-off-by: Yao Zi <me@ziyao.cc>
---
 hw/loongarch/virt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 49434ad1828b..8d7da5fac550 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -46,6 +46,7 @@
 #include "hw/block/flash.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "qemu/error-report.h"
+#include "qemu/log.h"
 #include "kvm/kvm_loongarch.h"
 
 static void virt_get_dmsi(Object *obj, Visitor *v, const char *name,
@@ -622,7 +623,9 @@ static MemTxResult virt_iocsr_misc_write(void *opaque, hwaddr addr,
                           features, attrs, NULL);
         break;
     default:
-        g_assert_not_reached();
+        qemu_log_mask(LOG_UNIMP, "%s: Unimplemented IOCSR 0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+        break;
     }
 
     return MEMTX_OK;
@@ -680,7 +683,9 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
         }
         break;
     default:
-        g_assert_not_reached();
+        qemu_log_mask(LOG_UNIMP, "%s: Unimplemented IOCSR 0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+        break;
     }
 
     *data = ret;
-- 
2.51.2


