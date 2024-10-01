Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04625CEACE7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfuU-0005Rw-EW; Tue, 01 Oct 2024 12:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuQ-0005Mi-19
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:34 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuM-00062b-Uh
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:33 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-37ccd50faafso3715544f8f.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800769; x=1728405569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HFx/GnAnRaknHxr+8cfa7m7LXk6D0SNwz0Fg7yuRYls=;
 b=JWQZOgPGSCLtsadxW/LNtStce52wn3c6WCNiTMk5fSrrP763iipk4nbA3dvOL41G2w
 Wlj7u3ws4WwwAAMe9Xk0QAaeFjKZMdz3mWFjUnIFeJEco4fdRVSM+0T4Jd6dnvuOiKHn
 KgyeFBYFPX3HiwksceK3ekWNTvHfOnYdc+ozVbbbBw94gXyoPSLzYDBNwSP+TFGntxzD
 Z4HbpLkulzPMAspt6Mb9ILYt+JVtIH8EsCIvgeyJ+Z7yHyhU5vaA9biknq/sRldUfj5L
 I7xMFzLnZT95rgKYuFn0ttxOC+0sQLSRZTNJPLC9gtxqLxYTIWb+PsDbLzhG8nVTTqcW
 IA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800769; x=1728405569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HFx/GnAnRaknHxr+8cfa7m7LXk6D0SNwz0Fg7yuRYls=;
 b=L5Hs7AOL21UKFdg+XSgtqIgeFEwCywwIQf5EaFUAELLGV5uia4Pakw3XfWOTxHIZHO
 STtuMaHT6/2qFrEka8MIYt2xTW+pNMrnKmMnBM3BBkhA/5PM5GQtmgRumU/saFO7XhrZ
 qNwhv9JWa/bu2jvcnhQZI3RHaRaZ8Qu05lSpR8y1ibjigNfH1sJMRy9niYKvu0qNXQZN
 B5SUvcVs6sM3SnD4R1+I2deuCGieVB4D6ItByr+W+4DHaAfAGFm6poDJ12S6aOVRT/w7
 HMXHGuXe19LSxRTLn7o3H6iAJ0cS1FiJHL02VwNj3VDBy7u+HDPYan0u3WST/HdDg4tu
 R+Fw==
X-Gm-Message-State: AOJu0YzrN+oG7Bmo3k0621F4WPf/S1fCS35QJyEOLthURct3UGsDEtDE
 L5nfuvX2V5B+niCbLaunFJgAxyhkWvJGeIN2tdEFSxSIrRYTT4SaipZFOmlIDRNFA82oWQEBKpQ
 d
X-Google-Smtp-Source: AGHT+IGGBgIRmU9BCbrzaOcMeuPxIzOfT6qmlXZzhMaIRfKJjtiKMl99TeVXTn5SYuSehUjjC00w4g==
X-Received: by 2002:a05:6000:cd0:b0:374:c287:929b with SMTP id
 ffacd0b85a97d-37cfb8b1895mr150709f8f.4.1727800769484; 
 Tue, 01 Oct 2024 09:39:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/54] hw/timer/pxa2xx_timer: Remove use of pxa.h header
Date: Tue,  1 Oct 2024 17:38:42 +0100
Message-Id: <20241001163918.1275441-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

pxa2xx_timer includes pxa.h, but it doesn't actually make
use of any of the #defines, function prototypes or structs
defined there. Remove the unnecessary include (we will
shortly be removing the whole header file).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240903160751.4100218-15-peter.maydell@linaro.org
---
 hw/timer/pxa2xx_timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index 6479ab1a8b3..d1a3ecac2b5 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -12,7 +12,6 @@
 #include "hw/qdev-properties.h"
 #include "qemu/timer.h"
 #include "sysemu/runstate.h"
-#include "hw/arm/pxa.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
-- 
2.34.1


