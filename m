Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99B8C3DA4B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSF16-0002ps-3T; Fri, 12 Jul 2024 08:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSF0z-0002dE-PX; Fri, 12 Jul 2024 08:04:41 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSF0x-0005tX-U5; Fri, 12 Jul 2024 08:04:41 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70b702be5e4so334679b3a.0; 
 Fri, 12 Jul 2024 05:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720785878; x=1721390678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rvugC+PXW9/SGH9OMmAAj3pNBhyER7y8a5VmvcnVk/U=;
 b=Yi7K7CXr7Cvjx1kgpNyVOI1JqtWuamBb4h9lUqP7HJx58ks0WqDcndctLQnN8C+KMG
 SLzqz2qZf34MrArhI4koLF17VzRf2D/h0MfnaBh/il3or3OlfmTmD9lsnBtuhuKbI5dI
 lFPSXVWA9wj+QaBtL+NHMqN6h7TQFJy20EYm4tB365BIqQ/UensMlWoH+HXHdpwa/hLf
 ZXIdb9rDzL38+RvdW+CpDdUcWHeF+4jM5Y+RUgfmcC/kI+qbxNaJij1aNfDFlHYv6Y59
 II+QNHJpwTNOHWLOeoEeHJElK/r/71W0HQ889j7R3LgTVQ+9snR06Egjj8bw5eMqu1Vk
 6wLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720785878; x=1721390678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rvugC+PXW9/SGH9OMmAAj3pNBhyER7y8a5VmvcnVk/U=;
 b=n2U3tVldFgNvHPxt5UZududQ5cqO1G5dhd4BxlbGwE2wAF25GPrIu7MZzKDvflRBB2
 CsOqsLhsn6lYIbkANrXJ8budLQLV4xNt+Q6y8AJHmFZKN548qE7OBwgKDLvgz7B7vnj6
 WlCunxz9ksP1yg2T+iyVmc/VUuh0w4IL6436s0s3BofrEJU+KXxumtAz8qvU5sZFN92r
 Q1kclRzz4Dl7S17u/0XvX4IkGZ+y7kybJ+XdYTu9kz9BPzqfLQD652m1xSjIyPzQqq6M
 yjJLjsT/ifYQrEJRAy8QK361+LFqRBLzX+tXGY5RkGj4M2bDZGYkPU7atcK/BOirOLQn
 b++A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqFXRFmdSfTCz81OJ1AG89qzD1R3MCu1T9eaV11p5dE79LjZdUYvPa09jUwVjCxEDextfX1QkMwAl/iG1S1JDf5YTaTqk=
X-Gm-Message-State: AOJu0Yyw2P7XWXoztVkffgY3MHGU+kNloYZWp9lUhJhtcbDIOkmR2UCc
 ESqkjy7kZ6nK7qjk/qV15crurErFYHJam51aPoHpbZV1l1W95ndy9qJ0tA==
X-Google-Smtp-Source: AGHT+IGXakIlgwxW4ufbgqrF+m7wat1y2+yfd1cXnUIdYukAVCKolgcyLuDABEGkZQ7nUsqESRxlsA==
X-Received: by 2002:a05:6a00:21cd:b0:70a:f38c:74ba with SMTP id
 d2e1a72fcca58-70b435eaa3fmr13720110b3a.22.1720785877737; 
 Fri, 12 Jul 2024 05:04:37 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438c0a1csm7308967b3a.63.2024.07.12.05.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 05:04:37 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 17/19] ppc/pnv: Add a CPU nmi and resume function
Date: Fri, 12 Jul 2024 22:02:44 +1000
Message-ID: <20240712120247.477133-18-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240712120247.477133-1-npiggin@gmail.com>
References: <20240712120247.477133-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Power CPUs have an execution control facility that can pause, resume,
and cause NMIs, among other things. Add a function that will nmi a CPU
and resume it if it was paused, in preparation for implementing the
control facility.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv.h |  2 ++
 hw/ppc/pnv.c         | 14 +++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index c56d152889..b7858d310d 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -112,6 +112,8 @@ PnvChip *pnv_chip_add_phb(PnvChip *chip, PnvPHB *phb);
 #define PNV_FDT_ADDR          0x01000000
 #define PNV_TIMEBASE_FREQ     512000000ULL
 
+void pnv_cpu_do_nmi_resume(CPUState *cs);
+
 /*
  * BMC helpers
  */
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index e405d416ff..cd96cde6c9 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2749,11 +2749,23 @@ static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
          */
         env->spr[SPR_SRR1] |= SRR1_WAKESCOM;
     }
+    if (arg.host_int == 1) {
+        cpu_resume(cs);
+    }
+}
+
+/*
+ * Send a SRESET (NMI) interrupt to the CPU, and resume execution if it was
+ * paused.
+ */
+void pnv_cpu_do_nmi_resume(CPUState *cs)
+{
+    async_run_on_cpu(cs, pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_HOST_INT(1));
 }
 
 static void pnv_cpu_do_nmi(PnvChip *chip, PowerPCCPU *cpu, void *opaque)
 {
-    async_run_on_cpu(CPU(cpu), pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_NULL);
+    async_run_on_cpu(CPU(cpu), pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_HOST_INT(0));
 }
 
 static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
-- 
2.45.1


