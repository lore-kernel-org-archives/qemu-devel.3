Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A02CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9Zv-0008Hp-AE; Sat, 17 Oct 2026 14:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9Zj-0008CS-Db; Sat, 17 Oct 2026 14:56:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9Zg-0003bc-B9; Sat, 17 Oct 2026 14:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263360; bh=AWYVdoCluqSQdoczhrmj5H3SEP9gyykz8ZRAYDegeIQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IYZrIjjcGS9UPleyK6+k0I4c7YAPWdH167jWN4lQ//x3t3HzMzkQaa4pzxEm8pOPC
 I59Ims7BAM6F5XsbEFCQ+VOhPzQDHnCWcplIu5iD5r8k0XWIA7vj96dn0nq8O1ZIBi
 B3PzPII7K0rY57NzKkW1HscFHlZwXzNvz+yNYCO6o2SZR3Y0Vt/EhJBtCNqHqAPMwY
 USqh6WCcexRs/Uqvn3KarUn1nOg0ciNHgsXn5DtEZ2dmiuJCTKeSh+PHnVFMpLvnDd
 4IeRPzBT4diPRJQ6sSJ2BbRbLYbhmEBaQjjexf35AWMQy5C+jJbdETaz1e29rPfhpC
 OARffxHKRdktQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A8E111DE6A6;
 Sat, 17 Oct 2026 21:56:00 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7406C443371;
 Sat, 17 Oct 2026 21:55:59 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 06/63] virtio-ccw: Do not overwrite existing
 indicators
Date: Sat, 17 Oct 2026 21:54:22 +0300
Message-ID: <20261017185528.722197-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Eric Farman <farman@linux.ibm.com>

The various indicators pointers allow them to be overwritten,
but leak any existing structs that might be there. If indicators
exist, ensure that they are released before setting the new ones.

Both the regular and adapter interrupt paths check that they
aren't being asked to enable interrupts when the other one is
enabled, so just do this release once all the potential checks
are completed.

Cc: qemu-stable@nongnu.org
Fixes: 7bca3892cb ("s390x/virtio-ccw: reference-counted indicators")
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260922201526.2383047-3-farman@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit 13c7ba5e0f14aa4c711ba7fc92cddceeafcb1e3f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 5d7112b028..b2887a1443 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -580,6 +580,11 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             if (ret) {
                 break;
             }
+            if (dev->indicators) {
+                /* Need to remove existing indicators first */
+                release_indicator(&dev->routes.adapter, dev->indicators);
+                dev->indicators = NULL;
+            }
             indicators = be64_to_cpu(indicators);
             dev->indicators = get_indicator(indicators, sizeof(uint64_t));
             sch->curr_status.scsw.count = ccw.count - sizeof(indicators);
@@ -604,6 +609,11 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             if (ret) {
                 break;
             }
+            if (dev->indicators2) {
+                /* Need to remove existing indicators first */
+                release_indicator(&dev->routes.adapter, dev->indicators2);
+                dev->indicators2 = NULL;
+            }
             indicators = be64_to_cpu(indicators);
             dev->indicators2 = get_indicator(indicators, sizeof(uint64_t));
             sch->curr_status.scsw.count = ccw.count - sizeof(indicators);
@@ -664,6 +674,17 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             } else if (thinint.isc > MAX_ISC) {
                 ret = -ENOSYS;
             } else {
+                if (dev->indicators) {
+                    /* Need to remove existing indicators first */
+                    release_indicator(&dev->routes.adapter, dev->indicators);
+                    dev->indicators = NULL;
+                }
+                if (dev->summary_indicator) {
+                    /* Need to remove existing indicators first */
+                    release_indicator(&dev->routes.adapter,
+                                      dev->summary_indicator);
+                    dev->summary_indicator = NULL;
+                }
                 thinint.ind_bit = be64_to_cpu(thinint.ind_bit);
                 thinint.summary_indicator =
                     be64_to_cpu(thinint.summary_indicator);
-- 
2.47.3


