Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA53CF042C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 22:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syJ2E-0000H7-GP; Tue, 08 Oct 2024 18:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1syJ2C-0000Fs-LG
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 18:50:28 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1syJ2B-0003xC-4J
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 18:50:28 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20b1335e4e4so61016225ad.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 15:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728427826; x=1729032626;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=suiGAQRfyMh8K1b9uLibp1VRaeCHB9aUrAtUyQNMeEg=;
 b=PEAHefjbCyIOMfbfb8YPhlhMmUFhlcdajwIqJL0x90ilOuDzh9vhzL4PaUW83EtPdH
 9FLBoRESys+WR8LhJiucWoQxrAWF5+DnQv1galzc6qHtvZw0Urrqq7C9D0EGatOS4vDY
 AAoDcf+4nYnTEIWlUrnGnfN+m3lcf9pSEaOLnWwxFF7anMoWQLtogYA5C1nZV/VC2xHN
 gAjgwxFdL8ZvVDWLqrIee3vQpeTYti21vhQhaEXocHm6qi7PzhhSmMT6PU2dRyz6OL7z
 f+ZmJPGeHbHsTsdv7CvY5xFCESYjQbPy/otbQesNb+pEz+78N4BEBfcF1ir2UmJlVDcE
 iERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728427826; x=1729032626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=suiGAQRfyMh8K1b9uLibp1VRaeCHB9aUrAtUyQNMeEg=;
 b=aw3K55Z1ANxnAUG7YZDsoeCZOWXm/RHimVVeUBIeSrH1G3TJGyN64jNFcMiEskxb1x
 +58vXstTh5FDXR7QTaVY3pCxju2kk9Ynd5z5dWX0QrwQS+WykcHh6B6vgoJzJlnG0kE/
 EByYc6c5Y/tQUXn7xs1qISm2NKv5ONPj3Nz/z79Qvxl1F+Ple0PLyVM6NPaMgrk61c7B
 gtMSNqWg7xmD+70rB3dbjLjRI3+0FLmQuNue51MQDOYB3DZdPjSRVYb/RxE3rUT8fhvY
 EGdjUnJuBQDgmJtlxiz5i7Pv91t7Pa16HLP1pOkXjDU/sF41oybmR3j3c8T7ButUi952
 kI9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi7fQoFSF0GVw9ICeHExUFs9UxTGtHI8PfIr4K1sRJGK/O8nRdy/+S3shr76uxyFdBGUQzm6JdILSE@nongnu.org
X-Gm-Message-State: AOJu0Yw2HEU0Ch2DKNRM/+1kP16C30gr/wAe7dpU5EpXCoW4BKLR4AjL
 00DsnzhJdhffDugmosg7tOii6PiD/6143r7kKH275rYhhDTTEzHKKm7MtQ2MUII=
X-Google-Smtp-Source: AGHT+IE1IZTwJVEGdid5Qwr+4IuRz3Iz4YUg8XMoaA6zrUqeDvyGJ6IWuEDltfBxhMX6iORM3vIecw==
X-Received: by 2002:a17:903:18f:b0:202:4047:e419 with SMTP id
 d9443c01a7336-20c6377bb70mr8421435ad.25.1728427825915; 
 Tue, 08 Oct 2024 15:50:25 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138af962sm60006105ad.26.2024.10.08.15.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 15:50:25 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v16 09/20] target/riscv: Expose zicfilp extension as a cpu
 property
Date: Tue,  8 Oct 2024 15:49:59 -0700
Message-ID: <20241008225010.1861630-10-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241008225010.1861630-1-debug@rivosinc.com>
References: <20241008225010.1861630-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62e.google.com
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

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 05f727222e..135559fc95 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1469,6 +1469,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
     MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
+    MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
-- 
2.45.0


