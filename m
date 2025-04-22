Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF65EC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 22:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7MDF-0004UM-5m; Tue, 22 Apr 2025 18:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1u7MD5-0004Sz-H1
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 18:35:28 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1u7MD2-00024a-Mo
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 18:35:23 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2295d78b433so67738505ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 15:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745361317; x=1745966117;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Nm9FPhOGujzcuwc0fqA5mk8oSCUhAkJUmvwSiBQ8E6k=;
 b=wLmuMwsXHs7t/s754vJMbMxv3/4kWqyDR3oPwkQje7voZerbTl9k5gxzadZEcXrssL
 Y2bAoFn9BcM8zcqQVnvAmWzDVCzxhTQVEfiBX2/AiJNqeVk/3Be3/MqfP1ns2a94A/ms
 yNzigb34aAUqyBiMnkMTk8oVnPYQk+pqjbE/eypToKLacSqjHG3oL/Rs/OJbNvdryFFj
 5gsjNMg/DGok7jzQN0woYYckiJ3BXM7OSBI6LIMnrG3AEXtEZkYpFbrblfB551KdO219
 l7HJQP5X3vTBbN0DsKE2Oj3hOyFwAz+bJzrMcgOQq+xaDHds+Q14PUcn/YYcm9JgiZdd
 FaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745361317; x=1745966117;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nm9FPhOGujzcuwc0fqA5mk8oSCUhAkJUmvwSiBQ8E6k=;
 b=kEbaKVwBn0Kcv6/+kIsorEFrPGWU3nTDXKxh3ER3cskllt9ArBO3uEw29rvZtXNx+m
 /VFrst5JTX/NWsAYhW/nirkAfnNQfmtdllzTlXl6QezrN/mrrLsRMNWnuJEQ3KJnVMed
 DtVVcoLsaPRE+7L9eZUnWnGk1IipMD3PWrfCTO4EI8ttJHO+R7At4HwXDa3bpn/b+lLa
 u0wRx+/ih9T/5CnpiMNmX3kU03kiMBaTLV6TQGjWUBifTQz7EMnlxnGf7W9IG2UQw1xU
 gYFMFmYuuHAFOM9wgnTrjCXJA0LQ2oMAoYXox9Y8yw+7dxtUe/v7kb5sGTwE4H20nV7e
 9yCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNgzvqYAQ+H80cpgORsZL8hAYAGRr1VDkU+DSyn10wJbSigO2dWN88h2uiaDwYNkNNqFwEVYS+GGYP@nongnu.org
X-Gm-Message-State: AOJu0YzNP/PJl+2+h8ZQJbM9PjKJIxYJ+LoCfkNfNNEUjiY8l9lBe92q
 qi31owQO7VnQcyWBH36kJlHDYqSSc2kPnqG5v5tk6AfPv+AkwPlm1L4Df+176wI=
X-Gm-Gg: ASbGncv5O5SjujOeZLFVxwcNSZWyRcxEzGw+SyPsyMj1Vrdg94TMAeKLGzEDT7LtwZB
 hTn7al5hh+hi+8dc/JSWKsM1Q416vpItLswYVIPkchpKG2aScsGcmrGp7pLqdH/l3bfBQAZCs7+
 AlVMLKM2mtCSVxi/y++32oDXafZNxe7Lg+xPY1T/+WDFqFKJKglwb4OU4w/3F4A2BKvzB4JqaW+
 3uZ0D3R/EYknRuv84CX91OVF4JqEKOtT7pGDXmvYyU8DXPGH4FJx0gz1B/SEex4D5aXLk+j4pmd
 UrCJSZx4+2hD2wllFfMjWb5yhU/4z6D/uYH4OTmb2Owga7SdVaQ2B7Q9PVCAMw==
X-Google-Smtp-Source: AGHT+IGRtNpcl084SxWJilu3P0E37ULqbnojQ/fPwBeTCEGXrb+sfYtrDiO3cdjyXzbI3RkIBLZUPQ==
X-Received: by 2002:a17:902:f681:b0:224:18bb:44c2 with SMTP id
 d9443c01a7336-22c53472982mr209857705ad.6.1745361317619; 
 Tue, 22 Apr 2025 15:35:17 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb491asm90813795ad.116.2025.04.22.15.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 15:35:17 -0700 (PDT)
