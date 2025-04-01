Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A4BC36017
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 20:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tziHI-0002WY-BT; Tue, 01 Apr 2025 16:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tziHG-0002W6-S9
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 16:32:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tziHF-0002j6-18
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 16:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743539522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ABawVvcKK7RU65Yj1tYiDOpvM6y62NkVV4fAMzTyFv8=;
 b=G/EXCen0pAObN79viANpYvRbMOZTPcaDdqmcCW6d31KQllCmub8fO+QAh9Gsin7FRbCtap
 NKIdwv5vjC523vXDu3ZTmb/YKCE5zl6sjVH+lLtUICR9iBEkJu292f5yVjExaQo3x4byEV
 iRtb5YV7I9usosFHwXIGK6ncDW4OPzA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-PyqGZLoXOMu209jTGqTBdw-1; Tue,
 01 Apr 2025 16:32:01 -0400
X-MC-Unique: PyqGZLoXOMu209jTGqTBdw-1
X-Mimecast-MFC-AGG-ID: PyqGZLoXOMu209jTGqTBdw_1743539520
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B3DA1809CA6; Tue,  1 Apr 2025 20:31:59 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.88])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A3E1195609D; Tue,  1 Apr 2025 20:31:55 +0000 (UTC)
Date: Tue, 1 Apr 2025 15:31:53 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Czenczek <hreitz@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 14/15] fuse: Implement multi-threading
Message-ID: <glmm3qwi3pqdwy4hdoirylt2g4tbmmih36zmdd3shnwtfpyhmy@uxsqnezebjhq>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-13-hreitz@redhat.com>
 <87sen0fj1j.fsf@pond.sub.org>
 <23f3bdae-c48f-4b23-9f6f-389625617a35@redhat.com>
 <874izg81dt.fsf@pond.sub.org>
 <4c2b5ab0-23d9-4ad8-9549-0ee2a9551b26@redhat.com>
 <87tt7eu0nt.fsf@pond.sub.org>
 <cfad66d7-1ba1-440e-9a48-4d0c91eb5aa1@redhat.com>
 <Z-vWlL1_P5UmK2Gl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-vWlL1_P5UmK2Gl@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
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

On Tue, Apr 01, 2025 at 02:05:40PM +0200, Kevin Wolf wrote:
> > Maybe we could make setting @iothreads here and the generic
> > BlockExportOptions.iothread at the same time an error.  That would save us
> > the explanation here.
> 
> This raises the question if the better interface wouldn't be to change
> the BlockExportOptions.iothread from 'str' to an alternate between 'str'
> and ['str'], allowing the user to specify multiple iothreads in the
> already existing related option without creating conflicting options.
> 
> In the long run, I would be surprised if FUSE remained the only export
> supporting multiple iothreads. At least the virtio based ones
> (vhost-user-blk and VDUSE) even have precedence in the virtio-blk device
> itself, so while I don't know how much interest there is in actually
> implementing it, in theory we know it makes sense.

And I really want my work on NBD Multi-conn support to merge well with
multiple iothreads.  That is yet another case where even if the I/O is
single-threaded, having parallel connections to the NBD server via
round-robin of requests can improve throughput.  But if you can afford
to assign four iothreads to manage four TCP connections to a single
NBD server, you'll get even better response.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


