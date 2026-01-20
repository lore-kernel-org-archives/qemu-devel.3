Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B723D2629F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 21:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viJV4-0004cA-4G; Tue, 20 Jan 2026 16:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1viJV2-0004ak-7t
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 16:42:56 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1viJV0-00016b-Ck
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 16:42:55 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-655af782859so9394011a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 13:42:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768945370; cv=none;
 d=google.com; s=arc-20240605;
 b=S4Mr6Kl5wwnGWZtMFhtD936wBErz1wLokFxZyWvgqp/SrmlJFytXvnTyN6IRAExHQF
 v6OQa0/Euf7bdyKBP9j7m1yerWAWd9fDZEt5OgQcYxWsNum/8Q69/GIHwp8KSCh/sSSV
 bkLyODaG8FL3CeXM+pybEziGPcQeN+Ver0XMCqWVHcB8vM3CMyvh3uBiO64uwQSaSO1l
 NpiLJ0jdy8Og0MbJkhYpWh/iWoR0CVLumnLUK7AOq1Uj/RJ8rBNtG+er38RBkwvrhVVc
 e9MJNHo+sukEgdIOzgcC1wP9aUJOqVhAED4Wfgz38y8zFkuM1CxInu2PuSdgTX4iYtwr
 oAaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SODSzcdnKzZlOKpIGDXzo+xqV5iYMzndbaLV3+jv2BM=;
 fh=h8sMn9YcM6Y4Fe/BPjGeqlTAhQJJie9m1kpd5onqEzA=;
 b=idqcd7NAkY8kjxM8csAE50MHH3qDa5zJyXd42pk4izb6LXEPK6pMq9NvRxFga+jQsG
 XgmoiWK+JhTdKOiXWZk6/c6cGZA1pmigA9lCxt13QDaiz36TCSdImFvB5pvTJe8JcCyO
 pJcq4BCq1YRRpsL6EdJGtKc2OgbgLi/0dLbIK3V6DXmtjexpVnq4Yhb6MyNSS5+sdnFd
 WkZiN2g//ycafa1r3kUEchFFT65lNSfLVgd8dtiGxl7yWZu+ur1/XuaHmJwmBURzif8n
 hkwAp2bRQfFWPQFlUpybbwlOBOJP7YqT649+TFCmm9fltCm++255+kYlspx7+XaNdAPp
 2asw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768945370; x=1769550170; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SODSzcdnKzZlOKpIGDXzo+xqV5iYMzndbaLV3+jv2BM=;
 b=AIG4eJrAEnKBOUxCGfDIA0Z8UdnbC6uLD6POsN0HxwEU2TFBXFAQVZ5YwTuy/LMEyr
 S7QA/FPcsxZejUZ1v1UT7n3ldSdSjk4Uf8I6d8KnF946Nc+mcNdVJ97EF1M9NnbB9NZJ
 /Gr102w5xU149i2lbQ7ybtr+EoHSsW/DrI1ftSRltP1Vzm587mEgbor61GUWmqgo69xc
 sLQvyOsHnnN+vMz9vFypLWjWxesbOj8n/Y8aS+6+kJQEEJTJvqACtRKTEPDfLa48KUiP
 wTPfSX8EgtuWTJQ46yhIOIpnQhg7xIfmV7K0HFRaH6i8HXRuy7Ff55CqOb1hxU0OuAVN
 Bg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768945370; x=1769550170;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SODSzcdnKzZlOKpIGDXzo+xqV5iYMzndbaLV3+jv2BM=;
 b=oGLw/VolIbC5Dup1xbA4GE//hUCG04gZ66XgZxwsI/lUW4SkJisURPLw7D2EN5pfm9
 V3N/N/7jmymMeG2Vg8SK3aZxy+nB5LBFmrvj4MwFbUhvokpI9iQJc4v4jqcdCbISvJ3+
 Y5IvjrAogEvPOHTqZ7CL2tlQ2nuelRmKvd1luNgn/c/oziiS82ADR5rcMcCil1177aUm
 UIpwMeIMLNYFu0Z9YHkMWDakpAGc212SKHGJ97BoWJOwPP9z/ezKfwoIrvbMU8k1IAJE
 7tdU0RD3yfaJj1LBtOXKbaaBXlGNjMClZKPTZyzBFeOQqihuI/4ta4HxyPeJ1LWnV+1Q
 F2ZQ==
X-Gm-Message-State: AOJu0YyM6bNybvoi8HZ7e1EXXVYM3PXsEQOn7g6XfynBu3wz8j0iwCTV
 vKWm/2v3t1qoLqrbn/5HM8SMTxPJf1KtZXpODj2wF9sQMOZDxOnCOZBWtxUcwtKPpnm9ufx7K+9
 xofwsvdCUdCg4zvEjVOB5ASnfPp6L5OA=
