Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CCFC3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 13:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2rk6-0002Ms-3P; Thu, 10 Apr 2025 09:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u2rjz-0002Fo-WC
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 09:14:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u2rjw-00069d-CD
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 09:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744290882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iR/97DDpxJft+AjUu2NrgfhEkSg1nwOu4xLUAZ3SJqE=;
 b=hZGIQfEtl510pml+v/V+XRZ5s+jGyvMkJlFcHyS59H0NgPd8j0+9BQ4+NYjuqHY8L/e9m6
 h5BbyZv07/fUMRpRn0NpNCV2CpKsgW00AZJ6kAhb2sWKuKWku5pppbEepmNwF3RM/wcLlQ
 xxp7inE0Ek0turexkNeNIUyVaf3m3os=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-FqRlt-WuPFqKNyRqEIV4Vg-1; Thu,
 10 Apr 2025 09:14:38 -0400
X-MC-Unique: FqRlt-WuPFqKNyRqEIV4Vg-1
X-Mimecast-MFC-AGG-ID: FqRlt-WuPFqKNyRqEIV4Vg_1744290877
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E8F018007E1; Thu, 10 Apr 2025 13:14:35 +0000 (UTC)
Received: from redhat.com (dhcp-192-195.str.redhat.com [10.33.192.195])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 248CC195DF86; Thu, 10 Apr 2025 13:14:31 +0000 (UTC)
Date: Thu, 10 Apr 2025 15:14:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pbonzini@redhat.com,
 stefanha@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH for-10.0] scsi-disk: Apply error policy for host_status
 errors again
Message-ID: <Z_fENT4Te_hUTOT-@redhat.com>
References: <20250407155949.44736-1-kwolf@redhat.com>
 <76bc1c49-43cb-445e-98e2-2f75c53623b8@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76bc1c49-43cb-445e-98e2-2f75c53623b8@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 10.04.2025 um 14:37 hat Michael Tokarev geschrieben:
> 07.04.2025 18:59, Kevin Wolf пишет:
> > Originally, all failed SG_IO requests called scsi_handle_rw_error() to
> > apply the configured error policy. However, commit f3126d65, which was
> > supposed to be a mere refactoring for scsi-disk.c, broke this and
> > accidentally completed the SCSI request without considering the error
> > policy any more if the error was signalled in the host_status field.
> > 
> > Apart from the commit message not describing the chance as intended,
> > errors indicated in host_status are also obviously backend errors and
> > not something the guest must deal with indepdently of the error policy.
> > 
> > This behaviour means that some recoverable errors (such as a path error
> > in multipath configurations) were reported to the guest anyway, which
> > might not expect it and might consider its disk broken.
> > 
> > Make sure that we apply the error policy again for host_status errors,
> > too. This addresses an existing FIXME comment and allows us to remove
> > some comments warning that callbacks weren't always called. With this
> > fix, they are called in all cases again.
> > 
> > The return value passed to the request callback doesn't have more free
> > values that could be used to indicate host_status errors as well as SAM
> > status codes and negative errno. Store the value in the host_status
> > field of the SCSIRequest instead and use -ENODEV as the return value (if
> > a path hasn't been reachable for a while, blk_aio_ioctl() will return
> > -ENODEV instead of just setting host_status, so just reuse it here -
> > it's not necessarily entirely accurate, but it's as good as any errno).
> > 
> > Cc: qemu-stable@nongnu.org
> > Fixes: f3126d65b393 ('scsi: move host_status handling into SCSI drivers')
> 
> Does it make sense to apply this one for older stable qemu series?
> In particular, in 8.2, we lack cfe0880835cd3
> "scsi-disk: Use positive return value for status in dma_readv/writev",
> which seems to be relevant here.  Or should I pick up cfe0880835cd3 too,
> maybe together with 8a0495624f (a no-op, just to make this patch to apply
> cleanly) and probably 9da6bd39f924?

Yes, I think it makes sense to pick all of them up (and 622a7016 in the
middle, too), they were part of one series:

https://patchew.org/QEMU/20240731123207.27636-1-kwolf@redhat.com/

And this patch builds on top of that series, so rebasing it correctly
might not be trivial without the previous series.

Kevin


