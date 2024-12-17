Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4211E7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 09:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNTYE-0008SV-Sn; Tue, 17 Dec 2024 04:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tNTY5-0008O4-Ip
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 04:07:26 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tNTY3-0001Zi-GS
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 04:07:25 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385d7f19f20so2514762f8f.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 01:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734426441; x=1735031241;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PgjSgjJZNQH0MIc70/i9yglpUly96nDthfPOg+sK/Yk=;
 b=Rgnr6kAhzXTcl54UA4CyyWWTxpTH/nenIXvrOiV5XZ6WiFWU3fMAkZXwAZKLRmnKnG
 c7Vj49AN4pvvV5AXFPjjV0fdVsyWhhRfg4wMKUa9i/m54nRKo+g4vBc02CtGRy7XwzsL
 FjWlTdIV7jo0XmcSJ/oWO4S4f9Rtqa4IpxvJz70tyja7PV2RDKX/1t3y2WJ+QoiGn8B5
 YYk2dexHXdDE1Dnrm2f/gGlyb5MECbhVp/df7SWpifoy32SuaB0rSc3CK78DQZN1Jodo
 wwOm6RR9r52j6Ow75pmIQM1Ec0hWDuJlyM9fad4l28hGQWN1zmYVtjzs+3190Wx5ECPN
 TITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734426441; x=1735031241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PgjSgjJZNQH0MIc70/i9yglpUly96nDthfPOg+sK/Yk=;
 b=PuLbUogy2JA0guTpF6h5hkvwNLtCtK/89rIF54HZC+yX+ig73eHH3mgD9mYMsHJyjW
 TVG5w1iLH+BIUiKSGo3cUwYyp0lpjhn8MB2+SYdn5ig4NvIeUNfq1BrIvp84FY/6XspC
 t7XwggaWLDo3U/CZsBQgLEhOwvNmnFWYVzI1QInmEzUOECcY/OwOos2zh74j0zRHj0GM
 wvHNBJt1TluUZSsYtPY0bluzqIEjDoUlhvUH/jz+81rI0g580cvP1IMN/vFZx7nqwt5T
 zj6uLugjtp4/Y0xxZpC21K7fNwfgHQC4cDNEaNdbhhhJw78WaiS86VMtW2a5fOC5cEW9
 EhYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxMmXrv1nWezd9n0Jk9zzDiD1JVcnwfUxph4l5fo/m3IHQEjvPeDFsJoCDq92r4nuDmE1mdt6WPV49@nongnu.org
X-Gm-Message-State: AOJu0Yxtvud7hDXePpkj1kKEOno5SdJfkGxidNE9ORceESDU+UfxtkOL
 6IhgF918SplDT8s2ahKR66W4lBeJawMmPU1r9oxzDV4Tfm68E1prOQqB9/cvKO4=
X-Gm-Gg: ASbGncuWkxP+iXiNHsU+ownzG3BiZl1WiIzY154tqaew6pni/RE5DutHpLSfzEbHwWq
 umR/7HbS6mQbhi0+WCV8hNQ6+TqZN9HwYjTbpweowYvcs3vGSbchfRxEBTc77skqef2bVRRko1x
 44v8fuWR02d4+2g6baSg0FhapwfE7rL8YRYdzn8/9VSyUzKFj/WdHuXtv3GoMH3eC2qc3nSYTdZ
 tTzhSsxx4nfPzZqgkRdeduV90PrpdhbKP46h+WcWQDmhxp6kgrkrtyUmA==
X-Google-Smtp-Source: AGHT+IGCU33sDnKzwaIvtxyhKjbuRRCYWEkZplRFSNzQdrDpmTVxicKEKeLUVqC9hhc0JwwUlNtJ8w==
X-Received: by 2002:a05:6000:184e:b0:385:e013:39ec with SMTP id
 ffacd0b85a97d-388da380c3amr1972966f8f.8.1734426441457; 
 Tue, 17 Dec 2024 01:07:21 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8046c46sm10704122f8f.71.2024.12.17.01.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 01:07:20 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v7 9/9] target/riscv: Add Smdbltrp ISA extension enable switch
Date: Tue, 17 Dec 2024 10:07:05 +0100
Message-ID: <20241217090707.3511160-10-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241217090707.3511160-1-cleger@rivosinc.com>
References: <20241217090707.3511160-1-cleger@rivosinc.com>
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

Add the switch to enable the Smdbltrp ISA extension.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1b883db0cc..c4330ded69 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -192,6 +192,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(shvstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
+    ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
@@ -1625,6 +1626,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
 
     MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
+    MULTI_EXT_CFG_BOOL("smdbltrp", ext_smdbltrp, false),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
     MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
-- 
2.45.2


