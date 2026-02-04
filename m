Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCE1E83EE8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnXyI-0006ad-Rn; Wed, 04 Feb 2026 03:10:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vnXyG-0006aQ-Jx
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 03:10:44 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vnXyE-0002PT-MO
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 03:10:44 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 4E14B80464;
 Wed, 04 Feb 2026 11:10:39 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:52d::1:1f] (unknown
 [2a02:6bf:8080:52d::1:1f])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id bAkUaf0A58c0-ehvcMztJ; Wed, 04 Feb 2026 11:10:38 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770192638;
 bh=UOyEgU2fkSCNwwe5eR/WpF3MJRlgWR+j2W2KcgqeC+M=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=rIczyRI5rxCz8PZZkiQmol00FfXrQaNTEIkhD5tEVpdzkARUltGsYkUdEv+ECio6b
 5CaTcW5yoVbvQSkBCCPX4YirsYoCg1CnXhDUjvMV4IYHzetFMoplcKNtVu90IwzvMU
 WeqMApAh77/LTKj9Kf+i9GL6I7r4iLbSOfJDaSQY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <cefd433e-ce22-49fc-855d-b6c15ad8bf19@yandex-team.ru>
Date: Wed, 4 Feb 2026 11:10:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] net/af-xdp: fix type overflow
To: "Chaney, Ben" <bchaney@akamai.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "d-tatianin@yandex-team.ru" <d-tatianin@yandex-team.ru>,
 "davydov-max@yandex-team.ru" <davydov-max@yandex-team.ru>,
 Ilya Maximets <i.maximets@ovn.org>
References: <20260129213215.1405459-1-vsementsov@yandex-team.ru>
 <20260129213215.1405459-2-vsementsov@yandex-team.ru>
 <E43BA2A0-02D1-416A-BE1A-0942D337ACC3@akamai.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <E43BA2A0-02D1-416A-BE1A-0942D337ACC3@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 03.02.26 22:10, Chaney, Ben wrote:
> 
>> In for-loop in net_init_af_xdp, we do nc->queue_index = i,
>> where is is int64_t for 0 to queues-1, and nc->queue_index is
>> unsigned int.
> 
> 
>> Also in parse_socket_fds, g_strv_length() returns guint which
>> is equivalent to unsigned int.
> 
> 
>> Let's simply use unsigned int type for queues, and update
>> the check appropriately.
> 
> 
> I have some concerns about this patch queues is generally signed,
> so negative values can be used for error handling.

Right, and because of it, in "net: introduce net_parse_fds()" I
change this UINT_MAX limit to INT_MAX.

> We should
> probably be consistent with this.

I wanted make it int, but decided, that I don't want to argue against

    If you're using "int" or "long", odds are good that there's a better type.
    If a variable is counting something, it should be declared with an
    unsigned type.

of docs/devel/style.rst :)

Still, in tap.c, queues variable is int in net_init_tap(), exactly to handle
errors. Still, where possible I use unsigned for it. Don't know what is better.
No problem to change all "queues" to be int, up to Jason.

> 
> 
>> - queues = opts->has_queues ? opts->queues : 1;
>> - if (queues < 1) {
>> + if (opts->has_queues && (opts->queues < 0 || opts->queues > UINT_MAX)) {
>> error_setg(errp, "invalid number of queues (%" PRIi64 ") for '%s'",
>> - queues, opts->ifname);
>> + opts->queues, opts->ifname);
>> return -1;
>> }
> 
> Perhaps the condition here should be opts->queues > MAX_TAP_QUEUES
> instead of UINT_MAX
> 
> Thanks,
>          Ben
> 


-- 
Best regards,
Vladimir

