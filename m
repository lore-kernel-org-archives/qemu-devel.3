Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDE4C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 07:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueqox-00020n-J7; Thu, 24 Jul 2025 03:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ueqov-0001wN-Ej
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 03:56:53 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ueqoq-00034R-CS
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 03:56:53 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-60c5b8ee2d9so1498743a12.2
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 00:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753343806; x=1753948606; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2VR1cJyg9YuhXgvDczjIuun+qGqSGpV2yx4nYrvOvXI=;
 b=PmwC+fJ8DGSiGwQW3aL2icCO5lbIgV2ZCsMbJZrPR0hsOMvew4tNi8uErd5pXwUkY/
 zhaHZ1DhB9mDB2JOFE/yi4cWRLNTOQDf8afn4K/wbhqv4pQmTT5in+OWVTA7ygayWKNU
 P27ArR0tQqizB1r2ajr4gJ3BGN3LuhoIrOE2aQEYa7IzlRBxpc6fDtDy8LUDDfHkL/wC
 8UYVTRbz3AdfrajM46IZl2AUTG7V0T2XltNI/kIoFy/7dBUy6dgm8RDDfGH89pm2BmXo
 +yulymrqODy6YOEJNbXJEHNT17gCZEV6KhbmZOoUYJQ2SE/45PXvSFUz/JFt3i28FSje
 ejZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753343806; x=1753948606;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2VR1cJyg9YuhXgvDczjIuun+qGqSGpV2yx4nYrvOvXI=;
 b=cWVMQAbFZKRpP7fmnZbKJh8teNy3xXuUOLvGXkGmBupb08HDVIc7as2HOyFFzwMq25
 wuCyRoX/XwpPZf6+xGm6A9zAVbcAw6m6XVglUDjMO69LjN/4J3hYk6whS3B08bcWtLKx
 D+A8PTd5kS/gQvG51s7VXouM+w4ubQ2TEiOHMzQkqEnjzJB8KEhfAAa8E1VEnow1PP/O
 aN5+OlbO691P1kcrbrHBVsitc72izzj2Q516H3XNo110OryUogbGpvVhz3Kfsqivv1ch
 nmNCNCewVoko076tcwVsHjq3hUtEEJ/OxbpUe/tu5L3ugHr7OhuWnGweGcCR090yOhKd
 RzKQ==
X-Gm-Message-State: AOJu0YxKSGaxhHF5ipBZ+PU4hcXECKpidfllYav4z3wp5VMtsHWYrLM3
 WRjkByVQQcn2Nn0sunGUacBdD3N1WSbbczohpdi7WhOayB1QtJT/CuvyjSxybw+pV3P2OwR2zZL
 +2gfpeUYfZiIZqfszL9JWA0bJBJbIXo2aYko8DZ6dlNDEwFutVTRj
X-Gm-Gg: ASbGnctxkww4GbtNnmIZnXOdbwnTMUZUe3zlUbeGrTRTWyUFuJhJQLdV3Qv9NIcuCSB
 wS1aDJXUIJJGuxKMzRzncbs3vX6ZA5bxoiXpdV/JZEe7YfFZU80J6iTRBRMuOZAmOVRaTvJICpD
 C+1LV0TTOgWUlIdsD2VZNmzZHZGhQfMcTQief+FjJ6lWreuf4/EyWjAEftFaSZZ0zDYHRIMinZt
 Jbnrwqr67+ILEPs
X-Google-Smtp-Source: AGHT+IEXC96ZvJruZFLki//TdFiQ8HzGVKU5xzrlJhYZgi7D8clJsohh212TwfyS4BYSLRfXj19/2PF/lzs15+xP54E=
X-Received: by 2002:a05:6402:5241:b0:608:a7a0:48 with SMTP id
 4fb4d7f45d1cf-6149b5b11ccmr5636532a12.28.1753343806394; Thu, 24 Jul 2025
 00:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250717-docs_add_b4_section-v2-1-69212ed39299@linaro.org>
