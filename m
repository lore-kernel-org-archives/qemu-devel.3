Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D2DC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk4Vf-00044C-CB; Wed, 15 Jul 2026 14:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wk4Vc-00043p-PC
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 14:39:04 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wk4Va-0003GR-Gv
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 14:39:04 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A5A743DF5;
 Wed, 15 Jul 2026 18:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784140739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MZU7tLS84VBYPqySl+QbeMgffwV1DzMtdcea1YDCfdE=;
 b=Vim3JpaL39aQrceIrDyGxsZncxVoj9EVbhxCyWP+KCV95g/cXd+KBV4Qb6r2cedA+x8PKe
 L3UbcDd0UM1do9WDvwyPbeaqoZENXGr+NR1lTXFK/VicexhGj3S3I+Pj2NtM4/R6kfcWol
 NjvA8Zk5w1j0GPqaSvUYqZfbojFKBio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784140739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MZU7tLS84VBYPqySl+QbeMgffwV1DzMtdcea1YDCfdE=;
 b=8XIx/y2CqYMiqs5EEE66XPofLcPtTaPe65bniZZ+A9DIZdLEc6GEBvj4XxprZTQdGLJqLW
 RgD5xM63kBX/KyDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KsEg88+i;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=u2jsfJbh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784140738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MZU7tLS84VBYPqySl+QbeMgffwV1DzMtdcea1YDCfdE=;
 b=KsEg88+iDVkvlqhmxor2tf54pplMy+g9xeUtn+QyLNNfgx0vxGrGu+vmacpnOb5N+tdG6b
 lzzoIIPFLPErL4rIyx4soV7ecIGYd9PPBeAs3GZ7u5kwGoVJgYUUYkr+l7P1Std8PXTJzt
 RoO3nChCrw4J95SF6gqlTlDnHjhSTW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784140738;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MZU7tLS84VBYPqySl+QbeMgffwV1DzMtdcea1YDCfdE=;
 b=u2jsfJbhXPU031VJSk4JSQ3B+bvj9f0pUO2OdID07tHv+lLlfROdhGnZGYMrF/kCdcLbT5
 5ufUsLtS3ThrAiCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46A57779AD;
 Wed, 15 Jul 2026 18:38:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PqKSBsLTV2omRQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 15 Jul 2026 18:38:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v3 1/2] gitlab: introduce files mapping GitLab accounts
 to real names
In-Reply-To: <20260715154029.1216464-2-berrange@redhat.com>
References: <20260715154029.1216464-1-berrange@redhat.com>
 <20260715154029.1216464-2-berrange@redhat.com>
Date: Wed, 15 Jul 2026 15:38:47 -0300
Message-ID: <87se5k3xoo.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A5A743DF5
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
 FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:mid, suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
>   Missing GitLab handle for maintainer 'Akihiko Odaki'
>   Missing GitLab handle for maintainer 'Albert Esteve'
>   ....
>   Missing GitLab handle for maintainer 'Zhenzhong Duan'
>   Missing GitLab handle for maintainer 'Zhuoying Cai'
>   GitLab handles missing: 158 / present: 68
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  .gitlab-map-auto          | 93 +++++++++++++++++++++++++++++++++++++++
>  .gitlab-map-manual        | 18 ++++++++
>  scripts/gitlab-map-check  | 51 +++++++++++++++++++++
>  scripts/gitlab-map-update | 45 +++++++++++++++++++
>  4 files changed, 207 insertions(+)
>  create mode 100644 .gitlab-map-auto
>  create mode 100644 .gitlab-map-manual
>  create mode 100755 scripts/gitlab-map-check
>  create mode 100755 scripts/gitlab-map-update
>
> diff --git a/.gitlab-map-auto b/.gitlab-map-auto
> new file mode 100644
> index 0000000000..c15c301435
> --- /dev/null
> +++ b/.gitlab-map-auto
> @@ -0,0 +1,93 @@
> +# This file is auto-generated by scripts/autolab-map-update

gitlab

