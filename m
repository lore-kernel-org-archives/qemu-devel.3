Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B86FAF99368
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqyF-00074k-Nk; Thu, 23 Apr 2026 06:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFqxn-0006nH-9I
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:07:15 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFqxk-0004Bv-Ns
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:07:14 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so79963035e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938831; x=1777543631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aD0+NtZ933JsUktAwjLuSvcDliO8muwbAGpMWz9LpqU=;
 b=mGfLM4sexU720ROemRJCRtph919pNf23q6LzOruhl9pwY9juqtrFFKBOnsi9b/IQmb
 PLsRCmT2KHutwTLArBdsNgqjGEobZQY/GSGDsOQCooSlkekc9FA7ZR1xee0/XNBZZGsA
 cKgDo0SGdO9+gFYBZa3NCJ4KI0cwvaEHDYgij6mFEq7BYe4XCzut5J0kUDIY6kokg7xs
 z4i7kdzdnjxoYs8ewJTbsRFsNXpi/XLBBU+dqgs4UDSLECVzccpmFMCfp2wH1TejmDke
 CVN56nBoLYI121pdeCCmWAwKwlZb2tBkdyl4gIw6hqHPeN4m5bWzn9JqneynsYqk2b8T
 x+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938831; x=1777543631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aD0+NtZ933JsUktAwjLuSvcDliO8muwbAGpMWz9LpqU=;
 b=bTJgkcdWfVinWGenFoqGO9yh9Fd0r8jnJ21zU0po/jan4zUx0y+rmqPr8bEDHBsmZW
 i97lQG3JQBfBoa3pbq5tsMuc3bsBGVIWnU+1lEEwFq12BAIYQZwdAg7y1qz3vLTNRtCP
 UQXru/z0vb5gw4+hSkemR6qymI4lf9IvPWMgNEFeUGfOw1kJzRfwiobv5Tf86D9L+dal
 rkfpnyOm0pX7LNVxDhHKXoXQggb9C9UgZvbkUPR6C/QPrqprTWPx1cQLixGcYbQVYW6t
 GpmyJ4vs/KgUSQtVzJtgA3fAYdfWDerNO95C57G4L8S/nyVcPJ84rH8XLpsA+sPpfcEj
 OyBg==
X-Gm-Message-State: AOJu0Yw+wb1IponO9rCqHDFeDJXSRromISzM58YdBJtaUDOBWwZqMqzq
 qs2s1+ixp4ttjtPTDXYzvmGkIqEuVUkIPab1HFfXO++9V52iRAK+Qn1bMYSa4V8yhtFYYGgPFhE
 xJ45LTTM=
X-Gm-Gg: AeBDies17LsYDXDI2BQQg1TbfyiyrmehTjxVI+ZFV7CZUFspSJJ1Zurk7dvhKP4LmCQ
 qRMVHP5RsH7Az/MlREHRulDKGK8/GYBC9TpV8XdzOBMsXkZOvU+sk5prP6Rc/WzkqBdGAF6RPyh
 /V0Omzue28sm6b0HXckEBAiDKzAuIBUaybynSGV7l4DfeyMh5q9y0nVZRMJxAsVWWo5bf5wpQZQ
 TUcgioyYOSp2qOp3aS7AcKADZmjTrrmp8TZ2tNldOrp70yyjdhBZ48YGFZ5kOSahZ+rH7ghiz45
 BznG08TTHVFRo6DJoMFW8zXnI5woHgXC+nLerbrk/6bx/7MU2PVFw7CgRvJ0rxynbbsz3vVgMCM
 Gk78GbWu0R7EmVisQbioQxDTP1BmuWQrLmX7d04YgNMNC4awUmyrf9HWE+QvKETHQOKbdcZQg3t
 fepCjwYyK0yIO2h53Aai4j1ulg4epgljdv5qB7cSOvuqlAe1JkktAFCD7uJMeuGRhf8IbkAL9N2
 3QV64xBScQ=
X-Received: by 2002:a05:600c:c0d5:b0:488:c683:be89 with SMTP id
 5b1f17b1804b1-488fb74dffemr291483175e9.9.1776938830716; 
 Thu, 23 Apr 2026 03:07:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4896c2a1804sm131569135e9.4.2026.04.23.03.07.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 03:07:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 8/9] target/microblaze: Include missing cpu-mmu-index.h header
 in translate.c
Date: Thu, 23 Apr 2026 12:06:11 +0200
Message-ID: <20260423100612.27278-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423100612.27278-1-philmd@linaro.org>
References: <20260423100612.27278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

translate.c calls cpu_mmu_index(), itself defined in
"accel/tcg/cpu-mmu-index.h". This header is pulled in
indirectly via "accel/tcg/cpu-ldst.h", but since we'll
remove the latter in the next commit, make the inclusion
explicit, otherwise we'd get:

  ../target/microblaze/translate.c:1620:21: error: call to undeclared function 'cpu_mmu_index'
   1620 |     dc->mem_index = cpu_mmu_index(cs, false);
        |                     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index af6a30b7760..6321b739ab4 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "tcg/tcg-op.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
-- 
2.53.0


