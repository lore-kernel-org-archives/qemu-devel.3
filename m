Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5571CC48260
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 06:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbxFv-0000UW-Vh; Mon, 19 Feb 2024 01:36:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rbxFv-0000UH-2N
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 01:35:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rbxFt-0007l7-I0
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 01:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708324555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=86Ps+IrFEEPum6oMmpBlA2iy8WCmzfxjUHrHcwcqhA0=;
 b=OD3RLgqlDV9DIhInakzwHbUKcituDxibCFJ6AE5gWowcrG2PJLNEm/GNOdCjo2xTo73PuF
 xVZcxQw6kd5BnQQm2jveB0gvpEKYWA3GKN6YOMSvMFwbWzdqy6CNg7BvsvE5d812ZSM5di
 22/m3xfQIqCUJeTSfxmJ5ILefsdiu1s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-ChS5dLUMNeqp9_ZOjSpMKA-1; Mon,
 19 Feb 2024 01:35:50 -0500
X-MC-Unique: ChS5dLUMNeqp9_ZOjSpMKA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CA863C13A89;
 Mon, 19 Feb 2024 06:35:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A31871121312;
 Mon, 19 Feb 2024 06:35:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 745DC21E6740; Mon, 19 Feb 2024 07:35:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Roman Khapov <rkhapov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  farosas@suse.de,
 eblake@redhat.com,  yc-core@yandex-team.ru
Subject: Re: [PATCH v2 1/2] qapi/migration.json: add reason to MIGRATION event
In-Reply-To: <d1f73aaa-f5cb-4366-a567-fad7d965b76e@yandex-team.ru> (Roman
 Khapov's message of "Sun, 18 Feb 2024 19:32:38 +0500")
References: <20240215122759.1438581-1-rkhapov@yandex-team.ru>
 <20240215122759.1438581-2-rkhapov@yandex-team.ru>
 <87il2p0w78.fsf@pond.sub.org>
 <d1f73aaa-f5cb-4366-a567-fad7d965b76e@yandex-team.ru>
Date: Mon, 19 Feb 2024 07:35:47 +0100
Message-ID: <87le7hrmf0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Roman Khapov <rkhapov@yandex-team.ru> writes:

> To be clear: you meant that the description of the event must be extended, similar to its description on the commit message? Or you don't see its proper usage at all?

The commit message doesn't really tell me either why and how anybody
would use @reason.  Once we have a common understanding there, improving
the doc comment should be straightforward.

> If the first is true, then I agree, the description can be improved, and it will be useful, thanks! Will add it in the next version of the patch soon.
>
> On 2/16/24 11:17, Markus Armbruster wrote:
>> Roman Khapov <rkhapov@yandex-team.ru> writes:
>>
>>> This commit adds the optional field reason for the events, which
>>> contains the string, describing reason of status changing.
>>> For example: reason of migration fail.
>>>
>>> Function migrate_set_state now accepts 4th argument: the reason to
>>> pass to event. Every call of this function appended with NULL argument.
>>>
>>> Also migrate_set_state_err_reason was added to form reason from Error*
>>>
>>> Signed-off-by: Roman Khapov <rkhapov@yandex-team.ru>
>>
>> [...]
>>
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index 5a565d9b8d..33bb5b7f50 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -1392,6 +1392,7 @@
>>>  # Emitted when a migration event happens
>>>  #
>>>  # @status: @MigrationStatus describing the current migration status.
>>> +# @reason: Optional description of status changing reason.
>>
>> Intended use?
>>
>> When is it present?
>>
>>>  #
>>>  # Since: 2.4
>>>  #
>>> @@ -1402,7 +1403,7 @@
>>>  #     "data": {"status": "completed"} }
>>>  ##
>>>  { 'event': 'MIGRATION',
>>> -  'data': {'status': 'MigrationStatus'}}
>>> +  'data': {'status': 'MigrationStatus', '*reason': 'str'}}
>>>  ##
>>>  # @MIGRATION_PASS:


