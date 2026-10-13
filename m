Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD43CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY3c-0007VS-Dp; Tue, 13 Oct 2026 04:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3K-0006yl-NY
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:12 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3D-0007bn-NM
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:05 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a1880e1bf1so24723185e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880792; x=1792485592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UViGHcknrDhUYElC9wgz9XVN/w6c0++pkoJaAEN1syM=;
 b=GlGX8WyUZLOKbjKxltbHUCmR1yyx2myOzaF/2wgOIZplRM7kcGv9gud1A+ZKKAgIJ3
 zY6VvkdVG5DW0ETewJDu7FxLAdZpYUqsK8lHE/NAK7HplN4BvPMsKFgMF8kJkieQV9Bo
 ZpaNe0XQns9TYUcwRpx7zCnZj/ZA7HSeupth86XmcohhhUYV91sdgawQ/utW6TX/Dx3n
 uUAGufd5LZc1h1TiTO0z9svuw3AjzuACX6BYimYhA06jT1qTRDP0UK9c83BlY0u/13OT
 Hxf+miaZ+H6G2UR5QfghCzvVGlOqLzHH6jN1wRlROPtM0UQYCxDxxD+JCQjg0CTrwWkm
 khQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880792; x=1792485592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UViGHcknrDhUYElC9wgz9XVN/w6c0++pkoJaAEN1syM=;
 b=X8j1RJWBKgEIyXwgXHf0Tc1oMvp2VW5sEZqw+XjyyvGL6FQKX1xG0Ze89iyfovhPDS
 9cp/qEVRy+9J7rkxrV9DNMIFfEE/qy63KwnkzXP6b815V2TxFQJt3UpJwkBoqjB1Ob+W
 W8P4EEdH1mSX6AlMNByoiHxOmMHqN9nYDh+ynZw6DATrFcCzVHyvC1SdhllAsOjgxSNj
 +zjdi+d1eN2AnbwZ7eP9YdSP9a5XJDWrQpPkLv9UZRZ9rrrXO+NPLmBmg3ZfRs1+TnoS
 71LBsLl1sIhBNCfOzwNBKjZNJz3bRrgc/SxbuWcpEEO5ui4nhZTfnCALSOuN+9eolwje
 ZaLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPWGYahGsLTKYP0nZCWTDRa2g7vThJa7JnZU056o2aoQK9s9zxjLa4pAW6Wth78wA2s79mVF78OZGg@nongnu.org
X-Gm-Message-State: AFq9FYJRAucKQqSpJKJferb6mcW90fkDPr1grcMylxMkmHeUMjUqVOLd
 wyKJYvm9EwdgAsqAKQOU2pNeYQSm+J2dqvbRKJ4iTleWYjS5sT3/1bov7pCK/JVGmJGy4AaeOev
 1Zvpm+3U=
X-Gm-Gg: AYBFou2/5SrBfd+Izc0b26bLlrOk6C3u04k7F12WAlCSb/rwiABp3SA/mbS0rkZqWim
 axHi4M+bXl3335o3gcs/WBdUko0LOMgja5O0ZQqnu/ApozFWcUs8SBmgnWTxkpTnOFCmm7JSwKR
 ZeqWa90r4zalhH0b42sAKZWL7TJwAtHTX+IJZchfCensc4XKH7Fjz+LyKE6krXQbCTcDcxKhmFM
 CpsyN7/J0x49p+/OmOBhwEwV+HoDa2Qy4/l4D/Nk+2b012eDO0tagTNJaJBm0fgGHD0K4Z4G/MN
 p3HDGHXyH4jsW+89JRCjmYJk4/kz2OemYwr6CKYwWRkY7ImEqNJwX2E3JH2lHWP812lb2gmxPag
 QsSKf21xxGeIizQI3N4v2mZ7ZO0dqzgpOE7LYnyjQi4b+3hzKCBcbBTViPFMe+0VCwFxbbo1hBq
 r7muidB9Gdi4WVaZTmpnC3oaj2wuB9EBP1WsDo+TLPUeaMp9jcmrOuTo00CCge4cBV0HEFvidi+
 gXnWJ1iB/UTo2BUbJyM2zI7aa3M7Gv+f8cGuT7BuujTkuHPETQrkoyja+ou7UB0N8rR35i6UL3j
 6VE=
X-Received: by 2002:a05:600c:e549:20b0:4a1:9438:719e with SMTP id
 5b1f17b1804b1-4a1943872ecmr113069885e9.9.1791880792088; 
 Tue, 13 Oct 2026 01:39:52 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:39:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 12/86] hw/intc/arm_gicv5: Relax QEMU_GICV5_MIN_LPI_ID_BITS to 0
Date: Tue, 13 Oct 2026 09:38:19 +0100
Message-ID: <20261013083933.1024405-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

The GICv5 specification allows implementations to declare a
MIN_LPI_ID_BITS value in IST_IDR2, which specifies the minimum number
of supported LPIs which can be configured (both for physical LPIs and
for virtual LPIs in VMs).  It also notes (I_ZKLJR) that it doesn't
expect most hardware implementations to require a minimum numberof
LPI ID bits, and that this is mostly useful for the virtual IRS that
a hypervisor might expose to a guest.

QEMU generally prefers to offer the guest the highest-flexibility
setting when it comes to this kind of IMPDEF value, so for instance
we set our supported ID and IAFFID bit size to the maximum the spec
permits.  Since this value is a minimum rather than a maximum,
"highest-flexibility" means allowing the guest to configure a very
small LPI range if it wants to.  Our current setting of 14 for
QEMU_GICV5_MIN_LPI_ID_BITS is the least-flexible the architecture
permits and requires that guests always configure large LPI ranges.

Set QEMU_GICV5_MIN_LPI_ID_BITS to 0, as the spec suggests real
hardware would.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/arm_gicv5_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index 59ac1c3880c..a47f639e84c 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -146,7 +146,7 @@ struct GICv5CommonClass {
 /* Number of INTID.ID bits we support */
 #define QEMU_GICV5_ID_BITS 24
 /* Min LPI_ID_BITS supported */
-#define QEMU_GICV5_MIN_LPI_ID_BITS 14
+#define QEMU_GICV5_MIN_LPI_ID_BITS 0
 /* IAFFID bits supported */
 #define QEMU_GICV5_IAFFID_BITS 16
 /* Number of priority bits supported in the IRS */
-- 
2.43.0


