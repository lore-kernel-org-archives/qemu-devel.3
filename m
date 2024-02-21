Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39F6C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcuCk-0005gc-3H; Wed, 21 Feb 2024 16:32:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcuCO-0005Dg-AO
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:32:17 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcuCJ-0004QX-23
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:32:12 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d95d67ff45so9577385ad.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708551128; x=1709155928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AbjV56HSNPOfq6zJHSiyHtAr0YbtPcePp6SnmecF8j8=;
 b=U0kB0mt187rTiDk915VCp56BsqBsK94N0xHOpKeRRGGIhxZ8GAafejvOPzY6MgFgLx
 h1oY3UPvoENXaxyOsIzzI4r4/yz3a1GuSZSOYCze6etE4QTEfgtbRT5sB7dFeW4WvIFn
 9QGA8Sj/8BjRlZkmxnlc3yEkerV4mbjziCEROx77A34hvgrHh/PmOxNRO610e52OWINQ
 pJnQLWjDiELzI0Z34GJsqhbhA15MPbdPSwfCCY/CZ+hF34cxrq1r/9UQVzZFA73TdX7A
 OEK8tNObkdJ3Pu14skBlA9XMkfYwop+lieabQ97BrLQ0pM3JP9iYE7iDW7oKbsHf1HjQ
 s7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708551128; x=1709155928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AbjV56HSNPOfq6zJHSiyHtAr0YbtPcePp6SnmecF8j8=;
 b=c3XKSne9QWHSagYymoEqZ6jDWeLQJAX6KkCArYDgcqX8CoDApAr064zpRfNumdeK8W
 lIErmy0enJq9fAJg/VPrpvxfLTSyvNNfU8sdC1ssOdzWEIbncSSN5b+sruPKpUSao1vk
 YxQz53kQNWK6fvRUkPsPIFPcwTtvxMwJuCui7MvslzxxyzT+8h7FXrf6YgYAahkTGBfZ
 oE/RsfUvvZLoonJQ8o57TxVdFZWFCRQPMGsYzN55013QesV+F6iCrtj3gDyHGHIz3YG8
 jfZiXJCtSAhxr/irUdDQKTJOxQyigt6+GVwk1FJMLz3Ng7UpCcj7U7a5D18ZIsie1tWo
 NPmQ==
X-Gm-Message-State: AOJu0YwUU1f0nWUxqB+Kf+nVR5q/lBZoc1I+2q3o5RnUTHdfsejhw2UX
 2ry0CknYZwAELOMN6SCuF4u7hrFWYPdiWr6ikAdvqOoldEnM77ML5KbnnadbcWz616NRndIvsxc
 C
X-Google-Smtp-Source: AGHT+IEWFgSh3W5i0iNlhs//EVm/xFWm06EJ+8YOX7EY0qQNRKblKNaB61ryBvWf5H8gLEobfh1j0g==
X-Received: by 2002:a17:902:e804:b0:1dc:334:a85e with SMTP id
 u4-20020a170902e80400b001dc0334a85emr10407478plg.17.1708551127731; 
 Wed, 21 Feb 2024 13:32:07 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 a19-20020a170902ee9300b001dbb0348733sm6618051pld.67.2024.02.21.13.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 13:32:07 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 6/9] target/riscv/vector_helper.c: set vstart = 0 in
 GEN_VEXT_VSLIDEUP_VX()
Date: Wed, 21 Feb 2024 18:31:37 -0300
Message-ID: <20240221213140.365232-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221213140.365232-1-dbarboza@ventanamicro.com>
References: <20240221213140.365232-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62c.google.com
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


