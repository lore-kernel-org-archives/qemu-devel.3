Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4526BC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28Kf-0003qC-H5; Thu, 03 Sep 2026 10:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x28KZ-0003pZ-Ut
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:22:21 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x28KW-0006LS-Vt
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:22:19 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49cd9add88aso15686495e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 07:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788445335; x=1789050135; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SofEA0kMSl55YTMq/QL7igbuZI2km1bjwW02TPvg6d0=;
 b=gBj+0O+7MWWhO9RgVpzmtJGd4j3PIRikC14BQdMDnV4m2/zmqJXmkaGXCyqBSBuiTF
 PBNLlJg0bai8N3Bbs+JqKAaMo8RZwri7GzqJ3P+Vz8IiKrcbxm9JBQFp6LsrX0tlwxvY
 G3AveO5QmQHkZQNqR57TpQCjuPjpZpOJ2O+YyYu5rHszGiJhb0pKEm9UBSNTlqOtyzNZ
 uh1X1yHdxwagEbj/UnvjzB88via6Cq/do1dRzbffa0n/8csJtJBhXS1Z6q5GDMY9ERtt
 thu0sqSOeyBwd6a/TTf3JRlxXZgfF7k0hwnBMtsJzR2622pQY3bUTP9Y2Rvi7dhF3FQV
 vbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788445335; x=1789050135;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SofEA0kMSl55YTMq/QL7igbuZI2km1bjwW02TPvg6d0=;
 b=qPdMo+M4ghv8teS2qcKsuce3yRz7t3NsQ8pDq6MCyh0n1npApFCXtkam4RQyD/3JcE
 pQ9xSBRAnPHcurgvzJbNbm3hknvf13kkZZrYmAYc8TztGqiaoknts0e/aG4b6AHaeoKJ
 svVjEAJ+fY0LhXrqs/qFw+RkkBOBQyEwFha8YB6xrttDcloptZrVjzkeNROpHPHQW9QF
 PMrVBH3MFhlvljJ/ZGQ4cvI5xnJ+WDy3QvSNCu7ljF27SAI4IVK/TOvgnThMJOBz7v2j
 rKaP1cyIncvPeHW56rVlMqSpucCLxXdI7t66v6BoyYIHUpH7EjJszwJ1RtFfEPqogjre
 tfuA==
X-Gm-Message-State: AFuF++k75N9vJqjjjHMQqK+8ZzfWGatC5Gx883qj1hY6Mh7gQd15Cuvs
 CF5nwt2rsoo3QI40FrpZ2YJv95i7r2mFZJwZ9s3oxRbnetA3Kyrm2HWG30EvJSfxh8o=
X-Gm-Gg: AYBFou20pfJUtU5/wayVj3oejv/JjmDu5aQNq4KfTKPWG7RDyRhMZViWohHRL/pZfF1
 H+PsuZdKbYJkxlI8wX3X6OjJkrPZaskLg9E8UinRzRLFqbpmYF4OeBg6zrBoYZiqaclMoKvViIV
 YWA9jNu5J9OhIcf9ZwZD0kKepb54lsPnuBGa5KyzmauE9pbjwa3B/57wlJXgB9/mXlU7cS9vWOA
 yPiAeakWYmWNbnGE4h2UDbSVrHr+YjsvqPaeHtRgdx/Bj/K+faxCN94YItCkitsYrHjF4672hCd
 DhTlkVQmrsRdGB+5mh413kAilC+AO1IOGO8PltTXKs5frSFsi8ZBNX015b5HzO2EWofFEQqMfpg
 WxoAaySmp/5UOSkrdI26gM4TEcPE4Xp6DB7MwnfXMf0asCphJQm2d1TMnFQHzHXjZsTSE1q9vDV
 psDdrq4erxa0KKNXlNCSZYIyQLiQugjFiaZw3hWhk0uNyCYGXnEiav/WH5VS8y
X-Received: by 2002:a05:600c:46d4:b0:49c:ee1c:d582 with SMTP id
 5b1f17b1804b1-49cf5baa0demr6027175e9.14.1788445335348; 
 Thu, 03 Sep 2026 07:22:15 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d1fa6sm82031215e9.1.2026.09.03.07.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:22:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8149B5F9CC;
 Thu, 03 Sep 2026 15:22:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/2] hw/intc: include CPUID for SGIs on GIC HPPIR reads
Date: Thu,  3 Sep 2026 15:22:11 +0100
Message-ID: <20260903142212.1451770-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903142212.1451770-1-alex.bennee@linaro.org>
References: <20260903142212.1451770-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

In ARM GICv2 (and GICv1), reads of the Highest Priority Pending
Interrupt Register (GICC_HPPIR and GICV_HPPIR) must include the
requesting CPU ID in bits [12:10] when the highest priority pending
interrupt is an SGI (interrupt IDs 0-15).

Introduce gic_get_sgi_source() to look up the source CPU ID for both
physical and virtual interfaces, and include it in bits [12:10] of the
HPPIR read value for SGIs.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4402
AI-used-for: initial prototype changes
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
NOTE:
  - the initial patch was more expansive and included re-factoring
    gic_clear_pending_sgi to use the new helper. I dumped that change
    so I could reason through the fix on its own.
---
 hw/intc/arm_gic.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 4d4b79e6f34..181d17ead7c 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -568,6 +568,17 @@ static void gic_drop_prio(GICState *s, int cpu, int group)
     s->running_priority[cpu] = gic_get_prio_from_apr_bits(s, cpu);
 }
 
+static inline int gic_get_sgi_source(GICState *s, int irq, int cpu)
+{
+    if (gic_is_vcpu(cpu)) {
+        uint32_t *lr_entry = gic_get_lr_entry(s, irq, cpu);
+        return GICH_LR_HW(*lr_entry) ? 0 : GICH_LR_CPUID(*lr_entry);
+    } else {
+        assert(s->sgi_pending[irq][cpu] != 0);
+        return ctz32(s->sgi_pending[irq][cpu]) & 0x7;
+    }
+}
+
 static inline uint32_t gic_clear_pending_sgi(GICState *s, int irq, int cpu)
 {
     int src;
@@ -1648,8 +1659,16 @@ static MemTxResult gic_cpu_read(GICState *s, int cpu, int offset,
         *data = gic_get_running_priority(s, cpu, attrs);
         break;
     case 0x18: /* Highest Pending Interrupt */
-        *data = gic_get_current_pending_irq(s, cpu, attrs);
+    {
+        uint16_t p = gic_get_current_pending_irq(s, cpu, attrs);
+
+        if (p < GIC_NR_SGIS && s->revision != REV_11MPCORE) {
+            *data = p | (gic_get_sgi_source(s, p, cpu) << 10);
+        } else {
+            *data = p;
+        }
         break;
+    }
     case 0x1c: /* Aliased Binary Point */
         /* GIC v2, no security: ABPR
          * GIC v1, no security: not implemented (RAZ/WI)
-- 
2.47.3


