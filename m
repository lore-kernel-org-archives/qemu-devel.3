Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88786CD1296
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2024 05:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsykI-0002q9-TX; Sat, 06 Apr 2024 01:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsykH-0002px-Lt
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 01:37:41 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsykG-0006IG-5m
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 01:37:41 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1e2bfac15c2so18883405ad.0
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 22:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712381859; x=1712986659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=syERz6mhK860XklS44UTgUTqfyplnj5Xmmc1ns2mrO8=;
 b=CPNo/F9zhoyhVnkYBeq9VmdK/Rimnw7PVYt49jBun7UFEl+gPy+Y14RlBXnwFLEHA3
 oXJXRmHbuWDnDZeFbyWEmIFJHiM9JRtqo99cod8SlqNIgrxkpitC/6BVej6EmSz3mIx8
 BMVmsgqonKzuWhX36aY/1+v1Bdkc2eWHKuCupn8xoGA+vJjIZLr7eBgy92xxns3vE0C1
 qSQlcPyxVFXzbzpTCLyZxPntvu1LmE0fwOUKhYYiGt+iJ8C9Qlw9dJKQNJobaJ1Yoxxd
 DBI1moe2HTbxOVygaCJZE9ocOk0xknYNcEPEIFUIJLJStvzuCBeQxGFvxJw4Oo0A23P+
 3yKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712381859; x=1712986659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=syERz6mhK860XklS44UTgUTqfyplnj5Xmmc1ns2mrO8=;
 b=gGTT+Xz3l22XhtJArxYBCFfVAsKGjbRH0/I7TQxX2nv8XQsUVUIe1/Ml6la0mQNP+J
 BRfMtlZllgFGKbinwov7z5114TjgUnH3OzfMz4TqYdVhgbUpaH7r3i4yOv0xtMAUnPyM
 XH4uXFhnZYucfSuBm8sNAZw7m3sVg/rnuZpKYX1UEClbZv00iqevjaDhO8pkCrsLo67f
 uiS9nEzsNbk3eLXYOfOtg1JDt9Lx+Lr/v1vtJg61pip47vTrZu1M6GtERy9xQbkJhZBR
 I9s/SPYGzzU9NcAVjbS04v+Tuv5JF9zq98T97K62qK1FKjpql6oQjnqrOXfCrLETUQpi
 99oA==
X-Gm-Message-State: AOJu0Yy7Y6eznN3evc3SdmR606d0vqM9nhcyl7hhQGgy023Ddb0IUuk8
 JrNb+0SxRpNBKdrjugNgbZzyju9JzpVTdYhj1o89nta750QxGr0Jln5fd8+h+56uVkTxDLZ29lt
 0
X-Google-Smtp-Source: AGHT+IHAZTT4dN5fVrWf0eXLKKgolH52Un8Zr4WpISoCKAo8Z9r5zMYktagIGeEkNF0BczBUCi8c8g==
X-Received: by 2002:a17:902:c952:b0:1e2:8ec0:90c4 with SMTP id
 i18-20020a170902c95200b001e28ec090c4mr3301213pla.2.1712381858926; 
 Fri, 05 Apr 2024 22:37:38 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a170903124c00b001dc05535632sm2589378plh.170.2024.04.05.22.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 22:37:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zack@buhman.org,
	peter.maydell@linaro.org,
	ysato@users.sourceforge.jp
Subject: [PATCH v3 2/4] target/sh4: Merge mach and macl into a union
Date: Fri,  5 Apr 2024 19:37:30 -1000
Message-Id: <20240406053732.191398-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240406053732.191398-1-richard.henderson@linaro.org>
References: <20240406053732.191398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Allow host access to the entire 64-bit accumulator.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/cpu.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 9211da6bde..d928bcf006 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -155,12 +155,22 @@ typedef struct CPUArchState {
     uint32_t pc;                /* program counter */
     uint32_t delayed_pc;        /* target of delayed branch */
     uint32_t delayed_cond;      /* condition of delayed branch */
-    uint32_t mach;              /* multiply and accumulate high */
-    uint32_t macl;              /* multiply and accumulate low */
     uint32_t pr;                /* procedure register */
     uint32_t fpscr;             /* floating point status/control register */
     uint32_t fpul;              /* floating point communication register */
 
+    /* multiply and accumulate: high, low and combined. */
+    union {
+        uint64_t mac;
+        struct {
+#if HOST_BIG_ENDIAN
+            uint32_t mach, macl;
+#else
+            uint32_t macl, mach;
+#endif
+        };
+    };
+
     /* float point status register */
     float_status fp_status;
 
-- 
2.34.1


