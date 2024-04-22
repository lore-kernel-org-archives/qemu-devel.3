Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E1EC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 08:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rypNA-0006Ju-7R; Mon, 22 Apr 2024 04:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1rypN6-0006J6-Mk
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 04:49:56 -0400
Received: from esa6.hc1455-7.c3s2.iphmx.com ([68.232.139.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1rypN3-0002VL-R7
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 04:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1713775793; x=1745311793;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gMwAhiXvz+hCU7jh8+LVOt/3ttLUs54lzS9t/ltlvl0=;
 b=oW9kmZVV1FsdEuyra27YK5CdEYIJBqLCUlu6KF37fabTvDRuzaGyJGyl
 NBDq2AHubEvwjRTKDWCa2W8eH45XJjbpRE3TMf3XnDjq1jfcN/uFUwZ0V
 P5bXHZWpW0neqPeIQlWapmcBVwohTcghqq89LI8QUB5QsEmzbOHffklvo
 icLMy4EWIZi+0NlvTQq+rZIqIHLirhlYX4viSDti0cx53TW4E/ZdeLF3f
 ZerY7O/PFDlQf8LqiggRaJ2V36qnhWT/5uZyK+UL0HqPEcPe+SzmFZ78s
 z+qJ5UOcUI5nnWGpIFmyzmeVLjUGZEBDt4V5PyTXHkOuqc8GRYveVSYkb g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="158258444"
X-IronPort-AV: E=Sophos;i="6.07,220,1708354800"; d="scan'208";a="158258444"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2024 17:49:48 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 59225161EA
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 17:49:46 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 94BCDD53E8
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 17:49:45 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 319936BC66
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 17:49:45 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 812321A000B;
 Mon, 22 Apr 2024 16:49:44 +0800 (CST)
To: arei.gonglei@huawei.com,
	pizhenwei@bytedance.com
Cc: philmd@linaro.org, qemu-devel@nongnu.org,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] backends/cryptodev-builtin: Fix local_error leaks
Date: Mon, 22 Apr 2024 16:53:12 +0800
Message-Id: <20240422085312.1037646-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28336.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28336.006
X-TMASE-Result: 10-1.961500-10.000000
X-TMASE-MatchedRID: Rn/6WSM7RsmzVFZ6osYjDtN9TX8X49sztkpWbH/Eii4agfsCivbmXr8F
 Hrw7frluf146W0iUu2t+VyE0midOQy+3xqQ44pFWxkszn8tNF/8nWEI8uQPVnbwHu+XsbkzRzdl
 o26al4KF7EgGMXpurEawnY0RVRjvrHxPMjOKY7A8LbigRnpKlKZx+7GyJjhAU+jNUt+S2/MRh+3
 I0DNknBvdR4epCKUhjfj3GneQohAsSkygLh0q7M762CM2SEcayG9EfUwHYIegFiCyBXpAi2mQM1
 mEYkV5Hmw0Qaktp+ussz+cQMs/Tnp75MOLIf/j3DF+QsB+Q01JoBmTSwRxjXg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=68.232.139.139;
 envelope-from=lizhijian@fujitsu.com; helo=esa6.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Reply-to:  Li Zhijian <lizhijian@fujitsu.com>
From:  Li Zhijian via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

It seems that this error does not need to be propagated to the upper,
directly output the error to avoid the leaks

Closes: https://gitlab.com/qemu-project/qemu/-/issues/2283
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 backends/cryptodev-builtin.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index a514bbb310..940104ee55 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -23,6 +23,7 @@
 
 #include "qemu/osdep.h"
 #include "sysemu/cryptodev.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "standard-headers/linux/virtio_crypto.h"
 #include "crypto/cipher.h"
@@ -396,8 +397,8 @@ static int cryptodev_builtin_create_session(
     case VIRTIO_CRYPTO_HASH_CREATE_SESSION:
     case VIRTIO_CRYPTO_MAC_CREATE_SESSION:
     default:
-        error_setg(&local_error, "Unsupported opcode :%" PRIu32 "",
-                   sess_info->op_code);
+        error_report("Unsupported opcode :%" PRIu32 "",
+                     sess_info->op_code);
         return -VIRTIO_CRYPTO_NOTSUPP;
     }
 
@@ -554,8 +555,8 @@ static int cryptodev_builtin_operation(
 
     if (op_info->session_id >= MAX_NUM_SESSIONS ||
               builtin->sessions[op_info->session_id] == NULL) {
-        error_setg(&local_error, "Cannot find a valid session id: %" PRIu64 "",
-                   op_info->session_id);
+        error_report("Cannot find a valid session id: %" PRIu64 "",
+                     op_info->session_id);
         return -VIRTIO_CRYPTO_INVSESS;
     }
 
-- 
2.31.1


