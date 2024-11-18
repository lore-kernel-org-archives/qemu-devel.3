Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968CAD591AD
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 19:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD7ZX-0004NF-AR; Mon, 18 Nov 2024 14:38:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tD7ZK-0003w6-OA
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 14:37:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tD7ZJ-0002vb-4W
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 14:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731958672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p8wohcCVYBXR0ry+UydV2Dq1uQJ4yc3/KyuxZsXkGVk=;
 b=bHafoJ5zVzII7KVUPls2WZ76qAhyW+Z3SsEzYQU/WvSwju03Cr0COFXFSCRHNi1/8OZW5P
 cVjjsl3401v5vfNCL0/BBLLJBWQqbm8bJ7MLK4F9AUIYc9GQJpH1k20bjndNqIjvq8MPrb
 r0t2knbH/YWEYihL28ioVe0+KXhMs/A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-cEuebC-kNAeKIgjaI75S4w-1; Mon,
 18 Nov 2024 14:37:49 -0500
X-MC-Unique: cEuebC-kNAeKIgjaI75S4w-1
X-Mimecast-MFC-AGG-ID: cEuebC-kNAeKIgjaI75S4w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF5791944A82; Mon, 18 Nov 2024 19:37:47 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.76])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C215D1956056; Mon, 18 Nov 2024 19:37:45 +0000 (UTC)
Date: Mon, 18 Nov 2024 13:37:42 -0600
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH] nbd-server: Silence server warnings on port probes
Message-ID: <cs4sgl6yvau2mtvivm7loa5xe6zekdhsi7ozsobqo3dtrzvr74@bjwxs3j5wsix>
References: <20241115195638.1132007-2-eblake@redhat.com>
 <j7bbrsft54ay6dckd4x7q3nokwrukyy2uspnjafjnd2rj34zey@xrzfihu5qbux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j7bbrsft54ay6dckd4x7q3nokwrukyy2uspnjafjnd2rj34zey@xrzfihu5qbux>
User-Agent: NeoMutt/20241002
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Mon, Nov 18, 2024 at 11:08:51AM -0600, Eric Blake wrote:
> On Fri, Nov 15, 2024 at 01:55:53PM -0600, Eric Blake wrote:
> > While testing the use of qemu-nbd in a Pod of a Kubernetes cluster, I
> > got LOTS of log messages of the forms:
> > 
> > qemu-nbd: option negotiation failed: Failed to read flags: Unexpected end-of-file before all data were read
> > qemu-nbd: option negotiation failed: Failed to read flags: Unable to read from socket: Connection reset by peer
> > 

> In testing this as a potential candidate for -rc1, I'm seeing iotests
> failures in `./check 094 119 -nbd` both pre- and post-patch.
> Bisecting now to see if I can find where those tests started
> regressing (looks like a timing change; a "return" line is swapping
> place with a SHUTDOWN event line in the QMP output).

Huh - I'm seeing those same two tests fail on a vanilla v0.9.0
checkout; therefore, this is probably a long-standing regression, and
certainly not something introduced by this patch.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


