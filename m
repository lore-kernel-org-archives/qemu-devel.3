Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE978FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwtx-0000pK-2G; Wed, 29 Apr 2026 00:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwtu-0000iI-MI
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:51:54 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwto-00014K-45
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:51:49 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2b25cf1b5f0so66525025ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438307; x=1778043107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ji1NoMhMP6oxBXvm+pUAsoPg0oAMp1mJbkRgT3H2pso=;
 b=PwOtenrh2mBLd6oAqy58nW63YbskqEjsLweyjkt7CZtPCgqAN1xMLjK2WxYJsXOIl3
 Q7mRuW7OAc+eTDOhqhYB75WCDmFx9Hjlg4kDq7fFafeu3HRT0WkqpYRI3U93gcpkCsVI
 gY979ptFNlLxUrQyvJ0MLA+QXLDzNnqbkJ1YttJm3dgKAeUoqi2C8vZvyYBUNUOkpGho
 mzo1KoDyMBeTuruTx6WbazCwjeJvXRLhVQiopX8meweyhexyc/YeHL7g0Ru2yf2hTjKV
 uitxGosP/rYoXjaBFLEb7+VM10wFQeMiONMi5kS9OhEjUw0HnOpSYy9MjQxe98IyFbiV
 BTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438307; x=1778043107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ji1NoMhMP6oxBXvm+pUAsoPg0oAMp1mJbkRgT3H2pso=;
 b=ZIvSN2A8BEWJs2baJslz12e4gh5fZmc9hKX/9Lkkb+HIynM+EdwWBhESCHc7/h2maS
 QboFgusF9kYf1e9WbgVMJHRxKC4j54bYxmZkSXgHKznKTrRD6zSkpwg94yLSPfIdhv4u
 xMvHWMZ2Y0AMOfWapfKfXNo6Vr1UiZvRR83i/iowDyacH2rUy1V3iZIP9Txb1YiyP/gQ
 jTL5BfdR4x0dCbLORKpoRezqVfv77sQUNVXLVGlXdTq4doaj8NaR+ZL/vc6mM4ZPZwt5
 O7eLB9Myvb7QlWKsvVtyPP2aD9tcw3GkAlrYumOqN3wUVlfdwIdcMWbJRHX08W2+kUhi
 QGSA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/tHEahyG3/Zf4xvsgix2fXcpyEAwwVwg0aXwiIAZbPLFchjmKZ9OQi0MUtPdM081B3kn5xCUp8BbQv@nongnu.org
X-Gm-Message-State: AOJu0YxapD4I5sDxb6fzxKYRjaG3bGiu225ekdcsezpy2CAK0m8tYQkS
 hGcwYKJ00z1/DnQ2aMLdCHZvC5QKk5/+WPLu90cntrU48MxGvda1il4j
X-Gm-Gg: AeBDieupJytETNQAwb5zwXrIu5Dpp0V+YbFRmcXrPFcDVtf4T/41Qkzs7GGeOlUjQDS
 rLSOMfta6gpTYDLBKpjCdRdSl1Po0Yi9tnROoMlPakmb6DudLUVH69QQG9aOKZBPphV3a4qvtQM
 WK4EoBbubHypsd/Qude4xEOsccCuDrdvJB/pKiXwN8Ci2MUgq2AdSMMFy7X1cclYrAdgU0nKUcq
 QYO2cV5pVpQF6pKqErqfDvfOX3chF+fbmRu4wIsPPcy9HibdcboBa+zT3jl5RxLs63ROX+2BO/S
 n5md2SxOaGUb+Zw16ayytu/7AoLGCAU7aSh93XS5UCDg1I44BpzxRZ3TzedH0zrwNVw9cp9YAFw
 6uTLipMNU4WRrB++HqT8+Ui6boHvxsKY9nFRvTGAQgPQeOtdyW6Pl8Egh1PNDp95DwcRaT/ORWW
 WvXFhutbVlWWR2OMohLZ7MfRMGtAVj0/CCL5TVRNo8Dyg2TCMmZG6g
X-Received: by 2002:a17:902:e78f:b0:2b0:5795:9ead with SMTP id
 d9443c01a7336-2b98720063fmr20969775ad.0.1777438306816; 
 Tue, 28 Apr 2026 21:51:46 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:51:46 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 qemu-stable@nongnu.org, Nutty Liu <nutty.liu@hotmail.com>
Subject: [PULL 43/51] target/riscv: Don't OR mip.SEIP when mvien is one
Date: Wed, 29 Apr 2026 14:47:44 +1000
Message-ID: <20260429044752.4176397-44-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
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

From: Alistair Francis <alistair.francis@wdc.com>

The RISC-V spec states that

"""
But when bit 9 of mvien is one, bit SEIP in mip is read-only and does
not include the value of bit 9 of mvip. Rather, the value of mip.SEIP
is simply the supervisor external interrupt signal from the hart’s
external interrupt controller (APLIC or IMSIC).
"""

As such let's mark the mip.SEIP in rmw_mip64().

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2828
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20260415233740.3027321-4-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 80727aa81e..da366cf562 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3728,6 +3728,14 @@ static RISCVException rmw_mip64(CPURISCVState *env, int csrno,
     uint64_t old_mip, mask = wr_mask & delegable_ints;
     uint32_t gin;
 
+    /*
+     * When mvien[9]=1, mip.SEIP is read-only and reflects only
+     * the external interrupt signal from the interrupt controller.
+     */
+    if (env->mvien & MIP_SEIP) {
+        mask &= ~MIP_SEIP;
+    }
+
     if (mask & MIP_SEIP) {
         env->software_seip = new_val & MIP_SEIP;
         new_val |= env->external_seip * MIP_SEIP;
-- 
2.53.0


