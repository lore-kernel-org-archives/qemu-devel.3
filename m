Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FFDC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 11:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEo2Z-0008HX-T0; Tue, 13 May 2025 07:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uEo2U-0008H1-Rt
 for qemu-devel@nongnu.org; Tue, 13 May 2025 07:43:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uEo2S-0001cn-GZ
 for qemu-devel@nongnu.org; Tue, 13 May 2025 07:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747136588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s28FGZwgRTEDsF/EUnSQEYSIBYXiYMvjc8Z9uzo1taA=;
 b=DaRMgy/o5ghIDc+1QSQHw7OhdimWu71wdKz17Y2ztfYlUMP6fkPffkijy2cXZZEKVwyn19
 w/4U1dc36PnB6PoJkXtkiPu0x/Bcc+0pgy+WSFX9YFh+RfU8LiWPvl6PXwvr50KpyylVhq
 Nb2ISZioWR0Ds3IqdiV5DazKgLRtA7o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-uzPWg0JdPp6SlRr4f8wA5g-1; Tue,
 13 May 2025 07:43:07 -0400
X-MC-Unique: uzPWg0JdPp6SlRr4f8wA5g-1
X-Mimecast-MFC-AGG-ID: uzPWg0JdPp6SlRr4f8wA5g_1747136586
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A3F21800771; Tue, 13 May 2025 11:43:05 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.238])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A79B31801490; Tue, 13 May 2025 11:43:01 +0000 (UTC)
Date: Tue, 13 May 2025 13:42:58 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pbonzini@redhat.com,
 stefanha@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH for-10.0] scsi-disk: Apply error policy for host_status
 errors again
Message-ID: <aCMwQq5eXE4Djjx4@redhat.com>
References: <20250407155949.44736-1-kwolf@redhat.com>
 <eebcf38d-6375-4456-9fa1-949cef6b0557@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eebcf38d-6375-4456-9fa1-949cef6b0557@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

Am 12.05.2025 um 11:23 hat Michael Tokarev geschrieben:
> On 07.04.2025 18:59, Kevin Wolf wrote:
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
> Ping? Is this change still needed for 10.0 (or for master)?

This was already merged for 10.0 as commit 61b6d9b7.

Kevin


