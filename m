Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEACED637A5
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 17:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBH0U-0000Ab-FI; Wed, 13 Nov 2024 12:18:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tBH0S-0000AE-Q2
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 12:18:16 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tBH0R-0003lB-F7
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 12:18:16 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71e5130832aso5715151b3a.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 09:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1731518293; x=1732123093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+7o8RmsaAOBH8IeqzRchnYHz4h5jWSdWaUM/ctLWYAQ=;
 b=AZaydr3vT9KSEXo4/JLLvWxk4A9sJr+TJWzUUpPTJu7/4uYPISNHMaFHXbXiemO0LI
 gDDxEufGTTpv64Qoqp5NXacZqm5JLAatjLmLkOn3dwH+n74g3+O1/wlz6S4cy5cIuxp9
 ROc7YxID9HAF/FvxJE+tXSB+C9C1psp9qVTDzwPHCnbJxVMEUDgNAXxj52JHrqi+sqQ8
 E92hLAq8Kzem2MG3tC96arC9HUALOtxExQHOftVoCNsSqBwPo26UIGG0uNykivJFBUb9
 j5KmeWzPQFa6BTLS+JlwH1MU4wvROWBBd90daY+TLlPRXCQ/BCQiVsj2xXxPPKJyDx5R
 6C2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731518293; x=1732123093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+7o8RmsaAOBH8IeqzRchnYHz4h5jWSdWaUM/ctLWYAQ=;
 b=Z43c/ji/Ao7q8kE5UAkx8/QFuuF76ZAAUE1PlwVOWf5sHGnUiE1N1fC5caUwfsyin1
 9oqK8xvRf1HBncm85gy0seQWyiQ20/7oykKmrgXEycFUvdYr5FPqcwt3rgsGJapsSRjZ
 uAvvxNBPdEZMTj1Q9ilap70l97Q6jMhXP0BHmO0gzG8bTMvJqZL2FEo0R6phwwpcsw2j
 KkcpJd1zU07uuC1fnpEAFcOJHoHlzlZF7l1Ij423qTlrbuYzuR5BkfiR/6CCXM7DKOBf
 D7VZxXHAnAOWXKy8KH6KmYJJx3ZOiBlEWewT+F+SgWPeUZQdkz+uacJM2hzCiv3szNy2
 3MkA==
X-Gm-Message-State: AOJu0Yy/VAxuWNe0PTyVyjBmClCV6vf1GMSMoafp8tSilnLNCg5BrRvm
 Mted/HuCd5CynWI7krWSjoJSLvAMN7AckMs4cpWvq8QmbcW6ywh3p5fVhpgUSUV1mrpLxfYWBc3
 2
X-Google-Smtp-Source: AGHT+IGTri8kdjjFaz87jgzKJ2k8TV06p2JBlenDnRzdylUfo7+phEGyUecPlbGR+GOEsyWvdfy9zg==
X-Received: by 2002:a05:6a00:2d9c:b0:71e:4ba:f389 with SMTP id
 d2e1a72fcca58-7241329bd75mr30656823b3a.10.1731518293221; 
 Wed, 13 Nov 2024 09:18:13 -0800 (PST)
Received: from grind.. ([187.101.65.72]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724078a9063sm13392889b3a.75.2024.11.13.09.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 09:18:12 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 3/9] target/riscv: add shcounterenw
Date: Wed, 13 Nov 2024 14:17:49 -0300
Message-ID: <20241113171755.978109-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113171755.978109-1-dbarboza@ventanamicro.com>
References: <20241113171755.978109-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
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

shcounterenw is defined in RVA22 as:

"For any hpmcounter that is not read-only zero, the corresponding bit in
hcounteren must be writable."

This is always true in TCG so let's claim support for it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4ad91722a0..6bfb1b1530 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -183,6 +183,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
+    ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
-- 
2.47.0


