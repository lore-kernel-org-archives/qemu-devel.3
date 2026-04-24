Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3116FB44A6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 06:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG9li-0003AL-Jj; Fri, 24 Apr 2026 02:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wG9lc-00039w-NQ
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 02:11:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wG9lb-00075D-88
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 02:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777011113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jFbrB9dceQErc9zTYJpCbSwhVssmE1zwm+K86ArDYPQ=;
 b=H1W1Yfov72aoWM2/oc/MM/PJyXEh43KoHfGKp/Chf70pq67Tu0bCPvdDse9eYM4LSFLW2a
 Be9Gb04W2lgdGo+cbIXCwHKtQ1HL+yk5LXIWI/rpW2/3cOpHahfDzSwSyTCmFkeRti/bbw
 3BZtg8cnciMLnib+JYz2P3r2POhSkbI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-aYmYqtIrPQuYSLhiz3Lv6w-1; Fri,
 24 Apr 2026 02:11:50 -0400
X-MC-Unique: aYmYqtIrPQuYSLhiz3Lv6w-1
X-Mimecast-MFC-AGG-ID: aYmYqtIrPQuYSLhiz3Lv6w_1777011108
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A89A418003F6; Fri, 24 Apr 2026 06:11:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.30])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69AF63007572; Fri, 24 Apr 2026 06:11:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 21EA021E6A28; Fri, 24 Apr 2026 08:11:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com,  mst@redhat.com,  peterx@redhat.com,
 farosas@suse.de,  raphael.s.norwitz@gmail.com,  bchaney@akamai.com,
 qemu-devel@nongnu.org,  berrange@redhat.com,  pbonzini@redhat.com,
 yc-core@yandex-team.ru,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v15 6/8] net/tap: support local migration with virtio-net
In-Reply-To: <20260420193846.675844-7-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Mon, 20 Apr 2026 22:38:43 +0300")
References: <20260420193846.675844-1-vsementsov@yandex-team.ru>
 <20260420193846.675844-7-vsementsov@yandex-team.ru>
Date: Fri, 24 Apr 2026 08:11:45 +0200
Message-ID: <87tst0x4ym.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Support transferring of TAP state (including open fd) through
> migration stream as part of viritio-net "local-migration".
>
> Add new option, incoming-fds, which should be set to true to
> trigger new logic.
>
> For new option require explicitly unset script and downscript,
> to keep possibility of implementing support for them in future.
>
> Note disabling read polling on source stop for TAP migration:
> otherwise, source process may steal packages from TAP fd even
> after source vm STOP.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


