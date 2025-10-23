Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406E1CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBn42-00040C-NF; Thu, 23 Oct 2025 00:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBn3p-0003qN-DK
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:36:28 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBn3n-0001aq-HU
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:36:24 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-290b48e09a7so4457575ad.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761194182; x=1761798982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QI6TJMPtaM0+7myaheiZ8p5Uvu3cs2aSIj1ObAHg/hk=;
 b=jFugGKvXVtiQpIR+sPT5GvIBTOGh+AIn/mSZBeZzMRR6k9mS6aE6ubF9bUocrSezD2
 ELEIImNzI2PrDe+/k8QTSBJCVVwrT5/DRqff/Q0Ai3ti5mqj7sPPArg0UyZlYJXt3nZF
 cwttwjFFCU/sqGvkBkXeqxz0dN2RGtMo2fK8QfpAsy9rPEkVqUB/F7pb5PQw4aD5Iz3x
 6WKXTWD0i4MTDiTjYwbf/RDoGMPa0UPe6xFi3axiRhy7iFaB2tOTQndazG/BIK5rRFTs
 TzgYPZsFjGpqSLSEkD65RjhihZhDm40op+u87oRV8tAzt8ScqXsX8MHA79z3AXGR13K7
 9omA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761194182; x=1761798982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QI6TJMPtaM0+7myaheiZ8p5Uvu3cs2aSIj1ObAHg/hk=;
 b=Qw4YKD0aKoN/WlyAbSXMlnYhZub70909n3wK05smr8SZJ00Kknr0cmKELbp/f+yoHV
 lE4wYzC6ZczloqqELLxLEHcQNcqNozSIR5TArMsSo89ePAXo73gKXZ1ZbPQ4SBFTjfhj
 5/G9AAwCU8YQ4Pz9kPSA8A4ktdN8H22habzZdF+3NNRr9nju5Lj5qsl+ZMvkOh6aVhEM
 Pfh8ETiWtmmVXuT2rfj/IZcI912BiJMEkPPraq3W6FRPiv2G3/UobNnNDG0mOMX8BnyB
 yWleP9FxwTFKkYbEUIw3CPtl9DEG87/DiUuTf56jhMXKJbUFTCTqtGrYkpfc3ECXtg61
 eiGA==
X-Gm-Message-State: AOJu0YxfcK0lU8m3ECLC4bpBDWp8qCaQ8uE4+YBhTd2qHWYy+n1Jyy9m
 Q0dnz56pO4rClRVxU+Z8VbzxM0HDaho27smqTR3aj/l1EsTAY7gq4/9BwniZDA==
X-Gm-Gg: ASbGncuHUoXVkkeEn6miVsdqzOhzPu2i1eTFlkkP0IDavdPQQcnGtJZ12L8XSfdNAcH
 iql6Uz5Mcpruh6XY5wOYKOx7AWD86BeUEnZ7Bvr/sA+Orgd2DZXu99FKKf+cnuyA7VMigiXnZSD
 T4eI9f94vBzOfylGA4Wc1hd6wZOexguemmCae8bNivPk7H7BbUGtSzVzxWymDZTqOMp7ETeChUc
 dpBbpJj5b53ksyh9ZlJKTaYr225jH/KbJoECOyAqrZ03x5FB3xNJUp4Z8GdodMS7zYFuuPVbMOp
 SE64Di6+WPQrnk2zZGqdwzziX7ZnmjCUhEmzo2YTfNe3883efZ39CBG8qG6rRqFe0j7q6z9UhBi
 R0i1iY5f72wKkg4dYpz139T+3NQwj+EIvLxfXvRNTJr/Pt+EsxxF8p+4qxXac8xlTbG9S88ReSY
 Jb7gHJ4W9IbYm8pL+uU2ddnpbDe4CXZ0MqBtgFrDrZMaVhlo/c5Tr+YFj5RzQ+WmnJzgT1eNW51
 9H2u22lm+yg/cYWgK4=
X-Google-Smtp-Source: AGHT+IGjCQANlZbN9VctTDuZEO1yh3sGPBzUnC1FDUaTBxbRySVkcPmBN7zb9cJefgnmFovtMhUoxg==
X-Received: by 2002:a17:902:f610:b0:272:2bf1:6a21 with SMTP id
 d9443c01a7336-290c9ca72aamr321529575ad.14.1761194181763; 
 Wed, 22 Oct 2025 21:36:21 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946dfc113csm8643015ad.68.2025.10.22.21.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:36:21 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 35/37] target/riscv: Fix a uninitialized variable warning
Date: Thu, 23 Oct 2025 14:35:18 +1000
Message-ID: <20251023043520.1777130-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023043520.1777130-1-alistair.francis@wdc.com>
References: <20251023043520.1777130-1-alistair.francis@wdc.com>
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

riscv_cpu_validate_v() left its variable, min_vlen, uninitialized if
no vector extension is available, causing a compiler warning.

Re-define riscv_cpu_validate_v() as no-op when no vector extension is
available to prevent the scenario that will read the unintialized
variable by construction. It also simplifies its caller as a bonus.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20251021-vlen-v2-1-1fb581d4c6bf@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 1150bd1469..d3968251fa 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -426,6 +426,8 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
         min_vlen = 64;
     } else if (cfg->ext_zve32x) {
         min_vlen = 32;
+    } else {
+        return;
     }
 
     if (vlen > RV_VLEN_MAX || vlen < min_vlen) {
@@ -676,12 +678,10 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (cpu->cfg.ext_zve32x) {
-        riscv_cpu_validate_v(env, &cpu->cfg, &local_err);
-        if (local_err != NULL) {
-            error_propagate(errp, local_err);
-            return;
-        }
+    riscv_cpu_validate_v(env, &cpu->cfg, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
     }
 
     /* The Zve64d extension depends on the Zve64f extension */
-- 
2.51.0


