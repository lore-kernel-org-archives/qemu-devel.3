Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15A2E83EED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnYAl-0005ks-Gd; Wed, 04 Feb 2026 03:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vnYAh-0005O1-Cs
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 03:23:37 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vnYAd-0003uC-CC
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 03:23:33 -0500
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id D2BD180778;
 Wed, 04 Feb 2026 11:23:25 +0300 (MSK)
Received: from [10.211.40.96] (10.211.40.96-vpn.dhcp.yndx.net [10.211.40.96])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id ONkrKk0AD0U0-Wcbh5KMI; 
 Wed, 04 Feb 2026 11:23:25 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770193405;
 bh=tMtEw+diE4AiFk9TLBdICSiUGPfUnO5+edClgwu3CvM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=hbvGNehp2CxbkZwUJ/FvLfFRF8zsdwdnGVRvgmhbmLn7z8Y0AHCD1NXuH8x+9lPru
 Oz5dFOdD8kArrNLQaAwiw4S+ghsh2l7E/B5s33/TQBtWgLCpKxqmqY5LcGEXUHOqzn
 e+WELxrJQKWQkeZo4C1acmeL2voxoMV5YbpssPMk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <7891a7f8-70ac-4558-b70a-36d767d3144c@yandex-team.ru>
Date: Wed, 4 Feb 2026 11:23:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/12] net/tap: fix vhostfds/vhostfd parameters API
To: "Chaney, Ben" <bchaney@akamai.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "d-tatianin@yandex-team.ru" <d-tatianin@yandex-team.ru>,
 "davydov-max@yandex-team.ru" <davydov-max@yandex-team.ru>
References: <20260129213215.1405459-1-vsementsov@yandex-team.ru>
 <20260129213215.1405459-11-vsementsov@yandex-team.ru>
 <5C6782F5-D8EF-4725-B5CF-843E4E49FC69@akamai.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <5C6782F5-D8EF-4725-B5CF-843E4E49FC69@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 03.02.26 22:40, Chaney, Ben wrote:
> 
>> There is a bug in the interface: we don't allow vhostfds argument
>> together with queues. But we allow vhostfd, and try use it for all
>> queues of multiqueue TAP.
> 
> 
>> Let's relax the restriction. We already check that number of vhost fds
>> match queues (or number of fds). So, no matter do vhost fds come from
>> vhostfds or vhostfd argument. Let's use correct vhost fds for multiqueue
>> TAP.
> 
> 
>> To achieve this we move vhost fds parsing to separate function and call
>> it earlier in net_init_tap(). Then we have vhost fds available (and
>> already checked) for all further cases.
> 
> I like the idea behind this change, but given that it modifies the API slightly,
> can you include and update to the documentation that clarifies which
> options are allowed to coexist and in what context?
> 

Hmm, current documentation lack this information at all, so I don't think
it's a problem of this patch.

Better, I'll add more documentation in separate commit on top (or as part) of
"[PATCH] qapi/net: deprecate TAP fd and vhostfd options".

Thanks for reviewing!

-- 
Best regards,
Vladimir

