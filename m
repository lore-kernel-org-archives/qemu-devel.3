Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C4AC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 14:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVJx-0005ff-CG; Thu, 01 May 2025 10:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVJw-0005es-6y
 for qemu-devel@nongnu.org; Thu, 01 May 2025 10:55:28 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVJt-0005Qi-Hb
 for qemu-devel@nongnu.org; Thu, 01 May 2025 10:55:27 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22423adf751so11443055ad.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746111324; x=1746716124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x/PgQfi425UDgUiGbtOMZZgEtm+lUa3KGmn3dWsY1lM=;
 b=aWCa8fk2BJ6ubapxJxbojAKB/PSF91mWx8SfU9WnroYJAaKgAcrWRQm8nKps2qwjV2
 ydbKHldijZ9ECYdJ6C/sGsowHgTiinVZZ9DY9QGEPOOeiEo8nfeeh75Dn5MURti1nzNI
 7v1HxcyIPncrrRM9kBLQY3nvzexwIciO9u0LajSatSbBly5/DMqgjM2nlyQ1lW8/canf
 iqH3rSD6bk/IPQYGHPVlP2ekmx7ZrhWoCOaJMiV4xwkRzm5vURxZhKvgW6QhT6H8fX1T
 S26/+/aA4r/ubtMDwhPNiLxzWTfpz42SOE4mhJf0HNamb/mPTMuh3GaR6fi5FeTwU9Md
 /QFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746111324; x=1746716124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x/PgQfi425UDgUiGbtOMZZgEtm+lUa3KGmn3dWsY1lM=;
 b=aQXNRAIaHy7jNkjYgLrO9UJZVBQSmCEJKhdvbvW6EI2MUHG6W5tKa8oKqgeQvMkSML
 Zie7XYoosJ5wArCtPA3/9RNySccKB+/tK0PHkrATyNJv677gHlwCgLZN/6abkqcCclek
 +7JsXeShHpyN81FsXoWq1gbnTwODrGF5ruVx2GjX4hXdfpWdkcRj4OGI/RopRsat7ic4
 twtvdfQlkRl0J/0TG72qhcoxdg3pLI/buQiODDim2IvbhV8IQHQB/ADE3QYWNol4P2uy
 7DgtAo3GMyyBariLJVaTLUtLYfoS3ZVfxNovbchlONqTyo+9ucLbwlBsq182JU4TIvJs
 W+NQ==
X-Gm-Message-State: AOJu0Yz13QWEpIqPOf3K+hJgnNPUg1jvOk2GgiVr7FHYzrhg6uIGjLnh
 gOOcIkUtMFze51FPpSq28pWsjy5Gb5J+5NVluCutxBOeiIXadEIs/oeuQ6W4Tx3XiP0y0jZIsxO
 J
X-Gm-Gg: ASbGncuaSKiYAMSjunaqntorVCJyp2h7GQFtOSUlLPVUNAvpZxfT7/ymgBJ1PbHoFBo
 1EbgRxchaBl4vkWHqbG2HBItd4+9QxnmA3r+/QALNnO3JBgFFSMXQtU/M2Dln4dn6fUL0ymUJE+
 ISnkJW8t31/v09tkPe/oYbi62B1N1HXeAGfKGJmEw2h+7zwgVbLOp7B/EeXqpfueaQ9m+Vb8gLP
 +/R8NumZWq4Eeu1GzPaMJGZ1cGMaxxdmLoEf8NRY6HvEdKT3Z+EVM/AxFSaSw3J8G0XEYS0mcla
 /Ky0IA6YAzftfIuHvo/QHRz2Ld4X9F68wlzlyv4pox9apy8LONNjTfMlwHzP/k3u5brs91wQKh8
 =
X-Google-Smtp-Source: AGHT+IFzgauIawkopdylbCya+8pGpTTVo258JyBdljaYdeHy3R4svlchVP4ZDVBe3gjDqOTjJJHyjw==
X-Received: by 2002:a17:903:1cc:b0:22c:35c5:e30d with SMTP id
 d9443c01a7336-22e084288bamr34948305ad.13.1746111323957; 
 Thu, 01 May 2025 07:55:23 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e0bb0e770sm7644415ad.92.2025.05.01.07.55.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 07:55:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/11] accel/tcg: Use vaddr for plugin_{load,store}_cb
Date: Thu,  1 May 2025 07:55:12 -0700
Message-ID: <20250501145520.2695073-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501145520.2695073-1-richard.henderson@linaro.org>
References: <20250501145520.2695073-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Avoid the use of abi_ptr within ldst_common.c.inc.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/ldst_common.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
index 9791a4e9ef..57f3e06192 100644
--- a/accel/tcg/ldst_common.c.inc
+++ b/accel/tcg/ldst_common.c.inc
@@ -123,7 +123,7 @@ void helper_st_i128(CPUArchState *env, uint64_t addr, Int128 val, MemOpIdx oi)
  * Load helpers for cpu_ldst.h
  */
 
-static void plugin_load_cb(CPUArchState *env, abi_ptr addr,
+static void plugin_load_cb(CPUArchState *env, vaddr addr,
                            uint64_t value_low,
                            uint64_t value_high,
                            MemOpIdx oi)
@@ -193,7 +193,7 @@ Int128 cpu_ld16_mmu(CPUArchState *env, vaddr addr,
  * Store helpers for cpu_ldst.h
  */
 
-static void plugin_store_cb(CPUArchState *env, abi_ptr addr,
+static void plugin_store_cb(CPUArchState *env, vaddr addr,
                             uint64_t value_low,
                             uint64_t value_high,
                             MemOpIdx oi)
-- 
2.43.0


