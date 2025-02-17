Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5346C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 09:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjxQU-0001oF-QA; Mon, 17 Feb 2025 04:28:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1tjxQM-0001nP-Fc; Mon, 17 Feb 2025 04:28:22 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1tjxQK-0000uC-Pg; Mon, 17 Feb 2025 04:28:22 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2fc20e0f0ceso5018539a91.3; 
 Mon, 17 Feb 2025 01:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739784498; x=1740389298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EbMv2dkOrEFHvUHvF6ZzowdWf/tdcr77orU+Pt2H9R0=;
 b=gg3XBAm0gguH2T71XcVHe7BymgL/7AT2cGeEvnXoaGUGBHfw2o3nn23/1MWHU4AGo0
 TmT8f10sq41IHkkGkDR0a/uyO+1Hgji+vlfIguOD8kxejGzVT3POsba30a6bS+MaTnyQ
 aWct/BR91ARmkILzPz0LuXpicCRR7JtcvhVEp3+bxDNw615OYCBe8KyciJHl0gsxrqAv
 bFOBLfFQmYiMouu7BA58X8UusdlqBoCKIplnzGvl3z9msmbluNUj7MbeUhyoaUiWdWIm
 UjSUEmAUVF9LMW8X7cNoU0W8LZx3SfNk7ywwFD5QMbZi/ftCQTGo5RIXEEwZ0XCMmT+8
 Guhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739784498; x=1740389298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EbMv2dkOrEFHvUHvF6ZzowdWf/tdcr77orU+Pt2H9R0=;
 b=ebXvHk/6NhMU4lxCUSdQA/ss+r2AcOavoPcM5Lv2ECVmhZ1P6E2dgB+8NbgnktgPHH
 SDy1vkHs97r/ujHDurBA3aYqLGTXHR7WNagb/AxnB/oF9En/O22jTCTpBxdpYF0byhed
 ysOjXMhW5gLxwd5qW3MVIiJHhTg+WNy0MXVuJFzPmZ/oS6aRglazRBs+1zQibO/qgL2Q
 p2UqqKvrnCTC5deoFmJdrUK+2PHANY9D3T4hXxJ/7NyqNDsQbeLDpcuidp2Exmkj7KmX
 yAguMjGwND0a7LqOb2U+oPVfuHmB25FpA8Stci4p4+avW23FtH/kP6qIm75JNa8pc59N
 At4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0+e0PVZeUBRfbxwUp4aX7Ty5IFFdDBeQXARDh0k12IxGqayDVAeqpsu/mgSMha/bJK758slUV14c2@nongnu.org
X-Gm-Message-State: AOJu0Yz7di1pEofVXK6q710NMZB0LDhIjn1Qr2lQshHSs1HrSKobBLAC
 PrNGi+PsH8zxcFByYgJKMCO3vNRHdDoIh4NrSgW044plq+ylIyCrQEWcNg==
X-Gm-Gg: ASbGncsM5m5EpQ4BSa93bO6iteS9ZRCCl3sI/jlosJo5RXy/7amqQIQC+6Rh1pqkN26
 jAk4g105i9Mh/5f3fcAylqJFKxishKp0ZyfNYrDmjHNzv19SkdpDYJOsSjSq9Yne48Id1/6jlV0
 xsCSn9CjjrRg2NVjSRSWhECgnXPMrtGvlUGZ1CBe/G+D37XuhrOMON8TjVR7RWmvVpfRXTrjS/0
 NjuB5gEJjSpIIekOP0LTPuR6bVjPWuW2AM9YxXWVpsLg0SeBXB7JV3O1yf/9E203SvHwtUD1dRd
 4WvJSn+BiUaNhGw6V+M=
X-Google-Smtp-Source: AGHT+IG/iLiZ27v0EMN/usFhr2lCDl/2yQPI3uQuLAclIOU0xMB0q4wtoJbX+6j3vbaV3fdVsMR+Zg==
X-Received: by 2002:a05:6a00:1403:b0:730:87cf:a7cd with SMTP id
 d2e1a72fcca58-732617a1b47mr16247520b3a.8.1739784498256; 
 Mon, 17 Feb 2025 01:28:18 -0800 (PST)
Received: from jeuk-MS-7D42.. ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73265f98e18sm4152940b3a.106.2025.02.17.01.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 01:28:17 -0800 (PST)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com, farosas@suse.de, lvivier@redhat.com,
 Jeuk Kim <jeuk20.kim@gmail.com>
Subject: [PULL 2/4] tests/qtest/ufs-test: Cleanup unused code
Date: Mon, 17 Feb 2025 18:27:53 +0900
Message-ID: <e041d3d2165994311a6ee4bee6d1c7864ff81916.1739784105.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739784105.git.jeuk20.kim@samsung.com>
References: <cover.1739784105.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x1030.google.com
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

Acked-by: Fabiano Rosas <farosas@suse.de>
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


