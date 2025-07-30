Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D71C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 01:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugvHO-0003Jo-Jo; Tue, 29 Jul 2025 21:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugvCs-0003vO-4k
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 21:02:10 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugvCq-0004qi-7z
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 21:02:09 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-31ec651c2a1so2498420a91.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 18:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753837326; x=1754442126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZpAThyHK47BS0F9JHZzT8Mn9PhBJDT2KUOQzUhgdcXI=;
 b=IvkFazdJ8+WOyZf4/p3KH4aujmOHwrmaenEYz6/13UH8/fCyVRDoM9ZTBuiFaUY3dV
 G2DQeePm7VmvF45glNxDqdqupJycWnReITWjyjZWPiCrA+dtDonAI2p6PIAGvDgSQNHq
 P5Uuck4nNG7gks4E44fZiAPzN6zXiu8xIEPLsDot3cva9lpgp5R77WwNus6lmapCVzYJ
 pxL2NpPWe3sdZ3QZr/jByPtzW2+Yt3/1xbX7uWqQOoGwTquPgJTci0ENH7ihYxeoBUyY
 15c5LACOYSRrncdyRz9YVlhvk1TF7eF0LmEFhV1S7AznNYkjjS2eVOyrdotwoCR5Rt3h
 /awQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753837326; x=1754442126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZpAThyHK47BS0F9JHZzT8Mn9PhBJDT2KUOQzUhgdcXI=;
 b=pLdiyxID73JsNaXxTr4DP3UIMTD1GH9Cf2kDtF92XiYeqjdHFu+9Y4t0BfB5pFeULt
 hGLzlkqZZtqbLSr9wvcj8NhszSxVxMlmY7x1IeArAMXdR07xxazlgHQsMnzbIyAHUlGF
 s75Vo1V0Zy7WPvG9S2BdjSVGViJGrVLxlUd8g7QGnz0mcXpa2vs47OuUwl0tnFG1MRLD
 lWS1e+/YUhjVWSbvRt+HGrpHV9s1SB+ry8MSXR1G2V4IHUe92SqYOcLr6InhWyZkin+t
 omwCddg+tMnZPbs36twu81k3MhFSZChag8sEahVhNb7nbHhIh5PXA4zlIziX8HXZhbbd
 rd5A==
X-Gm-Message-State: AOJu0YyuKYUNWBwMZxwUxTpcPX1/d6nutxLW/gAOHEUwIFx8dnNuwj+U
 sYXWkfupVDKdVcfXKRBgxtOWkxcdar4dFGe5M4R4myD6vmkWIEMsrAG+/t6XfQ==
X-Gm-Gg: ASbGnctD3pGWM+XmS30OHjFeK8CwkfrMrBKvK/h1Yj0UR0hAnNytT7LN7BfV5IEKCDw
 ZxoqJLNH1nekkkbHFQo25UumGHnI+P1le9AKhO+JwZREXjl2O5YF+Ahfg8TRgoleiDc0d/vZNz6
 2TWWvKl/GoZZ/6GhdL9c8HZq0OMCZnWC/ULleEwLOAqWNUZl5tJw1Fn7Dcv/U4LEd4439GqFCVi
 ZQGGjEXLYvIiLlwXnaYBPr4sPvbB+CRMTahZrxA1EOfLbLSUq4qjueC67TqSsGVKK/pFsW2SjnH
 BgamlsiIkv3R4sz2dH+hI38MWAyI4hI6bgvoKBaHEZHxcpUr/5eFzHJM89WYgTmbs9lrlYLPBjx
 SDY9AiNB4dUPdvoFoNkWp3Ajm7D7X95NDTQ4xY6CqNOw9SgRLHXT6Zubw6HkXn9RyHu67rx27Oo
 hREj7Bh277SZ2wPeVE5izBh5ZN4fM=
X-Google-Smtp-Source: AGHT+IEF6i0qGHgQAxVYEwys1JdlPxgSffrKxmVR4aN1G2KNdnzVTgf8A0NVUYAAk3Pdzc3bTvPsyw==
X-Received: by 2002:a17:90b:3c04:b0:31f:253e:d34f with SMTP id
 98e67ed59e1d1-31f5de54a53mr1965162a91.19.1753837326397; 
 Tue, 29 Jul 2025 18:02:06 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63df5adfsm343253a91.25.2025.07.29.18.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 18:02:05 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jay Chang <jay.chang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Nutty Liu <liujingqi@lanxincomputing.com>
Subject: [PULL 11/11] target/riscv: Restrict midelegh access to S-mode harts
Date: Wed, 30 Jul 2025 11:01:22 +1000
Message-ID: <20250730010122.4193496-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250730010122.4193496-1-alistair.francis@wdc.com>
References: <20250730010122.4193496-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102a.google.com
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

From: Jay Chang <jay.chang@sifive.com>

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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Nutty Liu<liujingqi@lanxincomputing.com>
Message-ID: <20250701030021.99218-3-jay.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5a6de07486..8842e07a73 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -374,8 +374,11 @@ static RISCVException aia_smode(CPURISCVState *env, int csrno)
 static RISCVException aia_smode32(CPURISCVState *env, int csrno)
 {
     int ret;
+    int csr_priv = get_field(csrno, 0x300);
 
-    if (!riscv_cpu_cfg(env)->ext_ssaia) {
+    if (csr_priv == PRV_M && !riscv_cpu_cfg(env)->ext_smaia) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    } else if (!riscv_cpu_cfg(env)->ext_ssaia) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
@@ -5911,7 +5914,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MVIP]     = { "mvip",     aia_any, NULL, NULL, rmw_mvip    },
 
     /* Machine-Level High-Half CSRs (AIA) */
-    [CSR_MIDELEGH] = { "midelegh", aia_any32, NULL, NULL, rmw_midelegh },
+    [CSR_MIDELEGH] = { "midelegh", aia_smode32, NULL, NULL, rmw_midelegh },
     [CSR_MIEH]     = { "mieh",     aia_any32, NULL, NULL, rmw_mieh     },
     [CSR_MVIENH]   = { "mvienh",   aia_any32, NULL, NULL, rmw_mvienh   },
     [CSR_MVIPH]    = { "mviph",    aia_any32, NULL, NULL, rmw_mviph    },
-- 
2.50.0


