Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667F2C52D6D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZsD9-0000B5-NS; Fri, 02 Aug 2024 09:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZsD3-0008C5-Gc
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:20:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZsD2-0002cb-15
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722604839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J3yAT5Q6kB4KNtAa6FnN2vZcx0lHGw7lxMm4xboIw9U=;
 b=Bng/pJse4kGwMRYxvdv9glSm2bQdV1WxQS2qFzswYvWa95R3XEu4WlXnqkbvCWiBhes0fi
 HAdTm9zmdaSZoroE4ZKW3/HwjsliWTgN+xWW+Ln+JCCSv8pyexOLh3In+vwWX6Dl/pE1o5
 sp2IJkm5zAAU/mDLaIQyuIdeGPqVIG8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-Kh-N5YKyPnWBoqDzHO4qOw-1; Fri,
 02 Aug 2024 09:20:35 -0400
X-MC-Unique: Kh-N5YKyPnWBoqDzHO4qOw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AC901955D57; Fri,  2 Aug 2024 13:20:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2E621955D42; Fri,  2 Aug 2024 13:20:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CE87E21E6682; Fri,  2 Aug 2024 15:20:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  eblake@redhat.com,
 devel@lists.libvirt.org,  hreitz@redhat.com,  kwolf@redhat.com,
 jsnow@redhat.com,  pkrempa@redhat.com,  f.ebner@proxmox.com
Subject: Re: [PATCH v2 6/7] qapi/block-core: derpecate block-job-change
In-Reply-To: <2ee88d14-98a0-4189-96fe-be737f915744@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 2 Aug 2024 14:10:49 +0300")
References: <20240626110124.374336-1-vsementsov@yandex-team.ru>
 <20240626110124.374336-7-vsementsov@yandex-team.ru>
 <87frs7x8tm.fsf@pond.sub.org>
 <2ee88d14-98a0-4189-96fe-be737f915744@yandex-team.ru>
Date: Fri, 02 Aug 2024 15:20:28 +0200
Message-ID: <87wmkz12oz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 18.07.24 14:01, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>> 
>>> That's a first step to move on newer job-* APIs.
>>>
>>> The difference between block-job-change and job-change is in
>>> find_block_job_locked() vs find_job_locked() functions. What's
>>> different?
>>>
>>> 1. find_block_job_locked() do check, is found job a block-job. This OK
>>
>> Do you mean something like find_block_job_locked() finds only block
>> jobs, whereas find_job_locked() finds any kind of job?
>
> Yes

Thanks!

>>>     when moving to more generic API, no needs to document this change.
>>>
>>> 2. find_block_job_locked() reports DeviceNotActive on failure, when
>>>    find_job_locked() reports GenericError. Still, for block-job-change
>>>    errors are not documented at all, so be silent in deprecated.txt as
>>>    well.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Suggest:

    1. find_block_job_locked() finds only block jobs, whereas
       find_job_locked() finds any kind of job.  job-change is a
       compatible extension of block-job-change.

    2. find_block_job_locked() reports DeviceNotActive on failure, when
       find_job_locked() reports GenericError.  Since the kind of error
       reported isn't documented for either command, and clients
       shouldn't rely on undocumented error details, job-change is a
       compatible replacement for block-job-change.


