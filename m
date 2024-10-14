Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47888D16243
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 11:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0J9x-0006Z9-Mi; Mon, 14 Oct 2024 07:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t0J9s-0006Vt-D9
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:22:41 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t0J9q-0002cg-KJ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:22:40 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37d533b5412so1864712f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 04:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728904957; x=1729509757;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hfu45ZedV2oYYdcJlwtmsTcYcSwVZM5Rhrrvekmn4k8=;
 b=UH6JDFFrND2LAVhA0VJ9uuwc/mpP4GrxkZ3eK/YZGrFuYJGare87/cNrdwYi2PnmEZ
 8nlYbiqFwCopv8yic0/soHN088bAJ1K1whbsw6iJGpBCaO9cf7ZkofLOeAWObx0daGwf
 HxlL+PivNgzVpcUBlzGeYyV0IqJfBXIq1jzak+XXlfGGhCXCp4u4Z4LINywvHK6E37Z9
 x0rDmD2NKXyKnz4VXqs3t0oraLoEUzFIZ4M/rig1IPPKXeNDQ4GxiEm6vOS6rXoEOR/3
 CzAcFERR7zVGX4vFQ7O/SfcJiZ+Okqcl2UzPYZb/H+XE01R23mk/IrRWI10xT5ThPd3u
 Gkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728904957; x=1729509757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hfu45ZedV2oYYdcJlwtmsTcYcSwVZM5Rhrrvekmn4k8=;
 b=jMCWyerQZnGI0EkNwJKjSTtdeN6gyCgSrLIbVTbfV5ToTSpC/XUQjAjQLKbsirhJAI
 Mc23FVXUyFGNlRwcLYw7OvQ8z/QxcIxKemVeusk4XWaZ2rBdc+drhGrCnFXhi4RYR+cF
 63PypjVfvfja+MYHXtv+/V8n677MKruVY0HEv4xEGSvO0bz71pLZO/PFn0MI1/zv0cbv
 YfcAPGiwGzC5qH58MhrhQJDhqETy4Dbz7fTrjJgow3ZL0Tr2AawZiH5HY1HKS8Npuf/T
 p16pKDhOYadH0hqirhNm7I7M2p6Dw8KfQhNmftgFieAoi1FkkmJOFe3JJuCcqRVZnAbS
 DypQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxDuvhyMk2UKAedKQtwPAcXI4jT3BV81ozl26yVVqZKfrMVJO3Bzt8d4k1jLctuuBLhoi9Wx2WzTR6@nongnu.org
X-Gm-Message-State: AOJu0YzEANVt8LNebWPRCz7b9eXGhZMZzhYBrd7HVFdn+TU6Y0WYAeIj
 SqVC/1WWwR3VTvDMDsQLxgmvPh8R/yFkbok2CrPfXzgfBbs+0mjaW7Lpl6W+WTE=
X-Google-Smtp-Source: AGHT+IGEz87dAj2XpG48PJ4i3nQmZtvyODMgISsVz2OeZad48TXvTMv1MX19c7lw0kyBmqky4QXirA==
X-Received: by 2002:a5d:68c5:0:b0:37d:46a8:ad4e with SMTP id
 ffacd0b85a97d-37d551b9740mr7558620f8f.15.1728904956802; 
 Mon, 14 Oct 2024 04:22:36 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d4b6bd382sm11117303f8f.43.2024.10.14.04.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 04:22:36 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 4/8] target/riscv: Add Ssdbltrp ISA extension enable switch
Date: Mon, 14 Oct 2024 13:22:14 +0200
Message-ID: <20241014112225.90297-5-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241014112225.90297-1-cleger@rivosinc.com>
References: <20241014112225.90297-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x432.google.com
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

Add the switch to enable the Ssdbltrp ISA extension.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 65347ccd5a..4a146bb637 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -190,6 +190,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
     ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
@@ -1492,6 +1493,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
     MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
+    MULTI_EXT_CFG_BOOL("ssdbltrp", ext_ssdbltrp, false),
     MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
     MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
     MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
-- 
2.45.2


