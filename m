Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8916FC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzldH-0003fZ-24; Wed, 24 Apr 2024 19:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldG-0003fP-1I
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:30 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldE-0002cC-H3
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:29 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f07de6ab93so415771b3a.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999747; x=1714604547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AXNxunD293g232TU+51MeWlmAuFekT13Nuf8XRAYogk=;
 b=KpXBbAEbeGBO/K7/bvHe/unYFTFwkKBNs1cx+FBnYyxyJbUKZdrWBxnErqIVGrgs6m
 AHTQEz+6HjM9Kqe2ElmVZJtOzEqYwV2ug+kz2jQ2JtqJVx26NGVjxbVaKbLiyAyF4bAs
 o6wfwfPYf0YyXi5a52ZqYdM4qxxxc+7J6qa9quzSJdDFIodqRCanGi4dlmxTD2rwgkoB
 zBxF4Hc+HP9Y1BCLANOOu0/2uThGfBXhsNzyeK3BtmI44GRIaWhXfaObD9LBc4wIo4zf
 JfSZuCAQtecdHRXA2GlMANOchRH2Isul1JpuvHIHLJbrqaHRHgRuqP6rosEKowLn4Odh
 bB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999747; x=1714604547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AXNxunD293g232TU+51MeWlmAuFekT13Nuf8XRAYogk=;
 b=Sf37pVZyhoH8UvVL8/Ml5V1BtPXCJl0Rhisem/KPO4r5KnGj8div++M+Ibkh+5BCkP
 svubuf0gEOBgQNwB9ZyvRQTvhrMwttY1/qA1QW34L8wtU1Ac9N168zOW9nq1q6z7aMRz
 WBE+ayjZleaihTs92621+P2EtAW0+B5B9yQt0EEkCU5/6uiMembfD4Jbak7CjCEAv5DO
 JhPOt3rwng3/GC+tBrRu8hEV54SxmRS3ltiXorgPrDgQDiEvtF2LdF6btnlETeyaPEH9
 XUoGz9cdEorWjFW7B3w7PJnsQUl66Jwkf8WCF1TO5MrMEr29dBOlwqEKLpYvstzCkSyn
 szXg==
X-Gm-Message-State: AOJu0YxPHKZUxmC5c4V6t3RraOIM5gWCqzEwwdQ6id/4v8ZCrRgLGmaT
 k2g4YgsFEmGw51feztCWmHB6Z99yMiNVHSWNdSq6sYQtgLo/2U/caZbzsAw4enBKB5sCzFUP6dn
 e
X-Google-Smtp-Source: AGHT+IFcAqCUh9kwu29eaO6ltidkfeoPNm5QQdFhcxIN7hb6Dd14y4fNsRWRf0jJj5F6TAHikhG2CA==
X-Received: by 2002:a05:6a00:2388:b0:6ea:7468:1f31 with SMTP id
 f8-20020a056a00238800b006ea74681f31mr4623725pfc.30.1713999747188; 
 Wed, 24 Apr 2024 16:02:27 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 h5-20020a056a00000500b006ed4aa9d5c0sm11981405pfk.188.2024.04.24.16.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:02:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 01/20] tcg: Make tcg/helper-info.h self-contained
Date: Wed, 24 Apr 2024 16:02:05 -0700
Message-Id: <20240424230224.941028-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424230224.941028-1-richard.henderson@linaro.org>
References: <20240424230224.941028-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Move MAX_CALL_IARGS from tcg.h and include for
the define of TCG_TARGET_REG_BITS.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/helper-info.h | 3 +++
 include/tcg/tcg.h         | 2 --
 tcg/tci.c                 | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/tcg/helper-info.h b/include/tcg/helper-info.h
index 7c27d6164a..909fe73afa 100644
--- a/include/tcg/helper-info.h
+++ b/include/tcg/helper-info.h
@@ -12,6 +12,9 @@
 #ifdef CONFIG_TCG_INTERPRETER
 #include <ffi.h>
 #endif
+#include "tcg-target-reg-bits.h"
+
+#define MAX_CALL_IARGS  7
 
 /*
  * Describe the calling convention of a given argument type.
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 05a1912f8a..e4c598428d 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -39,8 +39,6 @@
 /* XXX: make safe guess about sizes */
 #define MAX_OP_PER_INSTR 266
 
-#define MAX_CALL_IARGS  7
-
 #define CPU_TEMP_BUF_NLONGS 128
 #define TCG_STATIC_FRAME_SIZE  (CPU_TEMP_BUF_NLONGS * sizeof(long))
 
diff --git a/tcg/tci.c b/tcg/tci.c
index 39adcb7d82..3afb223528 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "tcg/tcg.h"
+#include "tcg/helper-info.h"
 #include "tcg/tcg-ldst.h"
 #include <ffi.h>
 
-- 
2.34.1


