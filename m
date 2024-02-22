Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE18C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 07:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd35W-0001lk-9L; Thu, 22 Feb 2024 02:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rd35T-0001lA-So
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 02:01:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rd35R-0003zt-Ox
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 02:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708585299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D7UFLVkTU8v58zbjsw+Z8KDl1KvXQ3Np+KYOJuuJ5+c=;
 b=hxOa3zKrJvS+E9UfIjg2EfP/N36sqKjLpbbVrbrX7MlL/GHBOMX0MU13XtHnmj/uwWy55k
 qZnme05NNMPIlqGIP1yj0dgwgPoOQtqIr8Ni7AZDoZmdD2cLee4OM+zO/AEcFAq1QKpRWQ
 nUIlyLEZa2wtFjoV9dsh6BwiOoE7kwg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-3VZJHHIaNQCXIhfrkp9bCA-1; Thu, 22 Feb 2024 02:01:35 -0500
X-MC-Unique: 3VZJHHIaNQCXIhfrkp9bCA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 401BD800074;
 Thu, 22 Feb 2024 07:01:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E91D2022AAA;
 Thu, 22 Feb 2024 07:01:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 45AFC21E66D5; Thu, 22 Feb 2024 08:01:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Roman Khapov <rkhapov@yandex-team.ru>,  qemu-devel@nongnu.org,
 peterx@redhat.com,  eblake@redhat.com,  yc-core@yandex-team.ru
Subject: Re: [PATCH v2 0/2] Field 'reason' for MIGRATION event
In-Reply-To: <87jzmxc1ux.fsf@suse.de> (Fabiano Rosas's message of "Wed, 21 Feb
 2024 11:45:42 -0300")
References: <20240215122759.1438581-1-rkhapov@yandex-team.ru>
 <87jzmxc1ux.fsf@suse.de>
Date: Thu, 22 Feb 2024 08:01:33 +0100
Message-ID: <875xyhyoc2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fabiano Rosas <farosas@suse.de> writes:

> Roman Khapov <rkhapov@yandex-team.ru> writes:
>
> Hi Roman,
>
>> This is resending of series 20240215082659.1378342-1-rkhapov@yandex-team.ru,
>> where patch subjects numbers were broken in patch 2/2.
>>
>> Sometimes, when migration fails, it is hard to find out
>> the cause of the problems: you have to grep qemu logs.
>> At the same time, there is MIGRATION event, which looks like
>> suitable place to hold such error descriptions.
>
> query-migrate after the event is received should be enough for giving
> you the failure reason. We have that in error-desc. See commit
> c94143e587 ("migration: Display error in query-migrate irrelevant of
> status").
>
>>
>> To handle situation like this (maybe one day it will be useful
>> for other MIGRATION statuses to have additional 'reason' strings),
>
> I find it unlikely. There's no "reason" for making progress except
> that's how things work. Only the exceptional (i.e. failure) statuses
> would have a reason. Today that's FAILED only, maybe also
> POSTCOPY_PAUSED.

I can't see a need for the proposed feature then.

>> the general optional field 'reason' can be added.

[...]


