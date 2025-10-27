Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E221CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDL9n-0006iT-Df; Mon, 27 Oct 2025 07:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL9d-0006YL-Rm
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:12:49 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL9D-0007dr-Au
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:12:49 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b6d78062424so843554466b.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761563538; x=1762168338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GGapUoTaewrM/kono1/xvH1foLM0vdOPsMqSeCNHNKo=;
 b=TPCnbBCw+kIl9OKanfgeySBuGrIOk05JF4J9dLOG/QEUv8A+CAsGD0YyXOR324ou7j
 ArSgi0Qfq6kAQxmzjZshsuZdkjTPg1PvKabFsqvA5Ie4k2UST/wu4tcz6BQF5hppWDfE
 iTx3r+h0rGIrFY0Bwip8YymWXy4JRKLfzlYJl6KOB7tLQq58FkNzM6mluwQpjjiedBKA
 77TtnMJArEO6degYPA7P3MrYpEUsLurHWtwaHMGYfFqvEPOvq8+i8oUDsx+/dBkn9mdJ
 UeO3PjYjW/l6mXbG/YSnnzQn9gvIas//U+iNrhX0R75kUBWhYKoTxXEXtjxbTehV10Bj
 r1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761563538; x=1762168338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GGapUoTaewrM/kono1/xvH1foLM0vdOPsMqSeCNHNKo=;
 b=ZAm33+wbYqcvRLylCCoOP27Oqp7WqQ9UIeTs3GJWtzLJ1jehOC/y+HFHTSpNtMQk48
 baRLTWon2Hg24ANcI++2jFq9Hr+1dtVlcOy/oCnMljxghECh+AIMqAdMct+Xe+Ur1e5g
 IYQ5/1A07fevg3zjiOuk9LzJjjRRXTR7yjrQtXjwHFWr05fa5B4/VlTDTxlx10H/fQxC
 wo1Q61JNlJ59zwIppST9iRmmFAyC28mlLafDBQOk5TcoO/UFFyL1k5cAlRHynPbz0oTF
 vlM5yzvqJCk5aPyLLHMboFpEvt9RLPSdF3FopOOdsF5TNDAuc1juC1Dm+wDpKS40eBlh
 dK8w==
X-Gm-Message-State: AOJu0Yx32K/jhI75v7F2HHUSBamPbgkwtxaBcZCcQpfA/ENtWWgCuwXT
 H/hFHWkoDyrK2pZBWBZVOdPb8WI+y2HSoSIFx0DGKaAKWVbxCO2kEertsQZZJq7EpeY=
X-Gm-Gg: ASbGncvLqagBcO6q6IXdLb2Il/YsCYgbehoypQBj/GRP4DDSJPU2Ba/1vjTWvcFl7Ay
 +bM9pQSy1AqpTyB6MHetQ/zk/BuVsbIb5Gp84Sk9Y5AdpR5LeWdWdypC66HcEpNAaF5WLEZIkuV
 5fxozG5cGiHdVWKKnzZQ0apHOT+fWF6G/UdT6pkGads/RZ94gDeMOno9Fuzq5OYW28emstHYDev
 0ZyTf4PPIRKZQOhn3a6AYxxMCIX1SX1mN8Mf6rNmyCffCR93I3Jv+P92LrbFGWg6qEkxUTuZjXg
 3XJDeGdV6/kafrZxcO+vFIsjkwmTTBu60rOg2YdcR5p+4oHm2yYrT96HsHWU5evMCZet1FM6rgX
 51dRNL0rGRJLNymbquHv1Ta3acfLKOQS1NEwDBw7nmU/MwfRiQIztrVmMwR/1xlH8AMEO20VuTP
 sWIQpK109/oOA=
X-Google-Smtp-Source: AGHT+IGtBMpHIebheyONrWsxP0glj3ZoIlLecwrjIGlCGS2qBmkZj9gRmSWXNpNrJHhHYenJu4IrlA==
X-Received: by 2002:a17:907:1b0c:b0:b6d:2f32:844a with SMTP id
 a640c23a62f3a-b6d2f328766mr2021446366b.22.1761563537679; 
 Mon, 27 Oct 2025 04:12:17 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6db2b010d9sm87578966b.43.2025.10.27.04.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:12:12 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A2BCA5F909;
 Mon, 27 Oct 2025 11:03:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Song Gao <gaosong@loongson.cn>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Julian Ganz <neither@nut.email>
Subject: [PATCH 27/35] target/tricore: call plugin trap callbacks
Date: Mon, 27 Oct 2025 11:03:34 +0000
Message-ID: <20251027110344.2289945-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027110344.2289945-1-alex.bennee@linaro.org>
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

From: Julian Ganz <neither@nut.email>

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places an exception hook for TriCore targets. Interrupts are
not implemented for this target and it has no host calls.

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/tricore/op_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 610f148a237..2c8281a67e0 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -19,6 +19,7 @@
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "qemu/plugin.h"
 #include <zlib.h> /* for crc32 */
 
 
@@ -29,8 +30,11 @@ void raise_exception_sync_internal(CPUTriCoreState *env, uint32_t class, int tin
                                    uintptr_t pc, uint32_t fcd_pc)
 {
     CPUState *cs = env_cpu(env);
+    uint64_t last_pc;
+
     /* in case we come from a helper-call we need to restore the PC */
     cpu_restore_state(cs, pc);
+    last_pc = env->PC;
 
     /* Tin is loaded into d[15] */
     env->gpr_d[15] = tin;
@@ -90,6 +94,7 @@ void raise_exception_sync_internal(CPUTriCoreState *env, uint32_t class, int tin
     /* Update PC using the trap vector table */
     env->PC = env->BTV | (class << 5);
 
+    qemu_plugin_vcpu_exception_cb(cs, last_pc);
     cpu_loop_exit(cs);
 }
 
-- 
2.47.3


