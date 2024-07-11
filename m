Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8897C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 08:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRpYY-0004fl-Gz; Thu, 11 Jul 2024 04:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sRpYW-0004cV-LF; Thu, 11 Jul 2024 04:53:36 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sRpYO-0004lF-5u; Thu, 11 Jul 2024 04:53:36 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:70c6:0:640:97e8:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 45AC860A14;
 Thu, 11 Jul 2024 11:53:20 +0300 (MSK)
Received: from [IPV6:2a02:6b8:0:419:884:de50:1ec6:a9a1] (unknown
 [2a02:6b8:0:419:884:de50:1ec6:a9a1])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id HraPjh0IdiE0-1r8yR7y7; Thu, 11 Jul 2024 11:53:19 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1720687999;
 bh=NVyRxxQjZ95Pl60TdBOckNgXzru5Gsfpw3DOXU0ofpE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=NWb10nB8OVRmQwNNQljj421GIFqaqPQYwNmocoGmdjAxK5942DeZxPGPHlcmImuTJ
 Dd3gnzr9HGXgwSD3CsiuyoU/U4Hj8e+WF09Qyf3hH2bZqLRqE0QCTop0YFhVRVHBau
 P2jQUH83cL2Bf/HpbjFI96FjFbwCl7vKgxnQMCH0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0e199197-9bad-40ef-9081-eca74ca39f69@yandex-team.ru>
Date: Thu, 11 Jul 2024 11:53:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] vhost-user-blk: live resize additional APIs
To: qemu-block@nongnu.org, raphael@enfabrica.net, mst@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, berrange@redhat.com, pbonzini@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, yc-core@yandex-team.ru
References: <20240625121843.120035-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240625121843.120035-1-vsementsov@yandex-team.ru>
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

ping. Markus, Eric, could someone give an ACC for QAPI part?

On 25.06.24 15:18, Vladimir Sementsov-Ogievskiy wrote:
> v5:
> 03: drop extra check on is is runstate running
> 
> 
> Vladimir Sementsov-Ogievskiy (3):
>    qdev-monitor: add option to report GenericError from find_device_state
>    vhost-user-blk: split vhost_user_blk_sync_config()
>    qapi: introduce device-sync-config
> 
>   hw/block/vhost-user-blk.c | 27 ++++++++++++++------
>   hw/virtio/virtio-pci.c    |  9 +++++++
>   include/hw/qdev-core.h    |  3 +++
>   qapi/qdev.json            | 24 ++++++++++++++++++
>   system/qdev-monitor.c     | 53 ++++++++++++++++++++++++++++++++++++---
>   5 files changed, 105 insertions(+), 11 deletions(-)
> 

-- 
Best regards,
Vladimir


