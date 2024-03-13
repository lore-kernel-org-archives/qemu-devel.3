Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8BAC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 19:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkUKH-0006wG-1x; Wed, 13 Mar 2024 15:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkUJp-0006qX-1Z
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 15:31:20 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkUJl-0002Qa-1L
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 15:31:16 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e55b33ad14so163505b3a.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 12:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710358269; x=1710963069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8PUZYN/jxC55WgIbgr/YDIPnxwzEfC4uN3+8U/WL+Ts=;
 b=hZ1mtA7wSG29Fp8L2WEsSXXySTSzMXtIPzy1+7p/vUypRNYi3k4z2mpLs/850WUVbz
 HZGKYvYitNEkGYRlMqrFGpr0NVQyseFgPlty5FSKKU8TzlfaGHy0S/16r+bmKeiW6PRD
 tPJb9hXneUZhPzGyOG9fqF/l0VsNgkSzQza+1bNgQx70ntHB0B/FEP40g2NLOWFhX5hE
 MCVD3WRsTKBUMVvfsaCQO6MoNAOTS1BmofBswOLzWP+lijwdNLL1IkOxYPivppbIct0W
 Bk1dNc9kXdzhIYtl4VETpNQPjh5PsK0R1gxiF2rCE6d3bbPQuhQ9P8I98+ypdmXZgLKN
 KXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710358269; x=1710963069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8PUZYN/jxC55WgIbgr/YDIPnxwzEfC4uN3+8U/WL+Ts=;
 b=oxpp7OLoxfHYLHedhKaeC+uG0Y+prjhFxLf6ZT97s3O4ivA7EcomKErrrV3yIGh6/M
 TqTjzWrxEsDlYHfiP4BNxDzkTdwFSQIqYUIf9ZNtmse7d+pOzYwh+Uno0VMmqUEB42ZN
 6GR7TZsf63cXGPm99YoeYqSIkcJF62wH981VKHWVZSv90kWlqmv4xWjFXhKD0+X5+HqH
 O2IXYAFal1177NMcVMA5rkoVj+Yno8KbGfMel6OlxcFrbM8YR+PSZlhUsKo5Ys+sdCnp
 tq14qHFvVcmOkWkQLrFjjwilPg1vNmii/QEmuLa/T39okoaCUHIb2Q8Us7BjYxT/TUnb
 c3xg==
X-Gm-Message-State: AOJu0YwHY2ZXGwURWjaWikt53d3afsPVLK5fuaADijNzdOKGraP/1aQ+
 LrgrWyMKaCigOZ/gBjGOpBMQlng6pGstk0koUxQbYLrORycieXmDHEqbrpIiyEbajPJayGQc/wj
 u
X-Google-Smtp-Source: AGHT+IF+4Tbe4uSyPjFuMsg+bCY723/3U6mX5hoKEfqrjXZJR2lqvkGuGcc31S/VGGCgQxwOMIBqIg==
X-Received: by 2002:a05:6a00:938b:b0:6e6:97b9:1ec3 with SMTP id
 ka11-20020a056a00938b00b006e697b91ec3mr3668406pfb.13.1710358268988; 
 Wed, 13 Mar 2024 12:31:08 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 k10-20020a628e0a000000b006e5a915a9e7sm8912421pfe.10.2024.03.13.12.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 12:31:08 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v13 1/8] target/riscv/vector_helper.c: set vstart = 0
 in GEN_VEXT_VSLIDEUP_VX()
Date: Wed, 13 Mar 2024 16:30:52 -0300
Message-ID: <20240313193059.405329-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240313193059.405329-1-dbarboza@ventanamicro.com>
References: <20240313193059.405329-1-dbarboza@ventanamicro.com>
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


