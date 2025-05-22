Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC74C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 18:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIAvM-0003Us-5Q; Thu, 22 May 2025 14:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uIAvK-0003Qn-8d
 for qemu-devel@nongnu.org; Thu, 22 May 2025 14:45:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uIAvI-00031f-GR
 for qemu-devel@nongnu.org; Thu, 22 May 2025 14:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747939543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gn5KgJ4a6xQOLUCAAw3X5IjxyrDjnw9hm4m+bT3koig=;
 b=LTsiNGQYiVI5GfdvyIXwTbS/uMi6/uM/WpZfhRSqs1FszNwQEmSP4uK/Amk+kjgMRK84QP
 YuWMB8rY3Cye4pxIcYIaZ26RCc0GvjsfovmJnqs/OtRUaFFkCK3YIrbb5YRsPEC2JzgBEi
 Yent7STVfUl7h7XccR2lMEoaqu/9qzk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-33k-cHkfNKOIAIJjWtoZWA-1; Thu,
 22 May 2025 14:45:42 -0400
X-MC-Unique: 33k-cHkfNKOIAIJjWtoZWA-1
X-Mimecast-MFC-AGG-ID: 33k-cHkfNKOIAIJjWtoZWA_1747939541
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0E0C18001EA; Thu, 22 May 2025 18:45:40 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.201])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0570A1956094; Thu, 22 May 2025 18:45:38 +0000 (UTC)
Date: Thu, 22 May 2025 13:45:35 -0500
From: Eric Blake <eblake@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 "Richard W.M. Jones" <rjones@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 4/4] nbd: Enable multi-conn using round-robin
Message-ID: <4sxzmn7ztnmnuc5rvsq7r3gmsdelykb2gea3dfcvzym4au5an4@hwzwkvl2e64x>
References: <20250428185246.492388-6-eblake@redhat.com>
 <20250428185246.492388-10-eblake@redhat.com>
 <faa5559f-2529-4c3a-827d-5350dd3213f2@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faa5559f-2529-4c3a-827d-5350dd3213f2@virtuozzo.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 22, 2025 at 08:37:58PM +0300, Andrey Drobyshev wrote:
> On 4/28/25 9:46 PM, Eric Blake wrote:
> > From: "Richard W.M. Jones" <rjones@redhat.com>
> > 
> > Enable NBD multi-conn by spreading operations across multiple
> > connections.
> > 
> > (XXX) This uses a naive round-robin approach which could be improved.
> > For example we could look at how many requests are in flight and
> > assign operations to the connections with fewest.  Or we could try to
> > estimate (based on size of requests outstanding) the load on each
> > connection.  But this implementation doesn't do any of that.
> > 
> > Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> > Message-ID: <20230309113946.1528247-5-rjones@redhat.com>
> > ---
> >  block/nbd.c | 67 +++++++++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 49 insertions(+), 18 deletions(-)
> > 
> > diff --git a/block/nbd.c b/block/nbd.c
> > index 19da1a7a1fe..bf5bc57569c 100644
> > --- a/block/nbd.c
> > +++ b/block/nbd.c
> > 
> > [...]
> 
> 
> > @@ -2207,24 +2233,29 @@ static const char *const nbd_strong_runtime_opts[] = {
> >  static void nbd_cancel_in_flight(BlockDriverState *bs)
> >  {
> >      BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
> > -    NBDConnState * const cs = s->conns[0];
> > +    size_t i;
> > +    NBDConnState *cs;
> > 
> > -    reconnect_delay_timer_del(cs);
> > +    for (i = 0; i < MAX_MULTI_CONN; ++i) {
> > +        cs = s->conns[i];
> > 
> > -    qemu_mutex_lock(&cs->requests_lock);
> > -    if (cs->state == NBD_CLIENT_CONNECTING_WAIT) {
> > -        cs->state = NBD_CLIENT_CONNECTING_NOWAIT;
> > +        reconnect_delay_timer_del(cs);
> > +
> 
> This code is causing iotests/{185,264,281} to segfault.  E.g.:
> 
> > (gdb) bt
> > #0  0x000055bbaec58119 in reconnect_delay_timer_del (cs=0x0) at ../block/nbd.c:205
> > #1  0x000055bbaec5d8e4 in nbd_cancel_in_flight (bs=0x55bbb1458020) at ../block/nbd.c:2242
> > #2  0x000055bbaec4ff16 in bdrv_cancel_in_flight (bs=0x55bbb1458020) at ../block/io.c:3737
> > #3  0x000055bbaec54ec1 in mirror_cancel (job=0x55bbb21ce800, force=true) at ../block/mirror.c:1335
> > #4  0x000055bbaec18278 in job_cancel_async_locked (job=0x55bbb21ce800, force=true) at ../job.c:893
> > #5  0x000055bbaec18df2 in job_cancel_locked (job=0x55bbb21ce800, force=true) at ../job.c:1143
> > #6  0x000055bbaec18ef3 in job_force_cancel_err_locked (job=0x55bbb21ce800, errp=0x7fff44f247a0) at ../job.c:1190
> > #7  0x000055bbaec192a4 in job_finish_sync_locked (job=0x55bbb21ce800, finish=0x55bbaec18ed2 <job_force_cancel_err_locked>, errp=0x0) at ../job.c:1253
> > #8  0x000055bbaec18f2e in job_cancel_sync_locked (job=0x55bbb21ce800, force=true) at ../job.c:1196
> > #9  0x000055bbaec19086 in job_cancel_sync_all () at ../job.c:1214
> > #10 0x000055bbaed55177 in qemu_cleanup (status=0) at ../system/runstate.c:949
> > #11 0x000055bbaedd0aad in qemu_default_main (opaque=0x0) at ../system/main.c:51
> > #12 0x000055bbaedd0b4f in main (argc=21, argv=0x7fff44f249d8) at ../system/main.c:80
> 
> We're dereferencing a pointer to NBDConnState that was never
> initialized.  So it should either be
> 
> > -    for (i = 0; i < MAX_MULTI_CONN; ++i) {
> > +    for (i = 0; i < s->multi_conn; ++i) {

Thanks for pointing it out; I'll fix that.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


