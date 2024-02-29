Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79D9C54E4A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 05:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfYyI-0001DX-3r; Thu, 29 Feb 2024 00:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfYyB-00013d-7c
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 00:28:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfYxw-0006Yg-Uv
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 00:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709184500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6BsJTeKYAgTG5YJRviqaQkXudr6cDh7tYbvRff2A2HM=;
 b=f/9DeZDNYpadrh/4No3NDLRvr7YuRigpeCHCAzE8U8Vq+BzDw0btJLBuy6EfYMGsWcUEom
 FOONk5tY4ha2M+Eynr4fx3otboPhisHJXf5wC68uIqp59ofx+bvIqEpYkYbYpMvP5FPAa4
 aoTAftDkurUwMxHoxMK5crDANHz0Ask=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-09jp2BbOMuya64jSm885hA-1; Thu,
 29 Feb 2024 00:28:15 -0500
X-MC-Unique: 09jp2BbOMuya64jSm885hA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8147329AA381;
 Thu, 29 Feb 2024 05:28:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DAFF28173;
 Thu, 29 Feb 2024 05:28:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B0CE121E66D0; Thu, 29 Feb 2024 06:28:12 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Kevin Wolf <kwolf@redhat.com>,  Fiona Ebner <f.ebner@proxmox.com>,
 qemu-devel@nongnu.org,  qemu-block@nongnu.org,  eblake@redhat.com,
 hreitz@redhat.com,  jsnow@redhat.com,  den@virtuozzo.com,
 t.lamprecht@proxmox.com,  alexander.ivanov@virtuozzo.com
Subject: Re: [PATCH v2 00/10] mirror: allow switching from background to
 active mode
In-Reply-To: <1310efb0-e211-46f5-b166-d7d529507a43@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 28 Feb 2024 21:07:02 +0300")
References: <20231009094619.469668-1-f.ebner@proxmox.com>
 <a5c48627-0bef-46cd-9426-587b358fe32d@yandex-team.ru>
 <993bfa5d-1a91-4b32-9bd8-165b7abba4f0@proxmox.com>
 <99dd287b-816b-4f4f-b156-32f94bbb62c2@yandex-team.ru>
 <87o7gbyy8w.fsf@pond.sub.org> <ZUTffE0wfjLH2u+e@redhat.com>
 <87cywqn84g.fsf@pond.sub.org>
 <1310efb0-e211-46f5-b166-d7d529507a43@yandex-team.ru>
Date: Thu, 29 Feb 2024 06:28:12 +0100
Message-ID: <87msrju9eb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

> On 03.11.23 18:56, Markus Armbruster wrote:
>> Is the job abstraction a failure?
>>
>> We have
>>
>>      block-job- command      since   job- command    since
>>      -----------------------------------------------------
>>      block-job-set-speed     1.1
>>      block-job-cancel        1.1     job-cancel      3.0
>>      block-job-pause         1.3     job-pause       3.0
>>      block-job-resume        1.3     job-resume      3.0
>>      block-job-complete      1.3     job-complete    3.0
>>      block-job-dismiss       2.12    job-dismiss     3.0
>>      block-job-finalize      2.12    job-finalize    3.0
>>      block-job-change        8.2
>>      query-block-jobs        1.1     query-jobs
>>
>> I was under the impression that we added the (more general) job-
>> commands to replace the (less general) block-job commands, and we're
>> keeping the latter just for compatibility.  Am I mistaken?
>>
>> Which one should be used?
>>
>> Why not deprecate the one that shouldn't be used?
>>
>> The addition of block-job-change without even trying to do job-change
>> makes me wonder: have we given up on the job- interface?
>>
>> I'm okay with giving up on failures.  All I want is clarity.  Right now,
>> I feel thoroughly confused about the status block-jobs and jobs, and how
>> they're related.
>
> Hi! I didn't notice, that the series was finally merged.
>
> About the APIs, I think, of course we should deprecate block-job-* API, because we already have jobs which are not block-jobs, so we can't deprecate job-* API.
>
> So I suggest a plan:
>
> 1. Add job-change command simply in block-core.json, as a simple copy of block-job-change, to not care with resolving inclusion loops. (ha we could simply name our block-job-change to be job-change and place it in block-core.json, but now is too late)
>
> 2. Support changing speed in a new job-chage command. (or both in block-job-change and job-change, keeping them equal)
>
> 3. Deprecate block-job-* APIs
>
> 4. Wait 3 releases
>
> 5. Drop block-job-* APIs
>
> 6. Move all job-related stuff to job.json, drop `{ 'include': 'job.json' }` from block-core.json, and instead include block-core.json into job.json

Sounds good to me.

> If it's OK, I can go through the steps.

Lovely!


