Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A5CC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 07:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPMj-0006X8-QU; Tue, 05 Mar 2024 02:37:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhPLu-00067p-FM
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:36:43 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhPLq-0005r7-VH
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:36:41 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1dc49b00bdbso48092875ad.3
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 23:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709624197; x=1710228997;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dNi2CODBILcZJ3pornZRE2FYjihFpsMHPvoOvkX8mDc=;
 b=YJtnwlH3TYKARwQTedLbVGSQNeuwx3NugHPWQEbXR9HAgvfr4S5Ux1bH/HQh1LVm8g
 BBM8RWo+28/fbIjTOQ2i6+U3xigRqWoN0RbC88ZHZQ2XrEUKqX2L4MS9FhQXFF6gAawj
 C9FrejFF0DWKeAQCkSNjTvLUR3wCa4O6LC2VI4bPrrt8Q2OKxfkL+EgcOJpyHkXgJ0R5
 2GtxM+aMunFPcXUSfxU9mPEPGcFQwKvdRdbBmGPPXK8M2FdcSHF352jQf4DpIEXzjFPq
 9opAnrFlx2krO+FOoFfAPaYk3ObELggUEKS9d/2HTQ2E5Umc3LtsSLQS5fC8hParGS63
 QVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709624197; x=1710228997;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dNi2CODBILcZJ3pornZRE2FYjihFpsMHPvoOvkX8mDc=;
 b=uUlAbyo3BT8omPjxl2JW5ujbX8f3p0UmlHSYbCPKWKd37iui/lD5zoYkR2nZ77ck6v
 deF3rELXwm67PSDt6G9J28G77hDrqHITpFmBlGT2z36ITMa131rrUUgxiprc//2RHpdk
 gdgxAfXwfR55+xW4r55ptF8qIcZ7qb8WxSU/OWOHWWRAzIPhcSHyd/wTVJ3YWnqCB8Sw
 zsbo5Bc1kBSYMa23tvkQljATCNCn4sviHu4h10cp/aUfvR9SHr0lveD/CMYwM7AMrZta
 xZ5p5gwKuEfuA3oP0xyiy2leukOk1qWrW0TNMAXmyIlS9rDIZ6gl02MGVjFyfIh5Zx4k
 MCJA==
X-Gm-Message-State: AOJu0Yz2xuJ+paP6CT/QYBh86lX/h0PagUnMW5h13VulDinkwO38fby7
 A69XuVixNjS2rgu+0OyI9HC85GXdZgJZ5cWYOHxnBzfTO/F2tm9fInY8RLTdZ3tC2y3oPhZmSiC
 b
X-Google-Smtp-Source: AGHT+IEjw1wkFY0spBfs/nxee99IMG11NMdPDQs85sISzCkuBEVDYT6GwkbtvzNIejOc4L7hd3H9FQ==
X-Received: by 2002:a17:902:a514:b0:1d9:7095:7e3c with SMTP id
 s20-20020a170902a51400b001d970957e3cmr1002127plq.57.1709624197590; 
 Mon, 04 Mar 2024 23:36:37 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 l12-20020a170903120c00b001db66f3748fsm9750555plh.182.2024.03.04.23.36.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 23:36:37 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 05 Mar 2024 16:36:20 +0900
Subject: [PATCH v2 03/13] contrib/elf2dmp: Continue even contexts are lacking
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-elf2dmp-v2-3-86ff2163ad32@daynix.com>
References: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
In-Reply-To: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Let fill_context() continue even if it fails to fill contexts of some
CPUs. A dump may still contain valuable information even if it lacks
contexts of some CPUs due to dump corruption or a failure before
starting CPUs.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/main.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 9b278f392e39..89bf4e23566b 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -336,7 +336,12 @@ static int fill_header(WinDumpHeader64 *hdr, struct pa_space *ps,
     return 0;
 }
 
-static int fill_context(KDDEBUGGER_DATA64 *kdbg,
+/*
+ * fill_context() continues even if it fails to fill contexts of some CPUs.
+ * A dump may still contain valuable information even if it lacks contexts of
+ * some CPUs due to dump corruption or a failure before starting CPUs.
+ */
+static void fill_context(KDDEBUGGER_DATA64 *kdbg,
         struct va_space *vs, QEMU_Elf *qe)
 {
     int i;
@@ -350,7 +355,7 @@ static int fill_context(KDDEBUGGER_DATA64 *kdbg,
         if (va_space_rw(vs, kdbg->KiProcessorBlock + sizeof(Prcb) * i,
                     &Prcb, sizeof(Prcb), 0)) {
             eprintf("Failed to read CPU #%d PRCB location\n", i);
-            return 1;
+            continue;
         }
 
         if (!Prcb) {
@@ -361,7 +366,7 @@ static int fill_context(KDDEBUGGER_DATA64 *kdbg,
         if (va_space_rw(vs, Prcb + kdbg->OffsetPrcbContext,
                     &Context, sizeof(Context), 0)) {
             eprintf("Failed to read CPU #%d ContextFrame location\n", i);
-            return 1;
+            continue;
         }
 
         printf("Filling context for CPU #%d...\n", i);
@@ -369,11 +374,9 @@ static int fill_context(KDDEBUGGER_DATA64 *kdbg,
 
         if (va_space_rw(vs, Context, &ctx, sizeof(ctx), 1)) {
             eprintf("Failed to fill CPU #%d context\n", i);
-            return 1;
+            continue;
         }
     }
-
-    return 0;
 }
 
 static int pe_get_data_dir_entry(uint64_t base, void *start_addr, int idx,
@@ -619,9 +622,7 @@ int main(int argc, char *argv[])
         goto out_kdbg;
     }
 
-    if (fill_context(kdbg, &vs, &qemu_elf)) {
-        goto out_kdbg;
-    }
+    fill_context(kdbg, &vs, &qemu_elf);
 
     if (write_dump(&ps, &header, argv[2])) {
         eprintf("Failed to save dump\n");

-- 
2.44.0


