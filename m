Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2082C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 05:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5IEg-0002RL-05; Thu, 17 Apr 2025 01:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u5IEe-0002Na-3C
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 01:56:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u5IEb-0001h5-Cp
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 01:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744869383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fV/zUsYUfEpjLtSRVTw1QYlXl+TL4iLw5Bnz+HIW/fw=;
 b=fgWNLc3S8N7c5Tfp+jkzZJ+rmxUk8Ud64p0QFCqa+v04Nsv27gPfWLPivwelPGEndcQ1w0
 Szb3StTfLqzm7PjXGYTfrrKx4mqtYhPt0U/L6phmILUKgKBIXOpDpfEnD2wKOf/lhhYNEX
 eryAz7e/6ZbofYG6ZDlIP2TJ63A+Nwg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-aNmdGxZ6Nuym3lfx2fIfwQ-1; Thu,
 17 Apr 2025 01:56:20 -0400
X-MC-Unique: aNmdGxZ6Nuym3lfx2fIfwQ-1
X-Mimecast-MFC-AGG-ID: aNmdGxZ6Nuym3lfx2fIfwQ_1744869380
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8E201800374; Thu, 17 Apr 2025 05:56:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52ABD1800D97; Thu, 17 Apr 2025 05:56:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 699E221E66C3; Thu, 17 Apr 2025 07:56:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>
Subject: Re: [RFC PATCH 05/13] migration: Reduce a bit of duplication in
 migration.json
