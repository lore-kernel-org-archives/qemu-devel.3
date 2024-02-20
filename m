Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343C4C54764
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYZN-0002iI-IQ; Tue, 20 Feb 2024 17:26:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcYYQ-0002R0-Fz
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:25:34 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcYYP-0003Z3-0V
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:25:34 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dbae7b8ff2so24537455ad.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 14:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708467931; x=1709072731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AbjV56HSNPOfq6zJHSiyHtAr0YbtPcePp6SnmecF8j8=;
 b=U1p4l1u8DwxCp6mIQQkSUInxPufulHlZSxgqaWgN/gVEUN2T6zpuuHyVUyHuR8+M+V
 /XLrGvVbHGbFX1KZmf0M1YaEUTnscRLHcx2kQiITjggrwBem0eTCOO4cqJ2Ho670OkIr
 24rZB+JzqRundzG90azDWKCJrZ1PPRlYnMdsYk9UuAYYhqkI3uyRmrBQpLJmAUiFHZwx
 bdBbUA0EW0o0dBY0gziN0t0ZCFgBC1lx8jwokcWmAr9frp5JKRx8yp7+8PgoJpdUG4mI
 EGlqoPyU6eTBJlgZelEGRKRInbHAQKw67s6/3qqjYNYKoBM2QVw6I+yT0lHoe0GncUl4
 dciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708467931; x=1709072731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AbjV56HSNPOfq6zJHSiyHtAr0YbtPcePp6SnmecF8j8=;
 b=SOveIH4nxWNQnqg1Q44P37S8VSLZ0IPLfgP5a4PhUsRsPciZGWQBEnuFnTubPIbc3n
 cmDd/GymC6IowJaRUOhAlznDTZmghGK5OzOMP+ggY87VJpceFnsLX5uz2lgQIj0KXUkK
 tSSDPYZUpwIBXwZswuUoy0zi2Qr2o/iwiNrPOZUtGwKiNCvqfBkkYiOJIEJR+n6Sc83s
 ENLVafhQE1Cf0OLzYeGzWkS2cIBTJ3ItYyeQtVgkpjiCikNsCyXskrDzBApHmyriSfMl
 gMKm04Vos6N7wwzLRS/p1M4wspAuXJgFpphzMRxrHGZ5bR/jyYcYxHbjTj8GwFoM4zQV
 3QUw==
X-Gm-Message-State: AOJu0Yy9rxw2pLSB3VNAlFbnMBdcqXAWj8hJDzuT9S8fdjWEONZ7Vhdz
 qizkil60GdouExQoBc9JujtKZNbxtOrij6S4YWR3oywOIojtR5w1ERnJF9pGhmifK46VsAgsxAa
 2
X-Google-Smtp-Source: AGHT+IEDra0zM6Ku0YS2LD7n6JfqWROrcg3/OP/2XuVoKm57CrjFPDwT21G3oHjjHWr9XmHth3X2HQ==
X-Received: by 2002:a17:902:da87:b0:1d9:2158:1308 with SMTP id
 j7-20020a170902da8700b001d921581308mr20498966plx.28.1708467931147; 
 Tue, 20 Feb 2024 14:25:31 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 iw20-20020a170903045400b001dbb86b88e5sm6761044plb.124.2024.02.20.14.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 14:25:30 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 4/6] target/riscv/vector_helper.c: set vstart = 0 in
 GEN_VEXT_VSLIDEUP_VX()
Date: Tue, 20 Feb 2024 19:25:08 -0300
Message-ID: <20240220222510.209448-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220222510.209448-1-dbarboza@ventanamicro.com>
References: <20240220222510.209448-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
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
---
 target/riscv/vector_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 84cec73eb2..cc7290a1bb 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4782,6 +4782,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
         }                                                                 \
         *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));          \
     }                                                                     \
+    env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
     vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
 }
-- 
2.43.2


