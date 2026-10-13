Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87632CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY44-00006A-9z; Tue, 13 Oct 2026 04:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3n-00083g-UB
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:36 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3l-0007yH-QK
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:35 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so17365625e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880832; x=1792485632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4lbX4jqxG9XcAqUvTf01b6jgpr+mQAhWItQ+vjCx7vI=;
 b=yPYOxiZVvqbwFp/8yTSJ6DJisXAN5KXbh66oGoTlIsXruGg/rAtMPCa0MO+pp8W12i
 hbCw0yY97Q3KIb4pbbh7EDTwW+v9+dN76viabfQq/ediv7od9IAK1yeVTvU9xz/jPQMf
 1ajC+l/XheW8FixJJRKSfqy8lNzckKMwOKj9lwjC33BZ5CuMin8EppJiGaWCA6bNrf85
 1Za+eNFtQOkqJ8u/Bj/7YRmVIhN96f47S8EAfpWsEs8/fuX+q3OQ3U3iS4dqEF1OWhSM
 FcEbeDwJfAPIeSHzwF8ANqlInWH/XtZ5ckoq9mM3VFDpgWtDeHi7saospJwA8dS25xKm
 54Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880832; x=1792485632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4lbX4jqxG9XcAqUvTf01b6jgpr+mQAhWItQ+vjCx7vI=;
 b=vIYOy0M3UYCiMtpMamShGJ9ZLIhhDR4+F5ovIlQtSwhLLbftV1TEgVDPtuL+75egY9
 FwczjDHb2Yd//eW8Mg9hGrKQhQh5JFN67B0Uc1kFZarJfRuioDpliGzraPRSwkdbU4jj
 ygIeRKsTBhs7LukaoAxbSw8tqkAidtPpgBiNpfn0/BCc5f8P+tcX+JJMiTkhUrFF8QCP
 O1FVKhCJbMmXOPD7+gvqOq0yCo7M21Z8mde+RHzKTVX9A8GeyG5uoKx8SUaDQ43fUXax
 DfA8MwXpN3i+I4dOAY0dN/taV4RxEJF5NxRvVDVKbQEjmzMEAJMOX9nRYWMhBsAhwc/R
 MzXw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxR7ZjY7x4HmdLjVO/x84vZ76lrjeUYA1ncW3zr0xJSLucNI14zOFEgzanhzPJnrsI5GBfuW9+9lpvm@nongnu.org
X-Gm-Message-State: AFq9FYJnGOm36L7rJeUtFvpPun991MW/VAdqLROOWYXYdrGadv02+nTr
 YuOTC5bOP0Y+Tm/bXT9Crsb4I7RLjiCIsXuDvfwZMkVA4NtfQYYTtVmaWQMnDcfLitlfaMUs57Y
 o3fjKtYE=
X-Gm-Gg: AYBFou08gflXWfDTp2ot7JCl3gA4EXOFSzceMyLO5bFEF+FsBVcHwdD4sWUNV5br8IR
 iztcjdl6dygLCrnHM/FrBTEjNgvrJDaKH06InabqjS0xY8vmS18pQKWuxlyuCU1cEofpdMlP62M
 xNmTDRiVR1y7+0x7JpC7zEfcTxLk7jtwm3QwqfVyKoYxedUt+pqoV08ocPexOZ9ZxX+zxU7xExZ
 h8lzJrUowzlTM58z0RLK4+GqqIB4atklO7SRLfVIo2jf7LlhUUcqU6nO5T48Lod8pHGZJlwykuL
 MzFGpKa1ca1x77iBeS6i8z4I1QMpb7mHxZidFxI5ZaQPPiY8SG9dajI1mto8O/+gWFN7YMMH2nM
 V+mCC8ararpkjZwlAYhvL6fZq+PhpLbh3qgMczBMjKhJ3pW8Qacru8KbOtXaeu+tEQvBSDOUCc4
 pMwWZ+64orlMrD6EzkMZFf5KLrRh6vXCnfmTqCclc4UXNLJgAJgJVYNbeY0RJ/8p0Apq3l7tRaF
 tncm/PxlTGbg3GwqTWQ8T0VWgwXoxIcR0okLqyybTRxftqWeNQgul7gnN0H4+jC8mHiNL0UK5eh
 I6kE4hKexsXs2A==
