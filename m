Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADF3C02187
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJs1-000148-Ue; Sat, 18 Jan 2025 20:12:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJs0-00013i-Dk
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:12:56 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJry-00039O-WC
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:12:56 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ee9a780de4so4365575a91.3
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249173; x=1737853973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wwddsRds/Fqnl1W3d1XlTTvUOcsVbxRQegi+2IouezM=;
 b=BqDyMe1OSHCVnPYSPukE8r9i7hPD6NWjtEy3/Q3E3EQsXinc63ttSVTjL8qo35GFP0
 IPEFz0vUFGycI7puAssVh+ANSU+Lr1ytIygiEh7QPatS5bhtxZgEJ8FNRdR4v8wYNrI0
 qVl+iVbiGGRJjdvAboiZ6WChN2mpoZb+BDKHM4exk0r0GETv3RT2WkHRWf/erCQ4Qpss
 lmfvaDQ9dQQlvQ4YER8CqYmm4mQIANzcLI+dmbTfqKfIFzYWPQWn0fC3BKJ61kagGThM
 rrENiA2NpF2ODBpo3pUQETMHi/hrwCUQsYtL0CeOKh7LPsZzl0bPi9zP7NDHRZQxb7V6
 Ec+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249173; x=1737853973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wwddsRds/Fqnl1W3d1XlTTvUOcsVbxRQegi+2IouezM=;
 b=v097Z4RQBzUEamuL9ADgdDlBmpkYr6wZR5qjfSnTrPkS4IUmKJQDG+vcEZ/tvcRGxR
 YQc1pa30kRtGBgpH6AoQo6a6E9EiRXqn6qKw/Zqd3FdsxpVRmR9Ia4Alxb1xhigQIZvK
 1A4NN2YL/nybNPYm+I0RJzXSrh0c9euT1I4HQ32LtI6Js+RBNAtnCjzzZPgnyOcbXh3K
 eNKjHJR92ph8sOGADTe5OMxKfuffF5aRPKS/IIDp/arQJwMoSQ4idcEbHY53g02cvLss
 6uozJO8rMrJzZk0sEkHBg6A1AqYRaYxfXsNPXnJmdD+nYJEC2E6DdhA8vV9MaK5b1tK7
 5SdQ==
X-Gm-Message-State: AOJu0YysxTdYrh43I5dkU5thmfHKtx+buR+8hP6iAGb3cI7jhU7zMiZs
 KAVi2VYY0TLg5z1H3KBS69JC7N/HTU9MQsA32cvxwpgJU3A1Oqhb+p60tV8h
X-Gm-Gg: ASbGncsH8vyvIia0dbDSvK0qn+5AP4mLlfL28TBB3ver2WZNnq4K+amGkOsJ7zYVBrL
 COk1PmbfgRt05XcRsAXxhLnlZ/pcmzRBjl6yseibx8eR7D14dNQu84gRhmh3aVIVWPdaO6JasZx
 tO9pUHjTyKsj0dcZQm1mJ4O3zfjmYc4exIk5tRaUcWsvDQqmFCUXspryOfFDFRM2ySuySudjQgR
 y13zkinBgCb89xA4eREqo6dXiqyg2j9AoqA/Mz8LEIgW9ZEA38eY0YKofHaGiEsS/FT51s+QO/0
 JvfuzrkEzse38MekLOUk+IZrX+zc+yvO+16Xsllx6V5aAwy9Unlnw3mbHwqLsIkEvWHk1afRxg=
 =
X-Google-Smtp-Source: AGHT+IFZkRQt34X8JpQ/omMiDPL0vJrrFyyTmXBpj0RmQxaaRSAFW8KSTM4EBPaNv63roPa+CXObvw==
X-Received: by 2002:a17:90b:2748:b0:2ea:59e3:2d2e with SMTP id
 98e67ed59e1d1-2f782c73b7fmr12336408a91.10.1737249173344; 
 Sat, 18 Jan 2025 17:12:53 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:12:52 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 05/50] target/riscv: add shvstvala
Date: Sun, 19 Jan 2025 11:11:40 +1000
Message-ID: <20250119011225.11452-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

shvstvala is defined in RVA22 as:

"vstval must be written in all cases described above for stval."

By "cases describe above" the doc refer to the description of sstvala:

"stval must be written with the faulting virtual address for load,
store, and instruction page-fault, access-fault, and misaligned
exceptions, and for breakpoint exceptions other than those caused by
execution of the EBREAK or C.EBREAK instructions. For
virtual-instruction and illegal-instruction exceptions, stval must be
written with the faulting instruction."

We already have sstvala, and our vstval follows the same rules as stval,
so we can claim to support shvstvala too.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241218114026.1652352-5-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                |   1 +
 tests/data/acpi/riscv64/virt/RHCT | Bin 346 -> 356 bytes
 2 files changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 07bcf96e86..4f76efc298 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -184,6 +184,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index 460808d017..15b82b5bb1 100644
Binary files a/tests/data/acpi/riscv64/virt/RHCT and b/tests/data/acpi/riscv64/virt/RHCT differ
-- 
2.48.1


