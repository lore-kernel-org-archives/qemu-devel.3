Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEC8CEE33B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 17:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLPAH-00052n-0V; Tue, 18 Nov 2025 12:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLPA2-0004vS-7b
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:06:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLPA0-0005Qp-RR
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763485592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RncDYIpVlhLpbxGgZkHOP1Sm95B3QGelYVHAs+SCxGw=;
 b=U53+eagLWP92SJXcAWNLg1RABL///5LQvwszsXNNqii0qiijWXjZqkx+mhmkuZ3oL/NVpq
 LmqmPzN3xu4m4sDnXJ1OoreejXNKyQD6k9mhlOlNGdOLy+n9Lywu8dIdVUXBUf/z4QZX6x
 2eZ/zhnsI7EOG2Gr9HadkC5vn7hGR1U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-wD50bmQxP6eOr_BW-5IFSA-1; Tue,
 18 Nov 2025 12:06:26 -0500
X-MC-Unique: wD50bmQxP6eOr_BW-5IFSA-1
X-Mimecast-MFC-AGG-ID: wD50bmQxP6eOr_BW-5IFSA_1763485584
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5575191B4C5; Tue, 18 Nov 2025 17:06:23 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70669300ABB1; Tue, 18 Nov 2025 17:06:19 +0000 (UTC)
Date: Tue, 18 Nov 2025 18:06:16 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: Re: [PATCH v2 12/19] qcow2: Fix cache_clean_timer
Message-ID: <aRyniMgeFyZMcU6q@redhat.com>
References: <20251110154854.151484-1-hreitz@redhat.com>
 <20251110154854.151484-13-hreitz@redhat.com>
 <aRs2OSuFy0HyW4EU@redhat.com>
 <7a3dc3f2-cded-4e2f-a914-938acd52576f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a3dc3f2-cded-4e2f-a914-938acd52576f@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 18.11.2025 um 12:01 hat Hanna Czenczek geschrieben:
> On 17.11.25 15:50, Kevin Wolf wrote:
> > Am 10.11.2025 um 16:48 hat Hanna Czenczek geschrieben:
> > > +/* s_locked specifies whether s->lock is held or not */
> > >   static void qcow2_update_options_commit(BlockDriverState *bs,
> > > -                                        Qcow2ReopenState *r)
> > > +                                        Qcow2ReopenState *r,
> > > +                                        bool s_locked)
> > >   {
> > >       BDRVQcow2State *s = bs->opaque;
> > >       int i;
> > > +    /*
> > > +     * We need to stop the cache-clean-timer before destroying the metadata
> > > +     * table caches
> > > +     */
> > > +    if (s_locked) {
> > > +        cache_clean_timer_co_locked_del_and_wait(bs);
> > > +    } else {
> > > +        cache_clean_timer_del_and_wait(bs);
> > > +    }
> > > +
> > >       if (s->l2_table_cache) {
> > >           qcow2_cache_destroy(s->l2_table_cache);
> > >       }
> > > @@ -1228,6 +1312,10 @@ static void qcow2_update_options_commit(BlockDriverState *bs,
> > >       }
> > >       s->l2_table_cache = r->l2_table_cache;
> > >       s->refcount_block_cache = r->refcount_block_cache;
> > > +
> > > +    s->cache_clean_interval = r->cache_clean_interval;
> > > +    cache_clean_timer_init(bs, bdrv_get_aio_context(bs));
> > > +
> > >       s->l2_slice_size = r->l2_slice_size;
> > >       s->overlap_check = r->overlap_check;
> > > @@ -1239,12 +1327,6 @@ static void qcow2_update_options_commit(BlockDriverState *bs,
> > >       s->discard_no_unref = r->discard_no_unref;
> > > -    if (s->cache_clean_interval != r->cache_clean_interval) {
> > > -        cache_clean_timer_del(bs);
> > > -        s->cache_clean_interval = r->cache_clean_interval;
> > > -        cache_clean_timer_init(bs, bdrv_get_aio_context(bs));
> > > -    }
> > > -
> > >       qapi_free_QCryptoBlockOpenOptions(s->crypto_opts);
> > >       s->crypto_opts = r->crypto_opts;
> > >   }
> > Is there any specific reason why you move cache_clean_timer_init()
> > earlier? I don't see an actual problem with the code as it is after this
> > change, but s->l2_slice_size is related to the cache in a way, so it
> > would feel safer if the cache cleaner were only started once all the
> > settings are updated and not only those that it actually happens to
> > access at the moment.
> 
> Oh.  I don’t think there’s a good reason.  I think it makes sense to keep
> the set-up in the old place.  Can you do that in your tree?

Yes, I changed it back and applied the series to my block branch.
Thanks.

Kevin


