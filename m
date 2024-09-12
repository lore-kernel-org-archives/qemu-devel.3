Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB79EEB569
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 08:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sofVQ-0001TY-RG; Thu, 12 Sep 2024 04:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sofVN-0001JA-HV
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:48:45 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sofVJ-0000JH-VF
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:48:44 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-374c1120a32so545731f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 01:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726130918; x=1726735718;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8GfbXR146ahHzfDRfP7yHw+LAlO/KwI1uO89UGrVWk8=;
 b=m8TgDE8zJRUZuZd/Du1W+gKJ1L3fhyRDDIUPeMlH59U8SDuPcucxSAbwEpgR3vJL+C
 QuxggJLXYxgmw13TkZIMuIrsbsgcSfiu+sg8FRxeOjF5quvEtO1lSdTszKesGWyLJZP0
 5qisrGIR4Pama+z/s5UfFTErmDp91jqVwrFfzOMNYdkYMTEY8xujpIlTh75fpVw0/iL7
 Wvr2bbM0VP8tbjCtrkGf2uD0lPhLwMvk6lNKyGDyg7E8ycWJr4tbagavIp2VbtZtZMBz
 fgVKcmkkl+TJDJe7wEJahORukT4UV6RdRr2tMnxCg6q+8rIcvGvPUYTBw3G45o1m+3ie
 HDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726130918; x=1726735718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8GfbXR146ahHzfDRfP7yHw+LAlO/KwI1uO89UGrVWk8=;
 b=gxM1/82i6BRGZYPpEWqnzGkESoZk/zuH1MFZXWlspHfEIWpELbY9QaRFRWZ3rfFkT4
 Cml7+Tn7RpIz6sy4zbzxEzZjQHH65CoZJGYvsSqm1H6nxxBI74CY/GC1Sp0LnfuACdGx
 GgCVTNlNywYkrON0PB1DbtY5AYDQOG26XELvK3KaJYNb+aI40oMBc11TBNejMESsj+J0
 TRx0UmwiS6o/Bssai6bAfawHZr4CnEN6ErZx1UDSZX5enIXIbBQ1SMYBFESo1lT2oMyQ
 hP2yn02+UyIYA7vkkChw89s7dns6jGs+qFNsIPcpXKU2mzOsIsQCOvawg4qbx8uJnMA8
 GREA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbInUtVmQD1qluwexoj7ZdcDg4zbhHpJkTXYd2dm9nEQFXswsM/svaAi2EXjNlmHuFLubxwjrR13ro@nongnu.org
X-Gm-Message-State: AOJu0YzWxIn81G25P3qmh5+FnqdKOeiElfbuh/UcrzVshf4J76QjBppr
 fy9iDtEAYT4K+s9zMx9cqMLlN6f+JfSqqHEggjIurMiGaj0cV/pb4VmtuwXFt2M=
X-Google-Smtp-Source: AGHT+IE1GJ67/oyqOTeVwf5avAFQotgbBlyliT9pJf7zz3+QsgxhCfj33NQ6e640IfdrOyisLbOi1w==
X-Received: by 2002:adf:cd8e:0:b0:366:eade:bfbb with SMTP id
 ffacd0b85a97d-378c2d4c76dmr1148455f8f.46.1726130918071; 
 Thu, 12 Sep 2024 01:48:38 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb33a92sm165637475e9.20.2024.09.12.01.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 01:48:37 -0700 (PDT)
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
Subject: [PATCH 01/10] target/riscv: Add `ext_ssdbltrp` in RISCVCPUConfig.
Date: Thu, 12 Sep 2024 10:48:20 +0200
Message-ID: <20240912084832.2906991-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912084832.2906991-1-cleger@rivosinc.com>
References: <20240912084832.2906991-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x433.google.com
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

This variable is used to determine if the Ssdbltrp extension is enabled.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 target/riscv/cpu_cfg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index ae2a945b5f..dd804f95d4 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -77,6 +77,7 @@ struct RISCVCPUConfig {
     bool ext_smstateen;
     bool ext_sstc;
     bool ext_smcntrpmf;
+    bool ext_ssdbltrp;
     bool ext_svadu;
     bool ext_svinval;
     bool ext_svnapot;
-- 
2.45.2


