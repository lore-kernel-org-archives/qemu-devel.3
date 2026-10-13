Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B14DCA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY6a-0004vX-Fa; Tue, 13 Oct 2026 04:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY42-00007I-JQ
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:52 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3y-00082f-PY
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:48 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a17baef589so22018805e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880845; x=1792485645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xKfVzycXN3xlTRcOP3v+QXWexvZM2B043jlT18XjlT4=;
 b=A8eKHNlBeSKcKJt44bta4eckTmUG4HgoJJzFo5NQg37Ck/+GcEbNssxFoNPPUaeJX7
 b6XaF2zReHCIb+/gdtDIN4ZyQ57pwspvgB+oDJ2Ml98BaxOdcV20JH82B1p0rgF4rzoI
 yn6uDYjgQ3ipqBiQQqa7+xtz8vQctDCw8dUxC8mrnfIt/lwo65szewQYbM9SypuGM23A
 66Ef2VK1VaC2Jbci33kWnLGvieTA5mm1wZyhM6TeOugFsoi76NPoxb7J1Uh+riwqZMBW
 isvkMaVvJ5i4JmQyGn+REWePC1MEu9LCP+ikM8wKOVbEsfi3GtdEbj7xhw66gCmwCLEN
 tuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880845; x=1792485645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xKfVzycXN3xlTRcOP3v+QXWexvZM2B043jlT18XjlT4=;
 b=wYB/mz2HjPqgoTEgZlfsnfZ8bwahyrRyehpzd7vVsiCy3IQD0A6FnhEe3m0TRKZymR
 pbu8dPpQ/qJcAYZtVfcaYEYpxbByYefvgvXZusDVYp0j//SCmtpyPFEGWRSA32fJDPDP
 Jdy+VxcNLkfQiUX/K5XdGLn9gdamfa3gCB3XLmFO0xVjOkyX90u7NLoL0Wl3wPKa61Py
 VUA0AQqWxVQ9tpQdZwyjVPZ4lpprxUOUYDxU0tHJ0vkHOMUkBWl18PS+G55cOsmo5yv4
 o+IP9Ht0S70Hn8xehXMHdnExDeaoRhziM7EY8U2w492rvfSVQ3G1HD80RASNc4PnDlK8
 HoeA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWFuOrh6ayWvzr4RTlys66OCPCS94B4hatBosGaLYnc8AlPtqBUUHiCEv8B26kSzGsdH99OpyebEbI@nongnu.org
X-Gm-Message-State: AFq9FYJUjRzLA9psmWHUn1NNraEvoK1DLGm8mSx2Hbuk2gYA1QMnOyF8
 MDeGtqspk9SZdByQM+MEOQ+Grv17peGB504MOMQt9v9CmHxu7YrkjWY/bztqP2M/6TqIGt0X6Bk
 kUSZ8tMI=
X-Gm-Gg: AYBFou2DLlzcLdrbygU9rAMnI7HgUARgwJ60T6CzJamDgWYpJ7Ci9/p+k3h7dnJVW2O
 5w/2AalvzwPAqPDJIDMVNEVNWvQWvhbWfpZ4yBGsxlHx0IOJn8ne67TXKdHQcOW539M4rqokF77
 /W5WFmcBN/ZBBe5hm/VGd7Ei89r7rSBzyaSRk9tzTqRvqxskZygSMyg+zPEqUEKGm0LCXIavkhd
 a7I3IHy3PcpVLwOUAuk9qsioQPDrgSIjYnVZXwCHNKhI7fNR73a5GqGh63/8HthVMLFTZn8XoEQ
 Po17uS+6YJh2XWZK96Io7zZI3sQ21L7yXeJj244ZPL9Kl6TYBM1gcpG6vSPSX5MVN+rOpqEaMl4
 Cmr1CQVTyhOp5znTB4uT8HfC7a27vhh4XEGzBQy2G/wwn3T5sjqoiRUED3z2WWsWQqsUoPuC74H
 RBi+9LZBAwb1X9D5iqbU6/8yr9NB4nvJh96lon6uoB7IgxKmlmhGCNYIEErcf2iEZx8X860jFKh
 +Yz6/NeYQR6ZIn/V9o3L4SOejgqkKyNe9kOdH9TkPrH5EgOIhoRqzaJ0q6ZvnwaIi/peABN4hKZ
 Pws=
X-Received: by 2002:a05:600c:4fd5:b0:4a0:5b:7bc0 with SMTP id
 5b1f17b1804b1-4a18e49a7e3mr237514455e9.21.1791880845027; 
 Tue, 13 Oct 2026 01:40:45 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 52/86] hw/intc/arm_gicv5: Indicate virtualization in ID
 registers
Date: Tue, 13 Oct 2026 09:38:59 +0100
Message-ID: <20261013083933.1024405-53-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

When has_virt is true, report virtualization support in the IRS ID
registers.  This includes reporting various specifics of our
implementation.  We choose to implement the maximum possible sizes
for VM and VPE IDs.  We don't need to store any implementation state
in the IMPDEF guest memory VM descriptor and VPE descriptor
structures, so we indicate that we have no VM descriptors and that
the VPE descriptor is the smallest size the spec allows.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c                | 40 +++++++++++++++++++++++-------
 include/hw/intc/arm_gicv5_common.h | 25 +++++++++++++++++++
 2 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 289a3afaeae..63e4a165eea 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -75,6 +75,16 @@ static uint32_t gicv5_idreg(int regoffset)
     return gic_ids[regoffset];
 }
 
