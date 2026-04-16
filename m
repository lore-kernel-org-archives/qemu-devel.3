Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34AEF8A145
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIrq-0006br-UN; Thu, 16 Apr 2026 05:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqU-0005BO-B8
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:12 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqR-0007km-3A
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:10 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4887f49ec5aso93485455e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331025; x=1776935825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1Gt5poSDoVmm0fF5KsqmGYktsklHB413Fw9gIlh9TFI=;
 b=hzI+PIoUM6+NW2jYnslib6mAqoZ/CxD2SGz6iuxJl4yk3NdaaCnXJJByK/HKzsj41i
 IPzG0McoGFzwnozBPyXEXY3zdtfLOPH/VhAoc////MuE2Ih2VFtiOO7l2u2FUH/7wkOk
 9NYZIFpz4eLnX7LZ1vfpFOq7TaKZghaMcXdsOEhFgJGv9igTmxuNyU8TEGYOzURVMGP4
 8Wfq7zRpTMZ8r0GKh9RLgsiDGSwe4PmGLndmqpND7iaokQUxWzKbAE7Zwc0/X7H7a8RO
 FyWZd2ssDLSXRgRlrXeTOsw1IveO0Sh7P5GPv+k+l/f3PiJMr/ow0/vZW9HUiAXIxbSL
 xzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331025; x=1776935825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1Gt5poSDoVmm0fF5KsqmGYktsklHB413Fw9gIlh9TFI=;
 b=Fpji8InaMYOUB1w+LU5Wj5ZOpbgXvr1n1tg8CtpxKBTz3Y/Y2zNQzzXl9EsrDC/O8O
 lWX81oY14QD1vQWxzytp9zeFEb3jBgRPjmPoRkqjbXWgAnHKMcOaawygy5VaNbODLF2E
 KVgLy+9oGKyOQHCOBpnlr27Ay2ZHyd9NAKHU3hpPyEkQhu/iGnp7xD4IsdMd4TU8ZTQM
 X7yZdR1fnnt3nT9S3kx6jc0h0czQjQyyvWgH9vLuWdIH/yl7shH6yqyCr4cBgfACx3Bv
 QZXGnCzn83vpy2jonK0Q0FRJitSyIXogEaf4D25t8/WGCQUCizEYNVzo2jdkHvzG+gIQ
 OutQ==
X-Gm-Message-State: AOJu0YyU/bNtjU5grX72tegXk2mwYUPVWDqhjW6CcTEUFY/5v15jKwDt
 fRxwh04wf6OJ0Zaf9JzniTFzIVQ2V+Kp8mnZ0whd0uQ83qxlT/Gm7k1b2Rsr6AztZBJLGQaX+U0
 Ib1nJMqU=
X-Gm-Gg: AeBDievd7W7ehveJ3PO8LRF8OQZKUYLHhjAbgl4hq7Skn2NhgjdGpf21XYcuJbBUjA4
 s4Ic9bK60PDvthl9ci78cC7KW/DFUSWCO7XIgeBBudhJCRsbM2AHQR/lGIIomYmewmXF42YK47R
 eJ24iWQv0tcpWKtpM89Pkz3LXszwHsmgcdQZv1Hh+Uifr/dDiYoHGAh0sAgMFeZaing8bdnQfV4
 MC0eOBNa8mX1olx+sx1FuUg5fB+qe5ouB/eYiq1F9e+K4BjZCdQRob9Tkv9rixpdKbw9WuRmP8n
 yq0VT22LfrJ/BA0No1ydNdp7QYmekaOQtSWOKw1GVbI+qJ1n5fXH/n1YY6olx3aaMFAPcv+kWSZ
 tOkLBpnRe0duCb8rgcvCn5Xu4Cs92+vXBsWKlDMOp/hbqqoJvQDdW9XsTdXyT5ZvjyKOLR0f0sf
 55RqOi2UlBWSO5fp/Xqh4fwfPtXvcfirGNcYtrX8thu6PHtkVR/yl5HzXO3iRmbEidXw+qEFdsP
 ZTEIE+Ecv1EnlTwGIF7ZpoHYTJgg2pzm933VWV6dA==
X-Received: by 2002:a05:600c:8883:b0:488:a82f:bb95 with SMTP id
 5b1f17b1804b1-488d689c18fmr260057125e9.29.1776331025312; 
 Thu, 16 Apr 2026 02:17:05 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.17.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:17:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/28] MAINTAINERS: Remove WANG Xuerui
Date: Thu, 16 Apr 2026 10:16:35 +0100
Message-ID: <20260416091654.316158-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091654.316158-1-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

WANG Xuerui has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

This makes "LoongArch64 TCG target" orphan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a7fb4e4770..0b2adbc247 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4115,8 +4115,7 @@ S: Maintained
 F: tcg/x86_64/
 
 LoongArch64 TCG target
-M: WANG Xuerui <git@xen0n.name>
-S: Maintained
+S: Orphan
 F: tcg/loongarch64/
 
 MIPS TCG target
-- 
2.43.0


