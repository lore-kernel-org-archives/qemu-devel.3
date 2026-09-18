Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E62BC982DC
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7YZf-0005uo-JN; Fri, 18 Sep 2026 09:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x7YZd-0005u5-Iy
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:24:17 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x7YZb-0000fg-BH
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:24:16 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2dd68a16955so17545865ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 06:24:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789737853; cv=none;
 d=google.com; s=arc-20260327;
 b=YE0qZfosdvvpg/hPFYmAe1WO/B46LbqTfxjlf/e6ZmGzDWbwybfprFclmRCTdANaNI
 O2m0qK5PsmXCIl9e+zYkExJmi6xgOnnOt1qSoOYGYmw4+TMvUhyGw6nbfZBoI+fLvZph
 UEKv+tdq1Gb+WzL1MHyD6tfzP9uvEjwhkhpZ5knLJh9qwgmu++whVu7FjYhyTNnBRU6c
 pum+Chiu85MpCDu/TW5C9cRXE0bJwAHu/Dk9kWJv0E7BQtmrmZ/PVWfGfwrTbq2n/Vl2
 deUwmn+x8cZcG/emy+RxLys1YkCFCxLUJiq38HGZm3ofIvIhIdatJNLL2jf8r8bfNI0u
 foxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L6IlHJ5Ab2Vh/643P00h0qFuUUJaOdk3hzAyRPB1X4g=;
 fh=ENXAnnRW8gtw1FNrhi0Ovuz9ptrShCXiU5SEw5N51X0=;
 b=YXKJCLI3y1vLs+Bdjz8sM2t/BitAMXO778dLuahQktyfjmoIcbwuEaPYGM7fsoMUxe
 hlg7ptNnb+gxViXt5Yx288KcLundo7hblJfkNJit+GHza0wHpRi/3GI2gd5+AVVwnF1n
 RnJ/fA6+fgfiTYJYzb6CPrgc4sNnVNz1zTdWQ75FjhfwOmnn1MmMSoEnyhsEPwG/RxUj
 PTIHSm2pPlCexSrkLiXQaHkhi0iF/scUPAtKnTjzCcuCOFvAvsJmP2qJDorIIZAFAdD+
 aYwH/bdwTwqgjLemlLjnZxVFf4PcbS/rr+Ryi+o6j7osLtAnwIgqKfwX3acZ41aFbqt/
 XzkA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789737853; x=1790342653; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L6IlHJ5Ab2Vh/643P00h0qFuUUJaOdk3hzAyRPB1X4g=;
 b=JiO9BDE8DO+lB4b/TZPGOKgy80hKt90WAg7jZysqOwZMrEBOPxLsI6b0u19sLjbGLi
 9Lldnq9IU8hBqPyCeMpCUCUU8TT06lAIIkIvmezHs4D5vBAP0PIqN9MgEjBVLvDOBsNm
 dFjtKOIlqkxHtzdMkTQ35RRYVf47yH6Jw+a91No8plBZu+QpTL5O9jPuxKrtpELXwJPu
 uzwrzK+ObOoxyBeWlmDKyePdEFn1b5/eiHzEvgyovQQ0yEgKY67FAlMaTuGoDXh9lpZz
 syX8o7ZxUqZQ+HP9GRJ1wyeYoCUHtFmFi/AXMkIwk/2AIiBPeOPR8ZY6XMIu/Jz7+R2j
 Ng8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789737853; x=1790342653;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L6IlHJ5Ab2Vh/643P00h0qFuUUJaOdk3hzAyRPB1X4g=;
 b=y8WOS7DPi2oAQ6o1gmLRM41Y0+n84de7ibx9eKO/e0HyqboGWOQCwIr2bgNpaPfbjB
 NYqQr+JQxdDBTV0D6AqIODYbcw8hbu05MBiFCUY2/c1/Peu2IJL6I99+v2I1EJ5VyOBO
 +qi0073zrweHjboS06XSUSSxZJkJJPz9gt6qYwRiOrOfgThcpF3wJpcZzWFK7/ai/ESo
 /Xeg9cBNW89JyD/yPcyb/M/E68iGG2j01T+ctAlcEqqzqZc1z6hQ7H28MujodKZ49bSY
 hg+4xi0GYgU4EKWMSnxMaHS1rrAFIEIZBHm+H1j7ziCs0A/N/vY6xS/XaA53Ck75teqg
 BD9g==
