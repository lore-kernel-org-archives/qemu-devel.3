Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD08C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 14:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg4FQ-0007ad-Hw; Fri, 01 Mar 2024 09:52:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rg4FO-0007Zs-96; Fri, 01 Mar 2024 09:52:26 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rg4FL-000347-Iv; Fri, 01 Mar 2024 09:52:26 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 3666E48327;
 Fri,  1 Mar 2024 15:52:20 +0100 (CET)
Message-ID: <9bcdcdb7-162f-431a-8895-8717ffe39413@proxmox.com>
Date: Fri, 1 Mar 2024 15:52:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] mirror: implement incremental and bitmap modes
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 f.gruenbichler@proxmox.com, t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com
References: <20240216105513.309901-1-f.ebner@proxmox.com>
 <217803cb-fced-4dce-87f3-9892b2f97dce@yandex-team.ru>
 <195fe8a5-02c2-4cc4-bc41-095f6477b676@proxmox.com>
 <3fbf2b67-3213-4416-86e4-f6e4deb0a97b@yandex-team.ru>
 <b3d0ee7a-e633-4719-bc52-2796b18acb32@proxmox.com>
 <9f27c816-510f-4482-85c1-f3d1be44b758@yandex-team.ru>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <9f27c816-510f-4482-85c1-f3d1be44b758@yandex-team.ru>
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

Am 01.03.24 um 15:14 schrieb Vladimir Sementsov-Ogievskiy:
> 
> As we already understood, (block-)job-api needs some spring-cleaning.
> Unfortunately I don't have much time on it, but still I decided to start
> from finally depreacting block-job-* API and moving to job-*.. Probably
> bitmap/bitmap-mode/sync APIs also need some optimization, keeping in
> mind new block-dirty-bitmap-merge api.
> 
> So, what I could advice in this situation for newc interfaces:
> 
> 1. be minimalistic
> 2. add `x-` prefix when unsure
> 
> So, following these two rules, what about x-bitmap field, which may be
> combined only with 'full' mode, and do what you need?
> 

AFAIU, it should rather be marked as @unstable in QAPI [0]? Then it
doesn't need to be renamed if it becomes stable later.

> About documentation: actually, I never liked that we use for backup job
> "MirrorSyncMode". Now it looks more like "BackupSyncMode", having two
> values supported only by backup.
> 
> I'm also unsure how mode=full&bitmap=some_bitmap differs from
> mode=bitmap&bitmap=some_bitmap..
> 

With the current patches, it was an error to specify @bitmap for other
modes than 'incremental' and 'bitmap'.

> So, I'd suggest simply rename MirrorSyncMode to BackupSyncMode, and add
> separate MirrorSyncMode with only "full", "top" and "none" values.
> 

Sounds good to me!

[0]:
https://gitlab.com/qemu-project/qemu/-/commit/a3c45b3e62962f99338716b1347cfb0d427cea44

Best Regards,
Fiona


