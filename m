Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60556C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 05:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whh4Y-0000Fh-F0; Thu, 09 Jul 2026 01:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1whh4X-0000FY-IY
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 01:13:17 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1whh4V-0006Pp-GZ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 01:13:17 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6986578d8c0so742832a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 22:13:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783573991; cv=none;
 d=google.com; s=arc-20260327;
 b=oc6kVwx4klvKb/ttyp5bc0mYBeS+ihvW68pmYTajjvXa5BKAPcPeN2BCkRP1rVAK4O
 AUgMPo0nfzmxymOPycFzm0SR6T3h//TOcNnfvMWUEXc9hnUMpDcDhL/K8BiBC3RnlLTH
 CU9N2q97YhQ+9bBdwDOwxgeMxQiPuc+Kc3V477Rz9WmDHt9S2qOqzSy0X11UrgiRF4y6
 VwmvKJpoTLbw3bgdiuvWfBSRbTGTFf2aFtgZBGA8KE8p9tnAvrL7eRnX+mC+cyZmYxZ4
 vT/3Ghonth5orDO62iZcPH+cHRbawRs8yv/kPYGnDrPT4ivg16LXIgAWNRtCkRGDuZk3
 ke9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8yheC23Fu7BnrPVtyitxwmCziP0KD0Q2ZaaJxs8SOa8=;
 fh=m/WZA3u3rBkZ+1/typaUaOujij8qXHEnx536J+geYTw=;
 b=XmImuH1zK6O/yfZcjxT3fQL6+rPEWFFSU6mutZzzSQ6lMPmogu4jswM4L/opIgytP0
 HsLGYs+abu2M7hy4UGL6AydWDAHRAIbRdqR8veztyv79X007AjEXp3G0mzL2obUP5JME
 GtXsQtBGSWDW+aoLnV0E7TRd1RCPIBcL/oXjfu5wOUwMM0vqI7HfNu4LNuK+iyAIOsn+
 sfiOzMWmzN/N+5GDgfrqn021G5Qmg2qnhjQm+d5yJ2mHXCkYeKHQjcAztqVlf+wG16cc
 f3HqCnqDieC8ACmGNW4KNhfUDkhrOC4YviixCuAPj0EbZtTt4buaRu4+juyR46T3xLQo
 S4WA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783573991; x=1784178791; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8yheC23Fu7BnrPVtyitxwmCziP0KD0Q2ZaaJxs8SOa8=;
 b=I5fVtV45R7t/hAWcBbiAtVVY6r7L7zyxNdqgNqJpEyE1dYqGIAirE8yrQrJxjj4v0N
 22LeAZi9U5Ya/mczFdc50pCOrtBlJSoTRHbmjraXdrO9ntyyw2mRwqK5HxsACaeKwT/T
 1MEPvg7LOiNhRahiKjnP1RPzQH5FO5iJgl+Rhu/wQ/YHRrjnKfQPKyg+m8Dn14S0PA+5
 a9RFqXACUx4+CUrQnG0+BTr6EDarMRsqApoxkU+5XMtXgaJiYms7JNzMcXz0DUCnvFrz
 q50027JLpl3J9sewiOiPrev+jWTWjB5MT8jKzdqtG20y1jBuPmlt/VihA0dX55PF0WBy
 zbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783573991; x=1784178791;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8yheC23Fu7BnrPVtyitxwmCziP0KD0Q2ZaaJxs8SOa8=;
 b=SKPe0rqb8Sw/3+3C4uP8mWQ71m/hDqdYJGeY11sF/UgCO9DtwRjbO/TkzXSnRaaT1W
 NQujh0SpnxcqwyQdef7xxThsw2dN6vL7yZXgj5L1sa/68whgt5wWQlofUeg3jxbqHUqK
 X6XA8t9Onc/xmnM79HmfED+ugFEbFkTI8rGn0HlGA/10S+wEGzt3DNyZWW+SG2LaxgZv
 pMLisGBLXuq8aGuVxDSuDRP8U7kl+tgIC53/Qktd+hH46nsXz44oRdX9EWrA2wMO6Nov
 3tbxl2PHE0PWxvs/3SI2Jn47OAMCdeuma8OhD2F14rhv0QRYiIyzN6CRjYQ0ODd+zitB
 xnSg==
