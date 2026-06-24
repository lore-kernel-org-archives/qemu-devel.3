Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AB0CDE002
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNOq-0003Ba-HG; Wed, 24 Jun 2026 09:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcNOe-0003B7-0x
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 09:12:05 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcNOa-0002Ov-Qe
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 09:12:03 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-490ac357c55so9240105e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 06:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782306718; x=1782911518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CVEO4XLr4G2W+rJySt1Hh+yg6XgiXIAi3GYT6tDVCYs=;
 b=ySOqNl5QFJN8f3t2Sb+QFR57APeH+T/55dlNgiO104eeeEu3JMn3HmKgR3aWyK7fjO
 rs/R48MD67Ljb1/c5tP/zl61Dp6tk8rACy6ZEW18p4vB1QIWutEqMjVrRWP8061tX0dY
 jb0L4DowdZjvhNylh3zj4ceK9E1IBlILxxItroFMoTRvMWXirRbAYs8DLklb6ZWTINnr
 hrIff/4c+6UQRAAITYkF8bRnvpzH7OAGFf1AKEfG2fd4KNHxzR9Ll4KJwh4GaUVHs7Df
 3ejHx+xYl+eHfiu64I8dXhNgjVANTuOUevLS+ovCEUBi4HgVjjh47b+uEeMt09yVeB6X
 aJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782306718; x=1782911518;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CVEO4XLr4G2W+rJySt1Hh+yg6XgiXIAi3GYT6tDVCYs=;
 b=bWN/5w7z6cESUJegYA+5IQrl72XVFn05SjFOGcYuLHm1nRLdSFb9Wgw+/kXMeV9KVT
 Xm+4KJriGSR64aaL08Odih9ZYlAkpcnsbu1FMUegld3/5iOeBpzL24Q2vjdRBTMQYsZH
 IxKlQiom0siR8vmRp2aK7RetSdzyS7vCMJ8sarzF+VgaDU7eLyrsLzjlklxm+6XLjXEh
 GzaFLM+r/HatiHI7rJIZEy694/dsO1DKkw4JMxQV+yiO66pmh9Rrr44vnz3A+MzUy9/p
 9FVhhCQ+s0J1bBX0/EBXMiQsEYBqf+asmPSyGW4HpzQFQn3Gwsnb9YrWGWaaG6C+ZC9s
 R1WA==
X-Gm-Message-State: AOJu0YwQY9ACUmHgOx3szVlDZR1Z3gXaTFScYSlRzOXEF8c6VXU65FT9
 DboCF//uvy5krcmkypWNZlAVDXA1BPIhtuYZljk2NdjumWCTmGsr0cCSeAsm9oxZW/bjECI8HrG
 n1SeHYxk=
X-Gm-Gg: AfdE7cnO18nsTFjXH9y1Hm+QzpocaysfarWMmVGuQ3648FZB8jWdAMtYcBF+jJUy6Qi
 lBZ+KCgFr7/dKK4GgcV+X7hLwMTEneAthUcK2OXADxnG+MA3+6vjLdOPAHMR7WbcMWOvNWpf8xk
 Iy9/+tdTKH1gObB+PPCv7uVhmY+VVmKsaU6jl9hZ7c5ihI6Rf1EsvOVhsqZ+UvIRfi9GxfvkuRU
 O7axwZN12l/W5wyNXckGJxIHu5SjBytuF1EcG4nCZWf4GLi6L67Oj9VpIPm1NIDB5PlGtqSbTuO
 Kqjt5AKZmrnKm4FKSk2zoZ4nyT4JisJ/Z2kYPcJ4RQy3H4Ffc8C5Lb4qQnr/K4bdceZ/ku/yNGW
 cha4eYtg+AjoIYUZYcuiiaHfbDgFURQUABkBv433b4tnArLsLlMlTUeTSkRvaTXCGQSKBBl3OQ+
 e7+lQPr+2IkNqNVlWjB7CSru8=
X-Received: by 2002:a05:600c:4899:b0:490:cb90:3e00 with SMTP id
 5b1f17b1804b1-4926084b98emr30470255e9.14.1782306717522; 
 Wed, 24 Jun 2026 06:11:57 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4924923c862sm350862725e9.7.2026.06.24.06.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 06:11:56 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E68695F803;
 Wed, 24 Jun 2026 14:11:55 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 1/2] gitlab: introduce files mapping GitLab accounts
 to real names
In-Reply-To: <20260624122936.2706393-2-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 24 Jun 2026 13:29:35
 +0100")
References: <20260624122936.2706393-1-berrange@redhat.com>
 <20260624122936.2706393-2-berrange@redhat.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Wed, 24 Jun 2026 14:11:55 +0100
