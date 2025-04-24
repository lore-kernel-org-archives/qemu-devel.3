Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977BDC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7l0R-00030Q-NM; Wed, 23 Apr 2025 21:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwy-0005TU-Kv
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:25 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kww-0005Xp-0v
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:24 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b074d908e56so263356a12.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456420; x=1746061220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tGFd37j+l93zOqMm5a5N6sYRNEZpuNLxVMZbuAwdikI=;
 b=PcKtJh0v6w2/7s1PehhXD46HTHmxjVXUuevsQqjrGZlAZIY6IF0ZT/SCsv48kNFd/k
 socX4MyM2xQuuTTQHyeZZzsGtnAnjLZ8GJNCysOrTV1IQ6Sk05NhRqjmh3ArbzI04CIQ
 jVeQ+G7dxsyJH/vyi/vprVSHZT1E7BuBIMz9btlGUXGDU4S3MAumpFpsCynK4L/nGM5Y
 Cd5ZycJ+3oDIYSVf6KpoRiEsG5iAuGAV6E18apFEVU04aPCtNE8znQUcpQQpyk+nGjL+
 eiWooGpp7MfMJcR6xqvvRwwuRhv5eaSs9N9aSsqhVbLEUUGHWYQDvhZ3TaFii2KnHFR5
 vVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456420; x=1746061220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tGFd37j+l93zOqMm5a5N6sYRNEZpuNLxVMZbuAwdikI=;
 b=Pc8dI1wPn86SILYFGZ2zvucytTKGyUQPOH4jTnVWFC+L90fe5uBk1buHi9guArMTSe
 ObJRqMydoTGrStluA6f6IkvoR9OWgigMI6H729kzxiLJh9ttjvLV6+1+uCgO7r2/LFeA
 zjTm6N2NRlEDT4TouxhSIAOjRmQj5ambyTxwJxblrVNtEy3/YEOz81D7NhFEEDWa0amD
 H1uF7i9o+FxdKSiJGdm1JwcQBnFkMxOSc+kbnjjHSMwW9uqkrfVQS+HlWnO+W7u68tGM
 51zDhHCVwdW36ChWoruRLdZsp2fQ6nqkKQ7h1iIAcDiWA60GcFvgje4mjgYUVbgllitb
 xQzg==
X-Gm-Message-State: AOJu0Yy1r4U0afM2/zswNCXclXUzuzCClREDIS0h6EsmSX+9cjKn+vvy
 K2UUPzlyrcJfk74V39EWsCMhoO1RTbNU8aKr4u1C64TlhCHC1exrwzx9ipTlWL/LFJjcGedBMpf
 h
X-Gm-Gg: ASbGnctUvaWYo+hKXdEuyQpHiNAO+B3ahAui+NdCDWIsHJYkIenoycZ6hMOtW7sjkOA
 3Av1eizxt6c847FYocySdMWOdwJyhpT/Xy/+Gw/iL8o8MInVf2QdrotSQIFJDH0e6BSx+2IahKC
 O/hMZmfC0mIipVMRZ1rDiyNDloAEFonLVyhD7fm3XWP14SHPzKbym6LpDSktU4f9tcstHPnd5El
 a+Mw6vaIwfp3NQAHx2fdhRucixfysHWTWJl7vs974m8qVzjhumI5sT07E0kRGyazrU/vC9BXMc6
 1D3bFXbl60NWKFx6waUXlxZzPz6h/JYUW18iq1fL7TWGmJugW6BukzCjuphcO7Temk3PeuVliN8
 =
X-Google-Smtp-Source: AGHT+IHaN2djWSm5gZTlcvneydlhpWV6XgbgfD5pD4pz8ObgOWk4R7oSdl54IYmtiAn9XpEeeir/+Q==
X-Received: by 2002:a05:6a21:3386:b0:1f5:92ac:d6a1 with SMTP id
 adf61e73a8af0-20444e81bf1mr805281637.4.1745456420448; 
 Wed, 23 Apr 2025 18:00:20 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f45c7sm129259a12.16.2025.04.23.18.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:00:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 143/148] accel/tcg: Remove mttcg_enabled
Date: Wed, 23 Apr 2025 17:49:28 -0700
Message-ID: <20250424004934.598783-144-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

In qemu_tcg_mttcg_enabled, read the value from TCGState
and eliminate the separate global variable.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-all.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index bb759cec07..b754f92905 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -60,14 +60,11 @@ DECLARE_INSTANCE_CHECKER(TCGState, TCG_STATE,
                          TYPE_TCG_ACCEL)
 
 #ifndef CONFIG_USER_ONLY
-
-static bool mttcg_enabled;
-
 bool qemu_tcg_mttcg_enabled(void)
 {
-    return mttcg_enabled;
+    TCGState *s = TCG_STATE(current_accel());
+    return s->mttcg_enabled;
 }
-
 #endif /* !CONFIG_USER_ONLY */
 
 /*
@@ -124,7 +121,6 @@ static int tcg_init_machine(MachineState *ms)
 #ifndef CONFIG_USER_ONLY
     if (s->mttcg_enabled) {
         max_threads = ms->smp.max_cpus;
-        mttcg_enabled = true;
     }
 #endif
     tcg_init(s->tb_size * MiB, s->splitwx_enabled, max_threads);
-- 
2.43.0


