Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263A2C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 13:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiCYe-0003oc-Lu; Wed, 12 Feb 2025 08:13:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tiCYY-0003nE-CG
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 08:13:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tiCYW-0001lU-8M
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 08:13:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739366011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xqqK5cdIvGLUJUMzoyAJoVATsVehHhV57gBFzsVJkZQ=;
 b=WlHlg8raSidao3Sw/J+bqoFUJ3MQusmm582bq5ULr9LUQKirAiy2yhuInkO+w5T5xY1B3Y
 oGm/S0TQSBu3ETv0s+t8vqSnmMK1G1LpK/sq5PtgJpeFfq7WIcMOAkaihXDqf/mwsxfGUJ
 zZvjSKZV8y7GVk34rcfkiI1jd7puiTI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-w44MsOc3M128k9dpPcevMw-1; Wed,
 12 Feb 2025 08:13:28 -0500
X-MC-Unique: w44MsOc3M128k9dpPcevMw-1
X-Mimecast-MFC-AGG-ID: w44MsOc3M128k9dpPcevMw_1739366007
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EABF1800875; Wed, 12 Feb 2025 13:13:27 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.168])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AF1C1800570; Wed, 12 Feb 2025 13:13:24 +0000 (UTC)
Date: Wed, 12 Feb 2025 14:13:22 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com,
 manos.pitsidianakis@linaro.org, qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 03/11] rust: Add some block layer bindings
Message-ID: <Z6yecuOmtQKYUwLj@redhat.com>
References: <20250211214328.640374-1-kwolf@redhat.com>
 <20250211214328.640374-4-kwolf@redhat.com>
 <b7b2ab97-acd3-4008-abd6-3da874541113@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7b2ab97-acd3-4008-abd6-3da874541113@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
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

Am 12.02.2025 um 10:29 hat Paolo Bonzini geschrieben:
> On 2/11/25 22:43, Kevin Wolf wrote:
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   rust/wrapper.h                | 4 ++++
> >   meson.build                   | 1 +
> >   rust/qemu-api/src/zeroable.rs | 5 +++--
> >   3 files changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/rust/wrapper.h b/rust/wrapper.h
> > index 41be87adcf..c3e1e6f9cf 100644
> > --- a/rust/wrapper.h
> > +++ b/rust/wrapper.h
> > @@ -53,3 +53,7 @@ typedef enum memory_order {
> >   #include "chardev/char-fe.h"
> >   #include "qapi/error.h"
> >   #include "chardev/char-serial.h"
> > +#include "block/block.h"
> > +#include "block/block_int.h"
> > +#include "block/qdict.h"
> > +#include "qapi/qapi-visit-block-core.h"
> > diff --git a/meson.build b/meson.build
> > index 30aae6b3c3..154195bc80 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -4045,6 +4045,7 @@ if have_rust
> >       '--with-derive-default',
> >       '--no-layout-tests',
> >       '--no-prepend-enum-name',
> > +    '--allowlist-item', 'EINVAL|EIO',
> 
> I've got some errno bindings that I wrote for chardev, I'll send them
> shortly.

Yes, we definitely need some proper bindings there. I'm already tired of
writing things like this:

    return -(bindings::EINVAL as std::os::raw::c_int)

Or even:

    return e
        .raw_os_error()
        .unwrap_or(-(bindings::EIO as std::os::raw::c_int))

Which actually already shows that your errno binding patch does the
opposite direction of what I needed in this series. My problem is when I
need to return an int to C, and I either have an io::Result or I just
want to directly return an errno value. So we'll have to add that part
to your errno module, too.

Kevin


