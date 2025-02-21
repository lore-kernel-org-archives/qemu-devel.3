Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE5BC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS8i-00085I-Kf; Fri, 21 Feb 2025 07:28:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tlS79-0006Ie-Lp
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:26:45 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tlS77-0007Zq-SF
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:26:43 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-220d601886fso30230895ad.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740140800; x=1740745600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/5vHs7s8IDk62c++QK817lUpigrwYrALES9gEU4BPmI=;
 b=W4nVNOIkHyagGY4vO3jFEv7HgwA8bP3epfEEW3M2A2pTGa+q3jOIkerAQcL8MJLZwz
 4cTGoQfTXgzHCCaF5ChrDWHwsy37xxQUg7s02Ub7B44bZ5gK9oW1iZQwONnZCr9zmyQT
 mIC/Sh3OkFgfqUqUTapzPDTzT8laJD0vhwK1CmKKFb+oT/Ha//nj2PnWxqvmuAvbfYoa
 VG1ZNS9pUzXhf7jReD792n3j2ymC65yBy7U8f5eBvZBtiVVoEDOyXceYoa5/KB3WeUSA
 IvLw0+FY8X+FbQwfUaEPhY4M0iKa3K7Gjpxf9ved5TvfVR8g28QnmBmyJbKqZMtmG0RT
 HQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140800; x=1740745600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/5vHs7s8IDk62c++QK817lUpigrwYrALES9gEU4BPmI=;
 b=XDQ5KxyjW3pjiqI7uKio2V3MY+sNbCizgB9zRc3y/pdmB+QDS4HF19fss/7gsNTyhQ
 SjlanZAIs1KKjXsvTlFhU/4lv7JpNdZkxkQfe73GaFGSyZVaoMBrtMRihzIBdf9vsLO9
 dfU7yaw2qvTwNLwKSJ58g/dqZgHpXVafMlxHSPwC8Hsu/dEwz9zRS5LERAZs6VZGmaF8
 Dn3Z2peMlU5PzxFCBnVmDcGx/Mlkb29S9sBdNHKdIucntIVsQoqVREQSktNp6bIgmVHb
 9BlRRvLuBee6VWbTYezBQTNdfIbbZqCTQkiJ8K0kpP7pYs4K23JCTHwUZhGlUXqizcnC
 ihow==
X-Gm-Message-State: AOJu0YySzs8WirRK7oStw/IPDDQFpgGK5eqy2j6cmncf/cr6ZD4VMrpy
 CVlqZKl1fOD6q8u4hyNPzhtgsNnhJuNCxjKTbVdFYZPNavQy8vNlGh89cdT5W2BojhTO7yItwEm
 f
X-Gm-Gg: ASbGncujmfC3rQeNtkXU19Mwo1w7Umd6tCS7Wo9kWG7qgUf6FEKWmOw7Zl/XP7Ft2gx
 Kr89C55wSYZAM/6PlP4dTgH2e1R5E+Htj97RADz2jU5Yjzfs+es+WjTvVq65TjZrhxecNKj7Hh0
 Lg8JW0YaIi7gb7sLbbwwAEAhlp42UmFlcMM3GCr02oYRha4Puxm3/iyDvoYoMqDlyayhRXZISQZ
 zX2M11RdznRFmAMUSDIJJQxSinsZu75kIgcqOYDTpl9fkyitUhdEb3p4k9dfCvPYzg09i4gs+1x
 E1wY9uCTLrwLp8OPx3fOGdF8wPtIY5tgL9gkiAtFJWV//mYpeD+JuA==
X-Google-Smtp-Source: AGHT+IGxdhq7J04pllruTn2puOm3WoDedsVx72P6r2m/M4y8uZL7gZH9hOUBc0fjulX1ysaHo2OXmA==
X-Received: by 2002:a17:902:db05:b0:21f:768:cced with SMTP id
 d9443c01a7336-2219ff30cfemr34573715ad.8.1740140800154; 
 Fri, 21 Feb 2025 04:26:40 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.11.154.120])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545e39bsm137349855ad.124.2025.02.21.04.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:26:39 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 3/3] target/riscv/kvm: add missing KVM CSRs
Date: Fri, 21 Feb 2025 09:26:23 -0300
Message-ID: <20250221122623.495188-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221122623.495188-1-dbarboza@ventanamicro.com>
References: <20250221122623.495188-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
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

We're missing scounteren and senvcfg CSRs, both already present in the
KVM UAPI.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index f14fcc58bb..017ca82226 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -616,6 +616,8 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
     env->stval = 0;
     env->mip = 0;
     env->satp = 0;
+    env->scounteren = 0;
+    env->senvcfg = 0;
 }
 
 static int kvm_riscv_get_regs_csr(CPUState *cs)
@@ -631,6 +633,8 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
     KVM_RISCV_GET_CSR(cs, env, stval, env->stval);
     KVM_RISCV_GET_CSR(cs, env, sip, env->mip);
     KVM_RISCV_GET_CSR(cs, env, satp, env->satp);
+    KVM_RISCV_GET_CSR(cs, env, scounteren, env->scounteren);
+    KVM_RISCV_GET_CSR(cs, env, senvcfg, env->senvcfg);
 
     return 0;
 }
@@ -648,6 +652,8 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
     KVM_RISCV_SET_CSR(cs, env, stval, env->stval);
     KVM_RISCV_SET_CSR(cs, env, sip, env->mip);
     KVM_RISCV_SET_CSR(cs, env, satp, env->satp);
+    KVM_RISCV_SET_CSR(cs, env, scounteren, env->scounteren);
+    KVM_RISCV_SET_CSR(cs, env, senvcfg, env->senvcfg);
 
     return 0;
 }
-- 
2.48.1


