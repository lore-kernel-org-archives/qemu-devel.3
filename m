Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D313F47CBF
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 19:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyER2-0001lO-Ig; Thu, 05 Mar 2026 14:32:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vyER0-0001lE-Pe
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 14:32:34 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vyEQy-0000ml-Mh
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 14:32:34 -0500
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id D9739C015F;
 Thu, 05 Mar 2026 22:32:27 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b93::1:1] (unknown [2a02:6bf:8080:b93::1:1])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id QWvTGN0Am8c0-YBG5PGBB; Thu, 05 Mar 2026 22:32:27 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772739147;
 bh=0y1IWc1aMTFpN+HfB2qoF73wTDsynkzLpevmLXGbTyQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=D6cPLKpAmyESTcQN+I3C1akanoyC2wK9pwaB4IzZofa+nRyBar3ngQhq6u9RgYwMV
 n2Zj4hAuPryl/tK7grKKxnx2L9GO36Hbf5OC1fiFvZNt22u3JlmC9w92zVrSe6MpSN
 AjJ5HxE1dhtanE/irGJieo15PQfH4ouAna+yO2oc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d6b29837-6eea-49c3-b130-a519f9778c58@yandex-team.ru>
Date: Thu, 5 Mar 2026 22:32:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/12] net/tap: move fds parameters handling to
 separate functions
To: "Chaney, Ben" <bchaney@akamai.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "d-tatianin@yandex-team.ru" <d-tatianin@yandex-team.ru>,
 "davydov-max@yandex-team.ru" <davydov-max@yandex-team.ru>
References: <20260218202829.1322088-1-vsementsov@yandex-team.ru>
 <20260218202829.1322088-10-vsementsov@yandex-team.ru>
 <881F7D8C-E65F-4629-8AE4-68CA9BFCEFB4@akamai.com>
 <22e274b0-564c-476b-8b8e-b0f6b634fa99@yandex-team.ru>
 <B4B91407-B42B-4496-8FCD-8AA08B3FC24B@akamai.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <B4B91407-B42B-4496-8FCD-8AA08B3FC24B@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 19.02.26 21:27, Chaney, Ben wrote:
> 
> 
> ﻿On 2/19/26, 1:10 PM, "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru <mailto:vsementsov@yandex-team.ru>> wrote:
> 
>> On 19.02.26 20:00, Chaney, Ben wrote:
>>>
>>> On 2/18/26, 3:29 PM, "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru <mailto:vsementsov@yandex-team.ru> <mailto:vsementsov@yandex-team.ru <mailto:vsementsov@yandex-team.ru>>> wrote:
>>>
>>>> + queues = tap_parse_fds_and_queues(tap, &fds, errp);
>>>> + if (queues < 0) {
>>>> + return -1;
>>>> + }
>>>> +
>>>
>>> Are we appropriately validating that queues != 0?
>>> I believe we need to throw an error in that case.
>>>
>> Agree. I'll add the check into tap_parse_fds_and_queues().
> 
> That sounds good. You may need a similar check in net_parse_fds to
> throw an error on an empty fd list, which would result queues = 0
> through a different mechanism.
> 
> Thanks,
>          Ben
> 

I think, I'll just add a patch on top of the series for this.

-- 
Best regards,
Vladimir

