Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CF9C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 16:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeGk-0002kZ-KC; Tue, 01 Jul 2025 12:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uWeGh-0002jc-Ex
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 12:55:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uWeGf-0006gS-Pg
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 12:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751388936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S0bCvBi65WEqcgALlJ7VkAULvyPeY8CiHXgCjbhv2Fk=;
 b=ggP0f6J5iZTER23GGxG+UGmf5QE+XcuafgnkGH6E3L7zzF/T6yOhHy4Eo7OMlf3+zpi2+y
 /gTluQIEa+42O9gPa47NL0uRQ38adsBPWrhVveWlL2s0+MXRwpKEVH0KLW8UrUchPGxESh
 n41bPIuPUMAYeYItAM8qWwTu9Bn9FhM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589--zf0S_FWMCKiVSkkkPryTw-1; Tue,
 01 Jul 2025 12:55:32 -0400
X-MC-Unique: -zf0S_FWMCKiVSkkkPryTw-1
X-Mimecast-MFC-AGG-ID: -zf0S_FWMCKiVSkkkPryTw_1751388930
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37BC418089B6; Tue,  1 Jul 2025 16:55:29 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.118])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA18530001B1; Tue,  1 Jul 2025 16:55:22 +0000 (UTC)
Date: Tue, 1 Jul 2025 18:55:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com, berto@igalia.com, fam@euphon.net, ari@tuxera.com
Subject: Re: [PATCH v4 41/48] block: mark bdrv_new() as GRAPH_UNLOCKED
Message-ID: <aGQS994ID5XHHIp8@redhat.com>
References: <20250530151125.955508-1-f.ebner@proxmox.com>
 <20250530151125.955508-42-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530151125.955508-42-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 30.05.2025 um 17:11 hat Fiona Ebner geschrieben:
> The function bdrv_new() calls bdrv_drained_begin(), which must be
> called with the graph unlocked.
> 
> Marking bdrv_new() as GRAPH_UNLOCKED requires making the locked
> section in bdrv_open_inherit() shorter.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
> 
> I'm not sure if the TODO comment is only intended for the
> lower half of the function, i.e. is moving it like this okay?

The thing that should require locking is when you attach the new node to
something, which is after the place where you moved it to. Currently,
these functions take the lock internally, and I'm not sure if that can
possibly be changed because opening an image usually involves a mix of
I/O to read image metadata (which is incompatible with having a writer
lock) and graph changing operations. It's not clear if this TODO can
ever be resolved...

But I'm not sure if bdrv_new() really should be GRAPH_UNLOCKED. We know
that we don't have any active I/O for a node that we only just created
and that isn't even linked in the global list yet. So maybe the other
option is using bdrv_do_drained_begin_quiesce(bs, NULL) in bdrv_new()
instead? Then callers can hold the lock if they want to.

Kevin


