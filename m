Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86451C52D71
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 17:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbOJU-00052g-0i; Tue, 06 Aug 2024 13:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sbOJT-00052C-4M
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 13:49:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sbOJJ-0008IH-0D
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 13:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722966562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0W+Q7VKPamkrTyHjpTUATs99/pi5hS7AOCfQ4SjAZBY=;
 b=RyoXONZKPcRtnrCHUjNPUYvb30zGhg600qpk4V4ESoZfFrkOnNjf7Jbd01ZC+Un/j5+Y5s
 iAR9+1kkSnS/rVHGCUShNVmd6XqC9F4XEm7KsEADUO0uFe7D8QreaxOMn2XITjqEiOjoR+
 JX0GiaPIVnMG3hyiulkxq6bD2TCXgPw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-X3YpkRiOPhuDueV0IWwjsw-1; Tue,
 06 Aug 2024 13:49:17 -0400
X-MC-Unique: X3YpkRiOPhuDueV0IWwjsw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9567C1955D42; Tue,  6 Aug 2024 17:49:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.245])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCD0F19560AE; Tue,  6 Aug 2024 17:49:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9A1DF21E668F; Tue,  6 Aug 2024 19:49:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Michael
 Roth <michael.roth@amd.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Complications due to having multiple QAPI schemas (was: [PATCH 5/6]
 qapi: apply schema prefix to QAPI feature enum constants)
In-Reply-To: <87ikwfj9rs.fsf@pond.sub.org> (Markus Armbruster's message of
 "Mon, 05 Aug 2024 16:59:19 +0200")
References: <20240801175913.669013-1-berrange@redhat.com>
 <20240801175913.669013-6-berrange@redhat.com>
 <87y15bnoq0.fsf@pond.sub.org> <ZrDGoSTUIcpaVGO8@redhat.com>
 <87a5hrm7wv.fsf@pond.sub.org> <ZrDSqXtiT2U7zS-p@redhat.com>
 <87frrjkrct.fsf@pond.sub.org> <87ikwfj9rs.fsf@pond.sub.org>
Date: Tue, 06 Aug 2024 19:49:13 +0200
Message-ID: <87y1591qzq.fsf_-_@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> It's not just tests.  QAPI-related headers have deteriorated, and pull
> in too much.  I'll try to clean this up.  Thanks!

While some cleanup is certainly possible and probably useful, I don't
think I can completely solve the problem that way.

Not counting tests, we have two or three QAPI schemas, depending on how
you count:

* QEMU's main schema qapi/qapi-schema.json

  This schema defines qemu-system-FOO's QMP (plus types used for QOM
  properties and such, but that's detail we can ignore here).

* The storage daemon's schema storage-daemon/qapi/qapi-schema.json

  This is a strict subset the main schema, not a schema on its own.

  qemu-storage-daemon wants to provide a subset of qemu-system-FOO's
  QMP.  We get this as follows.

  qapi/qapi-schema.json contains nothing but include directives.
  storage-daemon/qapi/qapi-schema.json contains nothing but a subset of
  the same include directives.  The exact same code gets generated for
  these modules both times.  We always use the copy generated for the
  main schema's modules, and ignore the one generated for the storage
  daemon.  Different code gets generated for command & event
  registration, and QMP introspection.  The storage daemon uses the code
  generated for its subset.  This is a bit of a hack.

* The guest agent's schema qga/qapi-schema.json

  This schema defines qemu-ga's QMP.

Each program generally uses at most one QAPI schema.  Easy.

The exception is the guest agent.  It might have initially used just its
own QAPI schema as well, but today, it also uses parts of the main
schema.  That's because the main schema has grown tentacles into common
code.

Example: qemu-ga with -m vsock-listen prefixes its -p argument with
"vsock:" and parses the result with socket_parse().  While we can
quibble about the details here, sharing vsock address syntax and parser
between guest agent and QEMU proper makes sense.  The address structure
/ abstract syntax is defined in the main schema's qapi/sockets.json.
The address parser is declared in qemu/sockets.h, and pulls in the main
schema's qapi/qapi-types-sockets.h.

Trying to limit qemu-ga to just its own schema would make no sense.  We
*want* to share things defined in a (shared) QAPI schema.

Note that while qemu-ga C code pulls in (generated) main schema stuff,
its QAPI schema so far does not.  However, reuse of utility types like
SocketAddress or OnOffAuto from the main schema might become interesting
some day.

The QAPI generator supports more than one schema per program, although
kind of half-heartedly.  There's -p to set a prefix, which is prepended
to filenames and symbols.  But there's no systematic effort to do the
latter.  We slap it to symbols whenever we run into a collision.

Example: your patch slaps it to the generated QapiFeature enum and its
members.

Example: we don't slap it to command handlers.  If two schemas both
define command 'frobnicate', we generate a prototype qmp_frobnicate()
for both, and expect the handwritten code to supply a function suitable
for both.

We can continue slapping the prefix to symbols whenever we run into a
collision, i.e. go with your patch.  Feels like the pragmatic choice to
not block your series.

But could we do better in the long run?

Back when we created the guest agent schema, QAPI schemas were
monolithic: a single schema file, generating a single qapi-types.h and
so forth.

Today, a schema can be modular, i.e. split into multiple modules, each
generating its own qapi-types-MODULE.h and so forth.

We exploit this to have a single schema both for qemu-system-FOO's QMP
and qemu-storage-daemon's QMP, albeit in a hacky way.

What if QAPI provided cleaner means for generating multiple QMPs from a
single schema?

Then we could have a single schema, and no worries about collisions.

I'm not asking you to try this.  It's just an idea I wrote up so I don't
forget it again.


