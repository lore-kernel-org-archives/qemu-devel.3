Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998FACC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY4h-0001np-7o; Tue, 13 Oct 2026 04:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3j-0007oi-D9
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:31 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3h-0007ww-5C
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:31 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a171b677d2so15779785e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880828; x=1792485628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EEvv5QuQZixZDbJ9DHZNjQdel6lxSlPk/jCh6hqlfL8=;
 b=oaqfxgiDpRXduVgGS0OpsqBac61LPo+Yt4DII59PB+PmUvazahzmbmgxfY4phDTH1V
 QCOJfXR4yNj9+3ZzDT/tZB/zlrX/p3EvfGZVGRhfk5u5mKMW2cXKC3PMqOxXzDnbwsjU
 y+cYYEIj4gYxd5xLaYtXFL//9TmFKyn8fakb47blF4l00qX3s8Pxpwxiut5GcumQw56/
 nGz9aKr+vhgAakBAwcJp7dwkFAaZamVn8jnrkHRV45buSqutNn1Y9CYNEODiBhXfieu1
 iXaMU/5raZFSB1C4+ramVFLiqBu5WnAPm7p7xFiUUK197zZ9lvcLSvDK+d4iRw0rcf1e
 bhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880828; x=1792485628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EEvv5QuQZixZDbJ9DHZNjQdel6lxSlPk/jCh6hqlfL8=;
 b=t5rVaC2GFuQabLImLMogYvTWv+1IsdBUJGdRZeiTge6FYBNPR6ZqinHu+JJAxGdyQ8
 A3q2eZAX+xdtBBjNVEfkoQ27Rk5ATChI2E+2F+ffqNqF/SrjhsLixGOYRK9WvwZzNZSN
 3DTjZcvgYtYU6qfk22KwBvig3Azh56HEGcvT4kiVp6M7IHrgw83QXjRoJ9Jos2FEkmpc
 8PpAGVPRCRlY9pjKV+aze/ZLe7Ft2APgwooJtsRjRxmh7FZJMbjB/EVWDkTeYcIacPoG
 tLHmbFNOtD+pJpiTl5YBZrKTvEbVSgQ78kuArE3uW8gWnPGjfPt7QEdJtMPyWIg78heE
 IPDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/HdnAgNet82zDtpYhnMhnMvdxAD+uyLnNjUuAp6pJqjp2xD+WmY3hg9YPGUfgtYz1M+s1m8JNnJaM@nongnu.org
X-Gm-Message-State: AFq9FYLEn2rKxYzBIEEM2XSmeJtJUmeHEZKlDLJwxeuPimx/F1skaAAq
 wbrKW5H5/Z+96RRjcOHGwGJtysx+4LbPzp0S0VHQSO+FICrII8+ml9M+DwfhQxNq4CjfCZWQSiR
 BTNX93qA=
X-Gm-Gg: AYBFou2F6MX8dh/EafYiAfvtw3KaeLzxyH+hXynIqQHKxISEUC1kcMqmE7d/uL+cFe/
 Aym3kBK4FH/Fcrs85Mhp7y+VT7a5eABls8OVF3l0p6tR+46Jai3Mx4k3q8FK2G5BMIvlAt8LhiE
 UCje7RBzGwra5X79SoLoDrbJhgqEw3rNgS0pTPGYUwReu6t9EVbzQoKiDlKkywcucqSDmbi2cGA
 jpunI6uWfDy0NYJTS9ETM/pu2hUSxK9knYNBK9J7esC+O/fxgfcpr7xynwWL9TUwMlyfjdGVYnH
 Hg6br/nXBLtKS0nDp1X7PZAN3US8008+xrFsMLHq2h6/voEBNitb95ql4xLAPNlw4qL1h1iAAv3
 8395gmIndcVnn3aRlgYJhjg1Rq74Q52WOKm+7YBeegN+s6/nC5ZQi8TPRVTDU8E0TXZPcwq4Rtr
 dnooWHDOJA0LBHuE8wTyThr+3/BsrWo6hhT9RQfJql7N+K8V7DHXCcKKfGDbhR97mgs6w5VjXds
 BUCBG0j/YEGqtdr6Ohsar8wqm229afOXurP/uunnUMewjGmwkGYxDNOUCwTLzg+znIfNRK4LsUB
 U1Y=
X-Received: by 2002:a05:600c:4ecc:b0:49c:fa21:e749 with SMTP id
 5b1f17b1804b1-4a18e4d55f2mr264357825e9.31.1791880827229; 
 Tue, 13 Oct 2026 01:40:27 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 37/86] target/arm: GICv5 cpuif: Handle LD/VD insns when
 setting domain/virtual args
Date: Tue, 13 Oct 2026 09:38:44 +0100
Message-ID: <20261013083933.1024405-38-peter.maydell@linaro.org>
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

