Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5185CD1296
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 23:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsWAW-00028a-7e; Thu, 04 Apr 2024 19:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWAS-00027b-2z
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:48 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWAN-0007pC-6h
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:44 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2a2c9903ef0so1149382a91.3
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 16:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712272002; x=1712876802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cdYcjDwLN/xr8PQzvEnfgv6lYJ6ezf5kr9JF5Mk0QDo=;
 b=fiaYcA4whMgC7FL8KEWtoPUAF4N34MaHkmu4FYmMjaSKwnJL6s6MgwbLZbTL4AYHb5
 MwLzbSwVSOxPGJmbIXDXo3uIqJD5CAA8fYF6z38O87MmTYey3J6fOeLw3rJRNKVsprlV
 16tUCJHjpRzEGGL9b3XyhxVNv8JCrsBIlg6MmdkTuPfyElGAH1kTnKSEyCBuv3zOCGh/
 E/Za0fCe6ZP8yu4MuYxRlpyVzeuaTwQ4hh6hqFiPrDcIbuylWNV7RrDdXXW0n6wLV1UV
 2/t8fNWXjv3z3RHSB0RMdL5VWK2fsXYrY1tetTqfvmcamUUpTsM0rCvExd5KOWuY+Ma1
 sdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712272002; x=1712876802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cdYcjDwLN/xr8PQzvEnfgv6lYJ6ezf5kr9JF5Mk0QDo=;
 b=s/DvDjbLJvav5CL8ozqoI4jOC093cGSP24kJIDWPp5vF61drNJFymuisiLNjoXOdi2
 MjVCw7hVT8pF3GK1Utsitly36xWSCN0KuZ1agS/k/bYd1eDbez/yFFqL+yWeIjx9XoK8
 XuzOd/Sam0otDhb/J2C3nQYIH8ZVJF426ogbF8xq2iEQetoqSm1YaAZHfm2y/4JX9zER
 6b8/ccspU4LluTWjV62Z3Jt1Lo/UjqXoLC5KWEs+5NPieDlYMIUFj5uQMf8uWi7JT6sq
 1M7Qe0wpeDV9IQ5mA3j+EQUHpKXph6Pqf77Ed98kyyQ2Z0/HKznF84yunl0FLSuphG6E
 WezQ==
X-Gm-Message-State: AOJu0YymVrk7phiiGSpC9VJjWJf3ntFQsy2HUOAXXFDnWoA5rR15+KHA
 XCY5V1gStD22WVRPFacaKi0J3eb8gzXB7cCsHV+14q3UfYpFZhK2p5C9bcDcK6PxsoA6Av0Hzas
 t
X-Google-Smtp-Source: AGHT+IHWiGp8/WcrXazbl7SYxrPNHSC8bzy537ihdQi24cUNQyJDGG8smImIQ3fgcUY397KuOD30eA==
X-Received: by 2002:a17:90b:4ac1:b0:29b:22d2:9dd5 with SMTP id
 mh1-20020a17090b4ac100b0029b22d29dd5mr1145312pjb.38.1712272001890; 
 Thu, 04 Apr 2024 16:06:41 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 q36-20020a17090a17a700b002a2f3cfc92asm1052592pja.16.2024.04.04.16.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 16:06:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 21/21] plugins: Update the documentation block for
 plugin-gen.c
Date: Thu,  4 Apr 2024 13:06:11 -1000
Message-Id: <20240404230611.21231-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404230611.21231-1-richard.henderson@linaro.org>
References: <20240404230611.21231-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-gen.c | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index d914d64de0..3db74ae9bf 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -14,33 +14,10 @@
  * Injecting the desired instrumentation could be done with a second
  * translation pass that combined the instrumentation requests, but that
  * would be ugly and inefficient since we would decode the guest code twice.
- * Instead, during TB translation we add "empty" instrumentation calls for all
- * possible instrumentation events, and then once we collect the instrumentation
- * requests from plugins, we either "fill in" those empty events or remove them
- * if they have no requests.
- *
- * When "filling in" an event we first copy the empty callback's TCG ops. This
- * might seem unnecessary, but it is done to support an arbitrary number
- * of callbacks per event. Take for example a regular instruction callback.
- * We first generate a callback to an empty helper function. Then, if two
- * plugins register one callback each for this instruction, we make two copies
- * of the TCG ops generated for the empty callback, substituting the function
- * pointer that points to the empty helper function with the plugins' desired
- * callback functions. After that we remove the empty callback's ops.
- *
- * Note that the location in TCGOp.args[] of the pointer to a helper function
- * varies across different guest and host architectures. Instead of duplicating
- * the logic that figures this out, we rely on the fact that the empty
- * callbacks point to empty functions that are unique pointers in the program.
- * Thus, to find the right location we just have to look for a match in
- * TCGOp.args[]. This is the main reason why we first copy an empty callback's
- * TCG ops and then fill them in; regardless of whether we have one or many
- * callbacks for that event, the logic to add all of them is the same.
- *
- * When generating more than one callback per event, we make a small
- * optimization to avoid generating redundant operations. For instance, for the
- * second and all subsequent callbacks of an event, we do not need to reload the
- * CPU's index into a TCG temp, since the first callback did it already.
+ * Instead, during TB translation we add "plugin_cb" marker opcodes
+ * for all possible instrumentation events, and then once we collect the
+ * instrumentation requests from plugins, we generate code for those markers
+ * or remove them if they have no requests.
  */
 #include "qemu/osdep.h"
 #include "qemu/plugin.h"
-- 
2.34.1


