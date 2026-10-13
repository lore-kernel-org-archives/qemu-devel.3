Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A89CC6B14
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY8Y-0007Jr-RW; Tue, 13 Oct 2026 04:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4H-0000Y8-D6
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:05 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4E-00089c-L4
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:05 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48afbd2c386so1448659f8f.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880861; x=1792485661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CSbF49+sZ3UGdDTJ3sEVMBom5AzlLVf7M9E9FjQ6vGs=;
 b=vj9j4b2JGzUE2OE8URce1vjnlxSz+NFvhj+KA/yj8qmFtqQRWuEFGr463TZ0PiYhlf
 KPnii6G51pYUYa3dKhLzCh3PNPQk5bC7EtPbll5B3xw3SvXsdCvjFeuYpPJP78Oc2IdA
 VRGdERBafIwV2dNinkD9uRgsFw3ydWx5abgHZnqXm2/3tp+XxXVFCgWaX4RgVWQi6z2q
 1taoFea7SrHfuy+vdc2bpOkK7vuEO3Jb4cbCucE0B59NezuSMS6utLcHFS6hzCyF9L08
 mcTN52i8qK1s9L5I8/gUCgpX2wKAKnuq/q5fPt2Usu3Jh6PqGx75ICOFB5JGAydwgtTU
 AYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880861; x=1792485661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CSbF49+sZ3UGdDTJ3sEVMBom5AzlLVf7M9E9FjQ6vGs=;
 b=aR/Y4xMvJYmpkFEZ5t05D7pWwI5J2+Tiy22JDH1LBNwaUo2fCu9r7Q26+BmRkqURkf
 5/3P6obzxoQM5aZBuUdw7uBeG+aYLlj4y75MLa+x0xZzq28d5ER3cwgg2W8PfF/TK78k
 njlUrYZ+zDVCeUB9wXgZWlFRldh/4tsd5PB/uz3bo8Q8Wt2ZDBW3uu3Erzj8MOnT8+0C
 rhpfDT5iiNqOAOGbi26q5IF8ZY8zyVYloe6k33LsfnusApLjYOKQn8GfL4B5Ljum9B/b
 Wptpi8XuhZtfD/kGCljDJ+yjcTRo6PLL2ahJ3TcmCEmqwy4co56rXsqdggTsFT5imY3k
 Wz6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBy9NabCq/+jclL51xPlmQ1mh6IiqfAXHlg1iNdIICqw/TS8hu8dAlhPl0jJ/qB9dZ1D0x+Y2Df1PARL@nongnu.org
X-Gm-Message-State: AFq9FYJygYMLfghO3w3zpZvRAm3ekD2775kMcA/+B+vhAKT1khIjyF6J
 PTSz5FZe+qpbjGEB23Jg/ZxaB/hpehDomXT3cj++ams+L8mQozQDSqH0qUJIa3YkYtqkwYglA/w
 i8B3bDyo=
X-Gm-Gg: AYBFou064Myzucpeq9ad3GPUKj7/eT+nuKJgyPdgBNH8yoTSAlrd1AjR33aIAvTQAtJ
 bNPmLUAbD3WLMW0QeF4dwBi+IOUh6QbluIn7I7Ny0z6zpIWwSKGuQkLP7gQEN5n+0VVSCVp4nEN
 LcvmDygVfrxgwknCOrIrl3+PlyqYjOUxOsLEZCZ4SNbDejGhF83vw71jrZ+c5tU4Zwu44iBdRdo
 VVi7s4clmTeLVc/TTsGzlwxdWeHrQw1p/GOw3KjWdtihhYICSc2rm0gLuoDFEfs49coUbTbxXOA
 nDVB2NsR17hIfSOhgKRCm106xGEIFYTmKt+AQJYRbeTI5scZGgGrV5IcGfHADdi7Ebrp5OlE2Ll
 Vez58yg6LFlBxqUX0HlArYZckSm70wjg2fO67KQv9NW3r6BFByp+nqVxZsV/pAXi9BQcoukwdh2
 flkAuFFGkBPSQpurjXL9mpxei/vT8R0wXeZ2qZ8JCd4spn8DsDx4Fv6ObfMU9TCKFp5Q1QgAvRr
 qqotGDRymun3nKOlkmBI9uhSlAg0xTNCmxIM3xWl7vKi1eWQ21LJpYwS+77KUg9mK/g5gLkBkSx
 bo4=
X-Received: by 2002:a05:600c:609b:b0:49f:ce78:356d with SMTP id
 5b1f17b1804b1-4a18e4c9944mr220069735e9.30.1791880860784; 
 Tue, 13 Oct 2026 01:41:00 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:41:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 66/86] hw/intc/arm_gicv5: Implement IRS_VPE_DBR
Date: Tue, 13 Oct 2026 09:39:13 +0100
Message-ID: <20261013083933.1024405-67-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

