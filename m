Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E13D4A5EE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgagN-00059S-R4; Thu, 15 Jan 2026 22:39:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgagJ-000568-Pt
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:27 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgag7-0008My-BH
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:24 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a0ac29fca1so10954765ad.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534754; x=1769139554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9u0Q1JjyvUW9YFkrSrLxZdxPG6FLLM0OzXcJAGsPT8=;
 b=Ax6hB5pbAO6GFreTlbKBIbd9kCW5W07375yqZJ9MiTxtlwKEgcSow9a3/kzCwru7bL
 dKZSheu4KrDPoiHKG3Nlv+5mh9tzSl9jCl4sKhCg+/uuFFYsMVWsLBDYqG4tjzdznG9X
 9lTZXtDYODPkZCKmKEN0OCUD5zD3J9m/Di0P/jmiRtCcvihKzwcwu44rd43kp2FTgORA
 oZThKIciq1Oojjh2DR+9/laXDLb+0kWF++5Ln6pjZeLpoRV+cCz+hHdzUXIxGL5DQcD4
 80k9EyeDhXiryRphR2S54LosEiaT0UhxNXE3V7g2HrfvDSHNMsJG3vdPME9a0hAxlKpv
 qtgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534754; x=1769139554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F9u0Q1JjyvUW9YFkrSrLxZdxPG6FLLM0OzXcJAGsPT8=;
 b=PTU5cgEAO7ZZ51HaHlYMnWp8OM0wk1yblgXmSgMtyzqOIV3zpK4QKvqjdJLeVN1WDG
 6rVop938bJ2Nj3CIYc8YD9/QzmFLLsawYVBlgOPK+WznNQnuo8HbQkptYfC+lBYf7/hC
 4pJJljNPITnMVK2gWxfvq/BD+pZWnyV/BEuYpFLtbsc7VmGK7QcduZ+QAAxUDTzmhTOC
 ArHRGPCGmVGoJcOuZLTxn0hvQAjCsCMsqXWKaP6HQTnM3tl2VsMMWLAgE4ySDEvxXDkS
 /QOlx3ZBFwpS9tsMsK6vWaKdD44UHlFe3oSSD7vyo3NqJe54vvaO/0+CJnE2Vv5poTpr
 4FuQ==
X-Gm-Message-State: AOJu0Yx3jmlFpPUP5h7C5hgNu2V/VCRPIl3ZyIh/TGmwznRdqGLP45vd
 1K/rzglBAl3dRA8eFOetsFMlbHWbD6/Ihpl3Cujkc7UZTMgfe1vfYQJsr1q6ElB4pA29dw5v+tl
 5GQ8DieJgmQ==
X-Gm-Gg: AY/fxX7gtigU9QymN0ezqAMs1ZNNIxyFXrOzUuXnowKr9ibynvtF9BF6K3z6hvJqFHq
 WjLaD1xC/OGgTKORu4jcaA86Uc8zynSCf6ByUxlBPNzaIu8YGf9Nxs9bLGgKqp43gj13q/LJ8XJ
 1yBXEmesAr2jY2n1uzeDp1sZ/i63y6iaeayes9BB6Z9wkFmY/yMdgpRIf5ISedqf9Q17Cx0Bxhd
 DjbBa5DCRILR2Xuis0o8EOuePMPxDhvsMLbbsh1olJpZgqvg7uCX02ynu1uOuhfcVyL/1i5uVh8
 ULZW7NoGYVJbcCkd6RNCmpWpeQgAeyfdqoMydsAJRvf3fAQDWoxP9J5+d6HcxSDml7SPqHKU0Wa
 JXODp+RJF8tFC9msHj2FsUezdb4SNSjqmTM2WV6nxKLLk6+28M2gHya+2TP0fOrI0lcwO3GTViy
 5Qp7QSETi0frecGL9b7w==
X-Received: by 2002:a17:903:1a8b:b0:29e:9387:f2b9 with SMTP id
 d9443c01a7336-2a71751c69emr15910255ad.24.1768534753799; 
 Thu, 15 Jan 2026 19:39:13 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ca9d5sm6527975ad.25.2026.01.15.19.39.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:39:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 46/58] linux-user/arm: Drop CONFIG_ATOMIC64 test
Date: Fri, 16 Jan 2026 14:32:52 +1100
Message-ID: <20260116033305.51162-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


