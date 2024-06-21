Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62826C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZIN-0005hN-P8; Fri, 21 Jun 2024 04:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZIM-0005gp-Er
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:06:54 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZIK-0008P3-VQ
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:06:54 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-365663f51adso897835f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 01:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718957211; x=1719562011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wIA5ZIlGPiIpZ77uW3DTdXqmrUImGJ4SmShsvIo62CI=;
 b=IAAxos6cLzcOQArJ3kHJodAxu5xFdVovG6rH+QGAFElG1saFPi/5JSienlQmbZ1h++
 JVduLjshz4b8RX4PUb8k1WroN4ybWjNA+8iCbPFapJBbtULoiAqsvMX/jRh3aTLHBHjP
 RL6UiEhS3AgEYmIaWlxKpNB+T6Y2lyqyPmSDwUpXekwp7zpZbdu8Uix173ryHBodVx+C
 YHePwZejzRw/sOfNdY/3zilcJtHA3u3JQqZpmvobniOKjYQRXPQIfzWGh2Uh80ywXoP+
 Mq4dqrqTBC1dxsqdpp4ess12L5yosYSSTMYn7NUodfkDx80kAextFZhiAOtiZTjWURT6
 cauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718957211; x=1719562011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wIA5ZIlGPiIpZ77uW3DTdXqmrUImGJ4SmShsvIo62CI=;
 b=S/lbCcX8dgelflMt3DSwUySrKPzOiAYckN+P4vnMp9+1QAp6PtFsj+uNPT3waBJQ4D
 FVDgxAB5m8JuWn49qLny5irYgjNXn0aSw9KFSWiGi7LrZZ33ZWVpRXzDW9OQaA+i7y0U
 5EwO/MC44yN0zvusH0JS7WZc+ik8/oglZQn56D+00aVKS6g4ez0eHLVkwb6TGRHF3pyu
 sTwLcokwGROXAU4Usjp3r8B4RBY7edkR68zp/NO7BJWAIJ51xas4JKqV3KuWzZRKq/4o
 G8Fxl4FozMOlhDLq15nYy+7Y+EnlWZc9M6zwWLdjzjYPjaqzzwV7pYORNZsrjcwijovg
 wFjQ==
X-Gm-Message-State: AOJu0Yy9cML0nL5czh+0jQGHsTVdTvEwQ2IvtOMjstvbsqeWv1iN7YQ7
 5oU0/45e8xf275qXmOcCGf+d4DHgCZ0ABGYG0Aqhujd38Z9PjDuUWZdgiKyFX1qCCElEM5cNdTH
 5
X-Google-Smtp-Source: AGHT+IEgQ1U2aTmFKSvB+qWycUFCCVBOuolfpfJ25lZvfbLp7WlHJCPNuJSVNa/DAErVveirNroNDw==
X-Received: by 2002:a05:6000:9:b0:360:775d:f917 with SMTP id
 ffacd0b85a97d-363171e2c36mr5350833f8f.4.1718957211381; 
 Fri, 21 Jun 2024 01:06:51 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36638d9c16esm973840f8f.57.2024.06.21.01.06.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Jun 2024 01:06:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
Subject: [PATCH 09/23] hw/sd/sdcard: Generate random RCA value
Date: Fri, 21 Jun 2024 10:05:40 +0200
Message-ID: <20240621080554.18986-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240621080554.18986-1-philmd@linaro.org>
References: <20240621080554.18986-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Rather than using the obscure 0x4567 magic value,
use a real random one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 30239b28bc..e1f13e316a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -46,6 +46,7 @@
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
+#include "qemu/guest-random.h"
 #include "qemu/module.h"
 #include "sdmmc-internal.h"
 #include "trace.h"
@@ -469,11 +470,6 @@ static void sd_set_csd(SDState *sd, uint64_t size)
     sd->csd[15] = (sd_crc7(sd->csd, 15) << 1) | 1;
 }
 
-static void sd_set_rca(SDState *sd)
-{
-    sd->rca += 0x4567;
-}
-
 FIELD(CSR, AKE_SEQ_ERROR,               3,  1)
 FIELD(CSR, APP_CMD,                     5,  1)
 FIELD(CSR, FX_EVENT,                    6,  1)
@@ -1055,7 +1051,7 @@ static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
     case sd_identification_state:
     case sd_standby_state:
         sd->state = sd_standby_state;
-        sd_set_rca(sd);
+        qemu_guest_getrandom_nofail(&sd->rca, sizeof(sd->rca));
         return sd_r6;
 
     default:
-- 
2.41.0


