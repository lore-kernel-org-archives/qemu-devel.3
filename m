Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72786C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 14:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY4Dn-00043V-4z; Wed, 15 Jan 2025 09:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tY4Dl-00042k-IS
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 09:18:13 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tY4Dj-000495-Uu
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 09:18:13 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ef748105deso8508010a91.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 06:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1736950690; x=1737555490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6pY9vdP9KrQzzUAagFD6e3VgrnW7ct4SyKNr03/IIzc=;
 b=LWmvRmzj7VXk3E/8guIwq32+8RMMFJ9cU948kAC8MvKYO3lUxdag9TCcFr6JeMjFIF
 cmicd5hrwpTtHJuNS1WTM4LvNgKUPBI9FLakVb33GiLI6N9FsPC85/rFQYc6RdIOKQYZ
 +bhFzyNEfhlhQKyKXBFwB++SPNN570l73yhhV8dbz/GyuSH6G5lFJuRI6EVIeLzeG63i
 SQLEcD/RZ6FWJ7je1MC/u/eAJTzAWgSWEoNN73npmRjY1nMY8fA1t7DBGfq5Aj+7smQ9
 VzBbWujJc7NkeTM7wVZaQ7HKLN/Pqpyt+S/WzMZ16RFrfPnZEOd+KASEm8n6eeKgb91l
 sttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736950690; x=1737555490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6pY9vdP9KrQzzUAagFD6e3VgrnW7ct4SyKNr03/IIzc=;
 b=VkeJTgZ/zR1NcvT1phhDy0sGzAqqzUBnAy1LU6wMGZ5napJy4QBLIQZXGswjH5rXgi
 cfDGBj4y9mjcYPoYTuLOCH7ApAfLvIIbyOhc7OVhe7lx2YoILEcvIJ0Dt8dY2e0rwxhg
 8vHlkPlevOng3JP8mpGutsNRu6oRPcGpsVvuTFS8DHDBAAo9TUWaCWmjTiVjBXzMK1zm
 7sxBE+F6LmcvL1MeiHkg7pRTWiuyOejLe8tiTc+nVyc6dsbwMYRAJ1Z8/E4TlWTO1WqL
 HtsrSFIOuPw8hI18tAGM7GuVTwtmcbHfj2JVYWMssR6XlInif3OpP+uvqjLHBFgEotME
 TPZA==
X-Gm-Message-State: AOJu0YyMVVCsGQKcB8bkb31nDUSBrJO/+jbqOMfze8pXLDFOJ1tO1An/
 5THtMGSaF5cWQ93gyCLoJBQ4ZoJQyjh6aGvik39IryzShh8ICscdw/FNexCIdtzOQ8wFyJzqewI
 nEDkJslU2xEhh2/Pa1mlwgByXx+mYyZOFaJsF/YZIuhQAhMjUyH5S55mAe1ozYKjnW8qsSh3Mxr
 vtBSrMVY9PpE/VF64lAj3ruAajPC2kR2TzQun9X4c=
X-Gm-Gg: ASbGncuwfxcAWR7L3cH+UAvkri6uLiIEgR3qscGdtaNSSCxp2142Z7/L+dL0Xwb7Tfq
 GZbWrMfB+YrmnpcYfG0uhY5YBU05Fqj1WSW2hQyehlLwmKNFS8sZKoFnHuVkV3DN6KqCIYKEKim
 d3FQMjPyGkbKoMzt4VzlpwRNSb1mfuLRuYqFM/Vf/Kb4G4m9NZUIHt+ixOIdpDambe465iT8N2o
 QlAHVymsGHGLdcHAnbN8ybkQomaXE1xeanBlZXVlPldl4IjUn84OoRyKwhKuRPVpVmUwbR/bQg1
 aqaRr99b
