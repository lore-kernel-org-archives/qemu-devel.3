Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A36C369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ksx-0002qu-Ha; Wed, 23 Apr 2025 20:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqV-00012p-Tw
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:44 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kq5-0004hi-Pv
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:19 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso534986b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455996; x=1746060796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=irulUe5yhLpB5KcHQZP5AkpEiKTl4QGB2IoJogi1FPE=;
 b=ilx/+zakCpZJ8o7t2mseXRnx0GNzCmwe0TRyA09K24MScAyt3zL3ijHgHbPQ6K39yv
 0inBhOpgc4IqVuwtJjtkq6XkREh6JSh8sUBZLVKQDpVuJq0DP4/bL+4JWdvH8qq5uC8r
 wMYFUZrdiSX0N8vTnOkU0qO1K+cwIyDvHODm7Crb/K4gC38TJsW0PRpC20rselkyTM1O
 uOY3Ff9chlOF0H5zuCC869nBLk4mtTjymY8HjwoC+EpVQxtaH6l5gNGuL7iMeOi+ehZ5
 /1iBjDVRtfQQ8pP2Gpw+bwkrsJ8ivAAt11uYGVpXDPMULa1E/PzPPBoRv89//gR+JYWO
 fGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455996; x=1746060796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=irulUe5yhLpB5KcHQZP5AkpEiKTl4QGB2IoJogi1FPE=;
 b=QTf/xe1+RRnBOaZL1OqWaEUA6Sct8nsYZao51BN5p0+aHFsO1TrAChFW2Ut/ruKJ8U
 AjCeSFEez/Hx15sFQLkfb3t1XsD8KmQEq8Xzap78xKqj8EM+4SJObxYw00CBsTKCAUlT
 Z3lcSPZ166/mSgouq6KoPOeQ81HhBorWXa96C/tHgPBlEAOd2wfa5L4KFQD/G5BJA0EW
 kR5vM7jjfmec3hzEX5LBpt6h7jT4xBEAYXv0HzxxU11pOzIYfENlwOu+vawjVNjhzjWR
 0skj5hm1VgWPUAc8MW0irvcjD6+9GlxDQNscB4rX2KfmP6Hjaeeph7hK+1M4Am+D7l7C
 ohOA==
X-Gm-Message-State: AOJu0Yyz9FRZBdbOFK9EP9aqId1KSmkqQPW2pIi80g/Lw/yS0hzxffUQ
 4Mrsg7x5H41oSZzVSs4ezGLyanrhroQ93AxKs7m7qfnkDYx7rFwKnxWjkJZlDsTi76SSi2ejIf/
 u
X-Gm-Gg: ASbGncuY9+TlLQ5p5XHGxGPMhGHkdf9ET2OPC/wXkxjb+x+vP/DQDgJDxQN/RUAUius
 0Yda+CIY/QBTjQOEHNzZMHfPFZsNjL8upwPt6teIAgveWKnO/QakcYxrFkUrvFz3fa9PC87epes
 jv/mBgDH6ec866D4+l5v2+zAAmuu5Y22WjmHzXqWRgQ6L02yrnIcaNjrKLmSJJ33/4kkuqwpSA+
 IrhCGbj12hNqEIfEfhfdjY6WcuXycltJxQZc8UGlWW9RsP8CNJfjF2iwsS6hmteRukqaUQ4i0uH
 W9r6612dAaovqoOaYBqdlhdlXTGbuEX2daur2odB+TvEl5jSvKkgDwGdvr32TokuKvdPJFWvo6c
 =
X-Google-Smtp-Source: AGHT+IHcnrpOOKFss680HXG5zP0moiyTOk6QU9N+v/AWTDhiz8zjjTTd5IueQbT4HqYQvpduYN9WNA==
X-Received: by 2002:a05:6a00:2448:b0:736:53f2:87bc with SMTP id
 d2e1a72fcca58-73e24633529mr1040160b3a.13.1745455996276; 
 Wed, 23 Apr 2025 17:53:16 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 052/148] include/exec: Drop ifndef CONFIG_USER_ONLY from
 cpu-common.h
Date: Wed, 23 Apr 2025 17:47:57 -0700
Message-ID: <20250424004934.598783-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

We were hiding a number of declarations from user-only,
although it hurts nothing to allow them.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-common.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index be032e1a49..9b83fd7ac8 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -9,9 +9,7 @@
 #define CPU_COMMON_H
 
 #include "exec/vaddr.h"
-#ifndef CONFIG_USER_ONLY
 #include "exec/hwaddr.h"
-#endif
 #include "hw/core/cpu.h"
 #include "tcg/debug-assert.h"
 #include "exec/page-protection.h"
@@ -40,8 +38,6 @@ int cpu_get_free_index(void);
 void tcg_iommu_init_notifier_list(CPUState *cpu);
 void tcg_iommu_free_notifier_list(CPUState *cpu);
 
-#if !defined(CONFIG_USER_ONLY)
-
 enum device_endian {
     DEVICE_NATIVE_ENDIAN,
     DEVICE_BIG_ENDIAN,
@@ -176,8 +172,6 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
 int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
                                         size_t length);
 
-#endif
-
 /* Returns: 0 on success, -1 on error */
 int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
                         void *ptr, size_t len, bool is_write);
-- 
2.43.0


