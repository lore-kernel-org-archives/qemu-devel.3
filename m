Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A79FC531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 17:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf0TJ-0006IU-FH; Fri, 16 Aug 2024 13:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0TE-0005mv-WC
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:37 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0TC-0007P0-Sh
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:36 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2d3da6d3f22so1120236a91.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 10:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723828231; x=1724433031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cjm2NL6Wgqty15f3ap7G8BavBfHkA8e5dbFy1QdhwG4=;
 b=fmWxfGQs4/NmwQVzkb8SUSMN7iKPReYpzZoc/HQLeqBzD0HnpaMa0HpJVxMZA3fRPb
 iXODnV5Z8az0yh6AFFmvFh0+x4vmqq+UGWFbXEoflSZF8ZwaRgaqh6j9iajvDS45xvG9
 YXhwqKycrPZBIsqnK5TAYwCbCrqWUxGi3EzbcVHzYJgL+4QnpnElB3NLOopNO7opX2bw
 ul9FgRhBk+40DRa4Pvp8S7g41T9p5e3qzEvqu/NHM7ocbJvPiwgL93nEfSeF/TZ7ccZB
 5lq8zsv3SMtUksIfxk9xNY0ZF5df9nyfzoHzGCQ9t5cpGADhkIlpgDU/sGWnupU/V4rQ
 p6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723828231; x=1724433031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cjm2NL6Wgqty15f3ap7G8BavBfHkA8e5dbFy1QdhwG4=;
 b=q8jW7GsFGjQDdPb/FQk/NT5tNsGB08huAu2cYAi4TcAng2xWmVUxZVqv9j5NOL9sjj
 E1wl4I9fSoh/OtA05RacawRTHtcDFXnL/777xgAPBGQQ/n3Fy+izmIuA3W6WFyW8uhyE
 nRPYG6M4mb+Sllp/WrCXjJN8Gq97y9hi7CqsrTDfKpwhtRq9RxShGdH0GPCllG+OOeFz
 vj5GeL3FrsFJfxAMtn8Jj6AkZpe/s3uaZBUXUVKOxPR2WXjm46FFAb4U1vxn2hyTlXTa
 hKOyoRBm9jyzMHKvEFLD+Pc1mmZ+mZ4Hq6T83A1kDVRcgCJV2wWgjZsFRPfwN0J2ZM1c
 Rvjw==
X-Gm-Message-State: AOJu0Ywko+qAt+M4sINomxU93CuNB0jDoDfxk+GaW/fDkmPuLwWekl9+
 v4F3qxckpHW3dTc3fPF3MJ/BnDLxz/V9pd/ta+zCcNWOb8RULMkQKo9ArZyfk/A=
X-Google-Smtp-Source: AGHT+IEU1lERPymDUGAzPNGmy+/sYLFle6YrB8nP36JdMYYclGQtxmT2XeZi6BnBBtkqtL39q/uiRQ==
X-Received: by 2002:a17:90a:8a14:b0:2c9:6d07:18f4 with SMTP id
 98e67ed59e1d1-2d3e086bf86mr3849955a91.35.1723828231315; 
 Fri, 16 Aug 2024 10:10:31 -0700 (PDT)
Received: from localhost.localdomain (121-45-122-195.tpgi.com.au.
 [121.45.122.195]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3ac7ca33dsm5988407a91.6.2024.08.16.10.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 10:10:31 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 12/17] bsd-user: Add generic RISC-V64 target definitions
Date: Sat, 17 Aug 2024 03:09:44 +1000
Message-Id: <20240816170949.238511-13-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816170949.238511-1-itachis@FreeBSD.org>
References: <20240816170949.238511-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=itachis6234@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Warner Losh <imp@bsdimp.com>

Added a generic definition for RISC-V64 target-specific details.
Implemented the 'regpairs_aligned' function,which returns 'false'
to indicate that register pairs are not aligned in the RISC-V64 ABI.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/riscv/target.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 bsd-user/riscv/target.h

diff --git a/bsd-user/riscv/target.h b/bsd-user/riscv/target.h
new file mode 100644
index 0000000000..036ddd185e
--- /dev/null
+++ b/bsd-user/riscv/target.h
@@ -0,0 +1,20 @@
+/*
+ * Riscv64 general target stuff that's common to all aarch details
+ *
+ * Copyright (c) 2022 M. Warner Losh <imp@bsdimp.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef TARGET_H
+#define TARGET_H
+
+/*
+ * riscv64 ABI does not 'lump' the registers for 64-bit args.
+ */
+static inline bool regpairs_aligned(void *cpu_env)
+{
+    return false;
+}
+
+#endif /* TARGET_H */
-- 
2.34.1


