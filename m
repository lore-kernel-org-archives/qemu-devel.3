Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36D4C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 12:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFXhn-0005Lm-Uw; Thu, 15 May 2025 08:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uFXhe-0005I0-Qd
 for qemu-devel@nongnu.org; Thu, 15 May 2025 08:28:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uFXhd-00066V-9d
 for qemu-devel@nongnu.org; Thu, 15 May 2025 08:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747312124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YsGYCkJDGc/e3Cub3C34msTbjsaBQCcTJWVOrPQcNQ8=;
 b=jWLQNwq6cgyEmRCss9OFOE514MXVXoMQ/YcQn50Y3APV0v4HiU30gJjg5kAvg2Tc1LxXWk
 X4tilFUPw3H6Iudkv6ZeZTVc53kzktJKX5Jkvr9LFQVtAU3yR1ykkAoxPS/PmuaMv5fVvG
 iYDDtuSr97hLvXVFFLuWwV40fp0mx0U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-bLqzSPH9P8KK5xEGFGcfYw-1; Thu,
 15 May 2025 08:28:41 -0400
X-MC-Unique: bLqzSPH9P8KK5xEGFGcfYw-1
X-Mimecast-MFC-AGG-ID: bLqzSPH9P8KK5xEGFGcfYw_1747312119
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05F4A1956089; Thu, 15 May 2025 12:28:39 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.242])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2001D19560A7; Thu, 15 May 2025 12:28:34 +0000 (UTC)
Date: Thu, 15 May 2025 14:28:32 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, pbonzini@redhat.com
Subject: Re: [PATCH 02/11] block: move drain outside of read-locked
 bdrv_reopen_queue_child()
Message-ID: <aCXd8MvDPnmKWiRI@redhat.com>
References: <20250508140936.3344485-1-f.ebner@proxmox.com>
 <20250508140936.3344485-3-f.ebner@proxmox.com>
 <aCTGceRCQ4bywHx5@redhat.com>
 <d1d0c8c3-9cba-4916-877b-95ccd718a817@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1d0c8c3-9cba-4916-877b-95ccd718a817@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 15.05.2025 um 13:48 hat Fiona Ebner geschrieben:
> Am 14.05.25 um 18:36 schrieb Kevin Wolf:
> > Am 08.05.2025 um 16:09 hat Fiona Ebner geschrieben:
> >> @@ -4368,6 +4368,7 @@ bdrv_reopen_queue_child(BlockReopenQueue *bs_queue, BlockDriverState *bs,
> >>                          bool keep_old_opts)
> >>  {
> >>      assert(bs != NULL);
> >> +    assert(qatomic_read(&bs->quiesce_counter) > 0);
> > 
> > BlockDriverState.quiesce_counter isn't accessed with atomics elsewhere.
> > Did you confuse it with BlockBackend.quiesce_counter?
> 
> No, but I saw that it is modified via qatomic_fetch_inc/dec(). And those
> modifications are in bdrv_do_drained_begin/end() which are
> IO_OR_GS_CODE(). So isn't it more correct to read via atomics here?

Aha, I missed these two places. Looks like Paolo's commit 414c2ec wasn't
very thorough with converting.

The commit message is also empty, so I don't know why we made this
change. Both places are GLOBAL_STATE_CODE(), so I don't think we
actually need atomics to synchronise these two places. Maybe there are
other accesses in iothreads, but then those should have been using
atomics, too.

> The documentation in include/block/block_int-common.h for struct
> BlockDriverState also states:
> >     /* Accessed with atomic ops.  */
> >     int quiesce_counter;
> 
> Should I rather add a patch to have the other readers use atomics too?

Either all accesses should use atomics or none of them. I'm not
completely sure which way is the right one. Using atomics everywhere is
the safe option, but I'm not sure if we ever access quiesce_counter
outside of the main thread.

Kevin


