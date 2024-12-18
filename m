Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EA8E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2bs-00067i-MP; Wed, 18 Dec 2024 17:33:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2aH-00047P-DW
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:32:09 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2aF-0003V2-TM
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:32:01 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-216401de828so1628795ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561118; x=1735165918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DYkEPiVTZPcrOR2pDmsygVgNKgeEe5hJGYqQAVm5GOs=;
 b=ACLP4ZHdvFpN4TE7wixSBx3qatJ4w+evCp7j4FHj43WBy3Cjt8cp1MK3sJK32iACOD
 yTX/TciNdYWpP6z1XVJLPk67gXlpdgRm+/fRKkP7VSOOYUvYztREfcFP5MyPrOFPeale
 E/uRePnX72G2N0h3Y8CvxMld0FF3QiJdN22BLEJEVBF4RU5On8237xZ3YfiiX2NAMYmi
 QgJ6GDtvJ5DRYaBisZMdUcxVOhrHjjBRmz5SfFpOHM3Grq5/fS2OUk8GUe2cLeOObWHe
 5vAD9GD5ZtTBgt4NZDyTUOvNYxko1A3+JnlF0HgCYA/U2fQ26xW9/Duh6rW6veHlkkso
 hPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561118; x=1735165918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DYkEPiVTZPcrOR2pDmsygVgNKgeEe5hJGYqQAVm5GOs=;
 b=c/oUiQwvn3cPFPxnK+slQnCnOlOqRHBtiGu3zZ0z3H41ITDN/jSyJImXWNoABICCGE
 p7VtKawplHVDrhAqScf9FpDemStRzvByqA6BO1MVuSAHLrOPqT82Kwdq7Cf7G7I5WJYG
 MoKZ/PsigUKmhQexbffBT+hFvz3nWEXXQzqH5rBhjekP6bZ0BcJJc8aEyzt0iyydFSP+
 JfvggMUzLHl/8D7FYGo5bkYzDsISvwaYORIcah+QEzJQJOiEGMBpRRL3vpAiyLWUOI9R
 g21/8i41zALWtRdjbFt8D+xv89Yw5exisSJh1lkqSD93fjtVdnkq61aCbKbVehT2mPzK
 B5+A==
X-Gm-Message-State: AOJu0YylsbsNa18g7vaR4eGhKC3eWsEwqqC59Wn5UXfX0ccRWES3bceZ
 d3g9wBkI5DrvmWFD6dp8205CNd3YRTAufF2KLjvwuGD2zEHT0YNJMI+kwvEj
X-Gm-Gg: ASbGnctTdFy0xbHakUlCi3OBrnF6vD9/VM9ZQeE7mlqWxF7OvElZMLYm7VzhLlBnYYW
 gO7QPStY12p3CzoEI1ulWcE7voKfv2EjnBBS2pByuRiNQf7hNnjxj7vLDXwbx3ujZlQ/wsSpFze
 ShDGNXnALVA0ucT7QHa5s5ipTioP/dXD/+0jd5Q+KiiSrkYqqBS3bHsYvLsAU6Kx7Ddth7Faqw+
 aT7oQrzoBKgJCI+ijxv8jdZjhA/hwvpilWHPBmCl+t4RpBtX1XPbDAOuRrHf8QMIuE423X9gxVS
 reJXircK4gPodOUnt7suS1fjfkCTHyxCpmuX01wryQqTOW08GKBRaSJbZ4ryimA=
X-Google-Smtp-Source: AGHT+IHwfCckBLQFFWNNdOUKwcqJUVrqzCQlYdhc/ZEsyXvLf3oRUetUpEr6ymnYhk38hMvz8rBhsQ==
X-Received: by 2002:a17:902:c404:b0:216:5b8b:232c with SMTP id
 d9443c01a7336-219d9901cb5mr19433645ad.54.1734561118434; 
 Wed, 18 Dec 2024 14:31:58 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:31:57 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, "Fea.Wang" <fea.wang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 33/39] target/riscv: Expose svukte ISA extension
Date: Thu, 19 Dec 2024 08:30:03 +1000
Message-ID: <20241218223010.1931245-34-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
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

From: "Fea.Wang" <fea.wang@sifive.com>

Add "svukte" in the ISA string when svukte extension is enabled.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241203034932.25185-6-fea.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 66e00ed260..18f4d94b6e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -199,6 +199,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
+    ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
@@ -1663,6 +1664,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 
 /* These are experimental so mark with 'x-' */
 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
+    MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.47.1


