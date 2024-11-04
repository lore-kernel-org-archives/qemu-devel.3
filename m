Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6D3D11194
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7ks8-0001PV-I4; Sun, 03 Nov 2024 19:23:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kru-00008t-PF; Sun, 03 Nov 2024 19:22:54 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7krs-0002pn-CU; Sun, 03 Nov 2024 19:22:54 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71ec997ad06so2939981b3a.3; 
 Sun, 03 Nov 2024 16:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679770; x=1731284570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9dNzjtTO6L3dRRAUvFaqb7JDDhySMuF5ts1rbW4ln58=;
 b=eMe+e0JXoyYDQ8iCjBK+xw5woSCpd/ALyb9O50xEEU4PepCbzirWMebB3Grz1+G/hX
 97MwmduxbGoVTIdP2OUTcJakBBKhX7+dVfKH/T3Mq0wvMEI7rxvnl4b4yB6YCjr6eM6A
 6h2mPueFIvSrW/AjsMTJ7/CI5UJ1JjNNOaMYucmgUdeIZEvEUwa9w/7EMPvrBmkaKTfF
 OhoMexZhMGRJ6LyOVOZeN7f55qkD0fwDSx1w4nQkiZ/Yj5Pj/VB1SIqAlUxlXcFOuyhJ
 t+Uq/EPSeu/6clkKErVckz9j6bUZl5F0qF/PfkzSvdYZWVxFJWHvzQwNmfSHKwRQXBj9
 WaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679770; x=1731284570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9dNzjtTO6L3dRRAUvFaqb7JDDhySMuF5ts1rbW4ln58=;
 b=sTOKPfuE80/A0kaTV79+nu/NYXNBu1Ht8PH3hGx4mLz9gtyJr5+4jZPHmlW5huTNnK
 gw2CgkNKRWRuXR5sR2+MbuQfpWR7HORNT03Gwy1nMgIidKMmLSHyAzA/5bYyXyl+rmU/
 gitDk8py76LVpss0NNxF9/Y1Mz9OQ6OGJoTOW38XOv/OLHXHIrqo7PbzDz2xy16CHhuc
 /JQOWq5P67+jVpwoLRtE6JmTcit0J78tXQDRkWSDf9x2464eOKpLGn/Fyla7k1wylPGs
 JruS2WJX8by1bu4UKLH0A7NFdrgbQ11mBUN6ul1m8oS+7LFBS9BMh5umvW5VpcdeepWL
 r7jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPseJhoQComd5alOuhxAUbl4Qyiekw5r+rHpcmwiHofNc2iTiDDJplSiGWeJNc3dph+f0F+rOAew==@nongnu.org
X-Gm-Message-State: AOJu0Yx1oVDIkDOUg4bCzCllclYNx8uwm2E4+2zuGyP8+5yLwcS9UHUJ
 me1kDG/Shd6i4KcDdm2h/fUvgzVCQ0jLACahmqcbA7cXdeE1mKoqVbO88w==
X-Google-Smtp-Source: AGHT+IH8Y6Ejge9ldk+In/djFtnqAIj0VTMB+o3cxN1T9f5fdQqW3hjNT6zrso8tMklurTwZk7Vupw==
X-Received: by 2002:a05:6a20:4ca0:b0:1da:68fc:c2e6 with SMTP id
 adf61e73a8af0-1da68fcc4bfmr19365954637.7.1730679770334; 
 Sun, 03 Nov 2024 16:22:50 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:22:49 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Michael Kowal <kowal@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 61/67] pnv/xive2: TIMA CI ops using alternative offsets or byte
 lengths
Date: Mon,  4 Nov 2024 10:18:50 +1000
Message-ID: <20241104001900.682660-62-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
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

From: Michael Kowal <kowal@linux.ibm.com>

Some of the TIMA Special CI operations perform the same operation at
alternative byte offsets and lengths.  The following
xive2_tm_opertions[] table entries are missing when they exist for
other offsets/sizes and have been added:
- lwz@0x810 Pull/Invalidate O/S Context to register    added
  lwz@0x818                                            exists
  ld @0x818                                            exists
- lwz@0x820 Pull Pool Context to register              added
  lwz@0x828                                            exists
  ld @0x828                                            exists
- lwz@0x830 Pull Thread Context to register            added
  lbz@0x838                                            exists

Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c             | 6 ++++++
 include/hw/ppc/xive_regs.h | 7 ++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 82c676b151..245e4d181a 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -614,18 +614,24 @@ static const XiveTmOp xive2_tm_operations[] = {
                                                      xive_tm_ack_os_reg },
     { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING,     1, xive_tm_set_os_pending,
                                                      NULL },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_G2,     4, NULL,
+                                                     xive2_tm_pull_os_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        4, NULL,
                                                      xive2_tm_pull_os_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        8, NULL,
                                                      xive2_tm_pull_os_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,         2, NULL,
                                                      xive_tm_ack_hv_reg },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX_G2,   4, NULL,
+                                                     xive_tm_pull_pool_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      4, NULL,
                                                      xive_tm_pull_pool_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, NULL,
                                                      xive_tm_pull_pool_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_OL,     1, xive2_tm_pull_os_ctx_ol,
                                                      NULL },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_G2,   4, NULL,
+                                                     xive_tm_pull_phys_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX,      1, NULL,
                                                      xive_tm_pull_phys_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_OL,   1, xive2_tm_pull_phys_ctx_ol,
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 5b11463777..326327fc79 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -124,12 +124,17 @@
 #define TM_SPC_PULL_USR_CTX     0x808   /* Load32 Pull/Invalidate user        */
                                         /* context                            */
 #define TM_SPC_SET_OS_PENDING   0x812   /* Store8 Set OS irq pending bit      */
+#define TM_SPC_PULL_OS_CTX_G2   0x810   /* Load32/Load64 Pull/Invalidate OS   */
+                                        /* context to reg                     */
 #define TM_SPC_PULL_OS_CTX      0x818   /* Load32/Load64 Pull/Invalidate OS   */
                                         /* context to reg                     */
+#define TM_SPC_PULL_POOL_CTX_G2 0x820   /* Load32/Load64 Pull/Invalidate Pool */
+                                        /* context to reg                     */
 #define TM_SPC_PULL_POOL_CTX    0x828   /* Load32/Load64 Pull/Invalidate Pool */
                                         /* context to reg                     */
 #define TM_SPC_ACK_HV_REG       0x830   /* Load16 ack HV irq to reg           */
-#define TM_SPC_PULL_PHYS_CTX    0x838   /* Pull phys ctx to reg               */
+#define TM_SPC_PULL_PHYS_CTX_G2 0x830   /* Load32 Pull phys ctx to reg        */
+#define TM_SPC_PULL_PHYS_CTX    0x838   /* Load8  Pull phys ctx to reg        */
 #define TM_SPC_PULL_USR_CTX_OL  0xc08   /* Store8 Pull/Inval usr ctx to odd   */
                                         /* line                               */
 #define TM_SPC_ACK_OS_EL        0xc10   /* Store8 ack OS irq to even line     */
-- 
2.45.2


