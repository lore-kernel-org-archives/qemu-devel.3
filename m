Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E1DC19F4E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm61-00063c-Nj; Wed, 24 Apr 2024 19:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5s-00061e-Jg
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:32:04 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5r-00042Y-2W
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:32:04 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ac9e8e4e3dso397521a91.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001522; x=1714606322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AWaHIgupDRubCdZ+Pwkx9z9dob2E973TsdkTQhijD54=;
 b=DaVogUA251nlbszpDbc+At25B2SHHQUJlnsEqWXvchHtUE4eZx2az5AtzoOssFi8j8
 tCXpj71e0LOgCQ6DKPzJ8Xg9O674EAzrQIJl/drRiL3Cod8vKM32+mCTndfKuc/yt5jV
 qAhwNv6MXolKP8Z+Ez9bEZM/OmryRmOkeKkfR58B2UTkbvhv3M4eD0uoxund86HZgAbL
 aTiJ9WG1WLzajz0j6UdGOOMPHY0jcnFy80A3TUGjDIhm/+0rkXtNNzvx2hS1f1twfEDk
 t6knBo7N1cUqCitaJMl+3+8lJZnrRNWSOcvX2fTiXzXa4c8Ash25TEZJlkvQc19bWPF6
 3TtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001522; x=1714606322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AWaHIgupDRubCdZ+Pwkx9z9dob2E973TsdkTQhijD54=;
 b=ao+15Q4Qwp7jXqWeQTN5UQuyToWT0juEjQ3gaArdQPu/4YugdqA0AI8YY59fs/S9CA
 ibpYPrS9BwkIXmURSjOzhVOPCRUbbsDi4m0ZDalJTRc/2AnBKNoXQtQCA07e3AX5BqrC
 MEWlIeG5EoIFNAJECGLbWBZQFGyGEY7KSue5rAqJE4JJl79TmIYTQxvRmOX21p2rj73W
 UtNLejMxpsbh8qD/P5Y6krowICDfXtwHkg5i07i3jxqG2ieyu7nj95w/eYWuN8RtThWo
 kpMJPBX3KWJubT2xdcH4X0ehQHDJBaZxV35QVZ19ieFQu8sSykbD3AtMfkdxqSnR76Yo
 yPuw==
X-Gm-Message-State: AOJu0YwCOxMKBFHj+ZHsx/2ENjgl6cAIhr8MsPpbXghpCy0Z6cVGij7p
 MQM7i0kB3ISo7P9ddh6pFOyl3wEF7YkKJ/o8sOCiVfUmKjW5CPZeG96IKhNSDUwVwTzR9BWe2Pd
 o
X-Google-Smtp-Source: AGHT+IH/d5mlwc4hSG8NtORDwKS2oU9Gpmt/7SQXD9GJW3CyBBlUt/ysiPbbV1xoFmLzCnKkFgutTQ==
X-Received: by 2002:a17:90b:120e:b0:2a4:b831:5017 with SMTP id
 gl14-20020a17090b120e00b002a4b8315017mr2145820pjb.48.1714001521874; 
 Wed, 24 Apr 2024 16:32:01 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:32:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 33/33] accel/tcg: Remove cpu_ldsb_code / cpu_ldsw_code
Date: Wed, 24 Apr 2024 16:31:31 -0700
Message-Id: <20240424233131.988727-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Previous commits replaced them by translator_ld* calls.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240405131532.40913-1-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index eb8f3f0595..85ca104dc9 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -438,16 +438,6 @@ uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr);
 uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr);
 uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr);
 
-static inline int cpu_ldsb_code(CPUArchState *env, abi_ptr addr)
-{
-    return (int8_t)cpu_ldub_code(env, addr);
-}
-
-static inline int cpu_ldsw_code(CPUArchState *env, abi_ptr addr)
-{
-    return (int16_t)cpu_lduw_code(env, addr);
-}
-
 /**
  * tlb_vaddr_to_host:
  * @env: CPUArchState
-- 
2.34.1


