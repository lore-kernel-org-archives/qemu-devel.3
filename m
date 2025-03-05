Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841E9C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdzM-00080S-5g; Tue, 04 Mar 2025 20:56:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyd-0006nZ-Rr
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:17 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyb-0000Oh-5b
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:14 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22374f56453so116383555ad.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139711; x=1741744511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HQNVj2T2mfEf1ChTebr01tmxgkp7uoU2ummH0YbKr2Y=;
 b=Mak9qQgOGrOsj/lG2MrRDUMzBGK+J1KDPH+OfdESOz0FxDEJCy94HTPP78FqwVBpfo
 a31YsP4p/p9kgd3wUgCrBxm7Dxan49rE93eubzYEU4/rUloFNYGr07L54YYMm+qMjXWV
 qCgSod1Aq6WbG/dTlZpgyOS1/3tSrRqYXnxeLtAeqxbN8c/MidcGh08aoE/TeHsklvFa
 W9w8eZeLY9wOTY4Js7DeGE9SS84i4DXq/tZnkPsBs+0EmtFasBXg5w0V5mm8xeBrAIHX
 m8q1n3Ynui4gotXx+ka6+WXdZArQ/Y7IggNILIvrG8rEiPXrVXjBBmJfCkpbUUCSx5GE
 fM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139711; x=1741744511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HQNVj2T2mfEf1ChTebr01tmxgkp7uoU2ummH0YbKr2Y=;
 b=M6/pN2LB+vKHO05GxNzJet3WDqlv1FDILxARc1mNRwF4ES/JnyGV6xq3BA578dWwAV
 rNK7VPfNklew7+dMTgdDwOJZPt3zZ7ZOumpTbYZ7iHQncfxHmkmpM8b5tq88rhHtqhM5
 g05mgMhTuWnNhGNn3d7RD26CJ5+sAaMEnKWvF5a1cga8CBZMpA9Me7xD7LrFGPqzoyMW
 upqfnOd9ljIGeZsD09f4q9gUtuercp3ffx5NLhYUA/JitSkxu0VNBvpa7yEZWXOmypAo
 SmHpS28q4ARenopFu7vIgbWtc+IdS8Q+U51Tei8G+ABTnAAnfTOzTU+MmG6fRomEd1ew
 ygDQ==
X-Gm-Message-State: AOJu0Yxz4kbkcNyGdqPb8kCSVwJQa2ZUMQ5svztrM3ZZvJWzYsOmAaQI
 5rsrozGATFDV9wlTVLCaicDsepqmIkcAmf83Whm9V4nl0slLKQFcLP09CHueSso=
X-Gm-Gg: ASbGnctiFujIEC06/auSBlX0zwY+kN5RdYD7BcgFRukANofeX8pZGzeWmGPvyKeXqsv
 IiAw/ZUVpburmCxqEkiSwbXSeEydSyFnhdxa+TwqME1xSKRs3RcpNIIaAPLJJ3OqU5YqOQWyte9
 EVcv7V8LOgw46IZKBFcqVNhUOKh+wvmKxu7M67xqK1N+qOWlYaQohUy9fYESqmbtVApsQEaDWdc
 p4CtnVXPatrhrG0Y81XAfGafKsfTFiBcF8SNuzkJ2KCLYx0OTyRJzdjgQTKfGLYb8fwJpakDuCU
 HfvcOWiKsbC1rMiye+gEtYHgZkM0g14c4NHcCwdSrkVynrnJfyXYjx4rxiQie9vpQZUbRIdKXUA
 fBx1Y62yxPYMgE6CmjxyKxnw5d8wu8S/x2oa/qUj8d1bl+/sjNDg=
X-Google-Smtp-Source: AGHT+IE7FsfLZHCg3zDQ1Odt4oanj5JZK3dYTBX1OZH175zD6zbeEKoGdPI7QoAaRSjBVExVUtDCkA==
X-Received: by 2002:a17:902:d485:b0:220:c164:6ee1 with SMTP id
 d9443c01a7336-223f1d20341mr21954115ad.32.1741139711446; 
 Tue, 04 Mar 2025 17:55:11 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.55.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:55:10 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 40/59] hw/riscv/riscv-iommu-bits.h: HPM bits
