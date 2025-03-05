Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F05C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpe0P-0003dx-Nv; Tue, 04 Mar 2025 20:57:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdys-00077N-6p
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:31 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyq-0000RG-JH
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:29 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22355618fd9so108723975ad.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139727; x=1741744527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e7fic5ApTylR4PI06x/G/v7IZ/lFGLmPIIZhQKKAKjY=;
 b=EFCNHXhhqXsrVJT1a840dJoUpbSMZrJID3bAZSHyfdLbZ+e9yeJqpwoM7AFgXh//T5
 DpJzqh6eDW/l6KggDAI86Ey+xCnGGQX9pj96pL0pjQSTrZ/uBMQSEDktU034/5xraM4B
 3nona8a5BYQjHnT90IHw9+UFjV+icfP39XuIlGV0b4UWAijbrdsMtqKcYG0uYGQ0yXK4
 w9PbDzSqCs8/HMx819kgtj4nPzFV45GnlQ+HIIGLP8PZ7Zja4tgH00+fJYURLIhNzY3B
 A/2w7ufsdOG5e9SZ8NJVdHubyOOgv8WvUPK3KRZP6mvE1+FToaUH8qxLE/9RZjwkKGBO
 KF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139727; x=1741744527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e7fic5ApTylR4PI06x/G/v7IZ/lFGLmPIIZhQKKAKjY=;
 b=NBgY+sklY+wDC0Oau2AK3G/Kud2if11U3jkCixG2/wfEn7gMMS3Ge1TykALqyPcHlr
 2wCsjlISOs+bRHWzkZo6HQ/sqkv9CpdhdtocUnth5Ux/YKbnux3Y7xmVZc3tzwUmSFyg
 T1uGcgX1ZWbIWJQHks0yhxVNzwcFUiaHUek3cNOs58tAetPf5atKOYsb3esCYJAn2MEP
 kF1sENjgjldyeVF1aBioDHQv4WDL25+y1Cu7UhWtYtcH8Ajt8mH7cuCkmEuUgZXUFpOK
 ebF9G2FcDj8fulEJWhUuNqq9po8Nz9cyJbF4ADKFpOp84fDFc2+h8QCiFIfvdt0V18Nf
 7qfw==
X-Gm-Message-State: AOJu0YykMoL8ssoqQ4xeyNicGlYF88dFaeUQxZpM26h4Yfj0wBwWYjXy
 stjvHgqgI/7eOtxEqdo2iTuPO3toacvq9n9hCllHOtc1RQyJMR/DwpfgA7HkxSM=
X-Gm-Gg: ASbGnct0vZNZgGQ+w0HvJxGNYZ72pz3U07DB3I5e9w6gU9VCnHCq/61Ff4UZIrepYYI
 VtbiWdiA1Tw8z5k1H7YdpqnZjKNn1k9xuzZCHoD6GkjU4k+7HpnSvG84jQ2ybIIZWd88WckbjRo
 W4BnTFlDcFQCFKkOEcdL6ZU5fa1vLNipkG9RkHP+u0opBad+tIYT0FHdZUd1sn2r3FBphvLYx13
 /cyKur0KWJ7EA6OF4CL4x/MiSTZgr321wmJYfKVVn8jxw4FT9VqllE+UtoTTdBAK1Wl/gyuUIlV
 w6kyzVPoEfxyyXaNUwJQ/EE89enJQFlz/OOvdhfZw/1a9Sm7IS3qVs5ocGHl67TzUTpUwzr7p2w
 ByJKDmwCFNjWUo+Eb3vkrg8Vuq/0UN6ptIb4IT//Ozvx8poUQ+/M=
X-Google-Smtp-Source: AGHT+IHyQKiLzLEm1sDf+XLBvUZQ6U11u+76gQVWBbmHm0PgFxdgaPX1c48XGiJ2WO63NsGgR/2YOQ==
X-Received: by 2002:a17:903:182:b0:223:2630:6b82 with SMTP id
 d9443c01a7336-223f1c6903amr26913875ad.10.1741139727108; 
 Tue, 04 Mar 2025 17:55:27 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:55:26 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 45/59] hw/riscv/riscv-iommu: add IOHPMCYCLES mmio write
Date: Wed,  5 Mar 2025 11:52:53 +1000
Message-ID: <20250305015307.1463560-46-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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

RISCV_IOMMU_REG_IOHPMCYCLES writes are done by
riscv_iommu_process_hpmcycle_write(), called by the mmio write callback
via riscv_iommu_process_hpm_writes().

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250224190826.1858473-8-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu-hpm.h |  1 +
 hw/riscv/riscv-iommu-hpm.c | 19 +++++++++++++++++++
 hw/riscv/riscv-iommu.c     |  2 +-
 3 files changed, 21 insertions(+), 1 deletion(-)

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


