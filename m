Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AD6CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPtP-0003qO-2m; Thu, 15 Oct 2026 14:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPtD-0003mS-RR
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:16 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPtA-00010k-Mm
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:15 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso655030f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792087751; x=1792692551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OaTDXncVxvgT4ZfQobI2uWoH8i7yOFG8YfpOm+j4JkM=;
 b=xuK7+GvuSph5ziPSTweSM8MsLAE5v9OUdvOlvG0p1zFBrqth6OViTh6qTlh5DHAGlr
 PEKtOeXZJstqYVbSChLSCqU5vfICvqRJk+3BUzesvs3ty2u0uOwTpIaoDeAsGzUvxPKq
 BYrPbYCGy14MSy1QodgsEOisaZrV7C/s9dnVZUSjQZejhgYsUqzvLOJ+PuPzdeB0i4Xt
 b2/C5Ix2JDg+iX6n5qSzPFKzdSUExO0npSRFDrCfryyaIDcuQwYjjQWCEDQ6NSJ0wQWE
 /uHL2m3gYpA+eMFGEvNptM2cEy0aWhFFmomb2aPxiVv5xhbNAk26UQYqPzU2kTVXUMXp
 Pjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087751; x=1792692551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OaTDXncVxvgT4ZfQobI2uWoH8i7yOFG8YfpOm+j4JkM=;
 b=sRgopNnXNdsqpdmgOJSb277/TckkHGIf8Jae+VAMUpeHAaIaCzpnghvcXB3nzT3Ror
 rBUcKrNZ5bBPfeTQuQbI4cRTtL6Tt4UaIIbeNl6qsN8MjtgyE+M9+RCQj5MMJS/fYzyM
 vEQbQqbNcQLM4MAyhR1FaXMQBno2hLdlCGZF9fzPT/17Yr9dJVdShxnHiQ9F5lKJnuSu
 Rwr7Ze/bMsAHOrPjD4dfUe42iWt/fsB7zAnIhp1d04o5HFiYzYVK3hQh0KhPcgUOb6lu
 Z3lOUmNznhvUJWy5eHKMPDcMSlE14kiv4BFD/xycp3UnHZFTTtSrGMcftZGzRp21VWgu
 0Uzw==
X-Gm-Message-State: AFq9FYJCtP8DgmZbX7bREJZBhP1HSU5Hn/XasJOol1zk6OgcxkLraOmQ
 AhUDc6m5BUdWp3OaW/INWlEf/fDt8pqi2mYps7FLrZlY2ZWVQRIrRPVJYKCAUzUARJmTTx1fkRT
 KqcXSOQ4=
X-Gm-Gg: AYBFou1uFJFXgUpye+BCFOVC3p46qXCSN8G1Mqm8DfRp8ZIsaYV65I6RPzBy3lmp1Ov
 Qriu2CocwBFXQJ385rfnLXZljkO3dMgfXcxWdAaa94whbPpNcGZGiPcJiKife5/9NxwCh3KH/KH
 7Bxgj0HSKcSvyNil9nmjRFFAxQEazw+q/U12O6stw0esAW3nde4+voUZ2fAQXzrIW0/qjVM3ZGL
 fG1o/hz+IuWdouB62gaVHV0ti5RXb+zW2A8n7R4/9GoyLgDIZ5KG78rq9jHvzswpc+AJY/9AoTU
 MDk/pjymKIYe2bdeIEHpEdxlvVYzq7uzcz+sADeYXuLXiFlC2iYw+fADuF4FVl8oJ8XcZtm0Kcn
 g++4/pU77ar2zqBqRJinzclCM0Gmt8mLYEo73JpmY7KROI9gI87r+fl6Xa6TYif77L1mNXgTczu
 2xPNJmXrHledWJWxtGPALgL/rUxsHrFW3qIhMbTkGfivOjVcKF3N3LZtA+AyZBmNn+mT/d99vpS
 5nsdxZeXRniBjh6NTxWbJJNNt6p9m8YPcwAV+yxyAL4I/NqMydeBR4zRvZfeZ7RO0KATZTCwIgv
 YaE=
X-Received: by 2002:adf:e64c:0:b0:485:8ee5:5ffa with SMTP id
 ffacd0b85a97d-48dba9de8f4mr32149265f8f.38.1792087751089; 
 Thu, 15 Oct 2026 11:09:11 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de7773d02sm14692701f8f.13.2026.10.15.11.09.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 11:09:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/16] target/arm: Use the 52-bit TTBR base address layout when
 TCR.DS is set
Date: Thu, 15 Oct 2026 19:08:49 +0100
Message-ID: <20261015180858.1863407-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015180858.1863407-1-peter.maydell@linaro.org>
References: <20261015180858.1863407-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Fuad Tabba <fuad.tabba@linux.dev>

With TCR.DS set, TTBR[5:2] hold bits [51:48] of the translation table
base address, whatever the OA size. If the effective OA size is below
52 bits, setting any of them is a level 0 Address size fault
(AArch64_S1TTBaseAddress(), AArch64_S1Walk()).

get_phys_addr_lpae() uses the 52-bit layout only when the OA size is
over 48 bits. With TCR.DS set and an IPS of 48 bits, it takes TTBR[5:2]
as base address bits [5:2] instead. A guest that sets them gets no
fault: the walk either succeeds with TTBR[5:2] ignored, or reads its
first descriptor from the wrong address. VTTBR walks with VTCR.DS take
the same path.

Use the 52-bit layout whenever TCR.DS is set, and check the whole base
address against the OA size.

Fixes: ef56c2425e5f ("target/arm: Implement FEAT_LPA2")
Cc: qemu-stable@nongnu.org
Reviewed-by: Gustavo Romero <gromero@redhat.com>
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Message-id: 20261009115728.1299384-4-fuad.tabba@linux.dev
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 6cff52d5921..2e67d02493b 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2107,18 +2107,21 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     descaddr = extract64(ttbr, 0, 48);
 
     /*
-     * With a 52-bit OA (FEAT_LPA or FEAT_LPA2), bits [51:48] of descaddr are
-     * in [5:2] of TTBR, and bits [5:0] of the base address are zero: a table
-     * under 64 bytes is still 64-byte aligned (R_KBLCR).
+     * With a 52-bit OA (FEAT_LPA or FEAT_LPA2), or with TCR.DS set at any OA
+     * size, bits [51:48] of descaddr are in [5:2] of TTBR, and bits [5:0] of
+     * the base address are zero: a table under 64 bytes is still 64-byte
+     * aligned (R_KBLCR).
      *
-     * Otherwise, if the base address is out of range, raise AddressSizeFault.
-     * In the pseudocode, this is !IsZero(baseregister<47:outputsize>),
-     * but we've just cleared the bits above 47, so simplify the test.
+     * If the base address is out of range, raise AddressSizeFault.
+     * In the pseudocode, this is !IsZero(address<NUM_PABITS-1:outputsize>)
+     * in AArch64_OAOutOfRange(), but descaddr has no bits set above 51,
+     * so simplify the test.
      */
-    if (outputsize > 48) {
+    if (outputsize > 48 || param.ds) {
         descaddr &= ~MAKE_64BIT_MASK(0, 6);
         descaddr |= extract64(ttbr, 2, 4) << 48;
-    } else if (descaddr >> outputsize) {
+    }
+    if (descaddr >> outputsize) {
         level = 0;
         fi->type = ARMFault_AddressSize;
         goto do_fault;
-- 
2.43.0


