Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852E01091930
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3MlV-00020j-9D; Thu, 19 Mar 2026 19:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3MlD-0001Rl-1O
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:26:39 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3MlB-0007jI-7q
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:26:38 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2adff872068so274745ad.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773962793; x=1774567593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RYB7pnWPDF09kxM2pVeCxMznDuYzQx/e50Ubr54oZJY=;
 b=XLpZJGAEdls4o7FiLQKpDqhaTrzTxJWVbLTmscYyW/Iv/dCCAN+hxa6IDk45lFVE0Z
 hCkhlXmvSympn1Z8M0g+d3zXMQDiq5v19OE5rChvvLRVt4sLr8hjBznqqM681tiR4imZ
 GXSe7/d1ilDKzLJ2R0RhDdT62QuVphMTPleSjmyiMVmwmOUMy57YXkOdwId94kVg7eU3
 tTW+lwlb0vmkvhHzzF+NGXv2nUrN5gZ2waoWeyjqwvXUTDY0KSSv8EGlygG+nM8T3Qm3
 k1VQFFW9j1evhV7MauUtGgQQVNE1CSr8bu1k6MOMVnZjrY8VcHtotxGpCanG8/VlCDVk
 +o+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773962793; x=1774567593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RYB7pnWPDF09kxM2pVeCxMznDuYzQx/e50Ubr54oZJY=;
 b=TehzG2OFDkbvI0qOSB3Vsab3v/dLdNQQVIHyVKZNrjr3Eb4VtsTtROVTweBVEm1/Er
 nmfSgRXq3MqTp7n/BpyXjjQ6AalnJ5yNOmQETfc+woXm42teM4wpq/i01rPso5LZUjWW
 QUHYhtxWyvVVO/i4VLFN8s+sFyJC5vuBmFTn2r6TPS+oS/FwR0+T1c9KutcznoUwDW5M
 bQax6GvTWtegkJlY9bntXrS/dRN22cTqjJojcOAddtC3JlgHbCCZHhMPvNz9hliA9I93
 llW2NFnAdkJjNpMmDvcHh9L8VWO/gG6YLrLN/qDjHxleWe2Hr8TyYPwbX2VsCy4TNgfE
 s11g==
X-Gm-Message-State: AOJu0YyDcdN1EOgAlWTWVNUNLvlSlHsEyFkCpohSl1ySXsedjlQwNUMN
 KW4ZQsl7hSCpl4z6LH/81Fa9UXshgWaau64Euvteyh8ThOL15I9tug1S3rOpEw==
X-Gm-Gg: ATEYQzy1FQXCYMA9yPXYV1kWahD+0VTnlGm8Bzhu5hOo40VscNoGTJxI2vMjH6AsmOy
 JjNl3FQ4FwtVnq3INm5QKqVBZOrWDE5BLs+VYeAxB92Z7u6pnStkpr/8WaydqQC+ur0vuFNQOfQ
 8dXkDvGOqEK9ZblIJ3TS4cc75NvuZJzhprptWFae3uuLpZ5hfNgDwSpCyVqWnXXYugtEgH8MTNJ
 gB8S7Z1JFVCsXv9itNWaL4VLk5BwCcGFnS/b0TNqFBD0jOC2Ubzg4MOsLu2gTXcLTKeY7rzfZ2M
 wFwORP+fXNdi6ut/udG05jRq1NK86rLc4B20JqG2SH/pUy9Tal8GaviXszoIUcl6pGXc8Bfkm04
 JES4mul3J21iZnJmHx17zZ4wJdeoQ+aN5szvVwee44Q3ILtv7h+P5FJS+P1N+WuBi2hOqMpSA1C
 U5ipDT0XsmdUj+NeCB0ES1Eez/tP6ztWKJ0V9KtUGXgw==
X-Received: by 2002:a17:902:dad1:b0:2ae:cb0e:fd5e with SMTP id
 d9443c01a7336-2b08275878cmr8524945ad.23.1773962793541; 
 Thu, 19 Mar 2026 16:26:33 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083516ae1sm2979165ad.13.2026.03.19.16.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:26:33 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Max Chou <max.chou@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 17/17] target/riscv: Fix scountovf CSR behavior in VS-mode and
 M-mode
Date: Fri, 20 Mar 2026 09:25:22 +1000
Message-ID: <20260319232522.1867400-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319232522.1867400-1-alistair.francis@wdc.com>
References: <20260319232522.1867400-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

From: Jim Shu <jim.shu@sifive.com>

From Sscofpmf spec [1]:
- In M-mode, scountovf bit X is always readable.
- in VS mode, scountovf bit X is readable when mcounteren bit X and
  hcounteren bit X are both set, and otherwise reads as zero.

[1] https://github.com/riscv/riscv-isa-manual/blob/main/src/sscofpmf.adoc

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260318024234.2772480-1-jim.shu@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5064483917..a75281539b 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1599,6 +1599,7 @@ static RISCVException read_scountovf(CPURISCVState *env, int csrno,
     int mhpmevt_start = CSR_MHPMEVENT3 - CSR_MCOUNTINHIBIT;
     int i;
     *val = 0;
+    bool virt = env->virt_enabled;
 
     /* Virtualize scountovf for counter delegation */
     if (riscv_cpu_cfg(env)->ext_sscofpmf &&
@@ -1609,8 +1610,19 @@ static RISCVException read_scountovf(CPURISCVState *env, int csrno,
     }
 
     for (i = mhpmevt_start; i < RV_MAX_MHPMEVENTS; i++) {
-        if ((get_field(env->mcounteren, BIT(i))) &&
-            (env->mhpmevent_val[i] & MHPMEVENT_BIT_OF)) {
+        if (env->priv < PRV_M) {
+            if (!get_field(env->mcounteren, BIT(i))) {
+                /* no mcounteren in S/HS-mode */
+                continue;
+            }
+
+            if (virt && !get_field(env->hcounteren, BIT(i))) {
+                /* no hcounteren in VS-mode */
+                continue;
+            }
+        }
+
+        if (env->mhpmevent_val[i] & MHPMEVENT_BIT_OF) {
             *val |= BIT(i);
         }
     }
-- 
2.53.0


