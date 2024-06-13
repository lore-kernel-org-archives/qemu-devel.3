Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBBBC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 13:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHkVy-0004cj-Tu; Thu, 13 Jun 2024 09:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiangwencheng@dayudpu.com>)
 id 1sHeJj-0001MT-Qz
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 02:52:15 -0400
Received: from va-1-16.ptr.blmpb.com ([209.127.230.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiangwencheng@dayudpu.com>)
 id 1sHeJd-0003J3-27
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 02:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=dayudpu-com.20200927.dkim.feishu.cn; t=1718261515;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=P49yGcNT0MCnPT2bpjKgFMHgiI0ZB1XEpIXUNLmlRo0=;
 b=3F8VHDEsHUUK/fV+nZdQ+2BmicJpqwh8G4T9JkeQ7r5l15rr3aK0t0EAjA3inn0i0u7vej
 5PqGhsWU2lcdUXxXb3w3Ieik+W2Mv44P8asWngQZ4G4mY8tACm0TThfSHssMshhHYCi/HO
 oEvzFh0cE02xV80aRLzbW31YXjjxJw+pqo5oakHKk20GTAuY95fkPdfMVSjDmB1l9Zxt5U
 7+6nWjOH7wxOw9tFJMY5m+MNE3lBPfLxhpMUzZbPmMwa24O/3aR9Ug+AQ/A8pSwRAhvX1w
 8OChI2pycxRuRFX/YI6zrbeTrDHLaHJdgHwG0qrtzpHfWjVVinnfT/TGsfCWMw==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Message-Id: <20240613065150.3100-1-xiangwencheng@dayudpu.com>
X-Mailer: git-send-email 2.30.0
Received: from localhost.localdomain ([117.133.51.44]) by smtp.feishu.cn with
 ESMTPS; Thu, 13 Jun 2024 14:51:54 +0800
X-Original-From: xiangwencheng@dayudpu.com
To: <qemu-devel@nongnu.org>
From: =?utf-8?q?=E9=A1=B9=E6=96=87=E6=88=90?= <xiangwencheng@dayudpu.com>
Subject: [PATCH] vhost-user: Skip unnecessary duplicated
 VHOST_USER_SET_LOG_BASE requests
X-Lms-Return-Path: <lba+2666a970b+30c3b6+nongnu.org+xiangwencheng@dayudpu.com>
Cc: <mst@redhat.com>, "BillXiang" <xiangwencheng@dayudpu.com>
Date: Thu, 13 Jun 2024 14:51:50 +0800
Mime-Version: 1.0
Received-SPF: pass client-ip=209.127.230.16;
 envelope-from=xiangwencheng@dayudpu.com; helo=va-1-16.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 13 Jun 2024 09:29:14 -0400
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

From: BillXiang <xiangwencheng@dayudpu.com>

The VHOST_USER_SET_LOG_BASE requests should be categorized into
non-vring specific messages, and should be sent only once.
If send more than once, dpdk will munmap old log_addr which may has been used and cause segmentation fault.

Signed-off-by: BillXiang <xiangwencheng@dayudpu.com>
---
 hw/virtio/vhost-user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index cdf9af4a4b..41e34edd49 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -371,6 +371,7 @@ static bool vhost_user_per_device_request(VhostUserRequest request)
     case VHOST_USER_RESET_DEVICE:
     case VHOST_USER_ADD_MEM_REG:
     case VHOST_USER_REM_MEM_REG:
+    case VHOST_USER_SET_LOG_BASE:
         return true;
     default:
         return false;
-- 
2.30.0

