Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C6CCD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 05:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMIyL-0002KN-Ej; Mon, 11 May 2026 01:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wMIyF-0002Jv-V5
 for qemu-devel@nongnu.org; Mon, 11 May 2026 01:14:23 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wMIyE-0002ib-C1
 for qemu-devel@nongnu.org; Mon, 11 May 2026 01:14:23 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-835399c11e0so1677816b3a.0
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 22:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778476459; x=1779081259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uY/3BCvApSqhWXajAFICkCmRzs5yfB4pXNodUvVTC58=;
 b=V56yfZ+yivnxEr/H3gV9dmnW3ZrsNeQisN7Xp5Nd8UwaoA10QGnMpjsLx0sJdfzP11
 DNG+Zf8j/kNrjdZrBXPAMP9HQ9b1X/Pu9GHbTewBLoYSSb6zz8WCM981faxG0r9cDxEv
 x5tRoqtMUFUXZ3pw8/eWfA4dJEH/rvk+NC2WARaDITvcP5Ujz+8BPtA3F/H4NEAcZeGI
 DLQ2Qb0mgk4sAUeYwcFdpRajcUppDYfjZSYzSlKB8OTf8pIizmUdjFL8+IVEPxv1yu1C
 9n5TT8SfNHAmEUUFaI+JCFknfpdJ+PP/ZfxX7+S6DD7/B21ewzxBaVV5nxVC6kJsNO0H
 jFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778476459; x=1779081259;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uY/3BCvApSqhWXajAFICkCmRzs5yfB4pXNodUvVTC58=;
 b=Ty4X9DoS2HYMwRq/tPQuHMebUybvMBAPrKJjnaNBXONTxIXXiVDBXsmDyTOI6tRSeC
 JRoUd7vhlyce+Thy5MmsqsQ1S9PD7J9kWSxfrWvhTlz4He6W5u3Q3KYw/pPjxSJIDd21
 8GKWcu+SJzuMk0/7bkAyb0712WmvA3MpmE+1oDNiXK/fdLGWxhOlqGuNaNgBTS9BJDEd
 VcB14MQoYe7d2VmtULR0tLm8ePjHBKMt477BZb8ZK8/oyyZdxTF28+2mgGJmeWwAVOzV
 sz8cnAD3LjtzWjB+sSHKgjtobt6gnvO2EukIV55RDcH9zDhoh9LXpR5KJ3LsFQDlJXJY
 FF8g==
X-Gm-Message-State: AOJu0YwSKwYaDFhxHM/9Jj7UFQhT5mICZy3jRmaQPlBU7pDbnpe2xSpi
 lkdVkTakubw72yVW+yClckbW0ucq5gcxX3GSu8C3N6RxsawMh1c1JNrrfCA7dA==
X-Gm-Gg: Acq92OFhtMVjxz6l4MaDub9KrQgeFW3gjeC6CVbNet7Dr+3/13ZiKUfbZCrvxrs2LN7
 zYYP+r/rOSN0coKEYBTed0gk1GvtUQ2TuJXKeVLy319xMsBdqTSwWdYzsjRpL6KbollOsB8dAZN
 caIy4bRIYKssisIcNoE0JZ/MYSxj4yz2a+V+Be5QysySiMNOCAPSiNeVbc4hemlKSJWS+dvcSlX
 wKbBoaX3mqh0iCl+NqIrrMJejWBMhsfhtLiFp7MZx1g4npWxtJi6K9GdY8/JPJquLfSDbvxjRLh
 SOLWBE0tdkS48Sbeex56l8cmh4stJKXMPitG8zhl09nakSNOJQ6mq3j+F9iXAKxVC26U0N9DVnL
 OQitmpYg/I6+IO5qXzj3iG1xFSCGYcHCkUEN5vpF7Pk/nKdjm753Zjx4Kj8lCOvJ45MzbakEBKm
 LDkAVwLu0AGWlvzI4fSJ+MJ4713n2GawA=
X-Received: by 2002:a05:6a00:278e:b0:837:e9cc:d46d with SMTP id
 d2e1a72fcca58-83a5e24add1mr20835333b3a.44.1778476458724; 
 Sun, 10 May 2026 22:14:18 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-839679c9293sm18655775b3a.33.2026.05.10.22.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 22:14:18 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 j-young.choi@samsung.com
Subject: [PATCH] hw/ufs: Zero reserved bytes in REPORT LUNS response header
Date: Mon, 11 May 2026 14:14:09 +0900
Message-ID: <c6bc0c611cf43f3d75bb6459362f71666d3b4240.1778476327.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

ufs_emulate_report_luns() writes the 4-byte LUN list length into
outbuf[0..3] via stl_be_p() but leaves outbuf[4..7], the reserved
field, uninitialized. Those bytes are then DMA'd to guest memory,
leaking uninitialized QEMU stack data.

Fixes: 7708e298180 ("hw/ufs/lu: skip automatic zero-init of large array")
Cc: qemu-stable@nongnu.org
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/lu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 3f3c9589ce..709d6adcf6 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -101,6 +101,10 @@ static int ufs_emulate_report_luns(UfsRequest *req, uint8_t *outbuf,
         return SCSI_COMMAND_FAIL;
     }
 
+    if (outbuf_len < 8) {
+        return SCSI_COMMAND_FAIL;
+    }
+    memset(outbuf, 0, 8);
     len += 8;
 
     for (uint8_t lun = 0; lun < UFS_MAX_LUS; ++lun) {
-- 
2.43.0


