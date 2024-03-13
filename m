Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB99C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 08:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkKRj-0007aV-Rf; Wed, 13 Mar 2024 04:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKRi-0007Zm-5w
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:58:46 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKRg-0002Ci-O6
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8ou60ZFfGz5wGuATfQwlf3o/Sr8yITEBKcHYAHL8PJg=; b=nRm+swVMS5GtExiogDX+ko214U
 ZUavRH1cqgLILijo9cmVatQGZYQWkiXjD4L/WpvtOX87yFwVVKVpXlUlo56nmYxf2pWvpZIlm14Pr
 cqTiSnaXE38hdIkwhF7ID+9HMSS34gjmtFR7t89oO1ONEFPS1GQXDxQ29xPFEv+7MooWoRikdwnBv
 y6sThI4CQ4Yc35oPKFkOL50g2MxKLDos9LHOWu9f+ggFvvK+y8sW78Oj6QSgsdMNcMkC1JcG4LJen
 DZ9wQSwKqI+JDzOPW5PUpg4/5/WLQgoN5SvWZng7TpPqZZGgqRnikh1ki3RODzFwAL5j5SPSTshRc
 y34E+8W+LC7CpBOMwU3TO2L4z+OtEx8/2iXRXMvRrYjkJx9zyw6WdUAG3RGunAnCQZllVqiil/ouL
 uh/qiaYQAMQw0mG2VWiNZu8JjGtbPb9/orECuR2QwDM/AdhwQD302JmRf7hg1IVIOWUq8pZ9dseGw
 OGoy6l4Q8e5hR45iVH47D7km7SVdW+y0x+xJKlJEX9UjalFGZn2mys8lGw2i1VyTo4foZFkz2+WQf
 lxa/gnkMf5AACpPvYJb5M6SXzF9C6eus2ZaKxrzNYQ6/3urv5ii/CWuWu0HyuUXHNcsVbf0gooW1V
 OLnawhpRAkFqS0MzSsY+ZgJDaD1u76VN46RSh4OQ4=;
Received: from [2a00:23c4:8bb3:1000:1218:d855:1998:7fa8]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKQl-000CUN-9d; Wed, 13 Mar 2024 08:57:51 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Wed, 13 Mar 2024 08:57:55 +0000
Message-Id: <20240313085810.2655062-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:1218:d855:1998:7fa8
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 01/16] esp.c: replace cmdfifo use of esp_fifo_pop_buf() in
 do_command_phase()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The aim is to restrict the esp_fifo_*() functions so that they only operate on
the hardware FIFO. When reading from cmdfifo in do_command_phase() use the
underlying Fifo8 functions directly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 590ff99744..f8230c74b3 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -265,7 +265,7 @@ static void esp_do_nodma(ESPState *s);
 
 static void do_command_phase(ESPState *s)
 {
-    uint32_t cmdlen;
+    uint32_t cmdlen, n;
     int32_t datalen;
     SCSIDevice *current_lun;
     uint8_t buf[ESP_CMDFIFO_SZ];
@@ -275,7 +275,7 @@ static void do_command_phase(ESPState *s)
     if (!cmdlen || !s->current_dev) {
         return;
     }
-    esp_fifo_pop_buf(&s->cmdfifo, buf, cmdlen);
+    memcpy(buf, fifo8_pop_buf(&s->cmdfifo, cmdlen, &n), cmdlen);
 
     current_lun = scsi_device_find(&s->bus, 0, s->current_dev->id, s->lun);
     if (!current_lun) {
-- 
2.39.2