Message-ID: <87o6h0krqc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> It is desirable to be able to discover the GitLab account handle
> assocaited with a real name in the MAINTAINERS file.
>
> Rather that duplicating the same account handle multiple times,
> inline with the MAINTAINERS file entries, this introduces mapping
> files:
>
>   * .gitlab-map-auto - data automatically queried from GitLab
>     using the 'glab' tool and REST API
>   * .gitlab-map-manual - manual overrides/augmentation for
>     cases where the MAINTAINERS real name does not match the
>     GitLab account real name
>
> The former would need refreshing when we add new MAINTAINERS
> entries, if the person had to be added as a GitLab account
> member. For this purpose scripts/gitlab-map-update can be
> used, assuming the user has the 'glab' client tool present
> and configured with an access token.
>
> To audit how many maintainers have GitLab handles present/missing
> scripts/gitlab-map-check can run a report.
>
>   $ ./scripts/gitlab-map-check
>   Missing GitLab handle: Akihiko Odaki
>   Missing GitLab handle: Albert Esteve
>   ....
>   Missing GitLab handle: Zhenzhong Duan
>   Missing GitLab handle: Zhuoying Cai
>   GitLab handles missing: 161 / present: 57
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  .gitlab-map-auto          | 83 +++++++++++++++++++++++++++++++++++++++
>  .gitlab-map-manual        | 18 +++++++++
>  scripts/gitlab-map-check  | 23 +++++++++++
>  scripts/gitlab-map-update | 44 +++++++++++++++++++++
>  4 files changed, 168 insertions(+)
>  create mode 100644 .gitlab-map-auto
>  create mode 100644 .gitlab-map-manual
>  create mode 100755 scripts/gitlab-map-check
>  create mode 100755 scripts/gitlab-map-update
>
> diff --git a/.gitlab-map-auto b/.gitlab-map-auto
> new file mode 100644
> index 0000000000..defecb2c9f
> --- /dev/null
> +++ b/.gitlab-map-auto
> @@ -0,0 +1,83 @@
> +# This file is auto-generated by scripts/autolab-map-update
> +#
> +# This GitLab map associates GitLab account handles
> +# with real names, in order to allow mapping from
> +# MAINTAINERS entries. The format of entries is
> +#
> +#    {gitlab-handle}<tab>{real name}
> +#
> +# Manual overrides must be placed in .gitlab-map-manual
> +a1xndr	Alexander Bulekov
> +adi-g15-ibm	Aditya Gupta
> +agraf	Alexander Graf
> +alex.williamson	Alex Williamson
> +aliang1	Aihua Liang
> +alistair23	Alistair Francis
> +anisinha	Ani Sinha
> +anthony-linaro	Anthony Roberts
> +berrange	Daniel P. Berrang=C3=A9
> +birkelund	Klaus Jensen
> +bonzini	Paolo Bonzini
> +bonzini	Paolo Bonzini
> +brian-cain	Brian Cain
> +bsdimp	Warner Losh
> +cborntra	Christian Borntraeger
> +cleber.gnu	Cleber Rosa
> +clegoate	C=C3=A9dric Le Goater
> +cohuck	Cornelia Huck
> +cota_	Emilio Cota
> +dagrh	Dr. David Alan Gilbert
> +danielhb	Daniel Henrique Barboza
> +davidhildenbrand	David Hildenbrand
> +dgibson	dgibson
> +dwmw2	David Woodhouse
> +ebblake	Eric Blake
> +ehabkost	Eduardo Habkost
> +eldondev	Eldon
> +epilys	Manos Pitsidianakis
> +famzheng	Fam Zheng
> +farosas	Fabiano Rosas
> +gkurz	Greg Kurz
> +gusbromero	Gustavo Romero
> +harshpb	Harsh Prateek Bora
> +hdeller	Helge Deller
> +hreitz	Hanna Czenczek
> +imammedo	Igor Mammedov
> +jasowang	Jason Wang
> +jmacarthur	Jim MacArthur
> +jsnow	John Snow
> +juan.quintela	Juan Quintela
> +kbastian-qemu	Bastian Koppelmann
> +kmwolf	Kevin Wolf
> +kostyanf14	Kostiantyn Kostiuk
> +kraxel	Gerd Hoffmann
> +lbmeng	Bin Meng
> +legoater	C=C3=A9dric Le Goater
> +lvivier	Laurent Vivier
> +marcandre.lureau	Marc-Andr=C3=A9 Lureau
> +marcandre.lureau-rh	Marc-Andr=C3=A9 Lureau
> +mcayland	Mark Cave-Ayland
> +mdroth	Michael Roth
> +mediouni-m	M. Mediouni
> +mjt0k	Michael Tokarev
> +mstredhat	MST
> +npiggin	npiggin
> +pauldzim	Paul Zimmerman
> +philmd	Philippe Mathieu-Daud=C3=A9
> +philmd	Philippe Mathieu-Daud=C3=A9
> +pierrick.bouvier	Pierrick Bouvier
> +pipo.sk	Peter Krempa
> +pkrempa	Peter Krempa (work)
> +pm215	Peter Maydell
> +qemu-janitor	Qemu Janitor
> +rth7680	Richard Henderson
> +schoenebeck	Christian Schoenebeck
> +sgarzarella	Stefano Garzarella
> +stefanberger	Stefan Berger
> +stefanha	Stefan Hajnoczi
> +stefanha	Stefan Hajnoczi
> +stsquad	Alex Benn=C3=A9e
> +stweil	Stefan Weil
> +thuth	Thomas Huth
> +vsementsov	Vladimir Sementsov-Ogievskiy
> +xcancerberox	Joaquin de Andres
> diff --git a/.gitlab-map-manual b/.gitlab-map-manual
> new file mode 100644
> index 0000000000..7326971cdd
> --- /dev/null
> +++ b/.gitlab-map-manual
> @@ -0,0 +1,18 @@
> +# This GitLab map associates GitLab account handles
> +# with real names, in order to allow mapping from
> +# MAINTAINERS entries. The format of entries is
> +#
> +#    {gitlab-handle}<tab>{real name}
> +#
> +# This file is manually written, to augment the
> +# auto-generated data in .gitlab-map-auto. This
> +# needed where a GitLab account real name does
> +# not exactly match the MAINTAINERS file real
> +# name.
> +#
> +berrange	Daniel P. Berrange
> +dgibson	David Gibson
> +hreitz	Hanna Reitz=20
> +mstredhat	Michael S. Tsirkin
> +npiggin	Nicholas Piggin
> +mediouni-m	Mohamed Mediouni
> diff --git a/scripts/gitlab-map-check b/scripts/gitlab-map-check
> new file mode 100755
> index 0000000000..69d5b8258a
> --- /dev/null
> +++ b/scripts/gitlab-map-check
> @@ -0,0 +1,23 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +missing=3D0
> +present=3D0
> +
> +grep -E '^(R|M):' MAINTAINERS | \
> +sed -E -e 's/^(M|R): //' -e 's/ <.*//' | \
> +sort | uniq > names.txt
> +while IFS=3D read -r NAME
> +do
> +  grep "$NAME" .gitlab-map-{auto,manual} > /dev/null
> +  if test $? !=3D 0
> +  then
> +    echo "Missing GitLab handle: $NAME"
> +    missing=3D$(($missing + 1))
> +  else
> +    present=3D$(($present + 1))
> +  fi
> +done < names.txt
> +rm -f names.txt
> +
> +echo "GitLab handles missing: $missing / present: $present"
> diff --git a/scripts/gitlab-map-update b/scripts/gitlab-map-update
> new file mode 100755
> index 0000000000..9fe07a98ee
> --- /dev/null
> +++ b/scripts/gitlab-map-update
> @@ -0,0 +1,44 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +echo "Checking authentication token status"
> +glab auth status
> +
> +if test $? !=3D 0
> +then
> +  echo "ERROR: not authenticated with gitlab.com"
> +  exit 1
> +fi
> +
> +if ! test -f .gitlab-map-auto
> +then
> +  echo "ERROR: cannot find existing '.gitlab-map-auto file'"
> +  echo "ERROR: this must be executed from the root of the"
> +  echo "ERROR: git repository checkout"
> +  exit 1
> +fi
> +
> +fail=3D0
> +echo "Updating member list from qemu-project"
> +glab api --paginate /groups/qemu-project/members | \
> +    jq -r -c '.[] | [.username, .name] | @tsv' | \
> +    grep -v '^group_3038080_bot' > \
> +    .gitlab-map-auto.tmp
> +test $? !=3D 0 && fail=3D1
> +
> +echo "Updating member list from qemu-project/qemu"
> +glab api --paginate /projects/qemu-project%2fqemu/members | \
> +    jq -r -c '.[] | [.username, .name] | @tsv' >> \
> +    .gitlab-map-auto.tmp
> +test $? !=3D 0 && fail=3D1
> +
> +if test $fail =3D=3D 0

