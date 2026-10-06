Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F050FCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENAB-0002fH-2z; Wed, 07 Oct 2026 04:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEIA7-0001yZ-Cl
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:18:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEI9r-0002jj-7P
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791343021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n2461GAjs7aIWpFWJ6R/RZP0oiSJGsU9amOc1G03hAU=;
 b=GbYjLw2JUWVzzZXlPfT5g5BWmbgKPMdmL0XhlFHANY566KGc4kVxwCshCWo91/Qoil0Fy3
 2jzeQho6NUf9XnRtT+GV7BHvGNUtHvDqvvTzMBckX+GR+eyx15a77jdB5m6Wh5MKbyBwAp
 Nnq8k6iTh6g/OhqF197negWOqywOX9c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-Mmms7Sv5MD6K02RxcQlzEg-1; Tue,
 06 Oct 2026 15:13:23 -0400
X-MC-Unique: Mmms7Sv5MD6K02RxcQlzEg-1
X-Mimecast-MFC-AGG-ID: Mmms7Sv5MD6K02RxcQlzEg_1791314002
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68F3318333E1; Tue,  6 Oct 2026 19:13:21 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43B981956087; Tue,  6 Oct 2026 19:13:19 +0000 (UTC)
Date: Tue, 6 Oct 2026 14:13:16 -0500
From: Eric Blake <eblake@redhat.com>
To: guillaume vincke <guillaume.vincke@ovhcloud.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 1/2] nbd/client-connection: Fix client returning a closed
 channel
Message-ID: <asVIFdF-xYwkJ3R8@redhat.com>
References: <20260925155346.357703-1-guillaume.vincke@ovhcloud.com>
 <20260925155346.357703-2-guillaume.vincke@ovhcloud.com>
 <arbf-WK4eJCeNX35@redhat.com>
 <19b7e322-f98b-4059-ae5e-95b2bdfe0c0c@ovhcloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19b7e322-f98b-4059-ae5e-95b2bdfe0c0c@ovhcloud.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 28, 2026 at 10:23:49AM +0200, guillaume vincke wrote:
> > > +static bool nbd_channel_is_closed(QIOChannel *ioc)
> > > +{
> > > +    char data;
> > > +    struct iovec iov = { .iov_base = &data, .iov_len = 1 };
> > > +    ssize_t len = -1;
> > > +
> > > +    if (!qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
> > > +        return false;
> > > +    }
> > > +
> > > +    len = qio_channel_readv_full(
> > > +        ioc, &iov, 1, NULL, NULL, QIO_CHANNEL_READ_FLAG_MSG_PEEK, NULL);
> > > +
> > > +    if (len == 0 || (len < 0 && len != QIO_CHANNEL_ERR_BLOCK)) {
> > > +        return true;
> > > +    }
> > > +    return false;
> > 
> > The last group could be shortened to:
> > 
> >     return len == 0 || (len < 0 && len != QIO_CHANNEL_ERR_BLOCK);
> 
> Thanks, I will make sure to include those changes in v2 once patch 2/2
> is reviewed, to avoid a new submission for these alone.

The changes turned out small enough, and I want to get a bundle of
pending patches merged, so I want ahead and made the minor changes and
included this on my NBD queue.

> 
> > 
> > but that is not mandatory.
> > 
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


