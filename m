Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90417CF258E
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 22:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t06pP-00076x-UY; Sun, 13 Oct 2024 18:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pN-00075l-Nc
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:41 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pL-0000tP-TH
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:41 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e28b75dbd6so2583705a91.0
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 15:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728857558; x=1729462358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nYSXn25U/DdvMWs7SvnxnC83hyNQjHsWrN+gaiP3cZI=;
 b=UV4A9fMgJH/jdrRHSRj8PwGHaoW3ecn5UDdiGCMiutCQ24/5si8HLA44cPyiDPxScT
 B9Q/3Hy2y2gaOV+WKee6YjWCfKVRm5JRJCUnFQ/YUvKqGF5TurWhO+tVpsq6JKJDoQjX
 1JaEdXW3MWeaKv7A7bTh03Ql0BkDlmU1386qiBANR69g50Sfezqzt8VT18/jhmkvOH7V
 jv6yvzLp6r5bYQTdednxGLGwAsvmiZWhGZsE0tdnaUO2GKRAZsKzmQILrwWbSVkTUTZG
 cKRd5rzZjBTXxO7d7Gqv5oYvqd/F+GbsToxmiqiejLfMcG5QF0aVWuTO27H4p2/De1o0
 20kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728857558; x=1729462358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nYSXn25U/DdvMWs7SvnxnC83hyNQjHsWrN+gaiP3cZI=;
 b=XhYb1MS/GdrnIiAEsj/s1KJTt5Rf35pQN1mNbIFTDKimXF06gL/GXPsKEy8nIoW2G9
 AjqcWDCuQGruWnpt9kKEKWRS2jXtqq+eJikCzCvzS/t/fXldF4U8DOioBrFuoDZegNci
 C2RtAqDPX5wtScd7fWpmefahJEejf4+b0w4MFW38PLoTpCtxgtPQRVtk2lQyjptJ6yQR
 ynJgcPjrc+ihJE59lAfNClCKJpPd3PcDzorr2xzb2l04js1ZGnJCeStmgLF9WPLV1uRS
 o91sbcQUVYzR74850Ae4qkcuYTOLxa+soAdxEG9UWr6oB6/vJT4o6NQQDz+VZthS77/C
 0Nfg==
X-Gm-Message-State: AOJu0YwPROWWoPLIyrtTO5/n+SYcJWysBR97jufphgyxWlloCGl41TCe
 WkRmY1Y887TToXlet9IMmItYjPHZUKX03EiNEEmO7udNAw0MNjHtWcyevwZgW+Ed17UeJTML0yS
 0
X-Google-Smtp-Source: AGHT+IE5+Grwiy+ST/5h5mjr6hl+1ON7WEkhh/uMXn2/NHYZUHnpujPHANZdm17PKAtec5QmcVtdmw==
X-Received: by 2002:a17:90b:390a:b0:2e2:af0b:8f2d with SMTP id
 98e67ed59e1d1-2e31536de5dmr7803911a91.26.1728857558447; 
 Sun, 13 Oct 2024 15:12:38 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5df1eebsm7271958a91.17.2024.10.13.15.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 15:12:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 02/27] include/exec: Introduce env_cpu_const()
Date: Sun, 13 Oct 2024 15:12:10 -0700
Message-ID: <20241013221235.1585193-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241013221235.1585193-1-richard.henderson@linaro.org>
References: <20241013221235.1585193-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

It's the same as env_cpu(), but for const objects.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20240912093012.402366-2-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-common.h | 13 ++++++++++++-
 linux-user/elfload.c      |  2 +-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 2e1b499cb7..638dc806a5 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -238,6 +238,17 @@ static inline ArchCPU *env_archcpu(CPUArchState *env)
     return (void *)env - sizeof(CPUState);
 }
 
+/**
+ * env_cpu_const(env)
+ * @env: The architecture environment
+ *
+ * Return the CPUState associated with the environment.
+ */
+static inline const CPUState *env_cpu_const(const CPUArchState *env)
+{
+    return (void *)env - sizeof(CPUState);
+}
+
 /**
  * env_cpu(env)
  * @env: The architecture environment
@@ -246,7 +257,7 @@ static inline ArchCPU *env_archcpu(CPUArchState *env)
  */
 static inline CPUState *env_cpu(CPUArchState *env)
 {
-    return (void *)env - sizeof(CPUState);
+    return (CPUState *)env_cpu_const(env);
 }
 
 #ifndef CONFIG_USER_ONLY
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 52c88a68a9..352960b771 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4314,7 +4314,7 @@ static int wmr_write_region(void *opaque, target_ulong start,
  */
 static int elf_core_dump(int signr, const CPUArchState *env)
 {
-    const CPUState *cpu = env_cpu((CPUArchState *)env);
+    const CPUState *cpu = env_cpu_const(env);
     const TaskState *ts = (const TaskState *)get_task_state((CPUState *)cpu);
     struct rlimit dumpsize;
     CountAndSizeRegions css;
-- 
2.43.0


