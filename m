Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887DEC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 09:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdS6K-0008La-V4; Fri, 23 Feb 2024 04:44:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdS6J-0008Kx-Ty
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 04:44:15 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdS6E-0001Uc-Qf
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 04:44:15 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-564647bcdbfso545306a12.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 01:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708681449; x=1709286249; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6XGxrLa5sW5SMtNskCL4fFQeVIwLt2ZkORTFwK4N4I8=;
 b=pTrdbpZeFT8385AVqcx9azjBY5WzV6cnxpqgQoA/xXmRicB2eiGK8+z8BT+KEtEhuG
 c8Zf7YF+D7RKd/bzEh7RvM/nkxT6aSnEPlnhcd81dZAwFPOQRXPMiGnfBW76UARAs4I8
 DSsyOKA5PmGB7jsO2pjncw1rOOupocJsC0+L075See9cU0hSRdUi8aCjoq+dv7gI8z4/
 ePAqZITiGafCZx8ghzbEAUfl4V3v9iWlH34pwqwtNkd/zInp7UHa2soSDlDDTFBaclN7
 oolPchJ3UR3S+zontGS2wyAEqj6CbgBss6HXrMl9V+beCSNLaM41+fiO7QS/52fCeZQm
 n7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708681449; x=1709286249;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6XGxrLa5sW5SMtNskCL4fFQeVIwLt2ZkORTFwK4N4I8=;
 b=EgZG5rX+30D7F0VtgDMp48jzfw2+AOo7eC3gilApzuU0ZQZ+j9BJ34nszdCq6glMNa
 8FV3p3hPb+WKcrrCDfTIRKOAHypxnEWpGyeoijLsTBJL3WcY3i0O2aXUk1X+y2FnhFMU
 pZfQas1iwoSQ790GKTuPCa4+O2JFtifkDhzwWutyAzI18E0uICBolLvYuRw5eOmiUkZ9
 lvPypzomItpuK3zq2N+/2mXxqxzsCIliPXu6JpH3B6X1SLPAPCMsfZTek8Kky7o4yNWU
 szBVsJFXQUkDo8M3gxBbyGAvSXVfFMQg9CqzRB6VvzhgaHxJHYdrThWjAS86IRuNZ2Rf
 USOw==
X-Gm-Message-State: AOJu0Yzp4zEeynJ3w495f6ujehwi9fBgHlZdVvcZSGDHOsBwVpUxEwZ2
 TiHnP1GoK2CbYRWTwUknnkEy3z6vmnHAoh10Wp6P6fKQsBfZfofEGzvkZTiJ3ty8IPBCWhtC/3+
 9p7UmcPCDBFZBn1lNmzHBxMThOinib4MWSsXzYg==
X-Google-Smtp-Source: AGHT+IFcejkm0qq1pA8W/tPEjMoe9PcwEJqzk+FkHFSrsEiqeLPX8tMuM9iR8LqIn6n487WlbcUaTFGGhALa2fr7nq8=
X-Received: by 2002:aa7:da57:0:b0:564:7962:4545 with SMTP id
 w23-20020aa7da57000000b0056479624545mr868392eds.15.1708681449020; Fri, 23 Feb
 2024 01:44:09 -0800 (PST)
MIME-Version: 1.0
References: <20240222125517.67131-1-philmd@linaro.org>
 <20240222125809.67291-1-philmd@linaro.org>
In-Reply-To: <20240222125809.67291-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 09:43:57 +0000
Message-ID: <CAFEAcA-+3-zt5SOTTrLnyWh8maDLE2QFR9S_eXOCQ071qyXZqg@mail.gmail.com>
Subject: Re: [PULL v2 00/32] Misc HW patches for 2024-02-22
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org, 
 qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 22 Feb 2024 at 12:58, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> The following changes since commit 760b4dcdddba4a40b9fa0eb78fdfc7eda7cb83=
d0:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into stagin=
g (2024-02-20 10:11:08 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/hw-misc-20240222
>
> for you to fetch changes up to 7164f7e4028ad3b01a5f98c27482587b401ad420:
>
>   hw/sparc/leon3: Fix wrong usage of DO_UPCAST macro (2024-02-22 12:47:40=
 +0100)
>
> Supersedes: <20240221211626.48190-1-philmd@linaro.org>
>
> Following checkpatch.pl error ignored:
>
>   ERROR: Macros with complex values should be enclosed in parenthesis
>   #62: FILE: include/hw/ide/ide-dev.h:31:
>   +#define DEFINE_IDE_DEV_PROPERTIES()                     \
>   +    DEFINE_BLOCK_PROPERTIES(IDEDrive, dev.conf),        \
>   +    DEFINE_BLOCK_ERROR_PROPERTIES(IDEDrive, dev.conf),  \
>   +    DEFINE_PROP_STRING("ver",  IDEDrive, dev.version),  \
>   +    DEFINE_PROP_UINT64("wwn",  IDEDrive, dev.wwn, 0),   \
>   +    DEFINE_PROP_STRING("serial",  IDEDrive, dev.serial),\
>   +    DEFINE_PROP_STRING("model", IDEDrive, dev.model)
>
> ----------------------------------------------------------------
> Misc HW patch queue
>
> - Remove sysbus_add_io (Phil)
> - Build PPC 4xx PCI host bridges once (Phil)
> - Display QOM path while debugging SMBus targets (Joe)
> - Simplify x86 PC code (Bernhard)
> - Remove qemu_[un]register_reset() calls in x86 PC CMOS (Peter)
> - Fix wiring of ICH9 LPC interrupts (Bernhard)
> - Split core IDE as device / bus / dma (Thomas)
> - Prefer QDev API over QOM for devices (Phil)
> - Fix invalid use of DO_UPCAST() in Leon3 (Thomas)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

