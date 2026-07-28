Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA1BC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wogyH-0005Ra-1V; Tue, 28 Jul 2026 08:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyC-0005O5-CU
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:40 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyA-00033G-GB
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:39 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47640541585so2450947f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 05:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785241896; x=1785846696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lKVj3gACkbHKcSCHyOf7jiUGxcjNCDEqa/wnEa9T7ro=;
 b=yhXEBXbJEfdBrC9GKyoPFMn31YCqJZcmTxklEEg9jVUMFYxy6dttjwNGi6NTcE6w0t
 0hCLihAE+yumaxpac1Tx3XCxy13/J/9aK8Ypeij6TgzMu5NWC8N7Maz35AfoHGi8M57L
 mGYXPVpRxHaofruvlZJ1uULUP9ZgDfA2izg45lh9iY5nATBGlKEEC3e+NPzTxUWjhV6l
 JQ8nz1A9Jow6q8KpSgcemX+L6bikuLqGN9LzI1zjlkbQygVbfgz+svCJ+k7/XNaxmqO8
 SIKADtsTx4iiEHV37JjtECYhdeyfVynUif5VQRKaUlkgL8mxblvkCqHKVUKa6J8Ft/AB
 JqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241896; x=1785846696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lKVj3gACkbHKcSCHyOf7jiUGxcjNCDEqa/wnEa9T7ro=;
 b=o53DxTmoVftHAdFY3do5cPVzmwfPaV9aOdx6RmY272R8hfUbcrrFycxOnArOsU5U+a
 yEXYyCGgOWaLlBcGvoKsVIwPrsgrUiHx/Q+9tePI5QlknKDejxM2kGIw11ECOAW4qvBn
 4thqKbvGAqluwlDaN1n4z6JslqMf1oi7wDRC6PSIJIgIRkTYX/UOmsFOOsM6IPlug3ho
 jwaE48vRX6hiHqOeR/kO6ANIPi2jFcuF/cIbfH8RfU/EaWEyhSOkjkza2oCfBQgnUWJC
 2FBvU6zfMzOF1YTX2k5G8hbI7hHetuAPZokG47UjppDE1EIPg/UTxF0+N58/aQL7r879
 Nm9A==
X-Gm-Message-State: AOJu0YxAS+nMn40iZYpI8gJNfmXrQNPOV0jpkCWqwZ2m5DoHlSRcgTd+
 63b6vejdEibfh8l6VXLdu7E3oQGR5Dow+jJ8lQ952qdg8P/JtRpezixVRu6gk8Dw07kgZmvh+kL
 u51+2
X-Gm-Gg: AR+sD11MikV93WUFYUZPXhYQMzc/RHmkq+eU1zTw3HRT3e7jAVPZ5aE40f/7XJ4b1Nn
 D+BCyBhb7O8hKOqOsjKdoJURziDEUaDfhylpyPbtBk0/rw+Z6DntgMBijlOzNzVCS1/tQQv7Smu
 MuDzt74iLS2BGU0uWEIC9aRNL9V/QKyfSAxIXyT1iz1rYZlXBntIxAiLXij19/xea6sEAazISpn
 llLIl9dgef31t+19i7imA4ePjMc5p/gS+oCKCmXYNPV2N7nsO6VRODChoFeQ3ga6XenQgc2I/YC
 43Q8mOLNCYrZ5IHahulCoxbeMzU3JgiIwD4HDPAjP/TYFhcgA6uPKbyGVRy5KWJo9eYs8MtC5Jv
 0GPw2iuPJv/9ZXjrId7sw4YbGP//PCMh5KPadT0VnbQNs/2g2bZmZ+oMiIM/8sDo44zl5PIdB+/
 LACATPKhD799gJaMCj0Ebk/2sgz1RPd0nuk7afQlJEl2uaruTVNt+ndYGrd1KOIwDm3ZvRo4DhG
 Q41f6HV4iE=
X-Received: by 2002:a05:6000:290f:b0:46e:37a6:c762 with SMTP id
 ffacd0b85a97d-47fb1f10955mr2533978f8f.32.1785241896472; 
 Tue, 28 Jul 2026 05:31:36 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6f076sm58499039f8f.34.2026.07.28.05.31.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:31:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/20] hw/net/can/flexcan: Fix out-of-bounds access in
 flexcan_mx_rx()
Date: Tue, 28 Jul 2026 13:31:14 +0100
Message-ID: <20260728123127.1711653-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728123127.1711653-1-peter.maydell@linaro.org>
References: <20260728123127.1711653-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

Require `last_not_free_to_receive_mbid >= 0` before indexing `mbs[]`.
This prevents a possible `-1` array index and fixes Coverity CID
1662790.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260723070059.6332-4-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/can/flexcan.c b/hw/net/can/flexcan.c
index 3a97edf7a4d..dd92a383373 100644
--- a/hw/net/can/flexcan.c
+++ b/hw/net/can/flexcan.c
@@ -1075,7 +1075,7 @@ static enum FlexcanRx flexcan_mb_rx(FlexcanState *s, const qemu_can_frame *buf)
         }
     }
 
-    if (last_not_free_to_receive_mbid >= -1) {
+    if (last_not_free_to_receive_mbid >= 0) {
         if (last_not_free_to_receive_locked) {
             /*
              * copy to temporary mailbox (SMB)
-- 
2.43.0


