Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29763EF8FEA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmUO-0008Ue-7k; Wed, 04 Mar 2026 08:42:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmT6-0007B3-5s
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:40:59 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmT1-0005JX-Mu
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:40:50 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-82747396358so3551363b3a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772631646; x=1773236446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1XjDMgl6IJWCtT3ldohujwgW47hISvqfsFoeJofhli4=;
 b=i0NA0xurhnwjAahgkgdz2iWP3wEhz9P0waOKAPjIAL5g/5esGZKqWmLuRxezpaukW+
 zlRW+2hXd6az8YMdzoYk0l8fldtA73kFaD1u087PsohG0dW8Niowxyj8JpytBYsobaoB
 VGCHec2JvEdUZSS6mM8nSt0KoLAfNmJf5o6RoZjRVQbwjCU3LviIUEcot6anYiOL1RgZ
 8Ku17PFoOUlsTqeVR47grZXmQIrrleqfk0+yggJ3ieotHzVCNj7Tbcn0VW+IbsLaA7YY
 Wlrbjdac2FSiZpZRVe+i1CbpIppn8gnUExlPU0H528JOjR38eOLMktBdJ2FAhqRMZ2Sl
 LuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772631646; x=1773236446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1XjDMgl6IJWCtT3ldohujwgW47hISvqfsFoeJofhli4=;
 b=rCVX6NCRHc09fLAXzpSHyEJov5kDqICIFHz9PRXa3ouYxIn0T84taz346SZR40dvfq
 7m8gSip4sb/mpYpBLkhJCoZo6LZD1X5356rgUNuJe3C6FdhtIuzCbIjDLvmuc3tzynpQ
 zjKvFrMFeNVsKyEgTwOX331MHhyWcMAjpcW9NQrQawQk6Qr1AY21TfLbKNfMm/PncjGu
 c+aw84CJq32b/O4mExlFtHeIq7KGLDjXsFpwOD9/vTgUkRjjH34QgK0IXZxA6sZHnYq4
 HfNTIliufjOkUpWYL524khsatQiE6KuLTFZw7BmGsflv/nXNbo4RCpotsCCXoaRvbzcS
 VNkg==
X-Gm-Message-State: AOJu0YytEZg6tqFfz9nyQ8cIAR++KXyGIVvOPz9yjft9lW15bjzy6cxb
 M78V5KVYKTeLjvywjql05AsWH+Xq8wNPj+CcNP4nJnzutvd5KUmk51Fz7TJSeICW7Y757lIH1Pu
 04kN+dAoZ5WuIxO40N8qSGLBWCG/Qlt/YR5QKMBKwfNuBEdG7saoIm0uDqPSBl+EVVYN2kj/b5J
 eCsWMGe+FuJadDwKcV8jItQtXzvDMIlDy7XJQPpLu1yQ==
X-Gm-Gg: ATEYQzxrQm2Xprj3I6R3oRlP2glMetbrHnZUNEQcahnL6LeqByp9Jo9+QdKcXx1H4F6
 mpjW2C4VXH8eT2U1kFiszz9KVbEi0zXiqAn8e3yJgqzJQUDnSO3P0S9dlOoOexLNeMOIeufXdgY
 jDhDZw3p5wxyHhdgypGw1QP6dc2BRvfXViAbQybTILhe1ekdPwhWqLKjkeAFGatt1whDDGgtyqS
 BrWie9h3GSZdIAzPfvB9NHwaTxlmcuYvje0hvj2ZOgQlDbgy84fpOCy+0578CjLqPuDkmcj+5eM
 xplvshHCTUGYWMX6SEpsCGmXgwj/r/+u9+Xq6gl3hKCYdMxM8YsuFUFaFgkyRCDOKt1ZALBqxLG
 hr043+fxt1WOClUzJKXb+z7SNvspWCJ1+INy5Fsu2OWDV+NrNMW6UKbvlieuzNwgMmHNy5usUcV
 8u5s5fpBfXldnTRru74v06/r+y4lfqBqF1YUzV1M38/zGnCl0slhm2eIamhpA5p8nLCZjXzayMq
 9yLH8epwFL9R9Uy4ovR0f4IN+0=
X-Received: by 2002:a05:6a00:1827:b0:824:adf4:5a32 with SMTP id
 d2e1a72fcca58-82972c62dfcmr1949731b3a.42.1772631645911; 
 Wed, 04 Mar 2026 05:40:45 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8297e11bf5dsm251921b3a.28.2026.03.04.05.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:40:45 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 10/14] target/riscv: Add cfg properity for Zvfofp4min
 extension
Date: Wed,  4 Mar 2026 21:40:02 +0800
Message-ID: <20260304134006.2908449-11-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304134006.2908449-1-max.chou@sifive.com>
References: <20260304134006.2908449-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x435.google.com
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

According to the ISA spec of Zvfofp4min extension,
"The Zvfofp4min extension requires on the Zve32f extension."

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c                | 1 +
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 target/riscv/tcg/tcg-cpu.c        | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9b98e18189..03eaa12028 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -194,6 +194,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
     ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
     ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
+    ISA_EXT_DATA_ENTRY(zvfofp4min, PRIV_VERSION_1_12_0, ext_zvfofp4min),
     ISA_EXT_DATA_ENTRY(zvfofp8min, PRIV_VERSION_1_12_0, ext_zvfofp8min),
     ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
     ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 59302894af..353a932c36 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -104,6 +104,7 @@ BOOL_FIELD(ext_zvfbfmin)
 BOOL_FIELD(ext_zvfbfwma)
 BOOL_FIELD(ext_zvfh)
 BOOL_FIELD(ext_zvfhmin)
+BOOL_FIELD(ext_zvfofp4min)
 BOOL_FIELD(ext_zvfofp8min)
 BOOL_FIELD(ext_smaia)
 BOOL_FIELD(ext_ssaia)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ba89436f13..b1097e55a3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -715,6 +715,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zvfofp4min && !cpu->cfg.ext_zve32f) {
+        error_setg(errp, "Zvfofp4min extension depends on Zve32f extension");
+        return;
+    }
+
     if (cpu->cfg.ext_zvfh && !cpu->cfg.ext_zfhmin) {
         error_setg(errp, "Zvfh extensions requires Zfhmin extension");
         return;
-- 
2.52.0


