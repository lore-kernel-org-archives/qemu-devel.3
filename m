Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EF4C28B24
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDXy-0007gl-Do; Thu, 06 Mar 2025 10:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDVc-0004XX-EB
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:51:40 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDVF-0006lY-IM
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:51:19 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43bb6b0b898so7185765e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276275; x=1741881075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lZf/YeQK4lOJ/RgUPpd1hWKDiWEJL3iQUsYLZBcJWdw=;
 b=wz0OYe+6S1Sl1L+lIGseAr/MPaAlFFlq188YkULfiOBAouOU1s44z2vVqatRYxHB6c
 xJ5LEgvfNACLfGzF5K33XdOuYG3ZfYp0pjFzEJpO/dsULNvDF5nMOEJPkLUDzvDsP3pd
 hiPaWcsfUV9HS2ZvRjIhigq2ZZ1jT082I2cLjlXV3JwXljVu07XJlv8eq+8NUdZigoSE
 I20HPD9nikBrj6oOJ+PkFCF2Wdb+HFjnaerjiLvLEuKctYgefVWeYfUgwc+UWcquz3SW
 J/FXTM4Ee0gRcjp+NJrb40mo3gwQv3cxyC7MtMZvaICdESWqGLG2tv7xNKt6Opa2hN6j
 NX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276275; x=1741881075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lZf/YeQK4lOJ/RgUPpd1hWKDiWEJL3iQUsYLZBcJWdw=;
 b=utkpCjBFbMV5Losxph3XITMVnngac+HP+qsG7NIBdmTz2/VVsR+KPcm8bgVW9yq3fK
 ztl4ghlViypyrxiBL1qG4SI903uGvh4jkIXcQ2fdQ6xuFVMJGd74kNOYalVPUy4BIY59
 u8D82TG83/FVokzQ76xwzdAoncyFWYWscGg2rk2k3aH3w0B5WOinx1T6F+e3/4nR5+pp
 FQ7ne01Pb/HgLSt783v1my9YWzAcQZwXrzWa7dRgtSYnCQAK1GEVAEswuHvBW4lvsNya
 d8p9Tj75DohN7WA7wSdASnN5oqsxtFlCusAqvaTEc2us6f/KjJHnISijW6/TUHK6JF1B
 xx3A==
X-Gm-Message-State: AOJu0YyPhwihIby+Mm6AURC4qFegS/CyGpErJWrfAibFMPgBBlDfc3dm
 3K8Iejt8mHssTeXl4wb04AuplXPwiqeUFiwuvdDOtL5ivFa2R06aao+n8YP5oI/0ynkpvASefXl
 Rv2I=
X-Gm-Gg: ASbGncv0t6pUooTm3BacrpstgXUvV6JNDGhC0qVoAtzpIXDAU+/pW6BhJnPh9IZt3Ws
 EDCOQbHiJyCOxqA3llj/FjD4EbVx+ZgHsYPqHkEViSB7lXwRpacALvfTALzmzBUhov+6SbEsQ/2
 p2tWZc47rD69smg+BfhfHp3+2aNB/r5Re5Nm5NfyhOlTpTOXNyhozcnm3TBdGmwrgNR6VBVY81I
 4CgkWquWB2/wQuA275C6Hlyx1IJCdcBU+wzWABhvwLSOLWsOlHiEiwC9UWI1jTw4cKTtnvnIuk1
 OJic6xFqib6E41Vv9SQ+T1lfhPQdxyg/3lrOt2L9I7gH7iw0sTrXrAUtAVGDhXCmgQUFqRRclSn
 FgdMNGKjWdWto1Gz/idY=
X-Google-Smtp-Source: AGHT+IHrC4i2hWa9IHhCr0+U3N6KCaNFSn7ilbroBAcO5aNcXxSpToAJF5Q1NFuia5UH9SXRONtSQw==
X-Received: by 2002:a05:600c:4f51:b0:439:92ca:f01b with SMTP id
 5b1f17b1804b1-43bd29bb5f2mr54974405e9.13.1741276275496; 
 Thu, 06 Mar 2025 07:51:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd6530f26sm49579485e9.4.2025.03.06.07.51.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:51:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/54] target/xtensa: Finalize config in xtensa_register_core()
Date: Thu,  6 Mar 2025 16:47:30 +0100
Message-ID: <20250306154737.70886-49-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Make XtensaConfigList::config not const. Only modify
XtensaConfig within xtensa_register_core(), when the
class is registered, not when it is initialized.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Message-Id: <20250210133134.90879-4-philmd@linaro.org>
---
 target/xtensa/cpu.h    | 2 +-
 target/xtensa/helper.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 0e6302c5bd3..8d70bfc0cd4 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -490,7 +490,7 @@ typedef struct XtensaConfig {
 } XtensaConfig;
 
 typedef struct XtensaConfigList {
-    const XtensaConfig *config;
+    XtensaConfig *config;
     struct XtensaConfigList *next;
 } XtensaConfigList;
 
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 2978c471c1f..f64699b116d 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -173,9 +173,8 @@ static void xtensa_core_class_init(ObjectClass *oc, void *data)
 {
     CPUClass *cc = CPU_CLASS(oc);
     XtensaCPUClass *xcc = XTENSA_CPU_CLASS(oc);
-    XtensaConfig *config = data;
+    const XtensaConfig *config = data;
 
-    xtensa_finalize_config(config);
     xcc->config = config;
 
     /*
@@ -195,6 +194,8 @@ void xtensa_register_core(XtensaConfigList *node)
         .class_data = (void *)node->config,
     };
 
+    xtensa_finalize_config(node->config);
+
     node->next = xtensa_cores;
     xtensa_cores = node;
     type.name = g_strdup_printf(XTENSA_CPU_TYPE_NAME("%s"), node->config->name);
-- 
2.47.1


