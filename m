Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62D5C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 14:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMT2T-0006km-H2; Tue, 03 Jun 2025 10:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMT2Q-0006k2-Tl
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:54:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMT2F-0003pE-Nc
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748962475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HRKmeyadlhKw1+KZqlhHVmNe6N5J7qrXabvm3ZHW9eM=;
 b=I1Cq2O09APrygy/OQ5wXIbepGUuhFI/Bq5iRTcbz1Ky2wKN8FQI5WDX1DGf4rbuWa2s2TQ
 m6NIKCCaBx2toaaU6eYTu+6mqP/s0CDcLQgV7ISdxC1XXup0lwxYmgkExHAHqyiVkPzOSh
 8L2jNG02nnUtH/3Qk4ymL/pQZFFQD/c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-OnM_9IkfPBusKAswggI7Ig-1; Tue,
 03 Jun 2025 10:54:32 -0400
X-MC-Unique: OnM_9IkfPBusKAswggI7Ig-1
X-Mimecast-MFC-AGG-ID: OnM_9IkfPBusKAswggI7Ig_1748962470
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 686711800258; Tue,  3 Jun 2025 14:54:29 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.62])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67492180009F; Tue,  3 Jun 2025 14:54:22 +0000 (UTC)
Date: Tue, 3 Jun 2025 16:54:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com, berto@igalia.com, fam@euphon.net, ari@tuxera.com
Subject: Re: [PATCH v4 00/48] block: do not drain while holding the graph lock
Message-ID: <aD8MnC9IEfz62O0m@redhat.com>
References: <20250530151125.955508-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530151125.955508-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
> Previous discussions:
> v3: [0]
> v2: [1]
> v1: [2]
> 
> Changes in v4:
> * Document requirement to drain all block nodes for affected
>   functions.
> * Also cover the generated bdrv_co_unref_child().
> * Remove now superfluous drain_bs variable in bdrv_set_backing_hd().
> * Mark bdrv_graph_wrlock_drained() wrapper as GRAPH_UNLOCKED.
> * Unify bdrv_set_backing_hd() with its drained_variant.
> * Mark more functions up the call-stack as GRAPH_UNLOCKED. This is
>   almost all of the new patches in the latter half of the series, most
>   do not require substantial changes, but there are a few where
>   something needed to be done. I did not mark functions outside the
>   block layer like qemu_cleanup(), save_snapshot(), qmp_xyz(), etc.
>   and also not functions that explicitly do a rdunlock_main_loop()
>   before calling a function that is GRAPH_UNLOCKED.
> 
> There were no changes for patches 01/48-09/48 and 17/48-23/48, endpoints
> inclusive. All patches starting from 25/48 are new in v4.

This is starting to become a little unmanageable. :-)

I'm sure we could keep adding more and more cleanup patches with each
version of the series, but we don't really have to let the first fixes
wait for all cleanups and fix the whole world in a single series.

So I decided to start with a prefix of this series and applied
patches 1-22, which all had received review before and were easy to
compare against the previous version. If you don't object, I'd send a
pull request for those without waiting for the rest.

If the other patches still need some changes, you can start a new patch
series at v1 containing the remaining patches. (No need to resend them
now, though, I can review them in this series.)

Does this make sense to you?

Kevin


