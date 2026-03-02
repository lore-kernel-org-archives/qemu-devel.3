Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9DFE9B37D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 13:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx35S-0005nq-2c; Mon, 02 Mar 2026 08:13:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vx35Q-0005jW-D5
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 08:13:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vx35O-0004En-CY
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 08:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772457199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UYqOn1OhepshI0sLeLrPBQ/QLEEnX03LO1VASK8sac0=;
 b=YnddNCv1mI1rbJJWpxQMB6nZLXH4QzOsHwSXhVynnMQjbQtT0N5AAqXdu5mFgmWAJZOcu+
 83W84J9KJopelMGif7KZGAs2a0JCd1rTpMgTT5+wJJAyqsU1QdLNYyqiBvg3vk+LkdBd9V
 cCRA/25Nt8lMdYMddF3kNYOX2cn8QGc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-9A3Jb2z_NC6xdyzkk52S0A-1; Mon,
 02 Mar 2026 08:13:14 -0500
X-MC-Unique: 9A3Jb2z_NC6xdyzkk52S0A-1
X-Mimecast-MFC-AGG-ID: 9A3Jb2z_NC6xdyzkk52S0A_1772457192
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2549A19775ED; Mon,  2 Mar 2026 13:13:09 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.198])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E4FA3000223; Mon,  2 Mar 2026 13:13:03 +0000 (UTC)
Date: Mon, 2 Mar 2026 14:13:00 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Jean-Louis Dupond <jean-louis@dupond.be>
Cc: Fiona Ebner <f.ebner@proxmox.com>, qemu-block@nongnu.org,
 hreitz@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com,
 dionbosschieter@gmail.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] mirror: Fix missed dirty bitmap writes during startup
Message-ID: <aaWM3DI5ISFPFrZ0@redhat.com>
References: <20260219202446.312493-1-kwolf@redhat.com>
 <46ff60a0-56c7-49f0-ae8f-6a26504409b9@proxmox.com>
 <aZ2ubi7GsYmGmcl2@redhat.com>
 <c9455331-0b32-47c2-8df4-e106db6d1622@dupond.be>
 <adc4bc7a-2ac3-4e37-8041-fcff77d96e15@dupond.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adc4bc7a-2ac3-4e37-8041-fcff77d96e15@dupond.be>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 02.03.2026 um 10:49 hat Jean-Louis Dupond geschrieben:
> 
> On 25/02/2026 13:32, Jean-Louis Dupond wrote:
> > 
> > On 24/02/2026 14:58, Kevin Wolf wrote:
> > > Am 20.02.2026 um 15:00 hat Fiona Ebner geschrieben:
> > > > Am 19.02.26 um 9:25 PM schrieb Kevin Wolf:
> > > > > @@ -1672,9 +1673,9 @@
> > > > > bdrv_mirror_top_do_write(BlockDriverState *bs, MirrorMethod
> > > > > method,
> > > > >           abort();
> > > > >       }
> > > > >   -    if (!copy_to_target && s->job && s->job->dirty_bitmap) {
> > > > > +    if (!copy_to_target) {
> > > > >           qatomic_set(&s->job->actively_synced, false);
> > > > Here, we must check that s->job is set for the qatomic_set().
> > > > 
> > > > Other than that, the patch looks good to me, thanks!
> > > Thanks, good catch. I'm squashing in this change:
> > > 
> > > diff --git a/block/mirror.c b/block/mirror.c
> > > index abdffc6de86..fa1d975eb9f 100644
> > > --- a/block/mirror.c
> > > +++ b/block/mirror.c
> > > @@ -1677,7 +1677,9 @@ bdrv_mirror_top_do_write(BlockDriverState *bs,
> > > MirrorMethod method,
> > >       }
> > > 
> > >       if (!copy_to_target) {
> > > -        qatomic_set(&s->job->actively_synced, false);
> > > +        if (s->job) {
> > > +            qatomic_set(&s->job->actively_synced, false);
> > > +        }
> > >           bdrv_set_dirty_bitmap(s->dirty_bitmap, offset, bytes);
> > >       }
> > > 
> > > Can I add your R-b with this?
> > > 
> > > Jean-Louis, do you want to give this patch a test if it still fixes your
> > > problem? The approach is a bit different from what we tried initially.
> > We are running our test case for +24hours now without any issue with
> > this patch included.
> > I am currently rebuilding el9 qemu with this patch included to run on
> > our production machines that had this corruption.
> > Let me come back in some days to fully confirm it's also fixed there :)
> Everything stays stable (without corruption), after a lot of servers in
> backup already with the patch.
> So therefor:
> 
> Tested-by: Jean-Louis Dupond <jean-louis@dupond.be>

Great, thanks for your testing!

Kevin