Date: Wed,  5 Mar 2025 11:52:48 +1000
Message-ID: <20250305015307.1463560-41-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Add the relevant HPM (High Performance Monitor) bits that we'll be using
in the next patches.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250224190826.1858473-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu-bits.h | 47 +++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
index de599b80d6..b7cb1bc736 100644
--- a/hw/riscv/riscv-iommu-bits.h
+++ b/hw/riscv/riscv-iommu-bits.h
@@ -88,6 +88,7 @@ struct riscv_iommu_pq_record {
 #define RISCV_IOMMU_CAP_ATS             BIT_ULL(25)
 #define RISCV_IOMMU_CAP_T2GPA           BIT_ULL(26)
 #define RISCV_IOMMU_CAP_IGS             GENMASK_ULL(29, 28)
+#define RISCV_IOMMU_CAP_HPM             BIT_ULL(30)
 #define RISCV_IOMMU_CAP_DBG             BIT_ULL(31)
 #define RISCV_IOMMU_CAP_PAS             GENMASK_ULL(37, 32)
 #define RISCV_IOMMU_CAP_PD8             BIT_ULL(38)
@@ -197,6 +198,52 @@ enum {
     RISCV_IOMMU_INTR_COUNT
 };
 
+#define RISCV_IOMMU_IOCOUNT_NUM         31
+
+/* 5.19 Performance monitoring counter overflow status (32bits) */
+#define RISCV_IOMMU_REG_IOCOUNTOVF      0x0058
+#define RISCV_IOMMU_IOCOUNTOVF_CY       BIT(0)
+
+/* 5.20 Performance monitoring counter inhibits (32bits) */
+#define RISCV_IOMMU_REG_IOCOUNTINH      0x005C
+#define RISCV_IOMMU_IOCOUNTINH_CY       BIT(0)
+
+/* 5.21 Performance monitoring cycles counter (64bits) */
+#define RISCV_IOMMU_REG_IOHPMCYCLES     0x0060
+#define RISCV_IOMMU_IOHPMCYCLES_COUNTER GENMASK_ULL(62, 0)
+#define RISCV_IOMMU_IOHPMCYCLES_OVF     BIT_ULL(63)
+
+/* 5.22 Performance monitoring event counters (31 * 64bits) */
+#define RISCV_IOMMU_REG_IOHPMCTR_BASE   0x0068
+#define RISCV_IOMMU_REG_IOHPMCTR(_n)    \
+    (RISCV_IOMMU_REG_IOHPMCTR_BASE + (_n * 0x8))
+
+/* 5.23 Performance monitoring event selectors (31 * 64bits) */
+#define RISCV_IOMMU_REG_IOHPMEVT_BASE   0x0160
+#define RISCV_IOMMU_REG_IOHPMEVT(_n)    \
+    (RISCV_IOMMU_REG_IOHPMEVT_BASE + (_n * 0x8))
+#define RISCV_IOMMU_IOHPMEVT_EVENT_ID   GENMASK_ULL(14, 0)
+#define RISCV_IOMMU_IOHPMEVT_DMASK      BIT_ULL(15)
+#define RISCV_IOMMU_IOHPMEVT_PID_PSCID  GENMASK_ULL(35, 16)
+#define RISCV_IOMMU_IOHPMEVT_DID_GSCID  GENMASK_ULL(59, 36)
+#define RISCV_IOMMU_IOHPMEVT_PV_PSCV    BIT_ULL(60)
+#define RISCV_IOMMU_IOHPMEVT_DV_GSCV    BIT_ULL(61)
+#define RISCV_IOMMU_IOHPMEVT_IDT        BIT_ULL(62)
+#define RISCV_IOMMU_IOHPMEVT_OF         BIT_ULL(63)
+
+enum RISCV_IOMMU_HPMEVENT_id {
+    RISCV_IOMMU_HPMEVENT_INVALID    = 0,
+    RISCV_IOMMU_HPMEVENT_URQ        = 1,
+    RISCV_IOMMU_HPMEVENT_TRQ        = 2,
+    RISCV_IOMMU_HPMEVENT_ATS_RQ     = 3,
+    RISCV_IOMMU_HPMEVENT_TLB_MISS   = 4,
+    RISCV_IOMMU_HPMEVENT_DD_WALK    = 5,
+    RISCV_IOMMU_HPMEVENT_PD_WALK    = 6,
+    RISCV_IOMMU_HPMEVENT_S_VS_WALKS = 7,
+    RISCV_IOMMU_HPMEVENT_G_WALKS    = 8,
+    RISCV_IOMMU_HPMEVENT_MAX        = 9
+};
+
 /* 5.24 Translation request IOVA (64bits) */
 #define RISCV_IOMMU_REG_TR_REQ_IOVA     0x0258
 
-- 
2.48.1


