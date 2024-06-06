Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF7BC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 03:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF3p5-0003cj-FN; Wed, 05 Jun 2024 23:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF3or-0003X8-7r
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:29:41 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF3ok-0003mU-6r
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:29:40 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-6ce533b6409so345279a12.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 20:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717644572; x=1718249372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1OdJEwOKA51hh/7jatyHlydDt1TQ7phcNBkbolfhN74=;
 b=CSM/W7SIRu8RNzQ4aHIKpWqNjK6iGijmrnrDw/9SNv6kjVmkzAlfu8aE6+bbsVzl38
 XEFE3Eoi6WOGy4I7BkdIndyARf6kOxC7VVRGAVRtL6LSIl2h9G3QkkxxbAYD+tKpykjU
 T32rwQ66cjAbt1fAUegK5j5FFPXn2SUdfEygm7WgSgXQS98zk51FQnAzhfGWAD1GmfOV
 aQachKpEATxznCXXkguETMqnyNS5MQ474KoFJq4i+GVzssKlSAX5ruaDOUNgKOc+RngY
 3tkJM8fwAp7VtE360Xl+qHDdnslyr+CuH2Vq4ngKkLSSZ55b9bsgBDrxuRzLKyHqmZa9
 oo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717644572; x=1718249372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1OdJEwOKA51hh/7jatyHlydDt1TQ7phcNBkbolfhN74=;
 b=m5amh1UJUIQ/W4CH7e2rdr54Yaxh5FWmj+XrGvGz+LuoDWRwfZZmEjknBybZecLjeQ
 Ol6P2RLcfwWplNFTO9hk9Ot0xacGhwxrUcQjHSgD5JJaGUEMwW+D8dMAxuDnzs2M+kbX
 3TJZeiFBN71udb1d9gn3+FplMds9olbA6M+HjI/MA1xvkn29rM4goezWRmpKjU3WQAbY
 OifZUeBKy7a/Fb2pMfPsOqqGd3jGruiaVb2JfU2H2RT3Zc+0iJGN4uRk4xkB3yBleopU
 ZqHqplIFQKXy3Z0B789QaJ1Z9vAPvQnXe22zWiPzNBnrqRyMnBBmbyiD0n4BSgvS5yiH
 Utcg==
X-Gm-Message-State: AOJu0YyQiZpLqduw6pNzj9vDwBgfdhfG2Z+OwOHBjtZjcOlgMj2vPVjX
 eAFiLBwGFywxj1xMV9RnrjZdgdyg1zCGY7crq3+XwfcmWqVe5WMEQt6tGR5VQuUbsn31HUZLa5P
 g
X-Google-Smtp-Source: AGHT+IG3XyaAUyvOg4qgjAL4twei/oxJLiiuUEVrwZHv7dLYA/y42GEIAcJa1YTSqBCilhXOyOMXkQ==
X-Received: by 2002:a17:90a:e547:b0:2c2:792c:b5c4 with SMTP id
 98e67ed59e1d1-2c27daf9835mr4356506a91.10.1717644572360; 
 Wed, 05 Jun 2024 20:29:32 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c254a76729sm4826265a91.0.2024.06.05.20.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 20:29:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v2 5/9] target/i386: Split out gdb-internal.h
Date: Wed,  5 Jun 2024 20:29:22 -0700
Message-Id: <20240606032926.83599-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606032926.83599-1-richard.henderson@linaro.org>
References: <20240606032926.83599-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/gdb-internal.h | 65 ++++++++++++++++++++++++++++++++++++++
 target/i386/gdbstub.c      |  1 +
 2 files changed, 66 insertions(+)
 create mode 100644 target/i386/gdb-internal.h

diff --git a/target/i386/gdb-internal.h b/target/i386/gdb-internal.h
new file mode 100644
index 0000000000..7cf4c1a656
--- /dev/null
+++ b/target/i386/gdb-internal.h
@@ -0,0 +1,65 @@
+/*
+ * x86 gdb server stub
+ *
+ * Copyright (c) 2003-2005 Fabrice Bellard
+ * Copyright (c) 2013 SUSE LINUX Products GmbH
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef I386_GDB_INTERNAL_H
+#define I386_GDB_INTERNAL_H
+
+/*
+ * Keep these in sync with assignment to
+ * gdb_num_core_regs in target/i386/cpu.c
+ * and with the machine description
+ */
+
+/*
+ * SEG: 6 segments, plus fs_base, gs_base, kernel_gs_base
+ */
+
+/*
+ * general regs ----->  8 or 16
+ */
+#define IDX_NB_IP       1
+#define IDX_NB_FLAGS    1
+#define IDX_NB_SEG      (6 + 3)
+#define IDX_NB_CTL      6
+#define IDX_NB_FP       16
+/*
+ * fpu regs ----------> 8 or 16
+ */
+#define IDX_NB_MXCSR    1
+/*
+ *          total ----> 8+1+1+9+6+16+8+1=50 or 16+1+1+9+6+16+16+1=66
+ */
+
+#define IDX_IP_REG      CPU_NB_REGS
+#define IDX_FLAGS_REG   (IDX_IP_REG + IDX_NB_IP)
+#define IDX_SEG_REGS    (IDX_FLAGS_REG + IDX_NB_FLAGS)
+#define IDX_CTL_REGS    (IDX_SEG_REGS + IDX_NB_SEG)
+#define IDX_FP_REGS     (IDX_CTL_REGS + IDX_NB_CTL)
+#define IDX_XMM_REGS    (IDX_FP_REGS + IDX_NB_FP)
+#define IDX_MXCSR_REG   (IDX_XMM_REGS + CPU_NB_REGS)
+
+#define IDX_CTL_CR0_REG     (IDX_CTL_REGS + 0)
+#define IDX_CTL_CR2_REG     (IDX_CTL_REGS + 1)
+#define IDX_CTL_CR3_REG     (IDX_CTL_REGS + 2)
+#define IDX_CTL_CR4_REG     (IDX_CTL_REGS + 3)
+#define IDX_CTL_CR8_REG     (IDX_CTL_REGS + 4)
+#define IDX_CTL_EFER_REG    (IDX_CTL_REGS + 5)
+
+#endif
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index 4acf485879..96b4382a5d 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "gdbstub/helpers.h"
+#include "gdb-internal.h"
 
 #ifdef TARGET_X86_64
 static const int gpr_map[16] = {
-- 
2.34.1