Date: Tue, 22 Apr 2025 15:35:15 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH RFC] target: riscv: Add Svrsw60b59b extension support
Message-ID: <aAgZo68nLYdm186S@debug.ba.rivosinc.com>
References: <20250314104833.369365-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250314104833.369365-1-alexghiti@rivosinc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x631.google.com
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

On Fri, Mar 14, 2025 at 11:48:33AM +0100, Alexandre Ghiti wrote:
>The Svrsw60b59b extension allows to free the PTE reserved bits 60 and 59
>for software to use.

Apart from what you already caught.
Extension is dependnet on Sv39. So it should be validated somewhere.
Perhaps in `riscv_cpu_validate_set_extensions` (target/riscv/tcg/tcg-cpu.c).

>
>Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>---
>
>I tested it by always setting the bits 60 and 59 in Linux which booted
>fine.
>
> target/riscv/cpu.c        | 2 ++
> target/riscv/cpu_bits.h   | 3 ++-
> target/riscv/cpu_cfg.h    | 1 +
> target/riscv/cpu_helper.c | 3 ++-
> 4 files changed, 7 insertions(+), 2 deletions(-)
>
>diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>index 3d4bd157d2..ee89cdef46 100644
>--- a/target/riscv/cpu.c
>+++ b/target/riscv/cpu.c
>@@ -219,6 +219,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
>     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
>     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
>+    ISA_EXT_DATA_ENTRY(svrsw60b59b, PRIV_VERSION_1_13_0, ext_svrsw60b59b),
>     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
>     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
>     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
>@@ -1644,6 +1645,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>     MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
>     MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
>     MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
>+    MULTI_EXT_CFG_BOOL("svrsw60b59b", ext_svrsw60b59b, false),
>     MULTI_EXT_CFG_BOOL("svvptc", ext_svvptc, true),
>
>     MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
>diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
>index f97c48a394..71f9e603c5 100644
>--- a/target/riscv/cpu_bits.h
>+++ b/target/riscv/cpu_bits.h
>@@ -663,7 +663,8 @@ typedef enum {
> #define PTE_SOFT            0x300 /* Reserved for Software */
> #define PTE_PBMT            0x6000000000000000ULL /* Page-based memory types */
> #define PTE_N               0x8000000000000000ULL /* NAPOT translation */
>-#define PTE_RESERVED        0x1FC0000000000000ULL /* Reserved bits */
>+#define PTE_RESERVED(svrsw60b59b)		\
>+		(svrsw60b59b ? 0x07C0000000000000ULL : 0x1FC0000000000000ULL) /* Reserved bits */
> #define PTE_ATTR            (PTE_N | PTE_PBMT) /* All attributes bits */
>
> /* Page table PPN shift amount */
>diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
>index b410b1e603..f6e4b0068a 100644
>--- a/target/riscv/cpu_cfg.h
>+++ b/target/riscv/cpu_cfg.h
>@@ -89,6 +89,7 @@ struct RISCVCPUConfig {
>     bool ext_svinval;
>     bool ext_svnapot;
>     bool ext_svpbmt;
>+    bool ext_svrsw60b59b;
>     bool ext_svvptc;
>     bool ext_svukte;
>     bool ext_zdinx;
>diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>index e1dfc4ecbf..6546cea403 100644
>--- a/target/riscv/cpu_helper.c
>+++ b/target/riscv/cpu_helper.c
>@@ -1156,6 +1156,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>     bool svade = riscv_cpu_cfg(env)->ext_svade;
>     bool svadu = riscv_cpu_cfg(env)->ext_svadu;
>     bool adue = svadu ? env->menvcfg & MENVCFG_ADUE : !svade;
>+    bool svrsw60b59b = riscv_cpu_cfg(env)->ext_svrsw60b59b;
>
>     if (first_stage && two_stage && env->virt_enabled) {
>         pbmte = pbmte && (env->henvcfg & HENVCFG_PBMTE);
>@@ -1225,7 +1226,7 @@ restart:
>         if (riscv_cpu_sxl(env) == MXL_RV32) {
>             ppn = pte >> PTE_PPN_SHIFT;
>         } else {
>-            if (pte & PTE_RESERVED) {
>+            if (pte & PTE_RESERVED(svrsw60b59b)) {
>                 return TRANSLATE_FAIL;
>             }
>
>-- 
>2.39.2
>
>

