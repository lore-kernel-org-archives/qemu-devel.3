Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E911EC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 14:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfhjt-0007Uu-H6; Thu, 29 Feb 2024 09:50:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rfhjr-0007UK-21; Thu, 29 Feb 2024 09:50:23 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rfhjp-0003F1-B2; Thu, 29 Feb 2024 09:50:22 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id BCAF947FF9;
 Thu, 29 Feb 2024 15:50:18 +0100 (CET)
Message-ID: <b3d0ee7a-e633-4719-bc52-2796b18acb32@proxmox.com>
Date: Thu, 29 Feb 2024 15:50:17 +0100
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
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <3fbf2b67-3213-4416-86e4-f6e4deb0a97b@yandex-team.ru>
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

Am 29.02.24 um 13:00 schrieb Vladimir Sementsov-Ogievskiy:
> 
> But anyway, this all could be simply achieved with
> bitmap-copying/merging API, if we allow to pass user-given bitmap to the
> mirror as working bitmap.
> 
>>
>> I see, I'll drop the 'bitmap-mode' in the next version if nobody
>> complains :)
>>
> 
> Good. It's a golden rule: never make public interfaces which you don't
> actually need for production. I myself sometimes violate it and spend
> extra time on developing features, which we later have to just drop as
> "not needed downstream, no sense in upstreaming".
> 

Just wondering which new mode I should allow for the @MirrorSyncMode
then? The documentation states:

> # @incremental: only copy data described by the dirty bitmap.
> #     (since: 2.4)
> #
> # @bitmap: only copy data described by the dirty bitmap.  (since: 4.2)
> #     Behavior on completion is determined by the BitmapSyncMode.

For backup, do_backup_common() just maps @incremental to @bitmap +
@bitmap-mode == @on-success.

Using @bitmap for mirror would lead to being at odds with the
documentation, because it mentions the BitmapSyncMode, which mirror
won't have.

Using @incremental for mirror would be consistent with the
documentation, but behave a bit differently from backup.

Opinions?

Best Regards,
Fiona


