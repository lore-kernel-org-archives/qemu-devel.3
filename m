Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C918BC369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 18:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u810K-0005FJ-Fv; Thu, 24 Apr 2025 14:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u810H-0005B5-OP
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 14:08:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u810E-0004Ri-HO
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 14:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745518128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=paT5S8UD1OBkn3kxBHkk2HQ6lRr9G8I86jTkuWfZ2SA=;
 b=VLMh9XnH3iRvsaclnfmnNrNCoflsPwAGl7F+N41UDmrabe8SFoFenb2gcSeGq/fn/yOeg3
 ewn62QzNP2LPlAVMpz0VqybXtBghKILZJpvT4ITxpmz99vCEnGbE+oQ6IpHXAnsFPyro1N
 WMFzX0f+XrHwe7RFUpg4iFZytbcwwLY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-1SL-qsotO2WryBUipnQiBA-1; Thu,
 24 Apr 2025 14:08:45 -0400
X-MC-Unique: 1SL-qsotO2WryBUipnQiBA-1
X-Mimecast-MFC-AGG-ID: 1SL-qsotO2WryBUipnQiBA_1745518124
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0191119560B0; Thu, 24 Apr 2025 18:08:42 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C61F1800378; Thu, 24 Apr 2025 18:08:37 +0000 (UTC)
Date: Thu, 24 Apr 2025 13:08:34 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fam Zheng <fam@euphon.net>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Lieven <pl@dlhnet.de>, 
 "Denis V. Lunev" <den@openvz.org>, Alberto Garcia <berto@igalia.com>, 
 Ilya Dryomov <idryomov@gmail.com>, Stefan Weil <sw@weilnetz.de>, 
 "open list:GLUSTER" <integration@gluster.org>
Subject: Re: [PATCH v2.5 01/11] block: Expand block status mode from bool to
 flags
Message-ID: <abnvlaphunplpfo25dk7cqpxzkay72gvonunm4tiuddsynxiou@zhmmjny2nzht>
References: <20250417184133.105746-13-eblake@redhat.com>
 <20250418215412.404558-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418215412.404558-3-eblake@redhat.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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

On Fri, Apr 18, 2025 at 04:52:46PM -0500, Eric Blake wrote:
> This patch is purely mechanical, changing bool want_zero into an
> unsigned int for bitwise-or of flags.  As of this patch, all
> implementations are unchanged (the old want_zero==true is now
> mode==BDRV_WANT_PRECISE which is a superset of BDRV_WANT_ZERO); but
> the callers in io.c that used to pass want_zero==false are now
> prepared for future driver changes that can now distinguish bewteen
> BDRV_WANT_ZERO vs. BDRV_WANT_ALLOCATED.  The next patch will actually
> change the file-posix driver along those lines, now that we have
> more-specific hints.
> 
> As for the background why this patch is useful: right now, the
> file-posix driver recognizes that if allocation is being queried, the
> entire image can be reported as allocated (there is no backing file to
> refer to) - but this throws away information on whether the entire
> image reads as zero (trivially true if lseek(SEEK_HOLE) at offset 0
> returns -ENXIO, a bit more complicated to prove if the raw file was
> created with 'qemu-img create' since we intentionally allocate a small
> chunk of all-zero data to help with alignment probing).  Later patches
> will add a generic algorithm for seeing if an entire file reads as
> zeroes.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> In response to Stefan's ask for what it would look like as a bitmask
> of flags instead of an enum.  Only the first two patches of the series
> change.

> +++ b/block/io.c
> @@ -2364,10 +2364,8 @@ int bdrv_flush_all(void)
>   * Drivers not implementing the functionality are assumed to not support
>   * backing files, hence all their sectors are reported as allocated.
>   *
> - * If 'want_zero' is true, the caller is querying for mapping
> - * purposes, with a focus on valid BDRV_BLOCK_OFFSET_VALID, _DATA, and
> - * _ZERO where possible; otherwise, the result favors larger 'pnum',
> - * with a focus on accurate BDRV_BLOCK_ALLOCATED.
> + * 'mode' serves as a hint as to which results are favored; see enum
> + * BlockStatusMode for details of the supported modes.

Stale comment applicable to v2 but not v2.5; will fix for v3.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


