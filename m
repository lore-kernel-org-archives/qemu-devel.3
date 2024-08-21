Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9197C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 02:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgb36-00014I-6g; Tue, 20 Aug 2024 22:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgb33-0000vn-Uc
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 22:26:09 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgb31-0006F5-IQ
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 22:26:09 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2703e8d3f7bso2178596fac.2
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 19:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724207166; x=1724811966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w37pH7YuBGYOWjqIybzdzbU05nLwB6boAQ2yePJtIGM=;
 b=FgPjS0elR7adqfmFvdyCELWKXa10VB0afTjv/lBhF0120+G/hspjcrfLh7YYxIQ5qz
 Pnqm/EOHFR4RCD/Wj7CeVnAqgelhVsXeUEL86U/5kFhuLaaXUuhkIrrJVwGRVoDXc58V
 NkD/E03gLcn72QqBpVpE4o4EV/sYOAsrQWOsbMAx8ZXvEqOMP3oNvpfay51hGsBPE7Pp
 AekjuQsGoBHl/3nA6K3oUCYkmETtP7XxWI++ZUmihxXVmC2QnTwsBF3LKCjE49lzYRP6
 9d1xP5FH9c54k2xy3ZbVeL3V5yA4LWysHXNYaPzB0gEhMejzbfAFhvniGEQRzkxKGLQX
 VTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724207166; x=1724811966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w37pH7YuBGYOWjqIybzdzbU05nLwB6boAQ2yePJtIGM=;
 b=AfLvile5NeGhPmNNyKk4mpVOaOssMfFUhjUWPnSilHIMJdir4mnegqLhIRWBtO+dZH
 HqyuAPrd4P2JgiZByiZB1FbBYFd6N5izj0Hm+eBpmFbiu88bzH2Z5YuAw9UkdKH3mg+Y
 k1UxWVQDWDNrExDsv28ronNxGZLit+InCKh7he3bt2HRu44RI4/Xu3KQuxApZDiCjYcM
 tj2sMm53TmWYsEHQncFwXm7a/0xBgINGsU45tgzGY8qdlOangxpykriL8+fPtnj9gPoE
 e9ZAC0MLoAyCYYBqfOw2+K+iWfM7PytSx4EwDsLLpt8TN2rJODGza8YWeHgUWUuPzEGB
 fuyw==
X-Gm-Message-State: AOJu0YwOv8NO3YtURRVMh3E7n5hRuVfs6Y4AT9UATwpUw1qu7ULjM8ZY
 vMy3rcsZN2REX2cBKpEKNepo4uEVjRrbZhy9FE9jQYyYfGD0n0oASW1YAVocv2ZxGI2p5mX1eRd
 NXT4=
X-Google-Smtp-Source: AGHT+IEWPdOVoSnv5hUqmi6fOvUVlTxyYQ/Zmo+uBXnjaaPFyDq4nVpatIbvBQLodFeL9Y+I+NUVHQ==
X-Received: by 2002:a05:6870:169a:b0:270:4500:bdc2 with SMTP id
 586e51a60fabf-2738be2e0f4mr966674fac.32.1724207165931; 
 Tue, 20 Aug 2024 19:26:05 -0700 (PDT)
Received: from stoup.. ([203.56.140.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127af1888esm9210774b3a.149.2024.08.20.19.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 19:26:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 5/5] target/i386: Fix tss access size in switch_tss_ra
Date: Wed, 21 Aug 2024 12:25:48 +1000
Message-ID: <20240821022548.421745-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821022548.421745-1-richard.henderson@linaro.org>
References: <20240821022548.421745-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The two limit_max variables represent size - 1, just like the
encoding in the GDT, thus the 'old' access was off by one.
Access the minimal size of the new tss: the complete tss contains
the iopb, which may be a larger block than the access api expects,
and irrelevant because the iopb is not accessed during the
switch itself.

Fixes: 8b131065080a ("target/i386/tcg: use X86Access for TSS access")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2511
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240819074052.207783-1-richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/i386/tcg/seg_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index bab552cd53..3b8fd827e1 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -378,7 +378,7 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
 
     /* X86Access avoids memory exceptions during the task switch */
     mmu_index = cpu_mmu_index_kernel(env);
-    access_prepare_mmu(&old, env, env->tr.base, old_tss_limit_max,
+    access_prepare_mmu(&old, env, env->tr.base, old_tss_limit_max + 1,
                        MMU_DATA_STORE, mmu_index, retaddr);
 
     if (source == SWITCH_TSS_CALL) {
@@ -386,7 +386,8 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
         probe_access(env, tss_base, 2, MMU_DATA_STORE,
                      mmu_index, retaddr);
     }
-    access_prepare_mmu(&new, env, tss_base, tss_limit,
+    /* While true tss_limit may be larger, we don't access the iopb here. */
+    access_prepare_mmu(&new, env, tss_base, tss_limit_max + 1,
                        MMU_DATA_LOAD, mmu_index, retaddr);
 
     /* save the current state in the old TSS */
-- 
2.43.0


