Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA46C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 05:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti4vg-0004Sz-8Z; Wed, 12 Feb 2025 00:04:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1ti4vb-0004Se-Sh
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 00:04:52 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1ti4va-0004K0-1Q
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 00:04:51 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-220c4159f87so530825ad.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 21:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739336688; x=1739941488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hfTjLdtBZ0T9sRrReah6th4d50zosHKErYKDzEctLuM=;
 b=By2lmalu8/coEjd+cGEKCSFiOYEvM8IlxoCYiU4joDIgCuY2pQgKzXzVYYDP1vjBnd
 0VgmKbMQ1UQyuAmoFdKi4NsJGGAruaK6BWpyO0ECYo+TgWWnPviIgZF3PNykdhWTbZSM
 k9BbADmoPLke7/041DXzytSIbSg1F8OD5nFeaLUawHE6iEpejVM4Opxaj/Y7Lg2Rotun
 fk7gC5rP/FqF4tz3IvRJYxFsgfkaSOAWMBu9Xng3q8lGVrPGTZ3LsESSfDLqY+Z+qduy
 LczGnclaLlsLStCrI2EeZBOLFgNP2nFG9Y8rgJSMJwcUNKay5A5Tq13es6DpwPqYyQeY
 ImKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739336688; x=1739941488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hfTjLdtBZ0T9sRrReah6th4d50zosHKErYKDzEctLuM=;
 b=MkMAb4UG4KcKMPbGdoH38YgtWQ6mvwNtjwKUf+o131lGaxpdK9Pz0UrjxYjR6kmFld
 hhFr3fexDEzoItIp2dJpave6eAs3kwXt09m4PChqiYBW+FYCWeSgqDIGjfInh5AML1s5
 /uI7OP0bMQbuMFRetYGfMXeXoMZuYDnxNcFScPhhr0TuDpBEN2a54gArPRmg+kNi5qC9
 UzIeh6cYrp53qHxixBqDIfyXELRbwUAopUc4RmxdZw4/pqLhSfp3yiknFZAdsSndoSNX
 gbqZDEUk35HfNVx+iWGLSfYX7LmWrj7k2Nw44bZrU0YG0VbSCeG+CVFEJndodoLOWgjO
 +THA==
X-Gm-Message-State: AOJu0YyraB7Q6fr9jZ7tSLvZ24QTv//8tGgxaKkzoozrf51//PWe7JIC
 vj1xHdKGt6JYD57XhzK3joC5xYu4D0K79lTRYQavl+42g684Fe3I
X-Gm-Gg: ASbGnctFi9RiaZtAK1KPKmEH1YptQKc0TBtZ9VGvMaPOEVEg2OV/6IAS43YtIRE3xOA
 nl/t3a7enkiKM8xJE4PAIhTQjazWF5RyHQlj+jgIWOPGPmUA2KCGIgq9ZKj8aZWH1swuQD5T9iD
 nwvUk5aY0QsX6tYUjeHzlEIH5i0gbESQM8PrO0Y2t2ANSVfjJaAjGJ81oKvOiCUg/KuDHH6+uRl
 joSKrzoa7R8K9MVLsHxzMZaiwv49odVcetUUdD/LO59zKev8fmoDQ7ijEB8q4S07etOJjgYDntH
 35HqgzHtM+wXM34uGHGeDQ==
X-Google-Smtp-Source: AGHT+IES4gzs/gY/CrJRwVVt9AJv/4iSreijLYm02ACdtbzvitPyhJNL2RbasE5gtSTZ2ynWU2Su0Q==
X-Received: by 2002:a05:6a00:c90:b0:730:9567:c3d5 with SMTP id
 d2e1a72fcca58-7322c371b32mr2406736b3a.4.1739336688283; 
 Tue, 11 Feb 2025 21:04:48 -0800 (PST)
