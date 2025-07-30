Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B22C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 01:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugvGP-0001H0-AT; Tue, 29 Jul 2025 21:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugvCf-0003Tx-89
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 21:01:57 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugvCd-0004mE-8x
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 21:01:56 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b26f7d2c1f1so7627863a12.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 18:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753837313; x=1754442113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vi2QCM5GKA+/mOomKJeUwGQ7BzgZo65UL+LjzBMT1yc=;
 b=ac1X/LhVyVDRz1fIdIvTBvvXKzDWWDU/Vv3BJhP/GOCLUWPN86F2LFgfUciURZFn5i
 sEK29CmXjSruiEsBJDxGBrxFVOYCLnzRIiS5KSvq/iUbiBCY5MkSop14I5gwis/aaSqX
 5QzS+yv2W7n7pncPJ0mNd+XleImBNeoGjXXBp/P1jMEf4jiWQ652Al56lFEsfWW1a0xN
 BodGUVzVHqhrEbWjVwGnHVsItoG4eGhEUZCLduWbX/FknK5Apa5+gn3ycC58ek3Ro9FP
 jy550D8nL/v7aTZjhJwhq2CyvrYSAGvc+K/wy6ScKhDHrsIyR0hnNvL7KzW04Xx8ZNLI
 4KnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753837313; x=1754442113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vi2QCM5GKA+/mOomKJeUwGQ7BzgZo65UL+LjzBMT1yc=;
 b=Cd7kQzyjHy6WvqNVAD4pP752JIycNr8S2j+rramzewc4MvxZsWTP9go6bTscUJH4p7
 ZEa+raRyKVsAZFXDM9zRQH9D6T0QE7FSPHfMGuQp7oUdWDrK8vHlXTq+SHcDiMMerFvK
 dZune8JQ49Pzj6pTbF6mylgrwwDQm/9s/e12qEZUIjDdDjsgwtmU4P9Oy/McPK0E3loQ
 sjKlIVST6CFUiV/pawZHiFNAxI47qYuAPhORQ6swV96mBBs8v5zotfLSuIqTtvI0JZ1B
 o2yne3ZQCpPjSSYvMrp43jjah6qH9SG7n2iLS7g7lQHKrRBIl1xV6WNHsKz4LZqHYBdg
 HQLA==
X-Gm-Message-State: AOJu0YzUXffemh3kcytiBntT+Cr9iE0ONc7xeaLwt8DA9d84GxzzpC+k
 gKPaNlNuvHhCww2h4UPhWzxxQ7p2FLc4PjzhNkNGj0GLsBSMOn1ZoaY96WVB6A==
X-Gm-Gg: ASbGncs6DM3/EqYoV2FTnX3EzXzlBIDy6WcMwbtyjaYtwf0mHxDwmz/Vb8A8XLKPufZ
 ktP+pLtm94Ubt9OGz73W6W7dKeBQgyltzT8b8RjPabeYFTN+oXDxMgSr4diGRzhdG7YJoLSCJdu
 DtBW17M+qUqg7dvXvj1bmODdWmANM94+LGZ7GRnntMYQjmNQIdEszGr9tyT26on4jdqpNto8GVZ
 yXUNzGKx5FOqZmjXcOPav/vAfKLIXRwkN4XsCAKE1EAU9Ct2HqvKHnfRhp7M6UsJ9uvIpCrYC28
 m3u+CVBy3xqlQ9Sb1AR1eHXE3W07VICUg4NbBuSE8ev6t2Fn+wWiz6dSnBiTJGMDBIHuCsqBteC
 MMFKlpncQ8KU7AiGa2aVRlAyK5rS+flxjcbo4wArGzFmobKkcHVQBIyIo0YDinFNJDOFfU53Aqy
 rOWrQpmh+BmGDklTyR582ZzApePvY=
X-Google-Smtp-Source: AGHT+IFaJB2Reh45WXnVC4qFHvkTOaqMJdh/8AuXSOnCdkvn9JYcxosZzgmjxHkQEVsB33jNkjx4VA==
X-Received: by 2002:a17:90b:4b09:b0:31f:32cd:97f0 with SMTP id
 98e67ed59e1d1-31f5ddb750dmr1886106a91.1.1753837313378; 
 Tue, 29 Jul 2025 18:01:53 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63df5adfsm343253a91.25.2025.07.29.18.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 18:01:52 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nutty Liu <liujingqi@lanxincomputing.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 07/11] target/riscv: do not call GETPC() in
 check_ret_from_m_mode()
Date: Wed, 30 Jul 2025 11:01:18 +1000
Message-ID: <20250730010122.4193496-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250730010122.4193496-1-alistair.francis@wdc.com>
References: <20250730010122.4193496-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x534.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

GETPC() should always be called from the top level helper, e.g. the
first helper that is called by the translation code. We stopped doing
that in commit 3157a553ec, and then we introduced problems when
unwinding the exceptions being thrown by helper_mret(), as reported by
[1].

Call GETPC() at the top level helper and pass the value along.

[1] https://gitlab.com/qemu-project/qemu/-/issues/3020

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Fixes: 3157a553ec ("target/riscv: Add Smrnmi mnret instruction")
Closes: https://gitlab.com/qemu-project/qemu/-/issues/3020
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Nutty Liu <liujingqi@lanxincomputing.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250714133739.1248296-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/op_helper.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 15460bf84b..110292e84d 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -355,21 +355,22 @@ target_ulong helper_sret(CPURISCVState *env)
 }
 
 static void check_ret_from_m_mode(CPURISCVState *env, target_ulong retpc,
-                                  target_ulong prev_priv)
+                                  target_ulong prev_priv,
+                                  uintptr_t ra)
 {
     if (!(env->priv >= PRV_M)) {
-        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
     }
 
     if (!riscv_cpu_allow_16bit_insn(&env_archcpu(env)->cfg,
                                     env->priv_ver,
                                     env->misa_ext) && (retpc & 0x3)) {
-        riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, ra);
     }
 
     if (riscv_cpu_cfg(env)->pmp &&
         !pmp_get_num_rules(env) && (prev_priv != PRV_M)) {
-        riscv_raise_exception(env, RISCV_EXCP_INST_ACCESS_FAULT, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_INST_ACCESS_FAULT, ra);
     }
 }
 static target_ulong ssdbltrp_mxret(CPURISCVState *env, target_ulong mstatus,
@@ -394,8 +395,9 @@ target_ulong helper_mret(CPURISCVState *env)
     target_ulong retpc = env->mepc & get_xepc_mask(env);
     uint64_t mstatus = env->mstatus;
     target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
+    uintptr_t ra = GETPC();
 
-    check_ret_from_m_mode(env, retpc, prev_priv);
+    check_ret_from_m_mode(env, retpc, prev_priv, ra);
 
     target_ulong prev_virt = get_field(env->mstatus, MSTATUS_MPV) &&
                              (prev_priv != PRV_M);
@@ -443,8 +445,9 @@ target_ulong helper_mnret(CPURISCVState *env)
     target_ulong retpc = env->mnepc;
     target_ulong prev_priv = get_field(env->mnstatus, MNSTATUS_MNPP);
     target_ulong prev_virt;
+    uintptr_t ra = GETPC();
 
-    check_ret_from_m_mode(env, retpc, prev_priv);
+    check_ret_from_m_mode(env, retpc, prev_priv, ra);
 
     prev_virt = get_field(env->mnstatus, MNSTATUS_MNPV) &&
                 (prev_priv != PRV_M);
-- 
2.50.0


