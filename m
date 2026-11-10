Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84F3606A32D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J6no62ps
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQoSP-0007QZ-3V; Tue, 10 Nov 2026 11:12:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xQoSF-0007Ay-2D
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 11:12:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xQoSD-0002kf-EK
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 11:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794327132;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=voSQQIyn4ebxY4Cm3DMJ0J3gcpTne/Sj4aJ/dLApr6o=;
 b=J6no62ps9YjwIgHmefUV9LuZHk/4zfCx4KUk8d5yB78B2LyZU5Tlg7hG6/X6NO4tRwmz59
 lawpmZz972PJf/bc2Lw+qAE3WemHw6A1JIzFJI5pyHqe0Mbi4iP/xtkjvTs8LJsAK6emOs
 mOanjPyOCX5DobJntcactmigraPL2cI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690--AIqwc7xMEqX2UeLtWjqjQ-1; Tue,
 10 Nov 2026 11:12:07 -0500
X-MC-Unique: -AIqwc7xMEqX2UeLtWjqjQ-1
X-Mimecast-MFC-AGG-ID: -AIqwc7xMEqX2UeLtWjqjQ_1794327126
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E029E1800495; Tue, 10 Nov 2026 16:12:05 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1A981956086; Tue, 10 Nov 2026 16:12:03 +0000 (UTC)
Date: Tue, 10 Nov 2026 16:12:00 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 stefanha@redhat.com, Feifan Qian <bea1e@proton.me>,
 Haotian Jiang <jianghaotian.sunday@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH v3 3/6] nbd/server: Reject rather than assert on
 non-compliant BLOCK_STATUS
Message-ID: <avNCUMcK2ZklLdG0@redhat.com>
References: <20261110153121.1516536-8-eblake@redhat.com>
 <20261110155356.1520433-7-eblake@redhat.com>
 <20261110155356.1520433-9-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261110155356.1520433-9-eblake@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 09:53:59AM -0600, Eric Blake wrote:
> The NBD spec is clear that a client must not send NBD_BLOCK_STATUS
> requests to a server if it did not negotiate any metacontexts with
> NBD_OPT_SET_META_CONTEXT for the current export.  However, if the
> non-compliant client uses NBD_OPT_EXTENDED_HEADERS and then passes in
> the relatively new NBD_CMD_FLAG_PAYLOAD_LEN flag alongside an
> inappropriate block status request, this was enough to trigger an
> assertion in qemu.  The assertion can also be tripped by initially
> requesting the context for one export, then using NBD_OPT_GO on a
> different export (nbd_check_meta_export() sets contexts.count to 0,
> but did not wipe contexts.exp). Forcing the client command to be
> rejected if contexts.count is 0 solves both triggers, and allows the
> assertion to still operate cleanly at a later location.
> 
> If you do not use recommended practice to prevent unwanted clients
> from connecting to QEMU's NBD server, then any client can cause a
> denial of service with minimal effort.  However, with TLS and x509
> certs in place, an attacker must first chain in an attack to convince
> the client to send unwanted traffic, which is a factor in declaring
> this a lower-risk denial of service.
> 
> Fixes: CVE-2026-124559
> Fixes: 2dcbb11b ("nbd/server: Add FLAG_PAYLOAD support to CMD_BLOCK_STATUS", v8.2.0)
> Reported-by: Feifan Qian <bea1e@proton.me>
> Reported-by: https://gitlab.com/qemu-project/qemu/-/work_items/3796
> CC: Haotian Jiang <jianghaotian.sunday@gmail.com>
> CC: qemu-stable@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v3: Move assert later rather than dropping it; improve commit message.
> R-b dropped.
> ---
>  nbd/server.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


