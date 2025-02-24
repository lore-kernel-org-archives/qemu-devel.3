Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A5FC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 19:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdpQ-0005mt-Pk; Mon, 24 Feb 2025 14:09:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmdp3-0005g6-Sl
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:09:04 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmdp1-0004qZ-HN
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:08:57 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso140712335ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 11:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740424134; x=1741028934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l80pE3gkD/yQiSsoJR+m7k+bMTj+1l2cFJ9CeVi+z68=;
 b=ceRv9F3rxKgJgzFiIKe2+VS6HJFEBI6EVwUwTn5Y8Yvutw0/V6nvNYli59uD4ee04L
 ruemjuJo3xbrM2CtnvfCoC104qDUOfg2QpTEjvUb3rr5B0qajid8EjC/i7rFEgyfBplZ
 m1dvb5ysQYFmUnvPpqTf3K1i1us7p029/nOwGa9F3Vb81JGGkQ2dyN3tAfdLzfjM5YEP
 IdX6y29cg+13MwKTTUr/KGn72CtrcLEdm7kTUWYI3uOYr6WbBT5iD4IeuVx0eULNrkGM
 5WFbjjt+VAJsVon5VZu5xGNqXZCjuVp9BkhbULv865W7yiDaD/uztbfbAr6gXk0bIpQ3
 1MSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740424134; x=1741028934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l80pE3gkD/yQiSsoJR+m7k+bMTj+1l2cFJ9CeVi+z68=;
 b=fiHmAU716JazXGfHrXXjfvFZOZTzOoINUCrt/96Yeea9GfkCvG+JRZl/HBle8TV4rP
 lbxFOYfB33aXyV8H4Ury5ejdY6MozLBu8RKR2viqSl/cl653djZS+kN9Jlyq+pz6/uyW
 0xiJcYovPxZ87Vhu3rSarUn7fKpIJaabrTYP839agseza6sroQHZDbs/L5hKVYi4PWcs
 fWScmvd5cYXGnUasYyqIyNEyC5OOvqtl4pMLwC3rpn3oWNzG1Z2fknPUHHvQC2W5pESr
 efO83bINmUbW6ZQu4nXwpzhQOPNZ4u+Rvc+FwlspBEv5KLyqVgn+Fz43F5NLNioWAPTr
 kZLw==
X-Gm-Message-State: AOJu0Yy03KfAQj4QOZiecw4afXPBpJGpY5Q4PVZzZJu22pb20vj/nuPE
 IggKK8TqPsYCBiYMd8E2oIV6Q/7sSNSk1/f8sAq5/cwk9IlW4eu9Cnq/cAJ+nUhWs3Ftqz1b2+S
 M
X-Gm-Gg: ASbGncvGVg2lxUX4DVVvOL5NyUmE7coV3sl7doaDJCVNim+rodpbbvGaBjdLYjkBgfT
 wD0YfemucD9wkwccPD4dPTLRb2ra39HDNcYV/j7pYge4O7QltIXFgxTXV7tZJ8CKn92EQhbUlpZ
 wjkCtzuRncnEbhroDY0ii34YORCpuA3bACd/2tirK37kdqgzLs3RxUF5DrqczgFCxuCFCsMSYdN
 6xK3s1PuTRhp2JrbXk1h34z6uWaIYRTG7OT33vzdsouYFiajk+Hk5PscW48u0rKWsTcGbCa7v4+
 0SwCOGA4wL9UJeELgvmjL8uDtWjVBQ==
X-Google-Smtp-Source: AGHT+IEdkN1AF/qeS//sCuqL/NEfu+nHiLqoV9sKZlzyJdTLgmySpUH+sHcP+0J8+1P8rquvpkgBFw==
X-Received: by 2002:a17:902:ce87:b0:216:7cde:51a with SMTP id
 d9443c01a7336-22307b59658mr6107835ad.28.1740424133820; 
 Mon, 24 Feb 2025 11:08:53 -0800 (PST)
Received: from grind.. ([2804:7f0:bcc0:6edb:f473:a9df:d551:443b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545df28sm183583155ad.153.2025.02.24.11.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 11:08:53 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 07/11] hw/riscv/riscv-iommu: add IOHPMCYCLES mmio write
Date: Mon, 24 Feb 2025 16:08:22 -0300
Message-ID: <20250224190826.1858473-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224190826.1858473-1-dbarboza@ventanamicro.com>
References: <20250224190826.1858473-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x634.google.com
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

RISCV_IOMMU_REG_IOHPMCYCLES writes are done by
riscv_iommu_process_hpmcycle_write(), called by the mmio write callback
via riscv_iommu_process_hpm_writes().

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu-hpm.c | 19 +++++++++++++++++++
 hw/riscv/riscv-iommu-hpm.h |  1 +
 hw/riscv/riscv-iommu.c     |  2 +-
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
index 70814b942d..1cea6b1df1 100644
--- a/hw/riscv/riscv-iommu-hpm.c
+++ b/hw/riscv/riscv-iommu-hpm.c
@@ -262,3 +262,22 @@ void riscv_iommu_process_iocntinh_cy(RISCVIOMMUState *s, bool prev_cy_inh)
         timer_del(s->hpm_timer);
     }
 }
+
+void riscv_iommu_process_hpmcycle_write(RISCVIOMMUState *s)
+{
+    const uint64_t val = riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_IOHPMCYCLES);
+    const uint32_t ovf = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_IOCOUNTOVF);
+
+    /*
+     * Clear OF bit in IOCNTOVF if it's being cleared in IOHPMCYCLES register.
+     */
+    if (get_field(ovf, RISCV_IOMMU_IOCOUNTOVF_CY) &&
+        !get_field(val, RISCV_IOMMU_IOHPMCYCLES_OVF)) {
+        riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_IOCOUNTOVF, 0,
+            RISCV_IOMMU_IOCOUNTOVF_CY);
+    }
+
+    s->hpmcycle_val = val & ~RISCV_IOMMU_IOHPMCYCLES_OVF;
+    s->hpmcycle_prev = get_cycles();
+    hpm_setup_timer(s, s->hpmcycle_val);
+}
diff --git a/hw/riscv/riscv-iommu-hpm.h b/hw/riscv/riscv-iommu-hpm.h
index ee888650fb..0cd550975d 100644
--- a/hw/riscv/riscv-iommu-hpm.h
+++ b/hw/riscv/riscv-iommu-hpm.h
@@ -27,5 +27,6 @@ void riscv_iommu_hpm_incr_ctr(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
                               unsigned event_id);
 void riscv_iommu_hpm_timer_cb(void *priv);
 void riscv_iommu_process_iocntinh_cy(RISCVIOMMUState *s, bool prev_cy_inh);
+void riscv_iommu_process_hpmcycle_write(RISCVIOMMUState *s);
 
 #endif
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index a4580dca0b..821ecba3a4 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2035,7 +2035,7 @@ static void riscv_iommu_process_hpm_writes(RISCVIOMMUState *s,
 
     case RISCV_IOMMU_REG_IOHPMCYCLES:
     case RISCV_IOMMU_REG_IOHPMCYCLES + 4:
-        /* not yet implemented */
+        riscv_iommu_process_hpmcycle_write(s);
         break;
 
     case RISCV_IOMMU_REG_IOHPMEVT_BASE ...
-- 
2.48.1


