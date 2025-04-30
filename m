Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDF9C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 08:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA2iT-0008Vu-Bs; Wed, 30 Apr 2025 04:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1uA2iQ-0008Vd-3l
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 04:22:50 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1uA2iO-0002ew-07
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 04:22:49 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-72bbead793dso5576417a34.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 01:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1746001365; x=1746606165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9p+M3a0+ZrpBZKw9HCYA3LwNf/EjFyeiq9XhHUkp/SI=;
 b=egZmbGfRBWr6ZVn61dHLMxY3JswZuCJ0+e2u4YOrm+IGXeCUuamx2F2B7mpoiDtXvR
 e2GZEmlVUUJCnndDETmXDe3nK4BecxIfrz2lAGhUjx+UsTP87ztRlMr/fC43PIhH03De
 tus/fzEIMD1iNFfzPmzBf55N16RYKXJT9BtRl3xSJDxO2Lq3zTWdEWBWjxXJAM5X8P9H
 Ca0VPZv6iVse+l1i2vdt+n6VCesmaETSFaYva4OqCzjU6zy/cf7Xv4zZ4VuvuXRjnZ7M
 lMYzoy83NsH+cf1A9CpOweV7xbcCcdSdBlfSO4agFCXGl7n+BFO1pEC0KTMqXJYy/3RC
 ROXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746001365; x=1746606165;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9p+M3a0+ZrpBZKw9HCYA3LwNf/EjFyeiq9XhHUkp/SI=;
 b=MeAYcdPxh4ZgGl0p1TIhxCpFra0rWG3gSjRFTAdJIiQcDFiB+8nnNUQN6/vaSagUdP
 1zFM44UeGZASpKsTdqmWmKiaeEOzXrCsYMrf7e7AFMJAaCqQbtIHhgDjh8Ziz7qFKz/6
 slLMwEKiuiU2fAPl77basFeUvds9RJBCZllVWp3IJbno/ZLrzlba+Fgm15XaeL5HJQ4d
 elYMIJ/PBlJeRYlxkLrPpthx1hB4R2o6MWlHRLY/8uY0BZ52Qg9DAPSxvrj6gvjVrhyQ
 ICxRmIn7rRTfgTm95+DJ+6uOFVCUW81iIjfXHEYuBaAFpKIbvEx/qH48q77NcORnLElX
 dIsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWykDz70HzW4m1h7Bx4vAcpdgOhfp8Req2iLicFVXhfWrEfxOoumvZ+qUt2w5uKMmLdYfxFrWS2DOAc@nongnu.org
X-Gm-Message-State: AOJu0YyC2dLqZ2U780FhxOmu9VKGrxQib64p2TmqHC9hJ67S4lbK3iyh
 pFo2IQo0XxNtFqdJ1XkrDOkdE3mmgkSOU3YhMOTTNjD/A22mNgHRz17+VLGQLEU=
X-Gm-Gg: ASbGnctWM3yFWLcnu7oYouVLBBMD/446VpVSxlPNHeP3HUTHrD2xWnlyKdNmHOyaGxv
 ZRZ1lfSi8eqm2LgwV/4FEqRQuKhf/mUMjPZl4RR8TiGxnN25T4T6uPQhdXuBxALlXQUiDKFVf/K
 usVn5pQ3lkG4+nprz+SqNcjaS8ZIapAu5xw4dQ5mIX3OyG5/BHp9hryVnhn47GtMzCUpkeUfcAr
 HEwKEMsxWaMeEIcLin170di4Rgl0ZmWWhpR8ZtA7FsXpprf4BGX403sIV4hk9Z97MeegE/jVFJA
 iyrBl4To3LY/WCX02pAA6aRub26WBA2CPIhZ5LdVP5aoUxtE8XAsfWqJhPL9UK5eTLL/ldk9aEA
 =
X-Google-Smtp-Source: AGHT+IG5YDY3gZZSC8W9a1bK/GX0lb3ui9tAXgtAMc39X5w1OCcKetwffT6JwXD7XcHRwT9Tn/JoMA==
X-Received: by 2002:a05:6870:4149:b0:2b8:fab0:33c with SMTP id
 586e51a60fabf-2da69f2a015mr1154476fac.23.1746001365461; 
 Wed, 30 Apr 2025 01:22:45 -0700 (PDT)
Received: from ausc-rvsw-c-01-anton.tenstorrent.com ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2da6e0523d6sm308556fac.6.2025.04.30.01.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 01:22:43 -0700 (PDT)
From: Anton Blanchard <antonb@tenstorrent.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Anton Blanchard <antonb@tenstorrent.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH] target/riscv: Fix fcvt.s.bf16 NaN box checking
Date: Wed, 30 Apr 2025 08:22:13 +0000
Message-Id: <20250430082213.1418201-1-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=antonb@tenstorrent.com; helo=mail-ot1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

fcvt.s.bf16 uses the FP16 check_nanbox_h() which returns an FP16
quiet NaN. Add check_nanbox_bf16() which returns a BF16 quiet NaN.
---
 target/riscv/fpu_helper.c |  2 +-
 target/riscv/internals.h  | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index 91b1a56d10..31c17399fc 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -756,6 +756,6 @@ uint64_t helper_fcvt_bf16_s(CPURISCVState *env, uint64_t rs1)
 
 uint64_t helper_fcvt_s_bf16(CPURISCVState *env, uint64_t rs1)
 {
-    float16 frs1 = check_nanbox_h(env, rs1);
+    float16 frs1 = check_nanbox_bf16(env, rs1);
     return nanbox_s(env, bfloat16_to_float32(frs1, &env->fp_status));
 }
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 213aff31d8..794c81bf7c 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -142,6 +142,22 @@ static inline float16 check_nanbox_h(CPURISCVState *env, uint64_t f)
     }
 }
 
+static inline float16 check_nanbox_bf16(CPURISCVState *env, uint64_t f)
+{
+    /* Disable nanbox check when enable zfinx */
+    if (env_archcpu(env)->cfg.ext_zfinx) {
+        return (uint16_t)f;
+    }
+
+    uint64_t mask = MAKE_64BIT_MASK(16, 48);
+
+    if (likely((f & mask) == mask)) {
+        return (uint16_t)f;
+    } else {
+        return 0x7FC0u; /* default qnan */
+    }
+}
+
 #ifndef CONFIG_USER_ONLY
 /* Our implementation of SysemuCPUOps::has_work */
 bool riscv_cpu_has_work(CPUState *cs);
-- 
2.34.1


