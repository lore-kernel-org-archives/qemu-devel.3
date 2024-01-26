Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09687C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 09:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTIP6-0004oj-78; Fri, 26 Jan 2024 04:21:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rTIP3-0004md-Pv; Fri, 26 Jan 2024 04:21:37 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rTIP2-0000P2-45; Fri, 26 Jan 2024 04:21:37 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id D52B9446A2;
 Fri, 26 Jan 2024 10:21:23 +0100 (CET)
Message-ID: <1cec54a7-073c-4dd7-a390-9890bf990720@proxmox.com>
Date: Fri, 26 Jan 2024 10:21:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] qapi: blockdev-backup: add discard-source parameter
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, hreitz@redhat.com,
 kwolf@redhat.com, jsnow@redhat.com
References: <20240117160737.1057513-1-vsementsov@yandex-team.ru>
 <20240117160737.1057513-4-vsementsov@yandex-team.ru>
 <d0cbb4ed-bdb9-4487-ab7b-4b5e72a36e7e@proxmox.com>
 <36a903e5-c646-4596-a6e1-a7b1e2571c43@proxmox.com>
 <ee7438e8-ba86-40cc-b24e-5ea6160ba564@yandex-team.ru>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <ee7438e8-ba86-40cc-b24e-5ea6160ba564@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 25.01.24 um 18:22 schrieb Vladimir Sementsov-Ogievskiy:
> 
> Hmm. Taking maximum is not optimal for usual case without
> discard-source: user may want to work in smaller granularity than
> source, to save disk space.
> 
> In case with discarding we have two possibilities:
> 
> - either take larger granularity for the whole process like you propose
> (but this will need and option for CBW?)
> - or, fix discarding bitmap in CBW to work like normal discard: it
> should be aligned down. This will lead actually to discard-source option
> doing nothing..
> 
> ==
> But why do you want fleecing image with larger granularity? Is that a
> real case or just experimenting? Still we should fix assertion anyway.
> 

Yes, it's a real use case. We do support different storage types and
want to allow users to place the fleecing image on a different storage
than the original image for flexibility.

I ran into the issue when backing up to a target with 1 MiB cluster_size
while using a fleecing image on RBD (which has 4 MiB cluster_size by
default).

In theory, I guess I could look into querying the cluster_size of the
backup target and trying to allocate the fleecing image with a small
enough cluster_size. But not sure if that would work on all storage
combinations, and would require teaching our storage plugin API (which
also supports third-party plugins) to perform allocation with a specific
cluster size. So not an ideal solution for us.

> I think:
> 
> 1. fix discarding bitmap to make aligning-down (will do that for v3)
> 

Thanks!

> 2. if we need another logic for block_copy_calculate_cluster_size() it
> should be an option. May be explicit "copy-cluster-size" or
> "granularity" option for CBW driver and for backup job. And we'll just
> check that given cluster-size is power of two >= target_size.
> 

I'll try to implement point 2. That should resolve the issue for our use
case.

Best Regards,
Fiona


