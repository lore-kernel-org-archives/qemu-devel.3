Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D95AC88E73
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 08:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Oaf-0002Cp-37; Tue, 15 Sep 2026 04:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6Oaa-0002AR-0X
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 04:32:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6OaX-0007iG-Ot
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 04:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789461144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ID2P1HsVLk4Xljf56tsUorvMYuJ0EEG+Y5+wQaTIIms=;
 b=AkEvpY+lFc0ciDFCikZ45jF2fDK/Y+yWx8+3g8dW+sZHEMmU0OOHvdZD1+eWvgxU4ptFef
 eHKiD0kjbkqTgoSx2j8V+/AbSqsqR4lcwmbYNYBe6x+oMKsBQhkQkcdnBGzTdFsE2r4P45
 P4fvL4DAF2v1ScSJRna6cgPHLqkOYfU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-EnXm9-P8N0OhcpsrBAW-qw-1; Tue,
 15 Sep 2026 04:32:22 -0400
X-MC-Unique: EnXm9-P8N0OhcpsrBAW-qw-1
X-Mimecast-MFC-AGG-ID: EnXm9-P8N0OhcpsrBAW-qw_1789461141
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B9A81954235; Tue, 15 Sep 2026 08:32:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86745180025F; Tue, 15 Sep 2026 08:32:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2601721E6A04; Tue, 15 Sep 2026 10:32:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  vsementsov@yandex-team.ru,  farosas@suse.de,
 eblake@redhat.com,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH] qapi/migration: Make migration parameter @local
 consistently unstable
In-Reply-To: <aqf5e32Ba_Q_7wXw@zhexu-thinkpadt14gen5.rmtcaon.csb> (Peter Xu's
 message of "Mon, 14 Sep 2026 09:41:15 -0400")
References: <20260912045350.2139416-1-armbru@redhat.com>
 <aqf5e32Ba_Q_7wXw@zhexu-thinkpadt14gen5.rmtcaon.csb>
Date: Tue, 15 Sep 2026 10:32:18 +0200
Message-ID: <87h5jqsynh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> On Sat, Sep 12, 2026 at 06:53:50AM +0200, Markus Armbruster wrote:
>> @local is unstable in MigrationParameters, but not in
>> MigrationParameter.  Fix the latter.
>>=20
>> Fixes: c9affb8e9b (qapi: add local migration parameter)
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> To avoid this in the future, can we further simplify MigrationParameter in
> qapi/?  E.g. either dropping the @unstable completely (by mentioning in i=
ts
> doc to reference MigrationParameters),

Or mark the entire MigrationParameter unstable.

> doc to reference MigrationParameters), or I also wonder if there is way we
> can completely avoid some struct to be visible in doc, so we can drop it;
> currently MigrationParameter still shows all fields "Not Documented".

The entire QAPI schema goes into the "QEMU QMP Reference Manual".  Even
types that aren't used in QMP, which is undesirable.

We have code to find the types used in QMP.  query-qmp-schema uses it.
We never got around to use it in the doc generator, too.

However, Marc-Andr=C3=A9's work to improve QOM introspection complicates
matters.  It exposes QAPI types in QOM introspection.  Types so exposed
are then part of the external interface, but that's not captured in the
QAPI schema, only in QOM property definitions.  We're probably going to
dumb down query-qmp-schema to cover all types, like the reference
manual.

We could create means to mark types "internal use only", and relax
documentation requirements for them.  Of course we better enforce these
are not exposed externally, neither in QMP nor in QOM.

This would let us neglect marking types "internal use only".  If we
don't want that, we could instead require "used by QOM" marks for QOM
use, and treat any type not so marked and also not used by QMP as
internal.


