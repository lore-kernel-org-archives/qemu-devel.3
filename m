Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81904C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfL6I-0002QK-JP; Tue, 04 Feb 2025 10:44:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tfL6G-0002Pp-8p
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:44:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tfL6E-0007m2-GR
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738683869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z9PdtwGwx3W+jYp868OHH3hOPHHg7d+MnWubXfQKzPc=;
 b=ADW12jdjwae+9c7//ZmCjCqyheRaPzRiLpK0CTRiB0bOafg+5MS1HhQZw0mgO6lS1plZ6D
 wgFro7ZO34PyWLUnBAecAIL8K+QrO0tD3w41y1ufy0IZJAAoyJkIUopA4qjVc+stL2fZ9d
 TPGfhnM0VZRphl8ZhDxraMjEVTIy7A4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-_qJqFZb0PYODbPhJiXg0AQ-1; Tue,
 04 Feb 2025 10:44:26 -0500
X-MC-Unique: _qJqFZb0PYODbPhJiXg0AQ-1
X-Mimecast-MFC-AGG-ID: _qJqFZb0PYODbPhJiXg0AQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 019221955D80; Tue,  4 Feb 2025 15:44:25 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.100])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47CD0180035E; Tue,  4 Feb 2025 15:44:21 +0000 (UTC)
Date: Tue, 4 Feb 2025 16:44:18 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, stefanha@redhat.com,
 pkrempa@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 11/15] block/export: Add option to allow export of
 inactive nodes
Message-ID: <Z6I10ir9-ZE3PAyY@redhat.com>
References: <20250130171240.286878-1-kwolf@redhat.com>
 <20250131095051.49708-2-kwolf@redhat.com> <87a5b7gkwu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5b7gkwu.fsf@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 31.01.2025 um 14:41 hat Fabiano Rosas geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Add an option in BlockExportOptions to allow creating an export on an
> > inactive node without activating the node. This mode needs to be
> > explicitly supported by the export type (so that it doesn't perform any
> > operations that are forbidden for inactive nodes), so this patch alone
> > doesn't allow this option to be successfully used yet.
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>

> > diff --git a/block.c b/block.c
> > index 61e131e71f..7eeb8d076e 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -6845,6 +6845,10 @@ void bdrv_init_with_whitelist(void)
> >      bdrv_init();
> >  }
> >  
> > +bool bdrv_is_inactive(BlockDriverState *bs) {
> > +    return bs->open_flags & BDRV_O_INACTIVE;
> > +}
> 
> This function is needed by patch 1/15.

Thanks, I'll move it there.

Kevin


