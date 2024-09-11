Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21792EE0206
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 16:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soQYQ-0001rm-DF; Wed, 11 Sep 2024 12:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYO-0001ql-VA
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:50:52 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYN-0003e3-Ed
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:50:52 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2068acc8b98so689655ad.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726073450; x=1726678250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tN0OHUrqQbUaQCGulY54+8M9t2g2sAjn/2PDGh46k0c=;
 b=BjXJFFVXtObTeoaICNCAfGZRbuej3dwe4qRcQlq8yXhxzdovKqYpIOF9cvOz4qb1bG
 l3eW3zaePxM/UWFykAmTlUvosw8xC91OUQbqRcDT6MamrVvpbUYxubqiUgLzcVx8Fp/b
 7ne+5Jv+ewTCoCpFrnpmB2OWBYHeP0RJcr/nuHbOhWLLImLSkJudKHYua+KdJXtPBTT8
 vPDYArtG/nRXdYCCmnCRIwQa4YcW7el/qUGwf7H6xAqeEvHE/iXyCYwam7zC4gmU/6Aa
 jJULOM7K3E+AAgAYck3WvTQozeQG2llDNT0Kze7sYRpzBOXPKUWzZsZDd/z5OATFomIG
 4iAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726073450; x=1726678250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tN0OHUrqQbUaQCGulY54+8M9t2g2sAjn/2PDGh46k0c=;
 b=QlwbvgBEdb5u7y7tksRFRMH9Ww2ZD/yHAdK1dqfHrircaGAWeEiB/TB7SdXzFxxya5
 VDwdF6BN4bEtR8oDNP8WMnuLavQhD+fy0ZUfn8Vz/HgsWd8fzE8ylrSAWmhORHiEjqQQ
 BKbVUuPICh6S280/5wQHIIvJbt2UOBJ3JReZLOAweZuGGbbrRHW5heXpTk77LU5L/5Er
 pTYPKaPElrIVq25WUFhnTTo0dIezXvVFLjHGPqGmvYu2+szDXcQIVh36m5YLBuKkqEdJ
 LN85Sq+GIDqmviJsqQ8eYTxMGbuDO0QHTtLA4Or/6d+7g90x6G9G+CRw2yoKKQ7XKNfw
 NiDw==
X-Gm-Message-State: AOJu0Yz2GsepcyHpdmHxzzCC2XxjKVS8pUfCBPjdGmXFdf7pINypxBmd
 n24CJ5bn7z4CLaHAulVj+0RKCVOrmeOV1Hgfw/opEsfYaB1GKQKk6D0GM9WWC6LoC+n9mDcoFCx
 U
X-Google-Smtp-Source: AGHT+IEsbGzzYMjBi2hO0WXV5b3+LlqaGEyckmk55oYnNNiom9m72bSztJceJJDMpI86ksyi4m7TPg==
X-Received: by 2002:a05:6a21:6f83:b0:1cf:47fd:50ba with SMTP id
 adf61e73a8af0-1cf5e17b1f8mr6059579637.37.1726073449911; 
 Wed, 11 Sep 2024 09:50:49 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe4e7esm3186947b3a.80.2024.09.11.09.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 09:50:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 philmd@linaro.org
Subject: [PATCH v2 01/18] tcg: Export vec_gen_6
Date: Wed, 11 Sep 2024 09:50:30 -0700
Message-ID: <20240911165047.1035764-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911165047.1035764-1-richard.henderson@linaro.org>
References: <20240911165047.1035764-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Add declaration to tcg-internal.h, making it available for
use from tcg backend vector expanders.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-internal.h | 2 ++
 tcg/tcg-op-vec.c   | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index d18f49f5d3..8099248076 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -102,5 +102,7 @@ TCGOp *tcg_gen_op6(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
 void vec_gen_2(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg);
 void vec_gen_3(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg);
 void vec_gen_4(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg, TCGArg);
+void vec_gen_6(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r,
+               TCGArg a, TCGArg b, TCGArg c, TCGArg d, TCGArg e);
 
 #endif /* TCG_INTERNAL_H */
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 84af210bc0..d4bb4aee74 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -172,8 +172,8 @@ void vec_gen_4(TCGOpcode opc, TCGType type, unsigned vece,
     op->args[3] = c;
 }
 
-static void vec_gen_6(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r,
-                      TCGArg a, TCGArg b, TCGArg c, TCGArg d, TCGArg e)
+void vec_gen_6(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r,
+               TCGArg a, TCGArg b, TCGArg c, TCGArg d, TCGArg e)
 {
     TCGOp *op = tcg_emit_op(opc, 6);
     TCGOP_VECL(op) = type - TCG_TYPE_V64;
-- 
2.43.0


