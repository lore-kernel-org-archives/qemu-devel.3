Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA37DC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ku5-0006Tz-LG; Wed, 23 Apr 2025 20:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktM-0005dM-If
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:41 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktK-00054B-Ap
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:40 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so371053b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456196; x=1746060996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V36uY+E2YpMl5Y6J3G48zQLEZwrQ3yY8b7UF9x5stjE=;
 b=JLXhnD8Os5V9Puh3SsCig2FBdA02ShwrTSbOtOwydvYiOQj3kA8p6uekPKQbAMLG/U
 phJHq6I3+dRQAvZpdmtC8iPs51EJXU3mWxU7cQ3o5FLVkUAKRPCDfwpZZJWhIjNu374+
 jYG1v9xyH08g4Bg5gs/ycJV0v7BL/3SwvPgRZelUQoJCzXGUy/ubpEafmbLwU26dBmld
 UYCEnzLxlqaiud3BHXFkjSNzC8bdStBP54d7Y1FDawfTHlWevymg3Zy/t4vUBkXkzl1h
 9C+6+0ekK5w0PZuE1pfF/MVcXaNwPEe3LyP6bKp1lWCIV1CwHLyoJS7t6RGHMtJNZQWC
 k78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456196; x=1746060996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V36uY+E2YpMl5Y6J3G48zQLEZwrQ3yY8b7UF9x5stjE=;
 b=DYkPx9oTdb2gevsxxnkkAApOB1943VfUTfcliU6P8i5Xa8mfVet0QQ+LfhafB7IAGa
 8reAvyuYAJgoFjSN2isggtH4uuqTMOQbayLXfzpimMCKAz66/ZBwQFxTQN4v+HSQlWIh
 iMLUTr6bZsyF3RuiwVWwbCP+DfnOymhIiH1YNJuDgzS7GgR+psA/JMybJkzp9xc8rA/W
 fqfvtAbotLnKgJGDEHdz3RG+d0Esi4As/H6yRhCc3m9lVU3accixyXLPMcpjUlQhE/lO
 YN4h0DtMmAcYwqW/jH9YlOxCnyztvSn+Qj9nezUZAFCnt1TSe5V0HAFd8v3ewGrLwB9+
 uc5A==
X-Gm-Message-State: AOJu0Yyg/0pr1qazTBH8/+nY7tz35a6KoZ+OHPIudyLrBEAMXmcwo7qP
 6JxRXs8l51wEhBsC62LIOwvsEhYQdDUvMb6mMlRYs8JWIqsY1ObzXSDS/WaUDJaqNOdRouVNWPY
 N
X-Gm-Gg: ASbGnctdZFeeE6SVhnwE1XXFQjVGGL7BjaLEXCRCCnvpx06PIShbrBr0P55NkawccoS
 +kvoCGPeDXwBqmFJh0MohJxI+ZLUTVmVXatuqMaq2l2VT+N3VI8FRDrCTLWSDVYMQ8f8AYRjoKw
 FtFXYNb9aJ1w9To7bYlxV1hV9cunv4XXujdilx8MsqM24zeJHDCL4GiM/lsTvV7TtcfE8RWdJ1C
 Og7TaPn6rXXcQWSFazdLJ1or4nyh9SSZauj4l7qz6U83OjPui4fjGPtQp92kqRlvOO5FTQ55iVK
 QSV3Y4ctlqFk3R2whj4sdpwMjVPvyqasWaS5Wl4fPTitvhzH8lvtZDCrvGyGxyW1xU5x+9un9lI
 =
X-Google-Smtp-Source: AGHT+IGgVC99VEXwJmYoQWHsV0+uOJYFcHEXhQQ644I6bAmM8sNlgjTHkwZpsJMtKndHGrPhnJdbTA==
X-Received: by 2002:a05:6a20:9f8b:b0:1f5:51d5:9ef3 with SMTP id
 adf61e73a8af0-20444f09a27mr915259637.20.1745456196579; 
 Wed, 23 Apr 2025 17:56:36 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 083/148] target/microblaze: Restrict SoftMMU mmu_index() to TCG
Date: Wed, 23 Apr 2025 17:48:28 -0700
Message-ID: <20250424004934.598783-84-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-13-philmd@linaro.org>
---
 target/microblaze/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index f3bebea856..88baeb6807 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -431,6 +431,7 @@ static const TCGCPUOps mb_tcg_ops = {
     .translate_code = mb_translate_code,
     .synchronize_from_tb = mb_cpu_synchronize_from_tb,
     .restore_state_to_opc = mb_restore_state_to_opc,
+    .mmu_index = mb_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = mb_cpu_tlb_fill,
@@ -455,7 +456,6 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = mb_cpu_class_by_name;
-    cc->mmu_index = mb_cpu_mmu_index;
     cc->dump_state = mb_cpu_dump_state;
     cc->set_pc = mb_cpu_set_pc;
     cc->get_pc = mb_cpu_get_pc;
-- 
2.43.0


