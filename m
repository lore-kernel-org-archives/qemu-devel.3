Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E40C3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 01:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0VYw-0008IC-KB; Thu, 03 Apr 2025 21:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0VYv-0008Hu-Ea
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 21:09:37 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0VYs-000815-UB
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 21:09:37 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso1654677b3a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 18:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743728973; x=1744333773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=diH6J4hofBmrfzs6sIeDZ95DC3OrtgE6crTHghEG7+s=;
 b=ABzPzSOXmfE4BFkJC8Cof5GE8klzGF4axLSMMviLuP/7yF63XE86fB0IzXxvyqGsp6
 ZBUf5nmoa2VA2PqUeKHC1lZcHpRZuMvSS3Uqj7/m4GuTvWrXXUHKAjeKEoHCEr4va+6Q
 l9BNgHDjdkZi4FFkdnhTgbbaRgZ5fCAvk7FxPIkmkSnKkX9/jePWYbTtDrcFugi2csjA
 UTgsgbg9flpSw/79S8ddA0rYb7qcOhIwJ/MSp08rm4N1xfVapsMUaNshNCU+ZcMyxX2d
 Fg7jN8kRnYZq93twHmm73cuNCF3bdo58w3UMU+4QblOqEpuyorSs2kzmR4SmOOLGR4qE
 fajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743728973; x=1744333773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=diH6J4hofBmrfzs6sIeDZ95DC3OrtgE6crTHghEG7+s=;
 b=MS1+N8FzMzrdD65sKxgZNqrjCt4sSFyH9YitaYh4x1kqJNCuUL79bqDtngh2jparii
 ah7TEDs+hm0YNrVlXhls3fXiAHWupXHO5N5fAihcJjb3RUsHcvOtUQUOhse3bFJ/9u1H
 pSowQyNN0Job0v55yW3MVIw9kHePAbfxw1KNdIqAUzeHRh/51/VZ486jYo4JVNjGYf94
 IavBLaGdW5yLSXL7KjZRqMq4hThvsJXxvuSzSHXUduZRoki86yWuZTz9wXLrDpkChbBr
 hwyB7ODdt/kUuyZVts2cq7n3dRiUWXmiaU/xnHT+NodIBCpFU0hTBRRs8Wa7PEiC7yl8
 jh4A==
X-Gm-Message-State: AOJu0YwJ6/Sc2sI3/7V9zXbjF8pHHabdXqnb3fterX0Q18Y6rvHMUk6E
 +fHDGNskfxawbGCQQwGzUzicLUO9oEox8L3DeyQc0BnbHUNKm/4xU11bagY1AeIwVi1MQWym3ez
 k
X-Gm-Gg: ASbGncvWTAF76ic3HGZQFk5Yc0X8VwsU5GM/cxVsfgmCkLzWTn5/8C6ye7j7mu4/2mK
 iKEreX7CD1IlSvU7+WLji8YU0yQki1kIjvXrw0ew9GkM74JmRb0nhkPmzxTXQBdx5xQntn52caU
 52lButRaFK1LOXyatDmcIKXggCtv6x1QMKbK9RikFT7tPw3caYhyJ9jdAd4IkO0X412mcMmsaZS
 qzUhKSUsirCQoy9MQzhpoWFJuXCt6dDdsgvU6FD4ZGw6kaY/Jo3CIr+wd3gkUk4IVeXChn7mbVT
 A9oxfI4Kkt3WVffgP9984vL0tiAXJxa1y7tu+Yjwlug1AiqtGzg=
X-Google-Smtp-Source: AGHT+IFHAJWsn0/232DMzmabORd90A1qyfzVFI0jo9fJEJ23sQJaR/n1PYuoo1Jprzp67CAbrIXHcQ==
X-Received: by 2002:a05:6a00:228e:b0:736:62a8:e52d with SMTP id
 d2e1a72fcca58-739e4b5c16fmr2348934b3a.12.1743728973165; 
 Thu, 03 Apr 2025 18:09:33 -0700 (PDT)
Received: from stoup.. ([75.147.178.105]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee2d9sm2171755b3a.39.2025.04.03.18.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 18:09:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Helge Konetzka <hk@zapateado.de>
Subject: [PULL 1/6] tcg: Allocate TEMP_VAL_MEM frame in temp_load()
Date: Thu,  3 Apr 2025 18:09:25 -0700
Message-ID: <20250404010930.164329-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250404010930.164329-1-richard.henderson@linaro.org>
References: <20250404010930.164329-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Be sure to allocate the temp frame if it wasn't.

In the resolved issues, incomplete dead code elimination left a load
at the top of an unreachable loop.  We simply need to allocate the
stack slot to avoid crashing.

Fixes: c896fe29d6c ("TCG code generator")
Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Reported-by: Helge Konetzka <hk@zapateado.de>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2891
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2899
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401144332.41615-1-philmd@linaro.org>
---
 tcg/tcg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index e8950df2ad..dfd48b8264 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -4671,6 +4671,9 @@ static void temp_load(TCGContext *s, TCGTemp *ts, TCGRegSet desired_regs,
         ts->mem_coherent = 0;
         break;
     case TEMP_VAL_MEM:
+        if (!ts->mem_allocated) {
+            temp_allocate_frame(s, ts);
+        }
         reg = tcg_reg_alloc(s, desired_regs, allocated_regs,
                             preferred_regs, ts->indirect_base);
         tcg_out_ld(s, ts->type, reg, ts->mem_base->reg, ts->mem_offset);
-- 
2.43.0


