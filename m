Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F46C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 14:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVK5-0005j7-Rd; Thu, 01 May 2025 10:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVK0-0005hT-5A
 for qemu-devel@nongnu.org; Thu, 01 May 2025 10:55:32 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVJy-0005Wu-9o
 for qemu-devel@nongnu.org; Thu, 01 May 2025 10:55:31 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-30332dfc820so1330444a91.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 07:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746111329; x=1746716129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9qBhX/Vzei5onG8CkoplGyB8ooo97U2cHYvAaBNQf3s=;
 b=yqHjfW2Pu4a4A8grA6amWgITpCSyX/D61LR4/4zn78XWcZFVdAK9nV0jGYJCmdjJQH
 Zvf8iyCafnu/V1Q+F+shIh6WILIagvKs958yTqiUMswEGVWNxs/m5VVg06RaUb7ydTid
 Im4+sJjoC0/jxBLEVst8gUV2bPj83Tk+rI+W3AZxsufk3MX0jQMOMiPiYwkaNrZSyjtA
 YNwH2twHBgyEhRklxRfnJ/F5udvxcIE6OshfI3lYB5YDBIRf5Oro3IOGxr6M2fCiztzu
 tN50klL3p7DK7vZp0OKQNXdB6wCiX8maWFUgOBDdPX5FnjHtSjRPfUmj+hmm2zTpVZDW
 20jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746111329; x=1746716129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9qBhX/Vzei5onG8CkoplGyB8ooo97U2cHYvAaBNQf3s=;
 b=Vomi6CmA+AO76UEMc0Rc1GF7Ff0lrS0uO373jjqZvIovILyypkTnDZhX6Id1OXHm1M
 dvimUHaHuTeCK4wrfj2e7Y/Eww5TGlql8nBNgGPkB/T6LB9zKl95AL5PhWldSgRgmExg
 nvgJtLYVyzzI7Y35NA6aZwtZnzAOMCTUy31MAbT4xZTHBaG35eX7soZzRrzhxtmxBItj
 178my/BPPCj5r6uOLEqjfz+0G8VTf+/PNGP0vuK1Oe428I8UEZ1O9LifwEoDe+aH0O3t
 VofwYsf3o+Duh2XovZpj15Gx6kx1UQ96J1WTuFqMn72Cw/Vx/2Hl6V7jTEIJUrBLJ6ga
 tURw==
X-Gm-Message-State: AOJu0Yyh9JNRTCnbZ8oj8gv2ug6yyW7G9ltgMj4exzUarjcxxHhGh5lM
 p4YKH5qY6OlAV/pbXiaZrzwVACcee6RqqKGWq94M1GTu+BxUwVLE8Z6AAcTTb3peDCUR8RONLpd
 W
X-Gm-Gg: ASbGncsMQ5SX5gd5O3PtPbprZWF+ELWT6cPnrH3lSzZJfXhubgUs2wtQmkUsnWJ8Dcu
 GDulcN5ScXiikkZyNZDtm7LCAYMfmYaLNGoE7H5VIZJK7tDdEudn21GcbX+ULVPiYqLbaKRismp
 onuTp0SXTb6dPmiE6WKPwbnmHynoduOeNkC7fAIWhAh3wd0WmiBMk+Fnh6keA50aKOvOZmtoBvH
 /xwFTLwtIAtaUWXOoRekS8ff0u1Bfjzdu99FQFuicP2IoqATohOLy8vJbqaSLmSfri5iYOJ7kDL
 uKxwpAiJ5pQRdoJ4gAV5OTLvxIrlAJorbl+LCh6Kkk81aWPiuK+65LgH8zDHh+UPA0NbskafXkI
 =
X-Google-Smtp-Source: AGHT+IF2OcmS55quGF2jvtdXrEbtIc+w4HSYinrSkXHrfVR1MvO6LAD/27AUhgNut3sk4kVhNca0zg==
X-Received: by 2002:a17:90b:586d:b0:2ee:7411:ca99 with SMTP id
 98e67ed59e1d1-30a400a8791mr4701956a91.1.1746111328449; 
 Thu, 01 May 2025 07:55:28 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e0bb0e770sm7644415ad.92.2025.05.01.07.55.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 07:55:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/11] accel/tcg: Avoid abi_ptr in user-exec.c
Date: Thu,  1 May 2025 07:55:18 -0700
Message-ID: <20250501145520.2695073-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501145520.2695073-1-richard.henderson@linaro.org>
References: <20250501145520.2695073-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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


