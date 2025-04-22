Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BD7C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JO5-0003MC-V2; Tue, 22 Apr 2025 15:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLp-00010I-62
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:13 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLl-0006fS-Pf
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:12 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22409077c06so78042095ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350328; x=1745955128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KE33KBayr4dnRr7Xrs3VkN2rsoJvmDMI/IpM1PhpEq8=;
 b=Vv86iRyEEpElgb1j8QcFjS54Uup+H1RGpfGbONKivSrKbcXjQue/RYLQF5yDRQOZCU
 xVlhMU/Fx2ZO4rbgn1joc1jSok5zA3ohHbHPz+AtYaW33O16Nxt2yoXG6vzSaUom4LFD
 ur5YJtcVpglqiA3RRT8IgQkhqUEYJu4DdYYzvcSHHGpAwW1p/xBJWoSsXPWEjgA/lrR7
 lF7yKCZnYifzAhohe0eFEGHXcEeydIHhcqWs/l1K9RHcqt6IxR410xRF2klqCVeTVEwF
 zDh+/2HKe7kGlI+9mu1hnkGaCvnAsw2hTqsKj26vtR9rZ5zeZH3AEyYrOG3oJzMF1vJm
 EauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350328; x=1745955128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KE33KBayr4dnRr7Xrs3VkN2rsoJvmDMI/IpM1PhpEq8=;
 b=QtQiiFjdLtR4+yJnU2kqtLufkmcrYxcVsboICsCzbpxRCm/mnMLXAg/W+6M3ceDogr
 7bLGu3b+dFldHgJ3EGlzsQVl8pj3fNygVUgmTtpl9smKRF186xoSWBMP++Ijm8IAnL3T
 6JzbJx9xb62jl1dFuZu6qdsYZtn8ODNa4Z696JJtYz218fNyRTEEsCrAUvPF71pjUP2I
 BTyy85Xh88m+J5Aw4E5Fj9hZhOCWzMAwek0emheDLjSmBBD6zxZyfwL2M8m816mSADN7
 J6NzA8Ql/IJcPBrkxZAfTd70k0Yv5/vC8OKHkUNxFFI5k4E5V8XehT9AW41mcwkQmGv/
 zM4w==
X-Gm-Message-State: AOJu0YzsthOijIlY6/llARTp4TMSoRmP1bOgMUxeU4QBcJtz7Sg22OGK
 qXmrX/FcvFXH/dVOtUfp2G5fKrT642sg/KpsklOLH9crUA78+spgrWvzFHPeY36bX2Uj9xJ4WZb
 Q
X-Gm-Gg: ASbGnctA3bOOxscJY+9Ojlf0By4QmXEdh30G+yzkuVP20zccln4gv5qWxNw7z3xI/pk
 g8dUtCIOeHTjBVua+DJsWg1ejEHgnBezmd3z29B6jbbvywE8man/LCHQpZpY7c4LlY2/NDPomUn
 NeO3VagNQit+CZqzJ8STc4xyE9JMZ8DGlRyfDN41lkB2waVi1qIRgXe7bREaVHjEX4NCCEV2Zdd
 9sNU237RuwvpL3hBpBpWJ47NfY9AuGt1UHPn5hHEoGtgw6m9JV3O1s5hjsaQsIuIz1Wm/9BfW1k
 F5LatXbOeWIrBOjFY1ZX0yEAxTaqXJHueBg9gq74UsI9GqMZDf9SBFq1KNVC3/zRmiyzNbL2vO0
 =
X-Google-Smtp-Source: AGHT+IFeFiI6+ksHq5yFSBGyRmRjKuBP4m9BKYK6WYqm/iC3564b8uc1QgjGGv1bPxnWlX08XQOvIA==
X-Received: by 2002:a17:903:40cc:b0:223:5c33:56b4 with SMTP id
 d9443c01a7336-22c53583807mr215608565ad.20.1745350327964; 
 Tue, 22 Apr 2025 12:32:07 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:32:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 072/147] hw/core/cpu: Update CPUClass::mmu_index docstring
Date: Tue, 22 Apr 2025 12:27:01 -0700
Message-ID: <20250422192819.302784-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Since commits 32a8ea12fab..90b7022e698 (target: "Split out
TARGET_env_mmu_index"), target's memory_rw_debug() callbacks
use the target's TARGET_env_mmu_index(), not the generic
CPUClass::mmu_index() callback. Update the documentation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-2-philmd@linaro.org>
---
 include/hw/core/cpu.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 6dcee5d0ba..29f6419050 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -104,8 +104,7 @@ struct SysemuCPUOps;
  *                 instantiatable CPU type.
  * @parse_features: Callback to parse command line arguments.
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
- * @mmu_index: Callback for choosing softmmu mmu index;
- *       may be used internally by memory_rw_debug without TCG.
+ * @mmu_index: Callback for choosing softmmu mmu index.
  * @memory_rw_debug: Callback for GDB memory access.
  * @dump_state: Callback for dumping state.
  * @query_cpu_fast:
-- 
2.43.0


