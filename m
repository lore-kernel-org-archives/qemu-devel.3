Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF1AC79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3ZAL-0003WC-3C; Mon, 07 Sep 2026 09:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3ZAJ-0003VR-Np
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:13:39 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3ZAH-0006Lt-Rx
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:13:39 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-86b03b75fecso52931677b3.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 06:13:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788786816; cv=none;
 d=google.com; s=arc-20260327;
 b=QkX69Mg/x8GSMWgsr+5FaUQ2Ik4vQGuSJTJQWwf+TSCLXsJ7YRrFGWMa6e1H1/bbcr
 jhjXQpxIVl/QBI4aqLg0oK2Kwf6Ik+YzaIIHqExKvpU4OHF5P+2fY73nha4JDqbR7zgp
 Q84TQYGSFAjafEKMESHjZCUqtEmpvgeOIvHDfdpqqJz/SvlGSUgwx+OuG6rtyo2dqqVb
 M3cnMKsnSBSRUI4twKbYuLU/F0BamABf5gBTgNPGoiNKsI6lwsxaGVVi3Kuur/N0NmL3
 QoRsVzYh39aNXBZ4pvQA2wkyXO2Zf+/Cny00QV9Ztms3Bpcqohb+nauUMIChnoNqO8KM
 TaHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LsKQwT92CuCF79ffYthOiqkKtA8Wza8dgn/5EiALA30=;
 fh=rBzcapTpLWFxB/fEXZxkpeUVM3G42KIP5PG5bvNHx2s=;
 b=lHHTXt+97/0fZ0Wwa3S4DGSIh1opREdgxPJqhKmX+URb13gmx23+ZVK2ljoVwHLAFr
 Syt5A5q/j67+H432oXej7+vhJCPqoia/vRSRuPekmE3mv/MOEAf0ziCnLMOM3YxMa9H8
 J6aEYnY+fwaiscNohkoeSb4j8ZzKAtkGN2m+Xro/Nv0Z0MBreGKlnF9ktlpUSQeLlP4J
 xng9Y0ldEgGOfEiFzd4CfN9Y7Kr8pfZ5lbGoOtR01lJJnlEZdPOoMWRDydYKGNwzkQmu
 tOitbWpq1HKPbRYj2k4csGe9nQlC9/zD/D8BeuEvtE+/wyCugLNA374Rk8aVVE7NXI1O
 QyBw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788786816; x=1789391616; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LsKQwT92CuCF79ffYthOiqkKtA8Wza8dgn/5EiALA30=;
 b=zWi6LrBz/8Qw2G7wfN6t+kG9TinJfb9yQyf9tz9FIGW/FTdk2d1fY/f2ASfNJa/s5p
 s42uD+d3/g53rhX+4jY4tbsTIQxVkFah9pX4ZS+B6i7kbsvbQ/tUMNYPQpC2upwk5/wm
 E7kGapx84opDkkCGmdo6mqQWlgjJMFTFU0hBQMpWYZicz6mVDoc75qJYgwweDaCxtFVA
 m/bP06jkFO3yB/nGtO2i9TjQ9Bxdymj1I9hgyAl1va+ffP4x8orLvtT7DTjDUDMci7bV
 OUCfSaf+ofmjGiSte1X6hMmFSoBET9tf1Fafl7e5KKftBnKQpzhkxvxWQ4DjEIiPiuNJ
 aXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788786816; x=1789391616;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LsKQwT92CuCF79ffYthOiqkKtA8Wza8dgn/5EiALA30=;
 b=gi4ouXPWQLMO8AYgFUlektY62ZGX0jw07N5dKIxIvBLcR5lO6d73nGFLl2qKTdgGIl
 KcOzcqZjg2jpcrH29oMz6cWy1K2/8G2y7zaTuq7PELRxCE0MOrVFkaM9EI2Kyho64GMb
 D2icbXb0Z6q/D87WXWTkq4Izit+5PQjV+vgClROc6gRrGoNtk+FPj9WWw5FZTRU+9xaz
 dBNx9Q9AuwnaKVQ7tdqdvOYFmnk8z0PSoS/MFkpFClQmzjX10XxrOYlqeYddDFSq5teU
 YAgJoesIMlsu3mgHMCuc67kXjV9d5+U/k80+hz1uvG8NAFetZyl5Nim3DqQDc4LaPQRJ
 /vIw==
X-Forwarded-Encrypted: i=1;
 AKwUvByeRVWcnpcSzHyrY9pdcIxQxaHr0Yz2usodRjcVVKhvtmt1/GE93nkHcAKdyHe54peSqWrSt3oeIaB2@nongnu.org
