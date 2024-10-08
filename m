Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263F4CF042B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 22:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syJ2Y-0000Sw-BX; Tue, 08 Oct 2024 18:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1syJ2T-0000MB-HT
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 18:50:45 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1syJ2Q-00040B-3W
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 18:50:44 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20b84bfbdfcso2120985ad.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 15:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728427836; x=1729032636;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M7nGUkC8AoqQkvdlZ/4VsRGMOV3aEFYCGC3UA04clbY=;
 b=NbO4eZjhzgmi0mUt9sddymA2V7KA2qXZlkjI13IP89/aFSzi/3VPBQwwd5Q+bEizlR
 OF7Qv3NJXmK2ZNYNHYlzFyuzcpJ1oPhfJf8oD0L3ggQIgHKiQkNviYpRmd8erfX1RZpV
 4tqT4PMqYw6rf7MP6fsyqzwrH27dxTOXyW9G0Ky7YmR2HVMHTJ09fyeXC2GjpH3Wudoo
 dJK4DA+Arwe3/Ac3hVDm6Saqq5ldRqSeqATxw/+o+abHZ4hngDk71l9Zrh4frFdgK4MA
 fcNZfx0q33wzljG5cZXnaUyl2Yp8ytan6fLYj2GAMR9APwAPL7022seWj6vb/qUBTPvL
 ZuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728427836; x=1729032636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M7nGUkC8AoqQkvdlZ/4VsRGMOV3aEFYCGC3UA04clbY=;
 b=idygMRbF3Ah6jCn8EmK2MjtOOQ/kBBkYua06yruJsgE/w1pilvbv9ZcnKA5z/OWM/g
 iBUmcGTNZA/PvyYNyKL+wxexsEZAzmVV35TO6wcO59o6ie3sy53ICgrldoUxZNrOk4Qp
 8Wh/KKr11LTxvDw/TGft8epOP7Z1pxkNO3IXAU30ne0YnGyk+e2qxOardd4MNbhjMwwt
 DXrXmBFtTbETj5bLNlKiXGhiSw8+dlnDrfOva6gLI94f90EGsjzpyLZzPDpzIAckW+Q+
 gzzOIcvFdWCOrYM3pj6HNXpmnPTDYcEfyal3vkhGHtgzXtGmeyNOvm91MST+4bsgQxZF
 695w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwtivGDluBFjWqbiJGPfF0B9pgwNa67t4vYUP0x4HMlUUUMRrgLgTa7zqv2YGZJBGmu3QRLMczffSN@nongnu.org
X-Gm-Message-State: AOJu0YwGJMVcKtwa74vK6LY/eaopya0PLNtQykp1ug7dfLMyLrv2YBNR
 rzE15T3DO30zNSev58cU/Xkvx/Ey0/8cA+TPALEmBHEPUk+Y+QZOY0Tl6gMFWPk=
X-Google-Smtp-Source: AGHT+IEbHNvHvKpZl8k8JCPjR7TqFTIoz53G5nX3plO9YJWEmczDSCNUWfxf68aDE2qqNCqpQV+EzQ==
X-Received: by 2002:a17:902:dace:b0:20b:a409:329 with SMTP id
 d9443c01a7336-20c4e26aa8bmr68444045ad.5.1728427836153; 
 Tue, 08 Oct 2024 15:50:36 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138af962sm60006105ad.26.2024.10.08.15.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 15:50:35 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v16 17/20] target/riscv: compressed encodings for sspush and
 sspopchk
Date: Tue,  8 Oct 2024 15:50:07 -0700
Message-ID: <20241008225010.1861630-18-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241008225010.1861630-1-debug@rivosinc.com>
References: <20241008225010.1861630-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

sspush/sspopchk have compressed encodings carved out of zcmops.
compressed sspush is designated as c.mop.1 while compressed sspopchk
is designated as c.mop.5.

Note that c.sspush x1 exists while c.sspush x5 doesn't. Similarly
c.sspopchk x5 exists while c.sspopchk x1 doesn't.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn16.decode | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
index 3953bcf82d..bf893d1c2e 100644
--- a/target/riscv/insn16.decode
+++ b/target/riscv/insn16.decode
@@ -140,6 +140,10 @@ sw                110  ... ... .. ... 00 @cs_w
 addi              000 .  .....  ..... 01 @ci
 addi              010 .  .....  ..... 01 @c_li
 {
+  # c.sspush x1 carving out of zcmops
+  sspush          011 0  00001  00000 01 &r2_s rs2=1 rs1=0
+  # c.sspopchk x5 carving out of zcmops
+  sspopchk        011 0  00101  00000 01 &r2 rs1=5 rd=0
   c_mop_n         011 0 0 n:3 1 00000 01
   illegal         011 0  -----  00000 01 # c.addi16sp and c.lui, RES nzimm=0
   addi            011 .  00010  ..... 01 @c_addi16sp
-- 
2.45.0


