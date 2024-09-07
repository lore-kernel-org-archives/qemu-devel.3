Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABF1E71080
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 10:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smswH-0004pn-81; Sat, 07 Sep 2024 06:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smswF-0004oW-Il
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 06:45:07 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smswD-0003VP-Qz
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 06:45:07 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c3ca32974fso3370469a12.3
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2024 03:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725705904; x=1726310704; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1Xd3PKFM4efJH5S3QVxyi570ahY/mrT7a1uh8NV/TyA=;
 b=Jzj/24lQjP1rUYmjt2uxr48xoGgb+qccejJJ2zkNQUr1+APum4m4aOmfOhk9AknZHd
 VtMZ9N7YkZhNDM2mwW/XnmNR4DqgKAz1DuIsnigj5QlmGrAHHy5ENLMB6m6LnqssLCKe
 VZ5rtgZL8cuYSF+eBz6dzLz+labuc6x+Kxbc+kgc/IpA+65uxvqO8bAWQqdPjyjDyewG
 4xpG5IQZKN1mDn5wrIlX5vTpEteK+V//XgfbLBROheVgiySMjJXsyBPgzGB4RIwKbKkc
 H49RkLtFkXcvDwkNi2YD3QNyBMAUqKV9eFrvljhDAZ2b1ewjotJGvx1XtQJi5nLZMvDi
 SUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725705904; x=1726310704;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1Xd3PKFM4efJH5S3QVxyi570ahY/mrT7a1uh8NV/TyA=;
 b=r5R03yP8qKzRdOM5DwthdWkG+QWazOAZJ3vmJTRcRqqiLhLlHpzD0OxrAFjs9a9pYV
 wh4FAxH4LUayQPZgE2fX1VM9NGcp8bk7+YSVxfXY8VbvPbnF4JXFly7/zFTDsUWLgMGE
 zRWT7jQW8jIgc4nDLnC3iZaM+qikWTgIynGub+nIWOnOms5Z4PIG4PjfBx3iDHhWuqP0
 jj2Pldh6jfFIPQd1tcsX7ThAmrpnjW52WZ9hhsW8ROt2ikcM7m/rg2cbz1F1yw3UBADC
 zcVEDulIwNRoLLPUNxREzzQi+DJA9cF0HSl+ve7AlfzL5sFF3YLgw4Vn2ud6rx2xqPR/
 MyTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXG4Hp0MeEGuwYajQvf+svcoErXm0aS+Px2tdSaXWVldTgAAVnIUFcBLmUq8NuTcESpR5+TZEINT/UF@nongnu.org
X-Gm-Message-State: AOJu0YzbwTbOZVCivaoexQc1EH1UsKaz+AZHQfqvrXTiq41IbO1j1RjV
 0W0+TKTYzIP0hGh5/mTvUrbdAoyxnZiWWde3S9DE7hJyaqP2S3zBfynpS3s5O0mpxsfZFZBWi36
 eNURx8AL6okx6LSSYiLQnncWdy/OpoX4o1gm9uw==
X-Google-Smtp-Source: AGHT+IGVYzt4HDwKfd5EVKapl8NVnEWZYNlMLclQPYbXOJCOmj95G+QguoGK2CaxMaRhFtbcDvBrB/Ok5e/aDv06Vr0=
X-Received: by 2002:a05:6402:5205:b0:5c3:d251:e4a8 with SMTP id
 4fb4d7f45d1cf-5c3dc78c320mr3945328a12.8.1725705903794; Sat, 07 Sep 2024
 03:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7rcp8YkeRisKBTfV0nenk6WvsG2Vwsqnm+=B=KD6rHuSqfog@mail.gmail.com>
 <bc2ab18b-0e26-40c5-af01-98616fcddb2e@tls.msk.ru>
In-Reply-To: <bc2ab18b-0e26-40c5-af01-98616fcddb2e@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 7 Sep 2024 11:44:53 +0100
Message-ID: <CAFEAcA_-nV6zVq5Qo6XoF3gtnLNHaHBbMWJZOsUyrg_U=-fJDg@mail.gmail.com>
Subject: Re: Build failure due to xen
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Kenneth Adam Miller <kennethadammiller@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Sat, 7 Sept 2024 at 07:39, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 07.09.2024 02:59, Kenneth Adam Miller wrote:
> > Hello,
> >
> > I'm on commit bd80b59 and my host is:
>
> $ git desc bd80b59
> v2.4.0-rc3-9-gbd80b5963f
>
> Date:   Mon Aug 3 11:44:07 2015 +0100

Wow, that is very old. So the answer, in order of preference, is:

(1) don't try to build such an ancient QEMU version: use
    recent QEMU instead.
(2) build on (a container of) whatever the contemporary Linux
    distro version of the time would have been: QEMU at that
    time built on Linux of that time, so it's the mismatch
    between new host (system headers, compiler, etc) and old
    QEMU that is causing problems.
(3) if you must try to build ancient QEMU on a modern host,
    then you are going to run into a pile of more or less
    annoying compilation errors, and you're on your own in
    figuring out how to fix them. Some strategies:
     - if the issue is in part of QEMU you don't care about
       then use a configure --disable-foo option to just
       not try to compile that feature/etc. e.g. here if you
       don't care about Xen support then disable it.
     - look through QEMU's commit log and the mailing lists
       for the compile message -- often the fix will have
       been made in some later QEMU and you could backport it
     - otherwise you'll just have to figure out and address
       whatever the incompatibility is.

thanks
-- PMM

