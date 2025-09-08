Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE43CAC582
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 21:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvjJ8-0002Xs-QD; Mon, 08 Sep 2025 17:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uvjJ3-0002X9-4I
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 17:21:45 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uvjJ1-0004KC-7u
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 17:21:44 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-623720201fdso5040139a12.1
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 14:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757366501; x=1757971301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z2JjjPKTZBQ3B92eya+NCiWs3VbN+zrxBT6nt4uCW0I=;
 b=Ag6IOVS8reRNJhGgwNIxvUjB+8p0R7iLpyRMq21IRbUhFq0WnM2pt2U0VW6yx+mSlM
 s5NWY8yRMptZ9DbsS4aMtL86sr1X4z6xXtr4JGq2mQ6piZAhEyhv0FKaspRWu9IQJXHs
 M3dYv/fOiK0bn/YXebGP0jeA3KaVEz5aNtklz/vKGbmINXpAlJCXa9T45KhQgy8O4Vw7
 g280II5NGy11Dgn6bV7J8yw6aG/yBp6jRRoH5uveUWVWBhhmAgqT4Fb+E4NHoJoyEgSi
 BCkNB+uIZbF2VVNI8FjrWJ2W7MFBwpS3r3GQF0njxJ2o0qW4bXRoHP688HHr4YYNlT8A
 5byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757366501; x=1757971301;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z2JjjPKTZBQ3B92eya+NCiWs3VbN+zrxBT6nt4uCW0I=;
 b=Bq++8mNB+MsI75PEXD+9ZOuQZU7JvQD/Poq6Z1iX9uE/D9a6GvSNg6St9BhnvljW56
 TiPIwqomcQj5lmJVPV3J0xnutR0GsJpe4g+sZecfUj+mJopVfLJqSfLg+JjaJJP5heVf
 g//HYvEu3e+3di5vk6tUwLeqGY8wMyxCUKfW6IyvDKgMaT4KfEBcOuFUfOIwrsH+0bQX
 l2LWzXCWRBsCmU3wrrwlNQs/SAnamRm2nKhL9AB0IglYsp2kpmNZZXvyrBq8fAZyjP2U
 dM8LaWn7aqwssCZ37hBfc3eTANB5vR/FOcXLjl698y/Rk1h+Ys0QLNEHMJi39/+jbw6A
 X6Rw==
X-Gm-Message-State: AOJu0YwpxAhbFCaPbwb54j3NvGpXofjIAxkgl9DwSy7+um7W3FeUOQMJ
 8jhnelKL3x2H16YqBL/tTNBELuFdh/h20GPhC6IiUSHdMZbgEOgZrc0EOSmIlpZ424I=
X-Gm-Gg: ASbGncuaNOQ1Aqb8CDatG43ysEHiGc++6/8PKJIiatheKe6c0OGDLNV1EwC+yFf5RyR
 nqEemyF4rShvO3mpIswMaZulUPsBys7yZanbz9xi5qwta5zSu7ZOyJB5X+UJzsu0sR771voLosd
 A/JkrP6+o3X6eOx6utuCRbtKYUPJ+CyIhFJKjXcnLptZaRnrWOGNolXtfUAmJNMgxeRD/2LXA4v
 2eX9i6xjidEIZPuLqJW8vAuNzTlZqdwQl49RFjD9yx3OcUgDNCx0ACJj/dq32qjV9Ekxf9oLdXF
 JjQvGfToRRxaJWHLgl7tgXHT+JkjT8ZNdmWV6ZrvstEWW/TMTpIk234XgRWBznTp60zy+5vbFlo
 hoMJ79FyeV4D4GWLcye1IGILHfh06N0wAAw==
X-Google-Smtp-Source: AGHT+IF0DDph9j7DrOFKt5SEinX7Lscltp23Ah85dJ9wDLr0jFX3ol/3VF9ewy8gZfQ+Hcl/JanzrQ==
X-Received: by 2002:a05:6402:3596:b0:629:949c:a653 with SMTP id
 4fb4d7f45d1cf-629949cb00dmr3270472a12.24.1757366501521; 
 Mon, 08 Sep 2025 14:21:41 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc1c7a10sm23314035a12.5.2025.09.08.14.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 14:21:39 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 01A485F7C1;
 Mon, 08 Sep 2025 22:21:39 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yonggang Luo
 <luoyonggang@gmail.com>
Subject: Re: [PATCH 4/4] gitlab: prevent duplicated meson log artifacts in
 test jobs
In-Reply-To: <20250908190901.3571859-5-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Mon, 8 Sep 2025 20:09:01 +0100")
References: <20250908190901.3571859-1-berrange@redhat.com>
 <20250908190901.3571859-5-berrange@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 08 Sep 2025 22:21:38 +0100
Message-ID: <87v7ls7i8t.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The build jobs will populate build/meson-logs/ with various files
> that are added as artifacts.
>
> The test jobs preserve the state of the build jobs, so we must
> delete any pre-existing logs to prevent confusion from duplicate
> artifacts.

Will this cause us to rebuild needlessly?

>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  .gitlab-ci.d/buildtest-template.yml | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest=
-template.yml
> index 308490a35a..d866cb12bb 100644
> --- a/.gitlab-ci.d/buildtest-template.yml
> +++ b/.gitlab-ci.d/buildtest-template.yml
> @@ -83,6 +83,10 @@
>=20=20
>  .native_test_job_template:
>    extends: .common_test_job_template
> +  before_script:
> +    # Prevent logs from the build job that run earlier
> +    # from being duplicated in the test job artifacts
> +    - rm -f build/meson-logs/*
>    artifacts:
>      name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
>      when: always
> @@ -111,6 +115,9 @@
>    before_script:
>      - export QEMU_TEST_ALLOW_UNTRUSTED_CODE=3D1
>      - export QEMU_TEST_CACHE_DIR=3D${CI_PROJECT_DIR}/functional-cache
> +    # Prevent logs from the build job that run earlier
> +    # from being duplicated in the test job artifacts
> +    - rm -f build/meson-logs/*
>    after_script:
>      - cd build
>      - du -chs ${CI_PROJECT_DIR}/*-cache

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

