Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6C5C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 20:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBgP3-0008TW-Cp; Sun, 04 May 2025 16:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBgOq-0008Mx-LU
 for qemu-devel@nongnu.org; Sun, 04 May 2025 16:57:25 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBgOn-0006wK-Vh
 for qemu-devel@nongnu.org; Sun, 04 May 2025 16:57:23 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so55975345ad.2
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 13:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746392239; x=1746997039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZDUucsVfN8y2irEntE8OMOE8JkQwtgG4PNL9nMV9SgM=;
 b=AmSE5A0eeije8UErLy+sjOry3EwLAU3kYPWF/kbVzmApqSQfbmtLYgNC5BAWKC/Fcx
 Hoo4HE1E0hC+vtub7NPW1AEZ9SaRdXr2aeyuA4VcdQiuEHUmhwqaa27wvsS9MkAgTIrt
 a+raNN4MC+TrEOVHSEaqkFSltznz2ZjMYcxgOtRoU/0djWgFsabCWAekKv+vLnyxBQei
 rVrxn7loXr3V0pBXSkvH0YcgobzdJj8u1s2JlxlzKX1QV1Cb15ggkkuEEUeTGsWVBriz
 +TiF/U7L81zls5snJ1OjIIP1CYxesrdTbbKHaWtbXdSUZys7nt57Kj5ti+69GEnSbDWK
 WS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746392239; x=1746997039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZDUucsVfN8y2irEntE8OMOE8JkQwtgG4PNL9nMV9SgM=;
 b=NyYwf8MslOJbnuD/T15o7ZZj7+WbAEa97aaku/M3Kt4PkdE9ZqsSFz79tFvEq4kce9
 Xo/bAh5KQG/0jeg94GeAdWjXfO3XyYTV3O+uIR5WeQbER/cRIyPjEbkJC6lGoAPcnVrU
 Xm/YNAUPN2pDvvT8Z9iyKCx52wxuSK92i1dYhi8AD0EReA7PMBOb2MN3/ha0ixUk21h/
 3JvIzWtpU18BQXv3QY2Pte9dsSjTgVveyp8U3toeX+YzESGINJ5t8SNO/DX7S6b1PQ9V
 Erxg8neiirL4caqbLiWdox0GKUGfMMEQEkjid0OUIK/I8zkZiWmftKkXbpxD215zHwbT
 UcMQ==
X-Gm-Message-State: AOJu0YyCeWuzFmDMr4hf9KiLF+hsUnI2Q4kOjFmkE2qO+eKjbOdl19CZ
 awqNq5fqyQfhg6S5jFqfJuz3xbLSSnXzrstKT8+YVVEjkr2pe6E69yjRnEGBiH2HdfzhowN66LG
 F
X-Gm-Gg: ASbGnctfp0/jlD0E5Q+XMHyj5WYpRoywgixsWRYBRtlnVm4GYw9aOQiUc5WNzb8AlGe
 pFVTLIURZlZBCQCHJxo+11n7IPMbqdbwo4bw6Y6yAj77s+5QVJhitHgiKV2ykIj92B1WRQmYAij
 ZZg+/81LKzhmQ04DHKepoe5bn2LSZCQeBhbMkO5pqPN9cvTBl29NOkDC2O9eJffuFa2RJcXeqsI
 vF/nU7oD27IkKY4GFZyBt/5jRKujqUBhmpNUTDwogLyYeLZJC6aN4Bq5YHy8jSmElBc2M6g2sPU
 x5WRsu168KVsBVIDWuAoRktlqY48G+aN+dt5usbKSRXeyHa6MwENhdROWXuIcT2zRoF4qaLv26c
 =
X-Google-Smtp-Source: AGHT+IEcvw7GqwvyWxOT9oUjxIr5ii3IzowMPcLjUHesS1SdB3jPKzCkgMdnqNJYcTihdmCcTtoXEw==
X-Received: by 2002:a17:903:3c4f:b0:220:f449:7419 with SMTP id
 d9443c01a7336-22e1e8ea150mr69674855ad.7.1746392239710; 
 Sun, 04 May 2025 13:57:19 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e150eadfcsm41346425ad.32.2025.05.04.13.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 13:57:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: foss@percivaleng.com,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 05/12] target/i386: Fill in TCGCPUOps.pointer_wrap
Date: Sun,  4 May 2025 13:57:06 -0700
Message-ID: <20250504205714.3432096-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504205714.3432096-1-richard.henderson@linaro.org>
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Check 32 vs 64-bit state.

Cc: Paolo Bonzini <pbonzini@redhat.com>
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


