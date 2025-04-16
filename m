Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3825C369C2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 13:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u52yf-0003ax-RL; Wed, 16 Apr 2025 09:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u52yc-0003Zf-8C
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 09:38:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u52yX-00058h-UB
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 09:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744810727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SV+BuKd8Go05g35Jj9yBwLDr0jqtMfLYdDH3/9TLl4s=;
 b=Yq8vy/Z4QPrWY+V503SImR0+/zc5cAhQ7QQsxTDtb1cyDV0YtumhEfxfPgGjwDyl6Z7caf
 V6uEcr2Nu6Vx6UHIP/68loSMUrvSpEpZwojuW4uFHo1nHEZm7GmSlZG3Kwc5jzEyGos1yI
 zaCbZMhr47sHp22fMpOV0oSm/SDAhW4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-v8eAviT1NQmVCnLRpoy7sA-1; Wed,
 16 Apr 2025 09:38:43 -0400
X-MC-Unique: v8eAviT1NQmVCnLRpoy7sA-1
X-Mimecast-MFC-AGG-ID: v8eAviT1NQmVCnLRpoy7sA_1744810723
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E6E319560B6; Wed, 16 Apr 2025 13:38:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BF9F195608D; Wed, 16 Apr 2025 13:38:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2F0C321E66C3; Wed, 16 Apr 2025 15:38:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>
Subject: Re: [RFC PATCH 05/13] migration: Reduce a bit of duplication in
 migration.json
