Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8A5E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 08:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWAHX-0000Us-SR; Fri, 10 Jan 2025 03:22:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tWAHL-0000Oa-Gx
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 03:22:06 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tWAHI-0008Nw-JW
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 03:22:01 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2163dc5155fso31281655ad.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 00:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736497318; x=1737102118;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WhRFTFyF7033JbYEv2f5UqjBlbc3fA9FaT4irnVKl7c=;
 b=OW1iT5ss5ZX0jGaXalcbR/DSZhbJEOparLtAnqBDOuOM980ZmshFlwa6NlITTaOsRo
 tLTJO8rneidvX+wTDufQ0NJDSdsxBDnBpPlMYEb1sNrsI11fjkcele8vousTD3r0sHTX
 ElCHDRpMDkMw29cSeUX/bycx/CcCMw1ak1466Q+ac1URMzGt7bOluZ5k0Ig7dexKxHOU
 /JOD37N8lw1Vnf7vTati4Zd68HEzQqwuJ8hOXmwYznswQXTo5VTAHXQtEx4v8eItTa3K
 SKXN34/8gKbvmbZBwEc2F4w+A06Ea2jJcyjrphJTKmTsyUf0Br1qw7Jlqs/diqjoMKpb
 QMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736497318; x=1737102118;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WhRFTFyF7033JbYEv2f5UqjBlbc3fA9FaT4irnVKl7c=;
 b=Fynh+1NlUJmBBPe++A1bdyvH/o5qnIBiklaKG0Mg+v8b3MoWgr+HRpk9VaSEKPtXeg
 G+WhhApFbcVHJkpNsZ6+OEuWVgDioeDSMYhABkfJYaj9D73Ml2ckoHtuV7REoeVGJhra
 4ruuGt0IlpcT1GOmTVdrZogqRMrkwZuQ3f7Eu55XXk7k75l94E4aXXks9hOFYNsan6Tz
 WLauWLUjP2avQXREZ4V2pAoqHacvQXKeiFtouoPVOEtF8JtDATwVVr/Kretbu9CXtUYJ
 iZ7MoMXIC6iUl2BcZ3ZVtsvjmdQzEs2gyLSc0sRcPenuutVcAe0AJVmkOJ2KhIcU1buM
 VQQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaGlDC3KoIIvAvnMJ6G/1uk77qA7kM01d6QBRX1ARYUbWLNdVzNLTBFC2hzbC3JfmGBSo+DhnXE8oR@nongnu.org
X-Gm-Message-State: AOJu0Yw7yW01db5gyR6K8V/3bTvKJaJsMFblofzRZ4/gWjWgY7vZrSIn
 5FDpKr3fzvRHqoIyMom4b540N/nd4pW181Y1HGLO8cKvwZv8Y78CbBu+XD6ThYYwPpl1HAiHjuM
 R
X-Gm-Gg: ASbGnct7SUe6786VvBt/ovGbX7eIkWNOkusj9j2cWbmEhRwo0iBM+RiuOOJbTUcHfRZ
 /fyqeOiwH0Mb9Dn0xWIbr0Nf0BVJEq7z0xu146JqpodxrQQKZd9M8UrRVC2AKEVaf+eZP1vzdsg
 7XXibldT1IheptW+Z4GKNhP1GO+nsgQw/GGxuSmqxmxgTDEtDHCgYHQGMpx6X7Om2Xt3zS5XOIW
 p2CAFMTWUh6b+D/NjDsrG0Z1Le/g1YgY7ev9qQQj44ebuyBOgX5O3hzPI01/f6btP1m2Q==
X-Google-Smtp-Source: AGHT+IHxYzNtH30GrSoBIGgHf0u8THkm1EA1hQnYBJEF3p9rDUCDXJ9FIB5ysCZjbIYUN9/kTR0M6A==
X-Received: by 2002:a17:902:f644:b0:216:59ed:1aa3 with SMTP id
 d9443c01a7336-21a83f70f0fmr134765985ad.27.1736497318371; 
 Fri, 10 Jan 2025 00:21:58 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f22ee09sm9278715ad.200.2025.01.10.00.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 00:21:58 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Fri, 10 Jan 2025 00:21:39 -0800
Subject: [PATCH v5 11/11] target/riscv: Add configuration for S[m|s]csrind,
 Smcdeleg/Ssccfg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-counter_delegation-v5-11-e83d797ae294@rivosinc.com>
References: <20250110-counter_delegation-v5-0-e83d797ae294@rivosinc.com>
In-Reply-To: <20250110-counter_delegation-v5-0-e83d797ae294@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add configuration options so that they can be enabled/disabld from
qemu commandline.

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 671fc3d1c1fc..fe470f646dc8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1587,6 +1587,10 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Defaults for standard extensions */
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
     MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
+    MULTI_EXT_CFG_BOOL("smcsrind", ext_smcsrind, false),
+    MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
+    MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
+    MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
     MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
     MULTI_EXT_CFG_BOOL("zicfiss", ext_zicfiss, false),

-- 
2.34.1