X-Gm-Message-State: AFuF++knt7zBHZjiyCie42c/n5BLlW6XNqS4xXSiU7cjgWCxuU2NhLaQ
 Aje49zCPx6hDDldN0fMNE7zD+2GI9VTTNUrV0MbyVV4TaprqOM48NQ6JZO2PSrQ0JDx1AG7loWB
 9ZGrKvlrld8xW/RFnAQuNcEJBFEXQqNDYLD19
X-Gm-Gg: AYBFou1Giye67UypMyvI3HGaQqutntrkNY9iN8jK2VnO65z3DlrQDtTG1/jmwMsmetV
 ghyMRa3S5GymI/Ci/2yRA/P0BUA1Y3vZMGI4BTJ9IHVYfuyjCiktqgGKHQ0pm4u+/mgJe7J9iH9
 Xkh3VIgKqePXsryrlzeE+XXDLI9kTIDfn+5uYM4LbKRImNmXugZ/rsGbV61hxr1vvH9Bmm9E4ad
 iXFmT3q2wBZBa7nt0d3rznA6yW3EXDmY76JlXvYyWN1tNvNYI53Btk7HO5vqn1LADbPZQoVVtxP
 MNRhNdPHW2aThc2/RDjpjNBq8GZ6BWUwnOH6HiJO0GB1KWVx/31vUD8oOZdy2TKW2BpyILeXue1
 4blCYQO+MvPM=
X-Received: by 2002:a17:90a:ec8c:b0:37f:e5b1:ec4b with SMTP id
 98e67ed59e1d1-39e35da0512mr11155754a91.5.1789737853155; Fri, 18 Sep 2026
 06:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260911154235.448312-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260911154235.448312-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 18 Sep 2026 17:23:59 +0400
X-Gm-Features: AcwNN1XCCV5Y5EL7yczDn1nM5Xiw4lxqO1rwc7TS8f1VFlOVX-iyf99xo2A4omU
Message-ID: <CAJ+F1CLqKJfBb6+WUQLtc8+SFSttXj9xh0GGjtcZOWkeF7MhdA@mail.gmail.com>
Subject: Re: [PATCH] tests: add SELinux label to container volume mounts
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

Hi

On Fri, Sep 11, 2026 at 7:44=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The cross-compilation container mounts lack the :z SELinux label.
> On Fedora with SELinux enforcing, container_t is denied read
> access to user_home_t files, failing the build.
>
> Add :z to volume mounts in docker.py CompilerRecipe and in the
> TCG meson.build, matching the existing extra source paths.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

superseded by Pierrick's version:
https://patchew.org/QEMU/20260917221117.274619-1-pierrick.bouvier@oss.qualc=
omm.com/

> ---
>  tests/docker/docker.py | 2 +-
>  tests/tcg/meson.build  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 315fa2ff848f..bdfea380339d 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -626,7 +626,7 @@ def run(self, args, argv):
>              argv =3D argv[1:]
>          cwd =3D os.getcwd()
>          cmd =3D ["-w", cwd,
> -               "-v", "%s:%s:rw" % (cwd, cwd)]
> +               "-v", "%s:%s:rw,z" % (cwd, cwd)]
>          if args.paths:
>              for p in args.paths:
>                  cmd +=3D ["-v", "%s:%s:ro,z" % (p, p)]
> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
> index d41a228fb3df..221c277dd09a 100644
> --- a/tests/tcg/meson.build
> +++ b/tests/tcg/meson.build
> @@ -266,7 +266,7 @@ foreach target, plan: tcg_tests
>        build_test_depends +=3D image_targets[cc_dockerfile]
>        build_test_depend_files +=3D dockerfile
>        mount =3D meson.project_source_root()
> -      mount =3D mount + ':' + mount
> +      mount =3D mount + ':' + mount + ':z'
>        here =3D meson.project_build_root()
>        cc =3D [docker_wrapper, 'run', '--run-as-current-user',
>              '-w', here, '-v', mount,
> --
> 2.55.0.543.g5ebe2ebe4ea8
>
>