Testing with:

$ env GITLAB_TOKEN=3D(pass gitlab-qemu-api)  ./scripts/gitlab-map-update
Checking authentication token status
gitlab.com
  =E2=9C=93 Logged in to gitlab.com as group_3038080_bot_40a04d3deae510d9bf=
50c5bebbb7bcd3 (/home/alex/.config/glab-cli/config.yml)
  =E2=9C=93 Git operations for gitlab.com configured to use https protocol.
  =E2=9C=93 API calls for gitlab.com are made over https protocol.
  =E2=9C=93 REST API Endpoint: https://gitlab.com/api/v4/
  =E2=9C=93 GraphQL Endpoint: https://gitlab.com/api/graphql/
  ! No token provided in configuration file.

! One of GITLAB_TOKEN, GITLAB_ACCESS_TOKEN, OAUTH_TOKEN environment variabl=
es is set. It will be used for all authentication.
Updating member list from qemu-project
Updating member list from qemu-project/qemu
./scripts/gitlab-map-update: 35: test: 0: unexpected operator
ERROR: Updating member list failed

> +then
> +  grep '^#' .gitlab-map-auto > .gitlab-map-auto.new
> +  LC_ALL=3DC sort .gitlab-map-auto.tmp >> .gitlab-map-auto.new
> +  mv .gitlab-map-auto.new .gitlab-map-auto
> +  echo "OK: GitLab member list updated"
> +else
> +  echo "ERROR: Updating member list failed"
> +fi
> +rm -f .gitlab-map-auto.tmp

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

