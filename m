Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576BECCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 09:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAmc0-0001d4-Vp; Mon, 20 Oct 2025 05:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vAmbz-0001cw-Cp
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:55:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vAmbx-0002ks-93
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760954125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZurhzRc+Ec9Dh/UVaIlZxVQiEXRt2/bVhx6dsUNI2uQ=;
 b=KmpCya8QiF1w7kxwNLyNg+xu4Uxlv4/Rv/mNHJg+o4CimNc41HM9ST7rmp/y5ijMNsnyWH
 ct+WtpRinF621G5K6h6HdtALzp9Gps5Im0L7ZK+GXhuBKarCfh+7zIETe4Doo87f940fZv
 cQjMEL01ZSDmYEhefWC0FdkBeqTHGqE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-cU0yIoijN5OjpDyGUq-TiQ-1; Mon,
 20 Oct 2025 05:55:21 -0400
X-MC-Unique: cU0yIoijN5OjpDyGUq-TiQ-1
X-Mimecast-MFC-AGG-ID: cU0yIoijN5OjpDyGUq-TiQ_1760954120
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CEC0195609F; Mon, 20 Oct 2025 09:55:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69E5C19560A2; Mon, 20 Oct 2025 09:55:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DBC7F21E6A27; Mon, 20 Oct 2025 11:55:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  Raphael Norwitz <raphael@enfabrica.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Stefano Garzarella
 <sgarzare@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Eric Blake <eblake@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 0/2] vhost-user-blk: support inflight migration
In-Reply-To: <20251020054413.2614932-1-dtalexundeer@yandex-team.ru> (Alexandr
 Moshkov's message of "Mon, 20 Oct 2025 10:44:12 +0500")
References: <20251020054413.2614932-1-dtalexundeer@yandex-team.ru>
Date: Mon, 20 Oct 2025 11:55:15 +0200
Message-ID: <87a51l99to.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Alexandr Moshkov <dtalexundeer@yandex-team.ru> writes:

> Hi!
>
> During inter-host migration, waiting for disk requests to be drained
> in the vhost-user backend can incur significant downtime.
>
> This can be avoided if QEMU migrates the inflight region in vhost-user-blk. 
> Thus, during the qemu migration, the vhost-user backend can cancel all inflight requests and
> then, after migration, they will be executed on another host. 
>
> At first, I tried to implement migration for all vhost-user devices that support inflight at once, 
> but this would require a lot of changes both in vhost-user-blk (to transfer it to the base class) and 
> in the vhost-user-base base class (inflight implementation and remodeling + a large refactor).
>
> Therefore, for now I decided to leave this idea for later and 
> implement the migration of the inflight region first for vhost-user-blk.

How is this work related to Vladimir's "vhost-user-blk: live-backend
local migration"?


