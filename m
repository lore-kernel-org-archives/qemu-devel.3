Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE56CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY34-0006q3-FK; Tue, 13 Oct 2026 04:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY32-0006oN-5k
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:39:48 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY30-0007ZT-IT
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:39:47 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48b0584ad71so1495305f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880785; x=1792485585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=g6OTnu60gLipqvPEMbn84dPOVj5s3bqVLHK6HOE+ziE=;
 b=w6bb7OkToceIyPRh62U9U4/+LkSX2oADBjxIsyx9r4SgZyXZv2xqSu3fIl6r8ikXMv
 ir1gfmzVF8oDqwIJ5xAqEpmuuB/Z7cfYfwkJobBsu0YZO/mFYDt7aRHp8O9McBeVRSxq
 zVMd8JcMl1g4TAByxBD35QW42gmpoJqDddLpvl0ZdKakxAd1Q30UOKVhJB6oPrXZSPKl
 qoB8qb4bBkIc2ukvbdfsY4yicFObJVovexLPmSvw8s+j4izy0cf4KIQQTQyoSNO7P4oq
 XT5CcwceOQ8D4DC8XOzlqXF9DrhTaK3qJRSPoAsbKCln9CEk85ieftjATrCNPjJmxB7x
 lc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880785; x=1792485585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=g6OTnu60gLipqvPEMbn84dPOVj5s3bqVLHK6HOE+ziE=;
 b=F7f0MVkEjqEcvy6giPQDkAYNZAhLP1yzVK9S6P5S70BcZZKeXKz6AsEZ7LR5oo/c5I
 HckCmjMtZQMjaZCp20hO3gERu42x2gP9HMNdmwvK1PgWSqGfB6WBs7dKFM/agzkmhw6z
 JZTQBMOc9vNjRZlPq92pAvaZT0rVKZ2VYHTx8wVN1aQYryq7v00OvJZD260YN4KcADYn
 gouTjCnUDbUgGxsqE1Md+TzVfpIh2OsO2CnZF3iXJi6equLEi5lWyAZ7/OCbijpW2wfU
 SxpmRZmzdDtHAIqNMoSOn7GsATQ2UbFxvn4K+8uS1JeYXE3wjAjhbs1CG9aX/BZHsYV/
 9Tqg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBZsaLCUqIx5SdC6z5ZfqtD4GtanasSRZV+TDG9wSjiy1rdUL2o3nCIAizMuQDzTWMeTTKbfHvTja4@nongnu.org
X-Gm-Message-State: AFq9FYKC4IgU4haLDs9k8hs7Ou02wpdEATaLOjwtpZgvUQkLFnZ9UV3q
 2QuGEjFcCGbu/RLoB0BvPODz5zFmktpY5y9jTpB0HpwadBfmNnYjmDFTYs4gq0XyHz4=
X-Gm-Gg: AYBFou2JAx+rnlf8RF1rnGgJ60qxG9Id4xY0A93keAyeO2ucCfni+MWhNpDIAJEKb9g
 IpttBvqY3Tkk3YfMNmuxQQFvL6KxYZZQx/QTMSvBALf3mBc3iRWngDT+eHpdQpcwzZxxM2giQ5T
 iLs68JOLbr08kuxcF3p7wDQPVQqzcl/85AGh30JidHzVd3YPQ2qb+iUQtpPBYYJi1SV55Wh1cS3
 p4y4cmHVV5BZZNn4T6Z2ZT8roY3Qe080ahl/wdrn3YVSX9k7ads2VVq/z4Mjvl8ggGM513Xzdau
 c1tbX9l31kaMxntPxnhY20Bmi0t2oyWKxPpwV0x1FAqea0TZ/bCmZRURYhstAZ0mAqu40DYsG7g
 DBvdVAfzFqvvuUfqz6qwCdqfp/kw0/ijB4xIaRjyKLHbfiaeJ9avBtRYGZLxzP7b+jwarQbB8XV
 SwzJzl/0yRZ4tYJagUGOMDjKpVlUqKO9pYB8QGPlwOw54xTgKjPY7SpIcpIj3lrZ5nM12FePHBI
 E/jTx7ezkqiWvd+x24taOBdyc4IuPfKkXq9a9fVuHLP5JXEUpi6JIb/oixfrunAPSQzTyLHd0X/
 qmA=
X-Received: by 2002:a05:600c:609b:b0:49f:ce78:356d with SMTP id
 5b1f17b1804b1-4a18e4c9944mr219993375e9.30.1791880784696; 
 Tue, 13 Oct 2026 01:39:44 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:39:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 05/86] hw/intc/arm_gicv5: Use cached IRS_IST_BASER.VALID state
Date: Tue, 13 Oct 2026 09:38:12 +0100
Message-ID: <20261013083933.1024405-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When the guest writes to IRS_IST_BASER we effectively cache the value
of the VALID bit in the GICv5ISTConfig valid field entry.  In a few
places we check whether the IST is valid by doing a bit extract on
the register value; switch those to look at cfg->structure instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index d354ac6b992..ca5c3ca6e03 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1223,8 +1223,7 @@ static void irs_map_l2_istr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
     uint64_t l1_iste;
     MemTxResult res;
 
-    if (!FIELD_EX64(cs->irs_ist_baser[domain], IRS_IST_BASER, VALID) ||
-        !cfg->structure) {
+    if (!cfg->valid || !cfg->structure) {
         /* WI if no IST set up or it is not 2-level */
         return;
     }
@@ -1294,7 +1293,7 @@ static void irs_ist_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
 {
     GICv5Common *cs = ARM_GICV5_COMMON(s);
 
-    if (FIELD_EX64(cs->irs_ist_baser[domain], IRS_IST_BASER, VALID)) {
+    if (s->phys_lpi_config[domain].valid) {
         /* If VALID is set, ADDR is RO and we can only update VALID */
         bool valid = FIELD_EX64(value, IRS_IST_BASER, VALID);
         if (valid) {
@@ -1605,7 +1604,7 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
                             deposit64(cs->irs_ist_baser[domain], 32, 32, data));
         return true;
     case A_IRS_IST_CFGR:
-        if (FIELD_EX64(cs->irs_ist_baser[domain], IRS_IST_BASER, VALID)) {
+        if (s->phys_lpi_config[domain].valid) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "guest tried to write IRS_IST_CFGR for %s config frame "
                           "while IST_BASER.VALID set\n", domain_name[domain]);
-- 
2.43.0


