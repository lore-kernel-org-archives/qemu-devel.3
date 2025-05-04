Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286AEC3ABB0
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 20:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBgP3-0008TU-C0; Sun, 04 May 2025 16:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBgOv-0008P8-Vh
 for qemu-devel@nongnu.org; Sun, 04 May 2025 16:57:31 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBgOr-0006xY-Tx
 for qemu-devel@nongnu.org; Sun, 04 May 2025 16:57:28 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-30863b48553so4550713a91.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 13:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746392244; x=1746997044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=77OvkwGdPZ715TT3lq2D7nntXkGJOpDEIXBjuTXTyWY=;
 b=LFfQc7Nqg2zYwv8fzAZLsdQcfkPAGtkJPNEZybaO4NNUQGkrSr1Eldk3U+zuv3lrrB
 Gnx8Cb4+4MtTu+2+LTL/kZ34iZMM3cWqeMUMyMiItXRc9FymvXYYlHUpz52pPmA810XQ
 LPw4b4N0U/42o3BiaGOxCwOo6DLq9scb0N/qaGhaCfI74qKP53sr8bmajdfUsgbajKFK
 VhWzpuQmPdvrEIR1LG0Y95WlV/tnKUCFqN5+GmX/RUF0ihPWHX71xGyeW6Mh1dsqlvz5
 CNcba+091viI+TDJJXDM/JPJNRE9F3KvhM/+c1/+Q+3ohHcX0ESqOz0BNogzO9lF4Obo
 uVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746392244; x=1746997044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=77OvkwGdPZ715TT3lq2D7nntXkGJOpDEIXBjuTXTyWY=;
 b=pNdurfa0ndjdxLQz+jgq9z9QHKR/mzJGxFi995emszM8c0SUqUX9r6DGKKUNCJtNHx
 VvlnOV8ehlZc66nIl5WGewEboeZL1hoQ+OXgP+eqTlWVK/DoCdh7IplgGRx3o+/Isv/4
 q2tkfxnwGtYH4zz5Uz5prfDcse+W4DDjyv88DOKynZY0XR7WKI4zpPXnBzmk4VxzCuic
 LgB1IS35xkHqrFDUE0D3wlsD+9kDM+AqfKM9wf3IMpC857Vz3p6PnaSuYRPMnE9vkmJJ
 aoc7vQVEL//0vghjSqYzNMeBm0jcdCKAoKGgQt1aoNAj565CWEtd5XLEC71sje1pFlj4
 D7NQ==
X-Gm-Message-State: AOJu0YxAH0KQoNpd2J/aodnHktKiWceRVD5mH5fayxi9Nr9BDR/N9J+9
 E3sl5F/BTtTSWOIQ3D8hI2hWDwJ6upRJMLqRYbQhd3/I2KT3uLCQcmSH5JevnWyHfjN4eeiBJkV
 d
X-Gm-Gg: ASbGncvKz6eSeD6IQ3gJf8vEAjs2T6H+BiKdGBOTNOte3FPdERYxDDBjF3oivnaBhK1
 5slk2PQxqfxvZn6HXqALPtDzN9jligPDU4V37/POZMXEKhncbNzSc9393Dp7+zTrSORYc0sUa8x
 uMPwnRxOt4t2ASizqP9+vnQzL7dM+hSHZi2cZPU7KFFCnZ71fCZ2Jhh5Q6319GvH8pPW9kvtFYh
 DC2GryX+6rCiAk8ZqzyjzjWf5pJZ4hd3XnRWLsb5K9VZOCNgt+7+rk8mJOVvyG91K971JnzZva/
 wOk7xhfHSvfWqc28vs1rrBY9cMQ0GXU49A3y72GeU9ZkqTKFKoDOyGOHXEyMj9bV1cIy+259oD9
 YOcZK0x6OxA==
X-Google-Smtp-Source: AGHT+IFf69FItg7a/r7GMSH6EqJSCxX4esnNaA1SKQ2G/8ZamfOR7g/Nxp0cPok00Y6gIL2htNvR9g==
X-Received: by 2002:a17:90b:58d0:b0:2ff:556f:bf9 with SMTP id
 98e67ed59e1d1-30a4e1c9560mr15654404a91.4.1746392244257; 
 Sun, 04 May 2025 13:57:24 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e150eadfcsm41346425ad.32.2025.05.04.13.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 13:57:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: foss@percivaleng.com,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH 11/12] target/sparc: Fill in TCGCPUOps.pointer_wrap
Date: Sun,  4 May 2025 13:57:12 -0700
Message-ID: <20250504205714.3432096-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504205714.3432096-1-richard.henderson@linaro.org>
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
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

Check address masking state for sparc64.

Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 2a3e408923..ed7701b02f 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1002,6 +1002,18 @@ static const struct SysemuCPUOps sparc_sysemu_ops = {
 #ifdef CONFIG_TCG
 #include "accel/tcg/cpu-ops.h"
 
+#ifndef CONFIG_USER_ONLY
+static vaddr sparc_pointer_wrap(CPUState *cs, int mmu_idx,
+                                vaddr result, vaddr base)
+{
+#ifdef TARGET_SPARC64
+    return cpu_env(cs)->pstate & PS_AM ? (uint32_t)result : result;
+#else
+    return (uint32_t)result;
+#endif
+}
+#endif
+
 static const TCGCPUOps sparc_tcg_ops = {
     /*
      * From Oracle SPARC Architecture 2015:
@@ -1036,6 +1048,7 @@ static const TCGCPUOps sparc_tcg_ops = {
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = sparc_cpu_tlb_fill,
+    .pointer_wrap = sparc_pointer_wrap,
     .cpu_exec_interrupt = sparc_cpu_exec_interrupt,
     .cpu_exec_halt = sparc_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-- 
2.43.0


