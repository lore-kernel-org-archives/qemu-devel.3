Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62616C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 12:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVWdH-0003Ro-SP; Thu, 01 Feb 2024 07:57:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVWdG-0003PF-Bb
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:57:30 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVWdE-000876-QB
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:57:30 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2cf595d5b4aso12660371fa.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 04:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706792247; x=1707397047; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tf8h3/gbSdNJTpt3E/ws1mjedr29y2lcAd5CCf0+6e8=;
 b=nLlwPU2lPjjixLEYqYkVA+OdMfjcasHj+a3wQgvNm7kaAdJNv5Iv8XdaDCcgqm8jXF
 nkfMabxDX1awW2kTexysit2Wi1dcIqn3J19dt9MDxTK2+hNLQXTzcdERbZKBowQjKOTb
 22jgVYORqTth+uWXBz59Wf9cPFK6daqc4E9YBhCwDC16NQcNkHv3NaSgFwFVdN/5ArlY
 qOg8pgBqAahvK7814SoCfaC+XHYirj8GjJfxMnoQCBtd5edyL2BXnoW36GpbEBjX07Yd
 JpPvPk+kot+HbV9FC4kj4dE5OGp2mb1P+1jo3gZGVSRPOHn1YrxErT0VevsSXvmyXC5m
 pVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706792247; x=1707397047;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tf8h3/gbSdNJTpt3E/ws1mjedr29y2lcAd5CCf0+6e8=;
 b=XZRPmvr05qqJVDqjQaucwen87cpO+4GTitwju+kelcJ6jHqfnqxbWzvrjhYNWvFNB1
 7sxnmxRWvGRX3BwVgQ1lne9oJ6FK97FDUi6zTj7BaOVxqBrZmqpnRx/zGoKbPXtIs/HX
 s2Rvn+xD/FT8WlC8Z3D48MXheRvK49q1sDANZhyCk51HBbpZce6FtBE9o9k1IIJBCCr4
 +045+HY8IO/XpiMirSTTyoOl3QNm7VcEc3UsHCj+Tc0Jdnx1iefv4zLAQ6F5sFDeYA+e
 zjoYMEq2MX9M15kPSb7GLSRwrLr9GNnjF3YEfQciv3jOW4lDB37oRat/u7D+mNOE49Sj
 537A==
X-Gm-Message-State: AOJu0YyLLubxJgYyR9/vaHku6g543LenIScTEAaZ4nODqpt5ILdb6SfT
 JNywOG4mLPJPfmRc5eh13TKo/Uf8TeKW0wxJKU0eW79w8fCCBMVgQSAt/Dx8V/cBYKef6b0MfFA
 3mOdBkMSFkecsw/OyEN50BTGDq8xXwzcTZJpJCg==
X-Google-Smtp-Source: AGHT+IFQvoV9R2p/LXDg5qfKqHI1FsFopWTKT6MFILKjKRWvHRSZ7UGjw2vSBotpdjD6GmnhJOsW7JFXQPA1ghK8sFo=
X-Received: by 2002:a2e:7a0a:0:b0:2d0:5d79:7438 with SMTP id
 v10-20020a2e7a0a000000b002d05d797438mr1170968ljc.52.1706792246778; Thu, 01
 Feb 2024 04:57:26 -0800 (PST)
MIME-Version: 1.0
References: <94cf974b-05ec-41c2-8d0b-43ffbc8bdeac@gmail.com>
 <904ef958-0e3d-48da-a4a7-5c1514c04472@tls.msk.ru>
 <e441b771-0a08-4f2c-b7a7-f6fdd787bc1c@tls.msk.ru>
In-Reply-To: <e441b771-0a08-4f2c-b7a7-f6fdd787bc1c@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 12:57:15 +0000
Message-ID: <CAFEAcA-C-pGGYY1bfE0ZatZP-imGmq=4-579TEnEZWFLeLxZLQ@mail.gmail.com>
Subject: Re: building qemu on a system with libxkbcommon installed but not
 xkeyboard-config produces an core dump
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Zhang Wen <zhw2101024@gmail.com>, qemu-trivial@nongnu.org,
 pbonzini@redhat.com, 
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com, 
 philmd@linaro.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x230.google.com
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

On Thu, 1 Feb 2024 at 12:50, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 01.02.2024 15:11, Michael Tokarev wrote:
> > 31.01.2024 11:13, Zhang Wen:
> >> With this patch, qemu requires keyboard-config when libxkbcommon is found on the system. So if the qemu is configured when libxkbcommon is installed
> >> but not keyboard-config, the configure stage will produce an error message, thus avoid coredump in the build stage.
> >
> > I'm not sure what you're talking about.  What *is* keyboard-config anyway?
> >
> > On a debian system there's no such thing.  There's keyboard-configuration
> > package but it has nothing to do with that.  It looks like if we apply
> > such patch, it will be impossible to build qemu on debian.
>
> Aha, I found it.  On debian it is /usr/share/pkgconfig/keyboard-config.pc,
> which is a part of xkb-data package.  And libxkbcommon Depends on xkb-data.
> It looks like the distribution here is wrong, there should be no libxkbcommon
> without xkb-data which includes keyboard-config.

Are we talking about "keyboard-config" or "xkeyboard-config" here?
The commit message says "keyboard-config" but the patch itself
says "xkeyboard-config".

Zhang: it would be helpful if you could tell us which distro
you are building on where you see this problem.

thanks
-- PMM

