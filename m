Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0896CD1489F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdieR-00014f-FE; Thu, 08 Jan 2026 00:33:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdicZ-00086o-2e
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:31:50 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdicW-0005eg-RY
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:31:42 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-bc0d7255434so1381318a12.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850299; x=1768455099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/nW4XYiLmggvfmphVZFuQuCaVORzFI4OKStPas9rXNQ=;
 b=gcOHy57skG8RZSLQprtczOccolHVX0NUw+Bnb6jegPOJv4gpxTQ47UgX8QTT+/2HyX
 2NplsfKpGST5izbmHJLHrRXzatFI3HGZNhcuxRA+Jv0AOOKW8gJtziQIsgetl/qe7G3H
 2vY0QGPotHWIvoksGyz4tWm6X6KhFRZ4geaykMR8fSA0am+MvVhzq0KWThsWVcwDX0Sq
 iX13ymm+Ysj8qoL3J4CHllvQvb/qKE0GbvxJwf6ITlARWY4IdlSWLRGqgnE7HaNFELUc
 7rvXTPhVRYgaTFpGIitaG2oN0XI5a5htf09WCHaE8Pgh2fNSZfBJGr97NQ3I/BrsFrui
 6zmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850299; x=1768455099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/nW4XYiLmggvfmphVZFuQuCaVORzFI4OKStPas9rXNQ=;
 b=T1Dyp2KKfIm5ubq7JHUoHC6qPd0kF4p4OugzymNVeyaIWauJb5TDoXAcNSDGm5cARc
 gGwQlGR/nJbC4BHrmaQ/Xy8KPkx0jF4+hqdkttt4u/N88n0O4fxAI7heBU2mqW9CtuQP
 uWIHidH0Kt/UDHNcsU1JiLfN2OFfm2EYhAKjWEhs0zJgG6l2iiqyZEjtUuSbH/Px8q1o
 +jpRGzbgwtfEoC4Kv6OSX4I7sl1FYZc/mq7EVskGl8OQjhoTvpnR3m+NrBXfP0yIAJ7/
 WV9PZBlT9/Ym+w41IuKkdpTfrqiiW9C9WCrYgJCP9EoMp8w174sn9PTxsc9uj6uy9WZ+
 83gg==
X-Gm-Message-State: AOJu0YwBt3N2k9315LcBNaw7XSgNG8yWuzIp9UcV83MVrboWCvmB9ctx
 kuPp+XV86Tnb349MvSQprFrF5HOJ7aaVFJyVS2t+0mHwiaYEFB73kadA+al4bpCFZyDuXBVsydD
 VpB1nPeA=
X-Gm-Gg: AY/fxX5dgfoO/UCz1zF1/WnIRwGrTPmKgzfGSCnYce3gYdWRFNdEkmsmH8/SEpNAlC4
 cVFZLOjWduBMMdz1w1bQW8uU/7FA5maqW1VEuRV/bXQ7Si6IbA+GLGzeViPHLl2DzY1Xz/Buutt
 O+HGdGEKIxhprZkTubvEUeI6EAZ6d8fmBlg4WPHwPtbu+UrsvG2JC6c4ZM/uVba97O3eInw1z+k
 ny22zwp/lmzqQNlW9eeyL1Jch2Ft5UZJofVgY7fLG8v2+xABgubFc42cNFDTxckDvfPg/oye5RY
 EjNJ8W9Y9AACxhXzIIgdKK4rh+R7Z5vHMMeKScTlNe4K5xEk61gRF6eoytxUHK6xVDFPTtGOqF7
 OStaS6Y3maWhfSd93yAlgJNC2DV5V9qWzWluCVBFfroh4s8nQ7E59oGpgY32aiGQxrYhHdOW9we
 Djnga/0iP3VHdYpV2fQQ==
X-Google-Smtp-Source: AGHT+IG3vzhuJmWJnWUfHpQypkg8vd5TvIVL7D7jSyklu4DNWTlieXe8Xda1whYVgysFJDMeMVatcw==
X-Received: by 2002:a05:6a20:158a:b0:343:72ff:af80 with SMTP id
 adf61e73a8af0-3898f9f9d3dmr5104215637.58.1767850299393; 
 Wed, 07 Jan 2026 21:31:39 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.31.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:31:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 39/50] linux-user/arm: Drop CONFIG_ATOMIC64 test
Date: Thu,  8 Jan 2026 16:30:07 +1100
Message-ID: <20260108053018.626690-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/cpu_loop.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index cd89b7d6f5..40aefc4c1d 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -146,25 +146,8 @@ static void arm_kernel_cmpxchg64_helper(CPUARMState *env)
     /* Swap if host != guest endianness, for the host cmpxchg below */
     oldval = tswap64(oldval);
     newval = tswap64(newval);
-
-#ifdef CONFIG_ATOMIC64
-    val = qatomic_cmpxchg__nocheck(host_addr, oldval, newval);
+    val = qatomic_cmpxchg(host_addr, oldval, newval);
     cpsr = (val == oldval) * CPSR_C;
-#else
-    /*
-     * This only works between threads, not between processes, but since
-     * the host has no 64-bit cmpxchg, it is the best that we can do.
-     */
-    start_exclusive();
-    val = *host_addr;
-    if (val == oldval) {
-        *host_addr = newval;
-        cpsr = CPSR_C;
-    } else {
-        cpsr = 0;
-    }
-    end_exclusive();
-#endif
     mmap_unlock();
 
     cpsr_write(env, cpsr, CPSR_C, CPSRWriteByInstr);
-- 
2.43.0


