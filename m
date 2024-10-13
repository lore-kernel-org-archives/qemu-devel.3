Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98493CF2579
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 18:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t03d0-0001JO-U9; Sun, 13 Oct 2024 14:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t03cy-0001Hu-EG
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 14:47:40 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t03cw-0002Su-IJ
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 14:47:40 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20cb7088cbcso13897995ad.0
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 11:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728845257; x=1729450057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SF1qZZsN9Tce3zMt/Ww343xHn3LIQsfZL/xAHrr77pE=;
 b=LmwrBdA2lePbQS47fTiEqEtedR6qZ50j+BNFGnJVNpPkPY4o4+Tw5s+6B3MDmFf4UN
 hOzeQnw6XqkxeguYeod3xjNqY6d78W/PC/lKioJYm2mSZPkMzFrL3FFS0CJaIpmQdTZc
 mfCnex1ZCU1kpYoWtL0AxXM81vkyS7Cm6OaWIZPLj0v7kh6npFSbgroXAuATPJoxaill
 /D2kSS14X1JOmNqukVXH85JBecI178q2xDhS9yGo6Z1Y8uWd0rhSqJNjmnMlUppFgaMg
 Hz/r473GQG9ZBqepkuNIV7Cm8wNDiNhfxxQowd72YNm/hb6QndMt+GggmM4mXn4OIj5n
 PU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728845257; x=1729450057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SF1qZZsN9Tce3zMt/Ww343xHn3LIQsfZL/xAHrr77pE=;
 b=SMOdxKMLyT6iiNwmtlI5pAd2cXSd1ZOrN/yYEALV9yIueUQQxKnpfxOGEesNCZ3WFM
 lTar7lbTb3xtc8DWC5PsQxm230cjbwVQJH+tD92RgvUQrcGxAs6QTBe5n9XvhIdIXD97
 OWT/jzff/R96dqbu3NuAhFBO/2isdcWHa9pfJNMXwF+vCsH6QEdqcaVNZG+Di/NeB34K
 We3fJ2/wqTQVD6Rb4z+2iGLZi55LmS0OZ4BK76nouRA6VU2NFqe7oSSvbbqaefBlXy2/
 +vzGmUH3fgUYJz5KjqGrrlN733+sZscjRFbJr5dVlmejyzdw9oVL6UCm8eUfP0YcTbiv
 jM8g==
X-Gm-Message-State: AOJu0YymDI7BQpiGDH+BH2yR2L7JT+f961RHdzSnBCPcJ1kZcFG0WYcu
 DkfNqZAL/gofixET6ACfWcW/IFZ50lZyN7tdrhvk+dMoF7zlMqsjN2YwuDYLPzc5hbMFY8yreKN
 z
X-Google-Smtp-Source: AGHT+IH34Gj+9ie+Ww5w99Nayxeq539t7+VFC56usb2+HbjbwkCaQnGw1VaJ0XIbNwvsU3RKZisR+g==
X-Received: by 2002:a17:902:db0e:b0:20c:7720:59b8 with SMTP id
 d9443c01a7336-20ca142a448mr132609625ad.6.1728845257298; 
 Sun, 13 Oct 2024 11:47:37 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c35522fsm52811805ad.296.2024.10.13.11.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 11:47:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/3] target/i386: Use probe_access_full_mmu in ptw_translate
Date: Sun, 13 Oct 2024 11:47:32 -0700
Message-ID: <20241013184733.1423747-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241013184733.1423747-1-richard.henderson@linaro.org>
References: <20241013184733.1423747-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The probe_access_full_mmu function was designed for this purpose,
and does not report the memory operation event to plugins.

Cc: qemu-stable@nongnu.org
Fixes: 6d03226b422 ("plugins: force slow path when plugins instrument memory ops")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/tcg/sysemu/excp_helper.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 8fb05b1f53..8f4dc08535 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -62,12 +62,11 @@ typedef struct PTETranslate {
 
 static bool ptw_translate(PTETranslate *inout, hwaddr addr, uint64_t ra)
 {
-    CPUTLBEntryFull *full;
     int flags;
 
     inout->gaddr = addr;
-    flags = probe_access_full(inout->env, addr, 0, MMU_DATA_STORE,
-                              inout->ptw_idx, true, &inout->haddr, &full, ra);
+    flags = probe_access_full_mmu(inout->env, addr, 0, MMU_DATA_STORE,
+                                  inout->ptw_idx, &inout->haddr, NULL);
 
     if (unlikely(flags & TLB_INVALID_MASK)) {
         TranslateFault *err = inout->err;
@@ -429,9 +428,8 @@ do_check_protect_pse36:
         CPUTLBEntryFull *full;
         int flags, nested_page_size;
 
-        flags = probe_access_full(env, paddr, 0, access_type,
-                                  MMU_NESTED_IDX, true,
-                                  &pte_trans.haddr, &full, 0);
+        flags = probe_access_full_mmu(env, paddr, 0, access_type,
+                                      MMU_NESTED_IDX, &pte_trans.haddr, &full);
         if (unlikely(flags & TLB_INVALID_MASK)) {
             *err = (TranslateFault){
                 .error_code = env->error_code,
-- 
2.43.0


