Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FE2CD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWc3g-0001Cy-8q; Mon, 08 Jun 2026 11:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWc3d-0001CR-V8
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:38:34 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWc3b-0004uo-7T
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:38:33 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-6604176b575so3985886d50.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 08:38:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780933110; cv=none;
 d=google.com; s=arc-20240605;
 b=MpmaZrMsnqYKZRnZxKD17cUHrNV5Y4blG77VLzweejM1enGlC8oLMkZfwLg53miq4V
 ZIx/LTX8TxcuHUroNY9z5Cj6KmZOcAIv764cSqkSajBATfwvqGT7cZazNjkFaCJRamqf
 S5jvI2QJAgfuWFbJ4SpaP/q5Jtd2y1rnzsWiLAQKK58o200LiXFF/f9ASTXdqjJnEzjA
 OsG0mSUQzx3tq42XAi88KiEL38MS0klVtf25jRiQsnPhs6W3X6vG6cViEhIlCBpUq1yK
 2MovrYv96LRzH5FjRrKzHGjIAuffYTv3D8gG9pXfdB2guv3mCmf2cD9lboxRxGUaUwDf
 kc3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=a4g+gkhBiLBRig2Q+JqCOCMKPSIeyA8keg+2S1dA8+I=;
 fh=opqnWuQ9axaTDnVV896x2DCbrS3lBUc5M9UTh/IaCZc=;
 b=DaDCYuulkLv1tHAGk917PgXGugSQYYpPJxLCmtys6HEGCaG6V4qgFUoGiSrEoQCTFO
 bYNfgsMko0r4JfFsl1uZTom8uGd319e5R3r7PeO9LGxQw80/DAYuBg/59fVWy2Hsezk/
 7mCyfBanEKQ6RageKjaTZbypSsz/QswBjKJW+JtGYteENRGq/dzL6CxzTepsalfLTBv6
 pz165VvODF5O1Rn8tEmiM68oyCZeK9DNAQBuleRuZZkVSyboNFPzkmiYj8Osl3hkXQ3Q
 dBFHsDAVDeVM1s/FkNdLhzClOl/ZCn0X/kF1JqahzVkW01LHHOtP9Y/oKIhHhzY3Imw/
 tygw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780933110; x=1781537910; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a4g+gkhBiLBRig2Q+JqCOCMKPSIeyA8keg+2S1dA8+I=;
 b=YxAhQ4r0/QFZrOO1RNvAKaZfGP8ksHfTdGCGc8PZORAdmvO2c3DYl2JqzhRo3N8IAh
 Sd1ErmbVxoyf5TY/g9PmSvVMjOO7NtzN6HH3/xFB0SeF+O9bakjApTLI7KfaHASTt3uH
 c1fKZBvwIwYlhS4Q95vmX5mwTK7++X015kbH0h0I8wyffCaCxQ22vVGwP5EkjWS8Mepg
 vl07Oey2xYMjNW2y9XeB9kUN3yzO7jpPKQB8GRyUD+8E2HMZ5P+diBPomIGz3rC2a5Q+
 m614JlPqd6bL6wt2tlJIA1IWOsjZlBZml3m7AbTjsIfAYLpUvEVzd0/Kt+ajz3vj+Doa
 zpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780933110; x=1781537910;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a4g+gkhBiLBRig2Q+JqCOCMKPSIeyA8keg+2S1dA8+I=;
 b=GyT+pBTrDB2mS9lZm8jjBatTAmZpsWgug+ThOKkkV+qCmWg8/Bi0+0QkInuyMI3YK9
 xaEoQRBO43pZ/1NWeA9Z/4JRqyE+bTcNmyk/YyIhSxPIErn5+WrpCpqxkDF1Q4DUKa0C
 7qATaKGYlkGpkBovrfof+IttCOmKjrxJe1EdNTqGzl4VIzk5Jr84rg+lpkga03E/o9EG
 ne6C8H/Zg28qCb9Tf6wBKbwCwOBA79w+NYsgnT4aYuu3kyXiEg7ULyACJVVg03KAm1xX
 6NL/8NQZcO/Cmw3QtO8vZa8sbLuPEhKWg5oc0ZFbWleajSPMNC7rexJaaZuLvxm8Eskc
 11nw==
X-Forwarded-Encrypted: i=1;
 AFNElJ82fpPLrRLeni5BLdSp9jud0jJl4ArsHkA4RiCgCqtHDQ7QLsEcKFEYHVuFTeQloLCCoAsN8Gpom6sK@nongnu.org
