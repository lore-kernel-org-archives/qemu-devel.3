Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C8CD2C114
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 14:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8KhU-0001cY-Of; Tue, 05 Nov 2024 09:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8KhS-0001YG-R1
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 09:38:30 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8KhR-0006hF-4b
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 09:38:30 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c9850ae22eso6915190a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 06:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730817507; x=1731422307; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KwKE1gM/FxM2KY8MQQzWbUzus/O47sxJIGMJvhcb5kg=;
 b=qh2bZvS+xCNjus0npYVyKrFA7/I++3A635ybsQBnPejOcDWAErEP0aiHgQYttgVdOZ
 rODoQcFLoJeF4xfSHDQjlKlMeKGN+wiMIrC/mbM2SbpDVfWbnzHi84hh7cQY3CU7UOsk
 TsfDR3y+OAoXi/+EatS7sulQ01kovhD3PzQUdYK9xfyEYH/RsNJKG+W6goOlYNx3IXng
 HWgfoddOTPfAiMns4+d4d0Hmd2XYLwaEW2ZMKIdvAol9Ze+fmw+2A1Tf4cn+9lgr37PG
 NRqnzJDzI9pnmb6j941fP6DF3krwxOOxWpNOig0uIx0gGAZlFvxLwMqOynZ91BqhLyHe
 KZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730817507; x=1731422307;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KwKE1gM/FxM2KY8MQQzWbUzus/O47sxJIGMJvhcb5kg=;
 b=X7W4KKqyPRbCd8z2cpklRofoldxqaGB8LCXCjcJOC1/6+7GblnkLoOGkC9eI8e+KvS
 vTOx21e8FgVIXSKOgKkl98y5SrMhHrA4AT4jstJQafT6bCg7BXiJKWltjTyYo+Gcn5KT
 lKkEIc3IcbDKVoJqUlyK+tIRYFtgGNzJHLoxWnsJoaLFrEFdO2bQjeTUKUVM+7ReKyZ0
 YFYDpCizY5mKM6VFQ0Dv2TP12q8DYqmJJ0YmfWbClVZOzawSDjywpw4dWZt7OBx5NYiJ
 on+3EaQacGp/wca3Sdq+CVc2fc0K5pEjgNttYlW3gvNZZ4dv3PQNRNpiZ4BVfBzZd1++
 mDRQ==
X-Gm-Message-State: AOJu0YyzCADQFzEQvdPYDoQMgFkzX/arPZ1G8iDRjtizrdb1Hy0jDwpF
 Ejp3Rm6Fzl4OUK10nGgLHYlemg3FlFkF+B6MG3OK8DVtoSe3B7lPy328XnO6Ab8GfvTktYfBi6p
 YrO4moJMUvddeG6q0bfk77MWm++bOFV86eZJ67Q==
X-Google-Smtp-Source: AGHT+IFOyG0n3FYNTQRVQReg1OfkOurbRz/WvBAjm1/YdeULyLe9DyzfNsqFWTuMsbfTXWdgaorDXYe9XAqaRyqS4V8=
X-Received: by 2002:a05:6402:2790:b0:5ce:d4ff:606 with SMTP id
 4fb4d7f45d1cf-5ced4ff0642mr6568182a12.34.1730817507204; Tue, 05 Nov 2024
 06:38:27 -0800 (PST)
MIME-Version: 1.0
References: <20241105132339.2967202-1-clg@redhat.com>
In-Reply-To: <20241105132339.2967202-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Nov 2024 14:38:15 +0000
Message-ID: <CAFEAcA9yP3=C5=wuXbBDQ0bSGonjGAyJ387=KsAcPS09Kn4pHg@mail.gmail.com>
Subject: Re: [PATCH] test/functional: Fix Aspeed buildroot tests
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Tue, 5 Nov 2024 at 13:23, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> Since commit 786bc2255256, cached asset files are read-only. Adjust
> the QEMU command line for buildroot tests to reflect the new
> constraint on the flash drive.
>
> Fixes: f04cb2d00d5c ("tests/functional: Convert most Aspeed machine tests=
")
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  tests/functional/test_arm_aspeed.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_=
arm_aspeed.py
> index 9761fc06a454..19853161b267 100644
> --- a/tests/functional/test_arm_aspeed.py
> +++ b/tests/functional/test_arm_aspeed.py
> @@ -125,7 +125,7 @@ def test_arm_ast2500_romulus_openbmc_v2_9_0(self):
>      def do_test_arm_aspeed_buildroot_start(self, image, cpu_id, pattern=
=3D'Aspeed EVB'):
>          self.require_netdev('user')
>          self.vm.set_console()
> -        self.vm.add_args('-drive', 'file=3D' + image + ',if=3Dmtd,format=
=3Draw',
> +        self.vm.add_args('-drive', 'file=3D' + image + ',if=3Dmtd,format=
=3Draw,read-only=3Dtrue',
>                           '-net', 'nic', '-net', 'user')

There are a couple of other places in this file where we add
a '-drive' option pointing to a file -- do they also need
read-only=3Dtrue adding ?

thanks
-- PMM

