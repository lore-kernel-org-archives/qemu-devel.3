Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB76C3ABDD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 17:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFFsE-0004ZB-EO; Wed, 14 May 2025 13:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uFFs9-0004U5-5L
 for qemu-devel@nongnu.org; Wed, 14 May 2025 13:26:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uFFs7-0002OW-7y
 for qemu-devel@nongnu.org; Wed, 14 May 2025 13:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747243582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ECD1mxEs+Q263+x+gWUdQgB8j7Kjuihsw2F2EZhWoxo=;
 b=XvZ9ZhqPNszE9j0JSuCHOu/74bQg2bCURY1KkuRZS7FF4v0bbhaeUziUQiyjSvYcTnthqT
 mhDmtv3NL2GOXde4rANoEJi2o1x8Y7Q51AOjzo3M3mvxKZ9lpvxfn/w7jcrXLzKDQcGXPr
 hGNtk5+4lkLE90LoHIWz7Y8nk3PkkZk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-Sw5hIGuzOxWf5R0gv4zjSQ-1; Wed,
 14 May 2025 13:26:18 -0400
X-MC-Unique: Sw5hIGuzOxWf5R0gv4zjSQ-1
X-Mimecast-MFC-AGG-ID: Sw5hIGuzOxWf5R0gv4zjSQ_1747243577
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 961ED19560AE; Wed, 14 May 2025 17:26:16 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.207])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C13AC1800359; Wed, 14 May 2025 17:26:12 +0000 (UTC)
Date: Wed, 14 May 2025 19:26:09 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru
Subject: Re: [PATCH 06/11] blockdev: drain while unlocked in
 internal_snapshot_action()
Message-ID: <aCTSMfOt1tyJVwt1@redhat.com>
References: <20250508140936.3344485-1-f.ebner@proxmox.com>
 <20250508140936.3344485-7-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508140936.3344485-7-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

Am 08.05.2025 um 16:09 hat Fiona Ebner geschrieben:
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
> 
> Could the bs associated to the device change because of polling
> when draining? If yes, does that mean we need to drain all in the
> beginning and not temporarily unlock?

I'm starting to hate this pattern. :-)

Maybe it would eventually be a good idea to have some helpers to deal
with this common problem of "I want to drain all nodes that will be
affected by the operation, but draining could change which nodes are
part of it".

For this specific case, though, I think drain all is right simply
because we may already rely on it: I suppose qmp_transaction() calls
bdrv_drain_all() for a reason, but it should actually be a drain
section. I'm pretty sure we're not just waiting for some requests to
complete, but want to keep other users away. Maybe the graph lock
actually covers whatever this drain was initially supposed to solve, but
bdrv_drain_all() doesn't look right.

So how about making it bdrv_drain_all_begin/end() in qmp_transaction()
just because that's the safe thing to do, and then we can just drop any
individual drains in action implementations?

Kevin