GIC system instructions come in several families where the prefix
of the name indicates which interrupt domain they operate on:

 - LD* commands (opc1 == 6) operate on the logical interrupt domain.
 - VD* commands (opc1 == 4) operate on the virtual interrupt domain,
   which is the domain of the current resident VM, which is the same
   as the logical interrupt domain but with the virtual flag set.
 - CD* commands (opc1 == 0) operate on the current domain, which is
   the virtual one if ICC accesses redirect to ICV, and the current
   physical interrupt domain otherwise.

The actual operation of the command in each case is the same apart
from the domain/virtual parameter selection.

Currently we hardcode "virtual = false, domain = current physical
interrupt domain" in our writefns for the system insns, which is
only correct for the CD* commands when virtualization is not
enabled.

Generalize our code for implementing the various GIC system insns so
they call a new function gicv5_domain_for_insn() which sets the
domain and virtual parameters based on the insn family (which can be
determined from the system insn's opc1 field) and whether the virtual
CPU interface is enabled.  This will make the CD commands work
correctly in the virtual CPU interface, and will let us use the same
writefns for the LD and VD insns as we do for the CD insns.

This change is all we need for the CD* commands to handle the virtual
interrupt domain correctly in most cases; the commands which don't
simply pass the argument through to the IRS (CDEOI, CDDI, CDIA,
CDNMIA) need further changes which we will handle in the following
commits.  VDPEND also needs adjustment as it has an extra argument
from the guest to specify the VM (making it the only LD* or VD*
command that has a different field layout from the CD* version).

(The IRS will currently reject any commands with virtual=true;
we add virtualization support to the IRS later in the series.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gicv5-cpuif.c | 71 +++++++++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 18 deletions(-)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index cbe233c61bf..f8d58b5a537 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -154,6 +154,39 @@ static GICv5Domain gicv5_current_phys_domain(CPUARMState *env)
     return gicv5_logical_domain(env);
 }
 
+static GICv5Domain gicv5_domain_for_insn(CPUARMState *env,
+                                         const ARMCPRegInfo *ri,
+                                         bool *virtual)
+{
+    /*
+     * Return the domain and virtual flag to use when GIC system insns
+     * result in commands to the IRS.
+     *
+     * GIC system insns come in several families where the prefix of
+     * the name indicates which interrupt domain they operate on:
+     *
+     * LD* commands (opc1 == 6) operate on the logical interrupt domain.
+     * VD* commands (opc1 == 4) operate on the virtual interrupt domain,
+     *   which is the domain of the current resident VM, which is the
+     *   the logical interrupt domain but with the virtual flag set.
+     * CD* commands (opc1 == 0) operate on the current domain, which is
+     *   the virtual one if ICC accesses redirect to ICV, and the
+     *   current physical interrupt domain otherwise.
+     *
+     * Returns the domain to use, and updates *virtual to return
+     * whether this is the virtual interrupt domain. The caller can
+     * then pass domain and virtual directly to the IRS functions.
+     */
+    bool logical = ri->opc1 == 6;
+
+    *virtual = ri->opc1 == 4 || gicv5_icv_access(env);
+
+    if (logical || *virtual) {
+        return gicv5_logical_domain(env);
+    }
+    return gicv5_current_phys_domain(env);
+}
+
 static uint64_t gic_running_prio(CPUARMState *env, GICv5Domain domain)
 {
     /*
@@ -507,8 +540,8 @@ static void gic_cddis_write(CPUARMState *env, const ARMCPRegInfo *ri,
     GICv5Common *gic = gicv5_get_gic(env);
     GICv5IntType type = FIELD_EX64(value, GIC_CDDIS, TYPE);
     uint32_t id = FIELD_EX64(value, GIC_CDDIS, ID);
-    bool virtual = false;
-    GICv5Domain domain = gicv5_current_phys_domain(env);
+    bool virtual;
+    GICv5Domain domain = gicv5_domain_for_insn(env, ri, &virtual);
 
     gicv5_set_enabled(gic, id, false, domain, type, virtual);
 }
@@ -519,8 +552,8 @@ static void gic_cden_write(CPUARMState *env, const ARMCPRegInfo *ri,
     GICv5Common *gic = gicv5_get_gic(env);
     GICv5IntType type = FIELD_EX64(value, GIC_CDEN, TYPE);
     uint32_t id = FIELD_EX64(value, GIC_CDEN, ID);
-    bool virtual = false;
-    GICv5Domain domain = gicv5_current_phys_domain(env);
+    bool virtual;
+    GICv5Domain domain = gicv5_domain_for_insn(env, ri, &virtual);
 
     gicv5_set_enabled(gic, id, true, domain, type, virtual);
 }
@@ -532,8 +565,8 @@ static void gic_cdpri_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint8_t priority = FIELD_EX64(value, GIC_CDPRI, PRIORITY);
     GICv5IntType type = FIELD_EX64(value, GIC_CDPRI, TYPE);
     uint32_t id = FIELD_EX64(value, GIC_CDPRI, ID);
-    bool virtual = false;
-    GICv5Domain domain = gicv5_current_phys_domain(env);
+    bool virtual;
+    GICv5Domain domain = gicv5_domain_for_insn(env, ri, &virtual);
 
     gicv5_set_priority(gic, id, priority, domain, type, virtual);
 }
@@ -546,8 +579,8 @@ static void gic_cdaff_write(CPUARMState *env, const ARMCPRegInfo *ri,
     GICv5RoutingMode irm = FIELD_EX64(value, GIC_CDAFF, IRM);
     GICv5IntType type = FIELD_EX64(value, GIC_CDAFF, TYPE);
     uint32_t id = FIELD_EX64(value, GIC_CDAFF, ID);
-    bool virtual = false;
-    GICv5Domain domain = gicv5_current_phys_domain(env);
+    bool virtual;
+    GICv5Domain domain = gicv5_domain_for_insn(env, ri, &virtual);
 
     gicv5_set_target(gic, id, iaffid, irm, domain, type, virtual);
 }
@@ -559,8 +592,8 @@ static void gic_cdpend_write(CPUARMState *env, const ARMCPRegInfo *ri,
     bool pending = FIELD_EX64(value, GIC_CDPEND, PENDING);
     GICv5IntType type = FIELD_EX64(value, GIC_CDPEND, TYPE);
     uint32_t id = FIELD_EX64(value, GIC_CDPEND, ID);
-    bool virtual = false;
-    GICv5Domain domain = gicv5_current_phys_domain(env);
+    bool virtual;
+    GICv5Domain domain = gicv5_domain_for_insn(env, ri, &virtual);
 
     gicv5_set_pending(gic, id, pending, domain, type, virtual);
 }
@@ -571,8 +604,8 @@ static void gic_cdrcfg_write(CPUARMState *env, const ARMCPRegInfo *ri,
     GICv5Common *gic = gicv5_get_gic(env);
     GICv5IntType type = FIELD_EX64(value, GIC_CDRCFG, TYPE);
     uint32_t id = FIELD_EX64(value, GIC_CDRCFG, ID);
-    bool virtual = false;
-    GICv5Domain domain = gicv5_current_phys_domain(env);
+    bool virtual;
+    GICv5Domain domain = gicv5_domain_for_insn(env, ri, &virtual);
 
     env->gicv5_cpuif.icc_icsr_el1 =
         gicv5_request_config(gic, id, domain, type, virtual);
@@ -585,8 +618,8 @@ static void gic_cdhm_write(CPUARMState *env, const ARMCPRegInfo *ri,
     GICv5HandlingMode hm = FIELD_EX64(value, GIC_CDHM, HM);
     GICv5IntType type = FIELD_EX64(value, GIC_CDAFF, TYPE);
     uint32_t id = FIELD_EX64(value, GIC_CDAFF, ID);
-    bool virtual = false;
-    GICv5Domain domain = gicv5_current_phys_domain(env);
+    bool virtual;
+    GICv5Domain domain = gicv5_domain_for_insn(env, ri, &virtual);
 
     gicv5_set_handling(gic, id, hm, domain, type, virtual);
 }
@@ -1108,7 +1141,8 @@ static uint64_t gicr_cdia_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     /* Acknowledge HPPI in the current interrupt domain */
     GICv5Common *gic = gicv5_get_gic(env);
-    GICv5Domain domain = gicv5_current_phys_domain(env);
+    bool virtual;
+    GICv5Domain domain = gicv5_domain_for_insn(env, ri, &virtual);
     GICv5PendingIrq hppi = gic_hppi(env, domain);
     GICv5IntType type = FIELD_EX64(hppi.intid, INTID, TYPE);
     uint32_t id = FIELD_EX64(hppi.intid, INTID, ID);
@@ -1185,7 +1219,8 @@ static void gic_cdeoi_write(CPUARMState *env, const ARMCPRegInfo *ri,
      * Perform Priority Drop in the current interrupt domain.
      * This is just clearing the lowest set bit in the APR.
      */
-    GICv5Domain domain = gicv5_current_phys_domain(env);
+    bool virtual;
+    GICv5Domain domain = gicv5_domain_for_insn(env, ri, &virtual);
     uint64_t *apr = &env->gicv5_cpuif.icc_apr[domain];
 
     trace_gicv5_cdeoi(domain);
@@ -1203,10 +1238,10 @@ static void gic_cddi_write(CPUARMState *env, const ARMCPRegInfo *ri,
      * current interrupt domain.
      */
     GICv5Common *gic = gicv5_get_gic(env);
-    GICv5Domain domain = gicv5_current_phys_domain(env);
+    bool virtual;
+    GICv5Domain domain = gicv5_domain_for_insn(env, ri, &virtual);
     GICv5IntType type = FIELD_EX64(value, GIC_CDDI, TYPE);
     uint32_t id = FIELD_EX64(value, GIC_CDDI, ID);
-    bool virtual = false;
 
     trace_gicv5_cddi(domain, value);
 
-- 
2.43.0


