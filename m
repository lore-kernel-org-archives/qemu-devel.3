Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BAAC28B28
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 12:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWMZ-0005BI-Di; Tue, 18 Mar 2025 08:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1tuQxj-0000bW-Fj
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 03:02:07 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1tuQxh-0002lg-PQ
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 03:02:07 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22398e09e39so111937945ad.3
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 00:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1742281324; x=1742886124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zgq72ZLImj4lKu2rvyuxiEEvV59jy+OySRur4RXmIHM=;
 b=W2PGQlQ8E8MaYZkqwhnBqxUGq8bC46hZ5uYE+doLPdqDcqotUW3aRO+FwHYLr6Dn65
 Q5NDGwJYWHlEO6IQ5zwgGu52TTNgwcJM+NFgbz5c18gsM3eZ3fF+5cEOl4Pfw4d4XgB6
 Zfzcz5dGX1inPKpmgc1xG0GACYl9ZulbdesfmKNB2tBGNTcMJiIc7xeaJO+wqTyUpVCs
 L8y0NMBuivxJ7eeeNngcT8oW7W/jhjUMwWMdAa4tuVsteLT/jsJJ1zdF3PcNRpmOIhn4
 K8CIP5i+oM+TtgXkpoHwSawmX6ptDFI8HigrfOn5zUxaOINfVM8a1/byHxzedkYq8SHb
 rzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742281324; x=1742886124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zgq72ZLImj4lKu2rvyuxiEEvV59jy+OySRur4RXmIHM=;
 b=pQR12QbLco+sz1cbJITu+uBbyfhNwvCFMAdo5kjtzRWfa2BZp7IDmgmLP6U5CgG1eR
 hQvNd8oTbUkrEaO6/ZeuzBbhpTGePRKHpcNwGoTu8qlA/4L7qrVXJxSDxkYTZRCB7v62
 4xEFhra+A2bdUg1fmtsUQEsPj/kvxEYv5ND+gnFnJv0spcFQnHcO/PObxFTpzWouXyG1
 AuVXdJ77dksGuH+/pPTvxdPOguK8oU4AjFroeSVX1OPuyEYeOP8pCDtQ0zSO6x0Alb/r
 pmEkan07spkycTvqVuw8IAolK6wF8s9D+CJItOAZSPCAR2WnZMeYhDo/e3HzukClqe6W
 t5Jw==
X-Gm-Message-State: AOJu0YwtJhZT3N/bOzsDACA3gNhs2aGAZWJjU/mC5l8vO32JBXTyJSAF
 D19TqURtQoEvTYpLNJs6rnjILqEyFdJ9fGGgli2Oijgg6KoaP9YpjBmZmy/LJf4yNQmaNKePeNY
 a8OsCUXzVxEFjnola/Yv6QkRqeqt2jli5pSTpJjx4q2cYb8SxUwnbjBzDCe27H5MGkcu0lkA/ff
 Y0o6IJX/SoXcpuetDR4+riYiFKKR6TUEQk40cuZzk=
X-Gm-Gg: ASbGnctRC3kPyuLREtkIQ0F+w+OZwmFRfqmipxh6qtey5TxOOstuHmzlh+pzIoIeVYX
 kpZ6iOzewGxikDwWg0Sw5te0b66dcRa/ZihRYUQ2P7+C0iC5B7N4IWbIPO3FyZNxTY+CFeKei9o
 5B0GwVCRd/h8DiAMp+Ji7BpRDJocRrx/F1EYp5luUOREFWjniFKA0vKKCKvsdKNHPW7sWJ66b8h
 IRfVorujwHeaP+mpnJEkoc/RD8fNEBUPKjFwJjxRSfobd1uvNkDKEUnQHlzbXB+5oBz4gTNf13V
 xQ9zPJX0NZmPE2Tzh2IDBKzjv/MItMW7FhsCuV6S1jaLQmzURiTIy5lRlR1rL+sBbsRMjjFXs9h
 1J83foVjj
X-Google-Smtp-Source: AGHT+IHLLq+8UgUa93r+t1fJaPfJiNLcX2puM2GzwRV6Rx9pvf91iEMqjHTZUf0Qw7ONGWvGmHsEtA==
X-Received: by 2002:a17:902:dacc:b0:220:f140:f7be with SMTP id
 d9443c01a7336-225e0af5c2amr178891315ad.41.1742281323790; 
 Tue, 18 Mar 2025 00:02:03 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c68885a1sm86966235ad.13.2025.03.18.00.02.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Mar 2025 00:02:03 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jay Chang <jay.chang@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH 2/2] target/riscv: Restrict midelegh access to S-mode harts
Date: Tue, 18 Mar 2025 15:01:36 +0800
Message-ID: <20250318070136.38898-2-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318070136.38898-1-jay.chang@sifive.com>
References: <20250318070136.38898-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=jay.chang@sifive.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 18 Mar 2025 08:44:57 -0400
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

RISC-V AIA Spec states:
"For a machine-level environment, extension Smaia encompasses all added
CSRs and all modifications to interrupt response behavior that the AIA
specifies for a hart, over all privilege levels. For a supervisor-level
environment, extension Ssaia is essentially the same as Smaia except
excluding the machine-level CSRs and behavior not directly visible to
supervisor level."

Since midelegh is an AIA machine-mode CSR, add Smaia extension check in
aia_smode32 predicate.

Reviewed-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Jay Chang <jay.chang@sifive.com>
---
 target/riscv/csr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 975d6e307f..c3dd8e6cda 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -372,8 +372,11 @@ static RISCVException aia_smode(CPURISCVState *env, int csrno)
 static RISCVException aia_smode32(CPURISCVState *env, int csrno)
 {
     int ret;
+    int csr_priv;
 
-    if (!riscv_cpu_cfg(env)->ext_ssaia) {
+    if (csr_priv == PRV_M && !riscv_cpu_cfg(env)->ext_smaia) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    } else if (!riscv_cpu_cfg(env)->ext_ssaia) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
@@ -5832,7 +5835,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MVIP]     = { "mvip",     aia_any, NULL, NULL, rmw_mvip    },
 
     /* Machine-Level High-Half CSRs (AIA) */
-    [CSR_MIDELEGH] = { "midelegh", aia_any32, NULL, NULL, rmw_midelegh },
+    [CSR_MIDELEGH] = { "midelegh", aia_smode32, NULL, NULL, rmw_midelegh },
     [CSR_MIEH]     = { "mieh",     aia_any32, NULL, NULL, rmw_mieh     },
     [CSR_MVIENH]   = { "mvienh",   aia_any32, NULL, NULL, rmw_mvienh   },
     [CSR_MVIPH]    = { "mviph",    aia_any32, NULL, NULL, rmw_mviph    },
-- 
2.48.1


