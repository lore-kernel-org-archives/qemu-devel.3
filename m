Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812F6C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 13:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s29dr-000200-Ks; Wed, 01 May 2024 09:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s29dp-0001zK-Rt; Wed, 01 May 2024 09:04:57 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s29do-0005tZ-4b; Wed, 01 May 2024 09:04:57 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1ec69e3dbe5so11842405ad.0; 
 Wed, 01 May 2024 06:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714568694; x=1715173494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y6wide9hnoYVuTByR37TR1r0aZ7vN/8k161BO8whwog=;
 b=VjBDgDexBb/TWaDirojH9WeXgArNmgGoRSdLEQdES97pcjG8spcRSgNnHNmlZ1WmDe
 9UXeVsm3Z5cHV8weuRd/9Fcb7z+gD/NtYoTl/f6EYoMfwzzX9xnbOPN3uEh0WRfHoBne
 HnHojNQKDphc7szKrrxJ8epxJoRsfz8Tnf+3FIPzBmiEbKd0wH7IlPG4Ckg8sfAKpB1C
 xF0l/0zgalCZxCnEBtsKn2vx3VbO0ko8MtG0m+XNQ1T5TiUY9FCyEYzPWMiWeHC9FO3o
 w2YeLqHRZtf3qnafhNHdoOSX63co9toFoOatv79vhUaz2kxxWnU3tKyUWMMDtMYmIXXE
 PilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714568694; x=1715173494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y6wide9hnoYVuTByR37TR1r0aZ7vN/8k161BO8whwog=;
 b=bKgmTKsl+L1OPq6GiBJdhbyenxhDHK7sJyepJibfZ7EzLn+qXtW8EuvhnyIXVEmLAF
 Q2pUHhdO5+2iKP0DPn3E8SioRRm6QalGpN+qkDuni+KTqzXfm3mSDuchncBE4st0JNrX
 juiPSJQpl7TwTVo7DKfyAvZulEl2LZ2VASNAfUoEs7VW/xLotqmR91hDj7TbfhU2Dhzx
 1ykRRjRFdvxAVPF4xkX2tPTq82AjXRciEuxkCNlk+iTzSxhTlZ7Of/AIaNnmtRl9zWpb
 yKi+TvfMZ6ehJdwlXmA0pvL6EofHJJugCjQPVgrLNov66Z+P56224en412XO7pRsbxy0
 gntQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVASgBhM3srlQbe0iCHTL3VtFOxwDto+1KLHtJsQDor2BkqVnGsdN8OiMA2shRtooMyfxHiLF8YMQKAou7vIEmZTg4D2e4=
X-Gm-Message-State: AOJu0Yyngbx1T2nYpZQfaox8pYwiyad/QvDSYVN0MWLMHyK/3EkgRQOv
 ytGBHGy2S6nAIEvZGb85MaPRJKt2or7rEHIr+TPPjR+DR9pPPzh3MiBL8w==
X-Google-Smtp-Source: AGHT+IF5z8a6HK5mCnDfBhRYy0xssZXROmR/zeZynDcrvu60IAhXtltoueCsb0LRbEBg+9LJ7JBlyQ==
X-Received: by 2002:a17:903:1108:b0:1eb:1129:7f15 with SMTP id
 n8-20020a170903110800b001eb11297f15mr2701497plh.46.1714568694098; 
 Wed, 01 May 2024 06:04:54 -0700 (PDT)
Received: from wheely.local0.net ([1.146.40.196])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a17090276cc00b001e41f1dda43sm24064471plt.75.2024.05.01.06.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 06:04:53 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Chinmay Rath" <rathc@linux.ibm.com>
Subject: [PATCH 3/3] target/ppc: Add ISA v3.1 variants of sync instruction
Date: Wed,  1 May 2024 23:04:34 +1000
Message-ID: <20240501130435.941189-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240501130435.941189-1-npiggin@gmail.com>
References: <20240501130435.941189-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

POWER10 adds a new field to sync for store-store syncs, and some
new variants of the existing syncs that include persistent memory.

Implement the store-store syncs and plwsync/phwsync.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/insn32.decode             |  6 ++--
 target/ppc/translate/misc-impl.c.inc | 41 ++++++++++++++++++++--------
 2 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 6b89804b15..a180380750 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -1001,7 +1001,7 @@ MSGSYNC         011111 ----- ----- ----- 1101110110 -
 
 # Memory Barrier Instructions
 
-&X_sync         l
-@X_sync         ...... ... l:2 ..... ..... .......... .           &X_sync
-SYNC            011111 --- ..  ----- ----- 1001010110 -           @X_sync
+&X_sync         l sc
+@X_sync         ...... .. l:3 ... sc:2 ..... .......... .           &X_sync
+SYNC            011111 -- ... --- ..   ----- 1001010110 -           @X_sync
 EIEIO           011111 ----- ----- ----- 1101010110 -
diff --git a/target/ppc/translate/misc-impl.c.inc b/target/ppc/translate/misc-impl.c.inc
index 9226467f81..3467b49d0d 100644
--- a/target/ppc/translate/misc-impl.c.inc
+++ b/target/ppc/translate/misc-impl.c.inc
@@ -25,6 +25,7 @@ static bool trans_SYNC(DisasContext *ctx, arg_X_sync *a)
 {
     TCGBar bar = TCG_MO_ALL;
     uint32_t l = a->l;
+    uint32_t sc = a->sc;
 
     /*
      * BookE uses the msync mnemonic. This means hwsync, except in the
@@ -46,20 +47,36 @@ static bool trans_SYNC(DisasContext *ctx, arg_X_sync *a)
         gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
     }
 
-    if ((l == 1) && (ctx->insns_flags2 & PPC2_MEM_LWSYNC)) {
-        bar = TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_MO_ST_ST;
-    }
-
     /*
-     * We may need to check for a pending TLB flush.
-     *
-     * We do this on ptesync (l == 2) on ppc64 and any sync on ppc32.
-     *
-     * Additionally, this can only happen in kernel mode however so
-     * check MSR_PR as well.
+     * In ISA v3.1, the L field grew one bit. Mask that out to ignore it in
+     * older processors. It also added the SC field, zero this to ignore
+     * it too.
      */
-    if (((l == 2) || !(ctx->insns_flags & PPC_64B)) && !ctx->pr) {
-        gen_check_tlb_flush(ctx, true);
+    if (!(ctx->insns_flags2 & PPC2_ISA310)) {
+        l &= 0x3;
+        sc = 0;
+    }
+
+    if (sc) {
+        /* Store syncs [stsync, stcisync, stncisync]. These ignore L. */
+        bar = TCG_MO_ST_ST;
+    } else {
+        if (((l == 1) && (ctx->insns_flags2 & PPC2_MEM_LWSYNC)) || (l == 5)) {
+            /* lwsync, or plwsync on POWER10 and later */
+            bar = TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_MO_ST_ST;
+        }
+
+        /*
+         * We may need to check for a pending TLB flush.
+         *
+         * We do this on ptesync (l == 2) on ppc64 and any sync on ppc32.
+         *
+         * Additionally, this can only happen in kernel mode however so
+         * check MSR_PR as well.
+         */
+        if (((l == 2) || !(ctx->insns_flags & PPC_64B)) && !ctx->pr) {
+            gen_check_tlb_flush(ctx, true);
+        }
     }
 
     tcg_gen_mb(bar | TCG_BAR_SC);
-- 
2.43.0