X-Gm-Message-State: AOJu0YwP7yTqB682zV0JILF/3iXD3U7oQLVzkjtjnq3SLpdT3KVyF7PN
 b2Nffqomeuq+AJ6Re9j4asOmQ0ssQytDZnyuyxWThAihpC/qqVgCQIaiC9ynUli72xBfZzgeuUq
 b0uAupiDkp7ivA2myDNFDKhHWLXg1lhU=
X-Gm-Gg: AfdE7cmI0dSAVBrGN8FodWZRFLRgCZjA4q5mUZpoNE4aBRkW3tYyPcVJ/AIHUkI7kSu
 tGJqSxJ7y941wKqeOftgDZF5nBGhuNvH8hy23dDF5moHCE+lNmNVn/+Oe6kqcbzhetXAetA58os
 RMO0ywqiWLBliXP9WnrM7OTlHFRcVQ167NqnIufPmOywRchc47idLdi4sTpb1y9K8IK5NmxlyVf
 bdeOeRTcYuI+nfrvLfjCEEuE5QyIvI7wzCYlaXTiLA6fcj7TYpyQe2I/w5A0vjNpcHvyLTLkOwo
 6Q6mZ1k2gyC49Fdw2ybQKBHK6ZU=
X-Received: by 2002:a05:6402:4303:b0:698:3946:b78e with SMTP id
 4fb4d7f45d1cf-69ab4451c88mr2034100a12.5.1783573991200; Wed, 08 Jul 2026
 22:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260706161716.29488-1-bin.meng@processmission.com>
