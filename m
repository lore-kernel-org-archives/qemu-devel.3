Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D3AE9B24D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 11:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuqeP-0003gH-Dl; Tue, 24 Feb 2026 06:32:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuqeN-0003g2-HV
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:32:23 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuqeL-0006wQ-Qo
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:32:23 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64c97997b0fso977345d50.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 03:32:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771932740; cv=none;
 d=google.com; s=arc-20240605;
 b=dPAic9MFkRD0YcGrau3nk31exKvjigr+1knXBgFtwqxBYo+Gg6lfV5rv4atLWzyN/8
 c+Pufuy/yd2/YU1nmAsbHLmnscakDtTbjgwn9OC3JgYVP0HDDb9A+mFEbk9PP5BFK5kj
 Tiw1EMHiM6jYsofGKa8CYt+sCqkhAYMzU8TU6KU0i1Qg/lJg5CneyLHbEqgLd4rE5n3k
 bGxwFA+W3B+zRvz9wAbvxvXI8q0Y/RqBa7HJTF+4gPhonAOr9k+jfb1NhzHOZ7GoYimO
 UzZ+DilapauFAobvDhXSmmWkU+hp9t9zpID9YNDdA92JBL/I8FuGK7FDOfmff2/VAlvw
 paXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nBGaC8xcvPnOnyQUsK3OXcgHCm1Pc6jOUmDlT8XJxgM=;
 fh=pQA5fDlPQpsKeXqqZVYjwxZwC2lW0/Vn767MOLF4BFw=;
 b=VtzLo07tk9l9XgCOg+ugci0tKpdYjL0o+IBCbI0s/5sclfkj37wyEHH8n7yrcxedrr
 9nxvseUuSGVjjQcAbUAbAMlAukZcLm3cc1iEjCNBVQYcU70K/yDu2bLrpaYIGITOu8Kb
 PoUDofkzt43h2+zq1Nx2dTULZ6hgk6lGXEbCReWCnQ0DWDoUXJ8vPj2UU+U0EnFU1lEb
 r8p8HyOk+WxnA1/t28nKtOZQiuucktajETh7vHLa1X+HoTgoGNA1yYlxCouPzEZDxhV2
 FD+9Pb4GiJGsxGkgVHCqA9ocmkkBBgtctqAYrO7s6+oUVDWnrDMggc8huSfQ1Sajpksa
 ukmA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771932740; x=1772537540; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nBGaC8xcvPnOnyQUsK3OXcgHCm1Pc6jOUmDlT8XJxgM=;
 b=DR15obhSF3+vSFol3M+xBhtDI6IcZr/wPrsCABZshCBl7BSg8L3ZbzlyrxtJ0iX2jX
 EP+DzvlSy24+In3Hi1EOjkuhOmsOUHZlZZzgoLWE/6mfkluAaO2fma88YhcFBXhfJ2uD
 w8qGT/e8tLuM40mGRS8nBBS1Ehp+2TIiQg3pcUBiJ5Tq3+iC0BcZ2X36PGbHPetlKPvQ
 Pb1Z+RF++VubjU+R0ezBcqVK0qVdqIk0IdaDDi+AXsza0lcdAHJ4mIBUVnavTgXdq42x
 rN7bfRKoz55CVA2uq2Q3FWlbzv53FZKmgCPswQDavpU1pOtf30tZWMU6/AGqFbH/1QN7
 5EDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771932740; x=1772537540;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nBGaC8xcvPnOnyQUsK3OXcgHCm1Pc6jOUmDlT8XJxgM=;
 b=AmuStIVpVqqOuVgUxhFEB2zMuWl/AxbZ3lip3oG6FyytxKLI/ZGKTex+M33vbDzEKL
 IP/fCQqGqq7goZ0qHesCGZGDNNe5dlNYDEXbVWZ3VSUWC4SKDkD5DMEw7g5aw9WOcXfS
 aR3R3p5pVEY1nrBR6Xf2barHHB1ojKi96xv4ceaY0b1u3/HBhoHbVPuH1H8V65K9RgCE
 R7SrnJ0nzNqL5CIvBxqauIPaoMxMWsgVxjWlkXpeKAsCwKfVl9zaKAA76mzsDUaanJWl
 l3UCReKKGp9ZqVOdnkcT+i0kJq3zEO1XNjL/0K6xthKIEXi0A6OdT6s4OeyTy6/qfOex
 Z9fA==
