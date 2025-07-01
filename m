Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82ABC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWebL-0007cq-3s; Tue, 01 Jul 2025 13:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uWebG-000778-TF
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:16:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uWebA-0007GU-GB
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751390205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZAeVpmcYgM0Ip8hYt5ch/mi/SNEpI48cRrp1tOmMJ14=;
 b=DEJs2Aw6vTOjfTtAlTUfYC3fpnO803WiIYMTbOx48oNKemwzfeP2qD7J808ydV4k7YzFTx
 Mi+ttU856IFslCOVent2YYlm3tU6acKmlRWTEK4n4SooSb39M07QpsY0iJmUsnaf/RCe9q
 Hg09cbXfkO8TbRKVfux09s50Jvtuniw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-nm6EoA53Nf-auvEZgTsdLQ-1; Tue,
 01 Jul 2025 13:16:39 -0400
X-MC-Unique: nm6EoA53Nf-auvEZgTsdLQ-1
X-Mimecast-MFC-AGG-ID: nm6EoA53Nf-auvEZgTsdLQ_1751390196
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2F6B1955F38; Tue,  1 Jul 2025 17:16:34 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.118])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7241E180045B; Tue,  1 Jul 2025 17:16:29 +0000 (UTC)
Date: Tue, 1 Jul 2025 19:16:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com, berto@igalia.com, fam@euphon.net, ari@tuxera.com
Subject: Re: [PATCH v4 00/48] block: do not drain while holding the graph lock
Message-ID: <aGQX6sjaLq9-UjHc@redhat.com>
References: <20250530151125.955508-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530151125.955508-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Am 30.05.2025 um 17:10 hat Fiona Ebner geschrieben:
> This series is an attempt to fix a deadlock issue reported by Andrey
> here [3].
> 
> bdrv_drained_begin() polls and is not allowed to be called with the
> block graph lock held. Mark the function as GRAPH_UNLOCKED.
> 
> This alone does not catch the issue reported by Andrey, because there
> is a bdrv_graph_rdunlock_main_loop() before bdrv_drained_begin() in
> the function bdrv_change_aio_context(). That unlock is of course
> ineffective if the exclusive lock is held, but it prevents TSA from
> finding the issue.
> 
> Thus the bdrv_drained_begin() call from inside
> bdrv_change_aio_context() needs to be moved up the call stack before
> acquiring the locks. This is the bulk of the series.
> 
> Granular draining is not trivially possible, because many of the
> affected functions can recursively call themselves.
> 
> In place where bdrv_drained_begin() calls were removed, assertions
> are added, checking the quiesced_counter to ensure that the nodes
> already got drained further up in the call stack.

I finished review for this series. I had some minor comments on patches
24, 27 and 41. Once we agree what to do there, I can probably just make
any changes myself while applying.

Kevin