X-Gm-Message-State: AFuF++kEf7oZ4Me9he3f9tr74/x2zgzx5VNmiDgX81fLVOKh/yM78IVA
 E04LGib9NUnEHaGT/XEva/9aayBdHagwh9jsQuGUqOs18St6OeE0YfZ5ccYyhBhnRv4Wh9e3rEF
 ibzOlxTJ43cUpyQukuCUd2eip8WWMofIQL4A8YjSOBQ==
X-Gm-Gg: AYBFou3GMHdN2l/lkFjJyzhuL8T8EeNXQiWZXxu5BovWB080IY4lNkJzDsIf9GVNv6V
 MfbiAp1MTWvwMy4fb64bhae7m585pXMTrmhJ6XbpfsgvXUXGGP0y4iz+nD5A0oSmx2LtwBa7KYW
 vnsx3+dU1eajIxCY1pPhK6eF27tYE9te9dAOP04PJ8bRJhgzOLKvIurhqx81IhJdEziB0GDu4NJ
 H83VL/lPUSUZCC3R9KUWTldnpUG8102R6o496Df7+hj+Y1Qn1qRFkd4/sfZa0XvHp0t/wf9UNHY
 NjEpsSUZLYuHRwu6nbXB9BvSoeq7Ndggj7/hn9uKrkPpa5ALi96Uzx+qANEttc3FGRVQh4KqvXC
 GwRd+XEhWJQzEX3ddmUuS5XWDxiZu
X-Received: by 2002:a05:690c:388:b0:873:5bd1:98bf with SMTP id
 00721157ae682-8735bd19fbdmr50589397b3.49.1788786816246; Mon, 07 Sep 2026
 06:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260902193551.582660-1-jsnow@redhat.com>
 <20260902193551.582660-15-jsnow@redhat.com>
 <4d2d0c34-121f-4439-abf4-4b2da3fbf6f3@nutanix.com>
In-Reply-To: <4d2d0c34-121f-4439-abf4-4b2da3fbf6f3@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Sep 2026 14:13:24 +0100
X-Gm-Features: AcwNN1UK6Drz-o8wuI3vBejHux09-vHGvKmTE8m2mAJj6rpdoOPCvjkI6c8xx3w
Message-ID: <CAFEAcA-aOmJoAP-umSG=stpLZHBS8z01BaEHV-kqOgMwB0DZdA@mail.gmail.com>
Subject: Re: [PULL 14/16] sphinx: require sphinx 7.2.6
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Mon, 7 Sept 2026 at 13:07, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 02/09/2026 20:35, John Snow wrote:
>
> > Make the extraordinary leap from Sphinx 3.4.3 to Sphinx
> > 7.2.6. Simplifications and cleanup will follow in subsequent patches.
> >
> > Note that CentOS Stream 9 only ships a version of Sphinx that runs on
> > Python 3.9, so regardless of the version of Sphinx we require, if we
> > require Python 3.10+, CentOS Stream 9 will be unable to build QEMU
> > documentation in an isolated offline build environment.
> >
> > CentOS Stream 9 continues to be able to build documentation so long as
> > PyPI access is permitted during configure, or if the requisite PyPI
> > packages are installed prior to configure time.

> > diff --git a/pythondeps.toml b/pythondeps.toml
> > index b1879c1a4da..f0f3af915a1 100644
> > --- a/pythondeps.toml
> > +++ b/pythondeps.toml
> > @@ -28,8 +28,8 @@ meson = { accepted = ">=1.12.0", installed = "1.12.0", canary = "meson" }
> >
> >   [docs]
> >   # Please keep the installed versions in sync with docs/requirements.txt
> > -sphinx = { accepted = ">=3.4.3", installed = "6.2.1", canary = "sphinx-build" }
> > -sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
> > +sphinx = { accepted = ">=7.2.6", installed = "7.2.6", canary = "sphinx-build" }
> > +sphinx_rtd_theme = { accepted = ">=1.2.2", installed = "1.2.2" }
> >
> >   # This test group is for dependencies required to run various tooling
> >   # and tests that should always be installed at configure time. It should
>
> Hi John,
>
> This patch appears to break configure with --enable-docs in a fresh
> build/ output directory:
>
> ../docs/meson.build:25: WARNING:
> /home/mca/src/upstream/qemu/build/pyvenv/bin/sphinx-build:
> Sphinx version error:
> This project needs at least Sphinx v7.2.6 and therefore cannot be built
> with this version.
>
>
> ../docs/meson.build:27:6: ERROR: Problem encountered: Install a Python 3
> version of python-sphinx and the readthedoc theme

Brian Cain sent a proposed fix for this:
https://patchew.org/QEMU/20260906222926.3714852-1-brian.cain@oss.qualcomm.com/

which is basically the same thing as your workaround.

thanks
-- PMM

