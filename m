Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C5BCD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsgmB-0007Qw-Gd; Fri, 05 Apr 2024 06:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglW-0006CM-4X
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:47 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglU-0004qP-MJ
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:45 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5a496fde460so1104631eaf.1
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312743; x=1712917543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ccORN4xD1pLxRilHuoEKBsPpuJK8Au1e6hYDpToIDUc=;
 b=uwBF/IKh/Rs10jYrln7eNjcS/wTgj91Jh5Q9PYdME45x5AdINmPNdun+nQnPISroG+
 9A62s+8J2hJGmaQl0ZmxNHMSLaewWcMZimi8wNALLmI3M6YDzyk7vA/udZtdIkcfOC6D
 btlsLxxlSEIFjgKd3y0tXAjkaO3Hh8JRNSdSjYdbRuV370GQv0AQuetTndMSO/HUDD59
 MS9CiBrsCzaW2OXo/00RNIUmb2rzrZFIz7yjLhfX7lbbNNqM4Ei2hSo68ZXa6U9s5p03
 3ewidd/TAJXqnCmth0TP1gWf2jj//OHFY3jOF6enoT9idHzPNvhFuUmmAftLTzjetpPO
 lH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312743; x=1712917543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ccORN4xD1pLxRilHuoEKBsPpuJK8Au1e6hYDpToIDUc=;
 b=fg3HZdJIgjbjscYy6FUNY3gnHKHP1A/TA7RHNV0RaBmlFjkRpiP+MURp37baas2wzD
 sQRniZRWdPa28xdmQR8m4elGCwEnjBdDzv/gc+FHqyvGn3rdzs+D6WAI5T8qOPiD/2uJ
 EY3c4LLXUrpf5pAyc2hqvsdSvkoQMJ2OKoxC6X6nMzQSowdPGW0S9mcNb128jztOwKN+
 mAlopsMH4VJduEn/mM51r/ZS6Q06Jym7lIRlTVgm2P5j3ZSJxH2Bz/bii+rUEy4BsfYf
 wEdGxEGCYH/aodnEgkaQ6nEHegKD/Zdo8llSv9Uvt3kaVxOxGq/qg6S9aQJP5vubRtD2
 FSUQ==
X-Gm-Message-State: AOJu0YxII86oJuKmIn9q3SatBF/hiOpC4Bnd6U6S6mfawxYGpjxBVAFC
 bFqCj/3s/yDMC0Oc7Z9HToKpxaQfVRBBRWSUnybZnXkkf6d+VR3lcljw6hfx7WJZOsS+7ZvOB0v
 7
X-Google-Smtp-Source: AGHT+IEIDv/Y1gMY9lk2jkQdKJN+vkooFamDsCWzJgwCx6bvTxwY9fOFzKUoqBJjGeoeXZKFhQm5tA==
X-Received: by 2002:a05:6358:ed18:b0:183:5c59:6455 with SMTP id
 hy24-20020a056358ed1800b001835c596455mr1256537rwb.0.1712312743415; 
 Fri, 05 Apr 2024 03:25:43 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PATCH 32/32] target/s390x: Use translator_lduw in get_next_pc
Date: Fri,  5 Apr 2024 00:24:59 -1000
Message-Id: <20240405102459.462551-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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

Cc: qemu-s390x@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index fed326b136..aaf0e0c335 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -36,7 +36,6 @@
 #include "tcg/tcg-op-gvec.h"
 #include "qemu/log.h"
 #include "qemu/host-utils.h"
-#include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
 
@@ -6473,7 +6472,7 @@ static void s390x_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 static target_ulong get_next_pc(CPUS390XState *env, DisasContext *s,
                                 uint64_t pc)
 {
-    uint64_t insn = cpu_lduw_code(env, pc);
+    uint64_t insn = translator_lduw(env, &s->base, pc);
 
     return pc + get_ilen((insn >> 8) & 0xff);
 }
-- 
2.34.1


