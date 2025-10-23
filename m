Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98163CCD1BF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 23:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC58O-00058w-W8; Thu, 23 Oct 2025 19:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC58N-00058e-OO
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:54:19 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC58M-00082m-47
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:54:19 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b6329b6e3b0so2185761a12.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 16:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761263656; x=1761868456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QI6TJMPtaM0+7myaheiZ8p5Uvu3cs2aSIj1ObAHg/hk=;
 b=QsG/LveKgUIeUbPWv94uCxJysN9WbGv3Sdb/XrSCgV0P9G4KKYmnB4i0Zvdw4OGcVW
 d24uKdZUMNuR10d1wbSBVAp4jp0P22rz9ZAU7z5RQfmV2VTn7uucECsRsCvwownZ07ix
 WXts5Caurs4BAVcWaBAdM8UIVle6vCxNs3i+hN120BHSMj2HTMfsqGoYqL9ZAb3Zw2xy
 prNkVahC7qGQgfZZ7AXg6sTDlWuoU4taR7tAM1SI9fxg/QsDu2MkD1vXapTNcPArkX7B
 o2l3Y7U9zEdF1EwsZa852wHEym9kEIh02RDESjfCvoSm9xcVOTgengPWMqB0/Dm816oP
 o+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761263656; x=1761868456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QI6TJMPtaM0+7myaheiZ8p5Uvu3cs2aSIj1ObAHg/hk=;
 b=CCsCNf4m6Sd52NSqmN3nuLluk3Fsw6tM/+83pBE9SzXkVQpcXWzfy7lvwurqBtOrFT
 iWJktO9O0TEETkW9FHNqnV+K/DC8drcOb4pmqIue3+i+wM1Qt4xtamXIdJGC3NDjBRPg
 MDHAkBUXnAOv/IKRAJbDJtzquQ+bILmhJcCrs/Ecq7XFAW02WlN53/huQNy3GHC30x2n
 geHCdQJpa6l37zJF+sz2HJFLXnwTrpiklx2WVOVS5W+HgGJQagtqE27vbcydnPBYofSv
 KYhgen5sHrBT2Tkecb7bzlHGvzoKKWFGCCKdlBdOSiINKOlG+MpUj2Zo6l8rqB4GlQtA
 +uNA==
X-Gm-Message-State: AOJu0YwVa+YJede4giTIWiS5OMqo2dv/7ljt3dbum1exEgGo1VWvPOHN
 6WNEFN1ZA2ohXufDaob1khvl6ukWvzMyOQQWFvYZ3bD4xKjgoZysCV29E1x4fw==
X-Gm-Gg: ASbGncsJot9w+8DixKDzbiQuQP5mr9XegPNfX98Sj1PPXa+jj8m1akIbF9EvdF9bf+6
 oziTa8ZpCEjICOq5/zwzFnczpBtVE93x1Rj0wKBB6A0UmN+VDUgW+Idwm5QkZ+AINYDWZgIzqoi
 6by+/4LNOM1EWV4nO1O1rNAHgwmRx3UbyXHHuLscGcgg+86I/OYpZbtBV2KG4xqWaf724Aq+2FV
 ys8zXipb9YyAjlqVJMig4kcvdgr3J0VJRQbEOfi786hOlBYoqdQN0Opn8o+Sz7tcKIripV5EpAy
 QmSMOSfRa/0iVPG4pNYeJnndzptZSdlW4jnYNeHfTfNj4WJRYscOp9wuMMQnll08mdnjrWfO88Z
 4aNtvz9HC3/utk5MIHdpmZbORTSrWllp/ZCDLYxPQW+4myuaGVeQsP17gMYz6wCs2TzWVgTF9oB
 5F2w/+gxo9Ik1O6BNHLbvXaIJ2PlbSufR6hWPD+jwml68V5Xl/3ugBF6NgFV+ZL5HaR25BjBxTW
 QoGSlBo
X-Google-Smtp-Source: AGHT+IG+d8H6H3+dK1ghRGYfY1mgU7mQ8gVCJuvqUn4aK+i/G2W8lFb+3mthyg1LgL7Svv+Jdu0d3Q==
X-Received: by 2002:a17:902:dacf:b0:269:8eba:e9b2 with SMTP id
 d9443c01a7336-29489e6c09amr7680695ad.29.1761263656220; 
 Thu, 23 Oct 2025 16:54:16 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946dda7949sm36542295ad.3.2025.10.23.16.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 16:54:15 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 23/25] target/riscv: Fix a uninitialized variable warning
Date: Fri, 24 Oct 2025 09:54:03 +1000
Message-ID: <20251023235405.1865337-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023235405.1865337-1-alistair.francis@wdc.com>
References: <20251023235405.1865337-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52b.google.com
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


