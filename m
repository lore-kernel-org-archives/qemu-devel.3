Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC36CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUfk-0000Vd-OV; Tue, 29 Sep 2026 06:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUfT-0007ni-UI
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:39 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUfS-0008Hw-1C
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:35 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-48449f62b93so1399865f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676153; x=1791280953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TyMW0ZAAuoKu8FHoW3hDyWiT/1WS6EoSeNzA0D/3CTE=;
 b=bYRTw7DLoxNeLEq5avaA8XRpIK31UGDnXkEmF2KjsKTtLBxSe4w33ZUSYab7FrXIJO
 cvgVJwKpIgayVEq8GjnoPgzlyCnSCl+we55V9VU34lycXWGQ3DcVBpWwVHN8RIk9CFnM
 hZjTiEDOsBxbGypE9o2r63krQplNF098yRuPskuhHJYroZTdmd+UgCIMkQTxUo3YuUwD
 DXb9wBHqQrrDeRFTytNWdepOUmt0AGxSrZS2hKVmAFAHyFcJz1+MQtEHmMArEk683R0M
 w/niRxRzXCbP1y49eSg/2tqmO2JUXZQcERB9z4AL8fM+dJnY0un/e6Yw1rtan6EhSmkC
 yoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676153; x=1791280953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TyMW0ZAAuoKu8FHoW3hDyWiT/1WS6EoSeNzA0D/3CTE=;
 b=VtlMYAGoFSEtnFoxo2aPLZO8ehx75AjDADw+oXZPYZ+0S+qpHTasaNoJWLu5oYSz//
 RQdJdf2ioywkH0DfIV665qlErLmtXJmJ7FbV7C+yawS1CaaXSqfzAVYqslVQIRIgkoQK
 2eT5mrzkpdbWI1qQNRq6nW2Nt7jrC9PWPlp4UA9dBQyP+tRDLZafzwMCBLFviMcnmWwu
 aVJSeeDmhZ5JCJzKnR3cDAyHsLGdeTDMbhBpEBWcrvjsAuProouhSEDEjGiJk3UMxbxt
 5RmnAR/83zIq/u+cy08TSgYItAUsOWrvLMyjENrkIKdrN9Xo6OYe0m0AvBO4ELVTSzlf
 XVMA==
X-Gm-Message-State: AFq9FYJvDajOV0tl5G6aL/+JvUl8vtwkRC0LttwoP3xwZkG4sWWIh6F+
 gQYJ9TI9XHjdTO/vIhqpvS0CNOPDzZFkSCeLR/KuIJ++3+h0HQUDmeNRWuaF6tvkPCWl+5o+9ji
 +FHq2
X-Gm-Gg: AYBFou1KVPvBm24Rlfju9slhNNkXKI8V79V9r5NJNTEcX7V+k3mvjw1vXJSv5vRc2n+
 TcOLMNbVQ+n5EK0NcAT4lZ7doZuaI8YxAfy1OVf9tY8dvJAD+k5VI8Urc2OZZSJgpid2WHbdxt3
 WkrHmn9PLm1mL8+SEV0PJ7H+9A2CZIGf7UdCVqytHj8oJNi+Db8vnT2XWo8uqQd36cuhY8bYrDV
 KDRFC6iODdUK1TXetFUhfMpTdklpmk2UwcgtHIde2lBG1LcnMykJaRU9avNZ5doklQ0VAVyD7n5
 mrWwNoOsDOCnxg+U/n/B1+l08pdMgVKiOiQskP7ZGpfaklc8ufcOCdaRAeR7L9OjtrvhUFoUCya
 wulyhqJH8mpByzGCNMEoN/qDuMpIOrHFjmiCzORIEyMN5uEBmHEnFLiFof6bM710AFNOvstHMA1
 Y8MZkkc+tdyPqeVPG75f1RBk+VKxIbLPdhfOFk0Xubf8cVGcNhHVHhCaolAASqbVuX6rvsYae6I
 GbudZ9uU6vTCqVHcfxIXf+ZY3cr6KyykXHvN+hSCupmchbddXjwzUDzYAjlWBidY0l9L3G54foT
 zks=
X-Received: by 2002:a05:6000:240e:b0:487:13a9:80d with SMTP id
 ffacd0b85a97d-48af1ac8c4amr3993480f8f.10.1790676152489; 
 Tue, 29 Sep 2026 03:02:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.02.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:02:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/37] target/arm: Fix next timer tick when the offset puts the
 count ahead
