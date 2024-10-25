Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DBFD0C606
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 12:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4JWu-0007rS-TI; Fri, 25 Oct 2024 08:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4JWs-0007qc-Bk
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 08:34:58 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4JWp-00011B-Kr
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 08:34:58 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c9404c0d50so2221877a12.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 05:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729859691; x=1730464491; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pKtoknJaRkBKpxNjIfUPtTkPP3ApBWXlXqHh3ivUFSw=;
 b=RkhdzzFCYBHzsYBJy5cQoebT+4EBdasP/tUOWeAJ9q/tNgOjyErBSdajnJcANe6xCE
 VqVvK8fIitOn614xy688uJnJcJXp3+KLhj/rGmSX+LsbYFI1whQ1OFiW64XpmSN0s+oE
 hzOV8dOOiLWKR0nyW22z5kycJdyDCK08T/rTTaomMMAvQNKwWP2A6ZQuRwBWl6Z/t5if
 kU3wCHGa5KBvCD1/3YEjI+dmiRbnf59Eznao6Q9ivnVoxLn6+FvBX2FsB8jjRSUQvGbb
 TUuTvEN1dX54xDXnWZ19AnsTcd9ZyUySfKa8zo6EjSRPY36UPJjQZ4zyDT8TbkFzYMak
 0eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729859691; x=1730464491;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pKtoknJaRkBKpxNjIfUPtTkPP3ApBWXlXqHh3ivUFSw=;
 b=ZKvgggtVkmbxK+5p5Lkh5l+ejUtlkxcXEgF9VmVyJE7SmVc+xnJ0+YC1T/ZMgwP8dk
 77nEAypZCAmHacJ4uf6vU8A/5XmfAjw1tKim1F00L8CizNyg1Z0WYlJ/tbLul5TUgKa6
 nZuQ9RGq+LSYmnJTdZwpLuFmfZ5dAwPQ7upNOoFlxDKSsRzP7eC3NNWhqSIGZ9XFIhek
 A9B4L90k4MZM4VSgNNetXXAyZRc+ZTzs1CDoOFM5RRhTEf6YYQTMQ2+tAle9D+hexOQX
 2kDJY55w34svCp1q216kxu/OX/13Pu3VHqHvvDeblP11eF86pDqrKYWXSp4LskeCTOS+
 XY+A==
X-Gm-Message-State: AOJu0YzUlsTuzsdhU03BrrX3WMVrY+VA5RxzRy7KtAsl+5AdnRbxEImb
 1agWxvdyHZYZ2rJKa8e3U8R1Cq8icbrm/96S8qVo/SVRCOvtIn/gunRNfz6w1lOw7rQEOGbAASA
 cdnQhFdz2zNbYQNuxuecMzGUiTWkobUxdAdbx4Q==
X-Google-Smtp-Source: AGHT+IFc2Op9efT7XB1MaMvSzihGqwwIa7ZKO0J2V89gm6BwuU7fgVwVzkr+ZAcMTo37AzRn3M36ExowDrORdYyd8cI=
X-Received: by 2002:a05:6402:2548:b0:5cb:7295:49b with SMTP id
 4fb4d7f45d1cf-5cba24ad1b7mr3094665a12.34.1729859690465; Fri, 25 Oct 2024
 05:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241023033432.1353830-1-richard.henderson@linaro.org>
In-Reply-To: <20241023033432.1353830-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Oct 2024 13:34:39 +0100
Message-ID: <CAFEAcA9rLJFbYez5b6_d0snNqzE1n9jCZUbKf7hYCoHvWfZziQ@mail.gmail.com>
Subject: Re: [PULL 00/24] tcg + linux-user patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Wed, 23 Oct 2024 at 04:34, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 6f625ce2f21d6a1243065d236298277c56f972d5:
>
>   Merge tag 'pull-request-2024-10-21' of https://gitlab.com/thuth/qemu into staging (2024-10-21 17:12:59 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20241022
>
> for you to fetch changes up to 310df7a9fe400f32cde8a7edf80daad12cd9cf02:
>
>   linux-user/riscv: Fix definition of RISCV_HWPROBE_EXT_ZVFHMIN (2024-10-22 13:45:03 -0700)
>
> ----------------------------------------------------------------
> tcg: Reset data_gen_ptr correctly
> tcg/riscv: Implement host vector support
> tcg/ppc: Fix tcg_out_rlw_rc
> target/i386: Walk NPT in guest real mode
> target/i386: Use probe_access_full_mmu in ptw_translate
> linux-user: Fix build failure caused by missing __u64 on musl
> linux-user: Emulate /proc/self/maps under mmap_lock
> linux-user/riscv: Fix definition of RISCV_HWPROBE_EXT_ZVFHMIN
> linux-user/ppc: Fix sigmask endianness issue in sigreturn
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

