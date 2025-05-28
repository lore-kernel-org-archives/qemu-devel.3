Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC9DC5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBz2-0003S3-Bs; Wed, 28 May 2025 04:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBwE-0008Ap-Vy
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:15:03 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvw-0005Ht-Cj
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:15:00 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-442ccf0e1b3so54554315e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748420081; x=1749024881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jbzs8SSpnFWUH8ateP0v1HSUtugL3UmRKi3x5SHm6hE=;
 b=k1qmjGVI5Sg/eYW765x51qW6d1Gp2DyD9S13cGT1kqzBY47iqYn9ObeeFofBCmGmd9
 91Vt8lGMlh2KXYzeelPL/wmixZpAmiqpUSaR6qeLzY+HeTxhovJj0rpXqdrW0O8nvRcX
 ZCjOdES7OZzOgdK7GrRnRIz7XyTgLHFJ+MkhwOb++NgHljpF71uNJAtzfMYyU8V9iz9q
 ApvxwY3SVzHD+55N6TBb0bcOK3rPi97KZhs2JrewqLMDAYTCRq6p2Cxf9n/w1NW0SNuR
 MCQXpWTN5Rj4xS+4CdbGPSFIVAcyebViJpBC9f7HRGOs5GsJ+zUrCyHSWbGJJJ6ESDU9
 Qm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420081; x=1749024881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jbzs8SSpnFWUH8ateP0v1HSUtugL3UmRKi3x5SHm6hE=;
 b=TwWxoDzkEBUE8kwLBcyhHkAh8D3VdN593QxxwDY0rnXcK5upPq7Cpqe/Z7dyyImW4W
 iZTHHRCzKn4In0hUbXA72kmnUJbQJ48vdyOAiOMp71KZV/mdJRhmgv4C0ifFKlYyCZ3v
 V/6ccSd94x9tcHBdf7dxYbK5z/QKtyKz9ARL9KGr2ir3uyLGpXJFFc0nsR+oZF/+oJyj
 rZU5dHIxMMVggSIzLvgu72UyoEkPUNEvEtSOzRN1aGxLj+QiPih7iV4cypZ4h3Jm4dhs
 8aIEB5uMcZ9PBOLAAg4UehP85eRcdjpydrqtoBDxOmcQCNwnDNQ/O/Ef73+aQjnJIXiS
 B51w==
X-Gm-Message-State: AOJu0Yx3b7t9g3PdEfHoiR3C8h3xA5VJukZMixrXgClhMTyIpYTMRvr4
 DKJ+rKYgFeLtW83UwMTbUg0ik9W1k2liSJFj+waLIYoNIl4Xlc+ZE7OJcZsUA9OnrxtUUCC8ZSH
 pNJYlZ/1b+g==
X-Gm-Gg: ASbGncub8x86eMdnCmcA8ocOYZRzJji6ppSqXnyN55AnpdHOnCiJjKCIzaRtdIN8eB7
 HA1PzDBdFO1ST//pg9fHeSBJm4Eo6+NmARmh3NqHvTtRK8zcJKvtgtI4ht+KzszmX5Vv5box/AK
 6zQZbavO5ZGPOb49Q1a+J0uZVrN7AzTjCbrusnLKVfXYuYvA/BHakyWx3Mv7OmrjiSuM4v1S4s0
 xVheyaJlA9cAhoNOQeYcR8vk/Kf7I8bX98vsiICHTuSBagKfO234cfNGrQAAE0LGFl+Azcs+xDq
 XF/VhC68FIpb/9s/imVq94pNuMi3jdQYInDe+oAJET/a+tu4bc7n9pMGO4J81u71PIg=
X-Google-Smtp-Source: AGHT+IH6Kk0axK9C0k5YiZSc4cP+/78DrUeLhh+1dpTU0MacUpZrdUAJ/FHLgjqUOQJTTg7ywaGYwQ==
X-Received: by 2002:a05:6000:178b:b0:3a4:dcb0:a4c with SMTP id
 ffacd0b85a97d-3a4dcb00b65mr7501920f8f.12.1748420081556; 
 Wed, 28 May 2025 01:14:41 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d85b5sm13178645e9.32.2025.05.28.01.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:14:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/28] target/i386: Fill in TCGCPUOps.pointer_wrap
Date: Wed, 28 May 2025 09:14:03 +0100
Message-ID: <20250528081410.157251-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528081410.157251-1-richard.henderson@linaro.org>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Check 32 vs 64-bit state.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/tcg-cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 179dfdf064..6f5dc06b3b 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -149,6 +149,12 @@ static void x86_cpu_exec_reset(CPUState *cs)
     do_cpu_init(env_archcpu(env));
     cs->exception_index = EXCP_HALTED;
 }
+
+static vaddr x86_pointer_wrap(CPUState *cs, int mmu_idx,
+                              vaddr result, vaddr base)
+{
+    return cpu_env(cs)->hflags & HF_CS64_MASK ? result : (uint32_t)result;
+}
 #endif
 
 const TCGCPUOps x86_tcg_ops = {
@@ -172,6 +178,7 @@ const TCGCPUOps x86_tcg_ops = {
     .record_sigbus = x86_cpu_record_sigbus,
 #else
     .tlb_fill = x86_cpu_tlb_fill,
+    .pointer_wrap = x86_pointer_wrap,
     .do_interrupt = x86_cpu_do_interrupt,
     .cpu_exec_halt = x86_cpu_exec_halt,
     .cpu_exec_interrupt = x86_cpu_exec_interrupt,
-- 
2.43.0


