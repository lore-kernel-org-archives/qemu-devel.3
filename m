Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA44D3C920
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 15:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTMCC-0004dE-7g; Wed, 10 Dec 2025 10:33:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vTMCA-0004cc-GN
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 10:33:38 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vTMC6-00067R-U0
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 10:33:38 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id BAC7680863;
 Wed, 10 Dec 2025 18:33:30 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:887::1:d] (unknown [2a02:6bf:8080:887::1:d])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id TXQJlZ0FV0U0-mxbXl07n; Wed, 10 Dec 2025 18:33:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1765380810;
 bh=vZH5i64bE4PMTS0OPbWp/aXV5iRP8RFINrr7ZJOIYDs=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=BpAOjONPEHZHEE4MIEU9ANGoVDt0uM9pt0MRNWFE21b5+3VwAubh5ho/+8KOAMS+o
 KAzbEgwovMRa7/f1DG9xKHMmTxZ4eWtvPnJpD7sosLaxLftBYDl+PVGVAOkpvQZV0x
 dcwVOUiNBZcnCzznSnsUQl2n4Ilpt207I0u3FsKg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <5fbc6906-0116-4fbc-bcdd-1bb63b3e6f05@yandex-team.ru>
Date: Wed, 10 Dec 2025 18:33:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] vhost-user-blk: support inflight migration
To: Peter Xu <peterx@redhat.com>
Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org,
 Raphael Norwitz <raphael@enfabrica.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20251110103937.1944486-1-dtalexundeer@yandex-team.ru>
 <cf0f69b9-4b2b-4c09-a32b-ad86bbe04f6d@yandex-team.ru>
 <aRztnfZFl-OcbVYI@x1.local>
 <d986f0ac-a0ae-44f6-b7a5-e002b7d3226e@yandex-team.ru>
 <aThTdgwsNexV9KAp@x1.local>
 <a8bff5ea-e1c3-4d4c-9ef7-93fa530bff0d@yandex-team.ru>
 <aTmP28XK0X1rvJRv@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aTmP28XK0X1rvJRv@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10.12.25 18:20, Peter Xu wrote:
> On Wed, Dec 10, 2025 at 02:41:20PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Yes, it can. And regardless of the way we chose: qdev properties or qapi,
>> I don't think we need a property for backend itself. We need a property
>> (or migration capability) for vhost-user-blk itself, saying that its
>> backend should be migrated.
> 
> The problem is then we need to introduce the new property to all frontends
> that would support the backend?  If it's a backend property, it can be one
> property for the backend that all the frontends can consume.
> 

Hmm, agree, that's right.. So, we may not touch frontend at all, and only
setup backend to be migrated. And this remains transparent for frontend side.

>>
>> It's a lot simpler to migrate backend inside of frontend state. If we
>> migrate backend in separate, we can't control the order of backend/frontend
>> stats, and will have to implement some late point in state load process,
>> where both are already loaded and we can do our post-load logic.
> 
> Would MigrationPriority help when defining the VMSD?
> 

Didn't know about it. Most probably it may help, we just setup so that backends
migrate before frontends.


-- 
Best regards,
Vladimir

