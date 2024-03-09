Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89B4C54E67
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 20:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj3Y9-0005jF-It; Sat, 09 Mar 2024 15:44:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rj3Y8-0005iV-2Z
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 15:44:08 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rj3Y6-0006d1-Lv
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 15:44:07 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6da202aa138so2072650b3a.2
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 12:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710017044; x=1710621844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w061jCPPwUR4u6cbb77XQauyX2K6ooNzzeN6qQfz33k=;
 b=bAfRVOp+I1R3kqJoy03wqW+ixZSiSA6BafTqETn9KusbqxDOvwz1UZpUKqD3XTdnCC
 aXL8utnzZ2WF9XXO45PFGrjVy8Ou+gykALqD1ba7qDpK2NISNsIriJ2VPQ9BrPj5r0MK
 osg8TP2RcgGDsCFhQZvTDEJ66CDyzg/aWufKa4HaURCa7OIx6TKA7NqP14JnYUPTXdYt
 5makNZN3opBm//aobtH1RvVBZFow0VrZjnQaK9nQu4ZcAHW7cDyGARYiJlNRXM2M9hFW
 zCfEPSNWFIndF8MCAV21MGUZENshBtNKCvSbW9d2zPVjfK6Uz8PXjTkaTUR05Ue8rhJ6
 SShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710017044; x=1710621844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w061jCPPwUR4u6cbb77XQauyX2K6ooNzzeN6qQfz33k=;
 b=O8QQ83/CU29pctXESAEuWxjwL2vPSaLawArQwJOrVPJv7QMXcWmePrVU32xzh4Y5TV
 8tlUZ2Nsrvg4qLq39CGFuBUeEXJW1HGChCU+GOHzcrRpqudrwGB4EczZuiPrxFDrkMlj
 9QhIqNvG5bImRSAK2pPM6ZJ1Wj083L31OxBS2R5GDrBssht6tHeU+QiYdLtrEz5DjA2L
 P6vme51jgCiGAUqxdgwNgUFtT0y8UZHwIOvSaKcyuBRLP/McXX50IS0eGFGRHugKf5il
 qajk9lQZxYN9FAyQtinJanrFhYRS45g8EdYgfE72gV2nLyD5Ym1QPJeNx1XFaVEFE0zs
 CX0Q==
X-Gm-Message-State: AOJu0Yw7jovYt3feB0fahl47npcrZfMa64B6MACAdCZBaiaSQd0Z/P/g
 66S6UHeFRsQMD+Oabz/bSL0gx5CsrKjjUyTokfqC8XbHkDM7UrnYsKi1xuAzhgwRn9Wh5/Pnz8w
 x
X-Google-Smtp-Source: AGHT+IEvq2hVuT5gS2at6A+Ja0Cuen73LJt7ab+XcA/qaTvhcSOpUCiddI63qz5S1x3m+FuYewkHsA==
X-Received: by 2002:a05:6a00:c95:b0:6e6:3406:26d3 with SMTP id
 a21-20020a056a000c9500b006e6340626d3mr4909647pfv.4.1710017044607; 
 Sat, 09 Mar 2024 12:44:04 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 ey15-20020a056a0038cf00b006e647716b6esm1656270pfb.149.2024.03.09.12.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 12:44:04 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 03/10] target/riscv/vector_helper.c: do vstart=0 after
 updating tail
Date: Sat,  9 Mar 2024 17:43:38 -0300
Message-ID: <20240309204347.174251-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240309204347.174251-1-dbarboza@ventanamicro.com>
References: <20240309204347.174251-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

vext_vv_rm_1() and vext_vv_rm_2() are setting vstart = 0 before their
respective callers (vext_vv_rm_2 and  vext_vx_rm_2) update the tail
elements.

This is benign now, but we'll convert the tail updates to use
vext_set_tail_elems_1s(), and this function is sensitive to vstart
changes. Do vstart = 0 after vext_set_elems_1s() now to make the
conversion easier.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/vector_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index a3b496b6e9..86b990ce03 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -1962,7 +1962,6 @@ vext_vv_rm_1(void *vd, void *v0, void *vs1, void *vs2,
         }
         fn(vd, vs1, vs2, i, env, vxrm);
     }
-    env->vstart = 0;
 }
 
 static inline void
@@ -1997,6 +1996,7 @@ vext_vv_rm_2(void *vd, void *v0, void *vs1, void *vs2,
     }
     /* set tail elements to 1s */
     vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);
+    env->vstart = 0;
 }
 
 /* generate helpers for fixed point instructions with OPIVV format */
@@ -2087,7 +2087,6 @@ vext_vx_rm_1(void *vd, void *v0, target_long s1, void *vs2,
         }
         fn(vd, s1, vs2, i, env, vxrm);
     }
-    env->vstart = 0;
 }
 
 static inline void
@@ -2122,6 +2121,7 @@ vext_vx_rm_2(void *vd, void *v0, target_long s1, void *vs2,
     }
     /* set tail elements to 1s */
     vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);
+    env->vstart = 0;
 }
 
 /* generate helpers for fixed point instructions with OPIVX format */
-- 
2.43.2


