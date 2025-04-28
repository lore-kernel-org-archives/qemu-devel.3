Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE815C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 19:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9UAG-0004YG-9K; Mon, 28 Apr 2025 15:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1u9UAD-0004Wv-Ew
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:29:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1u9UAB-0008SA-Oq
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745868548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gll9Rxp5n2BPvksSyTd2/o8pxifoanyEEFX8FSjf7yE=;
 b=TKbBd39NDxv/lpJYllQ8O5k4QB4rU+WhK9mVr4DGGiBQubsVRs6jeYV4dyNvrp13drsiRj
 F0xocAh1xMKFsNfMhtxu3mL2zKyuD3xRYQnRh+V52RMZFQKam4ZDWZ6xm8d5VNQ8dyGBUa
 ssz+uaqOq1pPiuto18gLR4jUvCFKiyY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-9K2gcXYnOgik3y1vLsmcew-1; Mon,
 28 Apr 2025 15:27:58 -0400
X-MC-Unique: 9K2gcXYnOgik3y1vLsmcew-1
X-Mimecast-MFC-AGG-ID: 9K2gcXYnOgik3y1vLsmcew_1745868477
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7E8D180087A; Mon, 28 Apr 2025 19:27:55 +0000 (UTC)
Received: from localhost (unknown [10.42.28.3])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0B8E419560A3; Mon, 28 Apr 2025 19:27:54 +0000 (UTC)
Date: Mon, 28 Apr 2025 20:27:54 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 4/4] nbd: Enable multi-conn using round-robin
Message-ID: <20250428192754.GF1450@redhat.com>
References: <20250428185246.492388-6-eblake@redhat.com>
 <20250428185246.492388-10-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428185246.492388-10-eblake@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
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

On Mon, Apr 28, 2025 at 01:46:47PM -0500, Eric Blake wrote:
[...]

This all looks similar to when I posted it before.  However I noted a
couple of problems ...

> (XXX) The strategy here is very naive.  Firstly if you were going to 
> open them, you'd probably want to open them in parallel.  Secondly it
> would make sense to delay opening until multiple parallel requests are
> seen (perhaps above some threshold), so that simple or shortlived NBD
> operations do not require multiple connections to be made.

> (XXX) This uses a naive round-robin approach which could be improved.
> For example we could look at how many requests are in flight and
> assign operations to the connections with fewest.  Or we could try to
> estimate (based on size of requests outstanding) the load on each
> connection.  But this implementation doesn't do any of that.

Plus there was a third rather more fundamental problem that apparently
I didn't write about.  That is that connections were serialised on a
single thread (called from many coroutines).  This bottleneck meant
that there wasn't very much advantage to multi-conn, compared to what
we get in libnbd / nbdcopy.

Are these fixed / planned to be fixed, especially the third?

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top


