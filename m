Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4CDC25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QSX-0005F8-Rz; Mon, 13 May 2024 03:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QSW-0005E3-GR
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:50:56 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QSU-0001z6-KG
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:50:56 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-51f45104ef0so4193757e87.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586653; x=1716191453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=420RbZAGJjbzrfJsdBQyYhnJyXLQSLvrDO7PgYHuwLQ=;
 b=bwSD3UgsgHnQAO1SdY6P4BYhDUvHoNxPP4WF8KoKYd7mjjSdbdMjRTqaq+qVjZcdRy
 GpkaRUnpH13+0x+FBr4xFBr1srtl6oH2419sKdPOwjO70myy8xr0RKgoe5T0vi+RVruo
 pmk6LOGNRhxQtgxfcQqBNlKMjoHmRtiv2toUk08pV6Nl7+nXikUDaTOFlNmfiKLYN05q
 PcJ4pnfX3sJ12raG8MR9LcO/xyKUw42qQTkpf+NeercQsUDingYgJAF1NU0vokkriGze
 kN6lrYhJc16eKkW42u+qIuLrvmrPI0ala5H6Lywf666x96yfjFxP14Nas9zLgemSiG5k
 7XMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586653; x=1716191453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=420RbZAGJjbzrfJsdBQyYhnJyXLQSLvrDO7PgYHuwLQ=;
 b=QS3qui96/u/SphuwJppn7YVOYrl1v53ja9V6HIjC2sqkrvBFI3irE6s9TXHv4S/SXz
 w/U5yWV950k0bSKW1GodrOWFNWf2ePcWN3XtZpAgtYzli1QJLrNXzKS7dgUbj92MO37p
 IQsRp774H4z6x+oULUl5Fgyb5HTts1jWVcE6w0kSF0qOhRU6VamW+YtoICk4Yv3jEgzH
 R7eRAAWXdRvNeX+T/YdfczHULr+BLpHWfHy85s3xugubnKGcrAayO6a5vMHr/W0R2jwZ
 ha+d0Bm4z75Wb4QIOFLNirdPAD+FpthBXk7zjSR2JeT5X/YubtoaO+8Ce1CMs6gsi62T
 7cqg==
X-Gm-Message-State: AOJu0Yx7xSDHNvVd5q4/3K8mkRUI7w15E2WZKZ+ESxyn/FK6gOz5NhIK
 SV1MhTD8fqCCZNGf7xGdlN5XMDgYpIov04vXXHYLf7R5wrTysCG8UVwjU7/ozoHvZvxzeanAVsd
 TPHU=
X-Google-Smtp-Source: AGHT+IFqeJ8lRT+z8knIpyx0JG9QUHlUGV1efyinRARrAevIsLdT0QhjCeN0QjBDZmwXiKs/E91VNw==
X-Received: by 2002:a05:6512:402a:b0:520:dc1c:3c5d with SMTP id
 2adb3069b0e04-5220fe799a5mr7038308e87.42.1715586652841; 
 Mon, 13 May 2024 00:50:52 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b896a50sm10374262f8f.30.2024.05.13.00.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:50:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 44/45] target/hppa: Log cpu state at interrupt
Date: Mon, 13 May 2024 09:47:16 +0200
Message-Id: <20240513074717.130949-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x129.google.com
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


