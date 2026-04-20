Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4E6F5A8B6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 19:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEuJa-0005HJ-H2; Mon, 20 Apr 2026 15:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wEuJV-0005Gq-H6
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 15:29:46 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wEuJT-0002R9-3G
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 15:29:45 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 55515C01B9;
 Mon, 20 Apr 2026 22:29:38 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:54b::1:34] (unknown
 [2a02:6bf:8080:54b::1:34])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id ZTXVB10M6Os0-PA5b5eex; Mon, 20 Apr 2026 22:29:37 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1776713377;
 bh=qNAzN812VT2LuHT3F4Vtrmb/ZRJ3bgoBueFsS7nymyA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=IbP1Ffrub2QVayoLWMuRoLVvxorHByZLa0yzHgjXVQNYcis5A/ZTvUnql7i77clvv
 d3jpHMdxvYb4HtluwY32eRPK9Y6/JDXsF8SjzdBDd1mZZA+COPDWYu0re4AZHAvD+i
 PanmJ2BJr14efA18vkQRnQGCTdNmTN20EX+SuKkc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <84c2fc39-8bf4-491e-9a3f-42a8c242ba54@yandex-team.ru>
Date: Mon, 20 Apr 2026 22:29:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 5/8] virtio-net: support local migration of backend
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
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20260420161958.584407-1-vsementsov@yandex-team.ru>
 <20260420161958.584407-6-vsementsov@yandex-team.ru>
 <AB9D5FA5-8BEE-41CC-8446-C640E5BE5814@akamai.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <AB9D5FA5-8BEE-41CC-8446-C640E5BE5814@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 20.04.26 19:56, Chaney, Ben wrote:
> 
> 
> ﻿On 4/20/26, 12:20 PM, "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru <mailto:vsementsov@yandex-team.ru>> wrote:
> 
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index a14ad05b9a6..8b2e666854b 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -40,6 +40,7 @@
> 
> 
>> GlobalProperty hw_compat_10_2[] = {
>> { "scsi-block", "migrate-pr", "off" },
>> + { TYPE_VIRTIO_NET, "local-migration", "false" },
>> };
>> const size_t hw_compat_10_2_len = G_N_ELEMENTS(hw_compat_10_2);
> 
> This hunk doesn't apply on the current master branch.
> 
> Thanks,
>          Ben
> 

Oops, and it must be in 11_0 now. Will resend.


-- 
Best regards,
Vladimir

