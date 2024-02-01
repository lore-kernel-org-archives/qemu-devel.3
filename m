Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064DDC4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 15:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVZ3X-0001BO-1A; Thu, 01 Feb 2024 10:32:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVZ3U-0001Ac-MJ
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 10:32:44 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVZ3S-0000YP-32
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 10:32:44 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-55fd5f67f03so391338a12.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 07:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706801559; x=1707406359; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WsoUwEALHq7B8gB9DU1dIA7qwIyGaTKdLCFV9qa/3xo=;
 b=ZJHQlgelsIAvAgXXoChxevT40sHf0TWpWcbb8UqOAAVIDKR4Asj78/4ts1Atv6t+7M
 A9W5NjYqEOXcZEBroLGxkkTEv9qf81fDCczGhU7RmwMkvD/ENCxNOPwjiZevuFpELSLG
 rgWpQnz1kyRE7jH8GjYlAiUVIi3l8AkK1/VrdgYWi09f31+//YeC6SoV2542xWrV4wA4
 /WFIvCJFNlLwdoD7rIpw3tTbpgu9rdzD32MEa+nRhRir2b2EJWEkLQwpBvBd9EaJFWHK
 jh/YOBIsnPEuMRshU5MkezZjfR/+Vx6Py+UDdiu8QSe/xG0sFTXhiKf+OpixLbbdLhIn
 kC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706801559; x=1707406359;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WsoUwEALHq7B8gB9DU1dIA7qwIyGaTKdLCFV9qa/3xo=;
 b=hGXJfjEKE4sLG8vZR6gV3U5vTi07q383Nvxws8qdMVpT9U31GhaDk1VUbLIWhBUKiH
 +SB1FHj6a6Fr5hT5UXrEjBV4X23eFK9wvgmH8hwdrPeLEy7UxV0ND+x07N75YJmjMHSj
 NEBEmEOEsJPbQj42KTqQJaGZOCdn72E/QgCcSF5U5smZ5znaamtZDmNset9pSblL4Ptp
 TCnJCN3lpbYcOhaVy9IKEX5UkPJ8+Cu0AgP9c4RNqqRjy8kPb5MSew83nIVR4mC5SgE8
 Qiwlwh0QUZv16blpeCTD9hHG2gDUUlETBg20ElGSUlWefS09Hxv41hNKUwaOjrdlOrE/
 M6uw==
X-Gm-Message-State: AOJu0Yycy9/z91LOITBGtKxZDBFzAkE6d1VDL7k5AdPHEr5vCnlkS151
 qErwIGVNLSgF83dgYGqht9w9vY6JLjO0E3npK9Oluij8+ctMBbmbcWv2kgY9f5Ibz3pnDzWwkKi
 edtHlfomOu1VMqdNmLODaLQ3o9r3QD16EaJslHA==
X-Google-Smtp-Source: AGHT+IHW7Le85kaxj4+EHVKpUped2iKIJlb43JDA0GFBgFolwqLB6DTDKUIIVgF0AQFtmSkdRdtFxr7vCyFKq/RFhQg=
X-Received: by 2002:a50:ee1a:0:b0:55f:d726:43e4 with SMTP id
 g26-20020a50ee1a000000b0055fd72643e4mr384148eds.8.1706801559636; Thu, 01 Feb
 2024 07:32:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1706544115.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <cover.1706544115.git.manos.pitsidianakis@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 15:32:27 +0000
Message-ID: <CAFEAcA8E4UQ_DhcHPgx5zcWi6uhkoxR6_JDpvoeX9eyXvQ35fQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] hw/{arm,xen} convert printfs to trace/reports
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Mon, 29 Jan 2024 at 16:10, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> This series changes some printfs to use the trace event framework.
> Additionally, it converts some error/warning reporting fprintfs to
> error_report/warn_report.
>
> v2 -> v3
> <cover.1705670342.git.manos.pitsidianakis@linaro.org>:
>     - addressed Peter Maydells's review
>
> v1 -> v2
> <cover.1705662313.git.manos.pitsidianakis@linaro.org>:
>     - addressed Alex's review
>
>
> Manos Pitsidianakis (6):
>   hw/arm/strongarm.c: convert DPRINTF to trace events and guest errors
>   hw/arm/z2: convert DPRINTF to trace events and guest errors
>   hw/arm/xen_arm.c: convert DPRINTF to trace events and error/warn
>     reports
>   hw/xen/xen-mapcache.c: convert DPRINTF to tracepoints
>   hw/xen/xen-hvm-common.c: convert DPRINTF to tracepoints
>   hw/xen: convert stderr prints to error/warn reports


Applied to target-arm.next, thanks.

-- PMM

