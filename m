Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A69CCFA07
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGJbs-0006nx-IJ; Tue, 04 Nov 2025 11:10:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGJbf-0006hp-36
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:10:04 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGJbY-0007Kt-Vi
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:10:00 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4775ae5684fso1765915e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 08:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762272593; x=1762877393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/9TOmFmIqhyuzG6e0MA/YDMsMgH5yDWNQ+TpSTSyVlM=;
 b=Bs56HUKH2nG5hbzhOsWryzm5lFyYOeOD4V4tb1uOmYOE+GjYTJIAXzo6aBcZoXZZ9n
 trSVH1morn+tMx4CQJIFinKhq4nTZZVAbS0zBtlyJyab+ufyvDUbRwWALQgv8ix3RqRS
 3ofUyRug0U42s//FP0tkPZ6RcUy3YgKv+tzU5nCPMAKtyF6QPMfjuY9U5B2dOTBdRzEH
 4vSW/72O1Tv0/PSXC01ZXPlKKxZEFgmRoGgmzfmrsJpHGb4OY1tb3/zUCyJaV1JjSrD4
 51PBKXNp1gjrftGher+iMjX7TrfG+rEGu6OTNKEqkPBJQVYswaZklo5OxkVJXw4VeudL
 b6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762272593; x=1762877393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/9TOmFmIqhyuzG6e0MA/YDMsMgH5yDWNQ+TpSTSyVlM=;
 b=XwDf/iedh/5bUwpkG43kotVfk2HkH/FQJA0WksGL5qDHEBw2YGOphgRV6H9kLT151A
 3tFeXaqXotv97z59mXcamIykxJdpEqwuHIWDAUh1KzNyRaks2fUJNfn3LuYkBMuUq/Ez
 J9FpLcKPcs3RQ90pcYXxvEf99AFBV7cpE6P5JEjIdAjV5JN0P7+hWGINz89Hi/x7frpT
 tmiEpjOWO3QAgX5t1F7Jy2hdFRCfUNiteBwNRpciZGiOhXne0EcNJ9Ue0Yi6b6ZO+aj1
 NiSuyPQTEOCnpZSRVoPoj1l2juo0ykwxgpa20sgoLiGI2eAiyigM1nvY++bFXEvr4hQl
 18WA==
X-Gm-Message-State: AOJu0YwlQnjLVVxYjC3EYtt728/LoAt/aRlqbW69gRH2CCPd0dhk2BpL
 RYrMPGhyAjRWXqKo0k+GcALmCEZBPXFKHRucVRco49QiYXumv/uTVrVUs9sRmVdVITSkTBm2cHv
 DY9pP
X-Gm-Gg: ASbGncsSCLBgsWRlbBXuGztOgg9E8sXPBUFIzcdA99aXnjPGeE+Lo4DUsU6jo8vX2GT
 +0B88L3taoJD/moStwLpDy/GTsJltYlgWVvJ78EkoSMLzNvhZrmgMmjHMeprBNxruFh8ftfiS3g
 Dw5+7laEnXdy6CsiGEWQMgm9zngfii0yUf1XivELeL81NBH/YFya6gF+zjgCvg7u4xUetwFbe/6
 AZJ4dA3OVPqPgt0tQAQjVkdk6wpo9zEtyVPZz0LI0r77OnCwbyWkDFU/F5vqdYpDmimeZKFXKTr
 tvH1+4Lq8Ob2OlTxIlNEJAjiEbM4rwikjLeqCsZq7G+al9sfH9CH6w52zUqj3ovwFTVepoEYhql
 wxqTY3h4jpOYr4CuD3m7hit1x8bZCv6z6yj7ztUcxs/N2Os5PjeKg6pAE2xz2+NscUVASWBuk93
 O5jgh1Ag==
X-Google-Smtp-Source: AGHT+IEboKozT2T2SPgevny/csOvI2uGVEwGbCoFmhWGnzRiVRI6S1l0aXX30LlFysEsypR7bOYY9w==
X-Received: by 2002:a05:600c:3511:b0:476:4efc:8edc with SMTP id
 5b1f17b1804b1-477307d9920mr141491715e9.15.1762272593390; 
 Tue, 04 Nov 2025 08:09:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47754adcd08sm57314455e9.5.2025.11.04.08.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:09:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>
Subject: [PATCH 7/9] cxl: Clean up includes
Date: Tue,  4 Nov 2025 16:09:41 +0000
Message-ID: <20251104160943.751997-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104160943.751997-1-peter.maydell@linaro.org>
References: <20251104160943.751997-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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


