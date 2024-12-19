Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1405BE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGs-00049l-6C; Thu, 19 Dec 2024 11:21:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tOFgP-0000a4-0H
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:31:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tOFgM-0003xh-TK
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:31:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734611469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0cta8WLQLFlLem+xl78Jb7wh7EriaWF5kl1CLaqwIXM=;
 b=LsJBDsLwYHx7x8OmXtcX1YDeeuzKw/WpRbYkZPSZKXDRbVsXvHC18WR1cA3jeQ3MizKzlD
 ht95KF3l/ZGIE0a3YAy+f6IOJs49biXKbAEvkgonACOoULiWyYIOXBP5JOkQYA93H9IoN9
 wxCSiUYvFBwkkfUc508T96DBXlfLVeM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-4jHpy3MvPnqBQHOUQE8QfQ-1; Thu,
 19 Dec 2024 07:31:05 -0500
X-MC-Unique: 4jHpy3MvPnqBQHOUQE8QfQ-1
X-Mimecast-MFC-AGG-ID: 4jHpy3MvPnqBQHOUQE8QfQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 034E51956069; Thu, 19 Dec 2024 12:31:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 898801953953; Thu, 19 Dec 2024 12:31:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 37C6421E6682; Thu, 19 Dec 2024 13:31:01 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 00/23] docs: add basic sphinx-domain rST generator to
 qapidoc
In-Reply-To: <20241213021827.2956769-1-jsnow@redhat.com> (John Snow's message
 of "Thu, 12 Dec 2024 21:18:03 -0500")
References: <20241213021827.2956769-1-jsnow@redhat.com>
Date: Thu, 19 Dec 2024 13:31:01 +0100
Message-ID: <87ikrfkg6y.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

John Snow <jsnow@redhat.com> writes:

> based-on: https://patchew.org/QEMU/20241213011307.2942030-1-jsnow@redhat.com/
>
> Hi!
>
> This series is a very, very barebones implementation for the new QAPI
> doc generator. It does not have many features that I presented on at KVM
> Forum; the point of this patch set is instead to present a stripped down
> basis for ongoing work so we can discuss on-list with full context of
> the code available to do so.
>
> The documentation this series generates is *not suitable* for replacing
> the current document generator, it has a few glaring omissions - on
> purpose - those features have been factored out intentionally so they
> can be reviewed with fuller context and more careful review.
>
> What this series does:
>
> - Adds the new "Transmogrifier" rST generator to qapidoc.py, which
>   generates an in-memory rST document using qapi-domain directives.
> - Adds a test document that showcases this new transmogrifier.

Note to other reviewers: transmogrifier output is
docs/manual/qapi/index.html.

> What this series very notably does not do (yet):
>
> - "ifcond" data for anything other than top-level entities is not
>   considered or rendered. This means "if" statements for features and
>   members are entirely absent.
>
> - The inliner is not present at all. This series renders only
>   documentation exactly as it is exists in the source files.

This item is not even a regression.

> - *branches* are themselves not considered at all; they're skipped
>    entirely for now. They will be included alongside the inliner in
>    either a subsequent series or a followup to this series.
>
> - Undocumented members and return statements are not autogenerated.

The current doc generator auto-generates missing member documentation
("Not documented").  It doesn't auto-generate missing returns
documentation.  I explored auto-generating them, but shelved my work to
not interfere with yours.

> - Pseudofeatures (Things like allow-oob) are not generated as documented
>   features.

What exactly are "pseudofeatures"?

> - Documentation culling: all entities are documented whether or not
>   they're relevant to the wire format.

Also not a regression.

> My goal in doing it this way is to save the "fancy" features for later
> so we can focus on reviewing and tightening up the core functionality of
> the transmogrifier. Once we're on steadier ground, I will re-add the
> fanciful features while adjusting the qapi-domain mechanisms. Once
> everything looks "roughly right, give or take some minor nits", I will
> switch back to the qapi-domain series itself for review before we merge
> everything together.

Makes sense to me.

[...]

>  docs/index.rst         |   1 +
>  docs/qapi/index.rst    |  53 ++++++
>  docs/sphinx/qapidoc.py | 419 ++++++++++++++++++++++++++++++++++++++---
>  scripts/qapi/parser.py |  97 +++++++---
>  scripts/qapi/source.py |   4 +-
>  5 files changed, 524 insertions(+), 50 deletions(-)
>  create mode 100644 docs/qapi/index.rst

The changes to the QAPI generator core (scripts/qapi/) are small, and
spread over just four patches:

    qapi/source: allow multi-line QAPISourceInfo advancing
    qapi/schema: add __repr__ to QAPIDoc.Section
    qapi: expand tags to all doc sections
    qapi/parser: adjust info location for doc body section


