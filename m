Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86538CF34BC
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 18:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swQes-0007Wz-MR; Thu, 03 Oct 2024 14:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1swQeW-0007Gw-Tc
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:34:19 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1swQeU-0005EN-Qu
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:34:16 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e0be1afa85so1168778a91.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 11:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727980453; x=1728585253;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FLg+s4rzz0OrmKj4UlRhD/WmbjGBPBMHWdNHXxUKfXo=;
 b=h6+LPAAuNvcSmlP5une64fccS7ki+WCv0YLCNvm7ZLMIqLOPs0Vhs7pyaZTV4FaQa3
 YMo0Ggs2lRDQGeCh5FSX1SogUuMlWH2BQfImhfojs9x0VTMFjm4/DwuYvD0Kz8+tTtV7
 shINP/33pDuwQFH32yieXLuF7Y9vYuK9dneSRAv3zA2895ROsMIWsudvu7t5R5GxNFmj
 MZHoUVFXSnA6WyZSzPhcAW8c0H34sYjz2yrNV2YCePja5Zfx/Mw9uZtTCI5ltYj9v8Tr
 Gdkc4xzsTIeIaoSzAW+zxAXRy/g0PYx/1ntNoedi6Bh7/E/QMkpbrIpkf+5ayGbZqsev
 hs9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727980453; x=1728585253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FLg+s4rzz0OrmKj4UlRhD/WmbjGBPBMHWdNHXxUKfXo=;
 b=OPIU8eSL8TEIlto86INC4Fwe4sPsSw9Y4gVZK0mYbbLYnluPqeRXd0b6USze3oKn2X
 nkaXsLrWUp5TYUwV17s4Ux3l8eb0TP0cQ2l5MctYN78a8U1S7+ixsZmwEFXwLRuUfBRW
 OP/cHw6p+aGexxYjhWHZMc0w1tn0cHeskkV0Xuc2v2ne8a2ATlJrsVMEcECieLnrZVB9
 H/PV8Mb6qSzmeVKDzAKCrn4UDwmi8/kXmVP9Zt3xB1/qYikMbr326OHpfld9VQBJ1Ylx
 DOSqvFsbyXOy0GbhWco4COeJDtLvYuymjIaUyrWZOEsYLJ9A7vYMCroihSFw1Qf3sxZv
 xZpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSKS+f/4I4R+Jqtaxqo7u/tsJ4L0Sbu1w2nc3ZdWRvOtAa2ABJw/ur1CZc+WWCTVrui7KXLIRqtKxR@nongnu.org
X-Gm-Message-State: AOJu0YyrJs9RcxQWkN4IdXJuJHdaSbv+IqeSWS0D0sJnaCN/KyODJDQo
 BmBoWINtimg9QKDQGGk9VdHaDEuDnAKkcylPACideDobXqUygq2JjfZqFY1Kckc=
X-Google-Smtp-Source: AGHT+IGghkKfjhtfw/7Ya0wwQsYcJUQXH/502s+XSigzNqPRmRPZNhuXRh5HVvt6mT+XGiAdh7jMoQ==
X-Received: by 2002:a17:90b:4b85:b0:2e0:7012:335a with SMTP id
 98e67ed59e1d1-2e1e620e121mr49150a91.6.1727980452948; 
 Thu, 03 Oct 2024 11:34:12 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20beefad16asm11796245ad.193.2024.10.03.11.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 11:34:12 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v15 21/21] target/riscv: Expose zicfiss extension as a cpu
 property
Date: Thu,  3 Oct 2024 11:33:42 -0700
Message-ID: <20241003183342.679249-22-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241003183342.679249-1-debug@rivosinc.com>
References: <20241003183342.679249-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=debug@rivosinc.com; helo=mail-pj1-x1033.google.com
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

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ac5ad6fa9d..0751d08d85 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1473,6 +1473,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
     MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
+    MULTI_EXT_CFG_BOOL("zicfiss", ext_zicfiss, false),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
-- 
2.45.0


