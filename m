Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730C4C47DDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 13:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVWhf-0006FC-3x; Thu, 01 Feb 2024 08:02:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVWhN-0006BQ-Ef
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 08:01:48 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVWhL-0000Xg-Od
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 08:01:45 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-55fcceb5f34so273644a12.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 05:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706792501; x=1707397301; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAdUFwzti1+9WNHY0F9MBZdywydLXG62Qp0LZhpz+d4=;
 b=JYOUZ5pPRfMQ/YR8Z43qGlDK9XV3pUScx3zIZRz3WsYwxLD3CXpCATZeB6Z8JSmWNp
 sZD/HAMSkeeApgnpLyVVkHRuyovytfBtanJoaJPnWKvjmrKOpnNngiTw3lihTe92Tu4S
 Lb8n0Zg/btvMecsEONVd9h2f/TFoFumeGGeT/KyyoFg+D45f/o1hlGTmEq0VsaBabfjc
 ntNyY6/lAAVc97oQkJ0qV3eSKZ3/uWI+26YYMNGSHS3bGuXFExURRrSHCXPEPDT9Rn/W
 DhpvMHSw8yVWsfRs1C4ZKfeZgGVXxjNQqWTJE2Ma/YvXRmBfLA4CYnV5RGVMMk6PBmup
 bErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706792501; x=1707397301;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GAdUFwzti1+9WNHY0F9MBZdywydLXG62Qp0LZhpz+d4=;
 b=exlu0Ecxcf3Nge+Ev9cGrX7v8bicHyfy6/czAxWeIJRtW/WMBV7tzU3JU4ixjXSH/O
 J9nZEWpIWKNY79isQ53GhXLnBx2K/rCUODQbvvd8ONorixLA6IBn7Ou6yROkZsCSgAPh
 aQmebZdOBeEgMukdvifbzuQJoL2x30AwO2hb0kFSguOeLgr6/FtbBi0oDMUNhr9ij3Ff
 z24KM4wzBXtDmpMnVXiXgNrxSwG3NjoSV3qEWAgqSD7ZmqrsgX934iXQlHnByJVhrX7Q
 dzMQIrQBxu8oPrfOwEkKePHXetrxBk6ppFrAl4psLUky3iqYSRsJgH0DrxGPEWDuQpTW
 8AmQ==
X-Gm-Message-State: AOJu0YzHUvZr/260Z+2UxvE34DYewS/TN8oa5Zfjrfu1rh+7iujtFt1G
 dFzqJzusj8obr/Bx8j3q4+J2vkJDIwa/XgcNT3bsuEhLDh21y0p/rLFDrL6UOEXwHywo+Jr4A/s
 8peOaIziNMmPENVhBcIcusF7Y5e63R+2EI2tQKg==
X-Google-Smtp-Source: AGHT+IGchpNugBXd0UWR0L4HfPB7rrrlfbTAhVXgZASVhwQPdfaEYxkablu0FrwKuJEfi6Bkh0r1DqwG91UEW5mupLU=
X-Received: by 2002:aa7:ccd1:0:b0:55f:19a4:e5f with SMTP id
 y17-20020aa7ccd1000000b0055f19a40e5fmr3378502edt.20.1706792500777; Thu, 01
 Feb 2024 05:01:40 -0800 (PST)
MIME-Version: 1.0
References: <20240201122835.1712347-1-alex.bennee@linaro.org>
 <20240201122835.1712347-5-alex.bennee@linaro.org>
In-Reply-To: <20240201122835.1712347-5-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 13:01:29 +0000
Message-ID: <CAFEAcA-1tG=xF5x=v8k-pMXwqmDuDjxJuarXj-Ao8S+DSGdB-g@mail.gmail.com>
Subject: Re: [PATCH 4/5] Revert "hw/elf_ops: Ignore loadable segments with
 zero size"
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>, Bin Meng <bin.meng@windriver.com>, 
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, devel@lists.libvirt.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Max Filippov <jcmvbkbc@gmail.com>, Marek Vasut <marex@denx.de>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Thomas Huth <thuth@redhat.com>,
 qemu-riscv@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, 
 Beraldo Leal <bleal@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Chris Wulff <crwulff@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 1 Feb 2024 at 12:30, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> This regressed qemu-system-xtensa:
>
>     TEST    test_load_store on xtensa
>   qemu-system-xtensa: Some ROM regions are overlapping
>   These ROM regions might have been loaded by direct user request or by d=
efault.
>   They could be BIOS/firmware images, a guest kernel, initrd or some othe=
r file loaded into guest memory.
>   Check whether you intended to load all this guest code, and whether it =
has been built to load to the correct addresses.
>
>   The following two regions overlap (in the memory address space):
>     test_load_store ELF program header segment 1 (addresses 0x00000000000=
01000 - 0x0000000000001f26)
>     test_load_store ELF program header segment 2 (addresses 0x00000000000=
01ab8 - 0x0000000000001ab8)

Hmm -- this second segment is zero length, so why did we create
a ROM blob for it? The commit being reverted here looks like it
ought to be expanding the set of things for which we say
"zero size, ignore entirely"...

Anyway, revert given we have a regression is the first thing
to do if there's not an immediately obvious fix.

-- PMM