In-Reply-To: <20250717-docs_add_b4_section-v2-1-69212ed39299@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Jul 2025 10:56:19 +0300
X-Gm-Features: Ac12FXwYPe4Yae7AlfUhHCVI6yDj9xMO8d5dIp2zZdeOIAGCWJ7XrzBdij5OQ_0
Message-ID: <CAAjaMXaCNM95LFZ8aeDHHQEHAtQM7iu1du5poSwF7cEqWK6fwQ@mail.gmail.com>
Subject: Re: [PATCH v2] docs/devel/submitting-a-patch.rst: add b4 section
To: qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Jul 17, 2025 at 9:59=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> Add a section about b4, an actively maintained and widely packaged CLI
> tool for contributing to patch-based development projects.
>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
> Changes in v2:
> - s/later/letter and add review trailers (thanks Gustavo)
> - Link to v1: https://lore.kernel.org/qemu-devel/20250717-docs_add_b4_sec=
tion-v1-1-2dfb4ad2fe07@linaro.org
> ---

(Ping)

Alex, does this look OK to you? If yes could you pick it up?

>  docs/devel/submitting-a-patch.rst | 40 +++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-=
patch.rst
> index f7917b899f6892ef74908fe8f1399b6ae5a30324..dd1cf32ad35a98528f43918ec=
eb2cc8a4847c5b6 100644
> --- a/docs/devel/submitting-a-patch.rst
> +++ b/docs/devel/submitting-a-patch.rst
> @@ -235,6 +235,38 @@ to another list.) ``git send-email`` (`step-by-step =
setup guide
>  works best for delivering the patch without mangling it, but
>  attachments can be used as a last resort on a first-time submission.
>
> +.. _use_b4:
> +
> +Use B4
> +~~~~~~
> +
> +The `b4`_ tool, used for Linux kernel development, can also be used for =
QEMU
> +development. It is packaged in most distros and PyPi. The QEMU source tr=
ee
> +includes a ``b4`` project configuration file at the root: ``.b4-config``=
.
> +
> +Example workflow to prepare a patch series:
> +
> +1. Start with a clean checkout of the ``master`` branch.
> +2. Create a new series with a topical branch name using ``b4 prep -n des=
criptive-name``.
> +   ``b4`` will create a ``b4/descriptive-name`` branch and switch to it.
> +3. Commit your changes, following this page's guidelines about proper co=
mmit messages etc.
> +4. Write a descriptive cover letter with ``b4 prep --edit-cover``.
> +5. Add maintainer and reviewer CCs with ``b4 prep --auto-to-cc``. You ca=
n make
> +   changes to Cc: and To: recipients by editing the cover letter.
> +6. Run patch checks with ``b4 prep --check``.
> +7. Optionally review the patches with ``b4 send --dry-run`` which will p=
rint the
> +   raw patches in standard output.
> +
> +To send the patches, you can:
> +
> +- Setup ``git-send-email`` and use ``b4 send``, or
> +- Export the patches to files using ``b4 send -o OUTPUT_DIR`` and send t=
hem manually.
> +
> +For more details, consult the `b4 documentation`_.
> +
> +.. _b4 documentation: https://b4.docs.kernel.org/
> +.. _b4: https://github.com/mricon/b4/
> +
>  .. _use_git_publish:
>
>  Use git-publish
> @@ -418,7 +450,7 @@ Retrieve an existing series
>  ---------------------------
>
>  If you want to apply an existing series on top of your tree, you can sim=
ply use
> -`b4 <https://github.com/mricon/b4>`__.
> +`b4`_.
>
>  ::
>
> @@ -533,7 +565,11 @@ summary belongs. The `git-publish
>  <https://github.com/stefanha/git-publish>`__ script can help with
>  tracking a good summary across versions. Also, the `git-backport-diff
>  <https://github.com/codyprime/git-scripts>`__ script can help focus
> -reviewers on what changed between revisions.
> +reviewers on what changed between revisions. The ``b4`` tool automatical=
ly
> +generates a version history section in the cover letter, including links=
 to the
> +previous versions on `Lore`_.
> +
> +.. _Lore: https://lore.kernel.org/
>
>  .. _tips_and_tricks:
>
>
> ---
> base-commit: f96b157ebb93f94cd56ebbc99bc20982b8fd86ef
> change-id: 20250717-docs_add_b4_section-fc37e538b20b
>
> --
> =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=
=CE=B8=CE=AE=CF=84=CF=89
>

