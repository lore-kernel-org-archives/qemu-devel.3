Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA7EE9B251
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 11:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuqTC-0005aN-Qb; Tue, 24 Feb 2026 06:20:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vuqT7-0005R8-Af
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:20:46 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vuqT4-0002uY-18
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:20:44 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 538908850A;
 Tue, 24 Feb 2026 14:20:33 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:448::1:11] (unknown
 [2a02:6bf:8080:448::1:11])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id UKeWfN7ACKo0-m71xOHou; Tue, 24 Feb 2026 14:20:32 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771932032;
 bh=E+M0ubGZzfuokt30VQMEqhmDw8oKWg/l1YRegknL0PE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Kdo3c7O9jq8Ovub/AhJdXU4I36Lm/sM3dmC8drTZABbGtuAwVMYofW3rYEOGqnZQ2
 eMZHCLcCFzvZB38W/eMrDnjrXcSHxfWgytApCdHe86ax//79y963qLidLEkxjt6uSa
 U8/GSo9/HVGOBNTEcA5Q47lN0TIw05mNN+F+Uatk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <e60e4849-30d7-4ceb-a1a5-9fdc9b579827@yandex-team.ru>
Date: Tue, 24 Feb 2026 14:20:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 6/8] net/tap: support local migration with virtio-net
To: "Chaney, Ben" <bchaney@akamai.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>, "farosas@suse.de"
 <farosas@suse.de>, "peterx@redhat.com" <peterx@redhat.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>,
 "wangyanan55@huawei.com" <wangyanan55@huawei.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>,
 "davydov-max@yandex-team.ru" <davydov-max@yandex-team.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "leiyang@redhat.com" <leiyang@redhat.com>,
 "raphael.s.norwitz@gmail.com" <raphael.s.norwitz@gmail.com>
References: <20260219115530.2019498-1-vsementsov@yandex-team.ru>
 <20260219115530.2019498-7-vsementsov@yandex-team.ru>
 <721F62BC-6E5F-4963-BC3A-666F0C0290CA@akamai.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <721F62BC-6E5F-4963-BC3A-666F0C0290CA@akamai.com>
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

On 24.02.26 00:36, Chaney, Ben wrote:
> 
> ﻿On 2/19/26, 6:56 AM, "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru <mailto:vsementsov@yandex-team.ru>> wrote:
> 
>> + if (tap->incoming_fds && (script || downscript)) {
>> + error_setg(errp,
>> + "incoming-fds requires script=no and downscript=no");
>> + return -1;
>> + }
>> +
> 
> This conditional will never trigger because we are in an else{} block
> that implies !tap->incoming_fds. I think we need to handle this case
> higher up.

Oh, right, will fix.

> 
> Other than that, this patch set LGTM. I was able to test it, and the
> performance was impressive.
> 

Thanks for testing!


-- 
Best regards,
Vladimir

