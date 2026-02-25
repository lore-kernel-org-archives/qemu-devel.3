Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2631FD375E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 13:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvF9q-0006KC-KD; Wed, 25 Feb 2026 08:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvF9n-0006JH-4r
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 08:42:27 -0500
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvF9l-0003Yg-FJ
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 08:42:26 -0500
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64ad9fabd08so6322251d50.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 05:42:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772026944; cv=none;
 d=google.com; s=arc-20240605;
 b=iG7nLuhe8xymIFTKVdfSDcBcPpvstMngSVpvCmb5kNTlCKMfbE77S43eX4FwdOuuTy
 dqfTmj+FvVl0S32CmJ5m3Ubk2EsQyXc53oU1EQAR345NV2dVcY+qQbEwazR7NvrdZWHN
 ITnrtseQgPbcCEp2V6iPuzpOSMuEFOW36/LAG8PVD8Dwt/94qCbkX5afVLd2WSGUg3Ih
 y0SqnyLB8iwEBKvekYr3ZpMJX3B7Sv5MvkPeHj9pvOon/xX0xd0JWQkeQS6a8VOqGXBq
 YYDglpR4/UYB4G68N2Sb+QD37q/2bcH9Sltgv0hQd9TLd57KDxngv/sRl64jyzRb/K9i
 awFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lMG59FwuW9GDLWcCOzLHsaRoWaYVZYGf1BGQQV1FqI8=;
 fh=21kckvfCsPMogHS8UiR7ok8RY3qQQJ9OdcmVsCccRHc=;
 b=SQVIX2iUEHTD3qHZUPA5sd/aXi/W9jxNBFGLOYWBBJRCCCVxc0n5Gchx1cJ8sdTd6o
 U7KWtCWvS8p9Lv8dizM2mfFFUVk6Pu/ix2f6maUpduSxTzAE4IWsEd58+ertRPzuVst8
 81aMF5x8cGX7BK2I65vmMxB6hEJGldAwk0CE2I2YWvMttVm7HCsJ9CazEDvJeVKacHlI
 ZR/ByUk7BSgJKCjf3DWUDAykwKXL9pMOqdSJxxqqY6fDZcEcpUVp1tOdobYLt6kr2sJP
 nT6PfcUvgSeMtpQj/eNb66S63lbXL370S5SpJ1KxM46dmL8KYlYAb/lBWFtXaYFnTbP+
 1jkA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772026944; x=1772631744; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lMG59FwuW9GDLWcCOzLHsaRoWaYVZYGf1BGQQV1FqI8=;
 b=Z0IzMQ+f++TOzd4mLB6U+VQ3JW7Ft6Pkdde8CkDrNVoIPkFRCRjTbdURZWvGPqYylv
 gHfzBVxpwPVvACis13MtVdIYnUO9M5fbMF5KUwyzwi+a9z/ji2Ad7DX9SkEzo3RED7Kx
 dfZhludOtXneAEXUAso5cS+7Y/e6/iCvRbC2F6EkL2tvxKsc1/yPMbYGfi2EuDdjkyeQ
 JpgKYDvP5+ZHHkRNYw/g9QANvS1mNoe8kwH32oeVXDGuj0n9YixPqmzxjGcPDEP4CoWo
 2yVTo9MiMCmFedGlVz5NlSW7lQ7pMPgHBFS74CkzpTGoubKlhMVRQtZrRTa0V0Fatfmq
 M9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772026944; x=1772631744;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lMG59FwuW9GDLWcCOzLHsaRoWaYVZYGf1BGQQV1FqI8=;
 b=raOeq4DLPGcr3b5VuJeeMxVgZ05GtEL5MmVTpWbG150iEsBo/JYhMKVd/0vlnEUqYE
 FFUGedzBif551flipj0fPS1kC++4Siaa8gFfhs6yXcf3mxnjqlJXX7nQ1HdAppf97MB+
 9Ktpcesvbqeyk3FUa+HNh5TG13bmrCz4nHkdbOLquwzQT8P+m2nqR36NjrAC7cvimgVV
 0Gacoo7LEuCGXavkoJABu9tNaQSWctg8ruGuz3oJAYL71iGSqt8hziqKxrxNz/MWSorM
 xRdsazmDpgvws9J0ch/+Ln2RmFKY1S9oSrG5AfmdRAIciHvttfdSwpLES/lKfbt4oxnY
 Lekg==
X-Gm-Message-State: AOJu0YyoJosj9o4nWRLRVxgmBzMCNLhdRUeEeISCWF+x/CStqxxuCXoQ
 Jd5h6whTohAw4+ug4zTXomiNdbhl4tqS4FZWw+x75J1kwH2SfGwnsjjPMezdQMe69+PKjEB0zMU
 PhAdjhFhjH0uqqk/V/kxWtKcvgMU1TeV0wQbMpkOM7w==
X-Gm-Gg: ATEYQzzK1AhQ8t8GS9pUKIVdHxYmnFoNT5MKHIQB9yU/gw+ilR4E2iQutltyLjgXkw3
 Wwp7rBIGBsVDxwiiiyMz7BzQ4GU6vgORZqHBgkZM8SyoAR/9YdTZP2+0uWuzwkTFKNr3ZKspjYr
 iX0qBYXHmQq/ixqUxzCr29WeMjxHLn/QHLmq214W04mA3Y3vZfzs1P36y09Zuq5QXOPy9hica2Q
 PhzQTqrTE2kNgwfUeQ5jG767QmsD1bR3FeuY8SvqtizKCvCX+4b1s1muzrY2Mccta45XTW+U2SO
 zqtqViDgswOXx3Vkw3PGQMgPTFkAl2OEfENLm8YIfINegQTWd3aXohEmAmR6EyMYc6E=
X-Received: by 2002:a05:690e:418a:b0:64a:d715:2c95 with SMTP id
 956f58d0204a3-64c790a5f95mr12046463d50.87.1772026943760; Wed, 25 Feb 2026
 05:42:23 -0800 (PST)
MIME-Version: 1.0
References: <20260224181440.832943-1-jsnow@redhat.com>
In-Reply-To: <20260224181440.832943-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Feb 2026 13:42:11 +0000
X-Gm-Features: AaiRm50V0YpD-v0A1aYSH7xg6wAf4kOyVBAibr2sC9345Plxio9strx2SllKeQQ
Message-ID: <CAFEAcA-ZX85KXk9E6bAxeFAFHNYUpquGzM0ao9ceSQenMhg+2g@mail.gmail.com>
Subject: Re: [PULL v2 00/19] Python patches
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kyle Evans <kevans@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Warner Losh <imp@bsdimp.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Maksim Davydov <davydov-max@yandex-team.ru>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Ed Maste <emaste@freebsd.org>, 
 qemu-block@nongnu.org, Li-Wen Hsu <lwhsu@freebsd.org>,
 Hanna Reitz <hreitz@redhat.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Tue, 24 Feb 2026 at 18:14, John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit afe653676dc6dfd49f0390239ff90b2f0052c2b8:
>
>   Merge tag 'audio-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-02-23 14:03:50 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/jsnow/qemu.git tags/python-pull-request
>
> for you to fetch changes up to 4e55bb4be53bc7a5e3fe1429af12d2e3090049a5:
>
>   python: add setuptools and wheel dependencies (2026-02-24 13:11:29 -0500)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

