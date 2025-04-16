Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8164C369BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 14:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u53x6-00072N-LN; Wed, 16 Apr 2025 10:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u53x5-000728-ER
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 10:41:23 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u53x2-0008KK-SV
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 10:41:23 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E34531F74A;
 Wed, 16 Apr 2025 14:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744814478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2C/vFi6WP3a/Ripa2m5rTK6ElrLMjYQxO2ha088tEoQ=;
 b=PSvVO3Ynvoja715IQ9t68tPhp4YTMljtuB6uyivfm73b0NS+erOi4owkjlMgaqE5KHcvAu
 L3/rzq7u5ai0DdXgkkwAfcf6EVsYBX/BT0j17FetPbBbKUJ0EyGgY+cERLlQiBb2abWQdw
 btMjutXVoKNnm4KYrwTIMx1gNjhAp+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744814478;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2C/vFi6WP3a/Ripa2m5rTK6ElrLMjYQxO2ha088tEoQ=;
 b=SlfZYQoIo3YF1Au4hgeJ0MD0maKF/QdNegHiDierMQMN03P7uV+xSmv4GNuAG53Hnqe82d
 3tdvzUlST+xpuSCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744814478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2C/vFi6WP3a/Ripa2m5rTK6ElrLMjYQxO2ha088tEoQ=;
 b=PSvVO3Ynvoja715IQ9t68tPhp4YTMljtuB6uyivfm73b0NS+erOi4owkjlMgaqE5KHcvAu
 L3/rzq7u5ai0DdXgkkwAfcf6EVsYBX/BT0j17FetPbBbKUJ0EyGgY+cERLlQiBb2abWQdw
 btMjutXVoKNnm4KYrwTIMx1gNjhAp+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744814478;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2C/vFi6WP3a/Ripa2m5rTK6ElrLMjYQxO2ha088tEoQ=;
 b=SlfZYQoIo3YF1Au4hgeJ0MD0maKF/QdNegHiDierMQMN03P7uV+xSmv4GNuAG53Hnqe82d
 3tdvzUlST+xpuSCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CC6A139A1;
 Wed, 16 Apr 2025 14:41:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lF27Bo7B/2clUgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 16 Apr 2025 14:41:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Subject: Re: [RFC PATCH 05/13] migration: Reduce a bit of duplication in
 migration.json
In-Reply-To: <878qo0mdk1.fsf@pond.sub.org>
References: <20250411191443.22565-1-farosas@suse.de>
 <20250411191443.22565-6-farosas@suse.de> <Z_056amMGN6Ey_1i@redhat.com>
 <87y0w2fzhp.fsf@suse.de> <878qo0mdk1.fsf@pond.sub.org>
Date: Wed, 16 Apr 2025 11:41:15 -0300
Message-ID: <878qo0f9tg.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> writes:
>
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>
>>> On Fri, Apr 11, 2025 at 04:14:35PM -0300, Fabiano Rosas wrote:
>>>> Introduce a new MigrationConfigBase, to allow most of the duplication
>>>> in migration.json to be eliminated.
>>>>=20
>>>> The reason we need MigrationParameters and MigrationSetParameters is
>>>> that the internal parameter representation in the migration code, as
>>>> well as the user-facing return of query-migrate-parameters use one
>>>> type for the TLS options (tls-creds, tls-hostname, tls-authz), while
>>>> the user-facing input from migrate-set-parameters uses another.
>>>>=20
>>>> The difference is in whether the NULL values is accepted. The former
>>>> considers NULL as invalid, while the latter doesn't.
>>>>=20
>>>> Move all other (non-TLS) options into the new type and make it a base
>>>> type for the two diverging types so that each child type can declare
>>>> the TLS options in its own way.
>>>>=20
>>>> Nothing changes in the user API, nothing changes in the internal
>>>> representation, but we save several lines of duplication in
>>>> migration.json.
>>>>=20
>>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>>> ---
>>>>  qapi/migration.json | 358 +++++++++++++-------------------------------
>>>>  1 file changed, 108 insertions(+), 250 deletions(-)
>>>>=20
>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>> index 8b9c53595c..5a4d5a2d3e 100644
>>>> --- a/qapi/migration.json
>>>> +++ b/qapi/migration.json
>>>> @@ -914,202 +914,6 @@
>>>
>>>> @@ -1277,45 +1059,121 @@
>>>>  #     only has effect if the @mapped-ram capability is enabled.
>>>>  #     (Since 9.1)
>>>>  #
>>>> +# @tls: Whether to use TLS. If this is set the options @tls-authz,
>>>> +#     @tls-creds, @tls-hostname are mandatory and a valid string is
>>>> +#     expected. (Since 10.1)
>>>> +#
>>>
>>> I'm not really finding it compelling to add a bool @tls as it
>>> is just a denormalization of  !!@tls-creds.
>>>
>>
>> This is here by mistake.
>>
>> I remember Markus mentioning that implying TLS usage from tls-creds was
>> undesirable. I was prototyping a way of requiring an explicit opt-in.
>
> I don't remember a thing :)
>

I hope I interpreted you correctly:

  "We have three syntactically independent parameters: @tls-creds,
  @tls-hostname, @tls-authz.  The latter two are meaningless (and silently
  ignored) unless the first one is given.  I hate that.
=20=20
  TLS is off by default.  To enable it, set @tls-creds.  Except setting it
  to the otherwise invalid value "" disables it.  That's because all we
  have for configuration is the "set migration parameter to value"
  interface.  Only works because we have an invalid value we can abuse.  I
  hate that." -- https://lore.kernel.org/all/877cnrjd71.fsf@pond.sub.org/

