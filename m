Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73E6C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXh2k-0005oz-1v; Fri, 04 Jul 2025 10:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uXh1x-0005Wz-Pt
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:04:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uXh1r-0000zP-NC
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751637878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BTyloFVuCr2WHoTM7XykG7Q7rvoItBD3yu1YB1eAH0g=;
 b=Bt6J5VIlOum3Xz0hatf7YmmaiH+tKHWwJEjUJkkESupy2ujC55MIsDnXhBaX2DGJZajntR
 UQbRoCJHbSZ9NNzWO4upPvvoecR6iR5LbrD6ZJABUHYt8pbumwFeowy8YJY7E8Z4KyL+C6
 L9yfOTxWuKg9ISB6eLsK5usVEZ/6vZU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-qD8cPdcFP6uSHS3rcpAHJg-1; Fri,
 04 Jul 2025 10:04:37 -0400
X-MC-Unique: qD8cPdcFP6uSHS3rcpAHJg-1
X-Mimecast-MFC-AGG-ID: qD8cPdcFP6uSHS3rcpAHJg_1751637876
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F09351956061; Fri,  4 Jul 2025 14:04:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A18871956087; Fri,  4 Jul 2025 14:04:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CA47921E6A27; Fri, 04 Jul 2025 16:04:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  Peter Xu
 <peterx@redhat.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 16/24] migration: Add capabilities into
 MigrationParameters
In-Reply-To: <87h5zs3xng.fsf@suse.de> (Fabiano Rosas's message of "Fri, 04 Jul
 2025 10:15:15 -0300")
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-17-farosas@suse.de>
 <87jz4sz5b6.fsf@pond.sub.org> <87h5zs3xng.fsf@suse.de>
Date: Fri, 04 Jul 2025 16:04:32 +0200
Message-ID: <8734bckq6n.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
>>> Add capabilities to MigrationParameters. This structure will hold all
>>> migration options. Capabilities will go away in the next patch.
>>>
>>> Also add capabilities to MigrationParameter as the enum needs to be
>>> kept in sync with MigrationParameters. This affects the parsing of
>>> migration HMP commands so make the necessary additions there too.
>>>
>>> From this point on, both QMP and HMP versions of
>>> migrate-set-parameters and query-migrate-parameters gain the ability
>>> to work with capabilities.
>>>
>>> With MigrationParameters now having members for each capability, the
>>> migration capabilities commands (query-migrate-capabilities,
>>> migrate-set-capabilities) will soon be deprecated. Add a set of
>>> helpers to convert between the old MigrationCapability representation
>>> and the new representation as members of MigrationParameters.
>>>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>
>> [...]
>>
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index 40e00fb86e..3d3f5624c5 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -763,7 +763,14 @@
>>>             'vcpu-dirty-limit',
>>>             'mode',
>>>             'zero-page-detection',
>>> -           'direct-io'] }
>>> +           'direct-io', 'xbzrle', 'rdma-pin-all', 'auto-converge',
>>> +           'zero-blocks', 'events', 'postcopy-ram', 'x-colo',
>>> +           'release-ram', 'return-path', 'pause-before-switchover',
>>> +           'multifd', 'dirty-bitmaps', 'postcopy-blocktime',
>>> +           'late-block-activate', 'x-ignore-shared',
>>> +           'validate-uuid', 'background-snapshot',
>>> +           'zero-copy-send', 'postcopy-preempt',
>>> +           'switchover-ack', 'dirty-limit', 'mapped-ram' ] }
>>
>> This is MigrateParameter.  Different order than in MigrationParameters.
>> Intentional?
>>
>
> I think you mean the pre-existing difference in the order of the
> compression options multifd-*-level? I'll fix that.

I noticed the new members are in a different order than in
MigrationParameters.  I didn't notice the existing members differ, too.

> If it's something else, it eludes my gaze.

No.

Thanks!


