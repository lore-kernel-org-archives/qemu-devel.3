Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3611C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 11:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZ6k-0000lQ-GQ; Tue, 01 Jul 2025 07:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uWZ6i-0000l4-0Z
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:25:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uWZ6f-0005Nh-Iy
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751369094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=npj4wgcwm/3BFwsSbjCSIbkrXPgZD3WEe1ROSOgWtcM=;
 b=MuyMrWI2IGA2Sj7MI/X7U2RssxAXAdMBJje/XeKr/du3BdNWyzX/8e+9k4Lw8QGeMJjspj
 QYr9RkKMD9PcGE/ykKvEwnzjT/O/Jw0PCHzuOPpQgdWV/JuM7d/MJ7/0B15h2gJNtCBixr
 KZQ7SNr/62KzfgsK+is0aaHghhON2Ig=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-jWu1yQo4MjSwSzL7yhqVCw-1; Tue,
 01 Jul 2025 07:24:51 -0400
X-MC-Unique: jWu1yQo4MjSwSzL7yhqVCw-1
X-Mimecast-MFC-AGG-ID: jWu1yQo4MjSwSzL7yhqVCw_1751369090
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6FF1919560A6; Tue,  1 Jul 2025 11:24:48 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.118])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17571195608F; Tue,  1 Jul 2025 11:24:41 +0000 (UTC)
Date: Tue, 1 Jul 2025 13:24:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com, berto@igalia.com, fam@euphon.net, ari@tuxera.com
Subject: Re: [PATCH v4 23/48] block: never use atomics to access
 bs->quiesce_counter
Message-ID: <aGPFd5KJyJfZCDjx@redhat.com>
References: <20250530151125.955508-1-f.ebner@proxmox.com>
 <20250530151125.955508-24-f.ebner@proxmox.com>
 <cf7767a8-9494-44c6-b175-de3d152ef9af@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf7767a8-9494-44c6-b175-de3d152ef9af@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 02.06.2025 um 16:45 hat Fiona Ebner geschrieben:
> Am 30.05.25 um 17:11 schrieb Fiona Ebner:
> > All accesses of bs->quiesce_counter are in the main thread, either
> > after a GLOBAL_STATE_CODE() macro or in a function with GRAPH_WRLOCK
> > annotation.
> 
> Now I wonder if that is actually good enough? Because vCPUs threads can
> also satisfy the qemu_in_main_thread() condition.

It is. vcpu threads can only act as the main thread while holding the
BQL, so in this case you already have the necessary synchronisation
without atomics. Basically all the otherwise non-thread-safe code
running in the main loop depends on this.

Kevin


