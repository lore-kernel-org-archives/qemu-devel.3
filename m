Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BA3C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 17:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX3CQ-0000rA-BP; Mon, 05 Feb 2024 12:56:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rX3CN-0000o8-NA
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 12:56:04 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rX3CM-00034s-0I
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 12:56:03 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-55ff5f6a610so19753a12.3
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 09:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707155759; x=1707760559; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v6cX1jta8LYnNqITdik8IW67rhGxFWo19bWstzfCB0M=;
 b=uAR10LDTPA7YCuE3q+zCePumrE4MuiCv5+x8N6jhGUmEfL78yPlUDHH+YtCI50l9wl
 SXRxLo5tMFPLP0EqHxvJWYnt5M+n3awkW248F4qu/8C50TkryMjmndCWSTQaOFdBNnwk
 7e9bZi8rN+d9ZsLgk4vxql4grABB9pesIUddj85McZ39KL/e0OuP9OGTSMGNjs7lcKZT
 5IFUFzBlxAZ4TzQyUGr4rt8dxH2VU38OciCcXlYEwpQb+IxDBgfjUxQK1I0WDufuzpPf
 heO3EVGPjdVWYsEuo027B3hsChJ8Dr0KDSEOxLxESaVOu2Of1dkCyTjUQ4/YB/kFFaug
 OURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707155759; x=1707760559;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v6cX1jta8LYnNqITdik8IW67rhGxFWo19bWstzfCB0M=;
 b=U+skmQnj7oclWyv0N93oCSvfMxOsQ8ZcyiQYqkxdLhN6O24NhRL+jsvy9u5tXC9hhC
 DWt+ghFeK61mgI2FSi89cD+LnElE2/rLtunGZbl3cLak9fPWVMJB+VhQL2xOaFx9H2EE
 B0Wweik9OQ92OGvIV1SjkWbdpLHrCb4ydH+l5SGrFftzWNrFxS7QH5dFL+yvSpt2C3/B
 uMRT/+phCxgmVGKmSWglSpxhxmKFeVac/V0qr9CoMxRziR02yyTb6cBVHdA/yBvfDoVm
 aL4Y86sbUUnr/KqN6f9xCP+Z1ttzXr5N0ddAvZAMWnOyQBfrbVVL2rPzlIPQfLIYJvKV
 ImZA==
X-Gm-Message-State: AOJu0YxgjvQklvuqZKnJ1Ss0qsKD0nVxpFLexQ3AP2TZUwg2BdXLQeB1
 Dlr0xRvdgqqd+DSBfolGuCbq3wV5Lhn4QBnlIyDeC63ebkqSCgoHV11pihRTEpWiFcDxTZ21ePV
 RMWt1oi0OH2OUjMED+pVQrlryAuMNL92VmSvpdg==
X-Google-Smtp-Source: AGHT+IEQrHcuJHdsGgtzVnEDzhGh+4X0iTCElHDwwdDlWEU4vXHxgznr/U04ZLa3/QdU4o4vlGRHXA4mcjKqB6VpTqg=
X-Received: by 2002:aa7:d308:0:b0:55f:6b8:b304 with SMTP id
 p8-20020aa7d308000000b0055f06b8b304mr45268edq.8.1707155759167; Mon, 05 Feb
 2024 09:55:59 -0800 (PST)
MIME-Version: 1.0
References: <20240205171819.474283-1-stefanha@redhat.com>
 <ZcEdrp-y5YFsfir4@redhat.com>
In-Reply-To: <ZcEdrp-y5YFsfir4@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Feb 2024 17:55:47 +0000
Message-ID: <CAFEAcA9-DUEeVPU9_G61OELNw=6DGax7RiahjC9YeKA=SgDvnQ@mail.gmail.com>
Subject: Re: [PATCH] docs/style: allow C99 mixed declarations
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Hanna Czenczek <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Mon, 5 Feb 2024 at 17:41, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> Rather than accept the status quo and remove the coding guideline,
> I think we should strengthen the guidelines, such that it is
> explicitly forbidden in any method that uses 'goto'. Personally
> I'd go all the way to -Werror=3Ddeclaration-after-statement, as
> while C99 mixed decl is appealing, it isn't exactly a game
> changer in improving code maintainability.

I definitely think we should either (a) say we're OK with
mixed declarations or (b) enforce it via the warning option.
(gcc -Wdeclaration-after-statement does not appear to warn
for the "declaration inside for()" syntax, so we could
enable it if we wanted to fix the existing style lapses.)

Personally I prefer declaration-at-top-of-block, but
more as an aesthetic choice than anything else.

thanks
-- PMM

