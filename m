Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B27C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjk5Y-0004zR-4q; Mon, 11 Mar 2024 14:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjk4g-0004pr-TR
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:08:36 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjk4f-0004It-7q
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:08:34 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-29b70bf6c58so2625350a91.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 11:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710180511; x=1710785311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8PUZYN/jxC55WgIbgr/YDIPnxwzEfC4uN3+8U/WL+Ts=;
 b=jFYDMoOkzZwUh38bUW2z9y4nlZOUCMsLmy6A7e4CZjIJvqfQ+MKbLeSngSPoPqBBDo
 MtLPuG51epIiz6LeNpNIzlqH6IdkQtMK5Kn54Gid6M//d5LTMO1QLvcNTviZIjOce17c
 EGjP3DzesyCnEnmuD+76iGm1kwj6gpcTJ6jD3AlzL8lTVpKrrX2gDKCoJ+rrm2PTzV0H
 5dxJlBI4jtU6ZoyiwHE6pSyQPakH6Dm7hyRpyQdQYU0J8nLWq9PNI2j4dZvtlDYQqzwU
 zDt4jT7bUAu9gWThIG/UU5Wjml0Wkp2qG2yw+eXiv6yzXAWszLgE82hH0XgNh+Z5cWqv
 bZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710180511; x=1710785311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8PUZYN/jxC55WgIbgr/YDIPnxwzEfC4uN3+8U/WL+Ts=;
 b=SHgnaZpIcGBV+lqOVaiKa09DXhK7At+saxXC4TWST6bHt+IvDKa7BB0UgTvipgLtDT
 IuJoa7YN9htgGUB0Z15dTFxITKFrHH1o74XFu09pQReXF969dOK0eQqxemoCUsxfB66E
 ofmSk8mTVfV0vrUJNZ9z0Rs88B4m0Yc28znAEDO8nQHIVzSSPfIjTPPAqC0xdKAb28FS
 xVSLNNeN8VoMmPbXag0MVxyjdGd0NYMUzFhttxxKZ+nFelSaNgThRK1OVSHcB2mLwh00
 AWWLySGNn989ynKni8r2G2o1aYYugVtZGVtzT29iXWGwI3zIDps65S4IgZlmbRvnsCWW
 PnTQ==
X-Gm-Message-State: AOJu0YxeK1GflBSeU73jgBGucRpJJhSaKF9fPcWd2iPyV+EqLdoPHtMa
 sD6jzx/WKJuOnwmJRWvB+R1JAoh1mWBIATe5iewr0xG/sTEyyMgM4lIAGq9QRvemeOOKRuZKNuP
 M
X-Google-Smtp-Source: AGHT+IH/v/Zk6NIUoGQOtQXjxmzkM3vdTAyTEK1zJP7dwWM9KOoV8nUEQxo2vxKJtV3CtvzOhnKz4A==
X-Received: by 2002:a17:90b:d87:b0:29c:30b8:d617 with SMTP id
 bg7-20020a17090b0d8700b0029c30b8d617mr228958pjb.16.1710180510968; 
 Mon, 11 Mar 2024 11:08:30 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 hk13-20020a17090b224d00b0029c2794d3f7sm525810pjb.7.2024.03.11.11.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 11:08:30 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 philmd@linaro.org, richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v12 1/7] target/riscv/vector_helper.c: set vstart = 0 in
 GEN_VEXT_VSLIDEUP_VX()
Date: Mon, 11 Mar 2024 15:08:15 -0300
Message-ID: <20240311180821.250469-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240311180821.250469-1-dbarboza@ventanamicro.com>
References: <20240311180821.250469-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1035.google.com
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

The helper isn't setting env->vstart = 0 after its execution, as it is
expected from every vector instruction that completes successfully.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index fe56c007d5..ca79571ae2 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4781,6 +4781,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
         }                                                                 \
         *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));          \
     }                                                                     \
+    env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
     vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
 }
-- 
2.43.2