Received: from jeuk-MS-7D42.. ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048bf1421sm10480602b3a.101.2025.02.11.21.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 21:04:47 -0800 (PST)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: jeuk20.kim@samsung.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, j-young.choi@samsung.com, keosung.park@samsung.com
Subject: [PATCH 1/3] tests/qtest/ufs-test: Cleanup unused code
Date: Wed, 12 Feb 2025 14:04:19 +0900
Message-ID: <a65608d3affdadae8286ecee0c1ec13037427cf5.1739336154.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739336154.git.jeuk20.kim@samsung.com>
References: <cover.1739336154.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Removed dead code related to the unimplemented task
management request.

Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 tests/qtest/ufs-test.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 1f860b41c0..ce8b398c6b 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
-#include "qemu/units.h"
 #include "libqtest.h"
 #include "libqos/qgraph.h"
 #include "libqos/pci.h"
@@ -35,7 +34,6 @@ struct QUfs {
     QPCIBar bar;
 
     uint64_t utrlba;
-    uint64_t utmrlba;
     uint64_t cmd_desc_addr;
     uint64_t data_buffer_addr;
 
@@ -257,7 +255,7 @@ static void ufs_send_scsi_command(QUfs *ufs, uint8_t slot, uint8_t lun,
 static void ufs_init(QUfs *ufs, QGuestAllocator *alloc)
 {
     uint64_t end_time;
-    uint32_t nutrs, nutmrs;
+    uint32_t nutrs;
     uint32_t hcs, is, ucmdarg2, cap;
     uint32_t hce = 0, ie = 0;
     UtpTransferReqDesc utrd;
@@ -305,7 +303,6 @@ static void ufs_init(QUfs *ufs, QGuestAllocator *alloc)
     hcs = ufs_rreg(ufs, A_HCS);
     g_assert_true(FIELD_EX32(hcs, HCS, DP));
     g_assert_true(FIELD_EX32(hcs, HCS, UTRLRDY));
-    g_assert_true(FIELD_EX32(hcs, HCS, UTMRLRDY));
     g_assert_true(FIELD_EX32(hcs, HCS, UCRDY));
 
     /* Enable all interrupt functions */
@@ -326,20 +323,15 @@ static void ufs_init(QUfs *ufs, QGuestAllocator *alloc)
     /* Enable transfer request and task management request */
     cap = ufs_rreg(ufs, A_CAP);
     nutrs = FIELD_EX32(cap, CAP, NUTRS) + 1;
-    nutmrs = FIELD_EX32(cap, CAP, NUTMRS) + 1;
     ufs->cmd_desc_addr =
         guest_alloc(alloc, nutrs * UTP_COMMAND_DESCRIPTOR_SIZE);
     ufs->data_buffer_addr =
         guest_alloc(alloc, MAX_PRD_ENTRY_COUNT * PRD_ENTRY_DATA_SIZE);
     ufs->utrlba = guest_alloc(alloc, nutrs * sizeof(UtpTransferReqDesc));
-    ufs->utmrlba = guest_alloc(alloc, nutmrs * sizeof(UtpTaskReqDesc));
 
     ufs_wreg(ufs, A_UTRLBA, ufs->utrlba & 0xffffffff);
     ufs_wreg(ufs, A_UTRLBAU, ufs->utrlba >> 32);
-    ufs_wreg(ufs, A_UTMRLBA, ufs->utmrlba & 0xffffffff);
-    ufs_wreg(ufs, A_UTMRLBAU, ufs->utmrlba >> 32);
     ufs_wreg(ufs, A_UTRLRSR, 1);
-    ufs_wreg(ufs, A_UTMRLRSR, 1);
 
     /* Send nop out to test transfer request */
     ufs_send_nop_out(ufs, 0, &utrd, &rsp_upiu);
@@ -370,7 +362,6 @@ static void ufs_exit(QUfs *ufs, QGuestAllocator *alloc)
 {
     if (ufs->enabled) {
         guest_free(alloc, ufs->utrlba);
-        guest_free(alloc, ufs->utmrlba);
         guest_free(alloc, ufs->cmd_desc_addr);
         guest_free(alloc, ufs->data_buffer_addr);
     }
-- 
2.43.0


