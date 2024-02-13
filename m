Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AEBC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyem-0002Wj-9C; Tue, 13 Feb 2024 14:41:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyek-0002W4-LO
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:41:26 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyej-0006G2-9x
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:41:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uLiM6plWEwzlkiZfu7sRaC/5jsVXGWNfxKLn+cAJ7PQ=; b=WEh8QXyUuCRcGXmvViGGH+SW+L
 9qEdSeoOYGDknC5ePJqk49f3Cb7s8prgdgRstXBfoKw4J89RE9rOT9Veiwts8l8kpu88UtNbld2nN
 q+lwODWjXqTLvrZsQpGsUEAVTs9TCh8e6wikHzUQwD9E596grcK+39F9K+WhHf7wD6UBuJxYZ9PM4
 tIDo9L9NIVs5lnVJMlf3ZokgZ7MJqW6GHabvfcer3XYCjKy2a5oz+lODeENFEh/oxHc1ZJsBhui31
 NgwctbkaXN+ZM4V2C7u4hk7YGcIKjB79h6j041IxHfFZDbd4G8KiGIV1JHXGu/jCb3IPyKZqtB5dh
 JDTjzF1faHPpk0wSsmG0zzWO9QzH6LAmftgRZOd9t22ahN+NSdzFpX1/v2aebHLvadHgTl8vWvWw+
 7ZUy/vZa0N1teRe/9kUWnJKvrQuxXxXiZx/cbEzb5Q/2c+Gkj+W4rJh4Nq1sET4gv1mCCIZ/DmLuI
 uSXY5lxh1oriAnS6Jj1L9qnQsBSnDGmB1YeNJk+KuBNrKX2qOmNuJmeIDhsWAtVi85+HnmUTnnWra
 vXsmxRHVow/3uqcG5wfJjwbE8nBt/a9g5YjYTsQL/X5AM2MTM4uvv2o+7zNuO6lH6+xRGoqc8TSun
 Ny9qPZWga21etqJOISI4XSn40HkJPXgfAkrjIH11o=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZye0-0008m4-Jg; Tue, 13 Feb 2024 19:40:44 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:30 +0000
Message-Id: <20240213194052.1162753-7-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 06/88] esp.c: update esp_set_tc() to set STAT_TC flag
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

This flag is set once the transfer counter counts down to zero.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-7-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 8c1c6bfc1c..c7b79a2949 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -161,9 +161,15 @@ static uint32_t esp_get_tc(ESPState *s)
 
 static void esp_set_tc(ESPState *s, uint32_t dmalen)
 {
+    uint32_t old_tc = esp_get_tc(s);
+
     s->rregs[ESP_TCLO] = dmalen;
     s->rregs[ESP_TCMID] = dmalen >> 8;
     s->rregs[ESP_TCHI] = dmalen >> 16;
+
+    if (old_tc && dmalen == 0) {
+        s->rregs[ESP_RSTAT] |= STAT_TC;
+    }
 }
 
 static uint32_t esp_get_stc(ESPState *s)
-- 
2.39.2


