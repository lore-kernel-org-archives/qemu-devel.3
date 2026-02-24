Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECF5E9B268
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 13:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vusvk-0003J7-5Y; Tue, 24 Feb 2026 08:58:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vusvf-0003FC-D1
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 08:58:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vusvb-0001ac-K9
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 08:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771941498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oc+ETJhZzxHkefH8QE/EDwHZuA0yT7j1kWEpHF/4sqc=;
 b=PzI82TJlecYRcPsFUs/skVWYgi5tnyOZsrYi0kEyrxmxOZSlZFGBqndoXOcExgTjrKGVmc
 1u0mE3GGSxawfpnpKX/oR42hIvI/JZ8AFbUfw3+pIAuojMu+hn+CUxWkHmY/hzI/9lkhPk
 S1cZx7qXM9CrDDK0+lx4ydGmpBCZd3k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-hM_8XKqmNmaAlZDNFGdziA-1; Tue,
 24 Feb 2026 08:58:14 -0500
X-MC-Unique: hM_8XKqmNmaAlZDNFGdziA-1
X-Mimecast-MFC-AGG-ID: hM_8XKqmNmaAlZDNFGdziA_1771941492
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF42319560A6; Tue, 24 Feb 2026 13:58:11 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.66])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD3D419560A2; Tue, 24 Feb 2026 13:58:08 +0000 (UTC)
Date: Tue, 24 Feb 2026 14:58:06 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, jean-louis@dupond.be, dionbosschieter@gmail.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] mirror: Fix missed dirty bitmap writes during startup
Message-ID: <aZ2ubi7GsYmGmcl2@redhat.com>
References: <20260219202446.312493-1-kwolf@redhat.com>
 <46ff60a0-56c7-49f0-ae8f-6a26504409b9@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46ff60a0-56c7-49f0-ae8f-6a26504409b9@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 20.02.2026 um 15:00 hat Fiona Ebner geschrieben:
> Am 19.02.26 um 9:25 PM schrieb Kevin Wolf:
> > @@ -1672,9 +1673,9 @@ bdrv_mirror_top_do_write(BlockDriverState *bs, MirrorMethod method,
> >          abort();
> >      }
> >  
> > -    if (!copy_to_target && s->job && s->job->dirty_bitmap) {
> > +    if (!copy_to_target) {
> >          qatomic_set(&s->job->actively_synced, false);
> 
> Here, we must check that s->job is set for the qatomic_set().
> 
> Other than that, the patch looks good to me, thanks!

Thanks, good catch. I'm squashing in this change:

diff --git a/block/mirror.c b/block/mirror.c
index abdffc6de86..fa1d975eb9f 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1677,7 +1677,9 @@ bdrv_mirror_top_do_write(BlockDriverState *bs, MirrorMethod method,
     }

     if (!copy_to_target) {
-        qatomic_set(&s->job->actively_synced, false);
+        if (s->job) {
+            qatomic_set(&s->job->actively_synced, false);
+        }
         bdrv_set_dirty_bitmap(s->dirty_bitmap, offset, bytes);
     }

Can I add your R-b with this?

Jean-Louis, do you want to give this patch a test if it still fixes your
problem? The approach is a bit different from what we tried initially.

Kevin


