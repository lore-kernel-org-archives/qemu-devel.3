Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AFEC48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 16:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rduh7-0005CG-RL; Sat, 24 Feb 2024 11:16:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rduh1-0005Bh-1z
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 11:16:03 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdugx-0002hT-W4
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 11:16:01 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-563b7b3e3ecso2321906a12.0
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 08:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708791355; x=1709396155; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V1VActajtTh/NJ3Nl/sBVLx0blomeS65L9gQTypppDw=;
 b=R4StcsEe3wkgQNIMGI7llTxCTBny4NwIkgYwW+i7kMvTqj8vBRyXirl8/jgIoqYZ86
 gsTUn7PXoczmOfy08O6OEqfMc/MUB0BJCXMhZR6PtdgxtV5Ikl0PkGc4hn5kt/1IQLuN
 czc/CDv/RsOf4xRKBgyu89ygajAj+iNx3tA6b4CqmFs7oNPg7jJWlW5FPOJxxoxM0OHx
 x8Rz2CgkWqi24y9k2U6+M1HU/OcPGCM6TlRD2aE4ejAR64ClfBqe0+mk6ZBahSrfyabJ
 7Ec5RrPs9viIgN7tza8fN5oQhBFbzZGP9JVrQFM8F8o4PTqTInBMFfUAtzHR01AKtyoL
 myPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708791355; x=1709396155;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V1VActajtTh/NJ3Nl/sBVLx0blomeS65L9gQTypppDw=;
 b=RXD0KG1zfltSe+xM594Y2XH/xuaGRfNt4+izI6dKHQylaZjHN9VDm8eIOi56mT/f98
 DCoW3EJaOHqTiyvbqOsdkoEL8/QmxHEFSW5iSQeCa9tOF4Lnm/0w7zTMjU2BCPIryhJl
 1j09U2XLUJSbzOHzwGjUskWdj5HVsqwnXFndHLXXsa/RcmVCqEorVEACxPvi2FzMmBaU
 aXAK/fUSe634X2Pau54oA9+UiYS7l7zWAYia/OBeSUWwBJ8RTJCUGNMlKCVzmPGR7V24
 jMZY+1HmLyFBVJ2d1+uaOfs4/FZglfkldjmMtU6Qv6akRbV5xwXyomr07CSkEH2usndm
 uj6g==
X-Gm-Message-State: AOJu0Yz5gCUIIzXO4HneNbhK49KukA9cRdhmOr99tzaa1zXuoFoafsFm
 wkPUzX5ozqSgR6PqyrEpkMRmUWyglYFzScYRMtldGcAE/twYL0Bf3ZY3QS6g1CDUmGOEnVTV5hb
 TnoA3J8eu9Ru597VOzLuQuRkoMj0x2NhLir5cXg==
X-Google-Smtp-Source: AGHT+IFLjVlEF3SqLrjxYTVCTdye1N8gaQ6mPF2HtKrh6VMhueIj0SWUAo9wGGpxAPOSmOSvh2fEJP91H9g6Dv2Usz4=
X-Received: by 2002:aa7:c3ca:0:b0:565:ac6e:cf1c with SMTP id
 l10-20020aa7c3ca000000b00565ac6ecf1cmr838701edr.1.1708791355181; Sat, 24 Feb
 2024 08:15:55 -0800 (PST)
MIME-Version: 1.0
References: <20240224010517.619640-1-richard.henderson@linaro.org>
In-Reply-To: <20240224010517.619640-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 24 Feb 2024 16:15:44 +0000
Message-ID: <CAFEAcA-5pE+=Xoq_BLRemRRr-zr2HU-FOcX-wHNQutTdc4Z4ww@mail.gmail.com>
Subject: Re: [PULL v2 00/39] tcg and linux-user patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Sat, 24 Feb 2024 at 01:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> v2: Fix bsd-user build errors.
>
>
> r~
>
>
> The following changes since commit 3d54cbf269d63ff1d500b35b2bcf4565ff8ad485:
>
>   Merge tag 'hw-misc-20240222' of https://github.com/philmd/qemu into staging (2024-02-22 15:44:29 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240222-2
>
> for you to fetch changes up to fcc6ad372f56d3f47b6d5457a904916b48b9e114:
>
>   linux-user: Remove pgb_dynamic alignment assertion (2024-02-23 15:07:03 -0800)
>
> ----------------------------------------------------------------
> tcg/aarch64: Apple does not align __int128_t in even registers
> accel/tcg: Fixes for page tables in mmio memory
> linux-user: Remove qemu_host_page_{size,mask}, HOST_PAGE_ALIGN
> migration: Remove qemu_host_page_size
> hw/tpm: Remove qemu_host_page_size
> softmmu: Remove qemu_host_page_{size,mask}, HOST_PAGE_ALIGN
> linux-user: Split and reorganize target_mmap.
> *-user: Deprecate and disable -p pagesize
> linux-user: Allow TARGET_PAGE_BITS_VARY
> target/alpha: Enable TARGET_PAGE_BITS_VARY for user-only
> target/arm: Enable TARGET_PAGE_BITS_VARY for AArch64 user-only
> target/ppc: Enable TARGET_PAGE_BITS_VARY for user-only
> linux-user: Remove pgb_dynamic alignment assertion
>
> ----------------------------------------------------------------

Hi -- looks like this introduces an new variable-length-array, which
we are trying to get rid of:

../linux-user/elfload.c: In function 'vma_dump_size':
../linux-user/elfload.c:4254:9: error: ISO C90 forbids variable length
array 'page' [-Werror=vla]
4254 | char page[TARGET_PAGE_SIZE];
| ^~~~
../linux-user/elfload.c: In function 'elf_core_dump':
../linux-user/elfload.c:4778:13: error: ISO C90 forbids variable
length array 'page' [-Werror=vla]
4778 | char page[TARGET_PAGE_SIZE];
| ^~~~

I noticed this because I happened to test merging this pullreq
together with Thomas's testing pullreq that enforces the -Wvla
error. I'll be merging that testing pull shortly but it's not
upstream quite yet.

thanks
-- PMM

