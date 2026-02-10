Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35736E94619
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 11:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vplhi-0000GH-Gk; Tue, 10 Feb 2026 06:14:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vplhg-0000Fl-KZ
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 06:14:48 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vplhf-0006Qp-5c
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 06:14:48 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-79427f739b0so56393737b3.3
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 03:14:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770722085; cv=none;
 d=google.com; s=arc-20240605;
 b=GnlLFFK0lPIq5jooMmAGU8BYcY8DUJMzc1HIU93miU4rrJcu4qF4RXrwBwj1kxpPoL
 +vDUQaFw3XVYDWdC98vTjJyNWuLIyphpXhHdDowrVnDHJPvceKUhgExr8mFum9Vu5p5g
 pgt/96WSaLfDUpZ3OKuxbI+513V0DxCjnqQLOvBKa3OaJJGVNGbCkRBPPkJ9Qmp1VXQV
 FFEEjlnAnp1ZzoqVUTbGyXPhjQN+JggT49CfdDzpmJhrMYek2jM2IoZk1wLJ8Fo8wQ/R
 aHPU8YWIiJ36/ZaHTDlNJ3AObGfVXJDbUqnOHWThF7ja/RCLG1vaSBf7ZINHPJIAiKRx
 F4LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2DCGukmM8r24pphdZ7HUQeUR+Y11ZrZOm6/lMJ/Hqr0=;
 fh=F+YjXdk2W4+aI0lwX3o1Zl54R5Mf09jK+RMHNXLxIVw=;
 b=lc0Qg5takBlVLTQx/rg5RQA5toOcET1S8pafz5W9hS7tyWr1Wi8L+6s0TP/0Nl6v4l
 BSSvZCfBba0kWQ/GdThJnKBsUXohLIgg+TcwZ1KcSJIrTY/AkmxW7Dvo6jtfvDPKpqzJ
 +tVzU4WLKyDvv7MMyJsy671Rkg0tCkgq2RuRkHBh2k35ucp8Onq9+jxcM3i8xemRmmYa
 FEd1lC0bXoLT6Mbc34O2x19sjpwupaaOe+a7+pjNukmrQEQhhITvWq8Xoa5HFeIaPMwZ
 UovpAs02KupjVzUxvVu5zukf/oYzd44ELV7xc5Cn/QrTONOAHB8FCr9AiCV3oJGRpbB/
 oPfA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770722085; x=1771326885; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2DCGukmM8r24pphdZ7HUQeUR+Y11ZrZOm6/lMJ/Hqr0=;
 b=t+gTD7xgQigPdEzlE7bnhnWjpziNW/8usIe9UFqjkUYbDZEHBUWgbsnJsTqCPuK5Sj
 5KmRITrgZYtRw2uE+XWhOkZjXhDlFyyx2T43toWS2nyX2MD1LctmEzLc7TEtwnpddh2v
 8V67VTIiu8ExwFGqAzfc1mfPLjN99dqbzUpVbvvBksArQedqJhD6KWfBl3t4j9WQJqYb
 dVR9wSx/Uq1EQ9QiAzyyvZdH3QeeSJ8rYFKqU1IsAsePgaMexFxQjUGy7D3xi5X6rLij
 k4kBcpYkxedHZQAD9vN5TwwFGJhCUbnPQ2wIUIrspLm5raIn3J0KaBTv4UtFSyy2XR2I
 svOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770722085; x=1771326885;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2DCGukmM8r24pphdZ7HUQeUR+Y11ZrZOm6/lMJ/Hqr0=;
 b=Ex0r1W1/4VlmGSthowLkLxgq7pEApDEpq5Z7oLQIWQYJerLmbTkauXZxRD5Ghra70o
 tkLN/ahB5q/1pOpPyE5Pf+ck7txU1u4Ax5Ud8rzSIwlN80kFup+0rux7q/KaiSb3o25/
 KIIXoKlmmifw/9e/Li9GFcDpymscZiyEXVy53NBLP7ftNTFw18CJx3wB+m6EUmABCesI
 IBMmk4faHLbYi7KHIXYGoBL/Ht60SSQs60fpMlJlNyQl/JkdJNbtgxUaqYalUZgL7XH4
 tUPDIEnMl9ei4n7KXHXl/Kkzd7b0E5tAqW4xXGsl0inATOvdQo+qUbrbnx8jWBkatmub
 ww4Q==
X-Gm-Message-State: AOJu0YzogIqLkGyTg4pHxGqKkVo6pojczCndKt1DTp7Dx3evL6pqeCum
 TmqZXT9XqvUOrj7rJWaEca3DKjvH2M3GB2fjxm+32DYVUmtEEcssYvNy5SvLIX7XpCDokjl5bON
 ch0bT+HFpQEIyHtzpyaIhj6/REBovm/ZK1FQ0Of+fIg==
X-Gm-Gg: AZuq6aJAiAte6nLDdpfwOGDr1aWRmjnt8b5dxI4apyBURi6Lqp5nzZ+IYrPdgDc60d6
 hrEZaRX56kdxKHyK7T6ZC5L/TAuPS40W4c/YIFGot5dH+gHj2rMZVLOFqNizKCGOCMGRbmZkBf5
 leMV/R5tp1VM2j/KT/xPrO0Bc40dcNDsElqQB37KKapA85fX50UPOKah/e4YcHwJvNL4KFLPdbW
 HmP3oYx9oc5GSKbiEwmVPmm26Kpgh6n2KJelppfhGbTkzdlaogVwOUNAH4Cl5FJ4gBOvLIy7mzQ
 mnaBIvZlKIVqlAFgHI0ks1NcGxV/0+dtW3Z83b3Pyjinu8mDXWdZi+fWv7X0Libr+sE6G1p0rHL
 KKA==
X-Received: by 2002:a05:690c:39f:b0:794:eb40:6745 with SMTP id
 00721157ae682-7952ab7ea3emr146076767b3.63.1770722085162; Tue, 10 Feb 2026
 03:14:45 -0800 (PST)
MIME-Version: 1.0
References: <20260206214448.22008-1-philmd@linaro.org>
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Feb 2026 11:14:32 +0000
X-Gm-Features: AZwV_QgJvPO36dyNCYobaltcQTSKj69S9JsoDO_uph37oSEpDTYLuFizrRm28Hs
Message-ID: <CAFEAcA8Lx=s0hRwm-fYUwQA82C=rH+VTFdhFZisTRHM_PqyZBg@mail.gmail.com>
Subject: Re: [PULL 00/30] Single binary patches for 2026-02-06
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 6 Feb 2026 at 21:46, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> The following changes since commit cd5a79dc98e3087e7658e643bdbbb0baec77ac=
8a:
>
>   Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst=
/qemu into staging (2026-02-05 13:54:50 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/single-binary-20260206
>
> for you to fetch changes up to 5cab4bafbb8c635c7db6ae1cff8660f83b547c02:
>
>   target-info: Statically initialize target_arch (2026-02-06 22:37:54 +01=
00)
>
> ----------------------------------------------------------------
> Various patches related to single binary effort:
>
> - Reduce RISC-V Boston tests
> - Prohibit target_ulong / TARGET_PAGE_SIZE uses on s390x target
> - Build target/arm/arm-qmp-cmds once
> - Forbid legacy native endianness & ld/st_phys APIs on SPARC targets
> - Forbid legacy ld/st_phys APIs on x86 targets
> - Rename OpenRISC -> or1k
> - Avoid QAPI parsing in target_arch()



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

