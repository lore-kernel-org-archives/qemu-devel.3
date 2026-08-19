Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E68BC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhjo-00087X-Rd; Wed, 19 Aug 2026 10:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wwhjP-00082j-AG
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:57:35 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wwhjL-0000Wt-TV
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:57:30 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id D6D068046A;
 Wed, 19 Aug 2026 17:57:21 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c60::1:5] (unknown [2a02:6bf:8080:c60::1:5])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id KvX9FU1ZbSw0-e00oQean; Wed, 19 Aug 2026 17:57:21 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787151441;
 bh=6ejtKMq6BP/4Z0YO9kvD1THBnOtBB0oRsSaATZdyrE8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=zMfDEkMJUQyYQ3MFb5lNegx/lmoSAODs2XtcAaeYgWLPKKmI8M474/xZARfXSY+LI
 U+WpVWHDodIADOIpM2eHuKFvxT9Ke5WbW08fK15V6XRMbhW3A7RRUbeCYjSMK5jHOQ
 7nptjbO4X/OReSlQ0VODAXfTNATp7GQ+kBWYBU0o=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <9fc39a84-15ca-4157-afca-f4cd22bfbdad@yandex-team.ru>
Date: Wed, 19 Aug 2026 17:57:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 10/15] migration/channel: check that transfer is UNIX
 socket when "local" set
To: Peter Xu <peterx@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, qemu-devel@nongnu.org,
 berrange@redhat.com, pbonzini@redhat.com, yc-core@yandex-team.ru,
 mark.caveayland@nutanix.com
References: <20260729091334.1863155-1-vsementsov@yandex-team.ru>
 <20260729091334.1863155-11-vsementsov@yandex-team.ru>
 <amoJoAyhymPgvyTR@x1.local>
 <b9957dda-c0ee-4081-8938-ecc5a50aae3c@yandex-team.ru>
 <aoNXx0cjLgIP7RBg@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aoNXx0cjLgIP7RBg@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
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

On 17.08.26 21:49, Peter Xu wrote:
> On Mon, Aug 17, 2026 at 09:15:17PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>> We only need to touch migration_capabilities_and_transport_compatible()?
>>> It should work for both, and fail QMP commands directly might also be
>>> slightly better.
>>
>>
>> Hm. Actually, migration_capabilities_and_transport_compatible() only sees
>> the parsed MigrationAddress, before any QIOChannel is created. At that
>> point we can't call qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_FD_PASS),
>> because there is no ioc yet..
>>
>> So, at least, we can't check, is passed from user fd is a UNIX socket
>> for SOCKET_ADDRESS_TYPE_FD case.
> 
> Maybe have one extra step for FD with socket_sockaddr_to_address()?
> 

For this we need an fd itself, but we don't have it at the moment, we
get it from monitof_fd_param() later (and we can't call it twice, as
it removes the fd from the list).

Now I think, correct place to check FD case is migration_fd_valid()
function, which also called both for outgoing and incoming paths.

So, check that we use either UNIX socket or FD in
migration_capabilities_and_transport_compatible(), and later check
for fd to be UNIX socket in migration_fd_valid().

Will do in v21, if no better ideas.

-- 
Best regards,
Vladimir

