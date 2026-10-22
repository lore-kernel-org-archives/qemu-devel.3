Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A525B606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex-team.ru header.i=@yandex-team.ru header.a=rsa-sha256 header.s=default header.b=KN6Ucsyb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJpXl-00028L-G3; Thu, 22 Oct 2026 05:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xJpXj-00027u-7F
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 05:57:03 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xJpXh-0003bn-Bn
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 05:57:02 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.yp-c.yandex.net)
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id C96618062E;
 Thu, 22 Oct 2026 12:56:58 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b37::1:16]
 by mail-nwsmtp-smtp-corp-main-68 with ESMTPSA id wuYh5D92WiE0-18v3YhaY;
 Thu, 22 Oct 2026 12:56:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1792663018;
 bh=aAikJOHG5kYZQnozqXTKA3iOhIpm6KcDT9v2pEPoJJQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=KN6UcsybDxZfoye5lXBtFukGSwPaP9O9sfsq1P7u46UXDDs/4+l8z9tGZdRf95LJw
 KyvU8OKIocFJ9s0b27H+PuBqRR3iciG+OP2MaR/8y2yK70ZcFyteJCJZrYENzqZ8M3
 acQiEBJ65fwm097Sq+6RntCjzmuSJjT4mbWyxvbI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <15d478a9-c42a-4601-bc19-ff65b8a95452@yandex-team.ru>
Date: Thu, 22 Oct 2026 12:56:58 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] runstate: fix race between guest shutdown and SIGTERM
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org
References: <20260904205749.510493-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260904205749.510493-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ping!

Can we merge it without 6/6? 6/6 is just a refactoring, we can proceed without it.

On 04.09.26 23:57, Vladimir Sementsov-Ogievskiy wrote:
> Hi all.
> 
> This series fixes a race between guest shutdown and SIGTERM handling.
> With -no-shutdown, a SIGTERM arriving while QEMU is processing a guest
> shutdown request can make QEMU exit after sending SHUTDOWN with guest=true,
> without sending a host SHUTDOWN event. This is unexpected for management
> software relying on -no-shutdown.
> 
> Patch 5 contains the fix and a detailed description of the race. The
> preceding patches prepare for it, and patch 6 makes the runstate action
> variables private.
> 
> Vladimir Sementsov-Ogievskiy (6):
>    runstate: introduce qemu_system_shutdown_request_safe() helper
>    runstate: treat SHUTDOWN_CAUSE_HOST_UI as force_shutdown
>    runstate: inline qemu_shutdown_requested()
>    runstate: simplify qemu_shutdown_requested_get()
>    runstate: separate forced and regular shutdown requests
>    runstate: make runstate actions private
> 
>   MAINTAINERS                      |   1 -
>   hw/xen/xen-hvm-common.c          |   2 +-
>   include/system/runstate-action.h |  19 ------
>   include/system/runstate.h        |   2 +-
>   monitor/qmp-cmds.c               |   2 -
>   system/meson.build               |   1 -
>   system/runstate-action.c         |  46 --------------
>   system/runstate.c                | 103 +++++++++++++++++++++----------
>   system/vl.c                      |   2 +-
>   ui/cocoa.m                       |   2 -
>   ui/sdl2.c                        |   3 -
>   11 files changed, 75 insertions(+), 108 deletions(-)
>   delete mode 100644 include/system/runstate-action.h
>   delete mode 100644 system/runstate-action.c
> 


-- 
Best regards,
Vladimir

