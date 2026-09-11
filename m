Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4000C88E42
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 06:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4v1s-0003CN-PQ; Fri, 11 Sep 2026 02:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4v1q-0003Bt-JG
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 02:46:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4v1n-0001m4-MM
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 02:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789109186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mT3vkVDVgEyCK9MhA68BUyPNTF02jnwVJFHJgGOuE3k=;
 b=RHsqEEi8OSfWl+87OKW5hXIqAwDJ9Q6G5tL/wXZy21oWyO+GV6BItOb9lyERk7/x554kQX
 E6JReK/SzWJUapgGXaBmpg7EgoBB4TSpxWtRtHnNYv/LZV5O4h4UQZ/q4DstiUQ3/lxFBY
 ipDGCCXeR3k9oyiKvYyTg+U1n5jJUHM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-md5t_x5jP-ablrnGmQ0zKA-1; Fri,
 11 Sep 2026 02:46:24 -0400
X-MC-Unique: md5t_x5jP-ablrnGmQ0zKA-1
X-Mimecast-MFC-AGG-ID: md5t_x5jP-ablrnGmQ0zKA_1789109183
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A6E41956089; Fri, 11 Sep 2026 06:46:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E5EF3000229; Fri, 11 Sep 2026 06:46:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C418E21E6A04; Fri, 11 Sep 2026 08:46:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  "Dr . David Alan
 Gilbert" <dave@treblig.org>,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 12/18] migration: Change HMP 'info
 migrate_parameters' output
In-Reply-To: <87wlsttg2q.fsf@suse.de> (Fabiano Rosas's message of "Thu, 10 Sep
 2026 10:02:21 -0300")
References: <20260909214509.237309-1-farosas@suse.de>
 <20260909214509.237309-13-farosas@suse.de>
 <87v78dftni.fsf@pond.sub.org> <87wlsttg2q.fsf@suse.de>
Date: Fri, 11 Sep 2026 08:46:19 +0200
Message-ID: <87cxukb804.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
>>> The output of 'info migrate_parameters' includes units of measurement
>>> for a few parameters. This is convenient for a user.
>>
>> Yes.
>>
>>>                                                      It also requires
>>> every parameter to be individually listed in the
>>> hmp_migrate_set_parameter() function, which in turn requires the
>>> MigrationParameter (singular) enum to exist.
>>
>> I think I understand what you mean, but your text doesn't express it
>> clearly.
>>
>> How does having in "info migrate" imply the need for parameter-specific
>> code in "migrate_set_parameter"?  Perhaps with the (unstated)
>> requirement that "migrate_set_parameter" must take values in the units
>> shown by "info migrate_parameters"?
>>
>> Let me try to explain the why differently.
>>
>> hmp_info_migrate_parameters() and hmp_migrate_set_parameter() both have
>> code for each parameter, and they both use enum MigrationParameter.
>>
>> You want to replace this parameter-specific code by code that works for
>> any parameter, in both functions.
>>
>> Your new code really doesn't want to do special per-parameter stuff.
>> That's why you want to get rid of all that.
>>
>
> Right, you got the point, it's that having the units requires custom
> formatting which needs to be per-parameter and therefore requires the
> parameters to be enumerated in the code which increases the maintenance
> burden. I'll update the commit message with something more clear.
>
>> You split the work as follows:
>>
>> * Get rid of special units in migrate_set_parameter [previous patch].
>>   Interface change, simple patch.
>>
>
> This one is separate because it affects how the user _sets_ those
> values, while the rest of the changes only affects how the user _sees_
> the values.
>
>> * Don't show units in info migrate_parameters [this patch].
>>   Interface change, simple patch.
>>
>> * Replace parameter-specific code [next patches].  More interesting, but
>>   no interface change.
>>
>> I like this split, it helps reviewers.
>>
>>>                                              While the latter is not
>>> bothersome at all, the former is.
>>
>> The values of enum MigrationParameter duplicate the members of struct
>> MigrationParameters.  That's plenty bothersome, isn't it?
>>
>
> As Peter pointed out in v1, this is now less bothersome than it used to
> be, since we stopped requiring documentation for MigrationParameter in
> commit 2220c2b9ef (qapi/migration: Don't document MigrationParameter,
> 2025-12-15).

"Less bothersome than it was" I can buy, "not at all bothersome" I
won't.

>> As far as I can tell, the only remaining uses of enum MigrationParameter
>> at the end of the series are an assertion in
>> migrate_mark_all_params_present(), which we discussed in review of v1,
>> and hmp_completion_single() in qtest/migration/misc-tests.c.  Any chance
>> we can get rid of it entirely?
>>
>
> We need something that ensures migrate_mark_all_params_present() will be
> updated when a new parameter is added. My attempt in v1 of converting to
> MigrationParameters to QDict didn't work because the has_ fields are not
> carried over to the QDict. At the moment, the best I can do is to use
> the enum.

Avoids "must keep has_fields[] in migrate_mark_all_params_present()
consistent with MigrationParameters" by "must keep MigrationParameter
consistent with MigrationParameters".  Not quite moving around the deck
chairs, because the latter is within the same file, but close.

Here's an idea for a clean solution: have a special input visitor with a
visit_optional() that always says yes.  This sets all the has_FOO.
Whether this can be made to work and is less of a maintenance burden
than MigrationParameter is left as an exercise to the reader :)

