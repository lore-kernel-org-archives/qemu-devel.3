Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676F1CFC51B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 09:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0H2Z-0007SJ-5i; Mon, 14 Oct 2024 05:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0H2B-0007Pz-Rb
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 05:06:36 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0H2A-0002qB-4H
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 05:06:35 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c9693dc739so2143050a12.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 02:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728896791; x=1729501591; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SY5qG+TiL/yKi41D3yTwJ1dG9plAHC1/64Uh34vWdrc=;
 b=jecmgTv1E9rLt/UCKzKbN7rdNH69B6iOj7qG4iFfn5bpC0WoYhID0H627Gh/dxhgOy
 82OC29rWsrZqggr/MyqrzaMAarSTlr8Avaqg88dATegq7lg4guW6T0+5DOYj5GOvhDwk
 w2iqWlZjADUxYJq33SCkqI7UhA4629jA6FMRVfNQbCwNurOyPw4tTraB3tiatqJkk39H
 1DdN1dKD9aq1n5QJ6hGLPlA53MgSejO9vkNSReWiowjmR5sjTJlLjkz4zAwAF1zSgtlJ
 nXiJPnXsRTas8XoXw538oRVqF3MKMyzBEHxDy/n99kQ4iMdKyoyqNnJooI6Cnq737Bj9
 RToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728896791; x=1729501591;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SY5qG+TiL/yKi41D3yTwJ1dG9plAHC1/64Uh34vWdrc=;
 b=Bdr7kC1AcpcFh49/NqlQp3Hj7XSuLpWk3mCroUgKQmRjyaFzFsa3huFej6syBX5KwB
 HAGfAh4U8/nO7Hhg6rxujTj+Vabza0AyKN6BUwyw6GqAQZaTRuZclWxxi0FVpdV4oghm
 2PQrlTEv5hq/eU3whv7CtqDzgylRyfrxwYFu8RO31rPbWZEnUVAOwGgsyULhrlLUYd91
 gMeRe83agMgiKY4y18+N5QVDbO8LDi41b6kc/BQcMKtQYK1NIaIlD1tqR05XnW28BS1f
 ZKeHvrERCVBdXa0Qr2GhTEfaukiDmFjmO5AjTOXG7oPSWinXOszJGSpTCLDt8RCZ0UiF
 G26A==
X-Gm-Message-State: AOJu0YyebRYX9gfG0cqKixAcW9osS2+Wtn88MttEfNVrucKJpCQY74qm
 uMAxAVkNR+0HUgFJrxpqPcwpoGNI404ThNIpllfhunsimu9v9SAyoj6cBmWNIUW386QFO1Gz1ma
 v4UD6PsWBNj1IS4rco/+Doaf5jtEOH94L7t1JcWwIrT+JCiTQ
X-Google-Smtp-Source: AGHT+IELsUe7KPyRt+rDxxb/Qm2GHxsIRAW5BqDtsqqnckI1sc4foG6GgsSqJ/qmbMDl8+2juB5GK32/gY7lV23OmGw=
X-Received: by 2002:a05:6402:270f:b0:5c9:85dc:5b9f with SMTP id
 4fb4d7f45d1cf-5c985dc5d75mr287741a12.2.1728896790726; Mon, 14 Oct 2024
 02:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <CA+rFky6nRpHj8xKa7Wnw_coe_gbJoSXn61fc87-w0Z_7V-aBPw@mail.gmail.com>
In-Reply-To: <CA+rFky6nRpHj8xKa7Wnw_coe_gbJoSXn61fc87-w0Z_7V-aBPw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2024 10:06:19 +0100
Message-ID: <CAFEAcA_-ncUdRTO+CpFCf44OY6toTBWw8-5y5zbnr3PSfn2sGA@mail.gmail.com>
Subject: Re: ALSA support in qemu-user?
To: Andrew Randrianasulu <randrianasulu@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Mon, 14 Oct 2024 at 02:13, Andrew Randrianasulu
<randrianasulu@gmail.com> wrote:
>
> some 8 years ago this patch was sent  to qemu-devel:
>
> https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg05333.html
> "[Qemu-devel] [PATCH 7/7] Add ALSA ioctls"
>
> I wonder why it was rejected, may be as part of series?

Hard to say from this distance, but looking at the patch
I think it probably was just that it was on the end of
a series that did a bunch of other things and the earlier
patches in the series had issues.

thanks
-- PMM