X-Gm-Message-State: AOJu0Yz0sUi/X/KTHL9e4q03TleIgaBxwTRdH2XN89SCXzCVwDhukSma
 3r1Yol/hkJvehiGqpNC1PGX9GOPAzIwNsjf49wM7T1NMYCnvCD3dJykeLBomYG2sWMXTUkNtDFo
 PQlvuMbksucBngdfjk85A4pQAh0ejgMCb+8hovfCWkg==
X-Gm-Gg: ATEYQzwrTzV4quNHXsC9Rr+WVYHlPqAAyv+72hQFZ+FJdCkrR4NJ63HBMPpautsqa7S
 mT8VI1xPjeM+z0dKVOZTTZiExbUgYFoXkabLsUPq5rzPUC+eKZucIeZ/+VqK8FbelOBOrvYoBlk
 Gk52jOEp/zTpKnzyMjfYIx1ey9IsG4X/rgWE5yxdTR+NhLOJwmhUtVR6HAqSEm2e9Td4Gs6YUgb
 LxRYwBOB5ovdVYRCqZnI8tENrGoKYc1VnI1evCqX1snqV5VHIPEZx5s/8KFK+DmQ1PEYk7QOynp
 hm1BRT7B+2HNFLWfN2q3zm9UOlpHzVZzZhK1gxZjXnJpjJlt6+WcAh/2fNysPeyp9WUIbaXfrD9
 j/w==
X-Received: by 2002:a05:690e:c4e:b0:64a:df97:e075 with SMTP id
 956f58d0204a3-64c788d174dmr8740479d50.33.1771932740169; Tue, 24 Feb 2026
 03:32:20 -0800 (PST)
MIME-Version: 1.0
References: <20260223182902.739189-1-jsnow@redhat.com>
In-Reply-To: <20260223182902.739189-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 11:32:08 +0000
X-Gm-Features: AaiRm51PkIr4ju2oXSgBHegTWu4yDAp_wcCDaSXzmIer1VPfuT11_cXvrPnC-0U
Message-ID: <CAFEAcA_HWG_xqqTVH4EeHiKpS6n=0Xv7h=Mt4oSKh3VbvyX9Bw@mail.gmail.com>
Subject: Re: [PULL 00/19] Python patches
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Li-Wen Hsu <lwhsu@freebsd.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Cleber Rosa <crosa@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Warner Losh <imp@bsdimp.com>, 
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Ed Maste <emaste@freebsd.org>, 
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, Michael Roth <michael.roth@amd.com>, 
 Fabiano Rosas <farosas@suse.de>, Yonggang Luo <luoyonggang@gmail.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 23 Feb 2026 at 18:29, John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit afe653676dc6dfd49f0390239ff90b2f0052c2=
b8:
>
>   Merge tag 'audio-pull-request' of https://gitlab.com/marcandre.lureau/q=
emu into staging (2026-02-23 14:03:50 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/jsnow/qemu.git tags/python-pull-request
>
> for you to fetch changes up to f0c2b38df05dd642314a31c3d2c16bd4501cbe32:
>
>   python: add setuptools and wheel dependencies (2026-02-23 13:24:42 -050=
0)
>
> ----------------------------------------------------------------
> Python pull request
>
> This drops qemu.qmp from the tree, finally O:-)
>
> ----------------------------------------------------------------

Hi; I'm afraid this fails to build for a lot of our CI jobs.
Here's a sample, I think all the failures are the same error:

https://gitlab.com/qemu-project/qemu/-/jobs/13238854891

mkvenv: installing pycotap=3D=3D1.3.1, qemu.qmp=3D=3D0.0.5
Using pip 25.1.1 from /usr/lib/python3/dist-packages/pip (python 3.13)
Looking in links: /builds/qemu-project/qemu/python/wheels
Processing /builds/qemu-project/qemu/python/wheels/pycotap-1.3.1-py3-none-a=
ny.whl
ERROR: Could not find a version that satisfies the requirement
qemu.qmp=3D=3D0.0.5 (from versions: none)
ERROR: No matching distribution found for qemu.qmp=3D=3D0.0.5
*** Ouch! ***
Could not provide build dependency 'pycotap=3D=3D1.3.1':
=E2=80=A2 Python package 'pycotap' was not found nor installed.
=E2=80=A2 No suitable version found in, or failed to install from
'/builds/qemu-project/qemu/python/wheels'.
=E2=80=A2 mkvenv was configured to operate offline and did not check PyPI.

Failing pipeline in case you want the links to the other
failing jobs:
https://gitlab.com/qemu-project/qemu/-/pipelines/2345847273

thanks
-- PMM

