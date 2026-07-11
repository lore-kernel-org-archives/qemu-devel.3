Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7B1C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifpD-0004nV-AA; Sat, 11 Jul 2026 18:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifox-0004Lk-NJ; Sat, 11 Jul 2026 18:05:15 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifov-0000Oo-An; Sat, 11 Jul 2026 18:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807181; bh=bCMVFGcS9pSFs0oWr3Jp9KED3QuIW9mi9PPpdkwK6MQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=pOWnKV697FTK7/i1BAYDxXQODzOf9MC2FKOl6+9cKdS2OQMMDzWZlVWkuVc30FFS+
 vc9DpsBpadP/U4htZyLFu/a+tRQRyzPra6eRXooNvxyuDIq14RcdYeWeeR3daEpvfM
 LgV2OyVFtQug9LsZm9a9ulTofFm/vL+R/LYI0aMKLy18QsjSAC1chjAhxjmQRjocH0
 P2OBvHIuU4ChI/x9nUfCPLVpH1PDh7F9k30fc8dC1eklJXcedc+r71k60ivYw+aRty
 3qWyZ2TtanlolpjFxSqH4aR9TPI8PI75bcksxnFMcCnOi3kDJ8v27gxKDhRY+BqmYe
 +vSk9hye78Kdw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6D9CB1C0AC5;
 Sun, 12 Jul 2026 00:59:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 24BA33EAF50;
 Sun, 12 Jul 2026 00:59:51 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C2F7713357; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Qing Wang <qinwang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 58/81] scsi: always send valid PREEMPT TYPE field
Date: Sun, 12 Jul 2026 00:58:36 +0300
Message-ID: <20260711215904.3757-58-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The SPC-6 specification says that the PREEMPT service action ignores the
TYPE field when there is no reservation. However, the LIO Linux iSCSI
target rejects commands with a zero TYPE field. The field never ends up
being used in this case, so replace it with a "valid" value to work
around the issue.

Reported-by: Qing Wang <qinwang@redhat.com>
Buglink: https://redhat.atlassian.net/browse/RHEL-155807
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Link: https://lore.kernel.org/r/20260401171927.396672-3-stefanha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 15a202656cd553911272f9666aa067c706fc3dfe)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index b55d0683238..349dea6bddf 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -453,6 +453,16 @@ static bool scsi_generic_pr_preempt(SCSIDevice *s, uint64_t key,
     uint64_t key_be = cpu_to_be64(key);
     int ret;
 
+    /*
+     * The LIO iSCSI target in Linux up to at least version 7.0 rejects PREEMPT
+     * commands with a zero TYPE field although the SPC-6 specification says
+     * the field should be ignored when there is no persistent reservation.
+     * Work around this by choosing an arbitrary valid PR type value.
+     */
+    if (resv_type == 0) {
+        resv_type = PR_TYPE_WRITE_EXCLUSIVE;
+    }
+
     cmd[0] = PERSISTENT_RESERVE_OUT;
     cmd[1] = PRO_PREEMPT;
     cmd[2] = resv_type & 0xf;
diff --git a/include/scsi/constants.h b/include/scsi/constants.h
index cb97bdb6362..717e470a5d4 100644
--- a/include/scsi/constants.h
+++ b/include/scsi/constants.h
@@ -340,4 +340,14 @@
 #define PRO_REGISTER_AND_MOVE                   0x07
 #define PRO_REPLACE_LOST_RESERVATION            0x08
 
+/*
+ * Persistent reservation types
+ */
+#define PR_TYPE_WRITE_EXCLUSIVE             0x1
+#define PR_TYPE_EXCLUSIVE_ACCESS            0x3
+#define PR_TYPE_WRITE_EXCLUSIVE_REG_ONLY    0x5
+#define PR_TYPE_EXCLUSIVE_ACCESS_REG_ONLY   0x6
+#define PR_TYPE_WRITE_EXCLUSIVE_ALL_REGS    0x7
+#define PR_TYPE_EXCLUSIVE_ACCESS_ALL_REGS   0x8
+
 #endif
-- 
2.47.3


