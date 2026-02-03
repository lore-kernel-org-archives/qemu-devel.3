Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C5FE8B362
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 20:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnNSM-0006gV-HA; Tue, 03 Feb 2026 15:57:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnNSF-0006dU-I3
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:57:01 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnNSC-0003VB-Sg
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:56:59 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c65822dead7so2440877a12.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 12:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770152215; x=1770757015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FKrFbIzO+OqhM9EqMf1DvtMtDYxv5MFzwPEplnrkp6c=;
 b=fmcBLdhmZq1IhD0XziawWDhcIZSXNUClujxKPLGcasp4Ij5H/LFs9Q7tBjkxt+6oTB
 xEeNqp2/jKzZH7EiImAIyHtJaVcNHM6YBzreubl/GwXzO+wfgtDg7hgJEcoFrBlZcNUb
 IGfhSe+S8mtON803lTLRa+pgYs574Lrd/d4YBxoetXFV0qMCZJPaxDimlUtQ/sJgsBXR
 FsZS0tlJIHi+fwDRFsYwG0tcy4WqV7DDsxuxAZIf4gLDG55Zp+Hc3xqZMhkKKtSzRoJH
 lIm2tJffkoJFlDS45JUFPqMskJctFZXPxYut4nr52Pe5nPidxFQF6KQX/IPVNquG2RFt
 KI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770152215; x=1770757015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FKrFbIzO+OqhM9EqMf1DvtMtDYxv5MFzwPEplnrkp6c=;
 b=YS0xEuYWZu0eLQcFbxdNiKs4Okv5VNZHxF5z+kZzRL2bTf3bzcdoiMv814jBdm1HdZ
 /fFNeFaxHo9LtSoQOuLsDk/Vjh6t851bDhWVwRRW1oNhfrmoLPTFrK8Dg4x/p9B4YwwF
 oLPRdu9OrCn12FvuuObH4Lpl0XyWDukyShSxFDuz8e9FC0J1f+t77tO3ojpXwKtavRpX
 A3OyzcA5oIpgzZjG0WJh+BfXHRJpWQ2p6ZE2eaGiAOJVX1l1ir1WeJtY+rDyiP5knuKf
 d/+NVgYYiuBVpfH0WCBJGgY2vzL5SkBa+e01m8BJ9Hk9oqd0dkpWuuN0JIVEUVEcqliD
 C8Vg==
X-Gm-Message-State: AOJu0YxESzCtdT6e7nbkvIZBAmqRrpVaF/aNXSCi3GfqmoCO11VaG4ZK
 XXNyn5suTpMec9E2zoOI3e/n1zN+3MpYyBuLPgydmLvhs7Y20cCAPHnHagRJm62QE0wd+/BOgFa
 3zJrsqr8=
X-Gm-Gg: AZuq6aKpcpbDsh0pLssl6lzn1LwcYAR8QOHiKpvlxqFBMRQn5HGZ1222OZl0tb3oKBy
 Nu2SjvaDqytmyHYBEA1H00AywjedivxuYYuYRTZdr9t6biIDmHRXFlO/BiU8SmXqpZlJQieGpAJ
 DU51o3uJGqJYWCvs4+MCet+lR/RSrxihcgS1a7ZnhKsOvz7YXBt+wjAPyUtxmlmATb0j6m1aKh4
 oYkDohOFexN2KyxYxkDE/7/VQAyYoJOsYfv1wSaEmfN684Qoh1X+gGvLTWLUbek7QyP4riITxoq
 Or4ZI1E9hWG7QAgaa/DDpIeW/FpS2HNH9sVgsnyA7uC09a2/2gwp1b4jqmr8P6zr+K33adoqvpA
 z6F36/2fGYJ9ygYed6EHlEw9JIkkFmnhZMJapmX8vzjSzKZqaLIIWtRaaQPHs8eri9zUo/9LZPj
 v57oC4R9WEM+vSk4wXSCFpJcSmE7vcxJu3LXy9mLSjFovnY5EZMiM3g6oDDde5XJGg
X-Received: by 2002:a17:903:2391:b0:2a9:2ab2:e50d with SMTP id
 d9443c01a7336-2a934112c06mr3679725ad.51.1770152215395; 
 Tue, 03 Feb 2026 12:56:55 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a9338512f4sm3612875ad.9.2026.02.03.12.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 12:56:54 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v4 6/9] include/hw/ppc/spapr: extract SPAPR_MAX_RAM_SLOTS in a
 new header
Date: Tue,  3 Feb 2026 12:56:34 -0800
Message-ID: <20260203205637.3109749-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
References: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52b.google.com
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

Allow to include it from common code (vhost-user, in next commit), else
it pulls ppc/cpu.h which has target specifics.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/ppc/spapr.h        |  8 +-------
 include/hw/ppc/spapr_common.h | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 7 deletions(-)
 create mode 100644 include/hw/ppc/spapr_common.h

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 5476ac7ce7b..b022f8dd25d 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -4,6 +4,7 @@
 #include "qemu/units.h"
 #include "system/dma.h"
 #include "hw/core/boards.h"
+#include "hw/ppc/spapr_common.h"
 #include "hw/ppc/spapr_drc.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/ppc/spapr_ovec.h"
@@ -946,13 +947,6 @@ int spapr_rtc_import_offset(SpaprRtcState *rtc, int64_t legacy_offset);
 
 #define SPAPR_MEMORY_BLOCK_SIZE ((hwaddr)1 << 28) /* 256MB */
 
-/*
- * This defines the maximum number of DIMM slots we can have for sPAPR
- * guest. This is not defined by sPAPR but we are defining it to 32 slots
- * based on default number of slots provided by PowerPC kernel.
- */
-#define SPAPR_MAX_RAM_SLOTS     32
-
 /* 1GB alignment for hotplug memory region */
 #define SPAPR_DEVICE_MEM_ALIGN (1 * GiB)
 
diff --git a/include/hw/ppc/spapr_common.h b/include/hw/ppc/spapr_common.h
new file mode 100644
index 00000000000..d799927ff5c
--- /dev/null
+++ b/include/hw/ppc/spapr_common.h
@@ -0,0 +1,16 @@
+/*
+ * Common definitions for PPC SPAPR
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_SPAPR_COMMON_H
+#define HW_SPAPR_COMMON_H
+
+/*
+ * This defines the maximum number of DIMM slots we can have for sPAPR
+ * guest. This is not defined by sPAPR but we are defining it to 32 slots
+ * based on default number of slots provided by PowerPC kernel.
+ */
+#define SPAPR_MAX_RAM_SLOTS     32
+
+#endif /* HW_SPAPR_COMMON_H */
-- 
2.47.3


