Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6BDC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 03:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1Qt-0002qF-Jx; Thu, 09 Jul 2026 22:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Qk-000287-Cd
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:36 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Qh-00007L-PX
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:33 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2c9bd2f8bf7so21243545ad.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652249; x=1784257049; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wFcyBuULSrHpxA728TqDcprGW+Y5ZM2AX0B1lV73vvM=;
 b=fyNQVRuqq4Etz4uVd2r1Kq7IwV+WP03lAqANK/5tA4IsWA2YP7edSsvqNznxSeaq4C
 k1NNPfswQcpvZXPebpMH76lj/6O+QffpIFPj+5/g7Zkp07PsHfdG0bbyalj3sfRUSiYX
 +uuyO+5/Eq0QG+p5FzJTKD3/KXqCX18t3ts/TCJqV8iGxZuvLaRFMmY/CGlu85husX5+
 P0a94ueB+f8XROStsz3+qVKxE26FdMTCKrTITYppstBLDzyrkPc5wDVMoiFTKVCRH3U/
 LQWFyJFb5mPyyaiAdXZ4wlOGpZgaRlZ8+1cTYXgJ58xtwrcTc7NKFMWKrZH8ZLxScAtz
 eipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652249; x=1784257049;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wFcyBuULSrHpxA728TqDcprGW+Y5ZM2AX0B1lV73vvM=;
 b=KbSjQplo/VK2JMZfDz4ZlKww/DnIu7po/CjJ7Lt+ElHmJYQbeBzghZXJ4J8FYwpj9z
 rRs/i5oGdORHFvKI9Y9i38WdxmG/+b0ytoSsniMynWZplCjWrqcc5AQO7bplnYT8TGil
 LU80Hfh5pcKQnFR2S8DzUeK7SFHO7SQeq/G6jYdWLCtyPqiSrpROzmfrcl5vX2cMh9Mv
 q/dxxeSSBvDNw4OyXB0bOed+Yp8aVC8EZkdpBOX1Cj+mjDdoJyDHiEWgVVxvnMCV1/V6
 8LuJ2tAQ6di1VLaCfcS6v2zfdFnSJKVX2CA53I6ZLnKrHz+RdwNlCaMKmDlLD3qMUMFB
 O0cg==
X-Gm-Message-State: AOJu0YyCJ0gson/qkqs+ZPxRxVKlNBnoqp4IsV3C2yxAd7Lo6PKyyFIz
 Dg4SmKdCxeBTtGOTaKnJdC7nHTwpGSbItKwAnPj/eAV7xORBH8GHTFI198f4/w==
X-Gm-Gg: AfdE7cmN/fAy7zVuRqyjcigkXxZUutsjHaaI9FibibcqIBSezXgipPXUJZe1bSetepZ
 BuHwvOYHIOylIsrdkAeIkJ/Ix9smiBbBEC4B6lU7J6nGdRjRpRRgmfyi/gSQEfCOLbIkn2lTPYJ
 hsKeFAtyfEDvgIC1TUIi3Btfkq5tjI6MnNeyFjFQUcGrB2PnKaQ70fH2fIB99MhtRXJ6BTLYYak
 hGg3QPawO2MHVNwZ9v1NZJbsNPRSd7aHjSzvmU1OyTblE/L265x841fEfeu7PE7/Dg1evDQ8jDw
 dyZlMQdYDEJ3fsfBdpurAQJfmX2VpJ33n60k4ZjLlyW6ed8GBVVhUa6U7432V2X72sC6pGljMHx
 1WMAp9sOooux3z+j62GoMUJq8OptwCWj7o9TB7m6pNS1TVhZaqWGtE3Oyg+ZOHTEz70XZs4xoc8
 8bQHuBE3sq8vRZOzRJdTYhFj8JxnDkELIDnYu+f8dlVA==
X-Received: by 2002:a05:6a21:7e83:b0:3bf:bde7:d67d with SMTP id
 adf61e73a8af0-3c0f112453emr1494008637.1.1783652249480; 
 Thu, 09 Jul 2026 19:57:29 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:57:28 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PULL 35/40] hw/pci/pcie_doe: Check mailbox length for overflows
Date: Fri, 10 Jul 2026 12:55:20 +1000
Message-ID: <20260710025525.1704417-36-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Alistair Francis <alistair.francis@wdc.com>

It was possible that a guest could overflow the `doe_cap->write_mbox`
buffer by writing more then PCI_DOE_DW_SIZE_MAX dwords.
`doe_cap->write_mbox_len` would continue to increment and there were no
bounds checks on the length when offsetting into doe_cap->write_mbox.

This patch adds a check and reports a guest error if we would overflow.

On an overflow we also silenty discard the entire object as instructed
to do in the PCIe spec when the length specified in the header
(up to PCI_DOE_DW_SIZE_MAX dwords) doesn't match the length of the
object.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3679
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Tao Tang <tangtao1634@phytium.com.cn>
Message-ID: <20260707020750.788960-1-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/pci/pcie_doe.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/hw/pci/pcie_doe.c b/hw/pci/pcie_doe.c
index 2210f86968..1bc2b45781 100644
--- a/hw/pci/pcie_doe.c
+++ b/hw/pci/pcie_doe.c
@@ -78,14 +78,21 @@ static bool pcie_doe_discovery(DOECap *doe_cap)
     return true;
 }
 
+static void pcie_doe_reset_write_mbox(DOECap *st)
+{
+    st->write_mbox_len = 0;
+
+    memset(st->write_mbox, 0, PCI_DOE_DW_SIZE_MAX * DWORD_BYTE);
+}
+
 static void pcie_doe_reset_mbox(DOECap *st)
 {
     st->read_mbox_idx = 0;
     st->read_mbox_len = 0;
-    st->write_mbox_len = 0;
 
     memset(st->read_mbox, 0, PCI_DOE_DW_SIZE_MAX * DWORD_BYTE);
-    memset(st->write_mbox, 0, PCI_DOE_DW_SIZE_MAX * DWORD_BYTE);
+
+    pcie_doe_reset_write_mbox(st);
 }
 
 void pcie_doe_init(PCIDevice *dev, DOECap *doe_cap, uint16_t offset,
@@ -356,8 +363,20 @@ void pcie_doe_write_config(DOECap *doe_cap,
         if (size != DWORD_BYTE) {
             return;
         }
-        doe_cap->write_mbox[doe_cap->write_mbox_len] = val;
-        doe_cap->write_mbox_len++;
+        if (doe_cap->write_mbox_len < PCI_DOE_DW_SIZE_MAX) {
+            doe_cap->write_mbox[doe_cap->write_mbox_len] = val;
+            doe_cap->write_mbox_len++;
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Mailbox write length (%d) overflow\n",
+                          doe_cap->write_mbox_len);
+            /*
+             * Too much data has been written, it can't
+             * "match the Length indicated in DOE Data Object Header 2"
+             * so we drop the entire object.
+             */
+            pcie_doe_reset_write_mbox(doe_cap);
+        }
         break;
     case PCI_EXP_DOE_CAP:
         /* fallthrough */
-- 
2.54.0


