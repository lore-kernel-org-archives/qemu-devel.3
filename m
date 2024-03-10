Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D56C54E58
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 11:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjHkX-0007no-Kp; Sun, 10 Mar 2024 07:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjHkG-0007ij-3h
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 07:53:37 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjHkE-00042S-Iu
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 07:53:35 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5cfd95130c6so2514628a12.1
 for <qemu-devel@nongnu.org>; Sun, 10 Mar 2024 04:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710071612; x=1710676412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dkHaxAaccqLTSQvWjOIYNF50FjoIR0eELlfVCBEjemM=;
 b=YnBAqt6chxfjRtD4WWayBw70WWQV7LQYcQcPHmNVEmgjc+Tt+KXfCqCH7Ndyu9NNis
 XCbWGtiIw4hDnEkqVsd3b8EL88SBBzJZ7WyDU3lJyGw5STdkRvGptXlpEetxMCl+y9IV
 XcVzKZfvAT+Du1Db9vq1JcVhmPO4gWBDu5ew+D6oVk+S8n5IS1qfBkJMcG12ntw0jQIl
 gbaTvIdck8Zvp92xrNcObmk132fjlh7IqAx/paYUIoviHXIJiJDnlhlgV1Hxv0JRAdpF
 mGitlqsglsp8XjABFyCag9bhM+WJIFEAaW9/mhvBYf4I8Ps2naeeF6HWMeNT+Xw/3Fj0
 2giQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710071612; x=1710676412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dkHaxAaccqLTSQvWjOIYNF50FjoIR0eELlfVCBEjemM=;
 b=qcfaAVvhOA0i+cxuE5Kf0801HBXO7SqGvAgcV1tlH0uZFQZjrtUQIUR7wSEifHeCPy
 1lu0hkCJs/JBNbH/M4WLsa8c7WO46/98HkVIagrOtn7VYCIgTyztrmRNoWy/0LeOMUH2
 QVevzB8dXCjWqHOZ7mzbqpkwJUrY+dZMZayut5sRmzfScpt900g9uA39oeZw/KIVsZkD
 IRi2dehpqbgj8+MmoZEy5I87b35EijL7On2BvvADsz+7zm5f3hcU1c9nf4g5+IvuLhqc
 e8Ai0rwE8A4tSIRsNwS7Jn1XFTXxSP7rhv7fbO4e2QpbY4/8RVwrkRyeQMlHo5eNAiQ4
 JRHQ==
X-Gm-Message-State: AOJu0Yzy7qhSrkB3C4+VhrJjccOnIr6htGrC87CU/PR25Z4kZQaL6xLs
 50tUTQWtdhr7aXcjsSZXNGCcLpQOREi5zEI9GMnvxm1jRpuI1sfeQqtsS+uFkcBQ6MBbvx8PMxv
 G
X-Google-Smtp-Source: AGHT+IEK82fIquQPB4PdrHH1GwDnGYrjws3X/PLHcGNNfwwo2+xWZfz4wYMEPMoKoXP6d9of2QUYUg==
X-Received: by 2002:a05:6a00:2291:b0:6e5:7480:e5b9 with SMTP id
 f17-20020a056a00229100b006e57480e5b9mr4116557pfe.9.1710071612270; 
 Sun, 10 Mar 2024 04:53:32 -0700 (PDT)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 g22-20020aa78196000000b006e647059cccsm2449253pfi.33.2024.03.10.04.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Mar 2024 04:53:31 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v10 03/10] target/riscv/vector_helper.c: do vstart=0 after
 updating tail
Date: Sun, 10 Mar 2024 08:53:07 -0300
Message-ID: <20240310115315.187283-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240310115315.187283-1-dbarboza@ventanamicro.com>
References: <20240310115315.187283-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52d.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


