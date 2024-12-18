Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E78DE7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2eC-0000t2-I7; Wed, 18 Dec 2024 17:36:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2aA-00041S-OO
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:58 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2a8-0003Rv-AJ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:53 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2164b1f05caso1581625ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561108; x=1735165908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KFA5ekI+kAcNMU4k/jpblMJI0Pebf31uGHT3NoHxS7k=;
 b=mZn6eemLlyFtdnX3WeP43hkQA5vC8JIcKb2eY66OObdfIcK/O6ajLjlEAgK6f7dcyu
 IYIsy4xby1Hgd4sIs4/95gtDs1iyQzKuPA4eQUe/FuDrtDBM9Xtmbqz1IcxigSXP20dN
 b9+8zMCqBxNwGZBVeBByDv81vPK2zBdk7GGy9FkjyyQthsJD6MnkD+3LbulG0fpfEcbF
 /Lwm4DbLfdxYLOYN1I9lkm/dF5VzluTmdJrzSy/gpS375ar126l/X8vflrBKKXK5c38G
 tAPc725GgSRZDN+9MncJPtN36TBbIP4WXsPRCO24cemXZaWgJQ/mNU117e1i7P2n1l3L
 ABWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561108; x=1735165908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KFA5ekI+kAcNMU4k/jpblMJI0Pebf31uGHT3NoHxS7k=;
 b=WV4ZBe8evpaitobOeTXlaTAgJdRfOJx66Yj+k7kULYUcg2GoRCWSI1JGCPADymfu9m
 1VcbQwaQxIcgwPtxwJj4wzXWF3EAW79gB/nyuXvnHN9iESbql8xoTjSuyxlIqAnRZ2MK
 0K3G7Y8jjCOsLDG+2pKCiltR6pQcxfT++M6faAb+PlxyrUiKHXgRCA6/X2d5wNLIKl7/
 Z5ZuYV6RPCxSH2bs7oDDnma277AS7w3xRpq5Dy4Zv0caX2io7QKVyyxtOs4WUqPWR2kf
 9Dxp3R7EcxAlcpP1Ptp+XQvDdS9U+UmrcPiwF9gRsi4yx++YEPA2yO1FY9HxfVAz5TPJ
 c4aQ==
X-Gm-Message-State: AOJu0YzgWa6mqxpcU/UHdQwIFJa1sVILuhI7dQIg1qccl2FmGs/EzeSm
 UA3AnrKgM3dgvc+bg5QdF/fIXwWev30/p4WcTAqbMwlYxRxYC6DSp2iwz+nA
X-Gm-Gg: ASbGnct6AoY2AKZF8FgN+yindzNBoPFDElc6D/Xr49OqH0IF2JcHnkXOKf7CQLSjQFV
 +LETq0H/vT2ovVvtO+PnU3j2f9DtVlKicn3Dsj/ipVAFYF70qDZMBg7gKtNxHholLgp9KVLhsvP
 9Wqn8nl9TgeNg5mmZcVQ27Ixp5nCE7E8Dsel5RGEGKYa565ZSVfMooZBRIQ8E/ob8M1Dwv1mPt0
 RtNpD6Fx17Aikmr/Ujq6EkTxWResufKIXM6r/Bja+sIHp6QtHir5axaA7QHWNngkLt50z2lq/pY
 dWPvGDCsMMEupXEEYRhkdr0wRxdduXhi91+5EesYRImnRwp35HLN9PIPz0tPN2E=
X-Google-Smtp-Source: AGHT+IFwk8S9YGDVvKrniUQxpzk4r7fcwjwjLB4R803OSbLdNPuqSMUMtarqwiup9yz/5k9EC5e4VA==
X-Received: by 2002:a17:903:2bce:b0:216:7ee9:2227 with SMTP id
 d9443c01a7336-218d724d328mr66790935ad.36.1734561108166; 
 Wed, 18 Dec 2024 14:31:48 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:31:47 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, "Fea.Wang" <fea.wang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 30/39] target/riscv: Support senvcfg[UKTE] bit when svukte
 extension is enabled
Date: Thu, 19 Dec 2024 08:30:00 +1000
Message-ID: <20241218223010.1931245-31-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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

From: "Fea.Wang" <fea.wang@sifive.com>

Svukte extension add UKTE bit, bit[8] in senvcfg CSR. The bit will be
supported when the svukte extension is enabled.

When senvcfg[UKTE] bit is set, the memory access from U-mode should do
the svukte check only except HLV/HLVX/HSV H-mode instructions which
depend on hstatus[HUKTE].

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241203034932.25185-3-fea.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h | 1 +
 target/riscv/csr.c      | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 385a2c67c2..4b9f899217 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -785,6 +785,7 @@ typedef enum RISCVException {
 #define SENVCFG_CBIE                       MENVCFG_CBIE
 #define SENVCFG_CBCFE                      MENVCFG_CBCFE
 #define SENVCFG_CBZE                       MENVCFG_CBZE
+#define SENVCFG_UKTE                       BIT(8)
 
 #define HENVCFG_FIOM                       MENVCFG_FIOM
 #define HENVCFG_LPE                        MENVCFG_LPE
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 9846770820..1936a6f32a 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2453,6 +2453,10 @@ static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
         mask |= SENVCFG_SSE;
     }
 
+    if (env_archcpu(env)->cfg.ext_svukte) {
+        mask |= SENVCFG_UKTE;
+    }
+
     env->senvcfg = (env->senvcfg & ~mask) | (val & mask);
     return RISCV_EXCP_NONE;
 }
-- 
2.47.1


