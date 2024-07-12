Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CE8C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 13:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSFvC-0003CT-3B; Fri, 12 Jul 2024 09:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sSFv9-0002wp-C2; Fri, 12 Jul 2024 09:02:43 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sSFuv-0005uC-Fq; Fri, 12 Jul 2024 09:02:42 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:958d:0:640:7be4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id E99E1612C9;
 Fri, 12 Jul 2024 16:02:24 +0300 (MSK)
Received: from [IPV6:2a02:6b8:0:419:5fb9:9623:463f:792c] (unknown
 [2a02:6b8:0:419:5fb9:9623:463f:792c])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id N2gLFH1IX8c0-ez4YT8UR; Fri, 12 Jul 2024 16:02:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1720789344;
 bh=P6nfmfbeAtBSNuM1anI2N+Vf4NkvsST7QPZOT2oBgf8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=PFXsoToIDNnXVOoj1Uy7TYfl1xsJdH1PWhdXvgk548acrjK4O3rZLmegwH4/79guN
 5ajLXeqYfFanzAVVrGw6HY39QtQp3C79voopCQArVrIOxtidX4AOC9oqew2WpgzoUw
 +0e5u6s4Y/Vge5Bw5k5/TBN2XAVE/7LlSb3UdCIw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <81c3195f-da8e-4add-b935-9c096370aa61@yandex-team.ru>
Date: Fri, 12 Jul 2024 16:02:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] backup: allow specifying minimum cluster size
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com
References: <20240711120915.310243-1-f.ebner@proxmox.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240711120915.310243-1-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11.07.24 15:09, Fiona Ebner wrote:
> Discussion for v2:
> https://lore.kernel.org/qemu-devel/20240528120114.344416-1-f.ebner@proxmox.com/
> 
> Changes in v3:
> * Pass min_cluster_size option directly without checking
>    has_min_cluster_size, because the default is 0 anyways.
> * Calculate maximum of passed-in argument and default once at the
>    beginning of block_copy_calculate_cluster_size()
> * Update warning message to reflect actual value used
> * Do not leak qdict in error case
> * Use PRI{i,u}64 macros
> 
> Discussion for v1:
> https://lore.kernel.org/qemu-devel/20240308155158.830258-1-f.ebner@proxmox.com/
> -
> Changes in v2:
> * Use 'size' type in QAPI.
> * Remove option in cbw_parse_options(), i.e. before parsing generic
>    blockdev options.
> * Reword commit messages hoping to describe the issue in a more
>    straight-forward way.
> 
> In the context of backup fleecing, discarding the source will not work
> when the fleecing image has a larger granularity than the one used for
> block-copy operations (can happen if the backup target has smaller
> cluster size), because cbw_co_pdiscard_snapshot() will align down the
> discard requests and thus effectively ignore then.
> 
> To make @discard-source work in such a scenario, allow specifying the
> minimum cluster size used for block-copy operations and thus in
> particular also the granularity for discard requests to the source.
> 
> Fiona Ebner (2):
>    copy-before-write: allow specifying minimum cluster size
>    backup: add minimum cluster size to performance options
> 
>   block/backup.c             |  2 +-
>   block/block-copy.c         | 36 ++++++++++++++++++++++++++----------
>   block/copy-before-write.c  | 14 +++++++++++++-
>   block/copy-before-write.h  |  1 +
>   blockdev.c                 |  3 +++
>   include/block/block-copy.h |  1 +
>   qapi/block-core.json       | 17 ++++++++++++++---
>   7 files changed, 59 insertions(+), 15 deletions(-)
> 

Thanks, applied to my block branch.

-- 
Best regards,
Vladimir


