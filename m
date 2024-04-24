Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD27C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzg7b-00020h-2S; Wed, 24 Apr 2024 13:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzg7W-000200-Vs
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:09:24 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzg7V-0005Ng-Ec
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:09:22 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e9ffd3f96eso209325ad.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 10:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713978560; x=1714583360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qLklIJJZiY2n6UNAfojZ7eG/b6Y2VQ38WZLeXE8ZXgQ=;
 b=mExn48ViZ2PFjYG72WwmF0aC58p3mflSOWx9tejM4jSo3gkIk2WxIrotkRquP55dnR
 OOa68TV0o5DL6Dvti3s5NC41da8Nk8aVSpIQ0Ds2k/Gs26PDedRSlYrJcXb+GYuFVQxp
 MoXwpyDwDXtAIVLV82TvkyACPYtfoFSettxPNzvjxbjFeLxzF/UKjKaSwEi/dyyVg9fh
 ylHLkOqQsEAu9Yc3FNkJgD4anMspQmfOYHHPYtS9VrqRxM0Kgh6qtFVuR7eo5d6+PDGi
 HML2v53IEP9IABxJS7w0gGnSSqJL60LB1/cVESz2/aJLjfZ5LRR3ZtqprCY9SIar3pRx
 FRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713978560; x=1714583360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qLklIJJZiY2n6UNAfojZ7eG/b6Y2VQ38WZLeXE8ZXgQ=;
 b=mVTlSKLaAyGFPGQkzB0LvTt96UHFlivYfGWWG8nT7pl4Y/qNeUduSvo2ZGC5KIsiDW
 OEZqFIcSiA5tNfuYSLw3+kpUsvdO7YZVVP/1WUhsvj9D59K/33pQxOoBL0CcrPO8J3Y8
 J2eJWWbc5kYy7iuWUU5nVC9E6TLChpFuL7OsbA/gA+jr7NMBLdDy9NTXymS8aDcV41QO
 vliFU1YGFSPzBj5wAmX5aMbRi+5Gx8U0h0lWu0tFw8dpIUel7MeXMc1LxGSLUxmxV9qX
 P7axYRF1kRRdO5dobjzjM/sU6awhVorPnRrhRzqiRSgPMRxU9OGFLV1iJM32pmpfKaTX
 cXEA==
X-Gm-Message-State: AOJu0Yw9eogKry3r1CfyXCaq/RM74FpmnFVciQXBjGJI8Rs4pg7mx98m
 ic+ZYAxkUWtXmOW/waKzb0MD1Soy2vf1Uh6MXJHL7SZZ+Yusr8JSIUJCfIMhuKOa4klgWO8CLLL
 L
X-Google-Smtp-Source: AGHT+IHuY0kILNYu1JgmMm9Q25UC2bjl3zpvSNohWVpiYxz3vz2PBs4LAKg53gTAGGub2DfXyUHhdw==
X-Received: by 2002:a17:902:d2ce:b0:1e1:1791:3681 with SMTP id
 n14-20020a170902d2ce00b001e117913681mr4084590plc.61.1713978560055; 
 Wed, 24 Apr 2024 10:09:20 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 u8-20020a170902e80800b001e0b5d49fc7sm12215489plg.161.2024.04.24.10.09.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 10:09:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] accel/tcg: Introduce CF_BP_PAGE
Date: Wed, 24 Apr 2024 10:09:08 -0700
Message-Id: <20240424170908.759043-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424170908.759043-1-richard.henderson@linaro.org>
References: <20240424170908.759043-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Record the fact that we've found a breakpoint on the page
in which a TranslationBlock is running.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translation-block.h | 1 +
 accel/tcg/cpu-exec.c             | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index 48211c890a..a6d1af6e9b 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -77,6 +77,7 @@ struct TranslationBlock {
 #define CF_PARALLEL      0x00008000 /* Generate code for a parallel context */
 #define CF_NOIRQ         0x00010000 /* Generate an uninterruptible TB */
 #define CF_PCREL         0x00020000 /* Opcodes in TB are PC-relative */
+#define CF_BP_PAGE       0x00040000 /* Breakpoint present in code page */
 #define CF_CLUSTER_MASK  0xff000000 /* Top 8 bits are cluster ID */
 #define CF_CLUSTER_SHIFT 24
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 5c70748060..26bf968ff3 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -368,7 +368,7 @@ static bool check_for_breakpoints_slow(CPUState *cpu, vaddr pc,
      * breakpoints are removed.
      */
     if (match_page) {
-        *cflags = (*cflags & ~CF_COUNT_MASK) | CF_NO_GOTO_TB | 1;
+        *cflags = (*cflags & ~CF_COUNT_MASK) | CF_NO_GOTO_TB | CF_BP_PAGE | 1;
     }
     return false;
 }
-- 
2.34.1


