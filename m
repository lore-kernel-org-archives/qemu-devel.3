Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249AAC5B543
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 13:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL0B5-00007h-GB; Fri, 30 May 2025 09:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uL0B3-00006e-8x
 for qemu-devel@nongnu.org; Fri, 30 May 2025 09:53:41 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uL0B1-00014t-Jx
 for qemu-devel@nongnu.org; Fri, 30 May 2025 09:53:41 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-60461fc88d7so3975010a12.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 06:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1748613217; x=1749218017; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mc46cCfneoTYTJz+e6DtEc53hKzBewpF+Ba7fhALtZs=;
 b=WJJceCEplFDyBf4TGqvuhf17p2gK9rwz4DEeMafR9yk+6KBeA1EkW37Cvm0E+1MSVY
 mPWjlRUGJ/RxBCziFHUj6uTkp1+2MRIRjNhH9+8xnuusznt10bn4Ua/fjXrPfDsFIFul
 sO1CyUUoLKdolceQ9gCH33NmceqFk0h7YWTsZfEwvHn3l4fzWiUWRzqa71TbPQgdIVhU
 xgo8+Jjuaref7ID4USfg/q4SXvAO7AwbwWtMOQ5MvOfKrk9HQzTn39JcA+41i58kFEgh
 E5nCgkYW7MtfOXo9Rr1IMDdVByrpr1Sy7b2kxpAImlwpY1907I/qKiEdktSteWinNpF4
 MjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748613217; x=1749218017;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mc46cCfneoTYTJz+e6DtEc53hKzBewpF+Ba7fhALtZs=;
 b=i3M/r1tBP3gDHpwUSsFJsw8xAhP7OKBBvNfBEiHnEhGfn0gqQIRYdBCRgnu5ekuS3U
 ft/NJznUzAhMteGF44ndQs/l9gf/GG4nrM9sJRDiMVoN6kxynbCSzaIz8k5khYpWUrcd
 dP4cCvI9njmLR0cqsjQE4sSwVKGO9yVcqBydn2oSKFNBjHy5UW0A04JTCDLz3MmyYQRc
 gXfPlA11kZha8etvRSV01pnHP1PiypLigGOTnMzF6YM+fjLkfyRmUi3d91gtUbNwCKYH
 Quwx5vPchC2ekQR5RFLValcewGIGb67eWrOprlEaDNA7Mv2SNBqH0McmUmxLQkXLLW6d
 AGmw==
X-Gm-Message-State: AOJu0Yxq1UhuUxHd+92hdRAh2l40YAlGcv4C2732zjwN5cgbwmn5ibuZ
 i1tkmsk70AUpxwxmoFGVGKQf2n6qV8JhhmiHKkF8NvaHW5Ae6LWl+iuZ2iS4Ho00AzE=
X-Gm-Gg: ASbGnctXPkC6K3Uylk9uKGfBdzzh5ku2Gc7tXT2gpjSDd8+wKYcnFka2C8TEqbsq9uB
 0uqWg4BmOn3mzV/AchKDC5bd1fIu8NACTNuAm0pnwSO3p+ByZ1/BD3vn6wi8vmVf1RUAy4nsAXw
 NPYEyybXsCAa8ZP/L7joMZpbSTuxXNIb/VgLfMbbeTQ1XYX31b4D8G9SNYVYdsLW6D5oCnykNn2
 35xYUot3M6251+sswhB3aWiNPFG7eTgMkJMHNqj2cU/FHQXvL1z8JJvf4SHLzp8gHDU/t7vanUS
 L/QkECJnmVjPMtNH4gPBY8lZeY+IcfSHRYZxAqpThkStZrPnIa7lS25sow==
X-Google-Smtp-Source: AGHT+IFNKKlrfynKwCDGYYOTlxKLbtgLa/cjnMpVxgF7ZkDrivjcRTbQssdDEeeYmZxG2uolidWDDQ==
X-Received: by 2002:a17:907:7210:b0:ad5:3055:784d with SMTP id
 a640c23a62f3a-adb322b02c7mr300488966b.34.1748613217255; 
 Fri, 30 May 2025 06:53:37 -0700 (PDT)
Received: from localhost ([2a00:11b1:1029:5857:f3a5:c7b7:d102:3317])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada6ad6aa9asm332618766b.179.2025.05.30.06.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 06:53:36 -0700 (PDT)
Date: Fri, 30 May 2025 15:53:35 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
Subject: Re: [qemu PATCH 2/3] target/riscv/cpu.c: add 'ssstrict' to riscv,isa
Message-ID: <20250530-cd03932babbb297f306d5c27@orel>
References: <20250529202315.1684198-1-dbarboza@ventanamicro.com>
 <20250529202315.1684198-3-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529202315.1684198-3-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, May 29, 2025 at 05:23:14PM -0300, Daniel Henrique Barboza wrote:
> 'ssstrict' is a RVA23 profile-defined extension defined as follows:
> 
> "No non-conforming extensions are present. Attempts to execute
> unimplemented opcodes or access unimplemented CSRs in the standard or
> reserved encoding spaces raises an illegal instruction exception that
> results in a contained trap to the supervisor-mode trap handler."
> 
> In short, we need to throw an exception when accessing unimplemented
> CSRs or opcodes. We do that, so let's advertise it.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 9d6fae72b2..cd0b159ed5 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -217,6 +217,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
>      ISA_EXT_DATA_ENTRY(sspm, PRIV_VERSION_1_13_0, ext_sspm),
>      ISA_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
> +    ISA_EXT_DATA_ENTRY(ssstrict, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
>      ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
> -- 
> 2.49.0
> 
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

