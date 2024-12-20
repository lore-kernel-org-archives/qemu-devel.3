Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4833CE7718C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfgc-0007AW-6p; Fri, 20 Dec 2024 11:17:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfgZ-0006r7-6R
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:17:07 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfgW-0007ld-Tp
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:17:06 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4361c705434so15598605e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711423; x=1735316223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5bc8CBnaM1oPkkMtIF7NNuH0SHv+cE5U0NdgeR9oFnE=;
 b=bXFm1qG8k1Yg3fpS24cjbKQYiCiK0Fof/47EqDryQ+1LqomirQX+MY5oBXuJQBo1CK
 GXU9E6ubsX0z6u9zL6X5zvH83Gg8LryjD9CJNKAGthKOTcbXBTuX/c/BHC41MhAa1WZC
 OFH2EZHv7qnZkc/hn3f0VDJxR+nRGoJENP9Y0T4NsGn1m8Aqf0iv4y3OZGj9ttW1Aqgn
 XLWwlXTvScQQDLtwrsMrLqcQz1zU7oPHRmG7eO9JO62LX8+dOeJZy5D/fDOclp0cB538
 XcnGpLXh2jhwTTKCSv/UwqzHPT5G8bLvExMTHq6OeWUADaN1gDdfUypVtW+D0lz1oeKj
 p60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711423; x=1735316223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5bc8CBnaM1oPkkMtIF7NNuH0SHv+cE5U0NdgeR9oFnE=;
 b=g4saONcJHD3N05Llfutz5rs3maMMvgx0ySfDPmgZdoQJEcAV1H0ycP9z3LoKPrvJMq
 vgxcWbQlda+O96++a/Szc9Vt6AxOsNBUCpXrDxyoJSKWRVKzeE6TxLWqMkfSSbOXPQ1M
 myOtuTHtEkxMxhZoIOUsgPNxlAQaugJ4pule1HDmx81c8EgUmkZ4Z36J4hAfxj1MHyJJ
 wmIf/+tABquWQKoAfDC849erWnn3AXlpTRdfp3hBOh6qztnePFQwopxPDXa2VW0xVsZT
 Ymu3kd6MT+/QnAFzOKcdzYrqALC/Dw5FmXbXePX9QWd2MS8ROwZ9ATORC0YnrhkodUco
 Q6wA==
X-Gm-Message-State: AOJu0YxTPMgd0jqNlE+P+1vu+wj+MbkHDnC/fSgNP3WH41B450doGA2b
 Oae4Bw97p19Onq0RB2yf+DuuIJ8b+h+g4BPQyC+nnQ0qeddpfG8PbSzAtdpDy25Xe1Mgkv1Ub70
 V
X-Gm-Gg: ASbGncsNtYTMS8s9gVXjOqcAbZfm790npCkl0n/JImxkKOtBCwXX7IOX2QoWxLrLTS0
 Ze/73ZJZdz1qqAtY5O2y5H+ENKBHL0cevysuHtpBecZ+CIATygxHtC0Ioi8mcPKHSzsCuP8BbaT
 m6LTCLaLqFSYmlg/qqtqaV7KXkbuGwmAiLOGu6UhGeJsP8XBsuGJTRkerUHEQgabmuNWs55ex2o
 ig+cRRtpjCk8Xxai7pIblT+eiPo6d+FeQH/4PMdfOJ+Jd5a53oH3ymOd2KdH2NO6/gE1ZGAB3Q=
X-Google-Smtp-Source: AGHT+IGGeO11V59UQGAcc+MlzF94h+HnyTGJ4FZfC+O6f47XqYOtth6uRX0QbyWR8vz9kInm/MCRzQ==
X-Received: by 2002:a05:600c:46ce:b0:431:55c1:f440 with SMTP id
 5b1f17b1804b1-43668b7a2cfmr33935025e9.30.1734711423249; 
 Fri, 20 Dec 2024 08:17:03 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b4471bsm83510675e9.44.2024.12.20.08.17.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:17:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 15/59] accel/tcg: Have tlb_vaddr_to_host() use vaddr type
Date: Fri, 20 Dec 2024 17:15:06 +0100
Message-ID: <20241220161551.89317-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

abi_ptr is expected to be used in user emulation.
tlb_vaddr_to_host() uses it, but can be used in
system emulation. Replace the type by 'vaddr' which
is equivalent on user emulation but also works on
system.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241114011310.3615-13-philmd@linaro.org>
---
 include/exec/cpu_ldst.h | 3 ++-
 accel/tcg/cputlb.c      | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index dac12bd8eb3..c1dd424dc1b 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -67,6 +67,7 @@
 #endif
 
 #include "exec/memopidx.h"
+#include "exec/vaddr.h"
 #include "exec/abi_ptr.h"
 #include "exec/mmu-access-type.h"
 #include "qemu/int128.h"
@@ -375,7 +376,7 @@ static inline void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
     return g2h(env_cpu(env), addr);
 }
 #else
-void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
+void *tlb_vaddr_to_host(CPUArchState *env, vaddr addr,
                         MMUAccessType access_type, int mmu_idx);
 #endif
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b76a4eac4e0..080cbcb34d0 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1504,7 +1504,7 @@ void *probe_access(CPUArchState *env, vaddr addr, int size,
     return host;
 }
 
-void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
+void *tlb_vaddr_to_host(CPUArchState *env, vaddr addr,
                         MMUAccessType access_type, int mmu_idx)
 {
     CPUTLBEntryFull *full;
-- 
2.47.1


