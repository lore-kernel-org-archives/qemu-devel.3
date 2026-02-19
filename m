Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B864CE9A053
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 18:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt8Tw-0004iT-RB; Thu, 19 Feb 2026 13:10:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vt8Tu-0004iD-1D
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 13:10:30 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vt8Tr-0002Zd-Nl
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 13:10:28 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1e1e:0:640:c6a6:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 852D1806F1;
 Thu, 19 Feb 2026 21:10:24 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:192::1:26] (unknown
 [2a02:6bf:8080:192::1:26])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id MAgBxv3AqGk0-MObUFAia; Thu, 19 Feb 2026 21:10:24 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771524624;
 bh=cJWO8xMqIdSB6hbvrb61crAI2eMikGynS12rQYRYegU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=a/nDbgRW522boarvlpXuNCmG1RRuQBWIcdA8m05iM5JeXsZADspeDinD95jV+rO2u
 FePSwkZshsUPsFoq4gjyGTgyW/swJVpaOV+bFBv0QSBiNfAQFT2eJ+MCE2AnEGHc5u
 d1/Z994bl260ahab1mWU/kEXrCX5Qwk1TbVnQUQI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <22e274b0-564c-476b-8b8e-b0f6b634fa99@yandex-team.ru>
Date: Thu, 19 Feb 2026 21:10:22 +0300
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
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <881F7D8C-E65F-4629-8AE4-68CA9BFCEFB4@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 19.02.26 20:00, Chaney, Ben wrote:
> 
> ﻿On 2/18/26, 3:29 PM, "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru <mailto:vsementsov@yandex-team.ru>> wrote:
> 
>> + queues = tap_parse_fds_and_queues(tap, &fds, errp);
>> + if (queues < 0) {
>> + return -1;
>> + }
>> +
> 
> Are we appropriately validating that queues != 0?
> I believe we need to throw an error in that case.
> 


Agree. I'll add the check into tap_parse_fds_and_queues().


-- 
Best regards,
Vladimir