> As for the test, we could simply not test the completion of
> parameters. It's not the end of the world, QEMU's implementation of
> readline is already wonky.
>
> There might be other situations in the future where we'd like to have a
> mapping of parameter to user-friendly parameter name, in which case I
> fear we'd probably just reintroduce the enum.

It was a mistake the first time, and it will likely be a mistake the
second time.

>>> From a development and maintenance perspective, having a list of
>>> parameters explicitly written in several parts of the code brings
>>> several annoyances: conflicts during rebase, multiple extra hits when
>>> grepping, requires contributors to search for every location a change
>>> needs to be mirrored to, etc.
>>>
>>> Remove the units from the output so we can write this code in a more
>>> convenient way. The HMP output is not part of any ABI.
>>>
>>> Also remove quotes from around the TLS options strings as this is
>>> inconsistent with all the other strings.
>>>
>>> Change block-bitmap-mapping format to a single line. This requires
>>> updating one of the iotests to match.
>>>
>>> Before:                                      After:
>>>                      (unchanged entries omitted)
>>> announce-initial: 50 ms                      announce-initial: 50
>>> announce-max: 550 ms                         announce-max: 550
>>> announce-rounds: 5                           announce-rounds: 5
>>> announce-step: 100 ms                        announce-step: 100
>>> tls-creds: ''                                tls-creds:
>>> tls-hostname: ''                             tls-hostname:
>>> tls-authz: ''                                tls-authz:
>>> max-bandwidth: 134217728 bytes/second        max-bandwidth: 134217728
>>> avail-switchover-bandwidth: 0 bytes/second   avail-switchover-bandwidth: 0
>>> max-postcopy-bandwidth: 0 bytes/second       max-postcopy-bandwidth: 0
>>> downtime-limit: 300 ms                       downtime-limit: 300
>>> x-checkpoint-delay: 20000 ms                 x-checkpoint-delay: 20000
>>> xbzrle-cache-size: 67108864 bytes            xbzrle-cache-size: 67108864
>>> x-vcpu-dirty-limit-period: 1000 ms           x-vcpu-dirty-limit-period: 1000
>>> vcpu-dirty-limit: 1 MB/s                     vcpu-dirty-limit: 1
>>> x-rdma-chunk-size: 1048576 bytes             x-rdma-chunk-size: 1048576
>>> block-bitmap-mapping:                        block-bitmap-mapping: bitmaps: name: bmap0 alias: bmap0 node-name: node-src alias: node-dst
>>>   'node-src' -> 'node-dst'
>>>     'bmap0' -> 'bmap0'
>>
>> Uh, the value of block-bitmap-mapping can become really long.  Its QAPI
>> type is array of BitmapMigrationNodeAlias, and each array element
>> contains another array.
>>
>> Why is this change useful?
>>
>
> Not so much useful as required, we can't have generic printing of QDict
> and QList if block-bitmap-mapping needs custom arrows and spacing.
>
> I can try to tweak hmp_migrate_print_qobject() in patch 14 to add some
> newlines where appropriate.

JSON pretty-printers can do this, and I'm confident you can do this,
too.

>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>


