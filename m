Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA74D43369
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 14:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t93qM-0002Q7-Eh; Thu, 07 Nov 2024 09:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t93qI-0002Pr-FY
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 09:50:38 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t93qF-0002jw-En
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 09:50:37 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5cefa22e9d5so1165214a12.3
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 06:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730991033; x=1731595833; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QxBVUPRIWmpnko/WFHt7sCbYR+ol2XFY2KXE7qsP5Ak=;
 b=VDoMkSZZzFuI9UiMif59VxJ3WXXB+UdWD9UPFR4opLMWD50bC7tUqgtMwRop3AiV6s
 vSDZ34VhXP+p9uh1nsIH14OCPJhZo6usCdTQh59HzvFKXc9+OKOZ8ligJMX5WcFW18PC
 nnz2GzQh5iLBDTNi+cFV2NbilrbceBuaCEp9JttzrZ5InOzxayWeFhea0tZS2FpE1FjQ
 OqYqKykPxJSnA1qg7SNqVUzxUBpGkX5cYUrVporx/A/RdPsD1rWKw/YmjUOorduHxo0K
 lLjvFDl3/2PsyjafQrts4AT4V3v3nwtRo4yb2GbP0qNGmQ7+N3ObSZwhNlCqVKg1yDYj
 rWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730991033; x=1731595833;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QxBVUPRIWmpnko/WFHt7sCbYR+ol2XFY2KXE7qsP5Ak=;
 b=H1MLW1DzZunkiMIepMKTtEy1zaZiGVYyo97611bic4HlX1Luage9gvKIpbv+yrOWPR
 lgAp73O72hwIS+E6JH+E+srjR6tTOV3dD06QyFID71wngOj9sy8Ah+W5GykhNhkQsTU/
 s23ACthoFSM4YOfEGbRFY9ud/66xx+UKdxf0i33fNOzW0340WxCDboNlckMTGx8KG3Xv
 zWx6WFFmZzpuKTOa23RZsU+YtRsJ4ps/MTYOjB09Qgl3ibChhk1dX5Bpp520jchDGW50
 N82g+RcuqGVPP32oixMV04O8Ko5e0j49QV98Hxx3nuOPqBw99buIbtRbHYNcMkYUnnjm
 GT5w==
X-Gm-Message-State: AOJu0YyUPgmDCocNBcT0NBg8/YUafI2DOA//P7lkUgadprayrHP/5U8t
 x/EexrcKrwrus8r8O69OaguEzlCqKOdre1mKOjjLzeqL3ToZGUdfn+Ko78wz/kW+fwccO03ouAf
 qL2fQo9wvaGU1fW72oj1AJhe1rbn5KT/W2LnRUQ==
X-Google-Smtp-Source: AGHT+IFPzKMoOsNRXdCEYwYqdMQl6kuCYb6kt1qDMKPCofbqaNW9xgRE19gjhetlhkOxpovqgmaCxezehLGl4eYpUII=
X-Received: by 2002:a05:6402:4309:b0:5cf:8ea:32f1 with SMTP id
 4fb4d7f45d1cf-5cf08ea33d9mr119725a12.8.1730991033332; Thu, 07 Nov 2024
 06:50:33 -0800 (PST)
MIME-Version: 1.0
References: <20241107131539.36843-1-stefanb@linux.ibm.com>
 <20241107131539.36843-2-stefanb@linux.ibm.com>
In-Reply-To: <20241107131539.36843-2-stefanb@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Nov 2024 14:50:22 +0000
Message-ID: <CAFEAcA8+w0jRJYkPSxz7p9qDi6Em4kR0Y9ShNVq1bRsBjzMC1Q@mail.gmail.com>
Subject: Re: [PULL v1 1/1] tests: Adjust path for swtpm state to use path
 under /var/tmp/
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Thu, 7 Nov 2024 at 13:15, Stefan Berger <stefanb@linux.ibm.com> wrote:
>
> To avoid AppArmor-related test failures when functional test are run from
> somewhere under /mnt, adjust the path to swtpm's state to use an AppArmor=
-
> supported path, such as /var/tmp, which is provided by the python functio=
n
> tempfile.TemporaryDirectory().
>
> An update to swtpm's AppArmor profile is also being done to support /var/=
tmp.
>
> Link: https://lore.kernel.org/qemu-devel/CAFEAcA8A=3DkWLtTZ+nua-MpzqkaEjW=
5srOYZruZnE2tB6vmoMig@mail.gmail.com/
> Link: https://github.com/stefanberger/swtpm/pull/944
> Tested-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: f04cb2d00d5c ("tests/functional: Convert most Aspeed machine tests=
")
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  tests/functional/test_arm_aspeed.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_=
arm_aspeed.py
> index 9761fc06a4..a574b1e521 100644
> --- a/tests/functional/test_arm_aspeed.py
> +++ b/tests/functional/test_arm_aspeed.py
> @@ -227,11 +227,11 @@ def test_arm_ast2600_evb_buildroot_tpm(self):
>
>          image_path =3D self.ASSET_BR2_202302_AST2600_TPM_FLASH.fetch()
>
> -        socket_dir =3D tempfile.TemporaryDirectory(prefix=3D"qemu_")
> -        socket =3D os.path.join(socket_dir.name, 'swtpm-socket')
> +        tpmstate_dir =3D tempfile.TemporaryDirectory(prefix=3D"qemu_")
> +        socket =3D os.path.join(tpmstate_dir.name, 'swtpm-socket')

This is missing the comment that I suggested adding in code review.

thanks
-- PMM

