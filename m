Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6127CC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 07:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJSOq-0006xD-SA; Mon, 26 May 2025 03:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJSOl-0006wq-8A
 for qemu-devel@nongnu.org; Mon, 26 May 2025 03:37:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJSOf-0007VV-Q1
 for qemu-devel@nongnu.org; Mon, 26 May 2025 03:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748245039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KkA6+Nd4ZvZzE5Ua8P0slhwXy1/6ZcHBx+o2BvW8t3k=;
 b=i0ygS9uqkY4/wCKTnfvW8QD5jfah8Ez2VUxHt+MebsovkvfQvjzkhPnnZyRvhqPXeAuV0k
 XZ/UH+88kxLBhM37AdPzd42LcH8f46G4wnVLka36P5ScHWLDcwubF5a11aDI6Zlvx+aC84
 fIrugqYQQtR9VfZsmIDfve/YPlPxbBc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-gxe5H_wyM--lYB0Vh3TCLQ-1; Mon,
 26 May 2025 03:37:17 -0400
X-MC-Unique: gxe5H_wyM--lYB0Vh3TCLQ-1
X-Mimecast-MFC-AGG-ID: gxe5H_wyM--lYB0Vh3TCLQ_1748245036
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BB43195608D; Mon, 26 May 2025 07:37:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A16D519560AB; Mon, 26 May 2025 07:37:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DFE2621E675E; Mon, 26 May 2025 09:37:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 07/13] migration: Introduce new MigrationConfig
 structure
In-Reply-To: <87ldqn5twe.fsf@suse.de> (Fabiano Rosas's message of "Fri, 23 May
 2025 10:38:41 -0300")
References: <20250411191443.22565-1-farosas@suse.de>
 <20250411191443.22565-8-farosas@suse.de> <87jz7idk97.fsf@pond.sub.org>
 <87ldqn5twe.fsf@suse.de>
Date: Mon, 26 May 2025 09:37:12 +0200
Message-ID: <87cybvbz6f.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
> Markus, sorry for the delay here. I had vacations and holidays, plus a
> pile of patches to review.

No problem.  Hope you enjoyed your time off!

>> Fabiano Rosas <farosas@suse.de> writes:
>>
>>> Add a new migration structure to consolidate the capabilities and
>>> parameters. This structure will be used in place of the s->parameters
>>> and s->capabilities data structures in the next few patches.
>>>
>>> The QAPI migration types now look like this:
>>>
>>> /* options previously known as parameters */
>>
>> Configuration previously known as parameters less the TLS stuff.
>>
>>> { 'struct': 'MigrationConfigBase',
>>>   'data': {
>>>       <parameters>
>>> } }
>>>
>>>
>>> /* for compat with query-migrate-parameters */
>>> { 'struct': 'MigrationParameters',
>>>   'base': 'MigrationConfigBase',
>>>   'data': {
>>>       <TLS options in 'str' format>
>>> } }
>>>
>>> /* for compat with migrate-set-parameters */
>>> { 'struct': 'MigrateSetParameters',
>>>   'base': 'MigrationConfigBase',
>>>   'data': {
>>>       <TLS options in 'StrOrNull' format>
>>> } }
>>
>> Yes, this is the state since PATCH 05.
>>
>>> /* to replace MigrationParameters in the MigrationState */
>>> { 'struct': 'MigrationConfig',
>>>   'base': 'MigrationConfigBase'
>>>   'data': {
>>>     <TLS options in 'str' format>
>>> } }
>>
>> This is new in this patch.
>>
>> Your description doesn't cover optionalness.  Here's my understanding:
>>
>> * MigrationSetParameters has optional members, because
>>   migrate-set-parameters needs that.
>>
>
> Yes.
>
>> * MigrationParameters would ideally have these members non-optional,
>>   because query-migrate-parameters wants that.
>>
>
> Yes.
>
>> * But to enable sharing via common base type MigrationConfigBase, we
>>   accept unwanted optional in MigrationParameters and thus
>>   query-migrate-parameters.
>>
>
> Yes.
>
>> * This doesn't apply to the non-shared members of MigrationParameters,
>>   so you made them non-optional.  These are @tls-creds, @tls-hostname,
>>   @tls-authz.
>>
>
> Yes.
>
>> * But in MigrationConfig they're optional again, because "empty string
>>   means absent" is silly; we want "NULL means absent".
>>
>
> Yes. But mostly because MigrationConfig will become the type for the new
> '*config' argument to migrate/migrate_incoming (patches 12 & 13) and we
> want to keep all members optional. Otherwise the user would have to pass
> all ~50 migration options in every migrate command, which is bad IMO.

Got it.

>> Correct?
>>
>> Up to here, this enables cleanup of some "empty string means absent"
>> silliness in later patches.
>>
>> The remainder is about unifying capabilities into parameters.  I'd split
>> the patch (but I'm a compulsive patch splitter).
>>
>>> The above keeps the query/set-parameters commands stable. For the
>>> capabilities as well as the options added in the future, we have a
>>> choice of where to put them:
>>>
>>> 1) In MigrationConfigBase, this means that the existing
>>>    query/set-parameters commands will be updated to deal with
>>>    capabilities/new options.
>>>
>>>   { 'struct': 'MigrationConfigBase',
>>>     'data': {
>>>       <parameters>
>>>       <capabilities>
>>>       <new opts>
>>>   } }
>>>
>>>   { 'struct': 'MigrationConfig',
>>>     'base': 'MigrationConfigBase'
>>>     'data': {
>>>       <TLS options in 'str' format>
>>>   } }
>>>
>>> 2) In MigrationConfig, this means that the existing commands will be
>>>    frozen in time.
>>>
>>>   { 'struct': 'MigrationConfigBase',
>>>     'data': {
>>>       <parameters>
>>>   } }
>>>
>>>   { 'struct': 'MigrationConfig',
>>>     'base': 'MigrationConfigBase'
>>>     'data': {
>>>       <TLS options in 'str' format>
>>>       <capabilities>
>>>       <new opts>
>>>   } }
>>>
>>> For now, I've chosen the option 1, all capabilities and new options go
>>> into MigrationConfigBase. This gives the option to keep the existing
>>> commands for as long as we'd like.
>>
>> Perhaps this would be slightly easier to digest for the reader if you
>> talked just about capabilities at first.  Once that's understood,
>> mention we have the same choice for new configuration bits.
>>
>
> Ok, I'll reorganize, along with the other comments you've made.
>
>>> Note that the query/set capabilities commands will have to go, we can
>>> treat parameters as generic configuration options, but capabilities
>>> are just too different.
>>
>> I think the argument is that migration capabilities are a pointless
>> interface complication.  One mechanism (parameters) is better than two
>> (parameters and capabilities).
>>
>
> Yes, that's the main point indeed.

Perhaps you can make this point more prominently.

>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>

[...]


