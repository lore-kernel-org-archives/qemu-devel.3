Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F47CE83EE7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnY3o-0007ed-9Y; Wed, 04 Feb 2026 03:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vnY3l-0007eQ-0q
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 03:16:25 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vnY3j-0002ue-FN
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 03:16:24 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 8D26BC015B;
 Wed, 04 Feb 2026 11:16:20 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:52d::1:1f] (unknown
 [2a02:6bf:8080:52d::1:1f])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id IGkiLg0Ah0U0-M8RRRXlK; Wed, 04 Feb 2026 11:16:19 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770192979;
 bh=sKfz1+Ebvn9G096uPd984mZtmCT9ybfOX27HgZtUidY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=cn3hyu7zbfJ8CeFa51Rao161oX+MK8jfqMuzO1Eswvt+gEj09GDdn9v/1+jzoHayq
 /YZyOkktDlaovDf7pihIFxvjZy/rV7VtpPPR/K8PsaKSjnyhsrtL/w5XMtof7iw/pJ
 t3ruVtILBzkIjUhi1PVrX8XGZrU4OIi0PzNYa+Ls=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <da225112-cbaa-4c61-8c94-abbd29fcbec0@yandex-team.ru>
Date: Wed, 4 Feb 2026 11:16:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] net/tap: move fds parameters handling to
 separate functions
To: "Chaney, Ben" <bchaney@akamai.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "d-tatianin@yandex-team.ru" <d-tatianin@yandex-team.ru>,
 "davydov-max@yandex-team.ru" <davydov-max@yandex-team.ru>
References: <20260129213215.1405459-1-vsementsov@yandex-team.ru>
 <20260129213215.1405459-10-vsementsov@yandex-team.ru>
 <65193BB6-0256-4E53-8923-8247FFBE93CB@akamai.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <65193BB6-0256-4E53-8923-8247FFBE93CB@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 03.02.26 22:37, Chaney, Ben wrote:
>> +static int tap_parse_fds_and_queues(const NetdevTapOptions *tap, int **fds,
>> +                                    Error **errp)
>> +{
>> +    unsigned queues;
>> +
>> +    if (tap->has_queues + !!tap->helper + !!tap->fds + !!tap->fd > 1) {
>> +        error_setg(errp, "queues=, helper=, fds= and fd= are mutual exclusive");
>> +        return -1;
>> +    }
>> +
>> +    if (tap->has_queues) {
>> +        if (tap->queues > INT_MAX) {
>> +            error_setg(errp, "queues exceeds maximum %d", INT_MAX);
>> +            return -1;
>> +        }
>> +        queues = tap->queues;
>> +        *fds = NULL;
>> +    } else if (tap->fd || tap->fds) {
>> +        queues = net_parse_fds(tap->fd ?: tap->fds, fds,
>> +                               tap->fd ? 1 : 0, errp);
>> +        if (!*fds) {
>> +            return -1;
>> +        }
>> +    } else if (tap->helper) {
>> +        int fd = net_bridge_run_helper(tap->helper,
>> +                                       tap->br ?: DEFAULT_BRIDGE_INTERFACE,
>> +                                       errp);
>> +        if (fd < 0) {
>> +            return -1;
>> +        }
>> +
>> +        queues = 1;
>> +        *fds = g_new(int, 1);
>> +        **fds = fd;
>> +    }
>> +
>> +    if (*fds && !unblock_fds(*fds, queues, errp)) {
>> +        net_free_fds(*fds, queues);
>> +        return -1;
>> +    }
>> +
>> +    return queues;
>> +}
> 
> This causes a build error in my environment:
> 
> ../net/tap.c: In function 'net_init_tap':
> ../net/tap.c:901:12: error: 'queues' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>    901 |     return queues;
>        |            ^~~~~~
> ../net/tap.c:863:14: note: 'queues' was declared here
>    863 |     unsigned queues;
>        |              ^~~~~~
> 
> Looking at the code is seems like it would be possible for queues to be unset
> If !has_queues && !tap->fd && !tap->fds && !tap->helper
> 
> Can we default to queues = 1, or if that isn't appropriate add an else block that prints an error and returns -1?
> 

Oops, right, will do (set default). Thanks!

-- 
Best regards,
Vladimir