X-Gm-Gg: AZuq6aL6ch1Nrf3sgDSYJPr+9c4QhYvYvmjI7b001j0M9Y6fmcqRvccUs29zMVGGNSb
 qhhKL+oAFZAzb6iJLPRxK1nPUDIXBcndp18jBr6ObcMrLX0HTytbHOwm7n99VNLiMhhowOpQX3X
 UUdFO+LvLviQaphDA5FugOpK3212vk5wuz4kvia8oC2+fopUWRq/x2W8NQS1cCH5CEGKaqGlFdy
 CXCMJfcDN3V+/rbIeEkUEFLlVH1n73MhveTH9Wit7JW9n19V+pglbTcnl5Li1ETZ0Moug==
X-Received: by 2002:a05:6402:2691:b0:64d:2822:cf71 with SMTP id
 4fb4d7f45d1cf-65452bcc4edmr11496096a12.29.1768945370201; Tue, 20 Jan 2026
 13:42:50 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <CAJSP0QVQNExn01ipcu4KTQJrmnXGVmvFyKzXe5m9P3_jQwJ6cA@mail.gmail.com>
In-Reply-To: <CAJSP0QVQNExn01ipcu4KTQJrmnXGVmvFyKzXe5m9P3_jQwJ6cA@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 20 Jan 2026 16:42:38 -0500
X-Gm-Features: AZwV_QjZkTqQV3H6_gNVkzSg1uUJilQZy4GcLXCoTgnlrVmZgQIgQs8X3slohxk
Message-ID: <CAJSP0QW4bMO8-iYODO_6oaDn44efPeV6e00AfD5A42pQ9d+REQ@mail.gmail.com>
Subject: Re: Call for GSoC internship project ideas
To: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 German Maglione <gmaglione@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 danpb@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Alex Bennee <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Marc-Andr=C3=A9,
I haven't seen discussion about the project ideas you posted, so I'll
try to kick it off here for the mkosi idea here.

Thomas: Would you like to co-mentor the following project with
Marc-Andr=C3=A9? Also, do you have any concerns about the project idea from
the maintainer perspective?

=3D=3D=3D Reproducible Test Image Building with mkosi =3D=3D=3D

'''Summary:''' Build minimal, reproducible test images for QEMU
functional tests using mkosi, replacing ad-hoc pre-built assets with a
standardized, maintainable build system.

QEMU's functional test suite (`tests/functional/`) relies on pre-built
images fetched from various external sources including Debian
archives, Fedora repositories, GitHub repositories (e.g.,
qemu-ppc-boot, linux-build-test), Linaro artifacts, and others. While
this approach works, it has several drawbacks:

* '''Reproducibility issues''': External sources may change,
disappear, or serve different content over time
* '''Opacity''': The exact build configuration of these images is
often undocumented or unknown
* '''Maintenance burden''': When images need updates (fixes, new
features), there's no standardized process
* '''Inconsistency''': Images come from different sources with varying
quality, size, and configuration

This project proposes using mkosi to build minimal, reproducible test
images directly from distribution packages. mkosi is a tool for
building clean OS images from distribution packages, with excellent
support for Fedora and other distributions. It should be able to
produces deterministic outputs.

The Ouroboros has finally caught its tail: QEMU adopts mkosi for
testing, while mkosi continues using QEMU to exist.

'''Project Goals:'''

# Create mkosi configurations for building minimal bootable images for
x86_64 and aarch64 architectures using Fedora packages
# Integrate with the existing Asset framework in
`tests/functional/qemu_test/asset.py` to seamlessly use mkosi-built
images alongside existing assets
# Set up GitLab CI pipelines to automatically build, hash, and publish
images when configurations change
# Document the image building process including comparison with
existing tuxrun/tuxboot assets (which remain out of scope for
replacement)
# Migrate selected tests from external pre-built images to mkosi-built
equivalents

'''Links:'''
* [https://wiki.qemu.org/Testing/Functional QEMU Functional Testing
documentation]
* [https://github.com/systemd/mkosi mkosi project]
* [https://gitlab.com/qemu-project/qemu QEMU GitLab repository]
* [https://www.qemu.org/docs/master/devel/testing.html QEMU Testing
documentation]
* [https://mkosi.systemd.io/ mkosi documentation]

'''Details:'''
* Skill level: intermediate
* Language: Python (test framework), Shell/mkosi configuration
* Mentor: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> (elmarco)
* Thomas Huth ?
* Suggested by: Marc-Andr=C3=A9 Lureau

