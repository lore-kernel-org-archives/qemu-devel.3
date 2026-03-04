Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7822EF8FE1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmEJ-0006gE-Ta; Wed, 04 Mar 2026 08:25:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmEE-0006fC-Ry
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:25:30 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmEA-00022a-HR
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:25:28 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-8297e0b27e5so47498b3a.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772630725; x=1773235525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KCAb2faB2fyT2II3L9Q2raCeFq1NF7CQPXyacWR21d8=;
 b=Ga6mmPlS1eqXY9Ds1LTOlV6Hoj3g7m5UjF6J+Azcto7FQpLkBoP5zz98XJkwH1ik7Y
 u/OXC3nFKggnYpHoWxVddOigCgqTsenwZr4BL9liF8/sW+gjyphTQ1p/B6HJg7Xbe1TW
 hSmkydFB6SHcPPnz9ScmjcBBGtHTrw/e7Z7N97KkbknpejH6KZuLTWHM8pNgjXZ2P//t
 hfaPdESm3uRhazqRnsih2VPD/94TMIwvxcXTpYmBhxaJ4TonOOzqj0ROgiCpF8nsmVFc
 WI5YkDkOp2DoBeJjBxbW+oVG1Csmmdg3A8wSeIJYgBqTGASjT//sNELYzrAbPn8ojBea
 aKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772630725; x=1773235525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KCAb2faB2fyT2II3L9Q2raCeFq1NF7CQPXyacWR21d8=;
 b=TamudR2GQQbwl/6tbsanARnI3foJ/ITVeRksA9fHUz9EHOXbo/8Nqw223i0uRLNLsR
 iSZNaJn6hsYC+NuQCIpM86HBmyFXxeEPvHnXzLPYiTwfgnHGuxYAIW9zELq0swklZeRm
 LdDRd7u6lNeTMLREL8VnyVxrQWuEJu0kGocFcdrKiLpeq3wkPgz3ErrcoVrj0pJBeZrr
 g7Df6ifycWRYjkaWc7S13Vg04lG4Ey2EfY0mRnxhuD8OxuFmCx+Xh7vwih/z2rnZCx7k
 VdGVi7d40Z8cu+S3qVl3rGzXK5VP1x4SwYIQaWWS9WTI5Xv2dt6D06l1oOFW3tcSVurK
 HDmA==
X-Gm-Message-State: AOJu0Yzvp7smZu3uXE8bdEg4elgVmtNmv16vyqPEJqq19viQzZH1eOec
 4qLUsLvNDiXICamqklU9bPHTymuKN1oI42oxZPuymxBmhjHWNpjoqGyTEMQ/KK0DPv/6twS0Cf3
 PFHTOoBZV3uH/2Tp8gquru9JqYKUFoeSQR0ZeHoRg8+Ur+e+8kqVtwAnOsrrgb9RiJvMyAaE8MV
 3F0Tic9iTxrSVk8ApgwQYJil6q4VG+SAmf5g7GzTlBOQ==
X-Gm-Gg: ATEYQzxlLwWiUI95kk6l75JzRzoXIT1uRJ6S7aWDIcNbtCbzD7bA68B8lEyo/yDRBv3
 WhFqcz57TLkII9HeLqxhvduAaKuT82ziQ+UDykfnkmJV+pGkrNXflmi8IFltXpWGbciB4TlM5zd
 svHWAlUx0ccIBoTi9DgqPg+bFnMCGrmDyQLEJmSFH+f5nlXk3tCLy3+SVLUA4Rk9R6kixPjgrHM
 Y76rc6dpO/C7jEugmDlVQm7HNwkBoCJOhyhCxkGZCpP9khvH9SQxbc2EAlh36YhbVDg4wyF+evF
 ZreF41alo+QG+s7gLUuE118I6aBBWwT9iBqmHoAOrasIsE1R71p9rmpYFdJ9GWfqV2Oy33f1raZ
 Diw1Zo33Pfyjvi98xLXEcqwxV47uIXdkarp5wvKHZ7w5kdPKxXLUruLgvoeQvdFYf1QvjDJ4zBZ
 Ap4eRe672zUtAxNxbPGjlpsCIX7fAuQ4MRd1CEUCxdIzxKNTM3fx7twsuVSJza1dBPkuPAnZZzr
 5oaQ3tPtyztu25BOFWkFVxWgv0=
X-Received: by 2002:a05:6a00:894:b0:824:b181:f492 with SMTP id
 d2e1a72fcca58-82972d0efa8mr1845812b3a.45.1772630724662; 
 Wed, 04 Mar 2026 05:25:24 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739db1d6dsm16968505b3a.26.2026.03.04.05.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:25:24 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v4 2/9] target/riscv: Add the Zvfbfa extension implied rule
Date: Wed,  4 Mar 2026 21:25:06 +0800
Message-ID: <20260304132514.2889449-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304132514.2889449-1-max.chou@sifive.com>
References: <20260304132514.2889449-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

According to the Zvfbfa isa spec:
The Zvfbfa extension requires the Zve32f and Zfbfmin extensions.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2ddc26c837..376517755e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2619,6 +2619,15 @@ static RISCVCPUImpliedExtsRule SSCTR_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvfbfa),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32f), CPU_CFG_OFFSET(ext_zfbfmin),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
     &RVM_IMPLIED, &RVV_IMPLIED, NULL
@@ -2632,8 +2641,8 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZHINX_IMPLIED, &ZHINXMIN_IMPLIED, &ZICNTR_IMPLIED,
     &ZIHPM_IMPLIED, &ZK_IMPLIED, &ZKN_IMPLIED,
     &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
-    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED,
-    &ZVE64X_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
+    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED, &ZVE64X_IMPLIED,
+    &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
     &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
     &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
     &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
-- 
2.52.0


