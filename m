Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CBCC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzd4D-0003VJ-L8; Tue, 01 Apr 2025 10:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tzd4B-0003UT-EO
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:58:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tzd49-0002D4-QW
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743519492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3aRXAmlXu4lZAao6GRB4cP8pg2LMaYeg7G/UcmpTO3w=;
 b=HDV+X/N9SRIPyJB5P2WkLxJEIGZP5kHbBWbGqabSqAkmyOM0Q6ZQ6h7lKIzaD0njcYPILg
 BFQeun96JzjHLZK7Kjnlhj2hmoLYzA2qcADYxB+jmVraLS9pTscIUeFJWAxKQfBC+Jm9XA
 h0zWd4r3cWwNlUtMSYtmmSMnTnYIqIY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-6SPPtnf8MBus3rDUg9Ponw-1; Tue,
 01 Apr 2025 10:58:11 -0400
X-MC-Unique: 6SPPtnf8MBus3rDUg9Ponw-1
X-Mimecast-MFC-AGG-ID: 6SPPtnf8MBus3rDUg9Ponw_1743519490
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6865A1800259; Tue,  1 Apr 2025 14:58:10 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.88])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D114E180094A; Tue,  1 Apr 2025 14:58:07 +0000 (UTC)
Date: Tue, 1 Apr 2025 09:58:05 -0500
From: Eric Blake <eblake@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 14/15] fuse: Implement multi-threading
Message-ID: <hyoxwmiw77g7cb2eckuypqyltpn4xj6ysttg5mhzzyj6x4yfam@6uqm75alnm66>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-13-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325160655.119407-13-hreitz@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Mar 25, 2025 at 05:06:54PM +0100, Hanna Czenczek wrote:
> FUSE allows creating multiple request queues by "cloning" /dev/fuse FDs
> (via open("/dev/fuse") + ioctl(FUSE_DEV_IOC_CLONE)).
> 
> We can use this to implement multi-threading.
> 
> Note that the interface presented here differs from the multi-queue
> interface of virtio-blk: The latter maps virtqueues to iothreads, which
> allows processing multiple virtqueues in a single iothread.  The
> equivalent (processing multiple FDs in a single iothread) would not make
> sense for FUSE because those FDs are used in a round-robin fashion by
> the FUSE kernel driver.  Putting two of them into a single iothread will
> just create a bottleneck.
> 
> Therefore, all we need is an array of iothreads, and we will create one
> "queue" (FD) per thread.
> 

> @@ -275,14 +351,24 @@ static int fuse_export_create(BlockExport *blk_exp,
>  
>      g_hash_table_insert(exports, g_strdup(exp->mountpoint), NULL);
>  
> -    exp->fuse_fd = fuse_session_fd(exp->fuse_session);
> -    ret = fcntl(exp->fuse_fd, F_SETFL, O_NONBLOCK);
> +    assert(exp->num_queues >= 1);
> +    exp->queues[0].fuse_fd = fuse_session_fd(exp->fuse_session);
> +    ret = fcntl(exp->queues[0].fuse_fd, F_SETFL, O_NONBLOCK);

As mentioned before, F_SETFL should be set by read-modify-write.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


