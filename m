Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A95E98FA8
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 03:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAgIH-0007Gl-86; Wed, 08 Apr 2026 23:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wAgIG-0007GP-1S
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 23:43:00 -0400
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wAgIE-0003J2-AW
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 23:42:59 -0400
Received: by mail-qv1-xf42.google.com with SMTP id
 6a1803df08f44-8a049a767c3so5196526d6.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 20:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775706177; x=1776310977; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oNisEvkzdcLRBpKff1CbPUGMEY8cYBSq5sGZaWsUOes=;
 b=VTOvoLfyhBNT/CivNQQ90Hk6m/XmKGcj2no153rQ64cDVCfCQva9FGjKeG9V7+TRRh
 8x9WgyXHYklbRT6KaIaQBgAYeltF0nUDA97RZt60o5GmfvS3qRawY4lixO/sNPOliYoy
 kE7RvNB7foIjIm2ojtmaputHnmcgZQd+RreSKh3N9VVYYK8TR9nUvxejriYYBynw7tzb
 kk8kGI+I8g91nBAS9+Zi4ZJuHSceGi62wOyRbznRNcbjNYmjLO6TXo/20KSbNCPJDzVZ
 fDLhCE6M1vrbz5ppCv4588Ak+1gmB3uGt9dA6Xj0XtH4ope/SF/xRp+nnz9GLZwJt4Zy
 AHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775706177; x=1776310977;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oNisEvkzdcLRBpKff1CbPUGMEY8cYBSq5sGZaWsUOes=;
 b=royvslhnrVQNXIGobmaThQGeeg4JmTJV5IQvyU6v3tzJbdvDQBLBe6VhdnINJ/bgfy
 0OHhamQG+GD+eBXsE18ppRws9Sd0l9zNw62IS7kh0jRhwkdpRPlKBdGfr79YCg5FAFIn
 MeCE7kngUah3Aun4IfoghCIWD1sXO3umky/dvsAQu7sFnm2H4rtymSL6cJx8W0ispk4n
 fh0WoP2L2l+9HHLUwGHX/+AN90L4lXCUShpecL8EzAXpB43NswpKVVq9gbcaJmR71t0q
 7lXY7F0vXxvx7k14F3P9agR57agNxacxbXIwW0IDEtY8HvKkFFM2y1avzYlhw3gZwZhs
 8qhg==
X-Gm-Message-State: AOJu0YzKKlOr3FFRDKBi5t5PhjmwQ7CWEwQISae4cEtlARNqNi4K2sIj
 wYick14QCdHUJXIMWPr38B2eXtmfAeDKVa8KhpSJKFia1274nXrGkd+W
X-Gm-Gg: AeBDietd3FF/0RbbMRwTaauZflQl/01ktPdsN1TjHRiEBjHRT6tiRJ7WfG0pACsSN7u
 jL3/ucTuew5CiD2QGJD8yp03mlo/nI0X5ge+asa6Fh6eN0mxXpJIVbtsPASyv1KMqDNWqlbmOHO
 /cQbZQGo6EgSAhMTJxnIhdGY1kyPOhXmJaa/tcM7toiJre2lvNwNx/hNOUPFWtJYlbHhMdM1InG
 FsPTLybR4EDAaRgaZQpV/MJdfiq9Gew6+7u2xn5UD30BaeprPPw4COQC0qQFutQEIMOGBTuytd3
 pxp507rAQKfkvsEhAU2eZiKsVlotl7ksLGVHB2pvEpj2niozyBSHjhQZsVwXM35Yv/IlqIg+des
 lcIX1lF5pK7x15f15MGh6nv6WZixH1M2Qonc/Zf/lFWvM/ZeHueqahZqQyI/JTb+wZ1L5dQDmq6
 REkicD1Cl85/hyhcv8gBtU7+J7c19Z58lgnqOa2Lrx03vh3R8YcoE5DVrlZ32aM8ylGRRkTPKT0
 DwCwuVa0mo=
X-Received: by 2002:a05:6214:33c8:b0:89c:869e:4972 with SMTP id
 6a1803df08f44-8ac7457263cmr32289996d6.10.1775706176785; 
 Wed, 08 Apr 2026 20:42:56 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac56e3a898sm60404416d6.38.2026.04.08.20.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 20:42:56 -0700 (PDT)
Date: Thu, 9 Apr 2026 11:42:31 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair23@gmail.com, daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com
Subject: Re: [PATCH v5 0/6] target/riscv: Implement Smsdid and Smmpt extension
Message-ID: <adcfzpN9kXIoL2Bj@ZEVORN-PC.localdomain>
References: <20260408140635.42546-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408140635.42546-1-zhiwei_liu@linux.alibaba.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f42;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qv1-xf42.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhiwei,

On Wed, Apr 08, 2026 at 10:06:29PM +0800, LIU Zhiwei wrote:
> This patch set introduces support for the RISC-V Smmpt (Supervisor
> Memory-tracking and Protection Table) extension. Smmpt provides a
> hardware mechanism for fine-grained memory protection, checked after
> address translation, which is particularly useful for supervisor-level
> sandboxing and security monitoring.
> 
> The rfc patch set:
> https://mail.gnu.org/archive/html/qemu-riscv/2025-09/msg00216.html
> 
My review comments align with Daniel's, LGTM.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> v4->v5:
>     1. Rebase to master. 
> v3->v4:
>     1. Add missing review tags.
> v2->v3:
>     1. Fix build error in patch 2.
>     2. Rebase to master.
> 
> rfc->v2:
>     1. When ext_smmpt is false or BARE mode, make other fields in mmpt
>        CSR zero.
>     2. Add patch 5 to fix smrnmi ISA string order.
>     3. Fix patch 6 smmpt and smsdid ISA string order.
>     4. Make smmpt and smsdid experiment extensions.
>     5. Add review tags.
> 
> 
> LIU Zhiwei (6):
>   target/riscv: Add basic definitions and CSRs for SMMPT
>   target/riscv: Implement core SMMPT lookup logic
>   target/riscv: Integrate SMMPT checks into MMU and TLB fill
>   target/riscv: Implement SMMPT fence instructions
>   target/riscv: Fix smrnmi isa alphabetical order
>   target/riscv: Enable SMMPT extension
> 
>  target/riscv/cpu.c                            |   6 +-
>  target/riscv/cpu.h                            |   9 +-
>  target/riscv/cpu_bits.h                       |  27 ++
>  target/riscv/cpu_cfg_fields.h.inc             |   2 +
>  target/riscv/cpu_helper.c                     |  81 +++++-
>  target/riscv/csr.c                            |  95 ++++++
>  target/riscv/insn32.decode                    |   2 +
>  .../riscv/insn_trans/trans_privileged.c.inc   |  30 ++
>  target/riscv/meson.build                      |   1 +
>  target/riscv/pmp.h                            |   3 +
>  target/riscv/riscv_smmpt.c                    | 274 ++++++++++++++++++
>  target/riscv/riscv_smmpt.h                    |  36 +++
>  12 files changed, 560 insertions(+), 6 deletions(-)
>  create mode 100644 target/riscv/riscv_smmpt.c
>  create mode 100644 target/riscv/riscv_smmpt.h
> 
> -- 
> 2.43.0
> 

