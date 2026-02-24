Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9330E9B24E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 11:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuqa0-0001cU-T7; Tue, 24 Feb 2026 06:27:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuqZt-0001cH-0c
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:27:45 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuqZr-0004h4-B7
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:27:44 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-7985fab9203so2124537b3.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 03:27:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771932462; cv=none;
 d=google.com; s=arc-20240605;
 b=gJh5swKomOcAeVHPzQVP9igVPtxt2+9uGtlY25Ez412LkSoPZnra2LNPn7LgP+nuah
 +LTbED12xMEFoMUBKaUPCiNuQKZhfDD6niiIc4EVc3howgfYmLrLygppFyhm+m6fypGx
 NGf/oI8oO4+2g6o8izYfpPozNT0wziV/+4hEpdVpmEKQFBzlX6L/+FIJVsQ5A7PXxGaA
 PM7cmmTctsaBHYLG6aD/AItntpVfu2Do/j+7j6PtAD2h9gyUlE6VeVLkGN5Z9zMv0y9R
 li7YD1DgmbKmE241KJWFEPBBVM1TzG8v21aMTMQ1waT9YwUDoZcI8IDWu5EAiYTcx6P8
 5VLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qhyoqlr1A//8H0iK825uIRfQeS9cOQDGExCUJTaMETY=;
 fh=66XzvMVRo7RtbCXWtk1MJcakO5/eQhTdrdK9epz7HXs=;
 b=HQgUvcc/IK/D9mdw9ZeEAIfVsGSd3Ky8TNNSO8osVnOxv5ro8qMRsVn2FAnAVv3HGc
 +BT8XUa2mpPnA0G3KDpYrX+Ox39VQUUJPibM4fl0kSu62VslTIdus8nGYjTW3JVLnIDh
 zj9dtZO9EvHzDgZ4vgxQohMVe5EgmscJ3UKcOlr/CdqQgzQY6bveBeY2jILHOvkYzzh+
 cQ9XaSWmilh9U/jSw1Tvq4PeBk5MSyUz8MShQ2tRq+WvnNlUf+vL56oo7xRHMrryrdgN
 XPORpRA0nc8orAF4r0W07tjTiktbMCeK7Fv08FvGCYZg6Ci9DHESH8cMhwXwUczwIUsh
 5sfQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771932462; x=1772537262; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qhyoqlr1A//8H0iK825uIRfQeS9cOQDGExCUJTaMETY=;
 b=dIy2oGIxZqQjqGUcbq4hENTaituCu4Hy2acvG7NF+C8zCPOnDCznHc1O6AlcX5IVT4
 RTAcpZzA+dnAXV4QuA7aESoW5Xy4Uj6R69mqa9ItVss2dzwN+HJiFWMfqZxZdSxAYYFV
 ma9toOvoY2DYr0gglXvvi7zHqyfeHQeqDGj6Gj3lXdJXL0i/a2frwKQXrGxwkNYVdj1J
 ZXk5rZWzaYXBI7mVIsb9kCOBeIj5hsm5eSyl3xJZAe1tOoUEAz9rq/Ik/4m/LblziTiN
 djfdT+QDpg8hJ9cMUm9KnsftbbJ6/f6l8GFBcaAoVMFipKU6OZzuj0Vgk56aQ/1eLbEt
 rcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771932462; x=1772537262;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qhyoqlr1A//8H0iK825uIRfQeS9cOQDGExCUJTaMETY=;
 b=abPME1EJALRUoHUAFVov27NmEahi+7670i2pAUkQMyhp5uYNAMkOLwbhAFI+JJmoh0
 OhRzuu6bZExyopdlGkNeYqr8CN492ELJ/KeULgeIEY2BZYE674cG4RRd97NDBVWf9bPB
 EyKAYTZ2fMEmNVcQ1ciDbgAqe7FOyViPpBFo3guvjIfWDUP4ffWSeLNBqEvn2xDJcTjt
 5wkKFWY/iSeE0pXTy7hPmxNeS1WzVEKZpJd7iYHZirVgQPhTm9yyNRHgFi/TaIGWB1Jj
 t/JUxuSwpFd+EpXgbb3QY2ANbtPFgiTD10pH1itzXFvH3aqrWl5gJOApnt2WmRYSQLDm
 Zh5Q==
