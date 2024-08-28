Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6AFC636EE
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 17:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjMm5-0007AC-Ue; Wed, 28 Aug 2024 13:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjMm4-00073v-7I
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 13:48:04 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjMm1-0004S9-HY
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 13:48:03 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7142a30e3bdso704248b3a.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 10:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724867277; x=1725472077;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tVrxnpz839aLLYnBnHuqeTltn+xpAuxyl7GsFPJsO10=;
 b=y2iP1mrOKI9372Rwosvwga48JhrYzwdXrO7ghBYv7GCK3gDC0L8uOW1T1oTNQhPmbM
 CHL/pAJUeBuRGrdfhBwVj+L3Rief6VkwAE6osppk0BiZJtvyAnWc95hvOeGRx9kSXeCi
 rGWQ4LH/3dIQRG9KoNOXSKMtWXXVahKvQUFTNKkwEzSdqCg0NIAxD4NB/NekYGWVROb4
 ZSWLMt/mkhaoTUn1GUV5R7h/s7kat0WnrltxefQLKZpZF3SzKIpvX//iJNLzodwzVztt
 gPrhCzbmlnWH3hC6PgaWJEaFtSpMT2+bFFKubsnxHjl/aSmel6PLKe3/haqzUsrYtE0c
 8Fqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724867277; x=1725472077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tVrxnpz839aLLYnBnHuqeTltn+xpAuxyl7GsFPJsO10=;
 b=Td3E8gFK33noOODlHN1cJ4UxfGTWMX/JL+7StVx9ZbjTynYJWDs8bD/cbJIuJ+6UaR
 oL2asUSF0P9c3tKZlfjGi8A5IGNpZ6zseO8sWXnfW6IA1RsKAn99ZjfHQ6gRUqqvDNYC
 6OsHUTW/UBpp6tce5UVjWPJdCPKOSD/NQGD5zkwTL6oes5BLjqQJIwV7jmbdIltW/AhT
 +ESZXn6U6+UoeJQSEI4R6/Ky57s8C82/WHz9Mazm9W9aq09rGHZPORA4CDGflfMLLbs/
 EaoZugooHGi6fsd0LaHhlzrujJERL5r/NjV4Jz02Ifkt6F0TeDhQFrhFeLLGhIbybSAm
 PRog==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYh0HApRPaEHUPqBZJ8GjC93xBCRH/99oGWEiAzM0s4NtZqPpA73+GYPnVkz07/HS+jPjaTnc6mA06@nongnu.org
X-Gm-Message-State: AOJu0Yy9oQXybMx6L2+G85O7pRh855d7G2kMkXB8WcxyJo8kRG7fPBcG
 tWsNQ31AX7dfQ94SGYRf7dDUdZ3MMuGphX6yUfujnbrb9Isggwuo1bM2gNcouys=
X-Google-Smtp-Source: AGHT+IGeoz29OJHiGtO8jOlztXNzZ41HHF1vUxFIlEh79PeguPLcyLrJJ6gr4+4gMqrCvp7MdySSuA==
X-Received: by 2002:a05:6a00:188f:b0:70b:5368:a212 with SMTP id
 d2e1a72fcca58-715df6e7884mr344506b3a.15.1724867277338; 
 Wed, 28 Aug 2024 10:47:57 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7cd9acdcf7dsm9778316a12.50.2024.08.28.10.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 10:47:57 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v11 09/20] target/riscv: Expose zicfilp extension as a cpu
 property
Date: Wed, 28 Aug 2024 10:47:27 -0700
Message-ID: <20240828174739.714313-10-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240828174739.714313-1-debug@rivosinc.com>
References: <20240828174739.714313-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 55754cb374..c9aeffee4e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1481,6 +1481,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Defaults for standard extensions */
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
+    MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
-- 
2.44.0


