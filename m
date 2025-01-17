Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651D4C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 05:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfLB-0004ef-6V; Fri, 17 Jan 2025 00:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfL9-0004dh-F7
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:19 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfL7-0005ts-U3
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:19 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2166651f752so39880945ad.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093376; x=1737698176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gF93jEnbQURpG8lMWRD7YR9EDFuOs9U0IQbQ7/L5COE=;
 b=gnewG2Rwdl/ZobCYOCCvCIH9PKV445dpPyjYPy2At3nznuQ375j1tls5dhdgLGhnuR
 pgfPQqJZiuno7RismsYpqSWQFPl40uopmKc6EEpbk5aOOyKUsUeUf66XovLsY9D9vq96
 b0ZIfQR7t2/sWnpplKtG8XAPBmjPV101vjIWX5dskRFlxIY4vM4aZwC754JsRnxHIb7i
 eR/vJcjIUwoOoRXmjDagsyTZCNBMmXI0aMakosSZoYGpqUkV2L5Ybp0YBSFZAfBjNLfA
 8uxF6hKygBObWWztfjUFbBHadwVuN4z0U4Am66/tsEaq5RDFmM5vs5CPsteLtlTvOItq
 rtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093376; x=1737698176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gF93jEnbQURpG8lMWRD7YR9EDFuOs9U0IQbQ7/L5COE=;
 b=nk9IZlc3UAzGXaF7gBELOKuispcUnojjxablrHYF0dyH6xGDub65zq8MRyy8mfwB3/
 2u9yQNi5ltODyEb4lgAcnigT4aP16GWF9zPIWTheOlc3lyID7U0ounfSV0S0mCOjvBmE
 rrG9DS6n5IYznEYGt4TC4zN6PzjhxOyhO0YR6MJ9VXfDFpjyXPulMt4k02TQy2GoJ8ok
 gyr/+8rmYyGLcQViOW8063GttLa4RK2u1hVwRUV7VUVgV/BecgBKiAqgTs233hj6FTnZ
 YyR0GlcnDDbZXRfJa8ECkrtJlv6MWeewF7W7T4v2V7YcwEkw6Eg5wbli1u4n1ml7WMWZ
 9hww==
X-Gm-Message-State: AOJu0YyQXum0f71P/UZBvB9cTYB/OCcM6lAGErEtvRCcl0Y+sHVbtETS
 QXcbeD2VRmr72uKj3Z71/G4HJsWuQlsCAlUOcmtidqJzQTonHmbOJOf9ug==
X-Gm-Gg: ASbGnctjV+l1u5ywXxjCTwfbhdTNHq9JuCvoyaLwWMNSIdZsYAQbCRTBRD6Bk1VE8q7
 DcpuxERjP9jj6g940S2DVeXVBhI02FqVMfg6N8Kjr2A1OLRASzvsdy7+QNj5KcU1Q2gSTJUcW1/
 tr47G09u3EE6hfI9PoyrJEWGbNfUufvhZubwdor6GZ1UPhh4K9GKQ0W70y2QKKE1MjbLblrc6O1
 l6CW0iS63vd1N4gjyD5qfhj0LxxZkuQAKuuSr8wLnPFt5e85M8bXLqllQQ+/Tm2acZiltbe5P0y
 A9HPkXJMy7qzfNnQJ0ElFLO1RuaAM5A7B1rbp18PXPc3NcTzxTUDEvDwiy/J
X-Google-Smtp-Source: AGHT+IGypwjVGJe+n19FgiLWfdHpgeysQCmfOd1HC85lQA2pRnCkvJW5Ie8fZYGh8Qh9/pVGbZgb9g==
X-Received: by 2002:a17:902:c94f:b0:216:25a2:2ebe with SMTP id
 d9443c01a7336-21c35542151mr20772815ad.19.1737093376430; 
 Thu, 16 Jan 2025 21:56:16 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:56:15 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 04/50] target/riscv: add shcounterenw
Date: Fri, 17 Jan 2025 15:55:06 +1000
Message-ID: <20250117055552.108376-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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

shcounterenw is defined in RVA22 as:

"For any hpmcounter that is not read-only zero, the corresponding bit in
hcounteren must be writable."

This is always true in TCG so let's claim support for it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241218114026.1652352-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                |   1 +
 tests/data/acpi/riscv64/virt/RHCT | Bin 332 -> 346 bytes
 2 files changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b8d5120106..07bcf96e86 100644
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
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index 4f231735ab..460808d017 100644
Binary files a/tests/data/acpi/riscv64/virt/RHCT and b/tests/data/acpi/riscv64/virt/RHCT differ
-- 
2.47.1


