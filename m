Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE66C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjl9S-0006es-Js; Mon, 11 Mar 2024 15:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4r-0003Js-D5
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:12:53 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4p-0000M4-CC
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:12:49 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41332865b05so379135e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 12:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710184365; x=1710789165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zc+ckQmpBvqBoIUO6cJJ2qIcD3yUGjjQZyKjrxix+5k=;
 b=p8059nxJ/VmA2lq1S2u6oaqz3fQHYPU8WQxweqyMc2Vf96A1t4WqTUeUTLJr9OkSp2
 YQ0YySl8tOJOk7Xq0jVxIaw8Q8FqN8KW7HliCxV5iIgZilVTG2qjVcu0OjFlYrQpx1Rt
 8JqlzqvsSk4KWX+edQfxS0w2J6sRRVXws+ig893alqvin2BLQcGyZZReGDTBzlt3yFI4
 hzTz2YZ90sLXsAt+LnNexZhuiRR7FsTHkzvzz4UCvVO8TBKP5KiHM55mAeAFmJXo4/ST
 Bo8/OY9xrdAYprR3lbr5a3N95TGFRO2fQVBZZJdV6OfeAoX3WAmsYNNI6oXdnY4Saxjv
 CpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710184365; x=1710789165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zc+ckQmpBvqBoIUO6cJJ2qIcD3yUGjjQZyKjrxix+5k=;
 b=dwX9xjsf1Rsxnx70/Jl9Z7KO0IfxNrMaSHpNrTCT3flsQ5fuzOMecg/DVrnV/f6jqw
 dH7yMelKL+QtI2NTvpDNR00e7cSO+hYlz4oouoeJdKT5uWIN2FgHnPccANpT0CekrCZp
 1F1oiAmS1A2EJbE9ReXaKM6yqk367aEQSsJ4gIj7WsKQB3UZ5wZSLc8bK1Lz/vMtPqYL
 6wM3oYsgKl6ayZOh2t4TnzELjR34p8cZGI6ruju+kzDSQsuZg4A1lUoXRYQvUyc88OH0
 tW9TWe2iGd7sf03CSqjsF1TvXotp5drBsRzc6g0edwGGh6CHuxxx5dymRQrvW8X3kvys
 6plA==
X-Gm-Message-State: AOJu0YyOgqG67tSljY4OfzVboHQ9PoVsfBBeWSq9iiokK3QyAfyd10Z5
 j+pHCP9R/yo885GLhrYmL/bIidmQY8cZJaeXz3SqdcMJlfZeaWV3yVKqcZqDuJMknz/9wthMHef
 d
X-Google-Smtp-Source: AGHT+IEKiT/PkSaXQlafu0tV4AKLhIPMNb/4pDzsx/RwpwrPDX6IYdQwMVK8KWACiQs1fLhB8G8YFA==
X-Received: by 2002:a05:600c:4e4e:b0:413:15fc:231 with SMTP id
 e14-20020a05600c4e4e00b0041315fc0231mr5142454wmq.29.1710184364730; 
 Mon, 11 Mar 2024 12:12:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c450a00b004131388d948sm14425266wmo.0.2024.03.11.12.12.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 12:12:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/20] contrib/elf2dmp: Continue even contexts are lacking
Date: Mon, 11 Mar 2024 19:12:25 +0000
Message-Id: <20240311191241.4177990-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311191241.4177990-1-peter.maydell@linaro.org>
References: <20240311191241.4177990-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Let fill_context() continue even if it fails to fill contexts of some
CPUs. A dump may still contain valuable information even if it lacks
contexts of some CPUs due to dump corruption or a failure before
starting CPUs.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Message-id: 20240307-elf2dmp-v4-3-4f324ad4d99d@daynix.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/main.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 9b278f392e3..86e709e6da3 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -336,8 +336,13 @@ static int fill_header(WinDumpHeader64 *hdr, struct pa_space *ps,
     return 0;
 }
 
-static int fill_context(KDDEBUGGER_DATA64 *kdbg,
-        struct va_space *vs, QEMU_Elf *qe)
+/*
+ * fill_context() continues even if it fails to fill contexts of some CPUs.
+ * A dump may still contain valuable information even if it lacks contexts of
+ * some CPUs due to dump corruption or a failure before starting CPUs.
+ */
+static void fill_context(KDDEBUGGER_DATA64 *kdbg,
+                         struct va_space *vs, QEMU_Elf *qe)
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
2.34.1


