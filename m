Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90228C44516
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 18:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkQvZ-0005pm-Cg; Thu, 16 Jul 2026 14:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wkQv6-0005kB-QI
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:34:59 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wkQv2-0005lF-4n
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:34:51 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id E5BE680679;
 Thu, 16 Jul 2026 21:34:37 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d6a::1:11] (unknown
 [2a02:6bf:8080:d6a::1:11])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id aYWxn21avOs0-XvuKa6VU; Thu, 16 Jul 2026 21:34:37 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1784226877;
 bh=wArgjRuih7xon3nVnIxAW68zvGJyS+Mqg1oMEu2BNmQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=mDwf1FSz2tuAu94mPTLBmoc19Eq3iklTdAKnQ28kUANwum+j/isCz0fNLP6g1S8EX
 Fr9akJIU5ALt3W3IwKabF1GREIGx9ljukbZfh1YR9FAtV8jTU5qXT9qXAvEdxoQ56U
 m/X56DiQgdw8WjE4/X6ahi1ZgNfxNBakoNMlfKqQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <9dba5934-ffd3-429e-a644-25f14bedac7f@yandex-team.ru>
Date: Thu, 16 Jul 2026 21:34:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 00/15] virtio-net: live-TAP local migration
To: "Chaney, Ben" <bchaney@akamai.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>
Cc: "armbru@redhat.com" <armbru@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "farosas@suse.de"
 <farosas@suse.de>, "raphael.s.norwitz@gmail.com"
 <raphael.s.norwitz@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "berrange@redhat.com" <berrange@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "mark.caveayland@nutanix.com" <mark.caveayland@nutanix.com>
References: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
 <92090252-442B-4F9F-A56C-0E8785A8A4CE@akamai.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <92090252-442B-4F9F-A56C-0E8785A8A4CE@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

On 15.07.26 17:46, Chaney, Ben wrote:
> 
> ﻿On 7/14/26, 11:43 AM, "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru <mailto:vsementsov@yandex-team.ru>> wrote:
> 
> 
>> Hi all!
>>
>>
>> Here is a migration for TAP net backend, including its properties and
>> open fds.
> 
> Reviewed-by: Ben Chaney <bchaney@akamai.com>
> 
> I've gone through this patch set again. I had a few minor questions that I'll send inline, but overall LGTM!
> 
> Thanks,
>          Ben
> 

Thanks!

-- 
Best regards,
Vladimir

