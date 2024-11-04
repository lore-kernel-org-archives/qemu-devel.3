Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA97D11199
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7krw-0000Dm-2H; Sun, 03 Nov 2024 19:22:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7krV-0006zT-BE; Sun, 03 Nov 2024 19:22:32 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7krT-0002mv-3Z; Sun, 03 Nov 2024 19:22:28 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-71e5a62031aso2875030b3a.1; 
 Sun, 03 Nov 2024 16:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679745; x=1731284545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uJHQWHKZNwdpX5xpE4NGKUgAt0/AlwETGxPvV8xdFsM=;
 b=WUVVc0GUPXctFFWoLOGOVIwCRA9CiHiCNrzlVHmp1EFF97W9SjkG+8ywjpbMmmu5p3
 GAMM8CHHMW4cJmpkdQCTlOjm4VUyHZyIJLZI+7FDLMgBBbRW8w56zlazgwFhouoxRVi4
 28OD3Fe4sQqYz35bjpg3qQqJx+AR6YBch5V/zY2dNAN5ObcC+phAZLuhCs0mCdkYtlMb
 9OuUS1hCXdvb6aLSSMgHRL8ZzvidBzohCnGS6C0bQKOcyi/fJAvLiT1tBr39X//sCzlQ
 fshFOdlX/Y9FhHArYE1UyqBBgTt3MDv1xf+rIah7t2xwt3Ger4BCtAIAM7mVXnL3Vmnj
 3vOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679745; x=1731284545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uJHQWHKZNwdpX5xpE4NGKUgAt0/AlwETGxPvV8xdFsM=;
 b=F4zQ1UjinPuiR8CBJ+G2MZxTekSzsmbF6LaNOgiXX2sfOtWZhy9+Mp89o838NM7Kxe
 XDeaUHTWTTcl5Qju6kZ8blfS0Im6RPDWoQ07GCy2Tx6hXkxxmTJt2SWBU9H6gs5b5wWv
 1aRLZE7Bj8ibYscrJ7Fs+kszJ2M4bI1zdGKz/2whaQ4W2BUT8eESdT+fA0c2HDfV0/t3
 cKO+5H5XJenUXZY1k8lbAnlxUJ8X55xqUd/aSEwKuYz+52Gyq+9UJRBycQ+ZtzIM/BRF
 Vavip25feQWP2I1NbDd2i4oPyVQgh6Pmwszc7nuEQZF/XJNFKpp2E0t9MT7AxqNEN/wK
 JWYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM5sxTgHY+FIdr7PpxrC3AqHIe7xCiB/GumARvl+o9GVZryEBV/5ZL2Lz7iBS3hZ8If3yPNyAeQg==@nongnu.org
X-Gm-Message-State: AOJu0YycjS3eODlPDPVsujW9N/9P9keTiKBA9GFvlf9R9gJDYvowgfDR
 lPIsnxldn6y4iIXmflt4ZByGIZsn6x0KEWMfxj2FadfH3QypZMH/FI86Sw==
X-Google-Smtp-Source: AGHT+IEQT+RFtjXPGWFUghrD43LUNWG56ge+40NlYqaG9LpsZjeSCaiTAvG/KMAflDbSsNlc+hdu2A==
X-Received: by 2002:a05:6300:4043:b0:1d9:2bed:c7e8 with SMTP id
 adf61e73a8af0-1dba55aaf69mr20671540637.35.1730679744964; 
 Sun, 03 Nov 2024 16:22:24 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:22:24 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 54/67] ppc/xive2: Allow 1-byte write of Target field in TIMA
Date: Mon,  4 Nov 2024 10:18:43 +1000
Message-ID: <20241104001900.682660-55-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

When running PowerVM, the console is littered with XIVE traces regarding
invalid writes to TIMA address 0x100b6 due to a lack of support for writes
to the "TARGET" field which was added for XIVE GEN2.  To fix this, we add
special op support for 1-byte writes to this field.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c             |  2 ++
 hw/intc/xive2.c            | 13 +++++++++++++
 include/hw/ppc/xive2.h     |  2 ++
 include/hw/ppc/xive_regs.h |  1 +
 4 files changed, 18 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index caa8dc74b6..574ac685c3 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -546,6 +546,8 @@ static const XiveTmOp xive2_tm_operations[] = {
                                                      NULL },
     { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL,
                                                      xive_tm_vt_poll },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_T,     1, xive2_tm_set_hv_target,
+                                                     NULL },
 
     /* MMIOs above 2K : special operations with side effects */
     { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, NULL,
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 26b6e72129..8d3d69a0db 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -585,6 +585,19 @@ void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     }
 }
 
+static void xive2_tctx_set_target(XiveTCTX *tctx, uint8_t ring, uint8_t target)
+{
+    uint8_t *regs = &tctx->regs[ring];
+
+    regs[TM_T] = target;
+}
+
+void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
+                            hwaddr offset, uint64_t value, unsigned size)
+{
+    xive2_tctx_set_target(tctx, TM_QW3_HV_PHYS, value & 0xff);
+}
+
 /*
  * XIVE Router (aka. Virtualization Controller or IVRE)
  */
diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index b7a7c33ddd..36bd0e747f 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -121,5 +121,7 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                                hwaddr offset, unsigned size);
 void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
                              hwaddr offset, uint64_t value, unsigned size);
+void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
+                            hwaddr offset, uint64_t value, unsigned size);
 
 #endif /* PPC_XIVE2_H */
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 27a744d50d..f8f05deafd 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -79,6 +79,7 @@
 #define TM_INC                  0x5  /*  -   +   -   +  */
 #define TM_LGS                  0x5  /*  +   +   +   +  */ /* Rename P10 */
 #define TM_AGE                  0x6  /*  -   +   -   +  */
+#define TM_T                    0x6  /*  -   +   -   +  */ /* Rename P10 */
 #define TM_PIPR                 0x7  /*  -   +   -   +  */
 #define TM_OGEN                 0xF  /*  -   +   -   -  */ /* P10 only */
 
-- 
2.45.2


