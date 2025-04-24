Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4CEC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7t0N-0003ST-C8; Thu, 24 Apr 2025 05:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u7t0H-0003RI-OK
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:36:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u7t0F-0001NF-M0
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745487373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f2+uNMypbcS2rEm8vr2Jromuvq4da3xOsm9vPyKMCOo=;
 b=E1T296TZ/2xA84VG83EcosasM+GfzdCKDjcOxsoAFkqWKV39Ss/FZ7PJwh5LSCnm0qbyWF
 5ZeTd6plWTBuGwFSQFYahk6vINj+ND3trJAbMHM2e1Wq5mpGK1U59To0wViNktUMyrJCO+
 s+xRMjKaP74kagC33kCWeSD7n3d4Og8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-Za9qFjKBM2u9SQaJSZxK2g-1; Thu,
 24 Apr 2025 05:36:02 -0400
X-MC-Unique: Za9qFjKBM2u9SQaJSZxK2g-1
X-Mimecast-MFC-AGG-ID: Za9qFjKBM2u9SQaJSZxK2g_1745487362
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F17871800261; Thu, 24 Apr 2025 09:36:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.5])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5859B1956095; Thu, 24 Apr 2025 09:36:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8FD9121E6768; Thu, 24 Apr 2025 11:35:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>
Subject: Re: [RFC PATCH 00/13] migration: Unify capabilities and parameters
In-Reply-To: <875xj4f8xi.fsf@suse.de> (Fabiano Rosas's message of "Wed, 16 Apr
 2025 12:00:25 -0300")
References: <20250411191443.22565-1-farosas@suse.de>
 <Z_07dfI4rFRpvZA1@redhat.com> <874iyomdat.fsf@pond.sub.org>
 <875xj4f8xi.fsf@suse.de>
Date: Thu, 24 Apr 2025 11:35:57 +0200
Message-ID: <87plh17vgi.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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

Fabiano Rosas <farosas@suse.de> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>
>>> On Fri, Apr 11, 2025 at 04:14:30PM -0300, Fabiano Rosas wrote:
>>>> Open questions:
>>>> ---------------
>>>>=20
>>>> - Deprecations/compat?
>>>>=20
>>>> I think we should deprecate migrate-set/query-capabilities and everyth=
ing to do
>>>> with capabilities (specifically the validation in the JSON at the end =
of the
>>>> stream).
>>>>=20
>>>> For migrate-set/query-parameters, we could probably keep it around ind=
efinitely,
>>>> but it'd be convenient to introduce new commands so we can give them n=
ew
>>>> semantics.
>>>>=20
>>>> - How to restrict the options that should not be set when the migratio=
n is in
>>>> progress?
>>>>=20
>>>> i.e.:
>>>>   all options can be set before migration (initial config)
>>>>   some options can be set during migration (runtime)
>>>>=20
>>>> I thought of adding another type at the top of the hierarchy, with
>>>> just the options allowed to change at runtime, but that doesn't really
>>>> stop the others being also set at runtime. I'd need a way to have a
>>>> set of options that are rejected 'if migration_is_running()', without
>>>> adding more duplication all around.
>>>>=20
>>>> - What about savevm?
>>>>=20
>>>> None of this solves the issue of random caps/params being set before
>>>> calling savevm. We still need to special-case savevm and reject
>>>> everything. Unless we entirely deprecate setting initial options via
>>>> set-parameters (or set-config) and require all options to be set as
>>>> savevm (and migrate) arguments.
>>>
>>> I'd suggest we aim for a world where the commands take all options
>>> as direct args and try to remove the global state eventually.
>>
>> Yes.
>>
>> Even better: make it a job.
>
> What do we gain from that in relation to being able to pass ~50
> parameters to a command? I don't see it. I think that's the actual crux
> here, too many options and how to get them from the QAPI into the
> migration core for consumption.

Two separate interface design problems:

1. Query and manipulate complex configuration

2. Control and monitor long-running jobs

Let's start with 1.

Migration is not the only instance of complex configuration.  Block
devices are arguably even more complex.  A difference: we can have many
block devices, but just one migration.

Here's the usual way to configure things: commands creating a thing take
the thing's configuration as arguments, other commands query and
manipulate a thing's configuration.  Works fine both for simple and
complex configuration.  Block devices work this way.

Migration doesn't.  Instead, we have global configuration state, and
commands to query and manipulate it.  Also works.

Instead of passing the entire configuration to the "create" command, you
can pass it piecemeal to "manipulate global configuration" commands.
You pay for the convenience by having to reset the entire global
configuration to a known state in certain situations.  Since use of the
global configuration state is implicit, it can be surprising, as Daniel
pointed out for savevm.

Overall, this isn't simpler or more convenient than the usual way, just
different.

Both ways use QAPI objects to hold configuration.  Query commands can
return such an object.  Commands that deal with partial configuration
can only take the same object when its members are optional.

In places where configuration is complete (internal configuration state,
the query command that returns it), optional makes no sense, and is
annoying.  We either accept that, or duplicate the configuration object.
Duplicating violates DRY.  It does result in better command
documentation, though.

On to 2.

Migration is not the only kind of long-running job.  There's also
block-commit, block-stream, drive-mirror, drive-backup, blockdev-create,
x-blockdev-amend, snapshot-load, snapshot-save, snapshot-delete.

These all create a "job" object that represents the long-running job.
We have commands and events to control and monitor such jobs: job-pause,
job-resume, job-cancel, job-complete, job-dismiss, job-finalize,
query-jobs, JOB_STATUS_CHANGE.

Migration does its own thing instead.

> The current usage of MigrationParameters as both the return type for
> query-set-parameters and the global parameter store for the migration
> state is really dissonant. What do the has_* fields even mean when
> accessed via MigrationState::parameters?

Yes, it's ugly, and the alternative is differently ugly, as discussed
above.

>                                          This series is not doing any
> better in that regard, mind you. I'm almost tempted to ask that we
> expose the QDict from the marshaling function directly to the migration
> code, at least that's a data type that makes sense internally.

Based on experience in the block layer, I predict you'd regret this :)

Use of native C data types is just so much easier on the eyes than
messing with QObjects.  Moreover, the compiler can't help you as much
with QObjects.


