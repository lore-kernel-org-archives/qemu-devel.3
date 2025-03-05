Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2034C282D9
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdzN-00087q-9Z; Tue, 04 Mar 2025 20:56:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyq-00075l-AK
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:28 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyo-0000Qz-HF
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:28 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22113560c57so118917285ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139725; x=1741744525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TdcLLvpFN1+Z9B+s54N+xpwueNucZWMefLhcdyHr3hI=;
 b=AWIbw8hdE4Z7MRIKib/zEwjkQlmfxATzImt5qSCWjjp4b0LxncFfOUXW+XX3OPFGKw
 ZhhFDogxYNhq14RlaIjgQ6waEKHDJ2TE1RkAln5hsZtD95HXAFwxDgL0d7EJzViOLjxV
 hNIwz0i+CBtnjtPMQIRVbNNxZTEjP3WkBnCLtaBTX4366a/KsTkSeF3LdHQVG2Daiy8E
 YeYEJQXlP7QIx1Z6u1HBsiLKziqv/bIb3l9/V4vCppfRGgcJVxzspmOiuzZVB06bD7lb
 qcgLezx2gFQvp8iPwIJyL5SCzp9jomH8dxhFPVukK8WSBOhcRgoJLXWFefgtSzAWSe5b
 OO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139725; x=1741744525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TdcLLvpFN1+Z9B+s54N+xpwueNucZWMefLhcdyHr3hI=;
 b=Fnx/06+m5XlzJwOROU60sLXbMYb7SHhhPu+JNda9pC5uekU4FpSHT4GFXHwZ0I+IbN
 QvD3DlmFgIlVx/8k4+eSXOXvn52OBrvJRsvuGtTiXxZfSCJ4SO3tMQ3R2Ba8zcp+ZAXG
 LnEI0N79OpQmtOSdfXnplMneN+etKebu5ZKHftzColT0oaHp0j+gLrEawEoGmcEIgDic
 Ira/7TnNkF+RvwGwVKmfVt8wBSjel500sy76DC2jZq0JR2GR1NFggwkgK3OK0uVYcmiO
 ALPPSO+Kzpt+JBpWHMFq2KJY+j0WFryLZh63NrZwdwbSoyEYMPqu/QdvOt7QL1WFAfFH
 fAHQ==
X-Gm-Message-State: AOJu0YwPpzIgm5+2EgLzNTRG5byrmKj4FxcW8glAnv4SI6TjT2FlkEE4
 Sd5OIYuiHEELWjHXWzGvStIH2LQUqNoW7Fdb91X7SetiW4TWvK2lvsPr8ygTecY=
X-Gm-Gg: ASbGnctXhbo7kIngRpqXUfON4404sA0v8Wd7//V3OekIAcYnwgY4mn7tDgWY+srQD57
 tJPRwIpdqgWuSxhYY8cl8KeNwtuxYX69+0iK45hhdnADSFPyJrPIdBhHwoho6zUUGlbP3dA90+V
 ZjTm/C2qGFwSqQUc5ODBfxPLigoUo9BbDTCXlbeXYXYDaL06I2FFGKXI0WJcber1pkYvWCOQfaz
 cEpj+oN+xLhNlMkRFlus9t01KqKGxSm9wVJJB9YLgd3ag/Y37wMUWR7VG1vmDmyJZARkHg5uYAc
 H9WpwTagfXkMeP8EHzomW8KVattB0qooNUMKb5remwckdhsBp7rQkO+xNTDFnw+TRIh6HcepO7N
 /7kULHW3TmTaSP5GUjlkH++N8ozOKkG6/++Uqm2H5Yx1+OHHFUF8=
X-Google-Smtp-Source: AGHT+IGSgFzyddFBTl/O3MrTXMI5DRqZsVYwV+hkmn5qD+3hPwF6ljorS0ri4FBVOHKxg/LAif0SIQ==
X-Received: by 2002:a17:902:e881:b0:223:6744:bfb9 with SMTP id
 d9443c01a7336-223f1d20e54mr22347475ad.41.1741139724005; 
 Tue, 04 Mar 2025 17:55:24 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:55:23 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 44/59] hw/riscv/riscv-iommu: add IOCOUNTINH mmio writes
Date: Wed,  5 Mar 2025 11:52:52 +1000
Message-ID: <20250305015307.1463560-45-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

RISCV_IOMMU_REG_IOCOUNTINH is done by riscv_iommu_process_iocntinh_cy(),
which is called during riscv_iommu_mmio_write() callback via a new
riscv_iommu_pricess_hpm_writes() helper.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250224190826.1858473-7-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu-hpm.h |  1 +
 hw/riscv/riscv-iommu-hpm.c | 60 ++++++++++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu.c     | 38 ++++++++++++++++++++++++
 3 files changed, 99 insertions(+)

diff --git a/hw/riscv/riscv-iommu-hpm.h b/hw/riscv/riscv-iommu-hpm.h
index cd896d3b7c..ee888650fb 100644
--- a/hw/riscv/riscv-iommu-hpm.h
+++ b/hw/riscv/riscv-iommu-hpm.h
@@ -26,5 +26,6 @@ uint64_t riscv_iommu_hpmcycle_read(RISCVIOMMUState *s);
 void riscv_iommu_hpm_incr_ctr(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
                               unsigned event_id);
 void riscv_iommu_hpm_timer_cb(void *priv);
+void riscv_iommu_process_iocntinh_cy(RISCVIOMMUState *s, bool prev_cy_inh);
 
 #endif
diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
index 325088333e..70814b942d 100644
--- a/hw/riscv/riscv-iommu-hpm.c
+++ b/hw/riscv/riscv-iommu-hpm.c
@@ -202,3 +202,63 @@ void riscv_iommu_hpm_timer_cb(void *priv)
         riscv_iommu_notify(s, RISCV_IOMMU_INTR_PM);
     }
 }
+
+static void hpm_setup_timer(RISCVIOMMUState *s, uint64_t value)
+{
+    const uint32_t inhibit = riscv_iommu_reg_get32(
+        s, RISCV_IOMMU_REG_IOCOUNTINH);
+    uint64_t overflow_at, overflow_ns;
+
+    if (get_field(inhibit, RISCV_IOMMU_IOCOUNTINH_CY)) {
+        return;
+    }
+
+    /*
+     * We are using INT64_MAX here instead to UINT64_MAX because cycle counter
+     * has 63-bit precision and INT64_MAX is the maximum it can store.
+     */
+    if (value) {
+        overflow_ns = INT64_MAX - value + 1;
+    } else {
+        overflow_ns = INT64_MAX;
+    }
+
+    overflow_at = (uint64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + overflow_ns;
+
+    if (overflow_at > INT64_MAX) {
+        s->irq_overflow_left = overflow_at - INT64_MAX;
+        overflow_at = INT64_MAX;
+    }
+
+    timer_mod_anticipate_ns(s->hpm_timer, overflow_at);
+}
+
+/* Updates the internal cycle counter state when iocntinh:CY is changed. */
+void riscv_iommu_process_iocntinh_cy(RISCVIOMMUState *s, bool prev_cy_inh)
+{
+    const uint32_t inhibit = riscv_iommu_reg_get32(
+        s, RISCV_IOMMU_REG_IOCOUNTINH);
+
+    /* We only need to process CY bit toggle. */
+    if (!(inhibit ^ prev_cy_inh)) {
+        return;
+    }
+
+    if (!(inhibit & RISCV_IOMMU_IOCOUNTINH_CY)) {
+        /*
+         * Cycle counter is enabled. Just start the timer again and update
+         * the clock snapshot value to point to the current time to make
+         * sure iohpmcycles read is correct.
+         */
+        s->hpmcycle_prev = get_cycles();
+        hpm_setup_timer(s, s->hpmcycle_val);
+    } else {
+        /*
+         * Cycle counter is disabled. Stop the timer and update the cycle
+         * counter to record the current value which is last programmed
+         * value + the cycles passed so far.
+         */
+        s->hpmcycle_val = s->hpmcycle_val + (get_cycles() - s->hpmcycle_prev);
+        timer_del(s->hpm_timer);
+    }
+}
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index f26aa15f55..a4580dca0b 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2024,6 +2024,27 @@ static void riscv_iommu_update_ipsr(RISCVIOMMUState *s, uint64_t data)
     riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_IPSR, ipsr_set, ipsr_clr);
 }
 
+static void riscv_iommu_process_hpm_writes(RISCVIOMMUState *s,
+                                           uint32_t regb,
+                                           bool prev_cy_inh)
+{
+    switch (regb) {
+    case RISCV_IOMMU_REG_IOCOUNTINH:
+        riscv_iommu_process_iocntinh_cy(s, prev_cy_inh);
+        break;
+
+    case RISCV_IOMMU_REG_IOHPMCYCLES:
+    case RISCV_IOMMU_REG_IOHPMCYCLES + 4:
+        /* not yet implemented */
+        break;
+
+    case RISCV_IOMMU_REG_IOHPMEVT_BASE ...
+        RISCV_IOMMU_REG_IOHPMEVT(RISCV_IOMMU_IOCOUNT_NUM) + 4:
+        /* not yet implemented */
+        break;
+    }
+}
+
 /*
  * Write the resulting value of 'data' for the reg specified
  * by 'reg_addr', after considering read-only/read-write/write-clear
@@ -2051,6 +2072,7 @@ static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
     uint32_t regb = addr & ~3;
     uint32_t busy = 0;
     uint64_t val = 0;
+    bool cy_inh = false;
 
     if ((addr & (size - 1)) != 0) {
         /* Unsupported MMIO alignment or access size */
@@ -2118,6 +2140,16 @@ static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
         busy = RISCV_IOMMU_TR_REQ_CTL_GO_BUSY;
         break;
 
+    case RISCV_IOMMU_REG_IOCOUNTINH:
+        if (addr != RISCV_IOMMU_REG_IOCOUNTINH) {
+            break;
+        }
+        /* Store previous value of CY bit. */
+        cy_inh = !!(riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_IOCOUNTINH) &
+            RISCV_IOMMU_IOCOUNTINH_CY);
+        break;
+
+
     default:
         break;
     }
@@ -2136,6 +2168,12 @@ static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
         stl_le_p(&s->regs_rw[regb], rw | busy);
     }
 
+    /* Process HPM writes and update any internal state if needed. */
+    if (regb >= RISCV_IOMMU_REG_IOCOUNTOVF &&
+        regb <= (RISCV_IOMMU_REG_IOHPMEVT(RISCV_IOMMU_IOCOUNT_NUM) + 4)) {
+        riscv_iommu_process_hpm_writes(s, regb, cy_inh);
+    }
+
     if (process_fn) {
         process_fn(s);
     }
-- 
2.48.1


