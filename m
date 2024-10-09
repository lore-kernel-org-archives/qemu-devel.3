Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88270CEE345
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 19:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syc6F-0007Xz-Dv; Wed, 09 Oct 2024 15:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syc6E-0007Ws-1J
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 15:11:54 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syc6C-0005eD-FT
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 15:11:53 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c87c7d6ad4so65118a12.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 12:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728501111; x=1729105911; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7Eo5USNrx8JyjXNjc6BLK+O8YByCE3WVTqVbgircm4Y=;
 b=xS5gcYNP9V4Fz5hTvmKVsER4SjUSsVumzfgUFmis5y1lFIbK1QYoE/4jWC6t1yo3J7
 n+BLi+m//Efzy86p7DLGP9fX3Px/4TuHS+YNApGTTmYcJuCDWeIwYPXJ2TV/WH84zfYM
 EyGxGevLF4ckS8mdXsno1ejIT+DjM3UEVgHxPsvctR8qe1uvYJV1KzWut4Yg9rvlHlKl
 DjzwaoF44bHKsEo2rnH8fSqjUcNlu2mYFVBZ5qkDZqTOKiaq0tfnAnuEIbHr+Hgm4uwV
 OZmkZM4MP5LeC+EVQuHJLeIySbXtBTVir4br0gserOSA0Oa9NusjMGsyK52pxOKk8jED
 F/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728501111; x=1729105911;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Eo5USNrx8JyjXNjc6BLK+O8YByCE3WVTqVbgircm4Y=;
 b=s1/x1j7txDELFXSpjS0L4xvOFnEphtHnSLg22dVwE2ZqJhNz1a0zASM4RsUAzDnALC
 jQ7YhpQKgcXKwBG97AmWKNUwE4h7cd2LrRZi5I5tZrOFGmF85yVMcdRTcDcmuCFJtv5P
 /XxbEIUoo0FHMktu4PNcit4AiRpcX2y0A1W7y3iGPKKQFJFhe+SqCHHnoFWCIsqDWUYL
 p49NL74FtfQ1IxLDtlW0KH/FF/kp8MjWc4bvv+XlsjnBfz4h5iS+8uisUgDTHV3GSklh
 YRHy34BUTQ5Yb0kSXgiFDdya0/johnLXekeslhN8618DBE8RuF39H2CHN10n69BWsfG8
 mRlw==
X-Gm-Message-State: AOJu0YxaHM48HRN7jYgZZIut8tvNVyAcq+FbGpItAbhSmc4rPv+BnPCv
 qsUsxPjWBuOZUMj+B2U4C2ZcI+cdcz5hP1iLl3hEZyZu/g+et7NSrPJ3g3wf+gGoYQNFwaLeW6D
 d7JRmamShouMgNzGJC7I3W1oruTnhzxkKqZYVKaFvrnvu4bvs
X-Google-Smtp-Source: AGHT+IG42NaORpkEuaLBHmaRIXnVnK3PbEIACsfckckh0z/+qNg5BqPlhSAKd0Y4Dl2lLk3qkq//FMyjN4as8PR19HQ=
X-Received: by 2002:a05:6402:26cf:b0:5c8:a92b:b0a with SMTP id
 4fb4d7f45d1cf-5c91d53c982mr3123807a12.1.1728501110782; Wed, 09 Oct 2024
 12:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241008185141.20057-1-richard.henderson@linaro.org>
In-Reply-To: <20241008185141.20057-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 9 Oct 2024 20:11:40 +0100
Message-ID: <CAFEAcA8JUM-uiK_nor99iJ3XOssjJ3sz4oD6qZEoBxZOLTZrmw@mail.gmail.com>
Subject: Re: [PULL 00/14] tcg + linux-user patch queue
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

On Tue, 8 Oct 2024 at 19:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 2af37e791906cfda42cb9604a16d218e56994bb1:
>
>   Merge tag 'pull-request-2024-10-07' of https://gitlab.com/thuth/qemu into staging (2024-10-07 12:55:02 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20241008
>
> for you to fetch changes up to 25f4e71722417db1f7d5140847849197053b23dd:
>
>   accel/tcg: Make page_set_flags() documentation public (2024-10-08 06:40:31 -0700)
>
> ----------------------------------------------------------------
> linux-user: Fix parse_elf_properties GNU0_MAGIC check
> linux-user: Various improvements to strace
> linux-user: Add openat2 support
> linux-user/flatload: Take mmap_lock in load_flt_binary()
> accel/tcg: Make page_set_flags() documentation public
> tcg/ppc: Use TCG_REG_TMP2 for scratch tcg_out_qemu_st
> tcg/ppc: Use TCG_REG_TMP2 for scratch index in prepare_host_addr
> target/m68k: Always return a temporary from gen_lea_mode


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

