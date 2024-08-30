Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCD1CA1009
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 17:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk5WZ-00055g-54; Fri, 30 Aug 2024 13:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk5WU-0004tS-S6
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 13:34:58 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk5WS-0003OB-Vz
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 13:34:58 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-371a13c7c80so1948038f8f.0
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 10:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725039295; x=1725644095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RAPk9TkgHuJzLy5angeKNdvCxMHfEkd/1HkV7jTog4w=;
 b=ZTCIBFovd8c3W4PzR9CPh12tME7Vm/uwte82i1x9LsnrRu4ZgYyPZ5gMc6BS2JLPeO
 I4vsEWVngPrMGYFKlnuPxm/JunRia4Wp3i30Kt2Opgq6yuOTGsIDwyKUGiObrpQx5Vwx
 CnJijBbyMDp3pzOVxYQ+rBlaAB/u4Z+8ckRj3QWpGPbPaMNjtR1hCYmoHhlJ10KRHkyG
 5bsyW4KQcT80SBs+2HGEdPikfI1w6kfwPf58pVL0Ux9RO37BpFa3ZO0gHrPdutsv1Gq0
 HnzrL+uOIusRtqrfTs+9sD1onfiHKTN9c1flXSoh6Kk1Aw7e+aWevYHfDFRyuJuohg6/
 fmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725039295; x=1725644095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RAPk9TkgHuJzLy5angeKNdvCxMHfEkd/1HkV7jTog4w=;
 b=bZw9B9yUB74nshc6ad7SH+riJqvD9Fakv+54k73G7A/OQWn/Upg6uMBUb9xoai3HE1
 P7B9o1yEw+Zs0Hu/E0N6x4yNAV2RMePBY30QxtXVgmUKGijir4jKNG7CAUdIinhUx1z7
 R9SZ6bHRZp5QLucxEOJpHXZ7OQ6XBeAypGN+G3XsllJ5wUXquMKyVf6gi/UekLiUVmkk
 XI3G2kQavUDEIRuDsiF/hY54S+qkzvO5ZI/cnuq9+Y9pXsGWAs1Z0rr49stqjHHJByRD
 H8M9/Qljtg9ZHbPT3XpaGEDkKoARIWWYRACG9fYb/P9OemH3Qz/8pOWoxFfzwRgXXJLi
 2tig==
X-Gm-Message-State: AOJu0Yy04pLWLVzL2HaxDaoh4oXa77r2ZDErx9i0K62X2Wfa8LFZdJcV
 Y2RRWEOyNAstFNI3bc1IhVG8syk8hO9CG4zf8EIPP1+B4/O4p8AV4bLhEVaFwgIRzPKdf9rJzWB
 9
X-Google-Smtp-Source: AGHT+IEqtATpvfs6JhyQ68/6pRcxTngQ/JZ/C2J5l2GOC7p3fQk5WWTVZa8M5Xc8NvFloloW+iy69Q==
X-Received: by 2002:a05:6000:4020:b0:367:895f:619e with SMTP id
 ffacd0b85a97d-3749c1c8000mr5273662f8f.11.1725039295167; 
 Fri, 30 Aug 2024 10:34:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb37f7849sm58471775e9.7.2024.08.30.10.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 10:34:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>,
	Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 2/3] hw/m68k/mcf5208: Add URLs for datasheets
Date: Fri, 30 Aug 2024 18:34:51 +0100
Message-Id: <20240830173452.2086140-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830173452.2086140-1-peter.maydell@linaro.org>
References: <20240830173452.2086140-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The datasheets for the SoC and board we model here are still
available from the NXP website; add their URLs and titles for
future reference.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/m68k/mcf5208.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 0ad347dfa81..b6677ad6bc3 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -4,6 +4,14 @@
  * Copyright (c) 2007 CodeSourcery.
  *
  * This code is licensed under the GPL
+ *
+ * This file models both the MCF5208 SoC, and the
+ * MCF5208EVB evaluation board. For details see
+ *
+ * "MCF5208 Reference Manual"
+ * https://www.nxp.com/docs/en/reference-manual/MCF5208RM.pdf
+ * "M5208EVB-RevB 32-bit Microcontroller User Manual"
+ * https://www.nxp.com/docs/en/reference-manual/M5208EVBUM.pdf
  */
 
 #include "qemu/osdep.h"
-- 
2.34.1


