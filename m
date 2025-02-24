Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D086CC021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 19:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdpJ-0005iK-94; Mon, 24 Feb 2025 14:09:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmdoo-0005d2-Cw
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:08:45 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmdom-0004nB-B6
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:08:41 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-220ecbdb4c2so17471625ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 11:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740424118; x=1741028918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JPj0bGMKB5weN7nB95sHvNTAUUO2MS1Ep+drM1URK0w=;
 b=S5eTTgQr8a/bAwV00jSmU7mi+1YthBDeoD3S3rjnnuwoVNX/riXz3ORfnF+2kaOrls
 3gPBju7RykCgrG4VU5nAzy6w/e7CLpmjdo4RpVIpHnYGcIeqbwqWD16nus7XMLmF2HXm
 ruF9c5B6iOdLF+3DyDgvojCy8xKcHnQWmkYx3YqzjO9dtRW10Aw0Gni0G8XiRN4Hnsgc
 p2blPdvZCmb/tV4WWsj+Fn19RtxzqYVIFx7QVHUtMVgKHrpr73gjVfhP0Xvp+/oGJSJN
 +nCNq1PdSXPb0r2qKXng76oW/mztTrKikPqvC6TUP0QfCE+QTd8I35qN/rQZ/IwYo/hj
 XGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740424118; x=1741028918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JPj0bGMKB5weN7nB95sHvNTAUUO2MS1Ep+drM1URK0w=;
 b=wEfu2Bbl8JHBQNWaf/NukZ5GL9cOF8c/oszE9BBTHoCZ74ha1OXGl1PtmWUiboQmcz
 NGowlb+w0UbGXYxqXdlulduFcufADf1V9lGND63uwiD1vQxUQWhPin8eeIxiQ/6odg8s
 PIEBRJxTsvdTDGemuA9qPSzG8Ok2f1Y2AJhGKj/z0hLNy00tlN+O+5Yw4QGJ5fv+FyUG
 06grJEG+WsQUgrDkuquaxfsRr5C2VVNBDRzwyP0/887CRyri3V5rxM475qB+FoGq7BxR
 BYnUeR3hYXOuwxOhiCmv5+3hEB3z0cDwkf38KGC4N38jmXBnBSD7MnNwQubjuuAXXWoU
 qe0g==
X-Gm-Message-State: AOJu0YybkipyzetamnpRnc43kzjLeXVoj0afEZ9wqJx3MJrkf6nGttXg
 KHS/UqfGx2B1hnLOf6P8u1rWZG3mq2hViq4TnnXDiO2iAqpT0583QQUqY/7NEVZH+JNbKHsKAbc
 k
X-Gm-Gg: ASbGncvZOW3egWiiEFxI1euyw7BO2Wh95K1zmvH03lGwZI9i60XX9He4ceEmTvypYeR
 mPZEI9GuYosfa5vlkSrKWOUL8X09e+cIZqPMvW2o2bDtByLNSXE1FAdGFPmsq5leCaXJ7Z2iMe0
 OcOLrHusGMabwIM2CNE1toWnSRkntWx0DZetoMcEyRf92unz0pAqI1xhmlxBRgqAb/yRt9wUb6Y
 z2rNsce2PaGDLyFgwOYwUAPWlwGakE1xssZJdbq5dMaE4ArjkvHz6ao4EknE63cmU6VPy+bL8Cb
 ypk47t4vVY8iiS7f9vyufKksfOZVtg==
X-Google-Smtp-Source: AGHT+IFYhjaiPEStxe7iJhguFOlJkhsmR296m3qkWSYgJmmzVTrn7IWMNOHrxKTyJb3amy5qpvAmzg==
X-Received: by 2002:a17:902:f64c:b0:21f:49f2:e33f with SMTP id
 d9443c01a7336-221a0ed7885mr233705535ad.21.1740424117994; 
 Mon, 24 Feb 2025 11:08:37 -0800 (PST)
Received: from grind.. ([2804:7f0:bcc0:6edb:f473:a9df:d551:443b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545df28sm183583155ad.153.2025.02.24.11.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 11:08:37 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 02/11] hw/riscv/riscv-iommu-bits.h: HPM bits
Date: Mon, 24 Feb 2025 16:08:17 -0300
Message-ID: <20250224190826.1858473-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224190826.1858473-1-dbarboza@ventanamicro.com>
References: <20250224190826.1858473-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62c.google.com
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


