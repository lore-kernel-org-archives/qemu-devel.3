Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE31CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usO06-00010d-4T; Sat, 30 Aug 2025 12:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usERq-0007cN-3A
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:48:22 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usERm-00055F-Px
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:48:20 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-24879ed7c17so21044745ad.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532897; x=1757137697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TShQhvQkk0r8kwmD31rsIF74/vVO8BlgWjtZI7/oTSM=;
 b=wgUXFGn7EdCTt8tgxANDme9ETBYU5TJekk4vsClNazwSoQ7iv+JQK+tbTdlYhY2gHR
 9S7xLarSMWk3ncgM9D9t4F8mj938iM3LrQ8LBc2i3biG0ZwlaIJb921Fs78dZ0eCMrwH
 bwMnMQMMhRrvtuvzAuNvX/2OVgGWDPhw2q0M5okXomoDy9xT+dHVy2vL/SO6iRl7h5NE
 RqyEibjo3qR1oBpjhU9ugHH7pISsiZTMLGWm6AK4TmRhwzEj/9JRtlop6whU2hzgclt3
 JXQ/fyGKxZNIQtScougcyvbLiHyBtvSj8LlZaX3EVf8KVmNnpHqdpc7AcrCggoD/XH8b
 TkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532897; x=1757137697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TShQhvQkk0r8kwmD31rsIF74/vVO8BlgWjtZI7/oTSM=;
 b=lP5+BqSvBJoI/VsI5OJUozzwoC1GZQ3VE2gqrgku1KAzvw+vG+sMenmQ1xl0Kin/aO
 ujUX/IRi2zaBPtQe39lr+u3O6CMwczSGA+RwY7iYD2UcDPymWXdfdbtTfC0ti8oY5/oJ
 pNPSa+HdBB1pPXZmjIMtrtYJwz7qx4wumGIiA+GMxps31tLVFDTcWZIPLYEEanZRHkRz
 iijecnub07w1fkzNmMxGAfSk69FmUoPhZXx4irj9wr840KB8qoj41prEvd32avTBobvu
 cJa/kCeJPCIsHSeWtm1ci2oiCvYxod8g5dHWDaV9yLLVpOvpJzWz3QamHigZeYqvm/rl
 Z7xg==
X-Gm-Message-State: AOJu0Yw4uENctXoCeALHlcvi4/5oOirEMhvswqYtedFTbFekx9YFplPA
 wzOp/iwq4duDJGRemwgnoD7nnUzpDZnXcUf/zfxCRubKZBM+pyR3VUvJn11f65L/J8Q+vybLnbR
 z0YtoU50=
X-Gm-Gg: ASbGncvXTO9QB2mXr5pdkWtna7RTf1U51wZaGNG9MQhHSrP7XwPgMlIpVqLwWr1woGc
 DMoAYY1C2WatoNp55BMl5L1hTRUxXvWGPpBv+Aj5JasaswDc1z7I5jr/JzxGgG/hLW4Ml25u9lY
 F4eLBmanw+BWxQKojL+BXpoh3ZSbXi18xcw9pgPe7XyCi00qhotRdlgF20OKxUbfDiczgF42ub1
 +NnpsAoMxQmUL6mL6MrR1BtD5g4SyjzoEwrPG/S5r5cS2FGWlp0lASBAu2G00jeijZbeNavlUHY
 QdhuOvFpI/PNfeDh+8qaQXPlGxfsrvLmQoSvu5LyOqdMJzhNUzKSMCNgZn2ZWh5OPkxhDXWFV7m
 e1w3RmVY+OwDAMsrXo1Zn1R72deMdPdMwXwP9GausGge+gtGG3GzGX5cZhZ6scaifKwREWnmLww
 ==
X-Google-Smtp-Source: AGHT+IHPxYycauEFdMq8lw8oqSsUw32sICv5TA/ZeaaSpSqdB/EBVwXDxWv6W1DcRXochpe+nnnKVw==
X-Received: by 2002:a17:902:f612:b0:249:2360:6af2 with SMTP id
 d9443c01a7336-249448db16bmr14718565ad.16.1756532897423; 
 Fri, 29 Aug 2025 22:48:17 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:48:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 79/84] linux-user/aarch64: Inject SIGSEGV for GCS faults
Date: Sat, 30 Aug 2025 15:41:23 +1000
Message-ID: <20250830054128.448363-80-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_signal.h | 1 +
 linux-user/aarch64/cpu_loop.c      | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/linux-user/aarch64/target_signal.h b/linux-user/aarch64/target_signal.h
index 6f66a50bfd..e509ac1032 100644
--- a/linux-user/aarch64/target_signal.h
+++ b/linux-user/aarch64/target_signal.h
@@ -7,6 +7,7 @@
 
 #define TARGET_SEGV_MTEAERR  8  /* Asynchronous ARM MTE error */
 #define TARGET_SEGV_MTESERR  9  /* Synchronous ARM MTE exception */
+#define TARGET_SEGV_CPERR   10  /* Control protection fault */
 
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 1
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 6060572eed..41d6b35498 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -89,6 +89,11 @@ static void signal_for_exception(CPUARMState *env, vaddr addr)
         si_code = TARGET_ILL_ILLOPN;
         break;
 
+    case EC_GCS:
+        si_signo = TARGET_SIGSEGV;
+        si_code = TARGET_SEGV_CPERR;
+        break;
+
     case EC_MOP:
         /*
          * FIXME: The kernel fixes up wrong-option exceptions.
-- 
2.43.0


