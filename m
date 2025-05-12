Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD50CC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJcH-0006Ft-4t; Sun, 11 May 2025 23:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJc7-0005Mj-7V; Sun, 11 May 2025 23:13:59 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJc4-00073w-F2; Sun, 11 May 2025 23:13:58 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7418e182864so2902054b3a.1; 
 Sun, 11 May 2025 20:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019634; x=1747624434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ozBPu1v/P5BL4hnwKiy63E2mFqcKZCCJOZmJTr2wD0o=;
 b=N7idvki+iVFU30C5ywqQioFrorb6nZYmd4NQMw0rqkT8t5yh7+tQv8UlVxjAXPs25G
 jX+i5st/nflyg/XVQDkdWEVDxWmQU7tqEacjGUVErLx5A5xL1jMwb9StueC6VVZpKjCR
 hCMaQ2Hw/yg9gr8qOeN9+eI1YyY5ux1xGf273rF8P/IBPXa2qIbfNPofQe1Rkxt6vTnc
 md0p3mNop3GHVZSeSqfS5Q4QShU6rGa3T8aiwBDcgU95v1kl/h5cFcmN7r69kQ3MsmQ5
 8uuZaroWcvHyD9iN3Rl6cxBLRbp/XEjUo/bRsgme7G8urxlSVYPFnZ9w0QM+qBaDuyEl
 w6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019634; x=1747624434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ozBPu1v/P5BL4hnwKiy63E2mFqcKZCCJOZmJTr2wD0o=;
 b=BpHCHEHF6rnpYuoo8cpEJzBaNUrZnBYF9JWkkdOfPAP+AVj5h/SxOVgnZRz7bmYT0z
 J1EWVXJnLpl5O7KvWWJEyNCQI34dCv4fTIF+tOacuCS/b2wCvTR+nAwvKCEdoVSJSKs4
 vA7LO+TEBET/uKter9gEpZFWP+e/lebf+Bde92LvHx++fww69tKitGtQkvn8w+Pi2sxe
 +VnOlL5Jkv+qMgfvefol/BmuoQO7EmOKqzrXNSaEN4XbHapAR7wCEBeekVgaetywS9dp
 h36pYtwHKrE5lqSf9AFuo0Q3xDPHYF+iy9NjgoY7YYqH+nTbOQx6KRQM7G7XOmBj30wo
 jHYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3RD2kRbgwydbeFZFG+JhQN6Mz1WsNrCkHJ60QYM2gT1k7Vho+z7Z9VYxPXP6Sk+ErwOXDL0d+Q3SS@nongnu.org
X-Gm-Message-State: AOJu0Yz7Sn3+bdJxf+VHN6mlQB/kQ4kYOi7TlLVDyWZFQqbHOo1XZFXn
 5NdS1dBGE9nBejFFJYQMTrUOzKGRrRNPVMwxhjxol/M5hi7Sz+zg8rl75g==
X-Gm-Gg: ASbGnct6YuAXAbMrmKs7A5s5cpzRveJoYIyrwFYW4GE+RCrz7tjMNQEx1j3tyxkvXOz
 izGxjQYU8wcBdUZdcNg2QQVOF4i0UzZmAubYyGduYhd/WQ6CnhI3Cdchcn0bxpRaevm1JKn9gTp
 3/6cmUbF/GvfEohAUgW003D9UjX1lrT+1iot8yAWeCChHdHMcQ+UIB/CRudIYSiuUkoHbcwUpoE
 qY63ZpSI3295M4APViAaoLeJSiH+oZG1cekWvUOZ3UAKOQAPnZZ9V4FoumPcEu7utIJsBrAkQml
 k8k9T04nf2XTfJmZfUjzVTi3s6qXzQR6l9kQnHamoDRVQPn+HH0VHhZRzQ==
X-Google-Smtp-Source: AGHT+IFvS6C5Pi6YkiAXAxfj78HycFXKAreucfhNtegwTOoM+rVV0TATN6v8msrR6oFGS1QE38+ojA==
X-Received: by 2002:a05:6a20:d490:b0:1f5:884a:7549 with SMTP id
 adf61e73a8af0-215abcf3a0bmr18032901637.41.1747019634276; 
 Sun, 11 May 2025 20:13:54 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:13:53 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 45/50] ppc/xive2: redistribute group interrupts on context push
Date: Mon, 12 May 2025 13:10:54 +1000
Message-ID: <20250512031100.439842-46-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
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

When pushing a context, any presented group interrupt should be
redistributed before processing pending interrupts to present
highest priority.

This can occur when pushing the POOL ring when the valid PHYS
ring has a group interrupt presented, because they share signal
registers.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive2.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 21cd07df68..392ac6077e 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -945,8 +945,9 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
                                    uint8_t nvp_blk, uint32_t nvp_idx,
                                    bool do_restore)
 {
+    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
     uint8_t *regs = &tctx->regs[ring];
-    uint8_t ipb;
+    uint8_t ipb, nsr = sig_regs[TM_NSR];
     Xive2Nvp nvp;
 
     /*
@@ -978,6 +979,11 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
     /* IPB bits in the backlog are merged with the TIMA IPB bits */
     regs[TM_IPB] |= ipb;
 
+    if (xive_nsr_indicates_group_exception(ring, nsr)) {
+        /* redistribute precluded active grp interrupt */
+        g_assert(ring == TM_QW2_HV_POOL); /* PHYS ring has the grp interrupt */
+        xive2_redistribute(xrtr, tctx, xive_nsr_exception_ring(ring, nsr));
+    }
     xive2_tctx_process_pending(tctx, ring == TM_QW2_HV_POOL ?
                                          TM_QW3_HV_PHYS : ring);
 }
-- 
2.47.1


