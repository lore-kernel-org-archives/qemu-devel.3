Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD56AC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 06:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhkWG-0004yE-Ey; Wed, 06 Mar 2024 01:12:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkW1-0004tG-VA
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:12:34 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkVq-0006En-QG
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:12:31 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dd2dca2007so11351295ad.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 22:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709705541; x=1710310341;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uEl9gr+JRIy2uRLCAmnmdcgL5kP09OBXfeuQ6yoOxrY=;
 b=rQrAES2FrN53fNKZs9iGNtBiY/cuhz73CxP+Z5StyrungnV6cyLwJXJawEF0yXmziQ
 uLD2urLqcGYVYFSDVlAa38iI1SDRBDaOD0xRgJ+mJcK4cRJNi67QAjaCm8ZbhNWu2T5L
 Glh4Qc8lRyt6yLrjasn8vqhwg8iG15xnqEYndbyTw/AY4pA1vNCMZBVwFGPVdYpy1kmS
 UorGyu8p5xIVonfh6gg4jT5aUySXY90gsfZYaeugzcz1CUhuLOiXXzoKabZxkzWYN5mR
 q/vDVyYJsPMKLjfPoTXWWcUyXb8xe26EClEP2w1cd/Q7yvZM21aihHEgNKxcifcMbUSS
 QC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709705541; x=1710310341;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uEl9gr+JRIy2uRLCAmnmdcgL5kP09OBXfeuQ6yoOxrY=;
 b=nVQ6jNJSOGk71uOpsciNNqH1gXitTbhqrbJIek6Lv4bHVI0TxZHu+35PbN5C98dGxl
 b8+biOCAjimZ79CUopOSJF4HA1szWEhPeJ1L4xaJ7JIuVxIKvfcLcNunuOGC8ZEKQSwG
 5BhN3O7mR5ytFzZU5cBpyGlC76iEvBZUSOKu9/IxbwDuzNmTaVEh8Amy6HV75LtSoD7r
 Ja4XJvW3qrvMPaoVa7Eyq3JuhoD+QD+c+5cF2sgHXIns3CLkpmuszrigeAmXTCjGCarK
 hE+c73wBr1qrZk2vT8IpcLg34bdQN6S1V3fECOXPFWRKqJjluoLi9iyV+dKQGIL9T8r1
 Rsiw==
X-Gm-Message-State: AOJu0YykSB3AVlcmKFs7qh8iiMcUb32BCwmOQiP7pabVOqQq6VaCn8tT
 JGZRukpDjz340k9H48VSoPfQUK4Xhke+hfsndQTdYPPm0PLRsiUCppGuJ6zcGko=
X-Google-Smtp-Source: AGHT+IGnrQtv9CU49UlrunUwPuisZ0cy6FKJehTDJv0w89pgyt9DfJRJLYbIIWyzbgZ4h3MoPRdWug==
X-Received: by 2002:a17:902:6b02:b0:1dc:af82:98b2 with SMTP id
 o2-20020a1709026b0200b001dcaf8298b2mr3772218plk.43.1709705541061; 
 Tue, 05 Mar 2024 22:12:21 -0800 (PST)
Received: from localhost ([157.82.206.27]) by smtp.gmail.com with UTF8SMTPSA id
 kz12-20020a170902f9cc00b001db8f7720e2sm11647298plb.288.2024.03.05.22.12.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 22:12:20 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 06 Mar 2024 15:12:09 +0900
Subject: [PATCH v3 03/19] contrib/elf2dmp: Continue even contexts are lacking
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-elf2dmp-v3-3-d74e6c3da49c@daynix.com>
References: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
In-Reply-To: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
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
 contrib/elf2dmp/main.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 9b278f392e39..86e709e6da3a 100644
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
2.44.0


