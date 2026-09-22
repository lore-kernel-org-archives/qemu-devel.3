Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E8FC982FF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8zym-00008n-F3; Tue, 22 Sep 2026 08:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x8zyi-00008I-2E
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 08:52:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x8zyg-00032o-EY
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 08:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790081524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h3oFneLy/QFXVPjXfu21kGv/DwOHjnRXOaITVXNLM4k=;
 b=Oa3iSNg2JCvr4ZsMXeDbUr0NDFzFuD5ZxhgpwtQHKgxuwUc9Y4ph94c5Ft1pxWHJCSvsK0
 HvPDelLDTv5mGyStnaRpJguVvo2yZ//Dy4O+hljCxmDZB8+9CIpJgq+NjW6he0oTkA7Jdr
 wB9GBsi9umkcl6mOfFoAebGWdbKvz+o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-a6LOw0kBN_ewhNmuY3Dg9Q-1; Tue,
 22 Sep 2026 08:52:01 -0400
X-MC-Unique: a6LOw0kBN_ewhNmuY3Dg9Q-1
X-Mimecast-MFC-AGG-ID: a6LOw0kBN_ewhNmuY3Dg9Q_1790081520
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2992619540D5; Tue, 22 Sep 2026 12:52:00 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.148])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C694195604E; Tue, 22 Sep 2026 12:51:56 +0000 (UTC)
Date: Tue, 22 Sep 2026 14:51:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 7/9] block: Add delay-alert-ms property
Message-ID: <arJ56iwQ0TdpvH3A@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260831135206.126184-8-hreitz@redhat.com>
 <20260903143055.GE825275@fedora>
 <cc6bfc83-457e-40c3-a263-0cde3c65f5d3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc6bfc83-457e-40c3-a263-0cde3c65f5d3@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

Am 16.09.2026 um 10:17 hat Hanna Czenczek geschrieben:
> On 03.09.26 16:30, Stefan Hajnoczi wrote:
> > On Mon, Aug 31, 2026 at 03:52:03PM +0200, Hanna Czenczek wrote:
> > > This device property allows setting up an I/O latency threshold for when
> > > to emit a delay QMP event.
> > > 
> > > Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> > > ---
> > >   include/hw/block/block.h   |  5 ++++-
> > >   blockdev.c                 | 16 +++++++++++++++-
> > >   hw/block/block.c           |  4 +++-
> > >   tests/qemu-iotests/172.out | 38 ++++++++++++++++++++++++++++++++++++++
> > >   4 files changed, 60 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/hw/block/block.h b/include/hw/block/block.h
> > > index df941df19f2..e7e401dd303 100644
> > > --- a/include/hw/block/block.h
> > > +++ b/include/hw/block/block.h
> > > @@ -36,6 +36,7 @@ typedef struct BlockConf {
> > >       BlockdevOnError werror;
> > >       uint32_t num_stats_intervals;
> > >       uint32_t *stats_intervals;
> > > +    uint32_t delay_alert_ms;
> > >   } BlockConf;
> > >   static inline unsigned int get_physical_block_exp(BlockConf *conf)
> > > @@ -83,7 +84,9 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
> > >                               _conf.account_failed, ON_OFF_AUTO_AUTO),    \
> > >       DEFINE_PROP_ARRAY("stats-intervals", _state,                        \
> > >                        _conf.num_stats_intervals, _conf.stats_intervals,  \
> > > -                     qdev_prop_uint32, uint32_t)
> > > +                     qdev_prop_uint32, uint32_t),                       \
> > > +    DEFINE_PROP_UINT32("delay-alert-ms", _state, _conf.delay_alert_ms,  \
> > > +                       0)                                               \
> > The latency histogram feature uses nanoseconds (64-bit integer) whereas
> > this patch series uses delay-alert-ms (uint32) and a double
> > floating-point seconds value in the QMP event. Maybe stick to 64-bit
> > integer nanoseconds everywhere for consistency?
> 
> I don’t have technical objections because doing so is easy, of course.
> Personally, I found nanoseconds really unwieldy to specify here. But I
> suppose if @block-latency-histogram-set does the same, then I might as well.

I don't expect this to be used much by human users, and for a machine
interface, what makes things unwieldy is having to keep track of which
value has which unit instead of just sticking to one unit everywhere.

I had the same comment before seeing that Stefan already pointed it out.

Kevin


