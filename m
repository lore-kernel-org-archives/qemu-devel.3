Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9633EC5AD4E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtC7n-0000pX-RN; Sun, 09 Aug 2026 18:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7m-0000p6-Ha
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:10 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7l-0007MM-3o
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:10 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-84e3007a2b7so1141862b3a.0
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786314968; x=1786919768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b4B0whQLU8Fqrs8mhfR5RJRxBochR2jShENdUKhhET4=;
 b=poQJxkSRt2Eb3uoQcgkEswF/y6eDYkm3CwpMdQn/G07O0ls0yFgch9EM6vTQXyiETR
 w9AX7Mx1X+2235NrjE/enj3qAMeJSSKV2xwD4EyKuTt90wpzCktt+a0UZT3kBAJ58rPK
 IDhC9CeMwtpLTdUx2DwELHB3QD196zczeAM+tSRXfzymzZIDnoVsdcxz/Pfrqm+Ug9yL
 YrNQ8B10eix292nfhAngsdSM1IcB09lGPqUp5a7/lblRqAGhPw69W3fzERiC8qgAuo5T
 7DxFrw2Hxi6dX/Nk3ZKPlUqzXeyUKdS8/6sdowHbENrsTg7u/gKq4ZZLy2qBkDd7IYM3
 Dh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786314968; x=1786919768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b4B0whQLU8Fqrs8mhfR5RJRxBochR2jShENdUKhhET4=;
 b=jWkxhGtw7605hmxdA/rWFdAaKhSmc43hGw/QLRRSjKKITrGMWBBNJZJz+VQa7dBkF8
 IQxXMWLJKFcxIAOmfYkVRTbtgsYb0OmBuaiu4JnSlxWFxLrXwCBpoqfoY43zmC57j08B
 rCuaingHlb6XFMcX7F/5uCJghuGb2DM0Yg+NCod6ZvpFDU99B3SNNTOwX5cN3c84Xnd6
 ow3+mAzYnHiBsXhxEGol5oAAn+BWlQU4z1Dl34xsC4z+RwM8YbaYRfQST+SWTn1IqfHo
 D8C81Aivf762bect9dB6CC9YD6yyel2H7UWzt1toNOe7J1mpWiqnsjPWjJYQ46AxCp7u
 8agw==
X-Gm-Message-State: AOJu0Yz/5Vf+nb3D7+YZXp3I3u/28eH+b8jG6XxluA7auW93/vTXfN63
 JwkGIRu2KCWGCQVIWwRT2NOzm32GE9ZmX3Jgho6VKsr5qFEUEXqEK4s2c1qAnwWsNXSsEiG6DQG
 UWWIg
X-Gm-Gg: AR+sD13plsgXME7KcEv1Sb6i9cy6NqA7oJs8Si/82fXA/JXBajw1OQN0YoGc3fLYfZY
 bHLPbycvpe1u5OkJkX4Jftx/gbGSKjNe5frNvHMlY/ZWwN98DOucKGUHnwxCzQ4IitftuD6orXZ
 m8LG1NnH+tIx+cqFN0MuKGKrnQAkFgIInCGyShLJ8NJHbaSuQx2iMHDmoQLCnR6xPLiWvcg97f3
 EIfA2GXg/D7HdVLBXwJ1r4DuQQyiIQ6V0Ko8KDBK85zlXsefFy2dPUvBLUCfrAycztHQgkn/KY6
 8pi6EH/a3zqRgeCj+ZBSLnLJuxU9zAbwzhA0iIQ7729Wf03o0bvpSd9wULZvk/6ViW+9O/7cq9S
 3uwXE+c2qO6Rvqbq5cIBf8ktgJiegIReJ/5F3yDwz6vXPzT/aUQeYIm2C3qTcCiZWeop3RcdzWC
 IWCU3athhYO1DVz7Wqp5tjVSX3P9K55+HwJVzfjgeCZnU/EsiVYOlBa6R5KubcH4riW2QOSN9a3
 3ddln2BlXtu/5OTX+kr
X-Received: by 2002:a05:6a00:244a:b0:845:c8f9:6ce0 with SMTP id
 d2e1a72fcca58-84f696a1628mr13617845b3a.21.1786314967694; 
 Sun, 09 Aug 2026 15:36:07 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f19ace6sm2998102a12.2.2026.08.09.15.36.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:36:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 16/56] disas/riscv: Drop useless const in structures
Date: Sun,  9 Aug 2026 15:35:05 -0700
Message-ID: <20260809223545.730664-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Individual fields should not be const, only full structures.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index eabe193b4f..3325b7b4ef 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -174,19 +174,19 @@ typedef enum {
 /* structures */
 
 typedef struct {
-    const int op;
+    int op;
     const rvc_constraint *constraints;
 } rv_comp_data;
 
 typedef struct {
-    const char * const name;
-    const rv_codec codec;
-    const char * const format;
+    const char *name;
+    rv_codec codec;
+    const char *format;
     const rv_comp_data *pseudo;
-    const short decomp_rv32;
-    const short decomp_rv64;
-    const short decomp_rv128;
-    const short decomp_data;
+    short decomp_rv32;
+    short decomp_rv64;
+    short decomp_rv128;
+    short decomp_data;
 } rv_opcode_data;
 
 typedef struct {
-- 
2.43.0


