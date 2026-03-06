Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A94FCB611
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWfr-00064c-2K; Fri, 06 Mar 2026 10:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWfB-0004dk-Fk
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:28 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWf9-0002lG-QN
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:25 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439af00d33cso6153521f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809222; x=1773414022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SGKjJIVnX4L6WV2EWibcclqBxhacVob9Ke4Fe6IFANA=;
 b=fx0Kg1v8hQ00QpvNMwatcJ4qNJfCIStSmjAA69WPt/Mfad5e8NmCIKfb9NDKObHzYl
 yMFpaTyG9cn/XGD7g2O9870yJghRCl2PMbFa/qh1H+52/YLvsuyvtMqExqMlwwrHQc8N
 NNYvq81l82r1b3xrfggcI8tgiaNL+j8VsMEth6r3gJp63LXLMH1vMicV156RWnUFK48b
 krgcUICbXHcnUc7T+9kcNeQmXAVFFvUph76IZU8esawhWrClF3yboHV1GjglO4aVIKKr
 zeyGrwGHGDtkDIdWLN2TGsv7xQXcpfKowrB45mAXP1Hx0GCOV37vp30HQE35W/cbrEcb
 Do/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809222; x=1773414022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SGKjJIVnX4L6WV2EWibcclqBxhacVob9Ke4Fe6IFANA=;
 b=IEC1hgPe6H+8Qca5ZQxc0n02NIf+AOhb0HIgj1g52ImhLDRpb3NXzCPUckQ76MyNNq
 LAtZkJexPYPTGbW4S4Exr9/EM7NPBqp9vLxyjAtn9azjxTKTf1X/mx4TFohcrCdtfcds
 dq80ZXkCyO6guweM1gkLobfkd+F3YOljQyWvbPG5a4NH0cgFcfvowkKUhQX/pokijXNO
 /d2l7s8kYXeMHv4nzVINc18FYDxMI4J06YTd7s+ZZVJUU/4+eotLwHwgPVtLL35HBKL3
 O0SxTL3eT2oQQQwoksd6R+wFOPqsAVe6c5aQYARjEkS0I1/hfgPXwfWkQvqYwM/ZUvGY
 CX1g==
X-Gm-Message-State: AOJu0Yy+AOR3wYfEVkeXZabag4UO6hruajXipTrVAMBRsR+8JS8sw7e/
 MvqlwwayVbnAqRAjjZyfHd5IKYX2wTSj79BAzmmMGDNq1xiYQJkfIcumj4ngEIfjrBEomX6d7vo
 ab18z
X-Gm-Gg: ATEYQzzzagnE1ac/1Vpwg0mxppa+13+jNhXrrZheTIMfwi2qQAB/Ym2h4MAW1AQ+y7+
 kxeDyRH3k+pCQlPX1CZxPKK1mRg8FUDFRoPnIScrRlhZklUBfIrfilKQtowmKERWQtUSNEhh1SW
 38F8WH1jF2/009QKC0rJ3JVN8QHTQlGfqhsYZB81kuxHnP4nl+pgybkDQNKcc8Fha/i7elOsWTG
 Igq6rkYAB4ZUDiKdGfxLuBdbo4tvwoAdo+yChp90xI9mv4SEBx+xQdzcPEqGpW+8Ilh8ZfRCKcz
 3bQ/a42P2TY4j4mZVft4bw1eI6AYP1HgOEQgUxEun6rQK09QhjWu/vnHRUgJx2iiBeHBJqHKVGU
 eYURc4O2pagsMUL1votduEO8hjXstmWbw6lLlzxgXqVd2cMxWLJn8coCunweg3BkY75Wq8PcOyy
 F3xF7Q6234lJYC8Y0lyFbcJlV6DZtaH6LjAaWSkraGs6Y/sJR534N2Ul2mcC3s8z4vd9qBI5LUD
 T0hcCoxgLCF0oOt+7s3eiEko7FAPG1Swx78MT6eVQ==
X-Received: by 2002:a05:600c:a47:b0:483:71f7:2782 with SMTP id
 5b1f17b1804b1-48526922c02mr39062575e9.12.1772809221937; 
 Fri, 06 Mar 2026 07:00:21 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.07.00.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:00:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/49] hvf: hvf-all: stop including hvf_arm.h
Date: Fri,  6 Mar 2026 14:59:26 +0000
Message-ID: <20260306145939.2162189-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

We don't need this target-specific header in this
target-agnostic source file.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260306130107.35359-5-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/hvf/hvf-all.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 033c677b6f..5f357c6d19 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -18,7 +18,6 @@
 #include "system/hvf_int.h"
 #include "hw/core/cpu.h"
 #include "hw/core/boards.h"
-#include "target/arm/hvf_arm.h"
 #include "trace.h"
 
 bool hvf_allowed;
-- 
2.43.0


