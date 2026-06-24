Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2149CCDE004
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNrM-0008LQ-I4; Wed, 24 Jun 2026 09:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wcNr3-00081h-N7
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 09:41:25 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wcNr0-0001pr-0X
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 09:41:25 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5821675A60;
 Wed, 24 Jun 2026 13:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782308476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+wLdn5N6P0XyfNfiuYPf5+VS5B8HBrGCPt6Oa7iLgAs=;
 b=Qu/NJ/9g+xYYFmEsxlNEpDuF2nXFwT0+XpUdrAzX6f5ClrXxLIK/Y3GPtnkSnu66YdLL/q
 tfH5pZG99x1qayMjVhypPJQxii5wePSH29HAbIuI3BDqirGhY4FcOfj5mxUMQpgLJoCHtA
 X2KsyA7bEnC1cHlBVIj/w4XksDUGE4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782308476;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+wLdn5N6P0XyfNfiuYPf5+VS5B8HBrGCPt6Oa7iLgAs=;
 b=V65U3Ki1KPTfUWuagLykSrtFhEWUjsvxX2m+yyouS/EwjPhD6h2FAG5f0N7Senrtj3KNgJ
 3TQYT+9BgYIvTcAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782308476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+wLdn5N6P0XyfNfiuYPf5+VS5B8HBrGCPt6Oa7iLgAs=;
 b=Qu/NJ/9g+xYYFmEsxlNEpDuF2nXFwT0+XpUdrAzX6f5ClrXxLIK/Y3GPtnkSnu66YdLL/q
 tfH5pZG99x1qayMjVhypPJQxii5wePSH29HAbIuI3BDqirGhY4FcOfj5mxUMQpgLJoCHtA
 X2KsyA7bEnC1cHlBVIj/w4XksDUGE4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782308476;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+wLdn5N6P0XyfNfiuYPf5+VS5B8HBrGCPt6Oa7iLgAs=;
 b=V65U3Ki1KPTfUWuagLykSrtFhEWUjsvxX2m+yyouS/EwjPhD6h2FAG5f0N7Senrtj3KNgJ
 3TQYT+9BgYIvTcAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECDEE779A8;
 Wed, 24 Jun 2026 13:41:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id s1vuLnveO2qsFQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 24 Jun 2026 13:41:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v2 1/2] gitlab: introduce files mapping GitLab accounts
 to real names
In-Reply-To: <20260624122936.2706393-2-berrange@redhat.com>
References: <20260624122936.2706393-1-berrange@redhat.com>
 <20260624122936.2706393-2-berrange@redhat.com>
Date: Wed, 24 Jun 2026 10:41:13 -0300
Message-ID: <87echw12fa.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Could we maybe use the username/username entries in .gitlab-map-auto to
validate what's being added as username/realname to .gitlab-map-manual?
So we don't accept by accident a mapping of
random-username/real-maintainer-name.

> The former would need refreshing when we add new MAINTAINERS
> entries, if the person had to be added as a GitLab account
> member. For this purpose scripts/gitlab-map-update can be
> used, assuming the user has the 'glab' client tool present
> and configured with an access token.
>
> To audit how many maintainers have GitLab handles present/missing
> scripts/gitlab-map-check can run a report.
>

On the same line as above, what about entries in .gitlab-map-manual that
don't correspond to any MAINTAINERS entry?

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
> +then
> +  grep '^#' .gitlab-map-auto > .gitlab-map-auto.new
> +  LC_ALL=3DC sort .gitlab-map-auto.tmp >> .gitlab-map-auto.new
> +  mv .gitlab-map-auto.new .gitlab-map-auto
> +  echo "OK: GitLab member list updated"
> +else
> +  echo "ERROR: Updating member list failed"
> +fi
> +rm -f .gitlab-map-auto.tmp