X-Gm-Message-State: AOJu0YyXFEsEmuw8j0EzInfMf8SCEnneUx+/Z2+4poxlkRByln4MQFB2
 16lCNc0VsgPzfUDnQKYjXCzjSNhDEKHcF9ebQ7FmG1Lai0YN+2lcK1yIkQUxQNLEYB8ueyA2fY4
 mB2u4ppPQuzPyGeoRRfwCRMnMF6LmwSmhjMCKSjEtvw==
X-Gm-Gg: Acq92OEVUY5C3rIaevF3oT1UJCkZj2eBKsql1BTNGG2rukfhU5qXqP2XFM7dIOC1e/K
 vAl04bJyQmrjIrbJ65qfS249omanyh0O42xlDKzgq9lg0k1oghe8+uwMwa4/0emLbfLTYOnFJHw
 XsXZqJjoXievUp9TDJzs49a1n41Bu2Fa/ykt1M2TiKWXO3gKQsADfM/2acIItRdQ/98KmtoEZ7l
 Y4e0hsb9ZSCH3WzbKnZ3rdI0a8gInkuvhhZB9+IJMUBDcDUtBLVd1OQnB5fxSHWx+AJDcqF4nXs
 7f8HeH+QGiLdqsBWfd1lWKXUaFTKw5qrrIJ/18NtOX9+xWbSHiHCs0hWPKUl6wETNcKcM2WT6Ae
 Lpg==
X-Received: by 2002:a05:690e:4806:b0:651:b67e:6e58 with SMTP id
 956f58d0204a3-66106e0451fmr9313996d50.7.1780933109280; Mon, 08 Jun 2026
 08:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-testing-macos-v1-1-42774498936f@meta.com>
 <CAFEAcA-aNmOmjhbVypCLpDVowTeSK-28aaY5X0jqRe32qmkqUQ@mail.gmail.com>
 <aibhMPHu6nbBT3Yi@redhat.com>
In-Reply-To: <aibhMPHu6nbBT3Yi@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 16:38:17 +0100
X-Gm-Features: AVVi8CeddfpxL76UMQrmz-LPkp7jsMtoZkEQMmKApcN7VPR1O6o1RGea93cI4CA
Message-ID: <CAFEAcA98r4DxQbB+yiWKqnTGSzps+GGQ3gxFPLogBGTXY77jXQ@mail.gmail.com>
Subject: Re: [PATCH] tests: strip macOS "-unsigned" suffix from binary name
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Emmanuel Blot <eblot@meta.com>, qemu-devel@nongnu.org, 
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Mon, 8 Jun 2026 at 16:35, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Mon, Jun 08, 2026 at 04:29:47PM +0100, Peter Maydell wrote:
> > On Mon, 8 Jun 2026 at 16:25, Emmanuel Blot <eblot@meta.com> wrote:
> > >
> > > On macOS, plain QEMU binaries are named qemu-system-<arch>-unsigned.
> > >
> > > In libqtest, qtest_get_arch() extracts the architecture by splitting
> > > after "-system-", which yields "arm-unsigned" instead of "arm".  This
> > > prevents the QOS graph from matching any machine node, causing all
> > > QOS-based tests to be silently skipped.
> > >
> > > In the functional test framework, the same suffix causes the arch to
> > > be parsed as "unsigned", leading to wrong output directories and
> > > teardown failures.
> > >
> > > Strip the "-unsigned" suffix on both code paths.
> > >
> > > Signed-off-by: Emmanuel Blot <eblot@meta.com>
> > > ---
> > > Address issues with liqtest and functional test framework when run fr=
om
> > > a macOS host.
> > >
> > > Unsigned binaries on macOS may be appended an `-unsigned` suffix, whi=
ch
> > > confuse these components that rely on the binary name to recover the
> > > guest architecture.
> >
> > I still think this not the right thing to do. The "make" process
> > on macos should produce and sign the binary in-place in the
> > build tree, so that users and test cases don't have to care
> > about this macos specific weirdness. (If the signing is
> > location-specific and we need to sign again for "make install"
> > that's fine. But we should produce a working binary with the
> > usual name in the build tree, not a non-working one or one with a
> > nonstandard name.)
>
> Yes, I was just about to write similar when I saw your message.
> We should not have this custom "-unsigned" name  in the build
> tree as specialcases like this break too many expectations,
> especially when most devs aren't ever testing for macOS and so
> won't see the special case.

I think it's OK to have the -unsigned binary as an interim step,
where we compile to qemu-foo-unsigned and then immediately sign
to produce qemu-foo. The problem is that "make" is for some reason
not actually doing the signing step. Alex notes in that other
thread that you can make it do the signing part by manually
running "make qemu-system-aarch64". We just don't have this
working correctly so that "make all" does it.

-- PMM

