Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9A8C47DB3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 13:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVtVS-0001kl-41; Fri, 02 Feb 2024 08:22:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVtVQ-0001kS-9k
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 08:22:56 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVtVO-0003H0-BR
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 08:22:56 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55ff5f6a610so630410a12.3
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 05:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706880172; x=1707484972; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qM3jajMyn5VF4lY9Ljtcsu1y92ARdlUKFqOT8XTHUtE=;
 b=lBDm8KwddqCMz89LPA7ngbLMtyRICz9hi2euTE8F7dGnqNTzPG2oBfeUeSmJ7Y7EqH
 HA/hdFU/E5RD8u1tfK0jWIhdCfSHuVtu7+JlVnIeyGc0vdO5uq/Ycl1aAbDu3AKdZIzi
 RjGtM8xSC9SQUnj2FEsbokwHJiFZcaZ3I4c5/R6OPnd9MWOaXuIeY/iyUxhOQKb8vEOO
 ACM3sH2/I/nN/j6nTxpi6GjhJlL6WQXDju1KAMs4DusuUfoqA0AKlViGVmuUngcS2G15
 t/Z1A+fjsHbTT05M9eqtJZzNjSn3djnw83Xia7X/Q8yMdlhLHqpq/R4EjDPXujQXGHmq
 6kYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706880172; x=1707484972;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qM3jajMyn5VF4lY9Ljtcsu1y92ARdlUKFqOT8XTHUtE=;
 b=AR8IIgL42CUbaYQlNzQLfKUfR5RRZA54B0wyhhppYzU8Eq1irnoJjSiCoJZRx+VxM4
 pySflf7g0ujyklUrQo9vS/Za6C4RDGGSSXeGx4frVK8CWfPbl23aruPItBWRMqlpoecO
 BIrnLDD+Sakvjj1DMm7MeeV+yHbbGTCKMH0RqhISv/mIVJVyMhuj5nBqZZtTSNEfr+mL
 Pw9Bcvh+OKyYOAhE/7/qhbFs8gPWq0ay5AaMVO4SrwWuz+JoSyyb6aV90dHn22G5DL8x
 N/fjgNzNCMkRFRqSWHTy5L9PJFFU+sV+URxhbLwL4RFzEo36MBJJKbHbofQCz+p1U/Pe
 zZqg==
X-Gm-Message-State: AOJu0YxLD3LWmGXXm1ysjpQB6EoLXKu5wh5LwV+aALrrrMtpcuisb7cL
 946nH5GWjumEHI6G5x8RUoCC5yDdhw/0j6V3nFjuXf5oGWjx6r2AlZj0BPVBqGuJ4dgIYexW3ke
 /mw0zlVarJXH2Rvg25zgBIyV7C6s/vCiLprKWqw==
X-Google-Smtp-Source: AGHT+IHDc1r420SBRHcr9IeCyaGbg84u21H/tI10IRt75IePgyZPF434pN2h1synNMJ389hIHzzYH3tja1YR90/P9cE=
X-Received: by 2002:a05:6402:1d29:b0:55f:8031:501c with SMTP id
 dh9-20020a0564021d2900b0055f8031501cmr5719183edb.30.1706880171913; Fri, 02
 Feb 2024 05:22:51 -0800 (PST)
MIME-Version: 1.0
References: <20240129030405.177100-1-peterx@redhat.com>
 <20240129030405.177100-7-peterx@redhat.com>
In-Reply-To: <20240129030405.177100-7-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Feb 2024 13:22:41 +0000
Message-ID: <CAFEAcA9=7NzEFLQxAxEWUzTRAZm87caC1ZhxeZkKyiP9Kb4k2w@mail.gmail.com>
Subject: Re: [PULL 06/14] ci: Add a migration compatibility test job
To: peterx@redhat.com
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 29 Jan 2024 at 03:04, <peterx@redhat.com> wrote:
>
> From: Fabiano Rosas <farosas@suse.de>
>
> The migration tests have support for being passed two QEMU binaries to
> test migration compatibility.
>
> Add a CI job that builds the lastest release of QEMU and another job
> that uses that version plus an already present build of the current
> version and run the migration tests with the two, both as source and
> destination. I.e.:
>
>  old QEMU (n-1) -> current QEMU (development tree)
>  current QEMU (development tree) -> old QEMU (n-1)
>
> The purpose of this CI job is to ensure the code we're about to merge
> will not cause a migration compatibility problem when migrating the
> next release (which will contain that code) to/from the previous
> release.
>
> The version of migration-test used will be the one matching the older
> QEMU. That way we can avoid special-casing new tests that wouldn't be
> compatible with the older QEMU.
>
> Note: for user forks, the version tags need to be pushed to gitlab
> otherwise it won't be able to checkout a different version.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> Link: https://lore.kernel.org/r/20240118164951.30350-3-farosas@suse.de
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  .gitlab-ci.d/buildtest.yml | 60 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index e1c7801598..f0b0edc634 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -167,6 +167,66 @@ build-system-centos:
>        x86_64-softmmu rx-softmmu sh4-softmmu nios2-softmmu
>      MAKE_CHECK_ARGS: check-build
>
> +# Previous QEMU release. Used for cross-version migration tests.
> +build-previous-qemu:
> +  extends: .native_build_job_template
> +  artifacts:
> +    when: on_success
> +    expire_in: 2 days
> +    paths:
> +      - build-previous
> +    exclude:
> +      - build-previous/**/*.p
> +      - build-previous/**/*.a.p
> +      - build-previous/**/*.fa.p
> +      - build-previous/**/*.c.o
> +      - build-previous/**/*.c.o.d
> +      - build-previous/**/*.fa
> +  needs:
> +    job: amd64-opensuse-leap-container
> +  variables:
> +    IMAGE: opensuse-leap
> +    TARGETS: x86_64-softmmu aarch64-softmmu
> +  before_script:
> +    - export QEMU_PREV_VERSION="$(sed 's/\([0-9.]*\)\.[0-9]*/v\1.0/' VERSION)"
> +    - git checkout $QEMU_PREV_VERSION
> +  after_script:
> +    - mv build build-previous

There seems to be a problem with this new CI job. Running a CI
run in my local repository it fails:

https://gitlab.com/pm215/qemu/-/jobs/6075873685

$ export QEMU_PREV_VERSION="$(sed 's/\([0-9.]*\)\.[0-9]*/v .0/' VERSION)"
$ git checkout $QEMU_PREV_VERSION
error: pathspec 'v8.2.0' did not match any file(s) known to git
Running after_script
Running after script...
$ mv build build-previous
mv: cannot stat 'build': No such file or directory
WARNING: after_script failed, but job will continue unaffected: exit code 1
Saving cache for failed job


I don't think you can assume that private forks doing submaintainer CI
runs necessarily have the full set of tags that the main repo does.

I suspect the sed run will also do the wrong thing when run on the
commit that updates the version, because then it will replace
"9.0.0" with "9.0.0".

thanks
-- PMM