In-Reply-To: <878qo0f9tg.fsf@suse.de> (Fabiano Rosas's message of "Wed, 16 Apr
 2025 11:41:15 -0300")
References: <20250411191443.22565-1-farosas@suse.de>
 <20250411191443.22565-6-farosas@suse.de> <Z_056amMGN6Ey_1i@redhat.com>
 <87y0w2fzhp.fsf@suse.de> <878qo0mdk1.fsf@pond.sub.org>
 <878qo0f9tg.fsf@suse.de>
Date: Thu, 17 Apr 2025 07:56:16 +0200
Message-ID: <87r01rjpq7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fabiano Rosas <farosas@suse.de> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> Fabiano Rosas <farosas@suse.de> writes:
>>
>>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>>
>>>> On Fri, Apr 11, 2025 at 04:14:35PM -0300, Fabiano Rosas wrote:
>>>>> Introduce a new MigrationConfigBase, to allow most of the duplication
>>>>> in migration.json to be eliminated.
>>>>>=20
>>>>> The reason we need MigrationParameters and MigrationSetParameters is
>>>>> that the internal parameter representation in the migration code, as
>>>>> well as the user-facing return of query-migrate-parameters use one
>>>>> type for the TLS options (tls-creds, tls-hostname, tls-authz), while
>>>>> the user-facing input from migrate-set-parameters uses another.
>>>>>=20
>>>>> The difference is in whether the NULL values is accepted. The former
>>>>> considers NULL as invalid, while the latter doesn't.
>>>>>=20
>>>>> Move all other (non-TLS) options into the new type and make it a base
>>>>> type for the two diverging types so that each child type can declare
>>>>> the TLS options in its own way.
>>>>>=20
>>>>> Nothing changes in the user API, nothing changes in the internal
>>>>> representation, but we save several lines of duplication in
>>>>> migration.json.
>>>>>=20
>>>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>>>> ---
>>>>>  qapi/migration.json | 358 +++++++++++++-----------------------------=
--
>>>>>  1 file changed, 108 insertions(+), 250 deletions(-)
>>>>>=20
>>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>>> index 8b9c53595c..5a4d5a2d3e 100644
>>>>> --- a/qapi/migration.json
>>>>> +++ b/qapi/migration.json
>>>>> @@ -914,202 +914,6 @@
>>>>
>>>>> @@ -1277,45 +1059,121 @@
>>>>>  #     only has effect if the @mapped-ram capability is enabled.
>>>>>  #     (Since 9.1)
>>>>>  #
>>>>> +# @tls: Whether to use TLS. If this is set the options @tls-authz,
>>>>> +#     @tls-creds, @tls-hostname are mandatory and a valid string is
>>>>> +#     expected. (Since 10.1)
>>>>> +#
>>>>
>>>> I'm not really finding it compelling to add a bool @tls as it
>>>> is just a denormalization of  !!@tls-creds.
>>>>
>>>
>>> This is here by mistake.
>>>
>>> I remember Markus mentioning that implying TLS usage from tls-creds was
>>> undesirable. I was prototyping a way of requiring an explicit opt-in.
>>
>> I don't remember a thing :)
>>
>
> I hope I interpreted you correctly:
>
>   "We have three syntactically independent parameters: @tls-creds,
>   @tls-hostname, @tls-authz.  The latter two are meaningless (and silently
>   ignored) unless the first one is given.  I hate that.
>=20=20=20
>   TLS is off by default.  To enable it, set @tls-creds.  Except setting it
>   to the otherwise invalid value "" disables it.  That's because all we
>   have for configuration is the "set migration parameter to value"
>   interface.  Only works because we have an invalid value we can abuse.  I
>   hate that." -- https://lore.kernel.org/all/877cnrjd71.fsf@pond.sub.org/

Ah, now I remember!

Possible minimally invasive improvement here:

* Reject @tls-hostname and @tls-authz when the value of @tls-creds means
  "TLS is off".

* When @tls-set-creds get set to a value that means "TLS is off",
  @tls-hostname and @tls-authz get unset.

This could break applications.  I'm not at all sure the slight reduction
in ugliness would be worth the risk.

I do not mean to discourage pursuing your RFC!  The TLS configuration is
ugly and confusing to use internally.  Getting that streamlined would be
nice.

> I still think it might be an improvement to define a new interface that
> requires explicitly enabling TLS. IOW, make tls a capability. But I
> really don't want to get caught on that right now, one mess at a time.

First: one mess at a time is commonly the sensible approach.

Second: I'm not sure attempts to make the existing migration
configuration interfaces somewhat less ugly and confusing are
worthwhile.

I rarely advocate starting over just because something is ugly.
However, migration configuration is not only ugly; its use of global
state feels fundamentally misguided to me.  Evidence: the surprising
side effects on savevm Daniel mentioned.  I'll add: when a management
application connects to an existing QEMU, it needs to laboriously set
the entire global migration configuration state, or else rely on unsound
assumptions.  Complete non-problem when the entire configuration is
passed to the command, like we do elsewhere.

>>>> Incidentally the docs here are wrong - TLS can be used by
>>>> only setting @tls-creds. The @tls-authz & @tls-hostname
>>>> params are always optional.
>>>>
>>>>>  # Features:
>>>>>  #
>>>>>  # @unstable: Members @x-checkpoint-delay and
>>>>>  #     @x-vcpu-dirty-limit-period are experimental.
>>>>>  #
>>>>> +# Since: 10.1
>>>>> +##
>>>>> +{ 'struct': 'MigrationConfigBase',
>>>>> +  'data': { '*announce-initial': 'size',
>>>>> +            '*announce-max': 'size',
>>>>> +            '*announce-rounds': 'size',
>>>>> +            '*announce-step': 'size',
>>>>> +            '*throttle-trigger-threshold': 'uint8',
>>>>> +            '*cpu-throttle-initial': 'uint8',
>>>>> +            '*cpu-throttle-increment': 'uint8',
>>>>> +            '*cpu-throttle-tailslow': 'bool',
>>>>> +            '*max-bandwidth': 'size',
>>>>> +            '*avail-switchover-bandwidth': 'size',
>>>>> +            '*downtime-limit': 'uint64',
>>>>> +            '*x-checkpoint-delay': { 'type': 'uint32',
>>>>> +                                     'features': [ 'unstable' ] },
>>>>> +            '*multifd-channels': 'uint8',
>>>>> +            '*xbzrle-cache-size': 'size',
>>>>> +            '*max-postcopy-bandwidth': 'size',
>>>>> +            '*max-cpu-throttle': 'uint8',
>>>>> +            '*multifd-compression': 'MultiFDCompression',
>>>>> +            '*multifd-zlib-level': 'uint8',
>>>>> +            '*multifd-qatzip-level': 'uint8',
>>>>> +            '*multifd-zstd-level': 'uint8',
>>>>> +            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
>>>>> +            '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
>>>>> +                                            'features': [ 'unstable'=
 ] },
>>>>> +            '*vcpu-dirty-limit': 'uint64',
>>>>> +            '*mode': 'MigMode',
>>>>> +            '*zero-page-detection': 'ZeroPageDetection',
>>>>> +            '*direct-io': 'bool',
>>>>> +            '*tls': 'bool' } }
>>>>
>>>>
>>>>>  { 'struct': 'MigrationParameters',
>>>>> +  'base': 'MigrationConfigBase',
>>>>> +  'data': { 'tls-creds': 'str',
>>>>> +            'tls-hostname': 'str',
>>>>> +            'tls-authz': 'str' } }
>>>>
>>>> snip
>>>>
>>>>> +{ 'struct': 'MigrateSetParameters',
>>>>> +  'base': 'MigrationConfigBase',
>>>>> +  'data': { '*tls-creds': 'StrOrNull',
>>>>> +            '*tls-hostname': 'StrOrNull',
>>>>> +            '*tls-authz': 'StrOrNull' } }
>>>>
>>>> I recall we discussed this difference a year or two ago, but can't
>>>> recall what the outcome was.
>>>>
>>>> Making the TLS params optional is a back compatible change for
>>>> MigrationParameters. I would think replacing 'str' with 'StrOrNull'
>>>> is also back compatible. So I'm wondering if we can't just unify
>>>> the sttructs fully for TLS, even if one usage scenario never actually
>>>> needs the "OrNull" bit nor needs the optionality=20
>>>>
>>>
>>> MigrationParameters is the output type for query-migrate-parameters. I
>>> belive it must be all non-optional to keep compatibility. The docs on
>>> master say: "The optional members aren't really optional"
>>
>> To be precise: even though the members are declared optional, they must
>> always be present.
>>
>> The members became optional when commit de63ab61241 (migrate: Share
>> common MigrationParameters struct) reused MigrationParameters as
>> migrate-set-parameters argument type.
>>
>
> Then, commit 1bda8b3c69 (migration: Unshare MigrationParameters struct
> for now, 2017-07-18) partially undid that change and introduced
> MigrateSetParameters.
>
> At that point we might have been able to make the MigrationParameters'
> members mandatory, but it was chosen not too, probably with good
> reason. I can't tell from the commit message.

