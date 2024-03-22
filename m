Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AB3C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjjL-0005dr-2u; Fri, 22 Mar 2024 14:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnjjG-0005d0-Nk
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:34:59 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnjjE-0004fz-Gk
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:34:57 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d109e82bd0so33153901fa.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711132494; x=1711737294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9x64EU4iGEbS+8KpTEV24E3/c6Oc+BBCoNTWdgJiQ1o=;
 b=YxFH83D+OmNMxT8CNGYkcw0cHXzYF36Nyy9nldcJJFuXcqg6dBbgn0QsvWf4i3jwHn
 f+zp6wQ4g7AYTBoEMGnIePBhmnSpTlHjOcUJDVkPHglQA4WrZW2pU8dJPRR0Et4akcvj
 sKh1OEeA0d+d6o+TkpTZX1vuahIJOu0kL1pFbUORGvbruQ8vJXAk3B7VK3HPlwiRYens
 BFfazeTZ8F4AHDCcdKx9EysYEHFVhdv/7K/7vUAWFiQ0xIKbSP5pPvWj8MF6nBEEcXKK
 f0p5TCeRPUc7YMt8boE5yYjGB6f4xXRXedPRZjsGOg3r/yjzDAfU84Red8H18IczA7lb
 RUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711132494; x=1711737294;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9x64EU4iGEbS+8KpTEV24E3/c6Oc+BBCoNTWdgJiQ1o=;
 b=N2KaoPHRHE+q8QFpnf0J9VdsuoOWNrJuhvJuGxyEH5t9iQp2rUUEsIoGhP/D4JGRuf
 2PDwzoirTCN3gDk0kDeORkQKpMLiTImf3G4kD8MU8O1tqAVcsFuGUTufFcy+C+Bu+zB7
 h24Gc34SvSc3Vlg6i+uS5/Qt/5fhlVrsjU1BCXu+8YGAXilYkkpG3plSkLmWHdyg/54y
 8+h92sfzc60xVqR5nXU/9bxydx+2/DSLKi/xW12QuAGFYHcDTAKNZOv+YIlmWajn/vsA
 c4cO5prhSuNBRXGRpc2STba9WrZYeiKfrDpoMp/sf3YxIQHEyWnXSbyagZBArDXXEhfv
 SfKw==
X-Gm-Message-State: AOJu0YyNX+fZlfaej/SLujOXdujWScCIwMFz3U5OthA50JJoIbVYU+si
 deZZgSeZSS3IWqsBURAPL4s+5BS9acI8J5jJEd0s80M2Y75HWeWYdJJBK7i5EQSs3UPkKcOVhdJ
 y
X-Google-Smtp-Source: AGHT+IEt412Rhq9+WijA/1jMUOLM65iSf11LyyGNCFqBhGuRJYEROSNgXx3DBHNuqoxhqWamn5UmdA==
X-Received: by 2002:a2e:b0f5:0:b0:2d6:8b90:4405 with SMTP id
 h21-20020a2eb0f5000000b002d68b904405mr275475ljl.31.1711132493879; 
 Fri, 22 Mar 2024 11:34:53 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.178.251])
 by smtp.gmail.com with ESMTPSA id
 iv16-20020a05600c549000b0041409cabb39sm244908wmb.18.2024.03.22.11.34.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 22 Mar 2024 11:34:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Nicholas Piggin <npiggin@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Anton Johansson <anjo@rev.ng>,
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1] target/ppc: Unify TYPE_POWERPC_CPU definition for
 32/64-bit
Date: Fri, 22 Mar 2024 19:34:50 +0100
Message-ID: <20240322183450.25284-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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

Apparently there is no wordsize special use with the QOM
TYPE_POWERPC_CPU typename. Unify 32 and 64-bit with a single
common definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu-qom.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index 8247fa2336..ed75f1b690 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -23,11 +23,7 @@
 #include "exec/gdbstub.h"
 #include "hw/core/cpu.h"
 
-#ifdef TARGET_PPC64
-#define TYPE_POWERPC_CPU "powerpc64-cpu"
-#else
 #define TYPE_POWERPC_CPU "powerpc-cpu"
-#endif
 
 OBJECT_DECLARE_CPU_TYPE(PowerPCCPU, PowerPCCPUClass, POWERPC_CPU)
 
-- 
2.41.0


