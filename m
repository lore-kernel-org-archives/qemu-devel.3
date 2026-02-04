Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1466E83EE9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnXpk-0003sF-Jg; Wed, 04 Feb 2026 03:01:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vnXpi-0003rW-Td
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 03:01:54 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vnXph-00078m-40
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 03:01:54 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1593:0:640:6beb:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 7A39D8080D;
 Wed, 04 Feb 2026 11:01:51 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:52d::1:1f] (unknown
 [2a02:6bf:8080:52d::1:1f])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id o1kt7n0A8eA0-SsVdace0; Wed, 04 Feb 2026 11:01:50 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770192110;
 bh=N9XS6Uw64rLv5KSlOM2rkZYctG+gaDEnLT0hbhjrJGY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=g2KH4H4peEw5D2cDMQ6yQ5Jc4oQIrzlnTM94vjMvLu8BUktiRJ+3TcLXuC46DdsXS
 7K3EukX60L982uu+Yn5RhnSKYkX6baZwoRsqbhwIK+rYuN91BBpfRTy+gzDtigYA0T
 tJowrh7Boq38/jrjHvxUcPf+abmLQstiJBnhjxLw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c1fa6180-4e6f-4cc2-93da-62afab02cad5@yandex-team.ru>
Date: Wed, 4 Feb 2026 11:01:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] net/af-xdp: fix type overflow
To: Ilya Maximets <i.maximets@ovn.org>, "Chaney, Ben" <bchaney@akamai.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "d-tatianin@yandex-team.ru" <d-tatianin@yandex-team.ru>,
 "davydov-max@yandex-team.ru" <davydov-max@yandex-team.ru>
References: <20260129213215.1405459-1-vsementsov@yandex-team.ru>
 <20260129213215.1405459-2-vsementsov@yandex-team.ru>
 <E43BA2A0-02D1-416A-BE1A-0942D337ACC3@akamai.com>
 <3fd2475e-f070-4255-a716-8d06cb888981@ovn.org>
 <F3E91DE0-38ED-493E-ADB3-9FF7139AA6A2@akamai.com>
 <2d704c50-37a4-4080-9c78-2b2a3fb2f25a@ovn.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <2d704c50-37a4-4080-9c78-2b2a3fb2f25a@ovn.org>
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

On 04.02.26 01:53, Ilya Maximets wrote:
> On 2/3/26 9:21 PM, Chaney, Ben wrote:
>>>>
>>>> Perhaps the condition here should be opts->queues > MAX_TAP_QUEUES
>>>> instead of UINT_MAX
>>
>>
>>> I wonder why would we use MAX_TAP_QUEUES for something that isn't
>>> a tap interface? It's also not defined here, would be a bit awkward
>>> to export.
>>
>> Fair point. It looks like I got my wires crossed a bit here. (And also in my
>> comment to the other patch). Would it be possible to have different
>> MAX_XYZ_QUEUES for other device types?
> 
> Why do we need an artificial limit on the number of queues?
> In the kernel the number of queues per device is not limited,
> it just needs to fit into unsigned int.  So, I don't think
> we need to create artificial limits on QEMU side.
> 
> AFAIU, the MAX_TAP_QUEUES was introduced because implementation
> allocated an array of that size on stack and it is not wise
> to do so with a fairly unbound values.  But today even tap.c
> allocates everything dynamically, so I'm not even sure if the
> MAX_TAP_QUEUES makes much sense for net/tap itself, as it seems
> to be an artificial limit for the number of fds that can be
> passed in.  It is also no enforced when QEMU creates the queues
> on its own.
> 
> Best regards, Ilya Maximets.

Right, MAX_TAP_QUEUES is artificial for tap.c, and becomes absolutely
unused after this series. Still, I forget to remove the macro itself.

-- 
Best regards,
Vladimir

