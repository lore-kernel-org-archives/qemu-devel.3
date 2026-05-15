Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3495CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 10:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNq7R-0000kM-Qx; Fri, 15 May 2026 06:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7E-0000ci-CP
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:01 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7C-0001GC-Ll
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:00 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so99961235e9.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 03:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778842197; x=1779446997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q7ib+7X+yNqrjRobYNQLodZUbFPa/X4O68Oeil12cXE=;
 b=wmZ1Ddh9Nm5njAp5rhdxPBfJjZ8eAMlxBWhTEjTFInPYgVi6PP0QACch9nW6oPErKu
 eTxI0pg0HrYO6Gu5FgAJHRX9tPX8PbQ4dxB1t1siMqWpq0BVIjzDbmOFvCZ0+9YTA+08
 VF+CUCIvE5QVWZK3bpaa+1m7lvthOE9n7Fm+7IZcRK/CKeJ4R0rXLcPpwbMW39Tgbh3c
 HmArYvcF4HGFMkDn5hvsNYgd1fIcaIcOORCeJ7rR2UWqWxFk/TMX+JEpGHL0Z7cetQut
 afRdiHKhFdMoebKV1V7DX6B8ns2A7JS8hobBm2GbXfCxgO2/LVJLl93FyjLQQwn5UUsS
 ziRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778842197; x=1779446997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Q7ib+7X+yNqrjRobYNQLodZUbFPa/X4O68Oeil12cXE=;
 b=PoDNLqTmMpfHRxxk7qlVPY16ZEGiAuahDNQOLmWVOv1S3XX5g+SpsJjY0O7k7H63Ug
 5FqZ89MqqnlkSw63tQ+WnCrflM0rJjw40lD6/VhJXpdc8aVhbG2sGq0F/Ns4LdLpgT/+
 3Gpo3+sdhEeqV98GHAqm4xIb+9hFfEq52UrtQ+vVNOQ9U9dh5GnTKS5M0RbV+VtzS6Q7
 ZyJAPbPAsyY8DNo/FYhwV+W0fRZSKZGLeTSn44mXduCzk7xa1xTDHceV6Wen3ewjQt4r
 FusBkVw/CJOjpx5AddK9upkbEmzMTyKyVu5WClrMZJ8ka6gYQNwY15bQGzbUCo5T9eFY
 66ZQ==
X-Gm-Message-State: AOJu0YzPCuDtNeuKOvZU9K4birGXtuX8CtzjnfTdXN/NSIdayvEZryBe
 mb/3splzx9jVOruwRlInK4c2q5/ED/rC/vlFOffBeF5avXb+AedK95pqALK9WO6kh05GSXhSF01
 KDO4h
X-Gm-Gg: Acq92OHpaI8FJolVEiToPyVPwovlCU5+sVSyrq+nNDMj/nWVEqg8PgACxbcve7S8PJP
 hA8lX+lZjtUo+1zd6ppr7xouSppdJWH8is1fJHPqPGGz5mF7Xkh/W1kIcdpUYuq7ByWpo6XmzAE
 kXtxYlcAvD1W0vespp+XynNjOudkKdhTezc5IQRE8dG1uPTmEHapxvMixEhycJj7r8Fd0gl0+vQ
 FOTZ6bgJsO737KQimQmvt+nHUxLGD5ZJSdUqJblJSueuv5n/jW8/9O+Q/WweHe4+7+3Jb3nbV7F
 IXgoY6NudgQH+ONCIqSmv3LJFlfjaueHtNv2QIQIomDg54vF1p7gJlgMQwfeX45/C0C0TzaKvpP
 xw0x2dn6hxLmXElEpdGgMz4ZP4Q6zGDWtN1i+eQfCzcZew9jNvtcSvh1vcfAHYUR/1bCBpcjvfc
 v1mPGd650/V1a5aAEJskfbnOl5ceDYmg0CZmWy4/51agfrHoHh1B7aY1bh8mKnLxKOw7wU8jUjZ
 VThKaPWHtd8Zox+WN+wCjGLy99/xXGET/qgb0lmmA==
X-Received: by 2002:a05:600c:1f89:b0:48e:526e:101a with SMTP id
 5b1f17b1804b1-48fe60e7a13mr47075595e9.12.1778842196693; 
 Fri, 15 May 2026 03:49:56 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2949asm18194355e9.1.2026.05.15.03.49.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 03:49:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/23] target/arm: GICv5 cpuif: Don't set HPPIV bit in
 GICv5PendingIrq::intid
