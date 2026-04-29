Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351B0FF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwuM-0001qR-LZ; Wed, 29 Apr 2026 00:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwuK-0001pA-0U
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:52:20 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwuI-0001Kn-9S
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:52:19 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2b2589c26e3so112409555ad.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438337; x=1778043137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=227Q35fZE6+M79xkJxQPFRbAqP+g1VEBQ9gOOBT2sro=;
 b=RPBR9/2KBG05ahmpYzjpJAcuGGQuWU/HkNwT2VeqEQpySKPF2EHRMf0P6CnoyiiyL3
 9sa8wEIl4WNQAsQOTfDMdDJuqrCX1R09pDS7TT2i2iQ7f3RZ0PDBL/UlwFbYn/bYujTH
 Fa90fankYSZ5WkNcQfW0QL+C/rqG3BxP2BW8sO+WVsJJIelDZfGK9ATSpsTPJ3SO5WGt
 J5qMPeJsUBodFo6QRjay42kDBF4ac4CuR6ihxPOsda1v3QRtHshG2YAM189s8bqcXAPr
 3RMj0Hw26MlOhd6yWgkiweD8FrVxJHEuc46+UJymFrpIdY2EEBjo3aBTQia6/G1YOHec
 eSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438337; x=1778043137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=227Q35fZE6+M79xkJxQPFRbAqP+g1VEBQ9gOOBT2sro=;
 b=FtNoeJMwF8ZhNbmPIDcMAVlF1x4Ip4n8qdh/i+c09rHHvJVZwjh54aEbYxeKSEcHx5
 GSCWxK42Z9sVA1H3Mrf8whRiFy2RsTZPcqZNPX8Hzp5n4LtkXfu2DDg+XnE/SRYhRlZL
 tzyljOX+7+h9Hc1o+93Y0d5Id0zLRdrNkOKO5teR/pyziYiFoh6pSg/61+21f3qMb+xz
 40FL679Punf0gAR4A1iQw70L/1qolvKS8H8llnp6PLEnIxb/3xLBPL2L2qLss8Fy/mgH
 MCISalRqc8JSWPuLCzpNHNSUSe1TuYJ23w+fPgDqOdk0oFnSbD+kRHpRD43NGcL37Yx4
 z28A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8qwC3b7opr2ynzEM+NzXVUHTji2hxGfuoIxoYiKKYBr4ZTAkrIYHCIMpG+cYhT2riLYVTu83JJyRI4@nongnu.org
X-Gm-Message-State: AOJu0YxL7BbqSxlDpa2DwVI2lkcZ/J9uueaTUKfZPmabMS4m6t4JKxC/
 rzVD0qoSxKZugxgEqobVRWpnUShRkvbAZSZoiHiZ7sV/74mRMN5UEHZR
X-Gm-Gg: AeBDietU+9Pyvu7DIRCtbj2BRgybOJ1lL67rLylXTzJ13b+sfQmy+mXvg4jZH/EAz4x
 26KTgq2dzdW85oHoJQf+Khy+ltSR83VYmq/NJEqL1EvfKG3f03ERnn7CVROzeI2ebOsf3LZEsx0
 N4VrotXcbPtELBDBCRSryQpr5yuoNRW4xDu4xXmIf1PpaR/gYrBCai8n9TJOuBJSvMAnWcMjPJI
 UOQV2dTDgX5p2U4kiYJCQqZ5/kFGCjH8T4CJsmj1lV6Rw9jRM1oLDdhmNfHraz1wvQ1wx21jECt
 l34B+6tm7Doz5hwH6yML3s3RdVWtizZWCfVMCCE2SvJtvzWIX3zutWJeI6r7ULxdmAowDfjS/L+
 0qPHh+ywKJptwIIQKFGFVFWwjqHo6K61tCuEOEvbG2FherIWbEqtpp29B8k1Miyyu3Ye87t1bfm
 17GRjUzixBpgogtJXn7VP6vU9g0Ldb+pycRia8waSogQSNamncl240
X-Received: by 2002:a17:903:1aad:b0:2b4:5ed3:415f with SMTP id
 d9443c01a7336-2b9873fc3afmr21588985ad.18.1777438336684; 
 Tue, 28 Apr 2026 21:52:16 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:52:16 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 49/51] target/riscv: Rename riscv_pm_get_virt_pmm() to
 riscv_pm_get_vm_ldst_pmm()
Date: Wed, 29 Apr 2026 14:47:50 +1000
Message-ID: <20260429044752.4176397-50-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
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

Rename riscv_pm_get_virt_pmm() to riscv_pm_get_vm_ldst_pmm() to better
reflect its actual usage. This function is used when checking the PMM
field for virtual-machine load/store instructions (HLV.* and HSV.*),
rather than for VS/VU modes.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260421093715.2995067-6-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        | 2 +-
 target/riscv/internals.h  | 2 +-
 target/riscv/cpu_helper.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 672f0dab0f..138183e017 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -890,7 +890,7 @@ bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
 bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
 RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
-RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env);
+RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env);
 uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
 
 RISCVException riscv_csrr(CPURISCVState *env, int csrno,
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index d090db2641..7eb6edbe90 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -209,7 +209,7 @@ static inline target_ulong adjust_addr_body(CPURISCVState *env,
 
     /* get pmm field depending on whether addr is */
     if (is_virt_addr) {
-        pmm = riscv_pm_get_virt_pmm(env);
+        pmm = riscv_pm_get_vm_ldst_pmm(env);
     } else {
         pmm = riscv_pm_get_pmm(env);
     }
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 2b3fea81d5..ef1ff7cb0b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -214,7 +214,7 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
 #endif
 }
 
-RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env)
+RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env)
 {
 #ifndef CONFIG_USER_ONLY
     int priv_mode;
-- 
2.53.0


