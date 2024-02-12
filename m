Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B1AC4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 14:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZX3t-0002VF-Ge; Mon, 12 Feb 2024 09:13:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rZX3o-0002UU-By
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 09:13:30 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rZX3m-0002tR-Ip
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 09:13:28 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-561587ce966so4031025a12.1
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 06:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707747204; x=1708352004; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4geB9HGax5d5Vzp3mxxxyPHxMTOW/26BnsmX94HPzvw=;
 b=GSH2JeBOi1dscxa38cMaSR3hCT/MUhAjQrIzKqM7dL6EvO3CFQVU2AjFY3ahGk8Mds
 /HKwgmxBPZAWBbxog2nLonzXIuJIrst59PWwdcYtqZzx3JPMM0kxQtBnIvApJIjKQRCk
 ThGTr7KdFmv4WEMLplpEkXUKL9uJDq7s7AhlNCM6mdA0dgb+EwO7twkbXS8kCAZC9fPH
 e3r46jZ9VvNJa/Fx9VgOFfHDN9lSYloTy3lc2se6iCXZW3I6mzUM1XOS4ppfuOIEztoF
 4DJHNHEy8OgR91hBYP0RDcbU00scQvW4W9BAuklJZavyXEoNJ8hUjxbnXZVxlk5y75w8
 78zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707747204; x=1708352004;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4geB9HGax5d5Vzp3mxxxyPHxMTOW/26BnsmX94HPzvw=;
 b=MQqErGewvLt+5XFKcclLj3bTvenloyjPXDhRiXmzUxW3NdAs86hptXmA/o9gG7HyTd
 8bJNs0hYlgr2f3xWcAb7ALtFmQar1MRkG9BrhJJtL4F+7FrWjo9LTilHC7ILJVN4E5dv
 cRT2bpbSxKqMuAe43rOWPw29hTrolHZApAmbSFn5EXvParnFNSjY2KJ/VLiIxysB9IjE
 H1D0jZ6TSVVlg1xGfHF+fY4Y5ToP7Y7iRKXyKzly/9ujTtnGlTTOlwO7UG+1AKH2mJ5f
 tzneKJPuvVYxmi4rA/wSzACQOG5P0rozepw/ATiYEweQ1xQEg+W4TjtvaUmi0rRt63Y6
 geHA==
X-Gm-Message-State: AOJu0Yxf03KlxlwS8AJPJsrD43AVV/62APa0Ar/8hrLgr0atqbe4MZ/5
 gMzdu1hcxW9NjiPcWpKY9moBOCexAfaO0M2puNAoCCurlEHkFJcxF4Dplnzb7nYv/RefdqbLhvD
 PMq/kdNW5OM0tpsB4hDe1OghAosvSlPGSQhZP7w==
X-Google-Smtp-Source: AGHT+IHkt0XY6+d1iJKRMy8Mku/Nfe1vVyFcAfLiCGYuKRLqsQpLezH4UsJ8e8uWr4i4DyHwC/Ii7RjPdADSyb4IphI=
X-Received: by 2002:aa7:d79a:0:b0:561:45dc:b438 with SMTP id
 s26-20020aa7d79a000000b0056145dcb438mr6024082edq.4.1707747203708; Mon, 12 Feb
 2024 06:13:23 -0800 (PST)
MIME-Version: 1.0
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Feb 2024 14:13:12 +0000
Message-ID: <CAFEAcA9+SO-u6e+57kU4RHRbjir4eREj+z0YXOpP7yoFdd9MMg@mail.gmail.com>
Subject: Re: [PULL 00/61] riscv-to-apply queue
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 9 Feb 2024 at 10:59, Alistair Francis <alistair23@gmail.com> wrote:
>
> The following changes since commit 03e4bc0bc02779fdf6f8e8d83197f05e70881abf:
>
>   Merge tag 'pull-tcg-20240205-2' of https://gitlab.com/rth7680/qemu into staging (2024-02-08 16:08:42 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20240209
>
> for you to fetch changes up to deb0ff0c777d20602ecc5b6f74f18cb7ecc0b91f:
>
>   target/riscv: add rv32i, rv32e and rv64e CPUs (2024-02-09 20:49:41 +1000)
>
> ----------------------------------------------------------------
> RISC-V PR for 9.0
>
> * Check for 'A' extension on all atomic instructions
> * Add support for 'B' extension
> * Internally deprecate riscv_cpu_options
> * Implement optional CSR mcontext of debug Sdtrig extension
> * Internally add cpu->cfg.vlenb and  remove cpu->cfg.vlen
> * Support vlenb and vregs[] in KVM
> * RISC-V gdbstub and TCG plugin improvements
> * Remove vxrm and vxsat from FCSR
> * Use RISCVException as return type for all csr ops
> * Use g_autofree more and fix a memory leak
> * Add support for Zaamo and Zalrsc
> * Support new isa extension detection devicetree properties
> * SMBIOS support for RISC-V virt machine
> * Enable xtheadsync under user mode
> * Add rv32i,rv32e and rv64e CPUs
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

