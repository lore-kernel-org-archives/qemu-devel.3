Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23158C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 16:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbigD-0004RP-R3; Sat, 25 Jan 2025 11:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbig2-0004Nx-Jd
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:06:31 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbig1-0000j8-1L
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:06:30 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361f65ca01so32098545e9.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 08:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737821186; x=1738425986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7GbKJhiOZPCKm4Y+qVPyi/qaA7c9EbLbN3OgEPNHS5s=;
 b=CeHlvQOyl+3+ThFv2AqMEw1mSUY6S33lbTQH0y2CMHJ82OfImqqM41ymOOiLyFIsXf
 LFqEOJhffLEtWPiFeDs+aMDvUyBNSPd4mXISnt46lG/96pQmexCoVtXBR99+czv6YJ4F
 8yTxML1fc0+ZRKm6YYS0NRUWix5nyfNwWsoP/+BKhID7mb9BhoJRWdpHSvsm6tcGANeA
 CY5GOEGwrCBPkPaAhiG8gtAqXPRBq7/a354C9bNSaYiEobUgtAam7N2o59KCUrrDRdy6
 geeYYJWS5vm3rUgeFOHtBksEuzWaZhzPUiwZqxgzoXfhtx0gYn/r4PSa9zmx0rkNaG/o
 mmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737821186; x=1738425986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7GbKJhiOZPCKm4Y+qVPyi/qaA7c9EbLbN3OgEPNHS5s=;
 b=AuGO5gLEvgE+coRimCyoYo2kBEvSMTOy6RTOs8UkbADCdQxRMYTh4//u2nIz1JQjtO
 +4tADs3QMhbmPlpXbPfqQ3GfcA4ceQSzfTGY7a1ANftLy5dn6dPAFBD7L29JWzQ31QvJ
 DO8T6uShkxtxXFY0Tng5CDMVVtwwWcdEimTx39dvoSd7sUJdQWijXUwYRHUZJj7h4CFe
 YrnZAcZGAqdAWtMct2jDdc9oKGodbu1AEG5xx0v5UmHsn3L7swSDqgvpLSTRFghOpkSO
 MncNMeDqVSLv1+EcXbwFc09IgjZuK8+cLjqvgAquuVTgjc3Sh/ORzuipjdHnA6tjBHiy
 e3nA==
X-Gm-Message-State: AOJu0YwSA6qbhIrlXpLVgLZJq2DWtZzm4RN2PHrGHkZYPDMwoMYaRI37
 Vw/OeOP+4cA78MuizKvwLNlGxAJ/i8ZVD1wFg1XK3N8D4iQCRkO/SPMcZ3wnlWMoCYBjwCRAikk
 CjaM=
X-Gm-Gg: ASbGncu/z28zX/ypsZ3TVc6Wgb/LgqwZQj3spOg6BjrFRsG3Z8dc/jjrYK1QaCHjCxp
 1p4FzSFS+FYT2nXYalqjH0+GK1lqptqrHuszasxjEtjERBol0KATKi4PXEYoOMN+UsalnHc5jyv
 Hz0vYhnlNE5X0pV03IfdSBUBJLcYtBe3BrOz43eaLtc/80JqtdNGriOWWHb2icIets9gKU8BvuE
 hLlM8YaxhqQ3CNbpo3akv/qLXAynLEQClTR1MQBOyvMnAQcev+RlLItf3w7H8Wc3rgTwchf7CK0
 huxE3+eejpd1Zka3B7HQxladIDIqV7SnUuOqp/RcJU2kxhHtY3iNRrt6AWi667vcN9OdFzM=
X-Google-Smtp-Source: AGHT+IF+onhQwhRyGv3ObT/uHizq6exWzIsKvQcyAnQtFEDnHtS+igSz1tJzUBwrm/Ks/q2fUb/EPg==
X-Received: by 2002:a05:600c:3544:b0:434:a781:f5e2 with SMTP id
 5b1f17b1804b1-438913cabedmr292044925e9.8.1737821185793; 
 Sat, 25 Jan 2025 08:06:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4b99dfsm66040915e9.26.2025.01.25.08.06.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 08:06:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/24] target/avr: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 17:05:34 +0100
Message-ID: <20250125160552.20546-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125160552.20546-1-philmd@linaro.org>
References: <20250125160552.20546-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 8a126ff3222..8712813f3e2 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -200,6 +200,7 @@ static void avr_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps avr_sysemu_ops = {
+    .has_work = avr_cpu_has_work,
     .get_phys_page_debug = avr_cpu_get_phys_page_debug,
 };
 
@@ -232,7 +233,6 @@ static void avr_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = avr_cpu_class_by_name;
 
-    cc->has_work = avr_cpu_has_work;
     cc->mmu_index = avr_cpu_mmu_index;
     cc->dump_state = avr_cpu_dump_state;
     cc->set_pc = avr_cpu_set_pc;
-- 
2.47.1


