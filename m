Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA31C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 12:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmXcn-0004tN-97; Mon, 24 Feb 2025 07:31:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmXcZ-0004ag-7t
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 07:31:39 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmXcS-0007dg-R4
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 07:31:38 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22104c4de96so71563695ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 04:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740400290; x=1741005090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cSfscRVCfJGOaupLnjlhY6p/zAXuZzDO5Ha2A5lVBLs=;
 b=Vp719NkFB76AJPN0MjS7plT5LOijhEH4gxmwS74wdjv+jDwlzaPo9aPy5jD1+AD7gL
 J5EugLygUwI+7+FfNz9pkwud21wH6TiEenIwO009q0GybdKBBSBAsqb5KNyYReGMeVnH
 +Cm8Lmcgcb9PGFXQHct50IhueZ6xvLVzhPamW503BhXZ8xn6X/dLrRitfbfmzYcTz1OA
 WFMk9s15z/L62N4I4R5e9OfIRaocMxux+fD6sfhpK4A1ItVnpbGbSxoXkidLOsOftyMN
 V+1tbKtzbu6ytxG2GE/uDfYvBa0Ir0dtsrZjIwGDaJqMVDbZhfbtLzBvud7N+l05RBp9
 oaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740400290; x=1741005090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cSfscRVCfJGOaupLnjlhY6p/zAXuZzDO5Ha2A5lVBLs=;
 b=RowI4RpaR6naV5jaqcwR/1yiqN6ZkZA0naqWHLn4kqX7PTYzqG3t8oKyYDD8pXR9c0
 oLFq97Ce3+N75n+v16Cou7SWizTypuQgNwumI08LTGKbcP9T7HRJPWgd7wCrmY+SQ7ww
 PT4wuiQXg26JW0jSS8EM7Y5WcEvNyFUG4xz+TZSdWA32xFHKCIA4qvm37AZFtUtNro4l
 3KGDsUfdCzg/OgDeyAiLvU/7yCsR7450Oj+3BEqvHqvEokHrSpc1MvZjPHX0UCmzYyWd
 LiEZMX4lH77WMdqCxy8GB9UahxMQK1NZehEvlhQiCyRTYPYjiTgsTU6jFSVXzhXto9fl
 T/oA==
X-Gm-Message-State: AOJu0YwFjc5y7+ByIP3L69SZ8mFfQDGAm/XkVRLR2mxUDq3n0pNF0kJ4
 q9TODPx8hfNJxt0vLsMOTeCqO8jvFLlFJ2JgHMOC/j9ngPvUrLniK/UWtFfVbHPZ8xZjdVF3qbD
 c
X-Gm-Gg: ASbGncsSkoyfsOt1iWd9XHx4QsOt3/FSMCvRwYXLY/OZ6Mozg4l+lavm42B4ChEh+ud
 PLJ9NvOO9SWSXhOR/69Vav8ckqkOmNvqnTWHBOLMnT+5nk5cN8HOxkL6V1KvZK663Y9d+bEaxjJ
 jo56+A91y1YCoX+u5cH36hDdidAQYxNWIIm12ol7uiyVYtSNBY8rz1q7xnEEuJbxqjdztSCy+xk
 k5Jjrd0tSMzpx4Opww2a2cu3pF+RLAtaHSTTAMi/AmQRxD+nyYzOkK7Tw/XPqg7SCV0i6UQYCiW
 K6/w+83hlERETSyIDDZ7KqD2g880Ng==
X-Google-Smtp-Source: AGHT+IElbJQ0HqRhVwrvgEIDn5K06ZY8B3rry8ORAJ2ZqqDWOGUt+E2L2FF9xeEFzOk+TJzRK0Q28Q==
X-Received: by 2002:a05:6a00:3e14:b0:730:7d3f:8c7d with SMTP id
 d2e1a72fcca58-73426d7279bmr20561142b3a.15.1740400290204; 
 Mon, 24 Feb 2025 04:31:30 -0800 (PST)
Received: from grind.. ([177.170.227.219]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73242568af8sm20554470b3a.48.2025.02.24.04.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 04:31:29 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 1/3] target/riscv/cpu: remove unneeded !kvm_enabled() check
Date: Mon, 24 Feb 2025 09:31:18 -0300
Message-ID: <20250224123120.1644186-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224123120.1644186-1-dbarboza@ventanamicro.com>
References: <20250224123120.1644186-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Remove the !kvm_enabled() check in kvm_riscv_reset_vcpu() since the
function is already being gated by kvm_enabled() in
riscv_cpu_reset_hold().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 471fd554b3..19bb87515b 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1606,9 +1606,6 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
     CPURISCVState *env = &cpu->env;
     int i;
 
-    if (!kvm_enabled()) {
-        return;
-    }
     for (i = 0; i < 32; i++) {
         env->gpr[i] = 0;
     }
-- 
2.48.1


