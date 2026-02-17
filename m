Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D54E6815B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 09:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsHrA-0000Yg-FF; Tue, 17 Feb 2026 04:59:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vsHqw-0000Vx-MT
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:58:50 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vsHqv-0001KY-59
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:58:46 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d4cb7e10efso3480575a34.0
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 01:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771322324; x=1771927124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mKoafgl9k/P7C/ae0FhPI1YFMXXnXfGrilpKysbRFTw=;
 b=bCHz8bSgn9DRjkIo61H7+l2yvds3TCuZouqFkeuouRB1nRzEBrLxr1BOaACQGPepZC
 Lj5eL4wMZ2/wfpAPJkg1gIjBTVhyw0T8DXibIj2jkI7gnby9lGdlByWckqgTE2hKQSEb
 Lzx4Vgw+SccqTbiKe3KuUU6/MXb0LBWzCmYOJnc+pZUnKTmLffZ36WbzRf9CC4fkH5+X
 rTfObHh2inM6/nTV1agArnGtfqCzVzuT+KB8DwkLvvVHHibKNMnphzDbMHDV+s8xUVfI
 VtWTtrWTRMkC0ZVb8ZwDdqCeP+M1kikeiMuyu0hM8lBEndnAB0fPxNHYdZ2wnm+Nl+E9
 dT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771322324; x=1771927124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mKoafgl9k/P7C/ae0FhPI1YFMXXnXfGrilpKysbRFTw=;
 b=GD1c/gl4mP5hSjB2SMHuQlfh11f2KyvUX9bvaUaJ32CrzrND+X8ICPfV2ZNPZYmx6V
 Jktm24+8jXbXTpNlyb41cB0CiCM2QsMiReJM0MvO4mv3KHmWC4sYVINP+vhd8MUPj5Od
 cF4AGqKmhNxg7LI4+3oDm6xlsqzjJGv9xxW911ZQFzwDYI1y/iXylW9VnXtNy7vvWrcX
 eUnp0gbpSW0W/u7uUcK/eFp+xWwGjEkAwQcSoNv5moGTPCFUNU79FDuCDh0I4x2R7x6n
 NiTMgNH0JkcXyQu2yT6knaPs6RUspE1dhlLn9HcmCRok+Bi/eO0k1Os47YK4RRlCXNPq
 SkrQ==
X-Gm-Message-State: AOJu0YxnrruaI1DY3R8Rkr9u9ujvsc2vhliRZRY5egklg/JSGnYUjos2
 fyfZW6jo5voHiAd54A8QtzBLOC1YOvYr3A4JxiMDxckFsyAElwmcLiU4Bup23UW8SVXZnDd/iwq
 a1V53
X-Gm-Gg: AZuq6aLsNNdDT6NjldcIkNK0YmuiY0SHnlIk1SEs2wLnRGr16eoc9fCIyxBfFYFUF+/
 WXTU1pMPNwmMGF5OeFUAFDAwAzYhNdQ7UF95JH+ayEGELy5OkjfftmdA7kMPCeZMzNEiH5mmE6z
 Y9qJJrW4be1C+fODETP6NLlBJG00VG0PG3bUsEzKSg2kNdPpXthlMhSVwf/iFKNaaqSZAUx2Fga
 5LBnJOKFx6lVahJYBzAbv2cTT0N0Gz5qKamdkc83xPrFeb0wx+B49pWcdXbp1GywRDRpcilC0eb
 XNaAr+iUe7vQW6CjPl5TBKldVaBlSbSjLPSrw+DwrMX/eX3z7zzZxBhTari7B3A46k+yUeHH+n1
 DS9vekgV4bEkqglXjG4LD84irEcjTId9OC1VgfxPXwzop77ecLkiCoeAGGqZBvo/ZeOHKR4Lq1u
 Tk6+wsU9ubebmv/fscHb3nKbb5lvc2cawF0KE7BngIlQmSwF3NkHzo485ZtkxncPse0/AlNbi+m
 R5UoNSkzhQcTeDwPsjXFm4XsNPRFIAvr9RugUxOk7SAwPfcJw==
X-Received: by 2002:a17:903:22ca:b0:2aa:d7fe:8603 with SMTP id
 d9443c01a7336-2ad17431b82mr99461555ad.8.1771321874944; 
 Tue, 17 Feb 2026 01:51:14 -0800 (PST)
Received: from localhost.localdomain
 (2403-580b-742d-0-10a2-dce1-aa4a-dd32.ip6.aussiebb.net.
 [2403:580b:742d:0:10a2:dce1:aa4a:dd32])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a6fa33esm99108675ad.13.2026.02.17.01.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 01:51:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 1/7] page-vary: Expose TARGET_PAGE_BITS_MIN definition
Date: Tue, 17 Feb 2026 19:51:00 +1000
Message-ID: <20260217095106.598486-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217095106.598486-1-richard.henderson@linaro.org>
References: <20260217095106.598486-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We'll use TARGET_PAGE_BITS_MIN in page-vary-common.c,
so expose it via "exec/page-vary.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260213182713.44924-3-philmd@linaro.org>
---
 include/exec/page-vary.h | 14 ++++++++++++++
 page-vary-target.c       | 15 ---------------
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/include/exec/page-vary.h b/include/exec/page-vary.h
index 101c25911c..3c77689ca5 100644
--- a/include/exec/page-vary.h
+++ b/include/exec/page-vary.h
@@ -20,6 +20,20 @@
 #ifndef EXEC_PAGE_VARY_H
 #define EXEC_PAGE_VARY_H
 
+/*
+ * For system mode, the minimum comes from the number of bits
+ * required for maximum alignment (6) and the number of bits
+ * required for TLB_FLAGS_MASK (3).
+ *
+ * For user mode, TARGET_PAGE_BITS_VARY is a hack to allow the target
+ * page size to match the host page size.  Mostly, this reduces the
+ * ordinary target page size to run on a host with 4KiB pages (i.e. x86).
+ * There is no true minimum required by the implementation, but keep the
+ * same minimum as for system mode for sanity.
+ * See linux-user/mmap.c, mmap_h_lt_g and mmap_h_gt_g.
+ */
+#define TARGET_PAGE_BITS_MIN 9
+
 typedef struct {
     bool decided;
     int bits;
diff --git a/page-vary-target.c b/page-vary-target.c
index 49a32b4fe5..ab92da4539 100644
--- a/page-vary-target.c
+++ b/page-vary-target.c
@@ -23,21 +23,6 @@
 #include "exec/page-vary.h"
 #include "exec/target_page.h"
 
-
-/*
- * For system mode, the minimum comes from the number of bits
- * required for maximum alignment (6) and the number of bits
- * required for TLB_FLAGS_MASK (3).
- *
- * For user mode, TARGET_PAGE_BITS_VARY is a hack to allow the target
- * page size to match the host page size.  Mostly, this reduces the
- * ordinary target page size to run on a host with 4KiB pages (i.e. x86).
- * There is no true minimum required by the implementation, but keep the
- * same minimum as for system mode for sanity.
- * See linux-user/mmap.c, mmap_h_lt_g and mmap_h_gt_g.
- */
-#define TARGET_PAGE_BITS_MIN 9
-
 #ifndef TARGET_PAGE_BITS_VARY
 QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS < TARGET_PAGE_BITS_MIN);
 #endif
-- 
2.43.0


