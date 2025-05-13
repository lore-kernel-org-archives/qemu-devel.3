Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5A9C3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 11:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEoCX-0002gz-OY; Tue, 13 May 2025 07:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uEoCR-0002g9-TH
 for qemu-devel@nongnu.org; Tue, 13 May 2025 07:53:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uEoCM-0002mY-Nk
 for qemu-devel@nongnu.org; Tue, 13 May 2025 07:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747137206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/94r+WJeYUUknTePwBFL+ppxLx10IHiKfKu3Xjt1bo0=;
 b=Bs9puMqCHOiDQZhmZ/gpbkDDk38eBvuuD0dMQIZYob3w7NvZWGkY2qZG35h2tPEK4wQQjT
 jJJ4naQ6DTiZ5l5IH4iwTaaAzbiI2bu8+Hlu2IIelGw+7Zbx22GOOo+t5v6PmMMKmb/jmW
 wgCklElRRc+ebNXf/9Gp3Qu27MhGCrc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164--9FBZO6fPje7lleXO43Rtg-1; Tue,
 13 May 2025 07:53:23 -0400
X-MC-Unique: -9FBZO6fPje7lleXO43Rtg-1
X-Mimecast-MFC-AGG-ID: -9FBZO6fPje7lleXO43Rtg_1747137202
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FA21180045C; Tue, 13 May 2025 11:53:21 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.238])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D1231955F67; Tue, 13 May 2025 11:53:18 +0000 (UTC)
Date: Tue, 13 May 2025 13:53:15 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pbonzini@redhat.com,
 stefanha@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH for-10.0] scsi-disk: Apply error policy for host_status
 errors again
Message-ID: <aCMyqz9diQHcPR5R@redhat.com>
References: <20250407155949.44736-1-kwolf@redhat.com>
 <76bc1c49-43cb-445e-98e2-2f75c53623b8@tls.msk.ru>
 <Z_fENT4Te_hUTOT-@redhat.com>
 <a2ec9fe4-c25f-4610-a1da-fe87817fe9f2@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2ec9fe4-c25f-4610-a1da-fe87817fe9f2@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
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

Am 10.04.2025 um 15:33 hat Michael Tokarev geschrieben:
> 10.04.2025 16:14, Kevin Wolf wrote:
> > Am 10.04.2025 um 14:37 hat Michael Tokarev geschrieben:
> ...>> Does it make sense to apply this one for older stable qemu series?
> > > In particular, in 8.2, we lack cfe0880835cd3
> > > "scsi-disk: Use positive return value for status in dma_readv/writev",
> > > which seems to be relevant here.  Or should I pick up cfe0880835cd3 too,
> > > maybe together with 8a0495624f (a no-op, just to make this patch to apply
> > > cleanly) and probably 9da6bd39f924?
> > 
> > Yes, I think it makes sense to pick all of them up (and 622a7016 in the
> > middle, too), they were part of one series:
> > 
> > https://patchew.org/QEMU/20240731123207.27636-1-kwolf@redhat.com/
> > 
> > And this patch builds on top of that series, so rebasing it correctly
> > might not be trivial without the previous series.
> 
> A (most likely small) issue here: 622a70161a "scsi-block: Don't skip
> callback for sgio error status/driver_status" is on top of an earlier
> commit, 1404226804 "scsi: don't lock AioContext in I/O code path",
> but does not actually *require* it, since it removes whole code block
> where a locking has been removed earlier by 1404226804.

Right, a backport should just remove the locking with it. That seems to
be a trivial conflict resolution.

> Also the next comment commit, 8a0495624f "scsi-disk: Add warning comments
> that host_status errors take a shortcut", clashes with e7fc3c4a8cc "scsi:
> remove outdated AioContext lock comment".

It's only comments anyway, but the correct conflict resolution here is
to keep both comments.

> This seems a bit too fragile for 8.2, don't you think?  And I haven't even
> tried to check 7.2 yet :)

Both of the merge conflicts you mentioned above don't really seem like
problems to me. Did you find any semantic merge conflicts? That's when I
would start to be concerned about fragility.

> https://gitlab.com/mjt0k/qemu/-/tree/staging-8.2 for the current result
> (not yet tested) - I dislike my comment handling at scsi_dma_complete().

Seems you already resolved the conflicts the same was as I suggested
above.

Kevin


