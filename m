Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B4FC369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mHf-0003qt-JS; Tue, 15 Apr 2025 15:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mBn-0001Y2-Ic
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:43:24 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mAr-0007hF-Nw
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:43:23 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3f6ab1b8fc1so3144588b6e.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744746138; x=1745350938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RaE4NUW0htUqy2JZaQ//W9CdS9U5ONG2ffBye71vnvI=;
 b=P+MhFuyjZ3YDAAc2PXDG2QnqDKcoivH41mwdP9xmqvzL3bafINMRJyqaM+tmhmZ7QW
 +dI+cG1bCx0DHWlsp6N+PZO9anrTImBiWTWmYmN46d+eeC9Yf6fKNmdTikEEI25+p0Cq
 GV2OwWCWDH5wfqxYiio9P51C8vdtttnaPKhsKkNfqFuRii1QanPdQPPuWwVWfh9w9N8a
 UPzD4oay7XEfYoDIBpc7ybda6CfMhzF0EAjJtQJhjlvrizYLqY/n+8bqFuDhImQRubkk
 LOHV6PZEbrzRX2stY/51OtHHKjCv0Cxh+tOVQiqa5Kas057PIpjcmrBWHLOmrK5fCcM8
 Sdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744746138; x=1745350938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RaE4NUW0htUqy2JZaQ//W9CdS9U5ONG2ffBye71vnvI=;
 b=bh4CEF3fkcEMK21aGDMyus1ZMLPW8vYYLd++Hth83lfvObfQTvBFxAp0pWx3GdQo6X
 L0tbrC1aP//5XQfNWg1KBtc3SvBzNnLKIjj5Pni+OjuZWUys0KOpIOssiLEWqpD2Vmjr
 pI08d6AFjV9+U2b+2MDnvF+dapOW0M7ZEU9Hwe950pWue8RJhY792EXpBn00hIDHlY64
 EF6XXj4IWL/g8FDCU7z9crGL9qLHIN3tWJZd+2HZdcehhD39FbmAPj8iERlL8XW/ixW4
 Fs3YGflUw8FrwTeU2SmSzELGgJ5u4EkvT6pFGz3JfJ2mm4BymF43dib5Kljm9rEF2Anc
 wu7w==
X-Gm-Message-State: AOJu0YxRTzIvnu06OXyQdZYz1sA5wPoVOBeK0x9UBeb6+JZd6TtoZbnj
 iJi6ImyNU3TfdSV6wyplnFKiNQh0sic68QpSM3rTGFfpyU/XjIvMLTl5muhSAtpkBY8dKTF/aSQ
 w
X-Gm-Gg: ASbGncuV7kdLLBRFJ5IgzjWQikMvHePs6+Zdz+8n29MFqHnDzJqpZVgPCPUqjQJSSE6
 VSt+vJ2vgSMaMUefVF/88+PQ5iTbBZo4FM9Ng+V+Fa/i/6RLgTGxkhpCiLSX9OKhfUzxBJu96dZ
 5NbQaQ1EmWqzV0t1kXRhwftF+NNArkKHIZe0cR6U836MX93G6KYBd4w1E4/xcNaE7FQ5PEurnvN
 7yxANXg7LNvZxK5BuI3KvJcSbNwnQoOV1xe0Kr2cKzCosUHmdcwxW/neaTrZ1QiAgQ1jEJwVEdO
 C2GZQthrtFvHWlWPCmD/XkTRHhNvr61+GDYzK5Rty5flQ3161cGznq8vNmHyBucxQhhykSEvYKV
 ztfxFDPv/Nw==
X-Google-Smtp-Source: AGHT+IEZb8Nw3s1c14zdXrBZBJq+vVpbwS2UBvFkGXhx9z7M9wpvanzUF+jCtJ/lXOww0oMoJ2vG6g==
X-Received: by 2002:a05:6a00:cc4:b0:736:592e:795f with SMTP id
 d2e1a72fcca58-73c1f8f7f6amr835685b3a.9.1744745762620; 
 Tue, 15 Apr 2025 12:36:02 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 126/163] target/microblaze: Use tcg_gen_addcio_i32
Date: Tue, 15 Apr 2025 12:24:37 -0700
Message-ID: <20250415192515.232910-127-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

Use this in gen_addc and gen_rsubc, both of which need
add with carry-in and carry-out.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index b54e5ac4b2..31afd3ab5d 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -310,11 +310,7 @@ static void gen_add(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 /* Input and output carry. */
 static void gen_addc(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 {
-    TCGv_i32 zero = tcg_constant_i32(0);
-    TCGv_i32 tmp = tcg_temp_new_i32();
-
-    tcg_gen_add2_i32(tmp, cpu_msr_c, ina, zero, cpu_msr_c, zero);
-    tcg_gen_add2_i32(out, cpu_msr_c, tmp, cpu_msr_c, inb, zero);
+    tcg_gen_addcio_i32(out, cpu_msr_c, ina, inb, cpu_msr_c);
 }
 
 /* Input carry, but no output carry. */
@@ -543,12 +539,10 @@ static void gen_rsub(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 /* Input and output carry. */
 static void gen_rsubc(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 {
-    TCGv_i32 zero = tcg_constant_i32(0);
     TCGv_i32 tmp = tcg_temp_new_i32();
 
     tcg_gen_not_i32(tmp, ina);
-    tcg_gen_add2_i32(tmp, cpu_msr_c, tmp, zero, cpu_msr_c, zero);
-    tcg_gen_add2_i32(out, cpu_msr_c, tmp, cpu_msr_c, inb, zero);
+    tcg_gen_addcio_i32(out, cpu_msr_c, tmp, inb, cpu_msr_c);
 }
 
 /* No input or output carry. */
-- 
2.43.0


