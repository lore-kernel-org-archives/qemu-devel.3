Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BECC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 01:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbsJK-0004iH-QQ; Sun, 18 Feb 2024 20:19:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rbsIR-0003My-Li; Sun, 18 Feb 2024 20:18:17 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rbsIQ-0004IR-5Y; Sun, 18 Feb 2024 20:18:15 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-60843233278so306607b3.3; 
 Sun, 18 Feb 2024 17:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708305493; x=1708910293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m35zG+ajLJL60pM6bIM9adMNO13lGgmKjK7XnKNpmk8=;
 b=HOBPdit1pZ9sWYbhvqInIi1SI6O/0+3Aut9AUggmU1XD0Du2ZM4ogGaTO0D21SguJP
 q3lByDeR+A64/X6X/sr4AP19ESON6Sra8BeJt3Rz0iqwRPpONBRigrRI+HvsKTKlyjd+
 GbRmcQ0qULhzLdTDuYJzqdDWq1Pl9jgiE4pigL1ZUoY6nSZqdJQc/ZuyX2h2vbpf5K2g
 rFKq+ceQccQvp75fLDX5SBp+PnWUm8vQlXXjiMadSaghBvuKEgpuk1cvuznIHYzUG5PK
 iJwPsU8kEnTlStsdJtee3aYF70kBRZ5OK0uiDdArSkk8An5lMkbbsqz6aq9IvYFo5Qk5
 5S+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708305493; x=1708910293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m35zG+ajLJL60pM6bIM9adMNO13lGgmKjK7XnKNpmk8=;
 b=wK1sIfH2aWstFum/uTlIETZfLZ2f4aJjccCGNMGORglLu70sky72+pHGK5XZMDX84Q
 rqlCxaWol3SVlq20eKK8W+oDrhz6PWzUZiuxXcbIg0ei42qfxGvqePmm4H2csN10q9iZ
 LhiHts2Vfn0T6DjJdcVUGg40f6LnBHco839lZ3t3eb8q922zwAQiI6veROgYhfCB6NwW
 tvj2arbYI7Z8tSFUVC+rhWwefFM67EqpbFcjuj73vc5avhzZo7v9fqWVR3bT8MRnIR4o
 HtJhn6UYC56EY7FxFG1ecterjzDk+cEA2vY6EPPzNJqWz8kj5j2Y6J2wV1Um/2ryGBKR
 UpHA==
X-Gm-Message-State: AOJu0YyJfXrMojgDWjS5CptJ+GSi+hBAF4SAJsIiK2LeuCQBBGXp2sM0
 J2WRMhEA8zZND+vlV9+p4I2nbDWMeX7lvtK86BEjYguj4+oc2gygIaxURHyaI3U=
X-Google-Smtp-Source: AGHT+IF2qhbPQGyBSQLuuEIsJ0iw68PRemVuEPRbWtd9o2ZYMICAcylB7JS4S4c5Oh5ZJCR0WmZ6CQ==
X-Received: by 2002:a81:431f:0:b0:608:e2f:e3d2 with SMTP id
 q31-20020a81431f000000b006080e2fe3d2mr4191567ywa.22.1708305492731; 
 Sun, 18 Feb 2024 17:18:12 -0800 (PST)
Received: from localhost.localdomain ([201.203.117.224])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a819e0c000000b00607ff905ed3sm1204704ywj.58.2024.02.18.17.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Feb 2024 17:18:12 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v5 23/41] Add GENET register structs. Part 4
Date: Sun, 18 Feb 2024 19:17:21 -0600
Message-Id: <20240219011739.2316619-24-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
References: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 include/hw/net/bcm2838_genet.h | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index 1bd004785a..94c2f3ebca 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -25,6 +25,12 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_HFB_FILTER_CNT      48
 #define BCM2838_GENET_HFB_FILTER_SIZE     128
 
+#define BCM2838_GENET_PHY_AUX_CTL_MISC  0x7
+#define BCM2838_GENET_PHY_AUX_CTL_REGS_SIZE 8
+
+#define BCM2838_GENET_PHY_EXP_SHD_BLOCKS_CNT 256
+#define BCM2838_GENET_PHY_EXP_SHD_REGS_CNT   256
+
 typedef struct {
     uint32_t rev_ctrl;
     uint32_t port_ctrl;
@@ -273,6 +279,34 @@ typedef struct {
     uint16_t rdb_data;
 } BCM2838GenetPhyRegs;
 
+typedef struct {
+    uint16_t reserved_0_2[3];
+    uint16_t clk_ctl;
+    uint16_t scr2;
+    uint16_t scr3;
+    uint16_t reserved_6_9[4];
+    uint16_t apd;
+    uint16_t rgmii_mode;
+    uint16_t reserved_12;
+    uint16_t leds1;
+    uint16_t reserved_14_18[5];
+    uint16_t _100fx_ctrl;
+    uint16_t ssd;
+    uint16_t reserved_21_30[10];
+    uint16_t mode;
+} BCM2838GenetPhyShdRegs;
+
+typedef struct {
+    uint16_t auxctl;
+    uint16_t reserved_1_6[BCM2838_GENET_PHY_AUX_CTL_REGS_SIZE - 2];
+    uint16_t misc;
+} BCM2838GenetPhyAuxShdRegs;
+
+typedef struct {
+    uint16_t regs[BCM2838_GENET_PHY_EXP_SHD_BLOCKS_CNT]
+                 [BCM2838_GENET_PHY_EXP_SHD_REGS_CNT];
+} BCM2838GenetPhyExpShdRegs;
+
 struct BCM2838GenetState {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -284,6 +318,9 @@ struct BCM2838GenetState {
 
     BCM2838GenetRegs regs;
     BCM2838GenetPhyRegs phy_regs;
+    BCM2838GenetPhyShdRegs phy_shd_regs;
+    BCM2838GenetPhyAuxShdRegs phy_aux_ctl_shd_regs;
+    BCM2838GenetPhyExpShdRegs phy_exp_shd_regs;
 
     qemu_irq irq_default;
     qemu_irq irq_prio;
-- 
2.34.1