Date: Tue, 29 Sep 2026 11:01:31 +0100
Message-ID: <20260929100133.2598676-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x10.google.com
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

gt_recalc_timer() arms the timer for the ISTATUS 0->1 transition at
count == cval + offset, treating an overflow of that sum as "beyond
the counter's wrap" and arming at INT64_MAX. That reading is valid
only when offset <= count. When offset > count (a CNTVOFF_EL2 or
CNTPOFF_EL2 that puts the timer's counter ahead of the physical
count), the sum overflows for every cval still in the future and the
wrapped value is the correct next tick, which is what the code used
before commit 8d37a1425b99. The timer then never fires on its own.

A KVM guest whose counter is set ahead of the host's, as the
arch_timer_edge_cases selftest does via KVM_REG_ARM_TIMER_CNT, gets
its timer interrupt only when the vCPU is next loaded and KVM
rewrites the timer registers, so a guest polling for the interrupt
hangs.
Reproduced with VHE, nVHE and pKVM hosts on QEMU 11.0.0. The test
passes on hardware.

Test count + (cval - (count - offset)) for overflow instead, so only a
physical count past 2^64 is "never", and add a vtimer test case with
an offset that puts the count ahead.

Fixes: 8d37a1425b99 ("target/arm: Handle overflow in calculation of next timer tick")
Cc: qemu-stable@nongnu.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Message-id: 20260921074451.3158645-2-fuad.tabba@linux.dev
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c               |  9 +++++----
 tests/tcg/aarch64/system/vtimer.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9a90ab68071..ff0b766b73d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1692,11 +1692,12 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
         } else {
             /*
              * Next transition is when (count - offset) == cval, i.e.
-             * when count == (cval + offset).
-             * If that would overflow, then again we set up the next interrupt
-             * for "as far in the future as possible" for the code below.
+             * cval - (count - offset) ticks from now. If count plus that
+             * overflows, set up "as far in the future as possible" below.
              */
-            if (uadd64_overflow(gt->cval, offset, &nexttick)) {
+            uint64_t remaining = gt->cval - (count - offset);
+
+            if (uadd64_overflow(count, remaining, &nexttick)) {
                 nexttick = UINT64_MAX;
             }
         }
diff --git a/tests/tcg/aarch64/system/vtimer.c b/tests/tcg/aarch64/system/vtimer.c
index 7d725eced34..e1cfad36be1 100644
--- a/tests/tcg/aarch64/system/vtimer.c
+++ b/tests/tcg/aarch64/system/vtimer.c
@@ -27,6 +27,7 @@
 
 int main(void)
 {
+    uint64_t freq, now;
     int i;
 
     ml_printf("VTimer Test\n");
@@ -44,5 +45,32 @@ int main(void)
         ml_printf("%d: cntv_cval_el0=%lx\n", i, read_sysreg(cntv_cval_el0));
     }
 
+    /*
+     * An offset that puts the virtual count ahead of the physical one,
+     * so cval + cntvoff wraps for every future cval. The timer must
+     * still fire. ISTATUS is set by the expiry, so poll it with a bound.
+     */
+    write_sysreg(cntv_ctl_el0, 0);
+    write_sysreg(cntvoff_el2, -(1ULL << 60));
+    asm volatile("isb");
+
+    freq = read_sysreg(cntfrq_el0);
+    now = read_sysreg(cntvct_el0);
+    write_sysreg(cntv_cval_el0, now + freq / 100);
+    write_sysreg(cntv_ctl_el0, 1);
+
+    ml_printf("cntvoff_el2=%lx\n", read_sysreg(cntvoff_el2));
+    ml_printf("cntvct_el0=%lx\n", now);
+    ml_printf("cntv_cval_el0=%lx\n", read_sysreg(cntv_cval_el0));
+
+    while (!(read_sysreg(cntv_ctl_el0) & 4)) {
+        if (read_sysreg(cntvct_el0) - now > freq) {
+            ml_printf("FAIL: ISTATUS not set within 1s: cntv_ctl_el0=%lx\n",
+                      read_sysreg(cntv_ctl_el0));
+            return 1;
+        }
+    }
+    ml_printf("ISTATUS set at cntvct_el0=%lx\n", read_sysreg(cntvct_el0));
+
     return 0;
 }
-- 
2.43.0


