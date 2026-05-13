Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9D2CD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 03:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN0ey-000581-C4; Tue, 12 May 2026 23:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wN0ew-00057W-Sz
 for qemu-devel@nongnu.org; Tue, 12 May 2026 23:53:22 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wN0ev-0006oE-98
 for qemu-devel@nongnu.org; Tue, 12 May 2026 23:53:22 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c8028fa6039so4146272a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 20:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1778644399; x=1779249199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+bxgENfIOWqGCFdj/P5sPamFsh4hBbf5NLHvp/A9rUo=;
 b=WQRCbQsaGWTIeo/duyg6Dy/YAfIDcBWxKz0fp0qF1TsoluElg7FNX79gSWBTbj8rmG
 ymMW6DGM4y7jvQGE/KK5vxi3/gdzT0z7aiqNB0cbTLGMr2PHd7tZse2FEl+AFlhGfoRw
 y0I8Txyn8OhAhGKI8JgGWonnM2unPbfkwGoHtsCXBQTdw5xpEhQaiuXDZ218HYsZl4W6
 FIZErgI+DjS+kYmFEZyz9Zl2Z/BjXpqx20H08MJ2VrO2lOtUzc5aN4mNrsqcTdXcS5j7
 HwSRG+Kq2bqQPy3or8vW10oLZoRT0gDUJJeAMafDH4rLG2ih6nqBE5CkwEqH3bdj4bWZ
 R/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778644399; x=1779249199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+bxgENfIOWqGCFdj/P5sPamFsh4hBbf5NLHvp/A9rUo=;
 b=MUZCwphOBeHesTpJDb6Vw0gYZZ5GDnv0CBQUa00REnGtr+NAbroFVpbgGH2Io+IaIh
 BBTQ0CrT0pLjMxUYjLDLgNezOxRVWAgzavVES8qe17vDiUiQtd78xQQ0oEZ10Z0m1T2t
 6uzjFLlv7NQqiXDKCG7XX+gF8t3gkjWjXPq4kBD1ykt0SDIXIVlVgINXUjy0HDnjO/YN
 4VyEL3CfZdC/a6yZN2znE9hhnGolIOZUYfuspS9SHRHwk0Gl27jRhk2dG1zxdZocSDv8
 DGYtzDq69vPmI0vAyy1Wv3U/nK+KCgKpPN4l/FxowY4cBPUrm255bnoLFAhJTBfkSlgn
 mCmg==
X-Gm-Message-State: AOJu0Yzz65qJr2Lpl7lFXqOHfm5OL8BZQfSnx4kAuUdS3BjSOd39zLcW
 Q0SquRDg3MKeaItnFaezR1CBNON8GeZ8xFGDxNaBWZiFf7xgNzwgjSApnUdBapFpayhSkl+0DEw
 5ndq0FgtG/8ko/lkg7M9P9VqjqC6cM93a10nR/MReInraDqo+T+yP34UHuKJtnLXD1ACsUgu5Su
 yZH6FANHjJA1sUA6/jdYPeyV8vFXzMlFCJcXVFsqaozciIJlP2
X-Gm-Gg: Acq92OFqIvb0ILl3MA7RDfNwWslujxhL6kk880NMYNpISj2Ck1UWSCowjsnD3amfVmY
 b4EqGHVOErFJJAn+hq2Gp1GU6X8h0Euv5cmILP3OnR9jK5KZ8/rX5ObL8fJ43KkFLAyNR2kRukg
 o5/k+o2/Gtc8/kkJzik9mNoppGJJvEAg3gRzZpVYVkkLnASqJ+Jeoz+OPS9spr8QPzD8dIo48TX
 L9LPcCPsSeutlIQyTMgL1doTezRvUAtMHKYxuH2rGA2nZZYHfXKUXNII3LACW4xAeEVZMCMVS6D
 NZ94UBmfJjRjEnWIhuWv4PhQCNEE+i4u2Lm9/IQBBIyDimxiyz7JHk0Dbe92WVwFzSGCMNOKldy
 1+6yzWmqdlFPalOSyTjfvfo5j12x//RqVyXyBYGEi0ZTepBy5pgmjnn51jbBsb+FDSRZ00eBq+x
 PxhJTSzA0xjc64b1xdMWV22LS0GUjHZW3pxD3+/y8DGTb8sl93hQ==
X-Received: by 2002:a05:6a20:3d20:b0:39f:3ca8:a315 with SMTP id
 adf61e73a8af0-3af80c7df0bmr1746431637.19.1778644399080; 
 Tue, 12 May 2026 20:53:19 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83967dbdfb0sm24317872b3a.45.2026.05.12.20.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 20:53:18 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 1/4] target/riscv: Add Zicclsm CPU option
Date: Wed, 13 May 2026 11:53:07 +0800
Message-ID: <20260513035310.3764218-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513035310.3764218-1-frank.chang@sifive.com>
References: <20260513035310.3764218-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x533.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Add Zicclsm CPU option so that user can turn on/off misaligned loads
and stores support.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                | 2 +-
 target/riscv/cpu_cfg_fields.h.inc | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a13727c0d4b..468055ee090 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -127,7 +127,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
     ISA_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
-    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, ext_zicclsm),
     ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_ziccrse),
     ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
     ISA_EXT_DATA_ENTRY(zicfiss, PRIV_VERSION_1_13_0, ext_zicfiss),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 734fa079f28..fc55dc6d892 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -139,6 +139,8 @@ BOOL_FIELD(has_priv_1_11)
 /* Always enabled for TCG if has_priv_1_11 */
 BOOL_FIELD(ext_ziccrse)
 
+BOOL_FIELD(ext_zicclsm)
+
 /* Vendor-specific custom extensions */
 BOOL_FIELD(ext_xtheadba)
 BOOL_FIELD(ext_xtheadbb)
-- 
2.43.0


