Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61862E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 15:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwLS-0007Hx-An; Wed, 18 Dec 2024 10:52:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNwLP-0007Gs-Um
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:52:16 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNwLO-0006Bu-5r
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:52:15 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso69038675e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 07:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734537129; x=1735141929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CIxt0xCHnXjAllBjGh6XMGwcFEqpupPAEWRBOMMJJcc=;
 b=WJSaWaCfIxSpwpnzipVZgXq/cWT3RexYMrMCYrXtZ8svGVKJRz1Nldu1odCZ3MA3nf
 RqIQ/CpmStpl5XEUlZQB95SC1QChEoYCBHXPkkW1nY/qHyJWdZO3/K0MLhjvwXVCczTL
 TLfH2S2+2n0dR2oc8rNF30I1ZVFwxsTTKe1uc8k3/7hwleUWBRWjTR2BDWZL/8hLgzhH
 dKfhOFgRcVp0wVazYIYle6OkXpEEsfh3dXz/BJo9nOorY1URYNPTIe2BOfWn+avb2+l2
 6iQ6cwUZX+G5zygII/aPCqsn+573zKM9KHBgthe/rquvH1gMI7SpF24iVCzUctNVdQhL
 +czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734537129; x=1735141929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CIxt0xCHnXjAllBjGh6XMGwcFEqpupPAEWRBOMMJJcc=;
 b=uMwS57srNewhoeI8UrgIPhi2Cb2xS3OReHcpKKV06dI2cj684YppGahnkYZXbfe4LF
 S856/KYXgF8P3dHgLinZb8fjuBBvvtYsklLNnVYwDMs9bgkTFSN03FlxhGjQGyBwmZC/
 /k6P2wfJ/NyU8HraXhExI9GckR8p6M5sKNcDD19MZ3dbeFZJjTrcDkGsAAtryUFspbwt
 2dwJfy8Nx4vCaFWP8+vyE0USQPdaGrZx8hiTY/0jLylXcI02yt60NZj5jUcptNpa0Hpo
 SbjLNGNd27zQD/WXI2k+ErC6AnKNDFXy0CzNpQTkTFVvuPbJeZBkf6WHv7BM1+1A7uwN
 Lm5w==
X-Gm-Message-State: AOJu0YyILeHPhfQxOK6beW/4TSJawWEHbyOjzqsK8u/jZ+8qsE9d4IEG
 Pzz8xBefNBFKKvKa+fKQ8J6N/I9s4V4Q4q6TWaNjHrF47sV9/K/g/ZPrRIiMnBvDScPw8UPTgCS
 Z
X-Gm-Gg: ASbGncuNcCUfeBSpACota3rLZ0hY1T1NF2ilqhqX8Wa0IRyNcNnQjXKapFCxis0BfNn
 5P59Y/fugKzTnb+JMZ8EYiYHHUUBPT0Xm3bNyFFluqe5ucgtyQR0hJvSJydFKP/4VNsZHohhWn0
 xg81LNOCmLxOKZ7A0ISsIKnmfFpqB/N9YmXuw5uvwcbfJP9fTVqQfqY3+LtPAVblWDZbGCfs/Sn
 HVszJuiVxpYKciSuOTab20fAERbHi0qwBC0MRP1bdfYUjC9V77/vD1JazMJd/IHX45yoE7O1QC1
 3OPz
X-Google-Smtp-Source: AGHT+IH07Egt/664N0XxOjg0KIstFjGiUodPoUsgRTj4gIS4CVqDcon+nERuBKxshQoZSmr7pKMChg==
X-Received: by 2002:a05:6000:144a:b0:386:37bb:ddc1 with SMTP id
 ffacd0b85a97d-388e4da40eamr2751659f8f.56.1734537128946; 
 Wed, 18 Dec 2024 07:52:08 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8060fb3sm14225403f8f.94.2024.12.18.07.52.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Dec 2024 07:52:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/4] target/ppc: Include missing headers in mmu-hash[32,64].h
Date: Wed, 18 Dec 2024 16:51:59 +0100
Message-ID: <20241218155202.71931-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218155202.71931-1-philmd@linaro.org>
References: <20241218155202.71931-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

CPUState* is dereferenced, so we need the structure definition
from "cpu.h". PowerPCCPU is declared in "cpu-qom.h". Include
them in order to avoid when refactoring:

  In file included from ../../target/ppc/cpu_init.c:27:
  target/ppc/mmu-hash32.h:6:23: error: unknown type name 'PowerPCCPU'
      6 | bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
        |                       ^
  target/ppc/mmu-hash32.h:66:15: error: incomplete definition of type 'struct ArchCPU'
     66 |     return cpu->env.spr[SPR_SDR1] & SDR_32_HTABORG;
        |            ~~~^
  target/ppc/mmu-hash64.h:173:36: error: unknown type name ‘PowerPCCPU’; did you mean ‘PowerPCCPUAlias’?
    173 | static inline void ppc_hash64_init(PowerPCCPU *cpu)
        |                                    ^~~~~~~~~~
        |                                    PowerPCCPUAlias

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/mmu-hash32.h | 3 +++
 target/ppc/mmu-hash64.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
index 2838de031c7..abbff206d4e 100644
--- a/target/ppc/mmu-hash32.h
+++ b/target/ppc/mmu-hash32.h
@@ -3,6 +3,9 @@
 
 #ifndef CONFIG_USER_ONLY
 
+#include "target/ppc/cpu-qom.h"
+#include "cpu.h"
+
 bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
                       hwaddr *raddrp, int *psizep, int *protp, int mmu_idx,
                       bool guest_visible);
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index ae8d4b37aed..b32e17c2c58 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -3,6 +3,8 @@
 
 #ifndef CONFIG_USER_ONLY
 
+#include "target/ppc/cpu-qom.h"
+
 #ifdef TARGET_PPC64
 void dump_slb(PowerPCCPU *cpu);
 int ppc_store_slb(PowerPCCPU *cpu, target_ulong slot,
-- 
2.45.2