> +#
> +# This GitLab map associates GitLab account handles
> +# with real names, in order to allow mapping from
> +# MAINTAINERS entries. The format of entries is
> +#
> +#    {gitlab-handle}<tab>{real name}
> +#
> +# Manual overrides must be placed in .gitlab-map-manual
> +TaoTang	Tao Tang
> +a1xndr	Alexander Bulekov
> +adi-g15-ibm	Aditya Gupta
> +agraf	Alexander Graf
> +alex.williamson	Alex Williamson
> +aliang1	Aihua Liang
> +alistair23	Alistair Francis
> +anisinha	Ani Sinha
> +anthony-linaro	Anthony Roberts
> +anthonyper	Anthony PERARD
> +berrange	Daniel P. Berrang=C3=A9
> +birkelund	Klaus Jensen
> +bonzini	Paolo Bonzini
> +brian-cain	Brian Cain
> +bsdimp	Warner Losh
> +cborntra	Christian Borntraeger
> +chao23.liu	Chao Liu (Zevorn)
> +cleber.gnu	Cleber Rosa
> +clegoate	C=C3=A9dric Le Goater
> +cohuck	Cornelia Huck
> +cota_	Emilio Cota
> +dagrh	Dr. David Alan Gilbert
> +danielhb	Daniel Henrique Barboza
> +davidhildenbrand	David Hildenbrand
> +dgibson	dgibson
> +dwmw2	David Woodhouse
> +eauger1	Eric Auger
> +ebblake	Eric Blake
> +edgar.iglesias	Edgar E. Iglesias
> +ehabkost	Eduardo Habkost
> +eldondev	Eldon
> +epilys	Manos Pitsidianakis
> +famzheng	Fam Zheng
> +farosas	Fabiano Rosas
> +gautammenghani	Gautam Menghani
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
> +lygstate	Yonggang Luo
> +maciejsszmigiero	Maciej S. Szmigiero
> +marcandre.lureau	Marc-Andr=C3=A9 Lureau
> +marcandre.lureau-rh	Marc-Andr=C3=A9 Lureau
> +mauromatteo.cascella	Mauro Matteo Cascella
> +mcayland	Mark Cave-Ayland
> +mdroth	Michael Roth
> +mediouni-m	M. Mediouni
> +mjt0k	Michael Tokarev
> +mstredhat	MST
> +npiggin	npiggin
> +p-b-o	Pierrick Bouvier
> +pauldzim	Paul Zimmerman
> +peterx	Peter Xu
> +philmd	Philippe Mathieu-Daud=C3=A9
> +pierrick.bouvier	Pierrick Bouvier
> +pipo.sk	Peter Krempa
> +pkrempa	Peter Krempa (work)
> +pm215	Peter Maydell
> +qemu-janitor	Qemu Janitor
> +rathc	Chinmay Rath
> +rth7680	Richard Henderson
> +schoenebeck	Christian Schoenebeck
> +sgarzarella	Stefano Garzarella
> +sstabellini	Stefano Stabellini
> +stefanberger	Stefan Berger
> +stefanha	Stefan Hajnoczi
> +stsquad	Alex Benn=C3=A9e
> +stweil	Stefan Weil
> +thuth	Thomas Huth
> +vsementsov	Vladimir Sementsov-Ogievskiy
> +xcancerberox	Joaquin de Andres
> diff --git a/.gitlab-map-manual b/.gitlab-map-manual
> new file mode 100644
> index 0000000000..1551e2f55d
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

This is

> +# needed where a GitLab account real name does
> +# not exactly match the MAINTAINERS file real
> +# name.
> +#
> +berrange	Daniel P. Berrange
> +dgibson	David Gibson
> +hreitz	Hanna Reitz
> +mstredhat	Michael S. Tsirkin
> +npiggin	Nicholas Piggin
> +mediouni-m	Mohamed Mediouni
> diff --git a/scripts/gitlab-map-check b/scripts/gitlab-map-check
> new file mode 100755
> index 0000000000..ff12e36593
> --- /dev/null
> +++ b/scripts/gitlab-map-check
> @@ -0,0 +1,51 @@
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
> +    echo "Missing GitLab handle for maintainer '$NAME'"
> +    missing=3D$(($missing + 1))
> +  else
> +    present=3D$(($present + 1))
> +  fi
> +done < names.txt
> +rm -f names.txt
> +
> +echo "GitLab handles missing: $missing / present: $present"
> +
> +# .gitlab-map-manual is to provide alternate real names
> +# for cases where name in MANITAINERS does not match

MAINTAINERS

> +# the GitLab account real name. As such...
> +
> +# ...all gitlab handles in .gitlab-map-manual must also exist
> +# in .gitlab-map-auto and ....
> +for HANDLE in $(grep -v '^#' .gitlab-map-manual | awk '{print $1}')
> +do
> +    grep -E "^$HANDLE\s" .gitlab-map-auto >/dev/null
> +    if test $? !=3D 0
> +    then
> +	echo "Unexpected GitLab handle '$HANDLE' is not a member"
> +    fi
> +done
> +
> +# ...and all realnames in .gitlab-map-manual must also
> +# exist in MAINTAINERS
> +grep -v '^#' .gitlab-map-manual | \
> +awk '{ saved =3D $1; $1 =3D ""; print substr($0, 2) }' | \

Is 'saved' doing anything here?

> +while IFS=3D read -r NAME
> +do
> +    grep -E "\s$NAME\s" MAINTAINERS >/dev/null
> +    if test $? !=3D 0
> +    then
> +	echo "Unexpected real name '$NAME' is not a maintainer"
> +    fi
> +done
> diff --git a/scripts/gitlab-map-update b/scripts/gitlab-map-update
> new file mode 100755
> index 0000000000..c134c226aa
> --- /dev/null
> +++ b/scripts/gitlab-map-update
> @@ -0,0 +1,45 @@
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
> +    jq -r -c '.[] | [.username, .name] | @tsv' | \
> +    grep -v 'Duo Developer' >> \
> +    .gitlab-map-auto.tmp
> +test $? !=3D 0 && fail=3D1
> +
> +if test $fail =3D=3D 0
> +then
> +  grep '^#' .gitlab-map-auto > .gitlab-map-auto.new
> +  LC_ALL=3DC sort .gitlab-map-auto.tmp | uniq >> .gitlab-map-auto.new
> +  mv .gitlab-map-auto.new .gitlab-map-auto
> +  echo "OK: GitLab member list updated"
> +else
> +  echo "ERROR: Updating member list failed"
> +fi
> +rm -f .gitlab-map-auto.tmp

