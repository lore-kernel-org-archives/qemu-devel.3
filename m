Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB20C54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHmR3-0007S7-Ck; Wed, 21 May 2025 12:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uHmR0-0007Rm-K5
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:36:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uHmQw-0005JE-Uq
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747845404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BDl7OxefI301J3FORWuaXnqvPGn8oWzWXjJGQ1pUoQI=;
 b=gWNhkEDiiWJA+eQ8iiEkt3ZQlkF4IckTIVkaBLwnne/bsqs9GdDdE/Li+37yfoscrFWFUO
 dqPDNmgFeWKhyh+tJ2SVJmZ+aY+BHuwRNVpBENOtvA9BMXQN7FG6Xb3RJVGYtveVTKcexs
 IzmkWPduh+a6kcstOSXiKz6y/8KCD5I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-mbbCFB7lNXWr6071b7SnLg-1; Wed,
 21 May 2025 12:36:40 -0400
X-MC-Unique: mbbCFB7lNXWr6071b7SnLg-1
X-Mimecast-MFC-AGG-ID: mbbCFB7lNXWr6071b7SnLg_1747845396
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51B8C1955DAB; Wed, 21 May 2025 16:36:35 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.112])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B72D919560AB; Wed, 21 May 2025 16:36:28 +0000 (UTC)
Date: Wed, 21 May 2025 18:36:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com, berto@igalia.com, fam@euphon.net, ari@tuxera.com
Subject: Re: [PATCH v2 09/24] block: move drain outside of
 bdrv_try_change_aio_context()
Message-ID: <aC4BCk_BWM-lMuVs@redhat.com>
References: <20250520103012.424311-1-f.ebner@proxmox.com>
 <20250520103012.424311-10-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520103012.424311-10-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
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

Am 20.05.2025 um 12:29 hat Fiona Ebner geschrieben:
> This is part of resolving the deadlock mentioned in commit "block:
> move draining out of bdrv_change_aio_context() and mark GRAPH_RDLOCK".
> 
> Convert the function to a _locked() version that has to be called with
> the graph lock held and add a convenience wrapper that has to be
> called with the graph unlocked, which drains and takes the lock
> itself. Since bdrv_try_change_aio_context() is global state code, the
> wrapper is too.
> 
> Callers are adapted to use the appropriate variant. In the
> test_set_aio_context() unit test, prior drains can be removed, because
> draining already happens inside the new wrapper.

I'm not sure what's the difference between qmp_x_blockdev_set_iothread()
which is converted to _locked() and e.g. qmp_blockdev_mirror().

The reason I could see in qmp_x_blockdev_set_iothread() is that (as we
discussed in the RFC version of this series) draining can change the
graph and that could in theory invalidate bs. But the same is true for
other functions in blockdev.c.

If it's just that qmp_x_blockdev_set_iothread() was easy to fix and the
others are more complex, that's fine with me, but maybe worth mentioning
in the commit message.

> Note that bdrv_attach_child_common_abort(), bdrv_attach_child_common()
> and bdrv_root_unref_child() hold the graph lock and are not actually
> allowed to drain either. This will be addressed in the following
> commits.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


