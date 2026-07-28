Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAC7C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wogyI-0005SY-VM; Tue, 28 Jul 2026 08:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyE-0005Qh-ST
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:42 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyD-00035n-AW
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:42 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47f9ab7ee38so2015129f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 05:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785241900; x=1785846700; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JarEyWDVEMKC5wehPlttkbVwi38ocKf1ZaDitzLyJ5I=;
 b=zq4V/+ZDDVmm1tWaABG/0kp+eMobMuDNqe5RCWi0Fm7EZOyWhm3tuS5AZEsR3wqaMN
 NyB+9c+ncts3eZMWeWsPIpr8Sb6CRTyy838hKE9XcYA4DHWOeWtAHjoz4998dF/SyweY
 p1A/HIHV07h8sLy3R+O7TpiPikUeWW4sv+X0UM9hmS0V3rlU5e7vLkete4Ilg1HHsx6O
 iK0TlSW1rYHNaF5oNacEhYqqXi4RNr0v+08xCRiZjtl4gj/LcBLuMBbkUrStqa+Q9UFx
 WYn0EUDuCfAnkjXbKGdAL0zXYhql8tF4eYpS5oGNRWfpU+cBTUO14Kj6Kb6kriiyoGRT
 P16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241900; x=1785846700;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JarEyWDVEMKC5wehPlttkbVwi38ocKf1ZaDitzLyJ5I=;
 b=Ke48/CkiTd+cCVL9gibVMO2FP5oI6PPTIsS24bqCgVzy8dZC8OrNLO7Wf4C/9BAsqi
 2VkRupu0EGnAeQS1Fh64LX8T9KExBwZlWFS1eQWwhAxnonWBUOG4SczjVe6Thvb4cU+4
 BkHWXufeEskIxXsxqSkZeTudu0LGw2uL6FWl3xwpOVVERoQKUoDy3j1QyYwFu9DptLrY
 5G0x+EFlj/anebR9pa9g7jnSsL7FHDLgmce1pSi02pbgiYcb/7Qp8/kpblS3+vTzAVTb
 GjkrhIaAAWdew9S+PgoIDRzjCNUx509aot3VH3gp1DVKxxApjvLPAeXtgsmcJ/cLd3IC
 kO6A==
X-Gm-Message-State: AOJu0YwhRN1rFATT6fy4GjaBUBK2Jhbiu114EHAuotGdc/pOp7DLwOKe
 OdlbKiecKZpdON3L9FNuUyzjqODjFz9vyvsuMv6Lubv06Vva1kY5VUPXknloDmzUd6gAuaBeLyj
 ZXmUq
X-Gm-Gg: AR+sD11VbFInd+yFdeOMIg0KigWqjixEQxbPjmL1G3mQQmwmbAC5mpjo/24I5rEREUh
 byD0Qy0o3IkahVc5wlJQACY1R7sIDdkdhRdoxR0+EunZOFpFfrmuw1KhZZfGXcp6PV/HsjQZ+wF
 PfWAAWdbeN5VGnSh0xVZurJ7YZpWhCizRr4FIiweyaQLCCg5hwD33jsxhEAxcsUOrDk8Js46R6U
 3fC56Q7cfaQpPfnfPH/rPifucUGUvpzl/ar7hl/g5MZHwgUo4rp94x2ECeLYzABZwMYUc6KdcLI
 lNL32x6xQ295O3nEf+4oA6D+p/DUz8wQGckDNRtRhxbNKmC9bpXr5KzPnBRi5Ymo0w//RDVAKCL
 CcGbsvacV5OlcsWwcH8+0kvnYB3OCuHBExG66bUIkEfomtWAkMqm406C9kLUIvec1yb7E9Dj74x
 TWkUmyEnZSlhBFRy4tB0h8A0v0qr1Ewr+N3lQIhx0wpfvGYWWOujLiYDmULQQgyFUI9uC94R/NK
 aDqwA+T15Y=
X-Received: by 2002:a05:6000:40db:b0:47f:91e3:3cbf with SMTP id
 ffacd0b85a97d-47fb1ed97e1mr2763950f8f.19.1785241899580; 
 Tue, 28 Jul 2026 05:31:39 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6f076sm58499039f8f.34.2026.07.28.05.31.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:31:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/20] hw/net/can/flexcan: Fix mailbox reset mask initialization
Date: Tue, 28 Jul 2026 13:31:17 +0100
Message-ID: <20260728123127.1711653-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728123127.1711653-1-peter.maydell@linaro.org>
References: <20260728123127.1711653-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Bernhard Beschow <shentey@gmail.com>

The mailbox reset mask initialized only the first word of the raw `mb[]`
array. Fix the initialization to cover the whole mailbox, as indicated
in the field description in the header. While at it, use the `mbs[]`
view instead in order to drop the redundant and oversized `mb[]` view in
the next commit.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260723070059.6332-7-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/can/flexcan.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/net/can/flexcan.c b/hw/net/can/flexcan.c
index 8d680f1832e..f84f090a7fd 100644
--- a/hw/net/can/flexcan.c
+++ b/hw/net/can/flexcan.c
@@ -134,7 +134,11 @@ static const FlexcanRegs flexcan_regs_reset_mask = {
     ._reserved2 = 0,
     .dbg1 = 0,
     .dbg2 = 0,
-    .mb = {0xFFFFFFFF},
+    .mbs = { [0 ... FLEXCAN_MAILBOX_COUNT - 1] = {
+        .can_ctrl = 0xFFFFFFFF,
+        .can_id = 0xFFFFFFFF,
+        .data = { 0xFFFFFFFF, 0xFFFFFFFF },
+    } },
     ._reserved4 = {0},
     .rximr = {0xFFFFFFFF},
     ._reserved5 = {0},
-- 
2.43.0