X-Received: by 2002:a05:600c:4e89:b0:4a0:12d7:4c88 with SMTP id
 5b1f17b1804b1-4a18e4ac77amr257883605e9.30.1791880832003; 
 Tue, 13 Oct 2026 01:40:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 41/86] target/arm: GICv5 cpuif: Handle GIC VDPEND VM argument
Date: Tue, 13 Oct 2026 09:38:48 +0100
Message-ID: <20261013083933.1024405-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

In the GIC system instructions, VDPEND is special: the other "act on
virtual interrupt domain" operations act on the resident VPE/VM, but
this one allows the guest to pass in the VM ID, so that a hypervisor
can pend an interrupt for a VM even if there isn't currently a VPE
for that VM resident on the CPU.

Add the VM argument to gicv5_set_pending(), and fill it in with the
VM argument from the guest for VDPEND, or the current VM (as set in
ICH_CONTEXTR_EL2) for CDPEND and LDPEND. (The IRS will fail all
virtual interrupt operations until we implement its virtualization
support.)

The placing of the VM field moves the PENDING bit from bit 32 to 63,
so we need also to special case the reading of that bit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c                |  5 +++--
 hw/intc/trace-events               |  2 +-
 include/hw/intc/arm_gicv5_stream.h |  3 ++-
 target/arm/tcg/gicv5-cpuif.c       | 34 +++++++++++++++++++++++++++++-
 4 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 5ac50acc786..d503d8db426 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -855,13 +855,14 @@ void gicv5_set_enabled(GICv5Common *cs, uint32_t id, bool enabled,
 }
 
 void gicv5_set_pending(GICv5Common *cs, uint32_t id, bool pending,
-                       GICv5Domain domain, GICv5IntType type, bool virtual)
+                       GICv5Domain domain, GICv5IntType type, bool virtual,
+                       uint32_t vm)
 {
     GICv5 *s = ARM_GICV5(cs);
     uint32_t iaffid;
 
     trace_gicv5_set_pending(domain_name[domain], inttype_name(type), virtual,
-                            id, pending);
+                            vm, id, pending);
     if (virtual) {
         qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_pending: tried to set "
                       "pending state of a virtual interrupt\n");
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 7512c6e6004..6681e32d1b7 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -237,7 +237,7 @@ gicv5_ist_valid(const char *domain, uint64_t base, uint8_t id_bits, uint8_t l2_i
 gicv5_ist_invalid(const char *domain) "GICv5 IRS %s IST no longer valid"
 gicv5_set_priority(const char *domain, const char *type, bool virtual, uint32_t id, uint8_t priority) "GICv5 IRS SetPriority %s %s virtual:%d ID %u prio %u"
 gicv5_set_enabled(const char *domain, const char *type, bool virtual, uint32_t id, bool enabled) "GICv5 IRS SetEnabled %s %s virtual:%d ID %u enabled %d"
-gicv5_set_pending(const char *domain, const char *type, bool virtual, uint32_t id, bool pending) "GICv5 IRS SetPending %s %s virtual:%d ID %u pending %d"
+gicv5_set_pending(const char *domain, const char *type, bool virtual, uint32_t vm, uint32_t id, bool pending) "GICv5 IRS SetPending %s %s virtual:%d VM %u ID %u pending %d"
 gicv5_set_handling(const char *domain, const char *type, bool virtual, uint32_t id, int handling) "GICv5 IRS SetHandling %s %s virtual:%d ID %u handling %d"
 gicv5_set_target(const char *domain, const char *type, bool virtual, uint32_t id, uint32_t iaffid, int irm) "GICv5 IRS SetTarget %s %s virtual:%d ID %u IAFFID %u routingmode %d"
 gicv5_request_config(const char *domain, const char *type, bool virtual, uint32_t id, uint64_t icsr) "GICv5 IRS RequestConfig %s %s virtual:%d ID %u ICSR 0x%" PRIx64
diff --git a/include/hw/intc/arm_gicv5_stream.h b/include/hw/intc/arm_gicv5_stream.h
index 162d55a8e6b..f6d32c6beca 100644
--- a/include/hw/intc/arm_gicv5_stream.h
+++ b/include/hw/intc/arm_gicv5_stream.h
@@ -86,6 +86,7 @@ void gicv5_set_enabled(GICv5Common *cs, uint32_t id,
  * @domain: interrupt Domain to act on
  * @type: interrupt type (LPI or SPI)
  * @virtual: true if this is a virtual interrupt
+ * @vm: VM ID (for virtual interrupts)
  *
  * Set pending state of an interrupt; matches stream interface
  * SetPending command from CPUIF to IRS. There is no report back of
@@ -93,7 +94,7 @@ void gicv5_set_enabled(GICv5Common *cs, uint32_t id,
  */
 void gicv5_set_pending(GICv5Common *cs, uint32_t id,
                        bool pending, GICv5Domain domain,
-                       GICv5IntType type, bool virtual);
+                       GICv5IntType type, bool virtual, uint32_t vm);
 
 /**
  * gicv5_set_handling
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 4ee548a768b..7f0109e9b12 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -40,6 +40,11 @@ FIELD(GIC_CDPEND, ID, 0, 24)
 FIELD(GIC_CDPEND, TYPE, 29, 3)
 FIELD(GIC_CDPEND, PENDING, 32, 1)
 
+FIELD(GIC_VDPEND, ID, 0, 24)
+FIELD(GIC_VDPEND, TYPE, 29, 3)
+FIELD(GIC_VDPEND, VM, 32, 16)
+FIELD(GIC_VDPEND, PENDING, 63, 1)
+
 FIELD(GIC_CDHM, ID, 0, 24)
 FIELD(GIC_CDHM, TYPE, 29, 3)
 FIELD(GIC_CDHM, HM, 32, 1)
@@ -594,8 +599,35 @@ static void gic_cdpend_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint32_t id = FIELD_EX64(value, GIC_CDPEND, ID);
     bool virtual;
     GICv5Domain domain = gicv5_domain_for_insn(env, ri, &virtual);
+    uint32_t vm = 0;
 
-    gicv5_set_pending(gic, id, pending, domain, type, virtual);
+    if (virtual) {
+        if (ri->opc1 == 4) {
+            /*
+             * GIC VDPEND has a VM argument field, and PENDING
+             * is in a different bit location to normal
+             */
+            vm = FIELD_EX64(value, GIC_VDPEND, VM);
+            pending = FIELD_EX64(value, GIC_VDPEND, PENDING);
+        } else {
+            /*
+             * GIC CDPEND for the virtual interrupt domain operates on
+             * the VM for the resident VPE. Our implementation of
+             * ICH_CONTEXTR_EL2 means we can trust that if the V bit
+             * is set the VM field is the right one.
+             */
+            if (FIELD_EX64(env->gicv5_cpuif.ich_contextr_el2,
+                           ICH_CONTEXTR_EL2, V)) {
+                vm = FIELD_EX64(env->gicv5_cpuif.ich_contextr_el2,
+                                ICH_CONTEXTR_EL2, VM);
+            } else {
+                /* no resident VPE: instruction is a NOP */
+                return;
+            }
+        }
+    }
+
+    gicv5_set_pending(gic, id, pending, domain, type, virtual, vm);
 }
 
 static void gic_cdrcfg_write(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.43.0