X-Gm-Message-State: AOJu0YzCnzN3iRJ4dgPwBgVSwXPWb+TgcTnFdb55hRebWpm/vwDnnvub
 KHKzHSDfPE0YiBUYu9w4z7YlVAmA0Kx++FVAKFJLvb/78FyO+GcFK/6j9oOBolUDQKR6kzZCyp6
 IzFOS6lVAENtjH4+6OGrPzuiJ9gjtPLxsHHoAQsV+KQ==
X-Gm-Gg: ATEYQzx/+u970PSaUvuyOqUds7uBSTF3dGCeLZfHJ5Al2t4Ruwz2HDwjc8ls1i0pWJ1
 4XLJ1SxHPvCQJQSZ941wbWSSH67LffM1QBR4f1QmBZHQngHg1ZUAkoyKV/hUggSV3Ji3xrlJSWN
 b11knYnK8i3aQBrzLo3vBaw1cw9P9+2v3JpAxRwjgd9MS6TBnRtz0eRjAoy4DZxRo8n1fN/54Vm
 FMzA8hvVOI7vRjhn5AYdYo29lHotB5pzu0+fqIUUf5RDV5UFBJ5zuprbBvV4fplaKSntLRc+ixg
 j/39iTDMKbP+FryBKDal331huN4xJ1rVe48fx8O5MSaasqtrpA2BGsnKuXQ+OwgQp+4=
X-Received: by 2002:a05:690e:d5a:b0:64c:973e:874a with SMTP id
 956f58d0204a3-64c974dca95mr3067942d50.42.1771932462074; Tue, 24 Feb 2026
 03:27:42 -0800 (PST)
MIME-Version: 1.0
References: <20260212151258.1750268-1-peter.maydell@linaro.org>
 <327cf588-ba87-4bf6-a2d1-15362c77345d@redhat.com>
In-Reply-To: <327cf588-ba87-4bf6-a2d1-15362c77345d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 11:27:30 +0000
X-Gm-Features: AaiRm50VKOpltr3hnFpP3u4rvZAFHH_urfRYj-Wn9lZ9VtOLEIXbphMpioz3NTk
Message-ID: <CAFEAcA_z5sSx4YEkB4x=eTeoc+6L17=BfyhZ0_nXx+qbcciB=w@mail.gmail.com>
Subject: Re: [PATCH] tests/functional: Make sure test case .py files are
 executable
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Thu, 12 Feb 2026 at 15:24, Thomas Huth <thuth@redhat.com> wrote:
>
> On 12/02/2026 16.12, Peter Maydell wrote:
> > The top-level test python scripts in tests/functional are supposed to
> > be marked executable; "make check-functional" doesn't care about
> > this, but it allows them to be run as standalone executables to
> > exercise a single test, as docs/devel/testing/functional.rst
> > describes.
> >
> > A couple of files have got into the tree without the executable
> > bit set: fix them.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   tests/functional/arm/test_aspeed_ast1060.py | 0
> >   tests/functional/ppc/test_ppe42.py          | 0
> >   2 files changed, 0 insertions(+), 0 deletions(-)
> >   mode change 100644 => 100755 tests/functional/arm/test_aspeed_ast1060.py
> >   mode change 100644 => 100755 tests/functional/ppc/test_ppe42.py
> >
> > diff --git a/tests/functional/arm/test_aspeed_ast1060.py b/tests/functional/arm/test_aspeed_ast1060.py
> > old mode 100644
> > new mode 100755
> > diff --git a/tests/functional/ppc/test_ppe42.py b/tests/functional/ppc/test_ppe42.py
> > old mode 100644
> > new mode 100755
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks; I've picked this up into target-arm.next since I'm assembling
a pullreq, unless you would prefer to take it some other route.

-- PMM

