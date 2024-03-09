Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05DFC54E5D
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 20:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj3Y4-0005fj-Gy; Sat, 09 Mar 2024 15:44:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rj3Y1-0005ek-3n
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 15:44:01 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rj3Xz-0006T3-M9
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 15:44:00 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e6381df003so2807855b3a.0
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 12:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710017037; x=1710621837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8PUZYN/jxC55WgIbgr/YDIPnxwzEfC4uN3+8U/WL+Ts=;
 b=fp0DPaMDZTOZUIy/5skvHEj7oFUvvOszbR1XlVnc4QX5W7Z+ZqCYLP+QI3hsaj4f2t
 wfBgRq3FLY/S3a6oJqmmdBzGCGCDBtvn4iFGdTy296+7UNamuTe79gLaYXSkW4YF4R/0
 DhHK+zo2ibl8TfkOFzNGQdgXvfV9KWAdfQHpjj30vNYrmvnShw9LMutX0qzWLHFbNo6P
 iCfSRk1sEX8ZyfpoDXNPBKO+HXm79sbFkdZNFA7LxbldzaezyVx8UnKIXaLb/F73iNem
 z1c46HQZkWiMGESWkaynNZ8aeYE/9CamZkyhsrkFOgQSF4gj06Xai/gMhhdEys4fbif8
 sKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710017037; x=1710621837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8PUZYN/jxC55WgIbgr/YDIPnxwzEfC4uN3+8U/WL+Ts=;
 b=XUHKFOFVAfRBLHrHNg97yTwmSpsUvtePqoW8PQ+BwoM6cPKwRngeYPqrF6jA+Yr+1g
 kcF+2sdgRzN3wT0bY//Sr7wBAMHQxPkeWe4h33kqlaYp876Q1hPHYSrdL0m0sf1Bxs8w
 MjlAX8lXPnquwi/tb/bfsShRb1rt+m6EnX5bqFr/YRqx9ka6D5Xa88KL3EKPkukqgRyx
 2asWMfaNty37R8JDloH5IYv6vUdc8faK3GqLBhGxyn9Vt4qgWcm8+hqIcttYWwf3BIjA
 AU3s3NY+pNfQeX4adhte7/bUBpmO5RQ61Zy8C+lBeRgMq0xt6rDDI32e0B/Q1k1hC/1W
 y6yg==
X-Gm-Message-State: AOJu0YxCW73aWv7QdAMTEZxugngrS8wnwx//HSVwwX7jebLC5skiQOAu
 /jGo5alvH/6KMny6NylmO2Sq1aUgwvxbDpjn4TP13LoToRU3+kK4bcqUObhHl+hymYYtBhGB04G
 G
X-Google-Smtp-Source: AGHT+IGdzGvX7mrERarF76JhhcsgAy8gKj/MPyUvYbkJWErAuMmz7huIIdn+UAkIPc3UJcgL3hUeew==
X-Received: by 2002:a05:6a00:4f8d:b0:6e6:412d:1cd2 with SMTP id
 ld13-20020a056a004f8d00b006e6412d1cd2mr4085586pfb.14.1710017037753; 
 Sat, 09 Mar 2024 12:43:57 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 ey15-20020a056a0038cf00b006e647716b6esm1656270pfb.149.2024.03.09.12.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 12:43:57 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 01/10] target/riscv/vector_helper.c: set vstart = 0 in
 GEN_VEXT_VSLIDEUP_VX()
Date: Sat,  9 Mar 2024 17:43:36 -0300
Message-ID: <20240309204347.174251-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240309204347.174251-1-dbarboza@ventanamicro.com>
References: <20240309204347.174251-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x435.google.com
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


