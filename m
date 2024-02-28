Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B1CC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 16:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfMkO-0005Zq-N7; Wed, 28 Feb 2024 11:25:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rfMjd-0004p9-NP; Wed, 28 Feb 2024 11:24:47 -0500
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rfMjb-0000ui-Ch; Wed, 28 Feb 2024 11:24:45 -0500
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:621c:0:640:f00b:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 52C8960DB7;
 Wed, 28 Feb 2024 19:24:36 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a519::1:3a] (unknown
 [2a02:6b8:b081:a519::1:3a])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ZOcqeV1IkuQ0-LPgPPo8A; Wed, 28 Feb 2024 19:24:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709137475;
 bh=Dts6lp1y93tKuAOeU+UyWR4MbDFpSCKIHvmD1zm9fB8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=iYA84NI+VI9dS4HLoWOtxon3cByIJF/MAz4D3fTT3MR/6ovr39sN2uCNn0LR1xqO7
 7TrHqTTdBh/aUwbmgMQH0rSsOwlbBI4BKkS90gO8U+sOoxnFLTyffsB1amZNr2+oXE
 9nPIoxJjFWAYj39qy8DREK70vRzEaF81YlpIW5/E=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <217803cb-fced-4dce-87f3-9892b2f97dce@yandex-team.ru>
Date: Wed, 28 Feb 2024 19:24:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] mirror: implement incremental and bitmap modes
Content-Language: en-US
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 f.gruenbichler@proxmox.com, t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com
References: <20240216105513.309901-1-f.ebner@proxmox.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240216105513.309901-1-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 16.02.24 13:55, Fiona Ebner wrote:
> Previous discussion from when this was sent upstream [0] (it's been a
> while). I rebased the patches and re-ordered and squashed like
> suggested back then [1].
> 
> This implements two new mirror modes:
> 
> - bitmap mirror mode with always/on-success/never bitmap sync mode
> - incremental mirror mode as sugar for bitmap + on-success
> 
> Use cases:
> * Possibility to resume a failed mirror later.
> * Possibility to only mirror deltas to a previously mirrored volume.
> * Possibility to (efficiently) mirror an drive that was previously
>    mirrored via some external mechanism (e.g. ZFS replication).
> 
> We are using the last one in production without any issues since about
> 4 years now. In particular, like mentioned in [2]:
> 
>> - create bitmap(s)
>> - (incrementally) replicate storage volume(s) out of band (using ZFS)
>> - incrementally drive mirror as part of a live migration of VM
>> - drop bitmap(s)

Actually which mode you use, "never", "always" or "conditional"? Or in downstream you have different approach?

Why am I asking:

These modes (for backup) were developed prior to block-dirty-bitmap-merge command, which allowed to copy bitmaps as you want. With that API, we actually don't need all these modes, instead it's enough to pass a bitmap, which would be _actually_ used by mirror.

So, if you need "never" mode, you just copy your bitmap by block-dirty-bitmap-add + block-dirty-bitmap-merge, and pass a copy to mirror job.

Or, you pass your bitmap to mirror-job, and have a "always" mode.

And I don't see, why we need a "conditional" mode, which actually just drops away the progress we actually made. (OK, we failed, but why to drop the progress of successfully copied clusters?)


Using user-given bitmap in the mirror job has also an additional advantage of live progress: up to visualization of disk copying by visualization of the dirty bitmap contents.

-- 
Best regards,
Vladimir