In-Reply-To: <20260706161716.29488-1-bin.meng@processmission.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Jul 2026 15:12:44 +1000
X-Gm-Features: AUfX_myHysVwGqtWqQ67Ko0ynSj3XUs4vZYbeFXnmNZ4BMEyjIwZrON-k8ol3J0
Message-ID: <CAKmqyKMURcgzxxA6oOYSMvxbCJ_-cZXjgwF3ioKG5yczSakHrw@mail.gmail.com>
Subject: Re: [PATCH] gitlab-ci: Remove job building OpenSBI firmware binaries
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Jul 7, 2026 at 2:23=E2=80=AFAM Bin Meng <bin.meng@processmission.co=
m> wrote:
>
> The OpenSBI firmware build job follows the same pattern as the EDK2 job
> [1] that was removed earlier [2]: it exists to produce firmware binaries
> from CI artifacts, but those outputs are not consumed by the tree.
>
> Remove the job definition and its project include to avoid maintaining
> bitrotting container and firmware build logic.
>
> [1] 71920809ceab ("gitlab-ci.yml: Add jobs to build EDK2 firmware binarie=
s")
> [2] 690ceb71936f ("gitlab-ci: Remove job building EDK2 firmware binaries"=
)
>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

>
> ---
>
>  MAINTAINERS                     |  2 -
>  .gitlab-ci.d/opensbi.yml        | 88 ---------------------------------
>  .gitlab-ci.d/opensbi/Dockerfile | 34 -------------
>  .gitlab-ci.d/qemu-project.yml   |  1 -
>  4 files changed, 125 deletions(-)
>  delete mode 100644 .gitlab-ci.d/opensbi.yml
>  delete mode 100644 .gitlab-ci.d/opensbi/Dockerfile
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 97dcc78ded..59707bf2a7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4117,8 +4117,6 @@ R: Daniel Henrique Barboza <daniel.barboza@oss.qual=
comm.com>
>  L: qemu-riscv@nongnu.org
>  S: Supported
>  F: pc-bios/opensbi-*
> -F: .gitlab-ci.d/opensbi.yml
> -F: .gitlab-ci.d/opensbi/
>
>  Clock framework
>  M: Luc Michel <luc@lmichel.fr>
> diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
> deleted file mode 100644
> index 42f137d624..0000000000
> --- a/.gitlab-ci.d/opensbi.yml
> +++ /dev/null
> @@ -1,88 +0,0 @@
> -# All jobs needing docker-opensbi must use the same rules it uses.
> -.opensbi_job_rules:
> -  rules:
> -    # Forks don't get pipelines unless QEMU_CI=3D1 or QEMU_CI=3D2 is set
> -    - if: '$QEMU_CI !=3D "1" && $QEMU_CI !=3D "2" && $CI_PROJECT_NAMESPA=
CE !=3D "qemu-project"'
> -      when: never
> -
> -    # In forks, if QEMU_CI=3D1 is set, then create manual job
> -    # if any files affecting the build output are touched
> -    - if: '$QEMU_CI =3D=3D "1" && $CI_PROJECT_NAMESPACE !=3D "qemu-proje=
ct"'
> -      changes:
> -        - .gitlab-ci.d/opensbi.yml
> -        - .gitlab-ci.d/opensbi/Dockerfile
> -        - roms/opensbi/*
> -      when: manual
> -
> -    # In forks, if QEMU_CI=3D1 is set, then create manual job
> -    # if the branch/tag starts with 'opensbi'
> -    - if: '$QEMU_CI =3D=3D "1" && $CI_PROJECT_NAMESPACE !=3D "qemu-proje=
ct" && $CI_COMMIT_REF_NAME =3D~ /^opensbi/'
> -      when: manual
> -
> -    # In forks, if QEMU_CI=3D1 is set, then create manual job
> -    # if the last commit msg contains 'OpenSBI' (case insensitive)
> -    - if: '$QEMU_CI =3D=3D "1" && $CI_PROJECT_NAMESPACE !=3D "qemu-proje=
ct" && $CI_COMMIT_MESSAGE =3D~ /opensbi/i'
> -      when: manual
> -
> -    # Scheduled runs on mainline don't get pipelines except for the spec=
ial Coverity job
> -    - if: '$CI_PROJECT_NAMESPACE =3D=3D $QEMU_CI_UPSTREAM && $CI_PIPELIN=
E_SOURCE =3D=3D "schedule"'
> -      when: never
> -
> -    # Run if any files affecting the build output are touched
> -    - changes:
> -        - .gitlab-ci.d/opensbi.yml
> -        - .gitlab-ci.d/opensbi/Dockerfile
> -        - roms/opensbi/*
> -      when: on_success
> -
> -    # Run if the branch/tag starts with 'opensbi'
> -    - if: '$CI_COMMIT_REF_NAME =3D~ /^opensbi/'
> -      when: on_success
> -
> -    # Run if the last commit msg contains 'OpenSBI' (case insensitive)
> -    - if: '$CI_COMMIT_MESSAGE =3D~ /opensbi/i'
> -      when: on_success
> -
> -docker-opensbi:
> -  extends: .opensbi_job_rules
> -  stage: containers
> -  image: docker:latest
> -  services:
> -    - docker:dind
> -  variables:
> -    GIT_DEPTH: 3
> -    IMAGE_TAG: $CI_REGISTRY_IMAGE:opensbi-cross-build
> -  before_script:
> -    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REG=
ISTRY
> -    - until docker info; do sleep 1; done
> -  script:
> -    - docker pull $IMAGE_TAG || true
> -    - docker build --cache-from $IMAGE_TAG --tag $CI_REGISTRY_IMAGE:$CI_=
COMMIT_SHA
> -                                           --tag $IMAGE_TAG .gitlab-ci.d=
/opensbi
> -    - docker push $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
> -    - docker push $IMAGE_TAG
> -
> -build-opensbi:
> -  extends: .opensbi_job_rules
> -  stage: build
> -  needs: ['docker-opensbi']
> -  artifacts:
> -    when: on_success
> -    paths: # 'artifacts.zip' will contains the following files:
> -      - pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
> -      - pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
> -      - opensbi32-generic-stdout.log
> -      - opensbi32-generic-stderr.log
> -      - opensbi64-generic-stdout.log
> -      - opensbi64-generic-stderr.log
> -  image: $CI_REGISTRY_IMAGE:opensbi-cross-build
> -  variables:
> -    GIT_DEPTH: 3
> -  script: # Clone the required submodules and build OpenSBI
> -    - git submodule update --init roms/opensbi
> -    - export JOBS=3D$(($(getconf _NPROCESSORS_ONLN) + 1))
> -    - echo "=3D=3D=3D Using ${JOBS} simultaneous jobs =3D=3D=3D"
> -    - make -j${JOBS} -C roms/opensbi clean
> -    - make -j${JOBS} -C roms opensbi32-generic 2>&1 1>opensbi32-generic-=
stdout.log | tee -a opensbi32-generic-stderr.log >&2
> -    - make -j${JOBS} -C roms/opensbi clean
> -    - make -j${JOBS} -C roms opensbi64-generic 2>&1 1>opensbi64-generic-=
stdout.log | tee -a opensbi64-generic-stderr.log >&2
> diff --git a/.gitlab-ci.d/opensbi/Dockerfile b/.gitlab-ci.d/opensbi/Docke=
rfile
> deleted file mode 100644
> index 5ccf4151f4..0000000000
> --- a/.gitlab-ci.d/opensbi/Dockerfile
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -#
> -# Docker image to cross-compile OpenSBI firmware binaries
> -#
> -FROM ubuntu:18.04
> -
> -MAINTAINER Bin Meng <bmeng.cn@gmail.com>
> -
> -# Install packages required to build OpenSBI
> -RUN apt update \
> -    && \
> -    \
> -    DEBIAN_FRONTEND=3Dnoninteractive \
> -    apt install --assume-yes --no-install-recommends \
> -        build-essential \
> -        ca-certificates \
> -        git \
> -        make \
> -       python3 \
> -        wget \
> -    && \
> -    \
> -    rm -rf /var/lib/apt/lists/*
> -
> -# Manually install the kernel.org "Crosstool" based toolchains for gcc-8=
.3
> -RUN wget -O - \
> -    https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64=
/8.3.0/x86_64-gcc-8.3.0-nolibc-riscv32-linux.tar.xz \
> -    | tar -C /opt -xJ
> -RUN wget -O - \
> -    https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64=
/8.3.0/x86_64-gcc-8.3.0-nolibc-riscv64-linux.tar.xz \
> -    | tar -C /opt -xJ
> -
> -# Export the toolchains to the system path
> -ENV PATH=3D"/opt/gcc-8.3.0-nolibc/riscv32-linux/bin:${PATH}"
> -ENV PATH=3D"/opt/gcc-8.3.0-nolibc/riscv64-linux/bin:${PATH}"
> diff --git a/.gitlab-ci.d/qemu-project.yml b/.gitlab-ci.d/qemu-project.ym=
l
> index 104a147b2d..72d02bc65b 100644
> --- a/.gitlab-ci.d/qemu-project.yml
> +++ b/.gitlab-ci.d/qemu-project.yml
> @@ -11,7 +11,6 @@ default:
>  include:
>    - local: '/.gitlab-ci.d/base.yml'
>    - local: '/.gitlab-ci.d/stages.yml'
> -  - local: '/.gitlab-ci.d/opensbi.yml'
>    - local: '/.gitlab-ci.d/containers.yml'
>    - local: '/.gitlab-ci.d/crossbuilds.yml'
>    - local: '/.gitlab-ci.d/buildtest.yml'
> --
> 2.34.1
>
>

