Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A4BCCF9E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 07:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBpLF-00044c-Ov; Thu, 23 Oct 2025 03:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan_salmon@163.com>)
 id 1vBorD-0001n7-2R
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 02:31:31 -0400
Received: from m16.mail.163.com ([117.135.210.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan_salmon@163.com>)
 id 1vBor7-0000vr-3I
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 02:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=x+
 KqWjhT+O7WNHy8kUjC6JCtlPmqZdIv2x4KUrDDi5Q=; b=AjR5YTL5iFc9nkQLLm
 qG8eCsNYpT0adnePTm3tD+rKI4U6puNq4bmFegCfG9X9I59NpV0CKvTky6X/H0Ri
 nUHL0X/lB56MebCXci6Y25cVn8Xm5lbDcL6ezMpz11Je70PmjJGD8Q3/xb32lHf6
 gS3B7cjVC0u1T3mwSrr2Ft8Rs=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wCXntWsy_loyhRSBw--.27046S2; 
 Thu, 23 Oct 2025 14:31:09 +0800 (CST)
From: zhaoguohan_salmon@163.com
To: kraxel@redhat.com
Cc: qemu-devel@nongnu.org (open list:All patches CC here),
 GuoHan Zhao <zhaoguohan@kylinos.cn>
Subject: [PATCH] hw/uefi/ovmf-log: Fix memory leak in hmp_info_firmware_log
Date: Thu, 23 Oct 2025 14:31:06 +0800
Message-ID: <20251023063106.9834-1-zhaoguohan_salmon@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCXntWsy_loyhRSBw--.27046S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw4DWFy8WF1DZryUXr48Xrb_yoWfArbEk3
 yUGFs7ur1rJrWY93Z8GFW0vFWYgw48Way8Gry2yw47Z34UtF12q3s7G34YqFy7W34UXrZr
 Jw1jqrZ8Aan5GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0jYLDUUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: 52kd0wpxrkt0xbvdzzlrq6il2tof0z/1tbiFA-vEGj5wuS8iQAAsm
Received-SPF: pass client-ip=117.135.210.2;
 envelope-from=zhaoguohan_salmon@163.com; helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 23 Oct 2025 03:02:13 -0400
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

The FirmwareLog object returned by qmp_query_firmware_log() was
not being freed, causing a memory leak.

Use g_autoptr to ensure the object is automatically freed when
it goes out of scope.

Fixes: c8aa8120313f ("hw/uefi: add 'info firmware-log' hmp monitor command.")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 hw/uefi/ovmf-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/uefi/ovmf-log.c b/hw/uefi/ovmf-log.c
index 98ebb0209491..850ef21f8859 100644
--- a/hw/uefi/ovmf-log.c
+++ b/hw/uefi/ovmf-log.c
@@ -261,7 +261,7 @@ void hmp_info_firmware_log(Monitor *mon, const QDict *qdict)
     g_autofree gchar *log_esc = NULL;
     g_autofree guchar *log_out = NULL;
     Error *err = NULL;
-    FirmwareLog *log;
+    g_autoptr(FirmwareLog) log = NULL;
     gsize log_len;
     int64_t maxsize;
 
-- 
2.43.0