X-Google-Smtp-Source: AGHT+IEX+JAERkOfAzzpTnnXozhgYHnxBE1H50y8Pg4mBSfLbvEF/5JEUDcrCwUvZp1Lb23ZKgWimw==
X-Received: by 2002:a17:90b:3881:b0:2ee:bc1d:f98b with SMTP id
 98e67ed59e1d1-2f548f424bcmr37681007a91.31.1736950689919; 
 Wed, 15 Jan 2025 06:18:09 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f72c1cba9csm1432858a91.24.2025.01.15.06.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 06:18:09 -0800 (PST)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jason Chien <jason.chien@sifive.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v3 2/2] hw/riscv/riscv-iommu-bits: Remove duplicate definitions
Date: Wed, 15 Jan 2025 22:17:30 +0800
Message-ID: <20250115141730.30858-2-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20250115141730.30858-1-jason.chien@sifive.com>
References: <20250115141730.30858-1-jason.chien@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=jason.chien@sifive.com; helo=mail-pj1-x1029.google.com
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

The header contains duplicate macro definitions.
This commit eliminates the duplicate part.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 hw/riscv/riscv-iommu-bits.h | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
index 485f36b9c9..de599b80d6 100644
--- a/hw/riscv/riscv-iommu-bits.h
+++ b/hw/riscv/riscv-iommu-bits.h
@@ -50,8 +50,14 @@ struct riscv_iommu_pq_record {
 #define RISCV_IOMMU_PREQ_HDR_PRIV       BIT_ULL(33)
 #define RISCV_IOMMU_PREQ_HDR_EXEC       BIT_ULL(34)
 #define RISCV_IOMMU_PREQ_HDR_DID        GENMASK_ULL(63, 40)
+
 /* Payload fields */
+#define RISCV_IOMMU_PREQ_PAYLOAD_R      BIT_ULL(0)
+#define RISCV_IOMMU_PREQ_PAYLOAD_W      BIT_ULL(1)
+#define RISCV_IOMMU_PREQ_PAYLOAD_L      BIT_ULL(2)
 #define RISCV_IOMMU_PREQ_PAYLOAD_M      GENMASK_ULL(2, 0)
+#define RISCV_IOMMU_PREQ_PRG_INDEX      GENMASK_ULL(11, 3)
+#define RISCV_IOMMU_PREQ_UADDR          GENMASK_ULL(63, 12)
 
 /* Common field positions */
 #define RISCV_IOMMU_PPN_FIELD           GENMASK_ULL(53, 10)
@@ -382,22 +388,6 @@ enum riscv_iommu_fq_ttypes {
     RISCV_IOMMU_FW_TTYPE_PCIE_MSG_REQ = 9,
 };
 
-/* Header fields */
-#define RISCV_IOMMU_PREQ_HDR_PID        GENMASK_ULL(31, 12)
-#define RISCV_IOMMU_PREQ_HDR_PV         BIT_ULL(32)
-#define RISCV_IOMMU_PREQ_HDR_PRIV       BIT_ULL(33)
-#define RISCV_IOMMU_PREQ_HDR_EXEC       BIT_ULL(34)
-#define RISCV_IOMMU_PREQ_HDR_DID        GENMASK_ULL(63, 40)
-
-/* Payload fields */
-#define RISCV_IOMMU_PREQ_PAYLOAD_R      BIT_ULL(0)
-#define RISCV_IOMMU_PREQ_PAYLOAD_W      BIT_ULL(1)
-#define RISCV_IOMMU_PREQ_PAYLOAD_L      BIT_ULL(2)
-#define RISCV_IOMMU_PREQ_PAYLOAD_M      GENMASK_ULL(2, 0)
-#define RISCV_IOMMU_PREQ_PRG_INDEX      GENMASK_ULL(11, 3)
-#define RISCV_IOMMU_PREQ_UADDR          GENMASK_ULL(63, 12)
-
-
 /*
  * struct riscv_iommu_msi_pte - MSI Page Table Entry
  */
-- 
2.43.2


