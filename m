Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D2310ED65C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65Bq-0006UR-5V; Fri, 27 Mar 2026 07:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Bj-0006Pd-Cj
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:15 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Bh-0007m3-2q
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:14 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-439b9b190easo1387289f8f.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610231; x=1775215031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L2i2X+U/t9okZTf4XS2NhEngJ3FvRUCSx/JHhx+JgBY=;
 b=ENlt1IT/O1DB6YVEGHD6CEmymURnN3GK/Xbq1+w1Fls/VxaTQXLUf5zL90hT+VCQan
 KghV4ktbxkBoD/gbEa+5tIOzHVb/9LtKGuTbi0MmFy4a6b39Em/+ndmkJ/yTop1gcyQL
 HF+/IGaxgqiezdR/Pa0pJyLdSoFgl59suFxKazDjrKtpL/dibshJztkneYW8FszAaMdb
 ro2qA9B1m8pQriLdm3ssr8XZwKqmBdg90Ss5dYTrf/8kQlGeSC+rvMAUuN6J8gEjryTX
 dR4bLfoKnVPGN9DTMDoUoLEjCf6J3JvU0q8/KogPLjAYLTrNe63TH4R93+Ybx8e+6ERF
 BRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610231; x=1775215031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L2i2X+U/t9okZTf4XS2NhEngJ3FvRUCSx/JHhx+JgBY=;
 b=RaasysB+8QLoNIAc1GgWu1llo+aShJPP+j7B9UDb8vBfoQxCzsXozVDWoWnulADaYj
 dJMr29JETNtyKDxLUzJfO0RRARn+OCKmmpCeeXrEjd9fGl4jX9hU9qvIBo2PCKZFO1vk
 iXO0SNI/uM2hFzipnqJEqbuDEV7vgvHFP1GxoMRAx9wAf47q5V+gNbsVhRUQZesRAMqX
 bkQzi5BRaCmig/O2iXmFaH/1i7W+e7dJb1g7LF/y7YUFd6+uutfQ5nuqA0ojAqgSdcLX
 6Q560hKzpH+/VWmwMzj//CrMCY1kENJPNocMaHW/3S+1M6yrxir0ze+wxHcU1JcFftpv
 yBkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9vRU0w5XxutznIMgUZRgiiDioPiws9MHawODpoQGcSHzwHon3TIL6NAswreScK59X+mBHC6dhw0IN@nongnu.org
X-Gm-Message-State: AOJu0Yzt3gZl++gjvdq0Vvpw/BKc+NVdhs3BxBxlGR9MbZvpPzHTxsgO
 dYDViErk5jTRs/TTtNA7otTzeKt3oANsqA3cLSN4GiNQP/D/Jil1H8Oj5NnbDrbBDfo=
X-Gm-Gg: ATEYQzyN9uPhV5XzPHPwRe7Z5K74aMDDd7+yQTbqoBD52eSUgZhrf8hqqLVSHcVI0bi
 PdEnq5kT8OmntV3oqbx6IS/0CJHIFR3KcIA8T5tZv/53eJjCMwl9LG90t8VI0emlcUqFXf2W4vp
 FcBwkZLfXzajkMDIWK9nYd5pzk/W0dsNtH/HfRUpkbr3V9y4LPjXTc2gt5ZQ6EhemZG3gkm5pNV
 xQKkdhG7d8+XHxOyxceF4cxbJHJT/+Yxi90Ab5sxRfwOL5nQ3tk2a812B/GkG+SljykPf5e4QnJ
 4aOx0ezsYmO/DoJgNj1E1GtyN7tZECaGuEe4lmbXh7m9gin31dkBTHAyAZQbaPC/UOjMhFPbxL0
 WM+/8AaQgAdvk1u4RR4WyVx4uXnsme4BQYFptVrkvsbTYeznEaK4IWEhZpggUldVDhyuOa59iST
 k+pUckwMbwZdUW1bU8bUCb97MspQWnQ+4FB0XB+yP7+CXdJFklJqgXfeo5d+B6l4qR7RMHegm+/
 q79PFSanGN1wlpxEchxV/2p26W/RjM=
