Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874EFC52D6F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 12:47:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc2XS-0002nd-JT; Thu, 08 Aug 2024 08:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc2XN-0002U6-MG
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 08:46:39 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc2XJ-0008Cd-HS
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 08:46:36 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5b9d48d1456so1464247a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 05:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723121192; x=1723725992; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=THtfz5smtEuXCggefzqHd8zStXmWuAPSNqlMv6P9PW4=;
 b=IDmNeIm1AXZzGi2yS0YRgbIUAcRzJYVA2/GB5RCpNiSDg6VChH8hbbuz86eEIaDWej
 zghCQD+yPJjucfw4MO9VyXQJwv7mSP47ZcIz5BEa/Qb8sVJCnDA5pL8uPPaBzgg8SLQs
 nGih6iJjUWXzGEjQ4VyASNH66/RDjvabhDrGX7qozGKOk/LgtjMq4fmq7imYHll4H/D+
 okuQs0nWR9HchrP6NL+NYFaHzwLLaCxGLBLgZuQTWnVzGL9p5gSCBFeRFjsil2mFczXh
 XRKcopBPOkI8ceiLViNBxn1TaDD73ocaXBcH9xekBfkPzDFnNk6MId/lzYbk+iGBeCwJ
 CHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723121192; x=1723725992;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=THtfz5smtEuXCggefzqHd8zStXmWuAPSNqlMv6P9PW4=;
 b=eXdkwuawRw6aCYx60RK31MBfFsPTxBukJmcGJp5GngRPGVrYJxN1Ge0lSsmPGLF5lh
 j7XF59kRTPmCQYt+rs0nqMIqt0JZntMeYw1qLaAml5UUtmpkAaMz2vQyMg/NMAHcCy5S
 AoKO+8E5dbVoNyLW6jSk3DIahonJn7N6SiS/flXtbaoOsWpZHz4POdKrgTN0vfOs1fy5
 4swG2iCBJzEey9DVjSThWBMDc8zPhOfJNkZH3ukVO4Zd/BrYaYI4sL6oX/m73IF4ZPVM
 /Qu50lUxZxk4KKfKFFhMmueSB74qsqCcdPnhIhZeMyzrPfkS6czQFG2N//BZ0K3ZBGux
 uQjA==
X-Gm-Message-State: AOJu0Yxh0uh0WBp+Is4INlAhEhruahrKIrpK3UB6YMX0jpjWWQI/SOwL
 C4WC6hjGh8OdsEU+YXZughkDJs7YORvytrksv5IqwN6bRPO0sN3rhg8v8rFU2Z7sTfA93+ueIV3
 C/KkZ5U7hUdiapuOtRB0DDI25zdU2FcrG0Li3TA==
X-Google-Smtp-Source: AGHT+IGp0Jk6EENzWb7IF/Ap6EiDmNFT8SrIHCpxnR/O0+f0dmN+dXJXgytgNuYFxOxxIjLei8+BQOX5l9pmCjYUV0E=
X-Received: by 2002:a05:6402:50c8:b0:5b9:fe2f:48e4 with SMTP id
 4fb4d7f45d1cf-5bbb3c120aamr1558396a12.6.1723121191757; Thu, 08 Aug 2024
 05:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240801170131.3977807-1-peter.maydell@linaro.org>
 <b09d230e-de05-4cf5-84ba-75ded34d674e@linaro.org>
In-Reply-To: <b09d230e-de05-4cf5-84ba-75ded34d674e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Aug 2024 13:46:20 +0100
Message-ID: <CAFEAcA_Sp82-nbVHrmFPRgz0DTGt6Rd1rQBX-x3SQBMY8dhdQw@mail.gmail.com>
Subject: Re: [PATCH 0/5] docs: more conversions from txt to rst
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, Jiri Pirko <jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Fri, 2 Aug 2024 at 00:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/2/24 03:01, Peter Maydell wrote:
> > Peter Maydell (5):
> >    docs/specs/rocker.txt: Convert to rST
> >    docs/interop/nbd.txt: Convert to rST
> >    docs/interop/parallels.txt: Convert to rST
> >    docs/interop/prl-xml.txt: Convert to rST
> >    docs/interop/prl-xml.rst: Fix minor grammar nits
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks. As docs changes I think these are reasonable to
put into rc2, so I'm going to apply them to my target-arm.next
branch, unless anybody would prefer not.

-- PMM

