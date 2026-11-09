Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB166606EEBF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ovhcloud.com header.i=@ovhcloud.com header.a=rsa-sha256 header.s=mailout header.b=Km83g6dC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQSBT-0004Iu-SU; Mon, 09 Nov 2026 11:25:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xQSBQ-0004HH-5E
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:25:25 -0500
Received: from 1.mo508.mail-out.ovh.net ([5.135.90.176])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xQSBJ-0007W6-PM
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:25:23 -0500
Received: from DAGFR11EX3.OVH.local (unknown [10.110.54.89])
 by mo508.mail-out.ovh.net (Postfix) with ESMTPS id 4jNZrW2Mmwz7tDW;
 Mon,  9 Nov 2026 16:25:15 +0000 (UTC)
Received: from [10.15.146.202] (109.190.254.61) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 17:25:14 +0100
Message-ID: <31a576fb-0676-481b-be52-7323ec0fece3@ovhcloud.com>
Date: Mon, 9 Nov 2026 17:25:01 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] nbd/client-connection: Fix client returning a
 closed channel
To: <eblake@redhat.com>
CC: <qemu-devel@nongnu.org>, <qemu-block@nongnu.org>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20261105164124.249395-1-guillaume.vincke@ovhcloud.com>
 <au4tsMuhKjq62dVB@redhat.com>
Content-Language: en-US
From: guillaume vincke <guillaume.vincke@ovhcloud.com>
In-Reply-To: <au4tsMuhKjq62dVB@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CAS4.OVH.local (172.16.1.4) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 17576141973114863911
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGm4PZSbEw62v9EKhtu3e1uIX0urpbAnNma/dWkNKppuNaLc77o31Wp307UrolIJ5O6ZUhNL4lkjsR8S9ZbmNmYVe0A0+gFUMgmIhnA3RkWkYJ8Vnkvv1lA5OWyAOMlVsLiko1KXOIF+WDV3vx1mCDXEvvqEHimmXcXjHRJeMODxt0dX6Teg485owxw73UNbU3jXqIXJaGqo9IDBPRzkNVJ/pSMH48TRVqzFvXHk5ExCe77ZBS32tNOe55Fh7FETv8sMZTTZSyUrpfjkMBgwV0y2gCb04PJLV+whij5XtEOl4sjpwoAbOfKYMRF4ibW5yKL2Vz2M53BCg1eyHsqFcjUBkJWm/TfJY/SQEc9Bv8Caz4RnI/35NMKZTtYNCbiIdJv17E18pgrm+hKVJ8WZCI1uqA2izebvZ1jkNBZB3FGX/qwPU5XcctByO0z0K+uQ1sKzLaZOTXsoGWYN1l48DzZwtABInBgNKy8WWOrKCIUeDQtEsIrRqOzkoPqmeuxgF9WWjFzdtYBRKROvcBj93+U4X0Gq6fqODC4mMmjyYenNq2eClizV3/hxV76A/NU6YeIt91PVevalRknTjNfhfOnRzELCZWi7YXkaqlZZkK1MZ19bsI1y5GNFXroShSbUZq3+ESldxju15XabK7QhcYrFuIrOWLtCwdzqpBXzsI9aw
DKIM-Signature: a=rsa-sha256; bh=KUwyu84sf5pSs7T3+WL8iMGFGj1n5R817nRF4q0MrDY=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1794241515; v=1; 
 b=Km83g6dCtysCNvv9wb/EwwTBNO9PFfYr0lyjL5xJVbNx09zk4QyIInYXK68xaQzNIry9ESjM
 4XqHxmT3BZ95TMNzrX5RCBVBL0z2X3dDZewYDRwCzmZkTWGLs3/NCXdtbq1l0woyE64mGAiK4Nj
 fSV34wysoXMobieEzoAO6zGs=
Received-SPF: pass client-ip=5.135.90.176;
 envelope-from=guillaume.vincke@ovhcloud.com; helo=1.mo508.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/26 20:45, Eric Blake wrote:
> On Thu, Nov 05, 2026 at 05:41:22PM +0100, Guillaume Vincke wrote:
>> NBD client relies on lazy reconnection on error. There is a case where
>> nbd_co_establish_connection() will hand back a channel disconnected by
>> its peer. This leads to the request running on the dead channel. When
>> reconnect-delay is set to 0 (the default), this bug prevents the
>> nbd-connect thread from running on the first operation. This patch set
>> addresses this specific case.
>>
> 
>>
>> v3 does not use a more robust method than sleeping to wait for the NBD
>> client to reach the desired state. An option would be to add a QMP
>> unstable debug query reporting the NBD client state and whether the
>> connect thread has a channel ready. The test would poll this instead of
>> sleeping. Would that be an acceptable follow-up?
> 
> I think an unstable query for current NBD server state (is the server
> up, and if so, which exports is it serving and what is the state of
> all client(s) attached to each server) would indeed make sense.  That
> will probably miss this release, but I still think this series is okay
> for now.  Queueing it up as a bug fix, for my upcoming pull request
> intended to make it into rc0.
> 

Thanks for the review and for queueing it. I sent a new patchset with
a QMP command at:
https://patchew.org/QEMU/20261109160609.1434289-1-guillaume.vincke@ovhcloud.com/
It does not access the server's internals but the client's, since the
test uses qemu-nbd that does not have QMP. Let me know if that still
fits your expectations.



