Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65790CE8D47
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 15:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJvnA-0007mm-4Q; Fri, 14 Nov 2025 10:32:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJvc1-0006KC-W1
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:21:22 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJvc0-0003uV-EU
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:21:21 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-477775d3728so21655875e9.2
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 07:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763133679; x=1763738479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vkUCqWEGShl+SesNg9zec2NRP5f9ibCAfyLsvJOY90I=;
 b=MqDYVPZ+fdcym1YjODpH0v2T6E+70nCp5MzphokFuniLc/qf/r/x+TrtkQnIxbnJX6
 9ukxXyQ/UyYUG3qzLBXyln9TxnTjl8CY95n0WzpLZsrr2KImag5llp5JRNhKcPkUEgTi
 ofHEH6ExpJL9uEi+OfoBqler+tkCCdGVbRrOIRuTTs6fkh9CBXQHjk0eH8F3M0tEZmc7
 boPZiWa8djyi4kWLI0xLTJyJR2mkujjLWIi5Kd+Up3vSaj9JgN006ON2fLovOJTGvGzp
 VG4fpOthDenAV7bS37WQE77KQC/hqXU3zhcQ+MUCD9NGyJDq7/iJAf5dPhOl8nDaU88y
 +1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763133679; x=1763738479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vkUCqWEGShl+SesNg9zec2NRP5f9ibCAfyLsvJOY90I=;
 b=t6vFGfwEL+uAVMgPTMLnhW25+HdWFGkVk5zfgu94+v6uhWMdC7t+MDmJMz9aXFAsWK
 brz/WriJ5efUVnzwemgspY+t7/v9swwtya0SCIH4OPuel/bL1gvfUkRfc4B/JWeLKVaa
 /3coTTSBIP0hdXPwCN/4rH0pr46Q5TUPljRLCpsGpySEh+jz6/4PUT9ORepIZOoesieO
 L7b4hAUxMXw1/b1JfkYWY8xAVccWUm5nrTjj5G4yWEp/rWjeJpDaaYIYGGzetv8JK6OS
 bLH8eMed2FRrpwrxXG7Pdb+6ghVdlP6/flf5hzTE8PkR5/DZRRq4hKaB6bljECiRVP9h
 Pa4g==
X-Gm-Message-State: AOJu0Yx8a0PCjbAI+aal2oQNrePcnTZwYMaeq7dYQH43iG1pZiwZLae/
 l1iNIEf8j353oPOk6yD7SPrBrdNTZYRK49qgS2qhX8Z/Wh9YuyHu0ZPLRXAaCnG23MCbDSII2sK
 5T9wB
X-Gm-Gg: ASbGncuGvuuXDjncEvAxsrr04vu9q+Vhn7gecZJ2+2y4aF3tlC6VpbpaXIMtkvGyMiz
 MRxdEmUHbtJs3woVY1R2ePF2I6hjoNPXQlqqPRTvhXIkgMYp9IpXoiJ3ck40/9HvURj1VL8KMbz
 bRV/cgVxQg5uzcMG2VYz0Mye3uvbi83Q7j336MYVrETwCg9zDLFV8TZBQLu3w440lt1promU1uF
 ROroG199GZ0brzOpj2m2WQdnCPSWYJLRJZJAzts28t/d9Co+GjqUzkEAe4EMxXzm54+WW/+UjsR
 evF8oE27HZjYgwzA5DhE/CmwxVK3iluNYPvpfm8AXUfqX8jzZyp2q5UphopRlkFcfCndMTEz+3S
 bUalk4DEeqLu/wP6BETTagIqgH/7iW8+H5u4AND0Lu1lNy/UXTVMp69QYRSgAn/FloF6X2bCeXw
 0GBOziIXMEt7UdsmBD1D9NOD/Qa7U=
X-Google-Smtp-Source: AGHT+IGvwddtkyPYNqf92j0/C7poDMQZA4pwpWPlj2JfMAsLFjdFhtl6AbKuUj0IFPR5BjSJRov2Mw==
X-Received: by 2002:a05:600c:3b0f:b0:477:557b:691d with SMTP id
 5b1f17b1804b1-4778fe9b23amr30696135e9.25.1763133678808; 
 Fri, 14 Nov 2025 07:21:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e8e798sm146772835e9.10.2025.11.14.07.21.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 07:21:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/10] cxl: Clean up includes
Date: Fri, 14 Nov 2025 15:21:06 +0000
Message-ID: <20251114152110.2547285-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114152110.2547285-1-peter.maydell@linaro.org>
References: <20251114152110.2547285-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This commit was created with scripts/clean-includes:
 ./scripts/clean-includes --git cxl hw/cxl hw/mem

All .c should include qemu/osdep.h first.  The script performs three
related cleanups:

* Ensure .c files include qemu/osdep.h first.
* Including it in a .h is redundant, since the .c  already includes
  it.  Drop such inclusions.
* Likewise, including headers qemu/osdep.h includes is redundant.
  Drop these, too.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20251104160943.751997-8-peter.maydell@linaro.org
---
 hw/cxl/cxl-mailbox-utils.c | 2 +-
 hw/mem/cxl_type3.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 68c7cc98912..6cfdd98168f 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -7,9 +7,9 @@
  * COPYING file in the top-level directory.
  */
 
+#include "qemu/osdep.h"
 #include <math.h>
 
-#include "qemu/osdep.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/cxl/cxl.h"
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index be609ff9d03..4f3688a71b6 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -8,9 +8,9 @@
  *
  * SPDX-License-Identifier: GPL-v2-only
  */
+#include "qemu/osdep.h"
 #include <math.h>
 
-#include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "qapi/qapi-commands-cxl.h"
-- 
2.43.0


