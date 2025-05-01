Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80FAC3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbPl-0007VQ-Ax; Thu, 01 May 2025 17:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOw-0005QV-Mp
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:25:03 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOu-0002F4-Hp
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:25:02 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-736c1cf75e4so1364926b3a.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134699; x=1746739499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hQZJbuYh2n3Wgp49lh7OYyMC9rzODAQBYexbJ7U5E2E=;
 b=RtZ2Z50n9zFHApaaRhB8kVyP2L7Cmrff1ks3NT4cY4kRdameJH9de1urpSCmStDn2w
 K5YBMN3svsyQiUgzcCZ9j2a7v+AuqTPB6kBc4Veq1MZ/8jji+sd2N9MjAZnqpjJiYdGW
 2L2PwVrj5xWk/ON3pRU3CBRsPRD+WthjXZzMbkYQmEpO1gegquqjHYd9RoCuNJdD6SJE
 E5Jxj7jtRmSVFVPtBeeidVyY0w9FF/b/pvpzdUiIuDrw1A1qAJy2t6dUgk1Fn7+/tAp2
 laxx3Mrx4QtAXQ0PRKfOS/6Ccgvuu3mIXM1u8qBcznlG4cLpSx/Ib/2LQFncdijCfLSh
 wNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134699; x=1746739499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hQZJbuYh2n3Wgp49lh7OYyMC9rzODAQBYexbJ7U5E2E=;
 b=bpAjTr2NYc0ROSeD+NagoTA1851DeO8UH7pMoq7PrO2bESN7meR53G1qDvRHzVLM6S
 JiyIRtwcPFkunNJ8+qR4u6PM/B+ofjq05eU/DZUSEvilWTnq0CM/Wvo9FAm0i9tEj2qU
 bnwoI7lTTWVsyghd+w6AvJxovgzwLZvT8csLe+fJIxHrh81OR5e8sqIjzQTABByCGVMH
 Vshp/EG8TcZyHbEZeXBdVBpauPleFoc6vBSMr/mgXF354XTERxFacnmf5Tw3zplj5Wm6
 pGhhlGzaXCdmE60/cjCiSVm80MqRMNVJeOsmJ0h/fYBQvJnoAbYWxgSaEoQybWOxTSSo
 FHVQ==
X-Gm-Message-State: AOJu0YygtbW2CGZFmFBaZ9mW22xq4mi8Fz5iqfpegVDyT0rJfeC+YDXo
 vc3wZRmek5ScERQNfAMPexSDMr2ruxdkr9l8J9EYfOv43S4k55MJ2vimlvHrSOvDkn+AtI3CR7d
 v
X-Gm-Gg: ASbGncvXzBjXyBJ1YCRs6jBUdrlyjVo/Hg8HOZoTJKjCwbOFycmgbVWJMih/sOqAQLC
 4VdwpgGh6xqJzq23pTxnJ/fQhTeFnrnMZ+Nz1Z5LsxIcWu3YBy0YuYk3cTDDSfnp2QK8vKxIb0e
 UsiC8ymu6FX1hSzMdwD4aIZAHDnIhxBkODAe7JdMy4rYiwS064Nkj4q60gCKQ1KQtU0hP6msAgD
 UB/GV1YFLbh/7w/Nw7xG/D2icdP/ipHoyD3XnCr2129C4kr15QmvMEMR8ucUZV1hUmpqNtEIqEt
 DtSLZUl7kJJ7+rB1qoscCn5L+/2yB69PL21Mc8vfPF6n7E8J7UOyjGR95JqNjm/LoWaxngsklM4
 =
X-Google-Smtp-Source: AGHT+IEpJ/0p9Ry+r63ZoLjNUy/y4x+O9RZE9+pkhPfxrS8I+75gMuyDAi8UjsrZyLrHx2YlVDsE2g==
X-Received: by 2002:a05:6a00:4482:b0:736:32d2:aa82 with SMTP id
 d2e1a72fcca58-74058b5afa8mr565644b3a.23.1746134698857; 
 Thu, 01 May 2025 14:24:58 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590610desm135897b3a.146.2025.05.01.14.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:24:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 58/59] accel/tcg: Avoid abi_ptr in user-exec.c
Date: Thu,  1 May 2025 14:21:12 -0700
Message-ID: <20250501212113.2961531-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

In page_dump/dump_region, use guest_addr_max to check the
size of the guest address space and size the output
appropriately.  This will change output with small values
of -R reserved_va, but shouldn't affect anything else.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/user-exec.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 46b1e97c30..085da0c036 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -29,6 +29,7 @@
 #include "accel/tcg/helper-retaddr.h"
 #include "accel/tcg/probe.h"
 #include "user/cpu_loop.h"
+#include "user/guest-host.h"
 #include "qemu/main-loop.h"
 #include "user/page-protection.h"
 #include "exec/page-protection.h"
@@ -202,10 +203,19 @@ int walk_memory_regions(void *priv, walk_memory_regions_fn fn)
 static int dump_region(void *opaque, vaddr start, vaddr end, int prot)
 {
     FILE *f = opaque;
+    uint64_t mask;
+    int width;
 
-    fprintf(f, TARGET_ABI_FMT_ptr "-" TARGET_ABI_FMT_ptr
-            " " TARGET_ABI_FMT_ptr " %c%c%c\n",
-            (abi_ptr)start, (abi_ptr)end, (abi_ptr)(end - start),
+    if (guest_addr_max <= UINT32_MAX) {
+        mask = UINT32_MAX, width = 8;
+    } else {
+        mask = UINT64_MAX, width = 16;
+    }
+
+    fprintf(f, "%0*" PRIx64 "-%0*" PRIx64 " %0*" PRIx64 " %c%c%c\n",
+            width, start & mask,
+            width, end & mask,
+            width, (end - start) & mask,
             ((prot & PAGE_READ) ? 'r' : '-'),
             ((prot & PAGE_WRITE) ? 'w' : '-'),
             ((prot & PAGE_EXEC) ? 'x' : '-'));
@@ -215,10 +225,10 @@ static int dump_region(void *opaque, vaddr start, vaddr end, int prot)
 /* dump memory mappings */
 void page_dump(FILE *f)
 {
-    const int length = sizeof(abi_ptr) * 2;
+    int width = guest_addr_max <= UINT32_MAX ? 8 : 16;
 
     fprintf(f, "%-*s %-*s %-*s %s\n",
-            length, "start", length, "end", length, "size", "prot");
+            width, "start", width, "end", width, "size", "prot");
     walk_memory_regions(f, dump_region);
 }
 
@@ -1135,7 +1145,7 @@ static uint64_t do_ld8_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     return ret;
 }
 
-static Int128 do_ld16_mmu(CPUState *cpu, abi_ptr addr,
+static Int128 do_ld16_mmu(CPUState *cpu, vaddr addr,
                           MemOpIdx oi, uintptr_t ra)
 {
     void *haddr;
-- 
2.43.0


