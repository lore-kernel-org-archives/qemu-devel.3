Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32B2C02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 19:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXm9f-000790-0V; Tue, 14 Jan 2025 14:00:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXm9J-0006Te-RI
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 14:00:30 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXm9D-00035Y-2V
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 14:00:22 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-71e36b27b53so2983367a34.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 11:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736881217; x=1737486017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZO0MHW2C4CbxTJs7lkrSc3hq/cnXciHDtgsOH5i4QM=;
 b=PZZZDsxp4Yq1BeiK9IM2+BJpQcPkzEPLLh01DbCxFOm0jmTzOiKSOJmrumqtlom5a8
 s1aXQ0llSC7xP4lLIGa8C29r1e/uVeIsv3wxtJLyZw2lShCiDZgMidIu4D1kZZLBJmnG
 DQ08SrMQe92OC0bQTqu1YqlUwyYze0AHvml5SLCN+NLsp9/+A9ckVlMP8icVTz91kkUn
 cbud9Lg3KfYeHcRycjaOXb0PdeyxzF0O4jyNiTAsWKKgNqSPXXYCJqhXZJqhAPDdPW54
 Ov3+l5F4NRpKKeyGo/1PLQAJLYPsdLPzmdqrZvd3EDJd7BeFc52SYG95czSOf3X1U8D2
 kxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736881217; x=1737486017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iZO0MHW2C4CbxTJs7lkrSc3hq/cnXciHDtgsOH5i4QM=;
 b=aZBl6XCt3pOfymtdaOUKQOnJvoFpAyBsaGAggtYdU3cRoeC6H9+wjnIKg6SCEwmfRf
 A2Z8v4onI6M4tnUEncd4zIT3nh6Ze6HO2b8Vr1Xf7VU8SMYDG1NRLQIWq9HEeTq9Xi9w
 HxhTFJwQI69/bkiZGzDcKoy9Y3bemIzb3sl2aTNkF2OKFWlQWiyu5yuJtCvyT/fblYg8
 l4NT1cWNkU2uDN/vC3Bnv2Kioo9UlCSShpB7ymAb3BdU8cHcWmsxjQVfNqI2hMEABokU
 Gd/VNL72MKK9IutIfN7C37H2UXhtpErbKNaeVELGC3YadSmAYGTE0ExcIbkkAfHcvieH
 RbXg==
X-Gm-Message-State: AOJu0YwYqAiFI6qbWTpZMSPZE7d+0X4X/gK/yWx5uHZfSDXw7tVcX+5h
 F9q5EHgLzd6LuOfa/FUF2K21Amuf9L1pSchv1s/kfzi1Yc6zOTR6Gy7dKcoZ6OP4sCC1HTJsrw+
 Ck9o=
X-Gm-Gg: ASbGnctTSMvT25889V0yhdXKn8fkZ/xJhpRqpta3+W34reYMoueZxneXvDJuoVuamj8
 09tdKhfF0+y5elYgQTbGhcbz9f+XXLkGzWeFGs7HdKnAYxDMWxnN1tBcDLawxfat8Lp1i02JeBg
 8uVHURCKORMi8rcqqfoEtP2zT+xh3viIm6W4JuI7d2H4FvAWBOm0FLuf7dQy3QQ5yxT5uvDULrS
 kwvJCBVHpkz6gZ1En1Rt05QNhzyql7wFCl6NtQaivD7PDkctFWCbU6rucz1lwsD/hTnwBs4Bkt9
 GyfNCYQTyg==
X-Google-Smtp-Source: AGHT+IFz5wUxtqY35Cq38ArxHHJTZr6YEffZGKJ33hfqh9/dxDeXGUuGvPfZwZT2mC9jTsQ96Ny5OQ==
X-Received: by 2002:a05:6830:3509:b0:71d:6221:d4b7 with SMTP id
 46e09a7af769-721e2ef58a3mr18402737a34.28.1736881217515; 
 Tue, 14 Jan 2025 11:00:17 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([189.110.107.205])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7231855ee1esm4875647a34.32.2025.01.14.11.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 11:00:17 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 1/4] target/riscv: add ssu64xl
Date: Tue, 14 Jan 2025 15:59:58 -0300
Message-ID: <20250114190001.1650942-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114190001.1650942-1-dbarboza@ventanamicro.com>
References: <20250114190001.1650942-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

ssu64xl is defined in RVA22 as:

"sstatus.UXL must be capable of holding the value 2 (i.e., UXLEN=64 must
be supported)."

This is always true in TCG and it's mandatory for RVA23, so claim
support for it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c                |   1 +
 tests/data/acpi/riscv64/virt/RHCT | Bin 390 -> 398 bytes
 2 files changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3d4bd157d2..b187ef2e4b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -213,6 +213,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
     ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(ssu64xl, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(supm, PRIV_VERSION_1_13_0, ext_supm),
     ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index 695022d56c4ac16607d4c622955ad339fbbfe997..b14ec15e553200760a63aad65586913d31ea2edc 100644
GIT binary patch
delta 48
zcmZo;?qlW(@^B96V`N}pOqj@Jz^cQ@$e^;(o|BQSxYW#~B4@H2qXkC_BLhPoBLf2f
D`wIz-

delta 41
wcmeBUZe!*O@^B7mV`N}poG_8gfK`Q&kwIpoJtyPj07f&87)Az$G)4vn0JA^`U;qFB

-- 
2.47.1


