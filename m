Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32402CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 20:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3rK-0005bm-D4; Fri, 29 May 2026 16:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wT3rH-0005bI-Fl
 for qemu-devel@nongnu.org; Fri, 29 May 2026 16:31:07 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wT3rF-0007g9-JU
 for qemu-devel@nongnu.org; Fri, 29 May 2026 16:31:07 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c8095d7d75bso5864188a12.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 13:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780086664; x=1780691464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+vv7aEndI0iV1vKeBeel9GNX8MitI4GAwLM1EzXkEww=;
 b=QNmpP8W8sZaa2WOnwyXdeSsUfGwRh33wjcWZugQPUbCJnGvR/lwnaHetHNSvE6OyVv
 KWpEspKRfdXFF9ub/Uxm5cwr53iSuV9ZX839ymOsm89Jn6tIw+Kf7a9dSzS1bLyXYEz1
 LdkeaCQD9DIuRanwGte7hswO6UFQ5jG4jtkhsS90cQgBAbRM4gE7eUjVzStzaBW/23+N
 SU3PE1zOp5OlZzM1oNjeDSEtMXgGTouWsrD7EiWumVu8wsOX8VUUToYOhdYQ1XtaSnTp
 rfUk4sccyljM8t0oi0vjbhKNgCWvKydCC/2tAY2uvIewVQ46xk9vMfD5z8++0InMpYdN
 Z4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780086664; x=1780691464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+vv7aEndI0iV1vKeBeel9GNX8MitI4GAwLM1EzXkEww=;
 b=lpMOM8hhr8bkczG0Ux1k/THAMHosZFymHqII/vvh/yBFk1T4vgrhokP5zoL1J3hKOg
 0T8tBvkdHZnbWZCUXtckPKbk8En3I9VTGv8Tf+Ag90+qJJZY6LEedbmf2wZ3tgJSFXeK
 K3kUr0OzDfwsaMrpbadw5bLWqCdK7m3Z8s5ZZCIAJwp1A820C+A6TM6wtu8594pNAQw6
 0fc77QgfvbywhvuY9OkBBz/5cWsKtK4t9XB30v8HhTtINt/yY/9Odgu+qfCCTAYzehNy
 zPvtokT8ViFoLu0yv3dQWAbZw2kkdWcbwgLI4N85mTmaGN15MSR6iWkqXMKxxvcPuCaG
 6m8g==
X-Gm-Message-State: AOJu0YyiDgvjq0gKbTRzv9SDpuUHpcqymOXTYOT0PqPJsY8KzGKT7YaO
 C4yVj3V7S6BAw0SM5gEy8m6jzRzF7he7kWI4bU63NxJVpDzhyV3Mr2a0fnFan42xooB0nPgyhgv
 DvhUBHHU=
X-Gm-Gg: Acq92OH/k1ei9noQ7MAMwM9N8fAWu1l5Kk+1PMnHMiTxoysTPF8jEl7VlJkSeN1KO9i
 5rQau6L7mrWIMecKJaQnAAT/UcRsGQ0Net9gIs8/q5owCMr5acMQM4+XiHGu+sMuxvVyFlbh1fi
 /6jyUE11L3HyNfeLP9KnS0prfRsV4yCFFk3npB+UBJeXcYrCeTinx+cR+EbadjdOM0+RXppHTRK
 130Dnnl6Aosc4RxsjlOvhnQcnB+SNkrH2GvCdkU1yCyLVhfVxcZLKodTo12ycLzRvPM0EApPgVb
 xM1GzRqJk5qpVOFrS0ukVIyUXidjwzrTlg4nkhZN2AFQmnYTmWSI9m9dQ9yLR+u0neEa3tveqjd
 c/pdT8ncesERFZbkjbHWF/nVmTQZzGv7GFOsF0PhvM/LxjBPQlCAUMaCHKyPwrMHJ7N4Ch7n4L6
 TdAu5+24FvPqXRQYNPmVrsWSKCEgKlO59S/5SBDVc=
X-Received: by 2002:a05:6a21:730b:b0:398:7eea:50a0 with SMTP id
 adf61e73a8af0-3b427c69149mr929775637.18.1780086663876; 
 Fri, 29 May 2026 13:31:03 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84214b02365sm2720237b3a.8.2026.05.29.13.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 13:31:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/3] docs/devel/tcg-ops: Fix reStructuredText format
Date: Fri, 29 May 2026 13:30:59 -0700
Message-ID: <20260529203101.290947-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529203101.290947-1-richard.henderson@linaro.org>
References: <20260529203101.290947-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

In the standard reStructuredText inline markup, italic
text is surrounded by one asterisk.

Fix incomplete style from commits 5e97a28a8b9 ("tcg: convert
tcg/README to rst") and 76f42780292 ("tcg: Add add/sub with
carry opcodes and infrastructure").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260519210019.11665-1-philmd@linaro.org>
---
 docs/devel/tcg-ops.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 56c0b0bd3d..92ef127c80 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -563,9 +563,9 @@ Load/Store
 
        ld16u_i32/i64 *t0*, *t1*, *offset*
 
-       ld32s_i64 t0, *t1*, *offset*
+       ld32s_i64 *t0*, *t1*, *offset*
 
-       ld32u_i64 t0, *t1*, *offset*
+       ld32u_i64 *t0*, *t1*, *offset*
 
      - | *t0* = read(*t1* + *offset*)
        |
@@ -598,19 +598,19 @@ Multiword arithmetic support
      - | Compute *t0* = *t1* + *t2* and in addition output to the
          carry bit provided by the host architecture.
 
-   * - addci *t0, *t1*, *t2*
+   * - addci *t0*, *t1*, *t2*
 
      - | Compute *t0* = *t1* + *t2* + *C*, where *C* is the
          input carry bit provided by the host architecture.
          The output carry bit need not be computed.
 
-   * - addcio *t0, *t1*, *t2*
+   * - addcio *t0*, *t1*, *t2*
 
      - | Compute *t0* = *t1* + *t2* + *C*, where *C* is the
          input carry bit provided by the host architecture,
          and also compute the output carry bit.
 
-   * - addc1o *t0, *t1*, *t2*
+   * - addc1o *t0*, *t1*, *t2*
 
      - | Compute *t0* = *t1* + *t2* + 1, and in addition output to the
          carry bit provided by the host architecture.  This is akin to
@@ -630,19 +630,19 @@ Multiword arithmetic support
          identical to the borrow bit.  Thus the addc\* and subb\*
          opcodes must not be mixed.
 
-   * - subbi *t0, *t1*, *t2*
+   * - subbi *t0*, *t1*, *t2*
 
      - | Compute *t0* = *t1* - *t2* - *B*, where *B* is the
          input borrow bit provided by the host architecture.
          The output borrow bit need not be computed.
 
-   * - subbio *t0, *t1*, *t2*
+   * - subbio *t0*, *t1*, *t2*
 
      - | Compute *t0* = *t1* - *t2* - *B*, where *B* is the
          input borrow bit provided by the host architecture,
          and also compute the output borrow bit.
 
-   * - subb1o *t0, *t1*, *t2*
+   * - subb1o *t0*, *t1*, *t2*
 
      - | Compute *t0* = *t1* - *t2* - 1, and in addition output to the
          borrow bit provided by the host architecture.  This is akin to
-- 
2.43.0


