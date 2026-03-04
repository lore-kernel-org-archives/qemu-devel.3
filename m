Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB72EF8FE7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmTQ-0007KG-Ro; Wed, 04 Mar 2026 08:41:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmSj-00074V-G9
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:40:32 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmSh-0005Fr-O2
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:40:29 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-829756f3ee9so485237b3a.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772631626; x=1773236426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pGVJp9rd848RfT+iHHjXq0FBv/JV9207fFEhqIScJMU=;
 b=McRCsLfSUeLYZ+yl1eMbzeQTNI+rXLpikWF1lodzZZMhDKqunVTtjBYdiA4tnhWSoC
 j9PJoKUBWxnXJt6rP0QEEPo1wMJ8tOF/gM7QJIkOaQianp+zZTRdlU+87152gBuldWay
 8nxysKS+ilklHPocD0Lj3rOBDfNkvaQd+/8pNTVbhlo5meArXkpTihtP9LiYyILkpQst
 mgUKOVJsMGCjptfS9zs1PsQAkmMpokRlp0VHQYVxARtrVafvAf+SccjUakkONNMwg780
 jIJ/ejYmtvJC0FQE8LfSZY2ihHy6WHcEhyUx92KEmECfXk3iaSNeXPtJL+eacxC2M/Ia
 TjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772631626; x=1773236426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pGVJp9rd848RfT+iHHjXq0FBv/JV9207fFEhqIScJMU=;
 b=UFGzs6M42fQ+nz4CuoVzM+YgVZYdrZMrQOlmPxXkAwRW28F/Iwq68xZXePDnHiJt6W
 4viihQMoL/OFk/IZH5wLHX3rHMdfMWKdEiJj8mTBOncHsYNV0FZIboTOY2mYXchEihOo
 W49AaRRSg8V5lV5WE0CQLoBS6wr/KtYHysVhXJUN4m/6uFRCQs4a66gx82YwSgkP6TGk
 SwPHvoH4QJIMfOLVeBWNUYnAbLTbOvbej8RPg+iArYqCmCyIGGd4F59lfBRsupjbVJMb
 tn2yvNz+4UkWN297V/8Pihsa8mcEN8z7ymXjMyDdA/xxLd5YnYc/MQIB7rjzVhv360Q4
 iROg==
X-Gm-Message-State: AOJu0YxxWA8iC5/t+1LlUATmjDzu9A08ixTxGSwjzaGREhYdLuL0Seyh
 Kp+QpdFBHILIvvrY9i/Wr5spuVyOvR8Nsjg5crhYV9I7zp0ZNqpgxUBC82lRjgUl/0vfHtCy6ue
 PCQO87bthUI/AbrL92BUSF4tOHi0/zNUsZt8UUEqFERKA0bSg4L8PqT5zH5dNHTQlkOl8UcwFLi
 pUnKMlnPS2+Fz0gNXTlP7d8ZGSGwxX9Nl4Ugt6A5pnig==
X-Gm-Gg: ATEYQzwUweCkmz8zEd77qStz5q44zngeRhl4SFIDM6s5an5+aT4LupOgMiYt/qnEfLE
 HU1O1noFtg5ByPtV0NVDAJZSTJgugfMw+l8+L2ouDkMRpP4xze3wS3NOSWxvrGYLaN31nW8bS6S
 F7mP85RoywbjCNc+ITDKxW4VPGu+sEkT6dp0lDmiyYAq6DHvh+XuwdE/1TFJpcPf/p5QXz147eL
 IvOB9WcDrvI3PVYYJx81FT7qjLDttafCY4sxA1nbh17UV7ubWhCQJxfukADPGTnC1K+iHno5NoH
 ekha3WCQNbo88DhfJ5iEbF5ZwU/t4TOL8FWxSa3jdWXt6/bXPD4WYKBLduRXEBH7mYeOleEk1Ue
 VqTg8tfDQRjVGTukphKIOyaelwG++2lE+iWkC0wcKaWDjMmrky7T3IPhngJNzOT6uCX7bp6ITWY
 J+DEZrBUSpwG9JV0ROc747D3tv7YR1dIuL3wJiLExX41smpYYMb3DkeVsticDgEHEsURSmE+WHw
 tPD5wdpZPLMgV06Ri/+o9sJPg4=
X-Received: by 2002:a05:6a00:3cd2:b0:824:93e4:2ddf with SMTP id
 d2e1a72fcca58-829728f0381mr1922473b3a.13.1772631626013; 
 Wed, 04 Mar 2026 05:40:26 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8297e11bf5dsm251921b3a.28.2026.03.04.05.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:40:25 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 02/14] target/riscv: Add cfg properity for Zvfofp8min
 extension
Date: Wed,  4 Mar 2026 21:39:54 +0800
Message-ID: <20260304134006.2908449-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304134006.2908449-1-max.chou@sifive.com>
References: <20260304134006.2908449-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x431.google.com
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

According to the ISA spec of Zvfofp8min extension,

"The Zvfofp8min extension requires on the Zve32f extension."

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c                | 1 +
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 target/riscv/tcg/tcg-cpu.c        | 5 +++++
 target/riscv/vector_helper.c      | 3 ++-
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 73cfcbdf6f..c3ddcefedc 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -194,6 +194,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
     ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
     ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
+    ISA_EXT_DATA_ENTRY(zvfofp8min, PRIV_VERSION_1_12_0, ext_zvfofp8min),
     ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
     ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
     ISA_EXT_DATA_ENTRY(zvkn, PRIV_VERSION_1_12_0, ext_zvkn),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 3696f02ee0..59302894af 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -104,6 +104,7 @@ BOOL_FIELD(ext_zvfbfmin)
 BOOL_FIELD(ext_zvfbfwma)
 BOOL_FIELD(ext_zvfh)
 BOOL_FIELD(ext_zvfhmin)
+BOOL_FIELD(ext_zvfofp8min)
 BOOL_FIELD(ext_smaia)
 BOOL_FIELD(ext_ssaia)
 BOOL_FIELD(ext_smctr)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 378b298886..ba89436f13 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -710,6 +710,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zvfofp8min && !cpu->cfg.ext_zve32f) {
+        error_setg(errp, "Zvfofp8min extension depends on Zve32f extension");
+        return;
+    }
+
     if (cpu->cfg.ext_zvfh && !cpu->cfg.ext_zfhmin) {
         error_setg(errp, "Zvfh extensions requires Zfhmin extension");
         return;
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index b2315ecf9c..57221ab884 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -38,7 +38,8 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
     int xlen = riscv_cpu_xlen(env);
     target_ulong reserved = 0;
 
-    if (riscv_cpu_cfg(env)->ext_zvfbfa) {
+    if (riscv_cpu_cfg(env)->ext_zvfbfa ||
+        riscv_cpu_cfg(env)->ext_zvfofp8min) {
         reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
                                            xlen - 1 - R_VTYPE_RESERVED_SHIFT);
     } else {
-- 
2.52.0


