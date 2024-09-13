Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32AEFA375A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp818-0005wu-O9; Fri, 13 Sep 2024 11:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp80F-0002TR-9N
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:31 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp80D-0007pg-G0
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:30 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42cba0dc922so18585435e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726240468; x=1726845268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wxR0xCz35b/wqsAjmukGKdOmyR9BCiHQy2UElwsB5Yo=;
 b=UWZ92ArLcbnzNELc7l3HBQVbHq5pKXjYJqWZ/CIgkGWp+1OL8wntxWutXyJAQ57xRs
 zXJsfe/IwE/PStY08FwTZZ6sqPtKwNtWjQHs+6lsF7WzOqn2Fv4caQsMM9IL7OBXnSWv
 21MdHrnJu1Ndfmg4TVcERXLOhYUmWsceTaRZcDw6E6lS9JtBtMZ4sMvQHjcQb1n2NHhl
 wjFPEKRx0nak+HdJ5TBhxVPmXHkNeB1I8EjebJbN+ki+ZtkhJQvFmN8tBqWxBAACJyFO
 68Tu/af7g3TQrucK9hdT6OXkZev1U3DZw8E7Tfn9aJoPf0wVTGW4z26b2R/kDUyOfkLq
 diqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726240468; x=1726845268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wxR0xCz35b/wqsAjmukGKdOmyR9BCiHQy2UElwsB5Yo=;
 b=G+OCWSrcIaKo02tgKRf3lxORnVWzZsbBDV+fqMtfTkaz8YKUMl3fuHl0OsXajIGV3P
 +NZxILvlROhuzg/uBhFW9xZuAACPfKm9vBM75umOAn7mcoHnyDL/6v2IgUKfaCmaiRTi
 GzdE2hfK0qcxVN1R0cOAc/lQoKNX2OxS1x/im6FAdfwvGVu8p/hWK+jPa8BczVrlOPUZ
 4nLa3Aqubc1U9I2q+s68AUUIm6EfZh64ivScW3xAE9mePQmzPMuJWENc7TnfCfLFQXKc
 ndBXyrOvgzF+y/wyMRc1YFqa5AbwJ2A8KRSmMvc3uetc9cwVN8epeLP0ibUueQ92xo0h
 mR0g==
X-Gm-Message-State: AOJu0YxPs4lrOO32reaHbTuKqWp+xdpxOM8rOUPwOJNKVQbnR7ouLUga
 P7IlVJrlN+GUNJAHpxFx3EZhZOy14rKYcwsdQiIaLeJzpdeCL1ysu5K9y53ml1zkHVEUE5WQ7v1
 +
X-Google-Smtp-Source: AGHT+IFcCsJqUotusT7sXKVfK25NIESJHZnYqlAE6/NdOCAbpPcSUVjg3fLzFmOTZCInlU/IhnBRWQ==
X-Received: by 2002:a05:600c:1e1a:b0:426:5fbe:bf75 with SMTP id
 5b1f17b1804b1-42cdb567190mr52002775e9.23.1726240467579; 
 Fri, 13 Sep 2024 08:14:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b16bfbfsm29152325e9.22.2024.09.13.08.14.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:14:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/27] hw/intc/arm_gic: fix spurious level triggered interrupts
Date: Fri, 13 Sep 2024 16:14:11 +0100
Message-Id: <20240913151411.2167922-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913151411.2167922-1-peter.maydell@linaro.org>
References: <20240913151411.2167922-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Jan Klötzke <jan.kloetzke@kernkonzept.com>

On GICv2 and later, level triggered interrupts are pending when either
the interrupt line is asserted or the interrupt was made pending by a
GICD_ISPENDRn write. Making a level triggered interrupt pending by
software persists until either the interrupt is acknowledged or cleared
by writing GICD_ICPENDRn. As long as the interrupt line is asserted,
the interrupt is pending in any case.

This logic is transparently implemented in gic_test_pending() for
GICv1 and GICv2.  The function combines the "pending" irq_state flag
(used for edge triggered interrupts and software requests) and the
line status (tracked in the "level" field).  However, we also
incorrectly set the pending flag on a guest write to GICD_ISENABLERn
if the line of a level triggered interrupt was asserted.  This keeps
the interrupt pending even if the line is de-asserted after some
time.

This incorrect logic is a leftover of the initial 11MPCore GIC
implementation.  That handles things slightly differently to the
architected GICv1 and GICv2.  The 11MPCore TRM does not give a lot of
detail on the corner cases of its GIC's behaviour, and historically
we have not wanted to investigate exactly what it does in reality, so
QEMU's GIC model takes the approach of "retain our existing behaviour
for 11MPCore, and implement the architectural standard for later GIC
revisions".

On that basis, commit 8d999995e45c10 in 2013 is where we added the
"level-triggered interrupt with the line asserted" handling to
gic_test_pending(), and we deliberately kept the old behaviour of
gic_test_pending() for REV_11MPCORE.  That commit should have added
the "only if 11MPCore" condition to the setting of the pending bit on
writes to GICD_ISENABLERn, but forgot it.

Add the missing "if REV_11MPCORE" condition, so that our behaviour
on GICv1 and GICv2 matches the GIC architecture requirements.

Cc: qemu-stable@nongnu.org
Fixes: 8d999995e45c10 ("arm_gic: Fix GIC pending behavior")
Signed-off-by: Jan Klötzke <jan.kloetzke@kernkonzept.com>
Message-id: 20240911114826.3558302-1-jan.kloetzke@kernkonzept.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: expanded comment a little and converted to coding-style form;
 expanded commit message with the historical backstory]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gic.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 806832439b4..2a48f0da2fe 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -1263,9 +1263,14 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
                     trace_gic_enable_irq(irq + i);
                 }
                 GIC_DIST_SET_ENABLED(irq + i, cm);
-                /* If a raised level triggered IRQ enabled then mark
-                   is as pending.  */
-                if (GIC_DIST_TEST_LEVEL(irq + i, mask)
+                /*
+                 * If a raised level triggered IRQ enabled then mark
+                 * it as pending on 11MPCore. For other GIC revisions we
+                 * handle the "level triggered and line asserted" check
+                 * at the other end in gic_test_pending().
+                 */
+                if (s->revision == REV_11MPCORE
+                        && GIC_DIST_TEST_LEVEL(irq + i, mask)
                         && !GIC_DIST_TEST_EDGE_TRIGGER(irq + i)) {
                     DPRINTF("Set %d pending mask %x\n", irq + i, mask);
                     GIC_DIST_SET_PENDING(irq + i, mask);
-- 
2.34.1


