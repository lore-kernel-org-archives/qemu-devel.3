Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBD5C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 14:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgPuD-0005Gd-QS; Tue, 20 Aug 2024 10:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sgPs5-0001ve-Eq; Tue, 20 Aug 2024 10:30:10 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sgPrz-0001X8-W5; Tue, 20 Aug 2024 10:30:02 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52efa16aad9so6910456e87.0; 
 Tue, 20 Aug 2024 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724164196; x=1724768996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N6K1JnQDB3GxWbgLc2L3O0RRJjZo+EVTDK5d5nCO5jo=;
 b=cmvN7qBaYXqERhqeCKewVAtXXP84WgIwc80yx/jb/ihfB3XsQZtDFH1jf/fGRO5kK0
 +1tXLpTn7T2Il0+Xf5k/jLw0WkYFxKs2QR+zPRCAiWmm1QUU1hVw6EKw87a/KjvSIOg+
 Ellh+z96mHlcE/UQsFHoOJ5pYvRhdi4AE7t8SBPiG5F30QB85p+c8wx0COOWrBVNz5a/
 9uaMcnkXe/KdwVnle9ggjbuY5up0g0UPtiiii2WUbgV5bg3iNN0z0S94MpbBmg2rqqj8
 c9HjjulnWntmnVsAYnqnHczPaIpv3KIX2YnYZ5qLBSQFMuajLdyeu5H+l9ZcbPCkSpv+
 7flg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724164196; x=1724768996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N6K1JnQDB3GxWbgLc2L3O0RRJjZo+EVTDK5d5nCO5jo=;
 b=ZV+618zq/yUx6bMyAIIsgYXavQxmBLrbby0U3aG1/hSNbFtI5L4sSRqXTftm8vU38u
 YeH+3J90H4au7m7iaGDArYbvbO67kEmLGbxBpsNZfnQjmSTQ3shORW15+pEqnVpLGuxG
 /eu5+oQ6b92XlxfNC3yF3eXZmZ+WqOBAKcRPSKHMKeB36ndE7KEX03qqYLWdSi0OEcbc
 oCFx9ASgSKkTXbIJubrrmfJbgzvcLYIA3vVuBTcOaeB3QqGMyo7mzDFLgz4KQFhgi38t
 eEVKTRO4Rz3cL5aCDB0Kb6cGb39Hu5pHUJhMeLLFwewSER8HtL9PNko9n9CpswqvcPD/
 V4Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX2hpyhThxBIMKI3YP5vfxLuMcRhoHFw1mwnuJYUg+0YwzM8WOlNOzTmaHHnhEmfRYVx0diLA4NJEoNJMPwXGd1viT
X-Gm-Message-State: AOJu0Yze/Wplt1/CctIotoBwXAXvmEvYpLN3wa4Z6MlITQvlXALYsLfq
 11AcG34g0ItkvATOg4sYsyNWPt9yVDkExE3Jp8DFf7IEASF7QjASv+YAI8l/
X-Google-Smtp-Source: AGHT+IERWznLEeJJPBmVGgbqZsGGHpjiqbNNsmHg/7CXZqA1iSzt7K9nFEzoO0ph3Q9aeI604W1JJQ==
X-Received: by 2002:a05:6512:138b:b0:52c:e3bd:c70b with SMTP id
 2adb3069b0e04-5331c690c37mr9543219e87.1.1724164195374; 
 Tue, 20 Aug 2024 07:29:55 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53345d17c33sm53420e87.128.2024.08.20.07.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 07:29:54 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org
Subject: [PATCH v2 02/12] hw/arm: xenpvh: Update file header to use SPDX
Date: Tue, 20 Aug 2024 16:29:39 +0200
Message-ID: <20240820142949.533381-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820142949.533381-1-edgar.iglesias@gmail.com>
References: <20240820142949.533381-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Update file header to use SPDX and remove stray empty
comment line.

No functional changes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/arm/xen_arm.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index 6fad829ede..766a194fa1 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -1,24 +1,7 @@
 /*
  * QEMU ARM Xen PVH Machine
  *
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
+ * SPDX-License-Identifier: MIT
  */
 
 #include "qemu/osdep.h"
-- 
2.43.0