+static bool gicv5_domain_has_virt(GICv5Common *cs, GICv5Domain domain)
+{
+    /*
+     * Return true if this domain implements virtualization.
+     * EL3 never does; if any CPU connected to the IRS has EL2
+     * then all other domains must implement virtualization (R_KDSPG)
+     */
+    return cs->has_virt && domain != GICV5_ID_EL3;
+}
+
 static GICv5SPIState *spi_for_selr(GICv5Common *cs, GICv5Domain domain)
 {
     /*
@@ -1208,8 +1218,8 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
             /* MEC field RES0 except for the Realm domain */
             v &= ~R_IRS_IDR0_MEC_MASK;
         }
-        if (domain == GICV5_ID_EL3) {
-            /* VIRT is RES0 for EL3 domain */
+        if (!gicv5_domain_has_virt(cs, domain)) {
+            /* VIRT is RES0 for this domain */
             v &= ~R_IRS_IDR0_VIRT_MASK;
             /* ...which means VIRT_ONE_N is also RES0 */
             v &= ~R_IRS_IDR0_VIRT_ONE_N_MASK;
@@ -1223,12 +1233,12 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
         *data = cs->irs_idr2;
         return true;
     case A_IRS_IDR3:
-        /* In EL3 IDR0.VIRT is 0 so this is RES0 */
-        *data = domain == GICV5_ID_EL3 ? 0 : cs->irs_idr3;
+        /* All fields are RES0 if domain doesn't have virt */
+        *data = gicv5_domain_has_virt(cs, domain) ? cs->irs_idr3 : 0;
         return true;
     case A_IRS_IDR4:
-        /* In EL3 IDR0.VIRT is 0 so this is RES0 */
-        *data = domain == GICV5_ID_EL3 ? 0 : cs->irs_idr4;
+        /* All fields are RES0 if domain doesn't have virt */
+        *data = gicv5_domain_has_virt(cs, domain) ? cs->irs_idr4 : 0;
         return true;
     case A_IRS_IDR5:
         *data = cs->irs_idr5;
@@ -1636,6 +1646,7 @@ static void gicv5_set_idregs(GICv5Common *cs)
      * for 56 bits of physical address space.
      */
     v = FIELD_DP32(v, IRS_IDR0, PA_RANGE, 7);
+    v = FIELD_DP32(v, IRS_IDR0, VIRT, cs->has_virt);
     v = FIELD_DP32(v, IRS_IDR0, IRSID, cs->irsid);
     cs->irs_idr0 = v;
 
@@ -1655,9 +1666,20 @@ static void gicv5_set_idregs(GICv5Common *cs)
     /* Our impl does not need IST metadata, so ISTMD and ISTMD_SZ are 0 */
     cs->irs_idr2 = v;
 
-    /* We don't implement virtualization yet, so these are zero */
-    cs->irs_idr3 = 0;
-    cs->irs_idr4 = 0;
+    v = 0;
+    if (cs->has_virt) {
+        /* Our impl doesn't need a VM descriptor, so VMD and VMD_SZ are zero. */
+        v = FIELD_DP32(v, IRS_IDR3, VM_ID_BITS, QEMU_GICV5_VM_ID_BITS);
+        v = FIELD_DP32(v, IRS_IDR3, VMT_LEVELS, 1);
+    }
+    cs->irs_idr3 = v;
+
+    v = 0;
+    if (cs->has_virt) {
+        v = FIELD_DP32(v, IRS_IDR4, VPED_SZ, QEMU_GICV5_VPED_SZ);
+        v = FIELD_DP32(v, IRS_IDR4, VPE_ID_BITS, QEMU_GICV5_VPE_ID_BITS - 1);
+    }
+    cs->irs_idr4 = v;
 
     /* These three have just one field each */
     cs->irs_idr5 = FIELD_DP32(0, IRS_IDR5, SPI_RANGE, cs->spi_range);
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index d8f6f5d5db9..7b24cad211b 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -153,6 +153,31 @@ struct GICv5CommonClass {
 #define QEMU_GICV5_IAFFID_BITS 16
 /* Number of priority bits supported in the IRS */
 #define QEMU_GICV5_PRI_BITS 5
+/* Number of VM ID bits */
+#define QEMU_GICV5_VM_ID_BITS 16
+/* Number of VPE ID bits */
+#define QEMU_GICV5_VPE_ID_BITS 16
+
+/*
+ * The VPE descriptor is IMPDEF in size and contents; it stores
+ *  - the VPE's residency status and location
+ *  - VPE doorbell settings
+ *  - metadata tracking pending interrupts for the VPE
+ * In a real hardware implementation, the IRS will keep its per-VPE data
+ * in guest memory with a cache so it isn't actually doing full memory
+ * accesses all the time. For QEMU we will keep the per-VPE data in
+ * host-side data structures, which don't have any size limitations.
+ * The specification doesn't define any situations where the IRS
+ * must write its state back out to guest memory, except for the
+ * entirely IMPDEF and optional power-management suspend/resume.
+ * QEMU's IRS doesn't implement power-management, so we will never
+ * write out anything to the VPE descriptors in guest memory.
+ * We therefore define them to the smallest size the spec permits,
+ * which is 8 bytes.
+ * (We similarly do not use VM descriptors, but for those the spec
+ * permits an implementation to tell software it does not use them.)
+ */
+#define QEMU_GICV5_VPED_SZ 3
 
 /*
  * There are no TRMs currently published for hardware implementations
-- 
2.43.0


