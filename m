Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB79FD1CDD7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3C8X-0000Rw-Ug; Tue, 22 Oct 2024 06:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1t3C8V-0000Rh-AB; Tue, 22 Oct 2024 06:29:11 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1t3C8R-0006mD-L8; Tue, 22 Oct 2024 06:29:10 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:210a:0:640:cc01:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 3B89560C52;
 Tue, 22 Oct 2024 13:29:00 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b683::1:3] (unknown
 [2a02:6b8:b081:b683::1:3])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id wSPTS30IhOs0-HDeQk0lF; Tue, 22 Oct 2024 13:28:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1729592939;
 bh=4WTAMmkVJhCtNdKn/Mom+vMJIKQ+iaj7e7eUxHwaFZE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Mb7xKUUvYkuzEO9TTj68ClT/tbqw1DSkROydckpvthClzoNkgzL39nRZpJlTHshf7
 jtAg8fsVsp4HpG6VaBNsyKXiwajf6FOm9AJ23nNJnxVMEMLmSIVsRAiRE3JotxuVXp
 EsZcKmJNUGEdA0VWDnr7PwpUDkdqb80QPjYYIL+Q=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <6de22024-507a-4441-ad6b-d09882c7bc1f@yandex-team.ru>
Date: Tue, 22 Oct 2024 13:28:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] vhost-user-blk: live resize additional APIs
To: qemu-block@nongnu.org, raphael@enfabrica.net, mst@redhat.com
Cc: sgarzare@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org
References: <20240920094936.450987-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240920094936.450987-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Yandex-Filter: 1
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

ping)

On 20.09.24 12:49, Vladimir Sementsov-Ogievskiy wrote:
> v6: tiny fix: add document comment for sync_config field to fix qdoc
> generation. Also, add r-b and a-b marks.
> 
> Vladimir Sementsov-Ogievskiy (3):
>    qdev-monitor: add option to report GenericError from find_device_state
>    vhost-user-blk: split vhost_user_blk_sync_config()
>    qapi: introduce device-sync-config
> 
>   hw/block/vhost-user-blk.c | 27 ++++++++++++++------
>   hw/virtio/virtio-pci.c    |  9 +++++++
>   include/hw/qdev-core.h    |  6 +++++
>   qapi/qdev.json            | 24 ++++++++++++++++++
>   system/qdev-monitor.c     | 53 ++++++++++++++++++++++++++++++++++++---
>   5 files changed, 108 insertions(+), 11 deletions(-)
> 

-- 
Best regards,
Vladimir


