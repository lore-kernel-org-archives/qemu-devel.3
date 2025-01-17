Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6CCC02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 10:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYjq5-0001Cd-8h; Fri, 17 Jan 2025 05:44:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tYjq2-0001C1-6A
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:44:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tYjq0-0007AP-EY
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:44:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737110667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AgMoN7qfthTNFf4lLxzZ1e3ELiRMVAf5vLcYPhJIams=;
 b=ebZeGMS92VObmiQ60+xBFv19yCga1TwZo8ZhT21o1lqlB1E+QfpwElGteM47OENOHs7W+3
 8Jz30LCdHggInPuhg1hI7qGHHRk6RDh4YWlJLgtmuUHOK0lcoYoCmP6kR/NBeMMiQCylES
 8yzhj6gszg5qWTNgcy6r0mexiN9NVHE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-6u-Jo66mMXSVnWesfJ8dCw-1; Fri,
 17 Jan 2025 05:44:25 -0500
X-MC-Unique: 6u-Jo66mMXSVnWesfJ8dCw-1
X-Mimecast-MFC-AGG-ID: 6u-Jo66mMXSVnWesfJ8dCw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77DDF1956058
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:44:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.48])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AC1230001BE
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:44:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9CBBE21E6924; Fri, 17 Jan 2025 11:44:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Victor Toso <victortoso@redhat.com>,  qemu-devel@nongnu.org,  John Snow
 <jsnow@redhat.com>,  Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH v3 0/8] qapi-go: add generator for Golang interfaces
In-Reply-To: <Z4mBWMqktTPWKaGR@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 16 Jan 2025 21:59:52 +0000")
References: <20250110104946.74960-1-victortoso@redhat.com>
 <Z4mBWMqktTPWKaGR@redhat.com>
Date: Fri, 17 Jan 2025 11:44:21 +0100
Message-ID: <87v7udvhx6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Jan 10, 2025 at 11:49:38AM +0100, Victor Toso wrote:
>> I've pushed this series in my gitlab fork:
>> https://gitlab.com/victortoso/qapi-go/
>>=20
>> The fork contains some tests, including tests that were generated from
>> QAPI's own examples from another generator created for testing, if you
>> are interested in it:
>> https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg04946.html
>>=20
>> I've generated the qapi-go module over each commit of this series, see:
>> https://gitlab.com/victortoso/qapi-go/-/commits/qapi-golang-v3-by-patch
>>=20
>> I've also generated the qapi-go module over QEMU tags: v9.1.0, v9.2.0:
>> https://gitlab.com/victortoso/qapi-go/-/commits/qapi-golang-v3-by-tags
>
> Apologies in advance for what will be a long mail.....

I decline the opportunity for the pot to call the kettle black ;)

[...]

> NB What I've not especially considered in any of this is the impact of
> differing QEMU versions & their schema changes. The easy way out is to
> just re-run the generator for each version, putting them in a separate
> Go package. So you can do 'import' of "qapi/qemu/abi920" for 9.2.0
> schema APIs, or "qapi/qemu/910" for 9.1.0 schema APIs. The app dev would
> have to choose which version (or versions) they consume & implement
> against. Splitting versions across the whole package, avoids having to
> consider versioning within parameters of a single command/event.

I endorse this approach.

First, a practical point.  We want to generate bindings from the schema.
The generator we have works on the current version of the schema.  To
generate something spanning versions, we would have to make it work on
several versions, wouldn't we?  I don't think we can afford such
ambition.

Next, some supporting thoughts on interfaces and why bindings spanning
versions feels like way too much trouble to me.

QMP was designed for compatible schema evolution: we can evolve the
schema without breaking clients of the wire interface as long as they
stick to certain rules, such as "ignore unknown members in client
input".

Occasionally, the schema needs to change in ways that can affect such
clients.  We promise to give clients notice and time to adjust: we
formally deprecate the old interface, but keep it working for a grace
period, namely the release it was deprecated and one further release.

So, if your QMP client targets a specific version of the wire interface,
and avoids deprecated stuff, it'll be fine for at least two more
releases.  After that, you better upgrade the client.

This is a moderately flexible coupling between QMP client and server.

When you stretch it beyond the limit, things for the most part continue
to work.  Only the things we changed incompatibly can break.

If you need more flexible coupling, you can use QMP introspection to
target a *range* of wire interfaces.  The price is additional complexity
in the client.

Downstreams complicate this story a bit, but not in interesting ways, I
believe.

The existing C bindings are for the current schema version only.  That's
fine, because the only customer (QEMU) only cares for the current
version.

It would also be fine for external customers as long as they only need
the moderately flexible coupling described above.

Bindings spanning schema versions are significantly harder.

Do our rules for compatible schema evolution transfer from the
JSON-based wire interface to the bindings?  Not necessarily.  May
require acrobatics that make the bindings ugly.

Example: adding an argument to an event is compatible evolution.

Adding it to the C function to send the event is not compatible: it
breaks the build, and all callers need to be adjusted to fix it.  Yes,
this may not be an issue with certain other languages, but my point
stands: not necessarily.

Example: adding a member to an object type is compatible evolution.

Adding it to the type in the ABI is not compatible: mixing ABI before
and after won't link if you're lucky, and run amok at run time if you're
not.


