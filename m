Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC03CCC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPtO-0003qE-VT; Thu, 15 Oct 2026 14:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPtC-0003lf-DH
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:14 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPtA-00010c-86
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:14 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48b042c0759so4161066f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792087749; x=1792692549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Y5YLQ6yN624mqbAF9NZG6hkdoe0QS+nA5gfqzyd3bmM=;
 b=u1CpgLyS4SYWfDudR6/zv1rj2Z3hd9qbV+4MCJH9odyt+2Q/TGOu2GUQyqKTt9FTDd
 LYbpqSm3IjeZghdLzxAdmE29ppOCimVqsrNw0SZcr6tknez4R1hGrWVZkil81cbWWHzk
 y+Z9D8QAFDbYqyZSn9e9fYDBipq7+QfR1InkL5WbhD/l7a99ZYSSVLZLUZuYml+HHJk6
 vZnlbOgMahaShEJuEo4xnH3a2VN0TYzxiUGu0FrdVj/S/8YFPHcBbXGh+Lgx675cAtJJ
 xIaadwxsz7GoJ2jeo7FIuzcwYEzjKpE3O9THoDENOYphvWcm13Fv6c01oK/9WW0v2Y3F
 0yjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087749; x=1792692549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Y5YLQ6yN624mqbAF9NZG6hkdoe0QS+nA5gfqzyd3bmM=;
 b=iKkMjXpMjBmc38nHjzclvvQ10MW1Wo2spjPVifR1yr9s3rFxedayOgMfqZrlYwpQEc
 fUoYUxzqwhD60yx5e8MFNGIY+A7p4RI6a7vvYrIR2vqOA7Xe0zDgV0TOwoomboXd2iiG
 TKJjQS97ytgeQcgchtiQZ5TI57U1Y8hK5xZDDWbJEwGE2e6WRax7B9xTd4mPIxl+6XyZ
 tc8fhjqUBp7R9pOOIoap8ryE1uanMSst+mvXauX9dfzWu1V8fKsuyZEMEiJx+y4/Hkny
 5JLzwJ0JbKHrykG2dzaqM0PXs6TtV1B4o+SBJvha0cU8LnAtTq0FiM/WV8sjs500zoTn
 RGug==
X-Gm-Message-State: AFq9FYIbf7ekkkkWxK3c14fnIBmvbRbDEv7ojZzgnyoJFsmyKtdSUHX/
 hXUHLROayKBEIbDmj/8fSEFIibBAHMqYDmnLVsnAyhkDkGLKVH5K29qN/d2sA+U6ODWeWfoUMFb
 XGjvuISM=
X-Gm-Gg: AYBFou0XVQlaFHEPk85klAIUUcyJROf7TXEfux1d0M4EpP0mUM2UevGXSyY9u0te7hR
 ehRLf5Zmz0SRU5nrDOWgkMi1dPX4r5BkN3F4PE/h8zth9vlH1BnvELmxmDsDNeKO8rgu1XqwdXS
 mMV9InkJqqIJ4SIwKvO/8VVqiy2BFpOfYy9aXCrVWdAWjasGkwD+n3PrfSYF1XKJ3Ky1IfzMily
 IimTa2R10ezvsUPeJsvCT9UzcSiolzKmZ+rYu3O9SEavnFOWY4f4RQU1WqhZf7ht+BFK9Q5X1zW
 YmuPPMxa+n/dbdLy3YpryWK/tLqT/+UTI6Bz2teTnY/KXhZO4LiKqv+eqRqlGBipu8JN0DYkYBp
 YtEcvgJPdjqOed5LKjD7alKbbDq7EgqkF3UZxL7e1NGkM8+8CXQ03QjeviHgi5I6Ruk/mVYNYj/
 cSlRGbWscD3quozs5wv8d9/WW9IQpPV3V9wuTiu0Kd36kq2yRXK4If1sH84mMieOi2sSF9tny7F
 GzX5TiBQ7rSNqcog9x8TmIZZqZrplFKIE2/z5fsBVEQ38WtBvAOdU24IsF5LQBqzdddRS2uoZ1R
 IJhI
X-Received: by 2002:a05:6000:40cc:b0:48d:fbdd:adc0 with SMTP id
 ffacd0b85a97d-48dfbddae6dmr1082197f8f.5.1792087749192; 
 Thu, 15 Oct 2026 11:09:09 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de7773d02sm14692701f8f.13.2026.10.15.11.09.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 11:09:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/16] target/arm: Clear TTBR[5:0] from a 52-bit table base
 address
Date: Thu, 15 Oct 2026 19:08:47 +0100
Message-ID: <20261015180858.1863407-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015180858.1863407-1-peter.maydell@linaro.org>
References: <20261015180858.1863407-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

get_phys_addr_lpae() can read the first descriptor of a walk from the
wrong address. This happens with a 52-bit OA when the initial lookup
table has fewer than eight entries and its base address has bit 51 set,
or bit 50 for a two-entry table. The walk then faults or translates
through whatever that address holds. VTTBR walks for stage 2 take the
same path.

For example, the 16KB granule with a 48-bit VA has a two-entry level 0
(FEAT_LPA2). The 64KB granule with a 44-bit VA has a four-entry level 1
(FEAT_LPA). KVM's page_fault_test hangs on this in its 16KB, 52-bit PA
guest mode under TCG, as reported on kvmarm.

With a 52-bit OA, TTBR[5:2] hold bits [51:48] of the base address. Such
a table is 64-byte aligned (R_KBLCR), so bits [5:0] of the base address
are zero. get_phys_addr_lpae() ORs TTBR[5:2] into bits [51:48], but
then clears only the bits in indexmask. For these tables indexmask
covers fewer than six bits, so TTBR[5] stays in the address, and
TTBR[4] too for a two-entry table.

Clear TTBR[5:0] when forming a 52-bit table base address.

Cc: qemu-stable@nongnu.org
Fixes: 7a928f43d872 ("target/arm: Implement FEAT_LPA")
Reported-by: Itaru Kitayama <itaru.kitayama@linux.dev>
Reviewed-by: Gustavo Romero <gromero@redhat.com>
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Message-id: 20261009115728.1299384-2-fuad.tabba@linux.dev
Link: https://lore.kernel.org/kvmarm/B4C0AC3E-6A4F-4A7B-B7BC-81207539115E@linux.dev/
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index de0435a58b8..6cff52d5921 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2107,13 +2107,16 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     descaddr = extract64(ttbr, 0, 48);
 
     /*
-     * For FEAT_LPA and PS=6, bits [51:48] of descaddr are in [5:2] of TTBR.
+     * With a 52-bit OA (FEAT_LPA or FEAT_LPA2), bits [51:48] of descaddr are
+     * in [5:2] of TTBR, and bits [5:0] of the base address are zero: a table
+     * under 64 bytes is still 64-byte aligned (R_KBLCR).
      *
      * Otherwise, if the base address is out of range, raise AddressSizeFault.
      * In the pseudocode, this is !IsZero(baseregister<47:outputsize>),
      * but we've just cleared the bits above 47, so simplify the test.
      */
     if (outputsize > 48) {
+        descaddr &= ~MAKE_64BIT_MASK(0, 6);
         descaddr |= extract64(ttbr, 2, 4) << 48;
     } else if (descaddr >> outputsize) {
         level = 0;
-- 
2.43.0


