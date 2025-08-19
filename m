Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5862CCA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 13:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoMNU-0007TE-81; Tue, 19 Aug 2025 09:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uoMNR-0007Sg-67
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 09:27:49 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uoMNN-0001v9-Vc
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 09:27:48 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:5ca4:0:640:d3ba:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 350E680A03;
 Tue, 19 Aug 2025 16:27:40 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b25::1:17] (unknown
 [2a02:6bf:8080:b25::1:17])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id dRRF260Fl4Y0-9Vzd43C0; Tue, 19 Aug 2025 16:27:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755610059;
 bh=1Cgd+X4j+mvXtNawKAeTNUbS1eV4akvKjZpscb27UMk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=UikRsNgvIFFrKFZjc41yTYhQoApoSjoPV7swTVjQz9P/MNuC3uqji/VpXXvLFqBwR
 cqkV1h+dnt+gF7BBq/gsFvwPOK87y9ocm1HfyPvUVSXtZ0ggCb4TyPJQpvSjQiTG2p
 77pEog+THefBMzqjuL/6KAMTmxlyFXD4FU2eQpjo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <7c27b2a0-afb1-4289-998f-9a0d624f135d@yandex-team.ru>
Date: Tue, 19 Aug 2025 16:27:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] TAP initialization refactoring
To: Lei Yang <leiyang@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
References: <20250818140645.27904-1-vsementsov@yandex-team.ru>
 <CACGkMEvHXy0=vwAGS+2S7jCa5TjLxOso-SYb15TTE5q=VtPA2A@mail.gmail.com>
 <bcc0adcc-4d50-454c-abf9-334e15c712e4@yandex-team.ru>
 <CAPpAL=zQ-PQo78TeqmYgvGRnGeQFy0g-BAd2R405pdBbtCJQpw@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAPpAL=zQ-PQo78TeqmYgvGRnGeQFy0g-BAd2R405pdBbtCJQpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 19.08.25 16:14, Lei Yang wrote:
> Hi Vladimir
> 
>  From the QE perspective, this series of patches cause a regression issues for multi queues:
> [qemu output] qemu-system-x86_64: -netdev ..."vhostfds": "20:21:22:23", "fds": "10:16:17:19" : vhostfds= is invalid if fds= wasn't specified

Oh right, thanks, I see the mistake in "[PATCH 15/19] net/tap: introduce net_tap_open()", I've refactored the end of net_init_tap() like it's only for "open" case, but fds case doesn't have own "return" operator actually, and goes to the end and fails on the last check. Will fix.

Which tests should I execute? At least "make check" doesn't see this problem.

> 
> Thanks
> Lei
> 
> 
> On Tue, Aug 19, 2025 at 4:42 PM Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru <mailto:vsementsov@yandex-team.ru>> wrote:
> 
>     On 19.08.25 05:45, Jason Wang wrote:
>      > On Mon, Aug 18, 2025 at 10:06 PM Vladimir Sementsov-Ogievskiy
>      > <vsementsov@yandex-team.ru <mailto:vsementsov@yandex-team.ru>> wrote:
>      >>
>      >> Hi all!
>      >>
>      >> As preparation for further development of TAP live local migration
>      >> (passing open fds through unix socket),
>      >
>      > I'm not sure I understand this, but I think it has been supported now,
>      > or anything I miss?
>      >
> 
>     Hmm, may be I missing something, but where?
> 
>     I see no code which put TAP fd into migration channel. Nothing about migration in tap.c at all.
> 
>     So, normally, to make local migration with TAP device, you have to create a new TAP for new QEMU
>     process.
> 
>     I want to add a migration state, which will include needed part of TAPState, including fd,
>     to continue using same TAP device in target process, avoiding also any initialization steps
>     on that fd.
> 
>     -- 
>     Best regards,
>     Vladimir
> 


-- 
Best regards,
Vladimir

