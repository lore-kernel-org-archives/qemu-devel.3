Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B9AC87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 01:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugvGv-0002Ux-2P; Tue, 29 Jul 2025 21:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugvCp-0003ok-En
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 21:02:07 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugvCn-0004p7-Dm
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 21:02:07 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b3bdab4bf19so323317a12.2
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 18:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753837323; x=1754442123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VIsknjkgZG7i/K/CbMZ/+uWxaIQ0J9cHKwtsWD/bOlM=;
 b=KD8uNwB9Zj7BpdlUxhllwj/uvlRhpodMVpn4UXGnpJimMTnkWdl55DRKzq/ad4/uF+
 uyPek9Af5Io4NBYBx3E09vyHtXNqO4GLo3r/b0XqnQJaGUeYX1+8aeLzCN+1+swJlEfp
 rzuaBkPgAn22MuLMHCeG/xe/W/vA4uCUed9nXg/zlGiqaYdU9MDDcZ8h7nH3tc7u2Vlf
 kZ5k6b0KswlcQSFqE9SiISMbugdf/D4aFJYATg5PLW3Gi9weT1nGiNOlLN5gffFPLTOa
 vB42UKz9q8aowZEKSbe4IAufUz5MrX3WW/bCrPBMpsLrfgtNV47P432zwfs6d5WbKHLh
 KP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753837323; x=1754442123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VIsknjkgZG7i/K/CbMZ/+uWxaIQ0J9cHKwtsWD/bOlM=;
 b=ZYvheK2okjUQr5VJcgHOrfC1ltABJDkM4DgQE3Cva13qKItucFGpQ659yfpG29pJDw
 Ny34MX1adJLNC55NQtijmZuxdVEaKWyfw0gKpfTYe95EOQ5M0I0cTh2KO6ExvDE8C9jQ
 lvMPIR4Ei8H4IaT4xKKDpbQsBW6Eavz2m8/VlcnGIgGt0y0STnhKVubvLhS+7AqzXvAU
 cmxLITclsJiDoE6EAF9q0c/D+kidoFchjBR9K85xtD7pPORRhfaLxR3yRdiR4E7X/tZN
 +3LD21A+sFTHga4iRxNjagCLTD4JifHOKAoV98bMwJM1bL1qUixArGkkTMBkuKWdnI63
 fUEQ==
X-Gm-Message-State: AOJu0Ywv6QXqPUXXAg0dfAVnVijKGA8771lINvU1JEFeMTBf2NgSiwZY
 EEqxU5CZ/PID/wV6jd8JaX+YJAuOkDng4Ium0eUaQj9M4X6CZpM8SBbQqbsHOg==
X-Gm-Gg: ASbGnct2RQikzzu22T/coKs6aV3YilpuzXVJdgrHtqekBdJGUe5UMIOz7e7WbYQjXvD
 5MqxtA3G94gZzsMbslD29nRq7tDRkF84K5iPAvyWVyGG4E2Qct97MIWL0aZWA6NuN7H7+ct1VX1
 p0clhYaHxMDddb6RbVBBY/UhBpRlh2utP6idmE5FledqTuGv+jfBIPbHl3BLNRng5Kd4S9bg9XS
 HpYlDFl/98HjT71wRtdonVpThgV8kpbXsBKnkNCVbjhlHZXhX0WenArnmghYfwwoenjncUiBua+
 v3zkxgL17d1vj1+E2IgcNWqHOnycYLrlQJcW2AHYBjo+ppbqif46aqJY6BbW7Vw4o5RuvGnp5kG
 coE99BkTHcmzGNcZJABCXK2gOFgctLKu2VnavfgKhA/+HKcYeC5i9+9F7DbKukg6zh2cSYq/Xdp
 fN8EFgg22Re4tuaTsAauzYRcsv88I=
X-Google-Smtp-Source: AGHT+IH1SJcytqQijGFc4NH1cQ9m9bkFFlw6P/bOD0lfAXrk4l8QJL5EN2NjWYVPMIRINXPVdqW4cw==
X-Received: by 2002:a17:90a:d404:b0:31e:3d06:739c with SMTP id
 98e67ed59e1d1-31f5de85bbbmr1951532a91.31.1753837323032; 
 Tue, 29 Jul 2025 18:02:03 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63df5adfsm343253a91.25.2025.07.29.18.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 18:02:02 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jay Chang <jay.chang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Nutty Liu <liujingqi@lanxincomputing.com>
Subject: [PULL 10/11] target/riscv: Restrict mideleg/medeleg/medelegh access
 to S-mode harts
Date: Wed, 30 Jul 2025 11:01:21 +1000
Message-ID: <20250730010122.4193496-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250730010122.4193496-1-alistair.francis@wdc.com>
References: <20250730010122.4193496-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x535.google.com
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

RISC-V Privileged Spec states:
"In harts with S-mode, the medeleg and mideleg registers must exist, and
setting a bit in medeleg or mideleg will delegate the corresponding trap
, when occurring in S-mode or U-mode, to the S-mode trap handler. In
harts without S-mode, the medeleg and mideleg registers should not
exist."

Add smode predicate to ensure these CSRs are only accessible when S-mode
is supported.

Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Nutty Liu<liujingqi@lanxincomputing.com>
Message-ID: <20250701030021.99218-2-jay.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 9bebfae3f0..5a6de07486 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5862,8 +5862,8 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
                           NULL,                read_mstatus_i128           },
     [CSR_MISA]        = { "misa",       any,   read_misa,    write_misa,
                           NULL,                read_misa_i128              },
-    [CSR_MIDELEG]     = { "mideleg",    any,   NULL, NULL,   rmw_mideleg   },
-    [CSR_MEDELEG]     = { "medeleg",    any,   read_medeleg, write_medeleg },
+    [CSR_MIDELEG]     = { "mideleg",    smode,   NULL, NULL,   rmw_mideleg   },
+    [CSR_MEDELEG]     = { "medeleg",    smode,   read_medeleg, write_medeleg },
     [CSR_MIE]         = { "mie",        any,   NULL, NULL,   rmw_mie       },
     [CSR_MTVEC]       = { "mtvec",      any,   read_mtvec,   write_mtvec   },
     [CSR_MCOUNTEREN]  = { "mcounteren", umode, read_mcounteren,
@@ -5871,7 +5871,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
 
     [CSR_MSTATUSH]    = { "mstatush",   any32, read_mstatush,
                           write_mstatush                                   },
-    [CSR_MEDELEGH]    = { "medelegh",   any32, read_zero, write_ignore,
+    [CSR_MEDELEGH]    = { "medelegh",   smode32, read_zero, write_ignore,
                           .min_priv_ver = PRIV_VERSION_1_13_0              },
     [CSR_HEDELEGH]    = { "hedelegh",   hmode32, read_hedelegh, write_hedelegh,
                           .min_priv_ver = PRIV_VERSION_1_13_0              },
-- 
2.50.0


