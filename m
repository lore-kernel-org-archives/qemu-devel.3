Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F6AEEB56A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 08:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sofVY-00020I-Lh; Thu, 12 Sep 2024 04:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sofVP-0001SW-Nt
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:48:47 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sofVN-0000K8-Ly
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:48:46 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42cc43454d5so5297905e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 01:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726130924; x=1726735724;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ij9UQ3ueFFesPCuwkY7Z0yakwufuTyK9/Ck/bkvrpOQ=;
 b=1fo1GihGUPb38z94sfDvd8GfQnuxpmR1UUZlPrmG6OYtHtMIdyQ8qxPteBVlLM3i48
 HkA8Y2R9fI2z+4qsda3wnbVBN1/l5b8Xef72iIEKoBlp9z9JlCmxiCItGhTQUqIAd9+1
 mV+tcp8kPOPT7Gv4B7iHcCBtCI/O09VaAYLiS4R7wWt1qF4NEM1dqTOHTFIREoJFy0np
 FmHTkmG9QbFkwNfa3rGuzVT1Sx3UE2FsjOOkSuKR1bsahgp68HQkqJLTK9RAk8vE3zpS
 9mqhNDeRSnxP4Mo+dRS4qB+qXE6SlSwZs5puwp6kMzBD+OXiLbGwcuSZq601cvRdIU0j
 LN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726130924; x=1726735724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ij9UQ3ueFFesPCuwkY7Z0yakwufuTyK9/Ck/bkvrpOQ=;
 b=Ps3yaQhB1qdVWPqSVzKrdItElMg8/4m1D3/QRu5+5jtVNMjvFk3WCystLSN+Y75IyT
 KI1zOwuiYL3BecvUsiiMu8CSR6vIk7J0UUp5H8oB6hQfF4sZ4+lBxC2IzUNjCSjbYO+7
 5ENTBhz0MHk2XIYmBmfuDSfzLlBBOBenIjMlSIUhcs5WaIZ5osF4zhnXWQ+vkpTl4w/a
 94hYd9ozahzkHIgaI8UbGIPpPwSyDBuLJT/3t9JrYPDsLiB9rErx307wjZwpnhP/G/RS
 wIqF7i35Yv5uxS2VwBjqgh4HGwAmqKg3DZytPjVTukYVdm1MOk59FLlGkzqzlE3fUrro
 BkqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAEInSYxvSzro5oozxj/NfMJJU/+fRUFA95bKf7APHjDTpKArY1Lln9Q4C57guY6P7bQ/dnw6x65Ap@nongnu.org
X-Gm-Message-State: AOJu0YxPyO37w7/C1VuVdXU23RuKGA94DN8K/RKgnrl5lwIiRqJkOxFw
 mrvi1sih2Oi7zzCoFAW1eNpT2UKDMDQ5uwDjtQrUNugSMhUl72PFjlXzXC4nZvg=
X-Google-Smtp-Source: AGHT+IGdkbi8fsTe4KKZ+e+XMK6RPQ7XQDobuWyGnRI8uyhu+4PSzz3TOv3heyJrF8LKuaa5+24FUA==
X-Received: by 2002:a05:600c:468a:b0:428:1b0d:8657 with SMTP id
 5b1f17b1804b1-42cdfac9565mr6359765e9.22.1726130924000; 
 Thu, 12 Sep 2024 01:48:44 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb33a92sm165637475e9.20.2024.09.12.01.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 01:48:42 -0700 (PDT)
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
Subject: [PATCH 05/10] target/riscv: Add Ssdbltrp ISA extension enable switch
Date: Thu, 12 Sep 2024 10:48:24 +0200
Message-ID: <20240912084832.2906991-6-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912084832.2906991-1-cleger@rivosinc.com>
References: <20240912084832.2906991-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x331.google.com
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

Add the switch to enable the Ssdbltrp ISA extension.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 206736182a..75433a4359 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -190,6 +190,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_12_0, ext_ssdbltrp),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
     ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
@@ -1518,6 +1519,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
     MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
+    MULTI_EXT_CFG_BOOL("ssdbltrp", ext_ssdbltrp, false),
     MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
     MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
     MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
-- 
2.45.2


