Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486A6606A324
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RPqFHLaC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRB3p-00031K-LC; Wed, 11 Nov 2026 11:20:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xRB3j-0002z9-Os
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 11:20:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xRB3h-0002AY-R3
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 11:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794414024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EAUJusRuCXumGYReCY/WQ7XDC+XVnqwfC1SRWSLCEO8=;
 b=RPqFHLaCi2pVYyMpwsxrVyllP6MCrKamNPkXwpiP+cV/DZ/uVM9YcYVzEsdTjoXdq7/GkG
 8kcCsxF+5w43kXQ42DnK37MX2oNHreMDNDH/sLLf3SBrHZSXXQhrPxXFaZmIsL82Cwe4I+
 dEtN3+rIQzUgDXJmwLZIhLCwgxap54A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-dtSaRQPgOT2b7-FuAYr-PQ-1; Wed,
 11 Nov 2026 11:20:18 -0500
X-MC-Unique: dtSaRQPgOT2b7-FuAYr-PQ-1
X-Mimecast-MFC-AGG-ID: dtSaRQPgOT2b7-FuAYr-PQ_1794414017
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 786161955D42; Wed, 11 Nov 2026 16:20:17 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E17AE1955DB9; Wed, 11 Nov 2026 16:20:15 +0000 (UTC)
Date: Wed, 11 Nov 2026 10:20:13 -0600
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 1/5] migration/postcopy: report COMPLETED only after
 the run BH has run
Message-ID: <avSVqo1zrRD-Ko13@redhat.com>
References: <20261110183257.2930908-1-den@openvz.org>
 <20261110183257.2930908-2-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110183257.2930908-2-den@openvz.org>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 07:32:53PM +0100, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> The postcopy listen thread waits for main_thread_load_event before it
> reports COMPLETED. That event is set as soon as qemu_loadvm_state_main()
> returns in the main thread, while the run state is changed later, in
> loadvm_postcopy_handle_run_bh(). The listen thread can therefore report
> COMPLETED while the VM is still in RUN_STATE_INMIGRATE, easily so in a
> bitmap-only postcopy where it has little to load.
> 
> Management reacting to COMPLETED then finds the VM still incoming: a
> blockdev-add creates an inactive node, since bds_tree_init() forces
> BDRV_O_INACTIVE in RUN_STATE_INMIGRATE, and attaching a device to it
> fails with "Block node is read-only". Precopy gets this right:
> process_incoming_migration_bh() changes the run state before it reports
> COMPLETED.
> 
> Once CMD_POSTCOPY_RUN has scheduled the run BH, set the event at the
> end of the BH instead. qemu_loadvm_state() keeps setting it in every
> other case, including a load that failed before CMD_POSTCOPY_RUN. The
> postcopy state it checks only becomes RUNNING on the main thread, right
> before the BH is scheduled.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Juraj Marcin <jmarcin@redhat.com>
> ---
>  migration/migration.h | 2 +-
>  migration/savevm.c    | 6 +++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