The IRS_VPE_DBR register provides access to the doorbell config of
the VPE selected with IRS_VPE_SELR.  The config is sampled into the
register when SELR is successfully written.  Writes to IRS_VPE_DBR
will update the config if the VPE selected by IRS_VPE_SELR is still
valid; if the VPE became invalid between the SELR write and the
CR0/DBR write then IRS_VPE_STATUSR.V is updated to report this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c                | 105 ++++++++++++++++++++++++++++-
 hw/intc/arm_gicv5_common.c         |   1 +
 hw/intc/trace-events               |   2 +
 include/hw/intc/arm_gicv5_common.h |   1 +
 4 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 455242596bc..f7d2d4a7143 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -29,7 +29,11 @@ typedef struct VMTE VMTE;
 typedef struct VPE {
     VMTE *vmte;
     hwaddr vped_addr;
-    bool valid;
+    uint32_t db_intid; /* doorbell interrupt ID */
+    uint8_t dbpm; /* doorbell priority mask */
+    bool valid; /* is the VPE valid? */
+    bool db_valid; /* are doorbell settings valid? */
+    bool db_req; /* is a doorbell requested? */
 } VPE;
 
 /* In the GICv5VMTConfig::vm_cache this is how we store VMTE info */
@@ -1257,6 +1261,8 @@ static void init_vpe_from_vpete(VPE *vpe, VMTE *vmte, uint64_t vpete)
     if (vpe->valid) {
         vpe->vped_addr = vpete & R_VPETE_VPED_ADDR_MASK;
         vpe->vped_addr &= ~MAKE_64BIT_MASK(0, QEMU_GICV5_VPED_SZ);
+        /* Doorbell settings always start invalid */
+        vpe->db_valid = false;
     }
 }
 
@@ -2008,7 +2014,20 @@ static void irs_vpe_selr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
 
     vpe = vpe_from_selr(s, domain);
     if (vpe) {
-        /* We successfully selected a valid VPE */
+        /*
+         * We successfully selected a valid VPE. Sample the config
+         * into IRS_VPE_DBR.
+         */
+        uint64_t dbr = 0;
+
+        if (vpe->db_valid) {
+            dbr = FIELD_DP64(dbr, IRS_VPE_DBR, DBV, vpe->db_valid);
+            dbr = FIELD_DP64(dbr, IRS_VPE_DBR, DBPM, vpe->dbpm);
+            dbr = FIELD_DP64(dbr, IRS_VPE_DBR, REQ_DB, vpe->db_req);
+            dbr = FIELD_DP64(dbr, IRS_VPE_DBR, INTID, vpe->db_intid);
+        }
+        cs->irs_vpe_dbr[domain] = dbr;
+
         status |= R_IRS_VPE_STATUSR_V_MASK;
     }
 
@@ -2017,6 +2036,53 @@ static void irs_vpe_selr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
     cs->irs_vpe_statusr[domain] = status;
 }
 
+static void irs_vpe_dbr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
+{
+    GICv5Common *cs = ARM_GICV5_COMMON(s);
+    VPE *vpe;
+
+    /* RES0 if we don't have virt */
+    if (!gicv5_domain_has_virt(cs, domain)) {
+        return;
+    }
+
+    cs->irs_vpe_dbr[domain] = value;
+
+    if (!FIELD_EX64(cs->irs_vpe_statusr[domain], IRS_VPE_STATUSR, V)) {
+        /* No valid VPE selected via SELR */
+        return;
+    }
+
+    vpe = vpe_from_selr(s, domain);
+    if (!vpe) {
+        /* VPE became invalid since SELR was last written */
+        cs->irs_vpe_statusr[domain] &= ~R_IRS_VPE_STATUSR_V_MASK;
+        return;
+    }
+
+    vpe->db_valid = FIELD_EX64(value, IRS_VPE_DBR, DBV);
+    if (vpe->db_valid) {
+        vpe->dbpm = FIELD_EX64(value, IRS_VPE_DBR, DBPM);
+        vpe->db_intid = FIELD_EX64(value, IRS_VPE_DBR, INTID);
+        vpe->db_req = FIELD_EX64(value, IRS_VPE_DBR, REQ_DB);
+
+        trace_gicv5_irs_vpe_dbr_write(domain_name[domain], vpe->vmte->vmid,
+                                      FIELD_EX64(cs->irs_vpe_selr[domain],
+                                                 IRS_VPE_SELR, VPE_ID),
+                                      vpe->dbpm, vpe->db_intid, vpe->db_req);
+
+        /*
+         * TODO: when we implement VPE doorbells, check here whether
+         * this config change means we should now generate a VPE
+         * doorbell event for this VPE.
+         */
+    } else {
+        trace_gicv5_irs_vpe_dbr_write_nv(domain_name[domain], vpe->vmte->vmid,
+                                         FIELD_EX64(cs->irs_vpe_selr[domain],
+                                                    IRS_VPE_SELR, VPE_ID));
+    }
+}
+
 static void spi_sample(GICv5SPIState *spi)
 {
     /*
@@ -2252,6 +2318,22 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
             *data = 0;
         }
         return true;
+    case A_IRS_VPE_DBR:
+        if (gicv5_domain_has_virt(cs, domain)) {
+            *data = extract64(cs->irs_vpe_dbr[domain], 0, 32);
+        } else {
+            /* RAZ/WI if no virt */
+            *data = 0;
+        }
+        return true;
+    case A_IRS_VPE_DBR + 4:
+        if (gicv5_domain_has_virt(cs, domain)) {
+            *data = extract64(cs->irs_vpe_dbr[domain], 32, 32);
+        } else {
+            /* RAZ/WI if no virt */
+            *data = 0;
+        }
+        return true;
     case A_IRS_VPE_STATUSR:
         if (gicv5_domain_has_virt(cs, domain)) {
             *data = cs->irs_vpe_statusr[domain];
@@ -2434,6 +2516,14 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
         irs_vpe_selr_write(s, domain,
                            deposit64(cs->irs_vpe_selr[domain], 32, 32, data));
         return true;
+    case A_IRS_VPE_DBR:
+        irs_vpe_dbr_write(s, domain,
+                          deposit64(cs->irs_vpe_dbr[domain], 0, 32, data));
+        return true;
+    case A_IRS_VPE_DBR + 4:
+        irs_vpe_dbr_write(s, domain,
+                          deposit64(cs->irs_vpe_dbr[domain], 32, 32, data));
+        return true;
     case A_IRS_SPI_SELR:
         cs->irs_spi_selr[domain] = data;
         return true;
@@ -2574,6 +2664,14 @@ static bool config_readll(GICv5 *s, GICv5Domain domain, hwaddr offset,
             *data = 0;
         }
         return true;
+    case A_IRS_VPE_DBR:
+        if (gicv5_domain_has_virt(cs, domain)) {
+            *data = cs->irs_vpe_dbr[domain];
+        } else {
+            /* RAZ/WI if no virt */
+            *data = 0;
+        }
+        return true;
     }
 
     return false;