Date: Fri, 15 May 2026 11:49:30 +0100
Message-ID: <20260515104945.4145203-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515104945.4145203-1-peter.maydell@linaro.org>
References: <20260515104945.4145203-1-peter.maydell@linaro.org>
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

In gic_hppi() we return the current highest priority pending
interrupt in a GICv5PendingIrq struct.  We try to set up the intid
field of that struct to be the form that is used by the ICC_HPPIR
register, which has a "valid" bit in bit 33.  Unfortunately the
GICv5PendingIrq defines the intid field as a uint32_t, so Coverity
points out that the bit doesn't actually fit.  Move the handling of
the valid bit to the callsite, and make this function report "no
pending interrupt" with GICv5PendingIrq::prio == PRIO_IDLE,
consistently with how we use this struct in other places.

CID: 1659594
Fixes: 9edad4ff3 ("target/arm: GICv5 cpuif: Implement ICC_HPPIR_EL1")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260512093856.3197700-3-peter.maydell@linaro.org
---
 include/hw/intc/arm_gicv5_types.h |  2 ++
 target/arm/tcg/gicv5-cpuif.c      | 18 ++++++++++--------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/hw/intc/arm_gicv5_types.h b/include/hw/intc/arm_gicv5_types.h
index eaed42f49f..de4f78a149 100644
--- a/include/hw/intc/arm_gicv5_types.h
+++ b/include/hw/intc/arm_gicv5_types.h
@@ -97,6 +97,8 @@ typedef enum GICv5TriggerMode {
  *
  * In this struct the intid includes the interrupt type in bits
  * [31:29] (i.e. it is in the form defined by R_TJPHS).
+ *
+ * "No pending interrupt" is represented by @prio == PRIO_IDLE.
  */
 typedef struct GICv5PendingIrq {
     uint32_t intid;
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 98238ada19..dd2f696511 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -129,10 +129,9 @@ static GICv5PendingIrq gic_hppi(CPUARMState *env, GICv5Domain domain)
 {
     /*
      * Return the current highest priority pending interrupt for the
-     * specified domain, if it has sufficient priority to preempt. The
-     * intid field of the return value will be in the format of the
-     * ICC_HPPIR register (and will be zero if and only if there is no
-     * interrupt that can preempt).
+     * specified domain, if it has sufficient priority to preempt.
+     * If there is no interrupt that can preempt we signal this by
+     * returning a struct with prio == PRIO_IDLE.
      */
 
     GICv5Common *gic = gicv5_get_gic(env);
@@ -166,7 +165,6 @@ static GICv5PendingIrq gic_hppi(CPUARMState *env, GICv5Domain domain)
         best.prio >= gic_running_prio(env, domain)) {
         return (GICv5PendingIrq) { .intid = 0, .prio = PRIO_IDLE };
     }
-    best.intid |= R_ICC_HPPIR_EL1_HPPIV_MASK;
     return best;
 }
 
@@ -575,7 +573,12 @@ static uint64_t gic_icc_hppir_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     GICv5Domain domain = gicv5_logical_domain(env);
     GICv5PendingIrq hppi = gic_hppi(env, domain);
-    return hppi.intid;
+
+    if (hppi.prio == PRIO_IDLE) {
+        /* No valid interrupt */
+        return 0;
+    }
+    return hppi.intid | R_ICC_HPPIR_EL1_HPPIV_MASK;
 }
 
 static bool gic_hppi_is_nmi(CPUARMState *env, GICv5PendingIrq hppi,
@@ -602,13 +605,12 @@ static uint64_t gicr_cdia_read(CPUARMState *env, const ARMCPRegInfo *ri)
 
     bool cdnmia = ri->opc2 == 1;
 
-    if (!hppi.intid) {
+    if (hppi.prio == PRIO_IDLE) {
         /* No interrupt available to acknowledge */
         trace_gicv5_gicr_cdia_fail(domain,
                                    "no available interrupt to acknowledge");
         return 0;
     }
-    assert(hppi.prio != PRIO_IDLE);
 
     if (gic_hppi_is_nmi(env, hppi, domain) != cdnmia) {
         /* GICR CDIA only acknowledges non-NMI; GICR CDNMIA only NMI */
-- 
2.43.0


