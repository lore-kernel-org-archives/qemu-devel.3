Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37303C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7BBN-0000zI-Ll; Wed, 15 May 2024 05:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7BBK-0000Pl-3U
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:44:18 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7BBI-0002U7-7A
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:44:17 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-420104e5390so39438005e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766255; x=1716371055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=420RbZAGJjbzrfJsdBQyYhnJyXLQSLvrDO7PgYHuwLQ=;
 b=BVDME0AIzTJ+dFcZe3yobr4g4v7+PFrZrwGMHFSJVwNwKu6uW9TEFKPUI39cqKlWVa
 5igAYy85rmMIgNLT1PDVz9m9VftW82U0FxdeeXD23uzaz4PH6CT8iHIDr1Wmk2I3zJc7
 rPyjESBQrHxmY13qhGUdvCgU6jth6v+/rxYXwFEOt6gcMG5N61FIyQf4Xzw1wzizqIdK
 kxBseh/3VNMjhu0MyINKULX4Eare1FW1lMeitS6wW7eEYm765VLdaTRGq00AlJZzlBiM
 yNXb+80IibAWYBw3IsF0gOiDlNkD6MAskRmbsF/jQjePM6qX5nWbx/7H+k61BU0kQ0pB
 gxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766255; x=1716371055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=420RbZAGJjbzrfJsdBQyYhnJyXLQSLvrDO7PgYHuwLQ=;
 b=wULmcE9CX90Sg2w65BQzocp68NCW2SuDSyvMTcgLtY5YAvznGFsCTR2iZbwoDVsKSW
 Nkc1vxneTrE8uA8lnMASRJGvRqyll5Zib97/eaxKEHSPoz4g17/cEnQAkXSBmdpEkfn8
 uh36W2VKwQxHcpvOQZryrLT4Z/qtCIFYCSmNR4OgKja0p5inGJcxFJUX2xjsA4kmsH0w
 fBBGDKNr1QM/C6EfaG1tH+EuSvw23OVWBHRSz+3DXtSI7weTuKxHx7cXRk6jexkRqbyD
 Lxu9IZ7cQW0x8Cci6l78D5KSGeeyfFeoprwDobFjZRAcLA0SibE9jZ1GP/9NgmgDrq4I
 J2iw==
X-Gm-Message-State: AOJu0YwEr1LjjlTX4UIxCggkY4TM8HqivFsv/ose2JNrS/GldKliZaH0
 Icwq/EKEzSAtVs1Jp24PzBDJg6nR6WP7grLJmhHSr0/Iij6CKPSFP5kh9X5Rwm64zb9+lZWKwud
 aWaw=
X-Google-Smtp-Source: AGHT+IE4avzGlyLs5At4OYoGiMVVjbnVp3dKhHTV1RYOuhT1yl7VD42uu71Y4j9hRKlh6fybrxkN/A==
X-Received: by 2002:a05:6000:1042:b0:34c:54c8:3f2d with SMTP id
 ffacd0b85a97d-3504aa63858mr11925117f8f.69.1715766254904; 
 Wed, 15 May 2024 02:44:14 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbc334sm15926239f8f.103.2024.05.15.02.44.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:44:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/43] target/hppa: Log cpu state at interrupt
Date: Wed, 15 May 2024 11:40:42 +0200
Message-Id: <20240515094043.82850-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

This contains all of the information logged before, plus more.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/int_helper.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index b82f32fd12..391f32f27d 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -241,21 +241,22 @@ void hppa_cpu_do_interrupt(CPUState *cs)
             [EXCP_SYSCALL_LWS]   = "syscall-lws",
             [EXCP_TOC]           = "TOC (transfer of control)",
         };
-        static int count;
-        const char *name = NULL;
-        char unknown[16];
 
-        if (i >= 0 && i < ARRAY_SIZE(names)) {
-            name = names[i];
+        FILE *logfile = qemu_log_trylock();
+        if (logfile) {
+            const char *name = NULL;
+
+            if (i >= 0 && i < ARRAY_SIZE(names)) {
+                name = names[i];
+            }
+            if (name) {
+                fprintf(logfile, "INT: cpu %d %s\n", cs->cpu_index, name);
+            } else {
+                fprintf(logfile, "INT: cpu %d unknown %d\n", cs->cpu_index, i);
+            }
+            hppa_cpu_dump_state(cs, logfile, 0);
+            qemu_log_unlock(logfile);
         }
-        if (!name) {
-            snprintf(unknown, sizeof(unknown), "unknown %d", i);
-            name = unknown;
-        }
-        qemu_log("INT %6d: %s @ " TARGET_FMT_lx ":" TARGET_FMT_lx
-                 " for " TARGET_FMT_lx ":" TARGET_FMT_lx "\n",
-                 ++count, name, env->cr[CR_IIASQ], env->cr[CR_IIAOQ],
-                 env->cr[CR_ISR], env->cr[CR_IOR]);
     }
     cs->exception_index = -1;
 }
-- 
2.34.1


