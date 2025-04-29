Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D66BC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 08:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9gXU-0003sT-Lz; Tue, 29 Apr 2025 04:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u9gXF-0003qz-4d
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 04:41:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u9gXD-0007je-CV
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 04:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745916106;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=KTij0Onsjc9Eu1Z4Zrg0Xuef4ZMXOXJApla19rctPGU=;
 b=JF0mnxkP8lvNDp1HodgyPFiDO7rYCVIzar6vA+KcF2RsXtjA3fvvhC9l/mLVCD7AtTJGfn
 tG61i6Ej8s20JxfRu4yhlkYR98XbS+dkDgfA1py9tIhUZt/nc1+19ta7bwLY0YBPE9gDlg
 GDpQudN9Yp85Qqy3srAYCZXHWfXshlE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-YK2hNHxgP5ep-WHVYA-lOQ-1; Tue,
 29 Apr 2025 04:41:43 -0400
X-MC-Unique: YK2hNHxgP5ep-WHVYA-lOQ-1
X-Mimecast-MFC-AGG-ID: YK2hNHxgP5ep-WHVYA-lOQ_1745916102
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C3AE18001E0; Tue, 29 Apr 2025 08:41:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.98])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF60C180045C; Tue, 29 Apr 2025 08:41:40 +0000 (UTC)
Date: Tue, 29 Apr 2025 09:41:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [RFC PATCH v2 0/4] Revival of patches to implement NBD client
 multi-conn
Message-ID: <aBCQwZ-xfbb5c8Kc@redhat.com>
References: <20250428185246.492388-6-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250428185246.492388-6-eblake@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Apr 28, 2025 at 01:46:43PM -0500, Eric Blake wrote:
> This is a rebase of patches that Rich Jones first posted in 2023:
> https://lists.gnu.org/archive/html/qemu-devel/2023-03/msg03320.html
> 
> I'm still leaving the series in an RFC state while I'm trying to
> improve the code to better play with all of the multi-queue changes in
> the block layer in the meantime.  In my own testing, the patches as
> presented here are not making any noticeable difference in qemu-img
> convert to a local destination file (multi-conn=1 was not much
> different than multi-conn=4, although I did validate that multiple
> sockets were in use and the round robin code was working).  Other
> benchmarks did show improvements, such as qemu convert targeting an
> nbdkit server on a curl backend getting a 20% boost when I ramped
> multi-conn from 1 to 4.
>
> I have more patches on top of these to post to the list once I can get
> benchmark numbers that make more sense.

I'm curious if you are benchmarking UNIX or TCP sockets ?

If UNIX sockets, then that recent patch about increasing socket buffer
size for UNIX sockets rings alarm bells. ie, I wonder if the artificially
low UNIX socket buf size on Linux is preventing you seeing any significant
multi-conn benefits ?

IOW, add that socket buf size patch on top of this series, before
benchmarking again ?

> 
> Richard W.M. Jones (4):
>   nbd: Add multi-conn option
>   nbd: Split out block device state from underlying NBD connections
>   nbd: Open multiple NBD connections if multi-conn is set
>   nbd: Enable multi-conn using round-robin
> 
>  qapi/block-core.json |   8 +-
>  block/coroutines.h   |   5 +-
>  block/nbd.c          | 796 +++++++++++++++++++++++++------------------
>  3 files changed, 479 insertions(+), 330 deletions(-)

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


