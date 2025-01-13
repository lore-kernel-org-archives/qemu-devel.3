Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6289E7719F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 12:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXJvp-00050g-TX; Mon, 13 Jan 2025 07:52:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tXJvn-00050S-Of
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 07:52:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tXJvl-0004te-AP
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 07:52:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736772751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UP5I0yu8bNqvyMUcRh6JH2jmb1C9okyZHoncWmzVJ7s=;
 b=HUib4d1Mx67mra4liRIHuhD7qj/wNkWwxvhHK5pJe/H8atKfiCOkloVkHyQ2yw1REyLjER
 HBjOipQWWDnENEVfSC5OGsIjiMn2WJMt02YpQuRn96M+dsQuNOHUE/hk2PSvgqbDsmHT4u
 uuBI/foTlB6B8KplCL7/PK4mAv6vDM4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-Xvcmq92fNQ6uNCqUxb8miw-1; Mon,
 13 Jan 2025 07:52:29 -0500
X-MC-Unique: Xvcmq92fNQ6uNCqUxb8miw-1
X-Mimecast-MFC-AGG-ID: Xvcmq92fNQ6uNCqUxb8miw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E9D91956050
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 12:52:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.48])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00D9E19560AD
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 12:52:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8C10521E6924; Mon, 13 Jan 2025 13:52:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Andrea Bolognani
 <abologna@redhat.com>
Subject: Re: [PATCH v3 0/8] qapi-go: add generator for Golang interfaces
In-Reply-To: <20250110104946.74960-1-victortoso@redhat.com> (Victor Toso's
 message of "Fri, 10 Jan 2025 11:49:38 +0100")
References: <20250110104946.74960-1-victortoso@redhat.com>
Date: Mon, 13 Jan 2025 13:52:25 +0100
Message-ID: <874j22ooza.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.019,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.787,
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

Victor Toso <victortoso@redhat.com> writes:

> This patch series intent is to introduce a generator that produces a Go
> module for Go applications to interact over QMP with QEMU.
>
> The initial Goal is to have a Go module that works as intended and can
> be improved upon. I'd consider initial releases to be alpha while we
> work with utilities tools and libraries on top of this.
>
> The generated code should reside in a separated Git repository, similar
> to python-qemu-qmp.
>
> Applications should be able to consume this under qemu.org
> namespace (e.g: import "qemu.org/go/qemu"), see Daniel's suggestion:
> https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg07024.html
>
> This is the third iteration:
> v2: https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg04785.html
>
> I've pushed this series in my gitlab fork:
> https://gitlab.com/victortoso/qapi-go/
>
> The fork contains some tests, including tests that were generated from
> QAPI's own examples from another generator created for testing, if you
> are interested in it:
> https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg04946.html
>
> I've generated the qapi-go module over each commit of this series, see:
> https://gitlab.com/victortoso/qapi-go/-/commits/qapi-golang-v3-by-patch
>
> I've also generated the qapi-go module over QEMU tags: v9.1.0, v9.2.0:
> https://gitlab.com/victortoso/qapi-go/-/commits/qapi-golang-v3-by-tags
>
> --
>
> Sorry that its been awhile between v2 and v3, I had to prioritize other
> things. I hope to get this back on track in 2025.
>
> Cheers,
> Victor
>
> * Changes:
>
> On generated go:
>  - the output should be formatted as gofmt/goimports tools (Daniel)
>
>  - Included QAPI's documentation too (Daniel), see:
>    https://lists.gnu.org/archive/html/qemu-devel/2024-11/msg01621.html
>     
>  - Commands and Events should Marshal directly (Andrea)
>
> On python script:
>  - rebased: now uses QAPISchemaBranches, QAPISchemaAlternatives
>
>  - use textwrap as much as possible (Andrea)
>
>  - lots of changes to make the output like gofmt does
>
> Victor Toso (8):
>   qapi: golang: Generate enum type
>   qapi: golang: Generate alternate types
>   qapi: golang: Generate struct types
>   qapi: golang: structs: Address nullable members
>   qapi: golang: Generate union type
>   qapi: golang: Generate event type
>   qapi: golang: Generate command type
>   docs: add notes on Golang code generator
>
>  docs/devel/index-build.rst          |    1 +
>  docs/devel/qapi-golang-code-gen.rst |  548 +++++++++
>  scripts/qapi/golang.py              | 1645 +++++++++++++++++++++++++++
>  scripts/qapi/main.py                |    3 +
>  4 files changed, 2197 insertions(+)
>  create mode 100644 docs/devel/qapi-golang-code-gen.rst
>  create mode 100644 scripts/qapi/golang.py

This is series adds a backend that slots in cleanly, i.e. without any
changes to the core.  That makes it as low-risk to merge as it gets.

I'd like an Acked-by for the generated Go from someone familiar the kind
of software that could use it.

The Go backend is a single golang.py, which generates:

* Types:
  alternates.go enums.go structs.go unions.go

* Commands:
  commands.go

* Events:
  events.go

It doesn't generate visitors or introspection code.

Correct?

The existing C backend generates code for

* Types (types.py):
  qapi-builtin-types.[ch]
  qapi-types.[ch] qapi-types-*.[ch]

* Visitors (visit.py):

  qapi-builtin-visit.h
  qapi-visit.[ch] qapi-visit-*.[ch]

* Commands (commands.py):

  qapi-init-commands.h
  qapi-commands.[ch] qapi-commands-*.[ch]

* Events (events.py):

  qapi-emit-events.h
  qapi-events.[ch] qapi-events-*.[ch]

* Introspection (introspect.py):

  qapi-introspect.h

The -* files are all one pair of files per module (the things pulled in
with include directives), if any.  We do this to avoid "touch the QAPI
schema, recompile the world."

The generated Go is monolithic.  No "recompile the world" problem with
Go?

golang.py is somewhat big.  Whether splitting it up along the lines of
the C backend would improve things I can't say.  No need to worry about
that now.