@@ -2607,6 +2705,9 @@ static bool config_writell(GICv5 *s, GICv5Domain domain, hwaddr offset,
     case A_IRS_VPE_SELR:
         irs_vpe_selr_write(s, domain, data);
         return true;
+    case A_IRS_VPE_DBR:
+        irs_vpe_dbr_write(s, domain, data);
+        return true;
     }
 
     return false;
diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index 553598e3178..50365c4dfe6 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -115,6 +115,7 @@ static void gicv5_common_reset_hold(Object *obj, ResetType type)
         memset(cs->irs_vmap_l2_vistr, 0, sizeof(cs->irs_vmap_l2_vistr));
         memset(cs->irs_vmap_vper, 0, sizeof(cs->irs_vmap_vper));
         memset(cs->irs_vpe_selr, 0, sizeof(cs->irs_vpe_selr));
+        memset(cs->irs_vpe_dbr, 0, sizeof(cs->irs_vpe_dbr));
 
         for (int i = 0; i < NUM_GICV5_DOMAINS; i++) {
             cs->irs_vpe_statusr[i] = R_IRS_VPE_STATUSR_IDLE_MASK;
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index edfbf7d7157..b187ceefe45 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -254,6 +254,8 @@ gicv5_irs_vmap_vistr_write(const char *domain, uint32_t vmid, const char *type,
 gicv5_initialize_vpet(const char *domain, uint32_t vmid, uint32_t vpeid, bool valid) "GICv5 IRS %s VM ID %u VPE %u starts as valid %d"
 gicv5_irs_vmap_vper_write(const char *domain, uint32_t vmid, uint32_t vpeid) "GICv5 IRS %s VM ID %u VPE %u now made valid"
 gicv5_irs_vpe_selr_write(const char *domain, uint64_t selr, uint32_t status) "GICv5 IRS %s IRS_VPE_SELR written 0x%" PRIx64 " IRS_VPE_STATUSR now 0x%x"
+gicv5_irs_vpe_dbr_write(const char *domain, uint32_t vmid, uint32_t vpeid, uint8_t dbpm, uint32_t db_intid, bool db_req) "GICv5 IRS %s VM ID %u VPE %u IRS_VPE_DBR doorbell now valid: prio mask %u intid %u requested %d"
+gicv5_irs_vpe_dbr_write_nv(const char *domain, uint32_t vmid, uint32_t vpeid) "GICv5 IRS %s VM ID %u VPE %u IRS_VPE_DBR doorbell info no longer valid"
 
 # arm_gicv5_common.c
 gicv5_common_realize(uint32_t irsid, uint32_t num_cpus, uint32_t spi_base, uint32_t spi_irs_range, uint32_t spi_range) "GICv5 IRS realized: IRS ID %u, %u CPUs, SPI base %u, SPI IRS range %u, SPI range %u"
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index 5823a7f78a0..d82cc23d10c 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -98,6 +98,7 @@ struct GICv5Common {
     uint64_t irs_vmap_vper[NUM_GICV5_DOMAINS];
     uint64_t irs_vpe_selr[NUM_GICV5_DOMAINS];
     uint32_t irs_vpe_statusr[NUM_GICV5_DOMAINS];
+    uint64_t irs_vpe_dbr[NUM_GICV5_DOMAINS];
 
     /*
      * Pointer to an array of state information for the SPIs.  Array
-- 
2.43.0


