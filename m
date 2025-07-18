Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48905C83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 09:25:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uchLE-0008Ps-Jn; Fri, 18 Jul 2025 05:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uchLB-0008LZ-EU
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 05:25:17 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uchL9-0006WQ-Bd
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 05:25:17 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6088d856c6eso3411436a12.0
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 02:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752830713; x=1753435513; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CPLXYfTxNQifyNXSbEAJsIWN+AIDCRqJ/bDbGQGI8Kk=;
 b=JWRd1NQ88gAw81J1azxse3QFbBJCkf9lp6lDwUzQk3o3yX28G39p9Prk4kfBY+x3aR
 sfbich16XscKbf9w99Xm1QD52ohkKb9q1a15rWVN/OSjGepeUMlg3n1NTOSzMw96iA1C
 pVPyIXYl+RfT2URnXsYh2EMNIRvrOJMSJap/DBqjzJqXg4IJ7LGYF4NiTK3b2f3/CeXX
 XpVvMRa1fRxBvA8Wqf7muRTDTvXo31tKfYi/woCMQG9TBp5gA3RKKR78wmeb+AERds4u
 +vd/1PMWPotP7XwBUdd1QiM1KuuCWYb87djyzP3qOHzexRPpaj0wTFZaCbhuXROHFrZP
 bgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752830713; x=1753435513;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CPLXYfTxNQifyNXSbEAJsIWN+AIDCRqJ/bDbGQGI8Kk=;
 b=OWOqknz16V1YeSpL9cSndxIcL+bzdVWytEXO+Ghy5UpyKW72GhPU9JiHIBddK1i6zU
 sH7SHaVLQljw0zx8kz/XWN3O1iAx3yqu3lPcwMCHglunh3orjeQ5+wJuCRiz/lAo/bP0
 k352tsefzBvZ24GKUqdD/k014AvIyII5iAqFruDwqPEceP2iXu9ap9O5JBwJjngbpbuI
 hgJgwJCnBT1fIqlo0XIqui2DFOMbjxsW/JBOuCLQjO/04qXBIUKnoSmJAQk7eXtCEcb6
 17jPMozmVuFN/PFmCUTTWwL+pErQQlWxMFZ1Ucrv1KAJVsfY8CROZtDsXaOF9UZ9XzQT
 w/4w==
X-Gm-Message-State: AOJu0YxLmIgtfBKUemZZ3eeTL5VewYaF8DpzgxRuVV0C5wpqeiYdlh/Z
 Kxcg05H600E+hT75b7zbiROFp+f68A6b6mrl7IFmbPbqBqK+LCRMrhpe9vll6LuFNEXzK+I/AvK
 Lrsyd2+PGQXRmPWfHmNAMwVTs78Y6i+7+sjOQLgu4zA==
X-Gm-Gg: ASbGncuMfckKuASRVLmljXP4w24r3YBsjJDxKUF3fyUOTkVj+8dLgPjUjeCijYfcFnE
 iLiZDXxHBqNTzRACkJJmZ6bYrCJGVW/CfoIWxlQbb/F2W4RzrJ9IFAsD65l5LKQIGiTu4Xa827r
 tTtKght7v7LYkSnU9wzROuU/ef768R0SBQ9awJssk5RUMgblwMpIKQTZkjHmNdkU61hHUoaWAO/
 C1BmA==
X-Google-Smtp-Source: AGHT+IFJPMyoWkLekd9j2jCjV5AsS3IVrBTHQs5Gc0S1BCrGm91CUR8eCFtw3+uKuimS0ehDYFBdIt4HUf+ONx9O2LA=
X-Received: by 2002:a05:6402:268d:b0:604:a19a:d84b with SMTP id
 4fb4d7f45d1cf-61281f1d19amr8523739a12.5.1752830713291; Fri, 18 Jul 2025
 02:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250717-functional_tests_debug_arg-v2-1-4f0d991e16f7@linaro.org>
 <aHoR4YgTKOgGsZgT@redhat.com>
In-Reply-To: <aHoR4YgTKOgGsZgT@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 18 Jul 2025 12:24:47 +0300
X-Gm-Features: Ac12FXwsVi0mGl8RF0V9lPqUrJt-V9J3ooEa-exzlsBkaQuvjzm8E4b-dcKuF6c
Message-ID: <CAAjaMXb29ybJ2x8p6JdB3SaZuyX4X8i=ywph=N2QNrq1HJ-nBg@mail.gmail.com>
Subject: Re: [PATCH v2] tests/functional: add --debug CLI arg
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x534.google.com
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

On Fri, Jul 18, 2025 at 12:20=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Thu, Jul 17, 2025 at 01:34:13PM +0300, Manos Pitsidianakis wrote:
> > Add argument parsing to functional tests to improve developer experienc=
e
> > when running individual tests. All logs are printed to stdout
> > interspersed with TAP output.
> >
> > Example usage, assuming current build directory with qemu source code i=
n
> > the parent directory (see docs/devel/testing/functional.rst for details=
):
> >
> >   $ export PYTHONPATH=3D../python:../tests/functional
> >   $ export QEMU_TEST_QEMU_BINARY=3D"$(pwd)/qemu-system-aarch64"
> >   $ ./pyvenv/bin/python3 ../tests/functional/test_aarch64_virt.py --hel=
p
> >   usage: test_aarch64_virt [-h] [-d]
> >
> >   QEMU Functional test
> >
> >   options:
> >     -h, --help   show this help message and exit
> >     -d, --debug  Also print test and console logs on stdout. This will
> >                  make the TAP output invalid and is meant for debugging
> >                  only.
> >
> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > ---
> > Changes in v2:
> > - Store stdout handler in `self` object (thanks Daniel)
> > - Deduplicate handler removal code (Daniel)
> > - Amend commit description to mention PYTHONPATH (thanks Alex)
> > - Link to v1: https://lore.kernel.org/qemu-devel/20250716-functional_te=
sts_debug_arg-v1-1-6a9cd68318bb@linaro.org
>
> You've ignored my v1 review requests that the code for creating
> log handlers should be moved into a helper method in util.py, and
> likewise that the argparse code moved into util.py, and thus not
> called in both main & setUp.

Hi Daniel,

I forgot to reply to those comments. The arg parsing logic needs to be
called from both, as explained in the comment. Plus, there's no reason
to put it in the util module, it's only used in one file. It doesn't
really help to split stuff out of testcase.py if they are only called
from that file, plus it's not a big file in the first place.

>
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

