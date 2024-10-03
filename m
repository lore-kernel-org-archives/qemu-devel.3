Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ACB8CF8577
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 10:33:12 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swI2A-0006Tv-B9; Thu, 03 Oct 2024 05:22:12 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1swI1v-0006Ib-63
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 05:21:51 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@yandex-team.ru>) id 1swI1R-0007Xl-8R
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 05:21:42 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:8a3:0:640:33b5:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id BBC7260E33;
 Thu,  3 Oct 2024 11:05:59 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8026::1:2f] (unknown
 [2a02:6b8:b081:8026::1:2f])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id w5Xx5d2IYCg0-bOD3oZIq; Thu, 03 Oct 2024 11:05:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1727942759;
 bh=b0+TwChyBeK2gf+lghBcsbb2F4D/kTslY/rx5m+Ajrk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=BOBKoxBSzz0GP/rBWYTJaXRX9Y/pA8IlwrlNMFxDM0K3zLK0zNrwLQF1SpdR/TZwb
 IiGftEIZ9SThFfGjJsHE/p3aLIZNBGkHO9oKyPGHlD559zuvAhmtQYYGj4z8PaI/2m
 RzK2OY3IKax3Zza4ow3Tu8vbpdhj4PbNo6/8t8K0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0e62dbcd-b642-41d1-bda9-8eef16f6c7bd@yandex-team.ru>
Date: Thu, 3 Oct 2024 11:05:58 +0300
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
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Ping

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