In-Reply-To: <87y0w2fzhp.fsf@suse.de> (Fabiano Rosas's message of "Mon, 14 Apr
 2025 14:02:10 -0300")
References: <20250411191443.22565-1-farosas@suse.de>
 <20250411191443.22565-6-farosas@suse.de> <Z_056amMGN6Ey_1i@redhat.com>
 <87y0w2fzhp.fsf@suse.de>
Date: Wed, 16 Apr 2025 15:38:38 +0200
Message-ID: <878qo0mdk1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
>> On Fri, Apr 11, 2025 at 04:14:35PM -0300, Fabiano Rosas wrote:
>>> Introduce a new MigrationConfigBase, to allow most of the duplication
>>> in migration.json to be eliminated.
>>>=20
>>> The reason we need MigrationParameters and MigrationSetParameters is
>>> that the internal parameter representation in the migration code, as
>>> well as the user-facing return of query-migrate-parameters use one
>>> type for the TLS options (tls-creds, tls-hostname, tls-authz), while
>>> the user-facing input from migrate-set-parameters uses another.
>>>=20
>>> The difference is in whether the NULL values is accepted. The former
>>> considers NULL as invalid, while the latter doesn't.
>>>=20
>>> Move all other (non-TLS) options into the new type and make it a base
>>> type for the two diverging types so that each child type can declare
>>> the TLS options in its own way.
>>>=20
>>> Nothing changes in the user API, nothing changes in the internal
>>> representation, but we save several lines of duplication in
>>> migration.json.
>>>=20
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>> ---
>>>  qapi/migration.json | 358 +++++++++++++-------------------------------
>>>  1 file changed, 108 insertions(+), 250 deletions(-)
>>>=20
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index 8b9c53595c..5a4d5a2d3e 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -914,202 +914,6 @@
>>
>>> @@ -1277,45 +1059,121 @@
>>>  #     only has effect if the @mapped-ram capability is enabled.
>>>  #     (Since 9.1)
>>>  #
>>> +# @tls: Whether to use TLS. If this is set the options @tls-authz,
>>> +#     @tls-creds, @tls-hostname are mandatory and a valid string is
>>> +#     expected. (Since 10.1)
>>> +#
>>
>> I'm not really finding it compelling to add a bool @tls as it
>> is just a denormalization of  !!@tls-creds.
>>
>
> This is here by mistake.
>
> I remember Markus mentioning that implying TLS usage from tls-creds was
> undesirable. I was prototyping a way of requiring an explicit opt-in.

I don't remember a thing :)

>> Incidentally the docs here are wrong - TLS can be used by
>> only setting @tls-creds. The @tls-authz & @tls-hostname
>> params are always optional.
>>
>>>  # Features:
>>>  #
>>>  # @unstable: Members @x-checkpoint-delay and
>>>  #     @x-vcpu-dirty-limit-period are experimental.
>>>  #
>>> +# Since: 10.1
>>> +##
>>> +{ 'struct': 'MigrationConfigBase',
>>> +  'data': { '*announce-initial': 'size',
>>> +            '*announce-max': 'size',
>>> +            '*announce-rounds': 'size',
>>> +            '*announce-step': 'size',
>>> +            '*throttle-trigger-threshold': 'uint8',
>>> +            '*cpu-throttle-initial': 'uint8',
>>> +            '*cpu-throttle-increment': 'uint8',
>>> +            '*cpu-throttle-tailslow': 'bool',
>>> +            '*max-bandwidth': 'size',
>>> +            '*avail-switchover-bandwidth': 'size',
>>> +            '*downtime-limit': 'uint64',
>>> +            '*x-checkpoint-delay': { 'type': 'uint32',
>>> +                                     'features': [ 'unstable' ] },
>>> +            '*multifd-channels': 'uint8',
>>> +            '*xbzrle-cache-size': 'size',
>>> +            '*max-postcopy-bandwidth': 'size',
>>> +            '*max-cpu-throttle': 'uint8',
>>> +            '*multifd-compression': 'MultiFDCompression',
>>> +            '*multifd-zlib-level': 'uint8',
>>> +            '*multifd-qatzip-level': 'uint8',
>>> +            '*multifd-zstd-level': 'uint8',
>>> +            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
>>> +            '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
>>> +                                            'features': [ 'unstable' ]=
 },
>>> +            '*vcpu-dirty-limit': 'uint64',
>>> +            '*mode': 'MigMode',
>>> +            '*zero-page-detection': 'ZeroPageDetection',
>>> +            '*direct-io': 'bool',
>>> +            '*tls': 'bool' } }
>>
>>
>>>  { 'struct': 'MigrationParameters',
>>> +  'base': 'MigrationConfigBase',
>>> +  'data': { 'tls-creds': 'str',
>>> +            'tls-hostname': 'str',
>>> +            'tls-authz': 'str' } }
>>
>> snip
>>
>>> +{ 'struct': 'MigrateSetParameters',
>>> +  'base': 'MigrationConfigBase',
>>> +  'data': { '*tls-creds': 'StrOrNull',
>>> +            '*tls-hostname': 'StrOrNull',
>>> +            '*tls-authz': 'StrOrNull' } }
>>
>> I recall we discussed this difference a year or two ago, but can't
>> recall what the outcome was.
>>
>> Making the TLS params optional is a back compatible change for
>> MigrationParameters. I would think replacing 'str' with 'StrOrNull'
>> is also back compatible. So I'm wondering if we can't just unify
>> the sttructs fully for TLS, even if one usage scenario never actually
>> needs the "OrNull" bit nor needs the optionality=20
>>
>
> MigrationParameters is the output type for query-migrate-parameters. I
> belive it must be all non-optional to keep compatibility. The docs on
> master say: "The optional members aren't really optional"

To be precise: even though the members are declared optional, they must
always be present.

The members became optional when commit de63ab61241 (migrate: Share
common MigrationParameters struct) reused MigrationParameters as
migrate-set-parameters argument type.

Making mandatory members of some type optional is compatible as long as
the type occurs only in command arguments.  But MigrationParameters is a
command return type.  Making its members optional was not kosher.
Because the optional members are always present, QMP didn't actually
change, except for introspection.

> For MigrateSetParameters they've always been optional and continue to
> be. There we need to keep StrOrNull for compat.

StrOrNull goes back to commit 01fa5598269 (migration: Use JSON null
instead of "" to reset parameter to default).

Similar argument: adding values to a member is compatible as long as the
type occurs only in command arguments.  But MigrationParameters is a
command return type.  Adding value null is won't be kosher.  However, as
long as as the value is never actually used there, QMP won't actually
change, except for introspection.

If this was a clean and obvious interface, I'd argue against such
trickery and for keeping it clean and obvious.  But the migration
configuration interface isn't.


