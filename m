Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6A6C0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 14:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcPxF-00005q-IB; Mon, 27 Jan 2025 09:19:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcPxD-0008Vs-KN; Mon, 27 Jan 2025 09:19:07 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcPxC-0002OX-3M; Mon, 27 Jan 2025 09:19:07 -0500
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by isrv.corpit.ru (Postfix) with ESMTP id 3BB40E0E31;
 Mon, 27 Jan 2025 17:18:40 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id A0C3151D9F; Mon, 27 Jan 2025 17:18:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Keoseong Park <keosung.park@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jeuk Kim <jeuk20.kim@samsung.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.1 29/41] hw/ufs: Adjust value to match CPU's endian format
Date: Mon, 27 Jan 2025 17:17:43 +0300
Message-Id: <20250127141803.3514882-29-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
References: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Keoseong Park <keosung.park@samsung.com>

In ufs_write_attr_value(), the value parameter is handled in the CPU's
endian format but provided in big-endian format by the caller. Thus, it
is converted to the CPU's endian format. The related test code is also
fixed to reflect this change.

Fixes: 7c85332a2b3e ("hw/ufs: minor bug fixes related to ufs-test")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Keoseong Park <keosung.park@samsung.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Message-ID: <20250107084356epcms2p2af4d86432174d76ea57336933e46b4c3@epcms2p2>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 4572dacc33e232a7c951ba7ba7a20887fad29e71)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 79f786ed4e..7862bba908 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -1164,7 +1164,7 @@ static QueryRespCode ufs_exec_query_attr(UfsRequest *req, int op)
         value = ufs_read_attr_value(u, idn);
         ret = UFS_QUERY_RESULT_SUCCESS;
     } else {
-        value = req->req_upiu.qr.value;
+        value = be32_to_cpu(req->req_upiu.qr.value);
         ret = ufs_write_attr_value(u, idn, value);
     }
     req->rsp_upiu.qr.value = cpu_to_be32(value);
diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 60199abbee..1f860b41c0 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -145,7 +145,7 @@ static void ufs_send_query(QUfs *ufs, uint8_t slot, uint8_t query_function,
     req_upiu.qr.idn = idn;
     req_upiu.qr.index = index;
     req_upiu.qr.selector = selector;
-    req_upiu.qr.value = attr_value;
+    req_upiu.qr.value = cpu_to_be32(attr_value);
     req_upiu.qr.length = UFS_QUERY_DESC_MAX_SIZE;
     qtest_memwrite(ufs->dev.bus->qts, req_upiu_addr, &req_upiu,
                    sizeof(req_upiu));
-- 
2.39.5


