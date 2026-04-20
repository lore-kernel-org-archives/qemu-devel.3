Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF3BF5A8AA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 19:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEuUI-0003Ta-Iy; Mon, 20 Apr 2026 15:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wEuUD-0003R0-AU
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 15:40:50 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wEuUB-00051h-Mv
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 15:40:49 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 842DC80741;
 Mon, 20 Apr 2026 22:40:44 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:54b::1:34] (unknown
 [2a02:6bf:8080:54b::1:34])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id geXCb10M1Gk0-2il1xiuo; Mon, 20 Apr 2026 22:40:44 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1776714044;
 bh=MSmK8daMDtT05U7l5fVw8rB1R0y+X9mNmlK7zo1fphc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=tZMN5aE2UG1E8IrwdQP6yaGGs/g7gQU3lBfD9yN5cS1CCQI3cxnRooWfxDOefzyJM
 HLltLc4U0R25zpgnNgD8BCaLcuERtrKum74rvxzDSuFrFcFgBV0KMWWKSeFjOlXGht
 DTulmG9G8Iv28k5SPExdiORwOVOF6MOAhEqaKwRU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <cb6e40f2-621f-4622-bcb9-0ad64b48abb8@yandex-team.ru>
Date: Mon, 20 Apr 2026 22:40:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/13] net: refactoring and fixes
To: "Chaney, Ben" <bchaney@akamai.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "d-tatianin@yandex-team.ru" <d-tatianin@yandex-team.ru>,
 "davydov-max@yandex-team.ru" <davydov-max@yandex-team.ru>
References: <20260318113144.15697-1-vsementsov@yandex-team.ru>
 <4515898a-2374-4bf0-b8d3-d6fcf488bb32@yandex-team.ru>
 <4B5C621F-E32C-420F-BCEC-DD9921D1720C@akamai.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <4B5C621F-E32C-420F-BCEC-DD9921D1720C@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20.04.26 19:35, Chaney, Ben wrote:
> 
> 
> ﻿On 4/20/26, 11:47 AM, "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru <mailto:vsementsov@yandex-team.ru>> wrote:
> 
>> ping :)
> 
> I've rereviewed this, and it looks good to me. My reviewed by tag is already applied :)
> 

Thanks!

-- 
Best regards,
Vladimir