As far as I remember: to minimize last minute churn, and to not
complicate a future re-sharing.

> Strictly speaking, we cannot make them mandatory now because commit
> 31e4c354b3 (migration: Add block-bitmap-mapping parameter, 2020-08-20)
> added the block-bitmap parameter, but made its output in
> query-migrate-parameters truly optional:
>
>     if (s->parameters.has_block_bitmap_mapping) {
>         params->has_block_bitmap_mapping =3D true;
>         params->block_bitmap_mapping =3D
>             QAPI_CLONE(BitmapMigrationNodeAliasList,
>                        s->parameters.block_bitmap_mapping);
>     }

We're consistently inconsistent ;)

>> Making mandatory members of some type optional is compatible as long as
>> the type occurs only in command arguments.  But MigrationParameters is a
>> command return type.  Making its members optional was not kosher.
>> Because the optional members are always present, QMP didn't actually
>> change, except for introspection.
>>
>>> For MigrateSetParameters they've always been optional and continue to
>>> be. There we need to keep StrOrNull for compat.
>>
>> StrOrNull goes back to commit 01fa5598269 (migration: Use JSON null
>> instead of "" to reset parameter to default).
>>
>> Similar argument: adding values to a member is compatible as long as the
>> type occurs only in command arguments.  But MigrationParameters is a
>> command return type.  Adding value null is won't be kosher.  However, as
>> long as as the value is never actually used there, QMP won't actually
>> change, except for introspection.
>>
>> If this was a clean and obvious interface, I'd argue against such
>> trickery and for keeping it clean and obvious.  But the migration
>> configuration interface isn't.