I still think it might be an improvement to define a new interface that
requires explicitly enabling TLS. IOW, make tls a capability. But I
really don't want to get caught on that right now, one mess at a time.

>>> Incidentally the docs here are wrong - TLS can be used by
>>> only setting @tls-creds. The @tls-authz & @tls-hostname
>>> params are always optional.
>>>
>>>>  # Features:
>>>>  #
>>>>  # @unstable: Members @x-checkpoint-delay and
>>>>  #     @x-vcpu-dirty-limit-period are experimental.
>>>>  #
>>>> +# Since: 10.1
>>>> +##
>>>> +{ 'struct': 'MigrationConfigBase',
>>>> +  'data': { '*announce-initial': 'size',
>>>> +            '*announce-max': 'size',
>>>> +            '*announce-rounds': 'size',
>>>> +            '*announce-step': 'size',
>>>> +            '*throttle-trigger-threshold': 'uint8',
>>>> +            '*cpu-throttle-initial': 'uint8',
>>>> +            '*cpu-throttle-increment': 'uint8',
>>>> +            '*cpu-throttle-tailslow': 'bool',
>>>> +            '*max-bandwidth': 'size',
>>>> +            '*avail-switchover-bandwidth': 'size',
>>>> +            '*downtime-limit': 'uint64',
>>>> +            '*x-checkpoint-delay': { 'type': 'uint32',
>>>> +                                     'features': [ 'unstable' ] },
>>>> +            '*multifd-channels': 'uint8',
>>>> +            '*xbzrle-cache-size': 'size',
>>>> +            '*max-postcopy-bandwidth': 'size',
>>>> +            '*max-cpu-throttle': 'uint8',
>>>> +            '*multifd-compression': 'MultiFDCompression',
>>>> +            '*multifd-zlib-level': 'uint8',
>>>> +            '*multifd-qatzip-level': 'uint8',
>>>> +            '*multifd-zstd-level': 'uint8',
>>>> +            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
>>>> +            '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
>>>> +                                            'features': [ 'unstable' =
] },
>>>> +            '*vcpu-dirty-limit': 'uint64',
>>>> +            '*mode': 'MigMode',
>>>> +            '*zero-page-detection': 'ZeroPageDetection',
>>>> +            '*direct-io': 'bool',
>>>> +            '*tls': 'bool' } }
>>>
>>>
>>>>  { 'struct': 'MigrationParameters',
>>>> +  'base': 'MigrationConfigBase',
>>>> +  'data': { 'tls-creds': 'str',
>>>> +            'tls-hostname': 'str',
>>>> +            'tls-authz': 'str' } }
>>>
>>> snip
>>>
>>>> +{ 'struct': 'MigrateSetParameters',
>>>> +  'base': 'MigrationConfigBase',
>>>> +  'data': { '*tls-creds': 'StrOrNull',
>>>> +            '*tls-hostname': 'StrOrNull',
>>>> +            '*tls-authz': 'StrOrNull' } }
>>>
>>> I recall we discussed this difference a year or two ago, but can't
>>> recall what the outcome was.
>>>
>>> Making the TLS params optional is a back compatible change for
>>> MigrationParameters. I would think replacing 'str' with 'StrOrNull'
>>> is also back compatible. So I'm wondering if we can't just unify
>>> the sttructs fully for TLS, even if one usage scenario never actually
>>> needs the "OrNull" bit nor needs the optionality=20
>>>
>>
>> MigrationParameters is the output type for query-migrate-parameters. I
>> belive it must be all non-optional to keep compatibility. The docs on
>> master say: "The optional members aren't really optional"
>
> To be precise: even though the members are declared optional, they must
> always be present.
>
> The members became optional when commit de63ab61241 (migrate: Share
> common MigrationParameters struct) reused MigrationParameters as
> migrate-set-parameters argument type.
>

Then, commit 1bda8b3c69 (migration: Unshare MigrationParameters struct
for now, 2017-07-18) partially undid that change and introduced
MigrateSetParameters.

At that point we might have been able to make the MigrationParameters'
members mandatory, but it was chosen not too, probably with good
reason. I can't tell from the commit message.

Strictly speaking, we cannot make them mandatory now because commit
31e4c354b3 (migration: Add block-bitmap-mapping parameter, 2020-08-20)
added the block-bitmap parameter, but made its output in
query-migrate-parameters truly optional:

    if (s->parameters.has_block_bitmap_mapping) {
        params->has_block_bitmap_mapping =3D true;
        params->block_bitmap_mapping =3D
            QAPI_CLONE(BitmapMigrationNodeAliasList,
                       s->parameters.block_bitmap_mapping);
    }

> Making mandatory members of some type optional is compatible as long as
> the type occurs only in command arguments.  But MigrationParameters is a
> command return type.  Making its members optional was not kosher.
> Because the optional members are always present, QMP didn't actually
> change, except for introspection.
>
>> For MigrateSetParameters they've always been optional and continue to
>> be. There we need to keep StrOrNull for compat.
>
> StrOrNull goes back to commit 01fa5598269 (migration: Use JSON null
> instead of "" to reset parameter to default).
>
> Similar argument: adding values to a member is compatible as long as the
> type occurs only in command arguments.  But MigrationParameters is a
> command return type.  Adding value null is won't be kosher.  However, as
> long as as the value is never actually used there, QMP won't actually
> change, except for introspection.
>
> If this was a clean and obvious interface, I'd argue against such
> trickery and for keeping it clean and obvious.  But the migration
> configuration interface isn't.

