Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D20F588EF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 16:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wErNt-00081O-Ro; Mon, 20 Apr 2026 12:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1wErNZ-0007hq-Lu
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:21:49 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1wErNV-0003Yu-KN
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:21:43 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43d7605ec91so2983480f8f.3
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 09:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776702098; x=1777306898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jlbR+uwzdp2+lvyziz0wCYmj2F91tqT21v73CNtF/qY=;
 b=FXbhD+TXIWTj90MhJVIaurs7A4UVazzNHz8q7WVA9z5aO+pdGFDVWMvgDGdpXa4zYf
 FwheJHquMtwooQD1knFVMh9Tn+PMeGLm8boy9GnTaPhMjqddWYwtKNoIt2rJYLi7yM0U
 3hdbUVyuMvP+0K4XVcWqTDpFysHfaAqYJfl3fZPEDKP87UFrQKkJbnjzKUYJADVN7vTT
 mT0KuiVCsbnTt2J7/10UOYfI9k9Ubh3hMug8hhKpTZBzt4Kx2JuiCrdGkt0V1GhFyVyo
 e8seMvVaJUVv5NpPyBrXcsNDjgmkgz9+V+rSTmBB0ESBemKafMmlxNm1qgoEaMmRCma8
 gtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776702098; x=1777306898;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jlbR+uwzdp2+lvyziz0wCYmj2F91tqT21v73CNtF/qY=;
 b=ElJXrlH4Jt8LhSlkY+F6j5K1UnPWapV0cogPgXw2ayHaOovu9huk35vy0lH8qoJFAz
 NRNETx/St1g8UKqqDidSWFSf7NlXwymN+jr7BR6e6wfvUqm6eFXAc8IdstjQi3YUdOdN
 AMM70r2Z28R6j+rrKy4COfz+qrHTtgaUdBzdG2aW/CsQxQCyJDNfARD7jpQ971mFiRXm
 eltzKaEunINkloo6KwXdRutPV6HOX+Z66DsFy3DDJJXLfsIEIJWjuHJdFRy8ZcaEgYQF
 rcZpnQb7ArVahSiufL+pp9heWpYHs1tNsszKt67GGFg4X5+WZjXp6an0A+UsE1dg5SFg
 7sgw==
X-Gm-Message-State: AOJu0YyEzpdHsPUt01RgDmacZ5KxN6qUYIjiiKLjfS7krPlxtFDar+U6
 2LUxWRtysN90tMi6QvqcXlYsUAFCwT8U5zVSlImrpGpR8wWGJ1BY+Uaz25Cyn3ZU
X-Gm-Gg: AeBDiev8ic+ht81Qx0h56qYgQq8e1qvFovYkHD6PCodUTqSOQ7gSm6+2q6Uu9xEK4S9
 MN66AQua2KjoY2UG/7Dsge9Vq8rQfmrFPhyUjjWEfh45l4PZ5SIWH6ShitLzYvbRjUnWfeCzBCN
 bmHc6JZnaHyWagVP7gbhmGZIFDi6JIFJS41Mc4wxNTBoZaq0PoDlyWaQgSl9NSgzjbJg9Yv57Aw
 rkvpIMD8q5rW6vXbUKW5C5kGe+i7/siqWGqjbkt6YBrwyJ74iuk4JSaTpnFyyLYG+kKpZapS6xV
 goGS7L7SfScolsJmt30THqJbSj+IkzFJLR9dER0yStNpLhcfmD0wI1Ys5qmBwpE4VsdfJd07NNY
 ostfhPpP6RihbejGU2+ExPojKynPk82PcKsgNgej7lJReQuXsYh5t/72ZV49pqSK+uFnbZuUjsN
 AkVM1sTVlwuEt7i6i0qbBjTf0C5XzlaT25L0TXTlGKeLpyWp4zEyI7MLLGrHfyATtBqm+SqsQ=
X-Received: by 2002:a05:6000:610:b0:43d:1c21:ead5 with SMTP id
 ffacd0b85a97d-43fe3e0b4d8mr22737692f8f.22.1776702097900; 
 Mon, 20 Apr 2026 09:21:37 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:1552:6880:e516:62d2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a18csm34340249f8f.20.2026.04.20.09.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 09:21:37 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: qemu-devel@nongnu.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH] hw/arm/raspi4b: NOP all DTB nodes when removing unimplemented
 devices
Date: Mon, 20 Apr 2026 18:21:14 +0200
Message-ID: <20260420162114.308519-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=osama.abdelkader@gmail.com; helo=mail-wr1-x435.google.com
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

fdt_node_offset_by_compatible(fdt, -1, compat) only finds the first match.
If the blob has more than one node with the same compatible string, extra
nodes will remain active. using the same loop as imx8mp-evk.c

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 hw/arm/raspi4b.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 3eeb8f447e..06aeb8db01 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -72,12 +72,14 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
 
     for (int i = 0; i < ARRAY_SIZE(nodes_to_remove); i++) {
         const char *dev_str = nodes_to_remove[i];
+        int offset;
 
-        int offset = fdt_node_offset_by_compatible(fdt, -1, dev_str);
-        if (offset >= 0) {
-            if (!fdt_nop_node(fdt, offset)) {
-                warn_report("bcm2711 dtc: %s has been disabled!", dev_str);
+        offset = fdt_node_offset_by_compatible(fdt, -1, dev_str);
+        while (offset >= 0) {
+            if (fdt_nop_node(fdt, offset) == 0) {
+                warn_report("bcm2711 dtb: %s has been disabled!", dev_str);
             }
+            offset = fdt_node_offset_by_compatible(fdt, offset, dev_str);
         }
     }
 
-- 
2.43.0


