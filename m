Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D819C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 18:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxA1r-0008Fc-Mv; Wed, 17 Apr 2024 14:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA1k-0007x6-RO
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:29:01 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA1h-0003O4-Id
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:29:00 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-343c2f5b50fso4284247f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 11:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713378535; x=1713983335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E03TQ0GvhSAU3PvcwPGXVXyQZvjAqNweStAhT2Ncf1c=;
 b=JQ/NRJMt1Vn60L8+lh7elzkyOF784pD/goOS0QjxO+lEPxMsiallW1zC368ZuBL0t5
 7GSYuAZHIyeLjcHJyrQmkgmAqzynD+OUsANYNJ+2TTt4ScK3MmuzuqWnf/t8EB5WnV9i
 L6Wp2vLBYFY2G2zTqcuYyAc/OjIdVDpbpQjgdl3sN/ZNmrEDEvnNVAy/3uiByDLVY8DJ
 VdVJ1Dp0OoooYn4NQUXzJH+1REVfOivLz9zj/CnqUpj7EkeNF6yITvYGoAJLFKKsKu8G
 aPu/uH5B+XsZRs4dfPFeJRfw2kyeJfxe42kszf4XwsWpsgGn53qdOWM8iFNFTLOgiPli
 Gj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713378535; x=1713983335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E03TQ0GvhSAU3PvcwPGXVXyQZvjAqNweStAhT2Ncf1c=;
 b=pEx9TjrenEeXXMP4cuIG6EHsIgKEVzx1t5ayuduLDuwFA8iWHp3nGySZIgE4/n7TXq
 LyXM1kFoIVIWyDWhJOCUYN3A+0gXeJB/jXNlNoODowapmXOjKxfjDAn3hWisYm4weKs+
 sebjQLSbfdNaCa1ucRyPKh9KrrgdRF7rnU1f2i5I+PfwxvFLkIBNjP8ZSv6RS5QKjfFQ
 8YA9TGuZTQc0aKH/abhVaM1Hs4SGJv0y4rsous6Oh9KCGetYYzdEQFNZAlS5gQAgQ+gx
 1Mb2CxoKtLjxPTH5ihUMeuewY2GplqjpAJIYSO+Y28gEMO4NOCt4hGWsVv6t6Gty5pkC
 pFFQ==
X-Gm-Message-State: AOJu0YyG9LzT/LSbwQGdPemK8IHmRpxNzL3c0A8XDB5ATLhX6bBsaAVF
 +4LKpxS0n2dJfV0NXhtTaQznwDlYD2ivjaehQK9sUOGwBH0P4U5T87m/LHg1lkrVd74Jqk44xgu
 s
X-Google-Smtp-Source: AGHT+IHQT5JABvlpfstGQxICNpYddTBTYsS9dZ9iGC+h6RZKGXZArF1Omn5GFmdpW+M+DOEg5uEEyw==
X-Received: by 2002:adf:f943:0:b0:349:bd11:1bea with SMTP id
 q3-20020adff943000000b00349bd111beamr97629wrr.11.1713378535418; 
 Wed, 17 Apr 2024 11:28:55 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.201.23])
 by smtp.gmail.com with ESMTPSA id
 k9-20020adff289000000b0033e45930f35sm18185709wro.6.2024.04.17.11.28.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Apr 2024 11:28:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>
Subject: [PATCH 08/21] gdbstub: Include missing 'hw/core/cpu.h' header
Date: Wed, 17 Apr 2024 20:27:53 +0200
Message-ID: <20240417182806.69446-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240417182806.69446-1-philmd@linaro.org>
References: <20240417182806.69446-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Functions such gdb_get_cpu_pid() dereference CPUState so
require the structure declaration from "hw/core/cpu.h":

  static uint32_t gdb_get_cpu_pid(CPUState *cpu)
  {
    ...
    return cpu->cluster_index + 1;
  }

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20231211212003.21686-15-philmd@linaro.org>
---
 gdbstub/gdbstub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 9c23d44baf..9c2b8b5d0a 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -37,6 +37,7 @@
 #include "hw/cpu/cluster.h"
 #include "hw/boards.h"
 #endif
+#include "hw/core/cpu.h"
 
 #include "sysemu/hw_accel.h"
 #include "sysemu/runstate.h"
-- 
2.41.0


