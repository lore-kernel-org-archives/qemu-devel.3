Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FD8C35FF0
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 08:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqTHn-0004q6-3E; Tue, 17 Sep 2024 04:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1sqTHi-0004Y2-Ci
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 04:10:07 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1sqTHf-0002rX-SJ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 04:10:05 -0400
From: Dmitry Frolov <frolov@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1726560600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=bD3PljUXA5AgbaFwmp771Sub/ppxgBtrHoC3nWQ7cXo=;
 b=rT7oXXmnzWFpd4aSrLQ1iOdWEag/3VpICuJq8spkL86oENmMXkS3JjxWtTFfQAQn4ZfFL0
 +Lwh4BJreHb78Kz0b8rWaqmmKSfotQI9sP6+CW6HO4em0GjjqEbtQiaBkOXjBjz8X8nqLG
 82En6znONMO/bypDhENiaf59wXljaMA=
To: jonathan.cameron@huawei.com
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org, fan.ni@samsung.com,
 Dmitry Frolov <frolov@swemel.ru>
Subject: [PATCH] hw/cxl: fix uint32 overflow cxl-mailbox-utils.c
Date: Tue, 17 Sep 2024 11:09:16 +0300
Message-ID: <20240917080925.270597-2-frolov@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The sum offset + length may overflow uint32. Since this sum is
compared with uint64_t return value of get_lsa_size(), it makes
sense to choose uint64_t type for offset and length.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
---
 hw/cxl/cxl-mailbox-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 9258e48f95..9f794e4655 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1445,7 +1445,7 @@ static CXLRetCode cmd_ccls_get_lsa(const struct cxl_cmd *cmd,
     } QEMU_PACKED *get_lsa;
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
-    uint32_t offset, length;
+    uint64_t offset, length;
 
     get_lsa = (void *)payload_in;
     offset = get_lsa->offset;
-- 
2.43.0


