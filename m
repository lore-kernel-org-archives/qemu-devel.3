Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A885DC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 20:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg9h5-0001yA-0t; Fri, 01 Mar 2024 15:41:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rg9h3-0001xP-U1
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 15:41:21 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rg9h2-0006zL-CD
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 15:41:21 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5d3907ff128so2378804a12.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 12:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709325678; x=1709930478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GuRyEJUy3EeC0acSqgIfQ+cNnDkZek7t4EbMZ1kuVCY=;
 b=RwKdvFaqq+YtR1qtErSzsheNZ+g7f+aCRXaIinkm2fFzev/elFg03wwOIitDH9Hbh4
 mGGAffPIFtlgqoOXRTaA13amAK/qsVPk+3cZU+8OzbtoDd1oXsomnvXln+rBSvbsp+Ut
 l89hObcazN9Ak7VeDuEvRk5RGaAyp+7tvUWKZxLUpfO4Kyr9abtcSIgtqQlAGjxr2d01
 hCMXBh5l4Iazio3P2R0HiwAZfIm7p1ECn4J0fC5CwBCSlnLXmtMkD3ku3m767yoYu11C
 7EGAw9lstkEc2lku8Hovq+Z/h8DldO+KuvwWO0CcNWh1i3V0QkOgVEYAcTHidA4z+fS7
 5uBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709325678; x=1709930478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GuRyEJUy3EeC0acSqgIfQ+cNnDkZek7t4EbMZ1kuVCY=;
 b=uT8IPC5jxD3r02h5Fuo5bkRI1bv9t4nwXMF75NCBT9H/06PWNYpELgmWh3xfUyUkX0
 1u3M2XYNcWko0OkVKKC3KIHWpTw3PT2pbpH+lQ+1X+JUA1lhE8bk1KDkM4HvXFdgRhmX
 uiDswsM30e5oUrNB3gOvEPOq3BtE7tpA+FO4e7SdRYdSEL3d0oTMf7j+SLlrtGZyb/0O
 I1889vp3TzvLl485hSqMGg6Oar+hr9tDRAiFmS6rR8df1+mJehsk2nU5lUYc1OPJqz6z
 7I601A0cbsqTh+Gi318M0+JRUBZEBBpirKNjc1MVmFGxdyoRzl8Y1WLfGbpeautIiK4e
 x5rw==
X-Gm-Message-State: AOJu0Yykf9odiDONtjHgO9stjG+FWSlO9iE5jmBJNcUtU60Dt9oMyb49
 MG20w6B9FX0raXedp/q3k61+TqG9WHAc0fg35910WegevNZEsh3p7ttCNszZDd6QL40gwrd40fq
 G
X-Google-Smtp-Source: AGHT+IGoTSE9Rs891AoE7C9IOasHEX9Qog6m84fx/4WzyuXfkuZNBKIXyorFy90YrREK38RAcHKMrQ==
X-Received: by 2002:a17:90a:990b:b0:29a:cb1d:7a37 with SMTP id
 b11-20020a17090a990b00b0029acb1d7a37mr2624088pjp.32.1709325678004; 
 Fri, 01 Mar 2024 12:41:18 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 l3-20020a17090ac58300b0029b2e00359esm681947pjt.36.2024.03.01.12.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 12:41:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 3/6] accel/tcg: Add tlb_fill_flags to CPUTLBEntryFull
Date: Fri,  1 Mar 2024 10:41:07 -1000
Message-Id: <20240301204110.656742-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301204110.656742-1-richard.henderson@linaro.org>
References: <20240301204110.656742-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

Allow the target to set tlb flags to apply to all of the
comparators.  Remove MemTxAttrs.byte_swap, as the bit is
not relevant to memory transactions, only the page mapping.
Adjust target/sparc to set TLB_BSWAP directly.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/memattrs.h   | 2 --
 include/hw/core/cpu.h     | 3 +++
 accel/tcg/cputlb.c        | 5 +----
 target/sparc/mmu_helper.c | 2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index afa885f983..14cdd8d582 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -52,8 +52,6 @@ typedef struct MemTxAttrs {
     unsigned int memory:1;
     /* Requester ID (for MSI for example) */
     unsigned int requester_id:16;
-    /* Invert endianness for this page */
-    unsigned int byte_swap:1;
 } MemTxAttrs;
 
 /* Bus masters which don't specify any attributes will get this,
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index af1a29526d..4c2fddc85b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -230,6 +230,9 @@ typedef struct CPUTLBEntryFull {
     /* @lg_page_size contains the log2 of the page size. */
     uint8_t lg_page_size;
 
+    /* Additional tlb flags requested by tlb_fill. */
+    uint8_t tlb_fill_flags;
+
     /*
      * Additional tlb flags for use by the slow path. If non-zero,
      * the corresponding CPUTLBEntry comparator must have TLB_FORCE_SLOW.
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 047cd2cc0a..72d6a09616 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1145,14 +1145,11 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
               " prot=%x idx=%d\n",
               addr, full->phys_addr, prot, mmu_idx);
 
-    read_flags = 0;
+    read_flags = full->tlb_fill_flags;
     if (full->lg_page_size < TARGET_PAGE_BITS) {
         /* Repeat the MMU check and TLB fill on every access.  */
         read_flags |= TLB_INVALID_MASK;
     }
-    if (full->attrs.byte_swap) {
-        read_flags |= TLB_BSWAP;
-    }
 
     is_ram = memory_region_is_ram(section->mr);
     is_romd = memory_region_is_romd(section->mr);
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 5170a668bb..e7b1997d54 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -580,7 +580,7 @@ static int get_physical_address_data(CPUSPARCState *env, CPUTLBEntryFull *full,
             int do_fault = 0;
 
             if (TTE_IS_IE(env->dtlb[i].tte)) {
-                full->attrs.byte_swap = true;
+                full->tlb_fill_flags |= TLB_BSWAP;
             }
 
             /* access ok? */
-- 
2.34.1


