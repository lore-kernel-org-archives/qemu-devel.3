Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7B6C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 10:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLgdh-0003A9-NE; Mon, 24 Jun 2024 06:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLgdg-0003A1-OT
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:09:32 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLgda-0005no-DP
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:09:32 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a72420e84feso192864466b.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 03:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719223764; x=1719828564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=koLFATHL1BaA++IQH6//3hnY7vQHAyf7kjCJ/u4vkKs=;
 b=o/CLKBCt9G82LMQYFaP3r//cfrvWtpwABpmKg5r91S8mLm5dsRSFPBOLO7+IhGSLa9
 enW1VTp7RuP3b+BymH8JFwr7t2X0pfKZLF9C9wn3PniRaDR5gvQ+kEtuwpXurbhRyFcr
 7UgqezOWXAIb7e3TapDfFkTERugIS0QdJTzSFFWwo2bTgPHVEG/+DYiK3ulSmwvrHqhR
 /nD6+Ojlu4Qa1Hf6LoRFZF52QM4YXroY39VDygQxo9taGmo5pDWqPiV2m38wpW2fNAIr
 HahWd1VxrNiGw/6gLqWSqak+TodQZd78RF4ep9HGDpdS6rL+plVy+H1GWWqrx7440FTc
 2wnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719223764; x=1719828564;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=koLFATHL1BaA++IQH6//3hnY7vQHAyf7kjCJ/u4vkKs=;
 b=FMmkZVir33IC+ZQdxn4EUfPg3tI4k3vuBAQn1TlN+A1mwVHcpfVtHV0RJbb47Y/s6w
 9/KKgd8W8+J7S24pterwFf/DOtR8/gkSHdChQGt1TEyh9Lu1LgBFTYF6Tq1mU+Wsj6+C
 CdCapV7YGEop+8M9Xc/J5FL6Byjw7HNqX/WmDbscgGhGLIFvdjsGluwRBIo7WHCfsyN+
 jsaTGhvmmyxhbhTnPd+xYwYe+oGVVEQ4GwnPnGtn8B8shlqPdibG+t8aPyb4d32jqKMH
 V7lO1a+4pfew7R0mnfMUiazB61K+lhQ29B+V5KzscY2ITa/biSQMbeU1n8qrETpOqLu7
 LBmA==
X-Gm-Message-State: AOJu0YxyL8FkgQDqfgowgDxrkgMg034n3MU7wgWc2ZBnQNJv/pWL9QRe
 oB9JOvezP5Fe+sE0Y/JJARZRNIajgo0urOZAm2OkjAxGKFVSJ4GXrjChEkpN7h4=
X-Google-Smtp-Source: AGHT+IHTsWsfWrLQ7i0ibA8Tsg0duIIL0f2/SiksqZWvXyIctryf5aUMgO+2qy1gTxNXPlqU1H0Uug==
X-Received: by 2002:a17:907:d403:b0:a72:554d:829c with SMTP id
 a640c23a62f3a-a72554d8597mr180973266b.3.1719223764321; 
 Mon, 24 Jun 2024 03:09:24 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a724d8a362fsm140804066b.158.2024.06.24.03.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 03:09:23 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CEE335F789;
 Mon, 24 Jun 2024 11:09:22 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] .travis.yml: Install python3-tomli in all build jobs
In-Reply-To: <20240624094807.182313-1-thuth@redhat.com> (Thomas Huth's message
 of "Mon, 24 Jun 2024 11:48:07 +0200")
References: <20240624094807.182313-1-thuth@redhat.com>
Date: Mon, 24 Jun 2024 11:09:22 +0100
Message-ID: <87tthips8d.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Thomas Huth <thuth@redhat.com> writes:

> Since commit 1f97715c83 ('Revert "python: use vendored tomli"')
> this package is a hard requirement for compiling QEMU, so install
> it now in all Travis jobs, too.

AFAICT the only repo currently running these tests is your github
mirror:

  https://app.travis-ci.com/github/huth/qemu/builds?serverType=3Dgit

Because both the official github mirror and the gitlab project haven't
run anything for a while:

  https://app.travis-ci.com/gitlab/qemu-project/qemu/branches
  https://app.travis-ci.com/github/qemu/qemu/branches

I've never been able to get anything to build since they transitioned to
TravisCI.com

>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .travis.yml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/.travis.yml b/.travis.yml
> index cef0308952..8fc1ae0cf2 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -106,6 +106,7 @@ jobs:
>            - libvdeplug-dev
>            - libvte-2.91-dev
>            - ninja-build
> +          - python3-tomli
>            # Tests dependencies
>            - genisoimage
>        env:
> @@ -141,6 +142,7 @@ jobs:
>            - libvdeplug-dev
>            - libvte-2.91-dev
>            - ninja-build
> +          - python3-tomli
>            # Tests dependencies
>            - genisoimage
>        env:
> @@ -175,6 +177,7 @@ jobs:
>            - libvdeplug-dev
>            - libvte-2.91-dev
>            - ninja-build
> +          - python3-tomli
>            # Tests dependencies
>            - genisoimage
>        env:
> @@ -215,6 +218,7 @@ jobs:
>            - libzstd-dev
>            - nettle-dev
>            - ninja-build
> +          - python3-tomli
>            # Tests dependencies
>            - genisoimage
>        env:
> @@ -231,6 +235,7 @@ jobs:
>            - ninja-build
>            - flex
>            - bison
> +          - python3-tomli
>        env:
>          - TEST_CMD=3D"make check check-tcg V=3D1"
>          - CONFIG=3D"--disable-containers --disable-system"
> @@ -263,6 +268,7 @@ jobs:
>            - libvdeplug-dev
>            - libvte-2.91-dev
>            - ninja-build
> +          - python3-tomli
>        env:
>          - TEST_CMD=3D"make check-unit"
>          - CONFIG=3D"--disable-containers --disable-tcg --enable-kvm --di=
sable-tools

FWIW the changes themselves look fine:

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