X-Received: by 2002:a05:6000:1ac8:b0:43a:c70:6f0d with SMTP id
 ffacd0b85a97d-43b9e99039fmr3534240f8f.20.1774610230632; 
 Fri, 27 Mar 2026 04:17:10 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 09/65] hw/intc/arm_gicv5: Define macros for config frame
 registers
Date: Fri, 27 Mar 2026 11:16:04 +0000
Message-ID: <20260327111700.795099-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Define constants for the various registers in the IRS config frame
using the REG and FIELD macros.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/intc/arm_gicv5.c | 243 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 243 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index cb1234b022..4c1ec8f30a 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -7,6 +7,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/core/registerfields.h"
 #include "hw/intc/arm_gicv5.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
@@ -22,6 +23,248 @@ static const char *domain_name[] = {
     [GICV5_ID_REALM] = "Realm",
 };
 
+REG32(IRS_IDR0, 0x0)
+    FIELD(IRS_IDR0, INT_DOM, 0, 2)
+    FIELD(IRS_IDR0, PA_RANGE, 2, 4)
+    FIELD(IRS_IDR0, VIRT, 6, 1)
+    FIELD(IRS_IDR0, ONE_N, 7, 1)
+    FIELD(IRS_IDR0, VIRT_ONE_N, 8, 1)
+    FIELD(IRS_IDR0, SETLPI, 9, 1)
+    FIELD(IRS_IDR0, MEC, 10, 1)
+    FIELD(IRS_IDR0, MPAM, 11, 1)
+    FIELD(IRS_IDR0, SWE, 12, 1)
+    FIELD(IRS_IDR0, IRSID, 16, 16)
+
+REG32(IRS_IDR1, 0x4)
+    FIELD(IRS_IDR1, PE_CNT, 0, 16)
+    FIELD(IRS_IDR1, IAFFID_BITS, 16, 4)
+    FIELD(IRS_IDR1, PRI_BITS, 20, 3)
+
+REG32(IRS_IDR2, 0x8)
+    FIELD(IRS_IDR2, ID_BITS, 0, 5)
+    FIELD(IRS_IDR2, LPI, 5, 1)
+    FIELD(IRS_IDR2, MIN_LPI_ID_BITS, 6, 4)
+    FIELD(IRS_IDR2, IST_LEVELS, 10, 1)
+    FIELD(IRS_IDR2, IST_L2SZ, 11, 3)
+    FIELD(IRS_IDR2, IST_MD, 14, 1)
+    FIELD(IRS_IDR2, ISTMD_SZ, 15, 5)
+
+REG32(IRS_IDR3, 0xc)
+    FIELD(IRS_IDR3, VMD, 0, 1)
+    FIELD(IRS_IDR3, VMD_SZ, 1, 4)
+    FIELD(IRS_IDR3, VM_ID_BITS, 5, 5)
+    FIELD(IRS_IDR3, VMT_LEVELS, 10, 1)
+
+REG32(IRS_IDR4, 0x10)
+    FIELD(IRS_IDR4, VPED_SZ, 0, 6)
+    FIELD(IRS_IDR4, VPE_ID_BITS, 6, 4)
+
+REG32(IRS_IDR5, 0x14)
+    FIELD(IRS_IDR5, SPI_RANGE, 0, 25)
+
+REG32(IRS_IDR6, 0x18)
+    FIELD(IRS_IDR6, SPI_IRS_RANGE, 0, 25)
+
+REG32(IRS_IDR7, 0x1c)
+    FIELD(IRS_IDR7, SPI_BASE, 0, 24)
+
+REG32(IRS_IIDR, 0x40)
+    FIELD(IRS_IIDR, IMPLEMENTER, 0, 12)
+    FIELD(IRS_IIDR, REVISION, 12, 4)
+    FIELD(IRS_IIDR, VARIANT, 16, 4)
+    FIELD(IRS_IIDR, PRODUCTID, 20, 12)
+
+REG32(IRS_AIDR, 0x44)
+    FIELD(IRS_AIDR, ARCHMINORREV, 0, 4)
+    FIELD(IRS_AIDR, ARCHMAJORREV, 4, 4)
+    FIELD(IRS_AIDR, COMPONENT, 8, 4)
+
+REG32(IRS_CR0, 0x80)
+    FIELD(IRS_CR0, IRSEN, 0, 1)
+    FIELD(IRS_CR0, IDLE, 1, 1)
+
+REG32(IRS_CR1, 0x84)
+    FIELD(IRS_CR1, SH, 0, 2)
+    FIELD(IRS_CR1, OC, 2, 2)
+    FIELD(IRS_CR1, IC, 4, 2)
+    FIELD(IRS_CR1, IST_RA, 6, 1)
+    FIELD(IRS_CR1, IST_WA, 7, 1)
+    FIELD(IRS_CR1, VMT_RA, 8, 1)
+    FIELD(IRS_CR1, VMT_WA, 9, 1)
+    FIELD(IRS_CR1, VPET_RA, 10, 1)
+    FIELD(IRS_CR1, VPET_WA, 11, 1)
+    FIELD(IRS_CR1, VMD_RA, 12, 1)
+    FIELD(IRS_CR1, VMD_WA, 13, 1)
+    FIELD(IRS_CR1, VPED_RA, 14, 1)
+    FIELD(IRS_CR1, VPED_WA, 15, 1)
+
+REG32(IRS_SYNCR, 0xc0)
+    FIELD(IRS_SYNCR, SYNC, 31, 1)
+
+REG32(IRS_SYNC_STATUSR, 0xc4)
+    FIELD(IRS_SYNC_STATUSR, IDLE, 0, 1)
+
+REG64(IRS_SPI_VMR, 0x100)
+    FIELD(IRS_SPI_VMR, VM_ID, 0, 16)
+    FIELD(IRS_SPI_VMR, VIRT, 63, 1)
+
+REG32(IRS_SPI_SELR, 0x108)
+    FIELD(IRS_SPI_SELR, ID, 0, 24)
+
+REG32(IRS_SPI_DOMAINR, 0x10c)
+    FIELD(IRS_SPI_DOMAINR, DOMAIN, 0, 2)
+
+REG32(IRS_SPI_RESAMPLER, 0x110)
+    FIELD(IRS_SPI_RESAMPLER, SPI_ID, 0, 24)
+
+REG32(IRS_SPI_CFGR, 0x114)
+    FIELD(IRS_SPI_CFGR, TM, 0, 1)
+
+REG32(IRS_SPI_STATUSR, 0x118)
+    FIELD(IRS_SPI_STATUSR, IDLE, 0, 1)
+    FIELD(IRS_SPI_STATUSR, V, 1, 1)
+
+REG32(IRS_PE_SELR, 0x140)
+    FIELD(IRS_PE_SELR, IAFFID, 0, 16)
+
+REG32(IRS_PE_STATUSR, 0x144)
+    FIELD(IRS_PE_STATUSR, IDLE, 0, 1)
+    FIELD(IRS_PE_STATUSR, V, 1, 1)
+    FIELD(IRS_PE_STATUSR, ONLINE, 2, 1)
+
+REG32(IRS_PE_CR0, 0x148)
+    FIELD(IRS_PE_CR0, DPS, 0, 1)
+
+REG64(IRS_IST_BASER, 0x180)
+    FIELD(IRS_IST_BASER, VALID, 0, 1)
+    FIELD(IRS_IST_BASER, ADDR, 6, 50)
+
+REG32(IRS_IST_CFGR, 0x190)
+    FIELD(IRS_IST_CFGR, LPI_ID_BITS, 0, 5)
+    FIELD(IRS_IST_CFGR, L2SZ, 5, 2)
+    FIELD(IRS_IST_CFGR, ISTSZ, 7, 2)
+    FIELD(IRS_IST_CFGR, STRUCTURE, 16, 1)
+
+REG32(IRS_IST_STATUSR, 0x194)
+    FIELD(IRS_IST_STATUSR, IDLE, 0, 1)
+
+REG32(IRS_MAP_L2_ISTR, 0x1c0)
+    FIELD(IRS_MAP_L2_ISTR, ID, 0, 24)
+
+REG64(IRS_VMT_BASER, 0x200)
+    FIELD(IRS_VMT_BASER, VALID, 0, 1)
+    FIELD(IRS_VMT_BASER, ADDR, 3, 53)
+
+REG32(IRS_VMT_CFGR, 0x210)
+    FIELD(IRS_VMT_CFGR, VM_ID_BITS, 0, 5)
+    FIELD(IRS_VMT_CFGR, STRUCTURE, 16, 1)
+
+REG32(IRS_VMT_STATUSR, 0x124)
+    FIELD(IRS_VMT_STATUSR, IDLE, 0, 1)
+
+REG64(IRS_VPE_SELR, 0x240)
+    FIELD(IRS_VPE_SELR, VM_ID, 0, 16)
+    FIELD(IRS_VPE_SELR, VPE_ID, 32, 16)
+    FIELD(IRS_VPE_SELR, S, 63, 1)
+
+REG64(IRS_VPE_DBR, 0x248)
+    FIELD(IRS_VPE_DBR, INTID, 0, 24)
+    FIELD(IRS_VPE_DBR, DBPM, 32, 5)
+    FIELD(IRS_VPE_DBR, REQ_DB, 62, 1)
+    FIELD(IRS_VPE_DBR, DBV, 63, 1)
+
+REG32(IRS_VPE_HPPIR, 0x250)
+    FIELD(IRS_VPE_HPPIR, ID, 0, 24)
+    FIELD(IRS_VPE_HPPIR, TYPE, 29, 3)
+    FIELD(IRS_VPE_HPPIR, HPPIV, 32, 1)
+
+REG32(IRS_VPE_CR0, 0x258)
+    FIELD(IRS_VPE_CR0, DPS, 0, 1)
+
+REG32(IRS_VPE_STATUSR, 0x25c)
+    FIELD(IRS_VPE_STATUSR, IDLE, 0, 1)
+    FIELD(IRS_VPE_STATUSR, V, 1, 1)
+
+REG64(IRS_VM_DBR, 0x280)
+    FIELD(IRS_VM_DBR, VPE_ID, 0, 16)
+    FIELD(IRS_VM_DBR, EN, 63, 1)
+
+REG32(IRS_VM_SELR, 0x288)
+    FIELD(IRS_VM_SELR, VM_ID, 0, 16)
+
+REG32(IRS_VM_STATUSR, 0x28c)
+    FIELD(IRS_VM_STATUSR, IDLE, 0, 1)
+    FIELD(IRS_VM_STATUSR, V, 1, 1)
+
+REG64(IRS_VMAP_L2_VMTR, 0x2c0)
+    FIELD(IRS_VMAP_L2_VMTR, VM_ID, 0, 16)
+    FIELD(IRS_VMAP_L2_VMTR, M, 63, 1)
+
+REG64(IRS_VMAP_VMR, 0x2c8)
+    FIELD(IRS_VMAP_VMR, VM_ID, 0, 16)
+    FIELD(IRS_VMAP_VMR, U, 62, 1)
+    FIELD(IRS_VMAP_VMR, M, 63, 1)
+
+REG64(IRS_VMAP_VISTR, 0x2d0)
+    FIELD(IRS_VMAP_VISTR, TYPE, 29, 3)
+    FIELD(IRS_VMAP_VISTR, VM_ID, 32, 16)
+    FIELD(IRS_VMAP_VISTR, U, 62, 1)
+    FIELD(IRS_VMAP_VISTR, M, 63, 1)
+
+REG64(IRS_VMAP_L2_VISTR, 0x2d8)
+    FIELD(IRS_VMAP_L2_VISTR, ID, 0, 24)
+    FIELD(IRS_VMAP_L2_VISTR, TYPE, 29, 3)
+    FIELD(IRS_VMAP_L2_VISTR, VM_ID, 32, 16)
+    FIELD(IRS_VMAP_L2_VISTR, M, 63, 1)
+
+REG64(IRS_VMAP_VPER, 0x2e0)
+    FIELD(IRS_VMAP_VPER, VPE_ID, 0, 16)
+    FIELD(IRS_VMAP_VPER, VM_ID, 32, 16)
+    FIELD(IRS_VMAP_VPER, M, 63, 1)
+
+REG64(IRS_SAVE_VMR, 0x300)
+    FIELD(IRS_SAVE_VMR, VM_ID, 0, 16)
+    FIELD(IRS_SAVE_VMR, Q, 62, 1)
+    FIELD(IRS_SAVE_VMR, S, 63, 1)
+
+REG32(IRS_SAVE_VM_STATUSR, 0x308)
+    FIELD(IRS_SAVE_VM_STATUSR, IDLE, 0, 1)
+    FIELD(IRS_SAVE_VM_STATUSR, Q, 1, 1)
+
+REG32(IRS_MEC_IDR, 0x340)
+    FIELD(IRS_MEC_IDR, MECIDSIZE, 0, 4)
+
+REG32(IRS_MEC_MECID_R, 0x344)
+    FIELD(IRS_MEC_MICID_R, MECID, 0, 16)
+
+REG32(IRS_MPAM_IDR, 0x380)
+    FIELD(IRS_MPAM_IDR, PARTID_MAX, 0, 16)
+    FIELD(IRS_MPAM_IDR, PMG_MAX, 16, 8)
+    FIELD(IRS_MPAM_IDR, HAS_MPAM_SP, 24, 1)
+
+REG32(IRS_MPAM_PARTID_R, 0x384)
+    FIELD(IRS_MPAM_IDR, PARTID, 0, 16)
+    FIELD(IRS_MPAM_IDR, PMG, 16, 8)
+    FIELD(IRS_MPAM_IDR, MPAM_SP, 24, 2)
+    FIELD(IRS_MPAM_IDR, IDLE, 31, 1)
+
+REG64(IRS_SWERR_STATUSR, 0x3c0)
+    FIELD(IRS_SWERR_STATUSR, V, 0, 1)
+    FIELD(IRS_SWERR_STATUSR, S0V, 1, 1)
+    FIELD(IRS_SWERR_STATUSR, S1V, 2, 1)
+    FIELD(IRS_SWERR_STATUSR, OF, 3, 1)
+    FIELD(IRS_SWERR_STATUSR, EC, 16, 8)
+    FIELD(IRS_SWERR_STATUSR, IMP_EC, 24, 8)
+
+REG64(IRS_SWERR_SYNDROMER0, 0x3c8)
+    FIELD(IRS_SWERR_SYNDROMER0, VM_ID, 0, 16)
+    FIELD(IRS_SWERR_SYNDROMER0, ID, 32, 24)
+    FIELD(IRS_SWERR_SYNDROMER0, TYPE, 60, 3)
+    FIELD(IRS_SWERR_SYNDROMER0, VIRTUAL, 63, 1)
+
+REG64(IRS_SWERR_SYNDROMER1, 0x3d0)
+    FIELD(IRS_SWERR_SYNDROMER2, ADDR, 3, 53)
+
 static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
                          uint64_t *data, MemTxAttrs attrs)
 {
-- 
2.43.0


