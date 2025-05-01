Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAE1C3ABAC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLs-00014b-SM; Thu, 01 May 2025 17:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLV-0000mK-JQ
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:31 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLT-0001TR-OB
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:29 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3085f827538so1909308a91.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134486; x=1746739286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=27xaPxYDe2r5uVdVLgh1cUarR6C7vq0+H7FwQk1GTjM=;
 b=zhcQimxZlzqKdj7nJqieYs6AwvfgSo8b3MsvB0LXzO88HKBv9eNMtvfieFDEBjUUO8
 n1DO5YpXS0Mdw48v+YT6ZjlQsgdKQ1V9Jk5ybZIjMgKtE5k7eJjUolT+sQ1Fb0w6X2er
 FXT3m96KfBycVlF0AnzfRAQoTwrBdv/m2LDY5eFvvFNOUDpuqGLvOS7MAvhRmQZgFNbF
 qcIfIhFACQ/dt8GVCTwyJzVjfdHodjxzPAHzTce3lFVNIZS6YyBceABzYyHjJImLfAuC
 ERgy5LOPylM2vjEC3wcwJhrYOtFPOySFrxvQLxNCjEfNlDON+MR2yD50Glifc6yKLW2a
 jpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134486; x=1746739286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=27xaPxYDe2r5uVdVLgh1cUarR6C7vq0+H7FwQk1GTjM=;
 b=GwvtaHDYzobRDgIpEpBItsTkO2jUj72pe02ESO3ycnPv+tR0O9PzpnYBHYbrSBVMMe
 yGViBpLK6gL6dwiLoufBY4AAQ8p+7iAJXn4STTdMbdbPh/zUC36v04wb1HlDUK+6cw+R
 MU9/M4nQqLcVau+Wamx8JgbQsYU/ufO9jfqojctxINngHRQWfKqrBP47oClCoHmY4RSA
 bVpRlpztHgqgUtcruoYU8kIPpypx+C7bEnZSgIcB3b5irq2qVh3lbm0mde87Tzj0CUdr
 B85tcFxFH2QShakLke3OayR91HQAAKu3TnspoyZnbmjfsYgLYTmQxhYv39zhZB4cd5VP
 RtuQ==
X-Gm-Message-State: AOJu0Yyhawb1wHf+ZEQCbw5mhVG6dcHTaTS9M8T8UejzkrrvmA6bA7Hk
 0VxMj1rpMTAvfGwyAVo9k2zUcgksHhde2gm12TjdB36Tn+IjK/3FVPHAZxrj/BwwLJhn2dUANef
 S
X-Gm-Gg: ASbGnctO0y23yx4I2fhVnd4A2betK88lhNa8/QyTUhFd0sdT+eWLrEns4eOiyKpbrFM
 2V8w34rwoOVX7gyb1JpyTL1S2NAtthCX9WV7AX+xnLpa7gepAfZiqtIu30sYVSTmm04Qn+1xNZd
 XOOttkLetqFlw6d1RtBjaKR94Z5VBY48gmMIeigpucgmbybVX7i44XdaSeG3RPmaXyv8KlDF367
 rfJT/yWmWh3OyJVg+BHE35GyjuFDHlCzIHG0OgqrsOgGOzD6lXBrgOlxmicbCk0mgojxTB9x8dh
 lBisl6OvPR+YWWN4MwHMx+AC/mL3l3UL28MMpT+2G6Y9G/JKqqh8YdshEIvDqywGy8I6/tH80tq
 O9C2n0SE0HQ==
X-Google-Smtp-Source: AGHT+IHTBwW8JXdvNTThtYvmFCvWBmIesGGr0MhROZjkIRrhpyCSn349TNU9xSGD+PMDqVG5komrDQ==
X-Received: by 2002:a17:90b:2711:b0:2ee:9d49:3ae6 with SMTP id
 98e67ed59e1d1-30a4e5aa625mr1040633a91.10.1746134486180; 
 Thu, 01 May 2025 14:21:26 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PULL 14/59] include/exec: Include missing headers in exec-all.h
Date: Thu,  1 May 2025 14:20:28 -0700
Message-ID: <20250501212113.2961531-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

"exec/exec-all.h" declares prototypes such:

  void *probe_access(CPUArchState *env, vaddr addr, int size,
                                        ^^^^^
                     MMUAccessType access_type, int mmu_idx,
                     uintptr_t retaddr);
  MemoryRegionSection *iotlb_to_section(CPUState *cpu,
                                        hwaddr index,
                                        ^^^^^^
                                        MemTxAttrs attrs);
                                        ^^^^^^^^^^

vaddr is defined in "exec/vaddr.h", hwaddr in "exec/hwaddr.h"
and MemTxAttrs in "exec/memattrs.h". All these headers are
indirectly pulled in via "exec/translation-block.h". Since
we will remove "exec/translation-block.h" in the next commit,
include the missing ones, otherwise we'd get errors such:

  include/exec/exec-all.h:51:1: error: unknown type name 'hwaddr'
     51 | hwaddr memory_region_section_get_iotlb(CPUState *cpu,
        | ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250424202412.91612-5-philmd@linaro.org>
---
 include/exec/exec-all.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 24383b6aba..c46255e66e 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -20,8 +20,11 @@
 #ifndef EXEC_ALL_H
 #define EXEC_ALL_H
 
+#include "exec/hwaddr.h"
+#include "exec/memattrs.h"
 #include "exec/mmu-access-type.h"
 #include "exec/translation-block.h"
+#include "exec/vaddr.h"
 
 #if defined(CONFIG_TCG)
 #include "accel/tcg/getpc.h"
-- 
2.43.0


