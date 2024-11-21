Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5442FD75BCD
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 08:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE2FX-0003wK-Ky; Thu, 21 Nov 2024 03:09:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1tE2FV-0003w9-N5
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 03:09:14 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1tE2FU-0006hy-9Z
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 03:09:13 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 0AD1FA4047D
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 08:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BA4C4CED0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 08:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732176541;
 bh=Wx+/AvQOEttNHLhCaHiEAPrUq0zi+Uf9WT6GU0OEpK4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Sn/hpJnTLc5o8CqlRU7da+BqaNybXhiE5MGpUg7PFf2OX2YyrETivs3SCJhYelDyL
 IqghVXaBblCBlahS45ZVS8WRIOKTxLI67QuUX6oFkChOViaEJTOGDrduz16XSK98Up
 0ulSfJrWQm8R8crlYtC9+D5AnOOHxRIVxKHpFLb/QHUl4UvkOuMLZDBP7fBYKh4dS3
 s28CGj+bHv5Babr2xjJbH9xPHjYglRpwCvUEzWtDNud+cQAFgGQgsaNP+YqAjEDT5c
 5kjVUgDsj9zBDqwvhqoLhKOj10C0l8jbam5TtLH6jWJkMP/oVpg3q/4OEaktXDJIkt
 /Bgd7NcTCOKZQ==
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-53da24e9673so541507e87.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 00:09:00 -0800 (PST)
X-Gm-Message-State: AOJu0YzlMtS7EiTiCMbrHay9vcNCX0soMZK2ZiztZjDKV2ppuPrQTK5h
 rLmakumfrYXkZqymEVPws0NLKolK3QkAIPtaHFEeT9bJXZsbsGV4JC1qKwVnxPpCUfwT7BVl/10
 cQ4flCgoisS5iKUTLNT/W9YbMVCg=
X-Google-Smtp-Source: AGHT+IFWdO7r2vPNOmY0U//KmDEAND2Ee7FqfozbOmquz/kr3iA+aKYrdFUKmtlqd9vKiox19I7k5FXR+BQrLH2Ho74=
X-Received: by 2002:ac2:4e06:0:b0:539:ea0f:cc43 with SMTP id
 2adb3069b0e04-53dc13384b9mr2144825e87.19.1732176539349; Thu, 21 Nov 2024
 00:08:59 -0800 (PST)
MIME-Version: 1.0
References: <20240929180659.3598-1-ardb@kernel.org>
In-Reply-To: <20240929180659.3598-1-ardb@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 21 Nov 2024 09:08:48 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEgpZccCfboaqrz+yFmrejtqREbPvZaZQMR0=d_+2enMQ@mail.gmail.com>
Message-ID: <CAMj1kXEgpZccCfboaqrz+yFmrejtqREbPvZaZQMR0=d_+2enMQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Fix PVH entrypoint parsing
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=147.75.193.91; envelope-from=ardb@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Sun, 29 Sept 2024 at 20:07, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Fix the handling of the ELF note that describes the PVH entrypoint
>
> v2: fix broken ELF note handling on big endian hosts
>
> Ard Biesheuvel (2):
>   hw/elf_ops: Implement missing endian swabbing for ELF notes
>   hw/x86: Always treat the PVH entrypoint as a 32-bit LE field
>
>  hw/i386/x86-common.c     |  7 ++-----
>  include/hw/elf_ops.h.inc | 19 +++++++++++++++++--
>  2 files changed, 19 insertions(+), 7 deletions(-)
>

Ping?

