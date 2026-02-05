Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9567E9128C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 08:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnuTX-00029W-75; Thu, 05 Feb 2026 03:12:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vnuTU-00029N-Ri
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 03:12:29 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vnuTS-0003TH-Hk
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 03:12:28 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id D01BA80796;
 Thu, 05 Feb 2026 11:12:21 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:52d::1:1f] (unknown
 [2a02:6bf:8080:52d::1:1f])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id IClBe10AxCg0-5sGzwCeZ; Thu, 05 Feb 2026 11:12:21 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770279141;
 bh=ayLJcCNXT916CW5ef8KlDmiuMXYa7d8RAYAww8q5NnY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=t+IqqQ/ti0szP8BUliSmEbmwidBaw+BqusHAEjwyvTl/JVLyYbL9pq5gsD6u6wwlg
 6MRXT6wfHslt0G62gvp9K6XM+AHtjSy3Shfz9chXHtaqBZWTd5GLwyPcarMAUyf1U3
 P8Ui9wn4SKOyc72grGDoj6rum3u7ahukgtysMgN8=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f9fdd3d2-97c3-42a2-b34d-8a22951091d1@yandex-team.ru>
Date: Thu, 5 Feb 2026 11:12:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 6/8] net/tap: support backend-transfer migration
To: "Chaney, Ben" <bchaney@akamai.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>, "armbru@redhat.com"
 <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "peterx@redhat.com"
 <peterx@redhat.com>, "zhao1.liu@intel.com" <zhao1.liu@intel.com>,
 "wangyanan55@huawei.com" <wangyanan55@huawei.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>,
 "davydov-max@yandex-team.ru" <davydov-max@yandex-team.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "leiyang@redhat.com" <leiyang@redhat.com>,
 "raphael.s.norwitz@gmail.com" <raphael.s.norwitz@gmail.com>
References: <20260201162001.296328-1-vsementsov@yandex-team.ru>
 <20260201162001.296328-7-vsementsov@yandex-team.ru>
 <080D4BAD-554D-4B47-A1FE-92F0AAE141B8@akamai.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <080D4BAD-554D-4B47-A1FE-92F0AAE141B8@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

On 04.02.26 19:46, Chaney, Ben wrote:
> 
> ﻿On 2/1/26, 11:21 AM, "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru <mailto:vsementsov@yandex-team.ru>> wrote:
> 
>> + if (tap->incoming_fds &&
>> + (tap->fd || tap->fds || tap->helper || tap->script ||
>> + tap->downscript)) {
>> + error_setg(errp, "incoming-fds is incompatible with "
>> + "fd=, fds=, helper=, script=, downscript=");
>> + return -1;
>> + }
> 
> Is it possible to relax this constraint at all? If so, I
> would prefer to allow script= and downscript= parameters
> to remain in place.
> 

That possible, but this requires some additional logic I think.

What if migration fails? Who should call downscript? Migration
may be successful on source, and fail on target.. In this case,
management tool usually resume stopped source. And in this case
source should get again a responsibility to call downscript.

So, I think it should be additional patch on top, which introduce
support for script/downscript together with backend-transfer.

-- 
Best regards,
Vladimir

