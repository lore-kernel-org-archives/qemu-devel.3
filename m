Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD83FEDA02
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 18:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Z2o-0001GE-Lg; Tue, 17 Mar 2026 14:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w2Z2f-0001D3-Hy
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:21:24 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w2Z2c-0002u3-Fm
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:21:21 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 8E1DBC022E;
 Tue, 17 Mar 2026 21:21:12 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:558::1:22] (unknown
 [2a02:6bf:8080:558::1:22])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id BLRY2r1AXa60-enTLJpIC; Tue, 17 Mar 2026 21:21:12 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1773771672;
 bh=HMyw9Lv5JZqsyb/XKWgB/YbKr+5k5Yp77rS4tm7k5nk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=RR6fTjJ46t14dh0Ji31xJutSUFh5JfPNhR9CjFDTRt15PQZMGqhIvDQ/+m7ts1jQB
 RWgcyFe854nLktGPTFVby/JojgVb6E2dbczGmE7HyPKGgP6WrUq9ECato0Fly00YbD
 iD6L9Mn7fyD3PJRHos6JgzYa9xidMsqP8AWuE/WU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3a285dd8-7c77-4746-94d6-72aa7b1da7c4@yandex-team.ru>
Date: Tue, 17 Mar 2026 21:21:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/12] net/tap: fix vhostfds/vhostfd parameters API
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, davydov-max@yandex-team.ru
References: <20260218202829.1322088-1-vsementsov@yandex-team.ru>
 <20260218202829.1322088-11-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260218202829.1322088-11-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 18.02.26 23:28, Vladimir Sementsov-Ogievskiy wrote:
> +static bool tap_parse_vhost_fds(const NetdevTapOptions *tap, int **vhost_fds,
> +                                int queues, Error **errp)
> +{
> +    if (!(tap->vhostfd || tap->vhostfds)) {
> +        *vhost_fds = NULL;
> +        return true;
> +    }
> +
> +    if (net_parse_fds(tap->fd ?: tap->fds, vhost_fds, queues, errp) < 0) {

reviewing own patches:

that should be "tap->vhostfd ?: tap->vhostfds" of course.

-- 
Best regards,
Vladimir

