Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0E1C44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 18:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkQuc-0005bY-CJ; Thu, 16 Jul 2026 14:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wkQua-0005bN-Hb
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:34:20 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wkQuZ-0005kF-18
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:34:20 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id C1714C04DA;
 Thu, 16 Jul 2026 21:34:17 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d6a::1:11] (unknown
 [2a02:6bf:8080:d6a::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id HYWsfV5WMa60-obWHF53g; Thu, 16 Jul 2026 21:34:17 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1784226857;
 bh=d2sXUNmWaX0qs7/P18rlsdRJb9ERuvDJ8Gwwnn5wB6Y=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=C9OBp+nb8ZFH2ZVF1lQ9iwgvH2/3dw3PJrFXof1IS7crBlzcNwPp3U2V9JJpcffr8
 Ogeq3bvvj8vwbz5ErRAias+cxjH+TwQ7qdRC8YJ5tW2WOAwzNWomCnIKU4jA5EHK+L
 lyDQsfCj6OgVsGgCpWEFmK3IBtv95xHUpm4oVEjg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <27ef0bb0-8ce7-4682-b169-8136276eff5c@yandex-team.ru>
Date: Thu, 16 Jul 2026 21:34:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 13/15] net/tap: support local migration with virtio-net
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
 "mark.caveayland@nutanix.com" <mark.caveayland@nutanix.com>,
 Jason Wang <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>
References: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
 <20260714154246.1242856-14-vsementsov@yandex-team.ru>
 <C3749950-EF67-430C-B894-A740C97124B6@akamai.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <C3749950-EF67-430C-B894-A740C97124B6@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 15.07.26 17:54, Chaney, Ben wrote:
> 
> ﻿On 7/14/26, 11:44 AM, "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru <mailto:vsementsov@yandex-team.ru>> wrote:
> 
> 
>> + if (has_local_migration_supported) {
>> + s->local_migration_supported = local_migration_supported;
>> + }
>> +
>> + vmstate_register(VMSTATE_IF(s), VMSTATE_INSTANCE_ID_ANY, &vmstate_tap, s);
>> +
>> return s;
>> }
> 
> A comment on vmstate_register says:
> 
>> * New code shouldn't be using this function as QOM-ified devices have
>> * dc->vmsd to store the serialisation description.
> 
> Is it possible to use that interface here?
> 

I'm afraid not. TAP is "QOM-ified", but it's not a device, and don't participate in
generic device migration code.

-- 
Best regards,
Vladimir

