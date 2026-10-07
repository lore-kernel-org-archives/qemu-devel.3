Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9756CCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 12:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEQL8-0005N2-Mx; Wed, 07 Oct 2026 08:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEQKu-0005J5-K1
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 08:01:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEQKs-0000R7-HW
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 08:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791374485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jDUY8dDIs7xQ4RAtbcMhXoIQSnAy+07tglDTGDuyhlE=;
 b=Cj175Qkd06ayGawoNjTyEtgbjAS9AwA6sYj2hnrVDWVa+Yh0O7giuGOiC4wf9lMl3UrGnE
 eogfJhckCNasaAAaabUmprrFrxii7RApzLujNTH199h8cvkQCkcvhVkqXrzwtVg7ridSj+
 apXTg2lI6FqAswLmvFAHi6fvQrpZn+E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-fEyQK68XMKKPuyRcsW0B0Q-1; Wed,
 7 Oct 2026 12:01:23 +0000
X-MC-Unique: fEyQK68XMKKPuyRcsW0B0Q-1
X-Mimecast-MFC-AGG-ID: fEyQK68XMKKPuyRcsW0B0Q_1791374482
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 745CE1801313; Wed,  7 Oct 2026 12:01:21 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C3EF766; Wed,  7 Oct 2026 12:01:17 +0000 (UTC)
Date: Wed, 7 Oct 2026 07:01:14 -0500
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v2 2/3] migration/block-dirty-bitmap: fix postcopy abort
 with bitmaps on several nodes
Message-ID: <asYzgmzKbr0ZxlXt@redhat.com>
References: <20261006170738.453977-1-den@openvz.org>
 <20261006170738.453977-3-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006170738.453977-3-den@openvz.org>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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

On Tue, Oct 06, 2026 at 07:07:37PM +0200, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> With dirty bitmaps on more than one node, the source switches nodes
> during the postcopy bulk phase and sends the node name again. The
> destination reads those chunks in the postcopy listen thread, which does
> not hold the BQL, and resolves the name through bdrv_lookup_bs():
> 
>   qemu-system-x86_64: ../block.c:6400: bdrv_lookup_bs: Assertion
>   `qemu_in_main_thread()' failed.
> 
> The bdrv_find_dirty_bitmap() call right after it needs the BQL or the
> dirty bitmap lock as well. Taking the BQL there would deadlock: the
> listen thread holds s->lock, and dirty_bitmap_mig_before_vm_start()
> takes s->lock with the BQL held.
> 
> Every node and bitmap that a non-START chunk refers to was set up by a
> START chunk, and those are loaded under the BQL during setup. Record the
> node alias there, and resolve all other chunks against s->bitmaps
> instead of the block graph.
> 
> Bitmaps on a single node never resend the node name after setup, which
> is why migrate-bitmaps-postcopy-test does not catch this.
> 
> Fixes: f791bf7f93f2 ("assertions for block global state API")
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Cc: qemu-stable@nongnu.org
> ---
>  migration/block-dirty-bitmap.c | 58 +++++++++++++++++++++++++++++++---
>  1 file changed, 54 insertions(+), 4 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


