Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752CCFE51E6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGCS6-0006jj-GH; Fri, 24 Apr 2026 05:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wGCS5-0006jU-7y
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wGCRz-0006yF-QE
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777021429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTCeBsjlQKwhcEds5zSNvts35yCBQRJVGN9HOP5QcY8=;
 b=YaaUGPSQ0GPbN6plbjW21xtGMfBjm0bZCb8k1+/4zMaPntCOmr2zJp34hZPJOd/bajIT5T
 jTYfnztvTu7e2Ke0HuZlIpsDaBB7Rva9FAhk7PWDCD6n7ULCIvNZrASsu2G5yNVIM+k2Zo
 Z9viGFsjf28bupEGfWpTGAkcHnlrfeQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-GbSRFpbfMZSHJO70SzctdA-1; Fri,
 24 Apr 2026 05:03:45 -0400
X-MC-Unique: GbSRFpbfMZSHJO70SzctdA-1
X-Mimecast-MFC-AGG-ID: GbSRFpbfMZSHJO70SzctdA_1777021423
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E898319560A3; Fri, 24 Apr 2026 09:03:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E78B180047F; Fri, 24 Apr 2026 09:03:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BBB3721E6A28; Fri, 24 Apr 2026 11:03:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Joao Martins <joao.m.martins@oracle.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,  Avihai Horon
 <avihaih@nvidia.com>,
 Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Prasad Pandit <ppandit@redhat.com>,  Alex Williamson
 <alex@shazbot.org>,  Kirti Wankhede <kwankhede@nvidia.com>,  Zhiyi Guo
 <zhguo@redhat.com>,  "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Juraj Marcin <jmarcin@redhat.com>,  devel@lists.libvirt.org,  Michal
 Privoznik <mprivozn@redhat.com>
Subject: Re: [PATCH v2 03/16] migration/qapi: Rename MigrationStats to
 MigrationRAMStats
In-Reply-To: <20260421202110.306051-4-peterx@redhat.com> (Peter Xu's message
 of "Tue, 21 Apr 2026 16:20:57 -0400")
References: <20260421202110.306051-1-peterx@redhat.com>
 <20260421202110.306051-4-peterx@redhat.com>
Date: Fri, 24 Apr 2026 11:03:39 +0200
Message-ID: <875x5gu3v8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> This stats is only about RAM, make it accurate.  This paves way for
> statistics for all devices.
>
> Thanks to Markus, who pointed out that docs/devel/qapi-code-gen.rst has a
> section "Compatibility considerations" stated:
>
>     Since type names are not visible in the Client JSON Protocol, types
>     may be freely renamed.  Even certain refactorings are invisible, such
>     as splitting members from one type into a common base type.
>
> Hence this change is not ABI violation according to the document.
>
> While at it, touch up the lines to make it read better, correct the
> restriction on migration status being 'active' or 'completed': over time =
we
> grew too many new status that will also report "ram" section.
>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: devel@lists.libvirt.org
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
> Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  docs/about/removed-features.rst |  2 +-
>  qapi/migration.json             | 10 +++++-----
>  migration/migration-stats.h     |  2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-feature=
s.rst
> index e75db08410..626162022a 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -699,7 +699,7 @@ was superseded by ``sections``.
>  ``query-migrate`` return value member ``skipped`` (removed in 9.1)
>  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>=20=20
> -Member ``skipped`` of the ``MigrationStats`` struct hasn't been used
> +Member ``skipped`` of the ``MigrationRAMStats`` struct hasn't been used
>  for more than 10 years. Removed with no replacement.
>=20=20
>  ``migrate`` command option ``inc`` (removed in 9.1)

docs/about/removed-features.rst and docs/about/deprecated.rst are meant
for consumers of external interfaces.  Since QAPI types are not relevant
there, I try to avoid mentioning them.

Your patch is just fine as is.

"Member ``skipped`` of the return value" would also be fine.

[...]

Reviewed-by: Markus Armbruster <armbru@redhat.com>


