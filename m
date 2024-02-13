Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744F8C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyft-0005Em-33; Tue, 13 Feb 2024 14:42:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfr-000550-6q
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:35 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfp-0006OA-OZ
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1nMvqXh1NHBqZnJ3Ay1RbxNHeCYbCSC3uTLrwTaNqtA=; b=0KieOt/Ejmzx160tJ9JFO5wMX4
 qXlvllAgWj+FeHO/6vWzhTCKF+dO7f6N1yeA3VKK6mpJAS8IeHAakpZmU39VPN9Pg3VuZbSLp/RcF
 AHL26wkUIsjE2y3S+pzZEq4k6xUaM3/habXgkKw7XM7JjqvoCchgGXPmjbugE90QjycQXA4S6PsdJ
 Hoxo4Hmtum/R0/Zv63Icf8qlQ4+sBliZFn+qK+oCPGOlFiwMxBb0mNJ8ItJOYSkdcuIQj/CqUNt9J
 KBo6gxUf2/yP6amRU/HxpdMC7pN3rpElQlyIlRezkfInKVUsi6kAAa85dqXblUJxIXt7qtoMHgWeC
 RLr6OjIN3vV4JgOsD9VPhTf7xzKVi6WFdJv6le1BOwS2UcBTqBDo+7tyyfXk7R99++q/ipxxzC6Mq
 wQFo8OduIWLQkZgm/AfIHTLovJSrme3bskYhKTdqiN7vgSbxD5gRlyoendxKObYe/Qi43qNtZTs83
 GRk4NbxOObEBuDhuzZKcz355u0kGDuGk2ZQQOrMPQ1ASAbQ8FyJZgn/clZSYoGkfiviS+PMAgmCLa
 8ve5PuEcJXFcmHgM+CGUNit2BP60eAALt3RCrJen3EZ4rtNq9fRqcSsZjKtpUjhCZL7c+3uD2wXjt
 nuOeaGdO9g2l3LRmUsiJxOpDrCk+Icc6pJzgcu4PQ=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyez-0008m4-Dy; Tue, 13 Feb 2024 19:41:43 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:47 +0000
Message-Id: <20240213194052.1162753-24-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 23/88] esp.c: don't immediately raise INTR_BS if SCSI data
 needed in esp_do_dma()
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

In the case when more data is requested from the SCSI layer during a DMA data
transfer from a device, don't immediately fall through to the TC check logic.
Otherwise when TC is zero INTR_BS will be raised immediately rather than when
the next set of SCSI data is ready.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-24-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index d80a38daa0..1f9902aec0 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -745,6 +745,7 @@ static void esp_do_dma(ESPState *s)
 
             if (s->async_len == 0) {
                 scsi_req_continue(s->current_req);
+                return;
             }
 
             if (esp_get_tc(s) == 0) {
-- 
2.39.2


