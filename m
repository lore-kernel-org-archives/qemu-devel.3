Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB116D68B29
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 14:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBasM-00052b-Q3; Thu, 14 Nov 2024 09:31:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tBas4-00051o-6i
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 09:30:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tBas2-0003cA-Iq
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 09:30:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731594652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2xrroYDtpTjOaNH22XBwF4DMaPxukbbPAhKBZfMOEjE=;
 b=ecUcp1BJfgisZ3XrbdgMRcrMvoHq2Oc2owumv4Vaz1nS6ubAbtw3+3y47Zt2Ccx+RqiVBM
 /PQxKFjSd2nGEao6GSLwOqsHMHPz5RIjqvPDag4U7VzDloFDxdwjp++DrS/HdWXwE5CDKZ
 SMOuGZPrRM+IhagBd2ZlGgumKvjOT7g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-kOXz5DJEO1eFKm3RvX2SKQ-1; Thu,
 14 Nov 2024 09:30:51 -0500
X-MC-Unique: kOXz5DJEO1eFKm3RvX2SKQ-1
X-Mimecast-MFC-AGG-ID: kOXz5DJEO1eFKm3RvX2SKQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C6E61956077
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 14:30:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.95])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C28FD19560A3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 14:30:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7271A21E6A28; Thu, 14 Nov 2024 15:30:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 01/31] include: move include/qapi/qmp/ to
 include/qobject/
In-Reply-To: <20241017113344.883424-2-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 17 Oct 2024 12:33:13
 +0100")
References: <20241017113344.883424-1-berrange@redhat.com>
 <20241017113344.883424-2-berrange@redhat.com>
Date: Thu, 14 Nov 2024 15:30:47 +0100
Message-ID: <87bjyhdh0o.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The general expectation is that header files should follow the same
> file/path naming scheme as the corresponding source file. There are
> various historical exceptions to this practice in QEMU, with one of
> the most notable being the include/qapi/qmp/ directory. Most of the
> headers there correspond to source files in qobject/.
>
> This patch corrects that inconsistency by creating include/qobject/.
> The only outlier is include/qapi/qmp/dispatch.h which gets renamed
> to include/qapi/qmp-registry.h.
>
> To allow the code to continue to build, symlinks are temporarily
> added in $QEMU/qapi/qmp/ to point to the new location. They will
> be removed in a later commit.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

[...]

> diff --git a/MAINTAINERS b/MAINTAINERS
> index c21d6a2f9e..656482b2a4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3153,8 +3153,6 @@ S: Supported
>  F: qapi/
>  X: qapi/*.json
>  F: include/qapi/
> -X: include/qapi/qmp/
> -F: include/qapi/qmp/dispatch.h

This tried to have add just include/qapi/qmp/dispatch.h from this
subdirectory.  It didn't work:

    $ scripts/get_maintainer.pl -f include/qapi/qmp/dispatch.h=20
    get_maintainer.pl: No maintainers found, printing recent contributors.
    get_maintainer.pl: Do not blindly cc: them on patches!  Use common sens=
e.

    qemu-devel@nongnu.org (open list:All patches CC here)

The patch moved and renames the header to include/qapi/qmp-registry.h,
which also fixes attribution:

    $ scripts/get_maintainer.pl -f include/qapi/qmp-registry.h=20
    Markus Armbruster <armbru@redhat.com> (supporter:QAPI)
    Michael Roth <michael.roth@amd.com> (supporter:QAPI)
    qemu-devel@nongnu.org (open list:All patches CC here)

Mentioning this in the commit message wouldn't hurt.  Not worth a
respin.

>  F: tests/qapi-schema/
>  F: tests/unit/test-*-visitor.c
>  F: tests/unit/test-qapi-*.c
> @@ -3178,8 +3176,7 @@ QObject
>  M: Markus Armbruster <armbru@redhat.com>
>  S: Supported
>  F: qobject/
> -F: include/qapi/qmp/
> -X: include/qapi/qmp/dispatch.h
> +F: include/qobject/
>  F: scripts/coccinelle/qobject.cocci
>  F: tests/unit/check-qdict.c
>  F: tests/unit/check-qjson.c

[...]


