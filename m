Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1D9C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 05:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzSNw-0002fS-US; Thu, 27 Aug 2026 01:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzSNv-0002e4-9V
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:10:43 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzSNs-00044t-MC
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:10:43 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-cbedbaba5fdso224856a12.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787807439; x=1788412239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NK/DHlEW6EIk2cf6PmuhEA3oo9/juwtu7TT1AMLm/g0=;
 b=MN+PJrckJmToPiqCxsohwOw3lBpS5sIcJky5xGhi/Mpb9R3X/U3TBHdRVJjbB6+wLf
 zkQTLfdW38KjMbv86kEsaC8YvWoCDxBiKvfT4BFSRXUDzGhQP8L/NpjZmEoJOi11YCJl
 fV9kq4VK0Rq5c52LELAsTnFac8MXjXWHgn/e7rROyecQBySLecYiTIZm0Oqd6f81iFkC
 BaPOc6LHr5ejW2hZl5pbTKtM5xKFAW0f7Q0SA71guWyJIZqGrASchGhGyt1xRERphaE8
 btwB/EGm6uaL7L654ZTr1MA/vJt5Z3oRZvEVg2UCF2G29KdLSqkT9+pIuwPg4ALvYcUh
 XHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787807439; x=1788412239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NK/DHlEW6EIk2cf6PmuhEA3oo9/juwtu7TT1AMLm/g0=;
 b=pM44pKFxY15g5k2kKEije/tKcZgNDKTEAR+J4NazHr3PMZ64yt+vsEb0Q8fOnwZ9W7
 d3QnprBdExA2bIkCQgXQ7OlcPU5bNmr4ll8PDMuqSlIsEEi3O/HJoaNRNHFCVypsZ5Mh
 8GjcbT2FxUATR45FXj+XiJ3WLyhgzw5bPr7E+Qpslcx601GPJu76RhcBOsNbygy/K0zH
 aD9g2wAirTeC6okdUVC0lq+UwmhsbMGBLoTg5Yp4c9FUjaKBRvg+xzxkR8Y+Z+3usQ4r
 bRRfO3yjUFMEQ9tIdi3wDbJYatzaz4aHoPLyqaNYxug07a4C0tNsBVk/yhuxktOkAuzf
 pWiA==
X-Forwarded-Encrypted: i=1;
 AHgh+RryTKEzCYHLBG6IDXGAkNF+/HCPBbD8rc1v3wJNWqQQFAkwlN1jAWQRMzvWWJ71kmkrol2IVK6zhb9G@nongnu.org
X-Gm-Message-State: AFuF++kpmAoXbqbx3fnrhdS7JIB2E8wdVybjY1t/amDn9u72bo9z8X5z
 0CUdbH7pgtZBkyrqWhNKNeLq0LDjuhfRtRWVA1ZqGQP1mYhXRYDGCRz9
X-Gm-Gg: AR+sD11MRJgwFDn0qOH8MckDz7R3jQtJj6toNXNGwQmImavod4fwSekMScJBj8QlDuz
 XKZjT4nUf5YJrEfdd2VuLz2Gvqpiiy/LRkses63XqyWuRrVHAATvs+QXr3f1bc2uw/aclSTTtRt
 HuF1aNYpbBfpCZSbrq1woWnId8QCstKl+XgejH4QuCo5VgP47GPxRRaw4Wv8OMdEH65AcgKhxQw
 iDQB6B0FAippzLLCx0+6HispmXxUQkB12nSLi/G1bWrNsBxrhFD4se84Ux1vrP1afIymA/1LK45
 +XBY/Yk+sXj2yMkfD2ZmxrOToRtLwLufyVFclkPGm6yaVysKMoj5NKZ4kpv4Jdc4fFqIDqBHvhL
 hpQbbLwYbj7/GN0GMEMXEU7lMS1p6wb2y9MEHhUq1cR7g66bqTWi4ANvQ3+9wwk18rHuJLKADe1
 zA8L2FhWD6xA7iNsw4hKJs908hi1gqSJVMpJ+qANNExnSSl8bQz67Bz8ech0UER8c+uMVzzDj8f
 JNguo5L8SEwqC9zeRaKmgEv5N9wjf5kILb8HapoF05pGbQAVmbpZWOzLG0ubiEMaGxgBNMPt1YZ
 2MafKi4otyDHCtetqdu4
X-Received: by 2002:a17:90b:3b4b:b0:381:11eb:d78e with SMTP id
 98e67ed59e1d1-3966d8b6295mr25121340a91.14.1787807439137; 
 Wed, 26 Aug 2026 22:10:39 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39670599275sm2210473a91.0.2026.08.26.22.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 22:10:38 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 04/12] tests/tcg/riscv64: Update semihosting linker script
Date: Thu, 27 Aug 2026 14:39:43 +0930
Message-ID: <20260827050953.67184-5-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260827050953.67184-1-joel@jms.id.au>
References: <20260827050953.67184-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Keep the tests at the start of RAM but bound them with a MEMORY region,
and use this to define __stack_top, which the multiarch system test boot
code will use.

Add more sections generated by the test binaries so they are placed
explicitly.

Split text and data into separate rx/rw regions, instead of one rwx
region to avoid binutils warnings.

A -kernel boot jumps to the lowest loaded address rather than the ELF
entry point, so _start must be first in .text. Use a .text._start input
section to make that explicit.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 tests/tcg/riscv64/semihost.ld | 47 +++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/tests/tcg/riscv64/semihost.ld b/tests/tcg/riscv64/semihost.ld
index a59cc56b289a..eff3701e4a19 100644
--- a/tests/tcg/riscv64/semihost.ld
+++ b/tests/tcg/riscv64/semihost.ld
@@ -1,21 +1,46 @@
+/*
+ * Linker script for the RISC-V system tests
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
 ENTRY(_start)
 
+MEMORY
+{
+    /*
+     * Virt machine, RAM starts at 2GB
+     *
+     * Separate sections for executable and writable data to avoid linker
+     * warnings.
+     */
+    TXT (rx) : ORIGIN = 0x80000000, LENGTH = 2M
+    DAT (rw) : ORIGIN = 0x80000000 + 2M, LENGTH = 2M
+}
+
 SECTIONS
 {
-    /* virt machine, RAM starts at 2gb */
-    . = 0x80000000;
     .text : {
+        *(.text._start)
         *(.text)
-    }
+    } > TXT
+
     .rodata : {
-        *(.rodata)
-    }
-    /* align r/w section to next 2mb */
-    . = ALIGN(1 << 21);
+        *(.rodata .rodata.*)
+        *(.eh_frame)
+    } > TXT
+
+    .got : {
+        *(.got .got.plt)
+    } > DAT
+
     .data : {
-        *(.data)
-    }
+        *(.data .data.* .sdata .sdata.*)
+    } > DAT
+
     .bss : {
-        *(.bss)
-    }
+        *(.bss .bss.* .sbss .sbss.*)
+    } > DAT
+
+    /* Stack grows down from the end of the data region */
+    __stack_top = ORIGIN(DAT) + LENGTH(DAT);
 }
-- 
2.47.3


