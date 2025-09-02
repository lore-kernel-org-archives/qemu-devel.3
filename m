Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB021CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utOiv-0006rY-Us; Tue, 02 Sep 2025 06:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1utOiu-0006qn-EN
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:58:48 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1utOis-0004Cp-IY
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:58:48 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-71d6051aeafso44542697b3.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756810725; x=1757415525; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yV+CNQks4sz0u20+BiRRmlFqbbFxD0ap07clOuus2Ko=;
 b=ph+OmknRK+frgXf73vmer7WNofAkn8vXCO9y5Mre8lF+/QuQmcBgAPaUgjiBeyAx+v
 J4ZCgM1O0+RCfQOnRlvAoKnRuv4H/FSrZM2ZJqLe8QM+QAL+UWo8Q+zX6YnLveJCwud9
 C/v4kdwEyrB4PwW/Q477tE/ne3b9VOXMd6/FTSFmUOd8ScALtM+Jil+oF3tt1khJSSPy
 BaHJ1zXnh3nJ3lpyWIwvYKlFfcbBdE6bw38UczLS6yOqg38bx3pDRNpgH+QfYFEZwGHL
 TNza3fUNihweQ/sf1L5420fNAIFakbxtZeeJ+EVaQtqBSWGgsj8jDV56aQQO0NncW2O3
 JMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756810725; x=1757415525;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yV+CNQks4sz0u20+BiRRmlFqbbFxD0ap07clOuus2Ko=;
 b=vQ8FdjjmNiVeRxKyZaKi3F7kOJaZGuSK/Mm4CB1Smw+R9dIhT9FYl8XC5QFk+HFvlr
 wYECNJDnokxrXtwfccSF6gaZqkCKd/aowV7XG/zuL4AKyETL70is6tM/5mZwpzj9ZIna
 rDryX0GCvQAwg8nX+OaAHrvU6K4HFuLvNYBud7KGX4GavuT8OhmwvS/b0a/G6MuJzMVH
 QMv1wpLbwkIG2HkQ+cV88I615UK1GwADUARCICcv+OnWcns1THYm2Ha77x/mw2cAjwUF
 VVPxEHS+BOXNrH03+DomlO14/jsCdPm++9qkNf1nNKal/cYbB9qCBQYq+IEV9L8WOd6M
 Leug==
X-Forwarded-Encrypted: i=1;
 AJvYcCURG5a8GjU8NrgGV0R9rF9j+ThApLH4mSX6aHV2BF8sZ5vD02IiWc7rxp04gt8wZxcd7LG5xXpx8A+L@nongnu.org
X-Gm-Message-State: AOJu0YxW8IPUE9CqPKCMMyslR0u+DBlQzPaCm3v1Bn4NYMy5umFREdTg
 VO8ekL6RetTYPe3HTi/31h+X1zgjdmkUasXfdcNlFQcCSYgtvmUjBefkKB8xj7ef/qw5PXkOW41
 JGXCKUoQiSA5FB5gW2dzaddyRb/qkAedM1N5dvinDBg==
X-Gm-Gg: ASbGncsqQp8jQB8ET0j4OfgkZuHBsOv2xtOJ7Gnz3EMeg3efQB36SMGHMLa3ImbX2hR
 QuR2Si0cwzbTrPTwFtK54zK9XmaMEXYTTIH6K1bE2/UnXPcsdtEXK2zoGbtMUvlV8SQwpcmolUh
 w/1DGmxe3nijDKfo93SN9XQowyTpTuzFw1LaSZ6HvH8gqVZ0oQgxnHS2Vjru/11Z7HN9jOkMaED
 tQhz1Uoj0nF7F3N/II=
X-Google-Smtp-Source: AGHT+IHA+Dfb4t8Rrkvv/8mnq+BNdIBrMbbHs2KvpQtXQLdr87wRwhzji9132Me30mr76kT22cF3DL96g105zS42HxQ=
X-Received: by 2002:a05:690c:7105:b0:721:318f:85ba with SMTP id
 00721157ae682-72276361f59mr105065627b3.17.1756810725149; Tue, 02 Sep 2025
 03:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250828162700.3308812-1-peter.maydell@linaro.org>
 <8e759fdd-5ed4-4e2b-9769-c6b072f52ed1@linaro.org>
In-Reply-To: <8e759fdd-5ed4-4e2b-9769-c6b072f52ed1@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Sep 2025 11:58:32 +0100
X-Gm-Features: Ac12FXzZ-3GgUycMvzRU8W_0jA9YjPaSqAoNS8lErMqUCxueZ8vrFPVSz4mwUH0
Message-ID: <CAFEAcA-Z9=gV-Ayu_9gD29H9+F3HZvLrtPxUxMv_c=0Y69yLTg@mail.gmail.com>
Subject: Re: [PATCH] system: drop the -old-param option
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Tue, 2 Sept 2025 at 11:54, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 28/8/25 18:27, Peter Maydell wrote:
> > We deprecated the command line option -old-param for the 10.0
> > release, which allows us to drop it in 10.2.  This option was used to
> > boot Arm targets with a very old boot protocol using the
> > 'param_struct' ABI.  We only ever needed this on a handful of board
> > types which have all now been removed from QEMU.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   docs/about/deprecated.rst       | 13 ------
> >   docs/about/removed-features.rst | 12 +++++
> >   include/system/system.h         |  1 -
> >   hw/arm/boot.c                   | 81 +-------------------------------=
-
> >   system/globals.c                |  1 -
> >   system/vl.c                     |  4 --
> >   qemu-options.hx                 |  7 ---
> >   7 files changed, 13 insertions(+), 106 deletions(-)
>
> FYI this patch doesn't apply anymore.

I think I wrote it on top of
https://patchwork.ozlabs.org/project/qemu-devel/patch/20250828162012.330764=
7-1-peter.maydell@linaro.org/
("linux-user: Drop deprecated -p option") -- the conflict
is only in the deprecated-features.rst docs. I'll fix this
up when I apply it to target-arm.next if the linux-user
patch hasn't hit upstream first.

-- PMM

